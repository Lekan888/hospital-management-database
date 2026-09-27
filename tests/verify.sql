-- Run after hospital_management.sql in the SAME demo database.
-- Fails with SQLSTATE 45000 if a result differs from the expected seed data.
-- Test mutations are rolled back; AUTO_INCREMENT counters may still advance.

DROP PROCEDURE IF EXISTS verify_hospital_portfolio;
DELIMITER $$
CREATE PROCEDURE verify_hospital_portfolio()
BEGIN
    DECLARE rejected BOOLEAN DEFAULT FALSE;
    DECLARE new_id INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF (SELECT COUNT(*) FROM information_schema.tables
        WHERE table_schema = DATABASE() AND table_type = 'BASE TABLE') <> 12
       OR (SELECT COUNT(*) FROM information_schema.views
           WHERE table_schema = DATABASE()) <> 2 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Expected 12 tables and 2 views';
    END IF;

    IF (SELECT COUNT(*) FROM patients) <> 12
       OR (SELECT COUNT(*) FROM doctors) <> 8
       OR (SELECT COUNT(*) FROM appointments) <> 20
       OR (SELECT COUNT(*) FROM prescriptions) <> 20
       OR (SELECT COUNT(*) FROM payments) <> 15 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Unexpected seed row counts';
    END IF;

    IF (SELECT COUNT(*) FROM patient_appointment_view) <> 20
       OR (SELECT COUNT(DISTINCT appointment_id) FROM patient_appointment_view) <> 20
       OR EXISTS (
           SELECT 1 FROM patient_appointment_view AS v
           JOIN appointments AS a ON a.appointments_id = v.appointment_id
           WHERE NOT (v.doctor_id <=> a.doctor_id)
       ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Appointment view duplicates or misassigns events';
    END IF;

    IF (SELECT COUNT(*) FROM patient_medication_view) <> 20
       OR (SELECT COUNT(DISTINCT prescription_id) FROM patient_medication_view) <> 20
       OR EXISTS (
           SELECT 1 FROM patient_medication_view AS v
           JOIN prescriptions AS pr ON pr.prescription_id = v.prescription_id
           WHERE NOT (v.doctor_id <=> pr.doctor_id)
              OR NOT (v.medication_id <=> pr.medication_id)
       ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Medication view duplicates or misassigns events';
    END IF;

    IF (SELECT COUNT(*) FROM appointments WHERE status = 'Completed') <> 10
       OR (SELECT COUNT(*) FROM appointments WHERE status = 'Scheduled') <> 10
       OR (SELECT COUNT(*) FROM appointments WHERE doctor_id = 4) <> 4
       OR (SELECT COUNT(*) FROM appointments WHERE doctor_id = 6) <> 4
       OR (SELECT COUNT(*) FROM admissions WHERE discharge_date IS NULL) <> 2
       OR (SELECT COUNT(*) FROM medications WHERE stock_quantity <= 50) <> 2
       OR (SELECT COUNT(*) FROM (
           SELECT patient_id FROM payments GROUP BY patient_id HAVING COUNT(*) > 1
       ) AS repeat_payers) <> 3 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Example report results do not match';
    END IF;

    IF EXISTS (
        SELECT 1 FROM admissions AS a JOIN rooms AS r ON r.room_id = a.room_id
        WHERE a.discharge_date IS NULL AND r.status <> 'Occupied'
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Seed room status disagrees with active admissions';
    END IF;

    START TRANSACTION;

    -- Patient 01 is in General Medicine; Doctor 01 is in Cardiology.
    INSERT INTO appointments (patient_id, doctor_id, appointment_date, reason)
    VALUES (1, 1, '2026-10-01', 'Cross-department regression check');
    SET new_id = LAST_INSERT_ID();
    IF (SELECT COUNT(*) FROM patient_appointment_view
        WHERE appointment_id = new_id AND doctor_id = 1
          AND doctor_first_name = 'Doctor' AND doctor_last_name = '01') <> 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cross-department appointment lost its assigned doctor';
    END IF;

    INSERT INTO prescriptions (patient_id, doctor_id, medication_id, dosage, prescription_date)
    VALUES (1, 1, 1, 'Demo quantity not modelled', '2026-10-01');
    SET new_id = LAST_INSERT_ID();
    IF (SELECT COUNT(*) FROM patient_medication_view
        WHERE prescription_id = new_id AND doctor_id = 1
          AND doctor_first_name = 'Doctor' AND doctor_last_name = '01'
          AND medication_name = 'Paracetamol') <> 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cross-department prescription lost its assigned doctor';
    END IF;

    INSERT INTO appointments (appointment_date, reason)
    VALUES ('2026-10-02', 'Optional relationships regression check');
    SET new_id = LAST_INSERT_ID();
    IF (SELECT COUNT(*) FROM patient_appointment_view
        WHERE appointment_id = new_id AND patient_id IS NULL AND doctor_id IS NULL) <> 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Appointment with optional relationships disappeared';
    END IF;

    INSERT INTO prescriptions (dosage, prescription_date)
    VALUES ('Optional relationships regression check', '2026-10-02');
    SET new_id = LAST_INSERT_ID();
    IF (SELECT COUNT(*) FROM patient_medication_view
        WHERE prescription_id = new_id AND patient_id IS NULL
          AND doctor_id IS NULL AND medication_id IS NULL) <> 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Prescription with optional relationships disappeared';
    END IF;

    -- A CHECK constraint must reject negative stock.
    SET rejected = FALSE;
    BEGIN
        DECLARE CONTINUE HANDLER FOR 3819 SET rejected = TRUE;
        UPDATE medications SET stock_quantity = -1 WHERE medication_id = 1;
    END;
    IF NOT rejected THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Negative medication stock was accepted';
    END IF;

    -- A foreign key must reject a patient that does not exist.
    SET rejected = FALSE;
    BEGIN
        DECLARE CONTINUE HANDLER FOR 1452 SET rejected = TRUE;
        INSERT INTO payments (patient_id, amount, payment_date, payment_method)
        VALUES (-1, 100, '2026-10-01', 'Demo');
    END;
    IF NOT rejected THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Unknown patient reference was accepted';
    END IF;

    -- A UNIQUE constraint must reject duplicate contact values.
    SET rejected = FALSE;
    BEGIN
        DECLARE CONTINUE HANDLER FOR 1062 SET rejected = TRUE;
        UPDATE patients SET email = 'patient01@example.test' WHERE patient_id = 2;
    END;
    IF NOT rejected THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate patient email was accepted';
    END IF;

    UPDATE medications SET stock_quantity = stock_quantity - 1 WHERE medication_id = 1;
    ROLLBACK;

    IF (SELECT COUNT(*) FROM appointments) <> 20
       OR (SELECT COUNT(*) FROM prescriptions) <> 20
       OR (SELECT stock_quantity FROM medications WHERE medication_id = 1) <> 100 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ROLLBACK did not restore sample data';
    END IF;

    SELECT 'All verification checks passed' AS result;
END$$
DELIMITER ;

CALL verify_hospital_portfolio();
DROP PROCEDURE verify_hospital_portfolio;
