-- Eight example reports. Select the database where you imported the project.
-- These queries read the demo data; they do not update it.

-- 1. Appointment schedule with the doctor assigned to each appointment.
SELECT appointment_id, appointment_date,
       CONCAT(first_name, ' ', last_name) AS patient,
       CONCAT(doctor_first_name, ' ', doctor_last_name) AS doctor,
       reason, status
FROM patient_appointment_view
ORDER BY appointment_date, appointment_id;

-- 2. Doctor workload, including doctors with zero appointments.
SELECT d.doctor_id,
       CONCAT(d.first_name, ' ', d.last_name) AS doctor,
       COUNT(a.appointments_id) AS appointment_count,
       SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed,
       SUM(CASE WHEN a.status = 'Scheduled' THEN 1 ELSE 0 END) AS scheduled
FROM doctors AS d
LEFT JOIN appointments AS a ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name
ORDER BY appointment_count DESC, d.doctor_id;

-- 3. Department coverage. Aggregate each child table before joining to avoid
-- multiplying patients by the number of doctors in the same department.
SELECT dep.department_name,
       COALESCE(p.patient_count, 0) AS patient_count,
       COALESCE(d.doctor_count, 0) AS doctor_count
FROM department AS dep
LEFT JOIN (
    SELECT department_id, COUNT(*) AS patient_count
    FROM patients
    GROUP BY department_id
) AS p ON p.department_id = dep.department_id
LEFT JOIN (
    SELECT department_id, COUNT(*) AS doctor_count
    FROM doctors
    GROUP BY department_id
) AS d ON d.department_id = dep.department_id
ORDER BY dep.department_name;

-- 4. Payments recorded per patient. COALESCE displays zero if none are present.
SELECT p.patient_id,
       CONCAT(p.first_name, ' ', p.last_name) AS patient,
       COUNT(pay.payment_id) AS payment_count,
       COALESCE(SUM(pay.amount), 0) AS total_paid
FROM patients AS p
LEFT JOIN payments AS pay ON pay.patient_id = p.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
ORDER BY total_paid DESC, p.patient_id;

-- 5. Patients with more than one payment: HAVING filters grouped results.
SELECT p.patient_id,
       CONCAT(p.first_name, ' ', p.last_name) AS patient,
       COUNT(pay.payment_id) AS payment_count,
       SUM(pay.amount) AS total_paid
FROM patients AS p
JOIN payments AS pay ON pay.patient_id = p.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
HAVING COUNT(pay.payment_id) > 1
ORDER BY total_paid DESC, p.patient_id;

-- 6. Current admissions. A NULL discharge date means the stay is still open.
SELECT a.admission_id,
       CONCAT(p.first_name, ' ', p.last_name) AS patient,
       r.room_number, r.room_type, a.admission_date
FROM admissions AS a
LEFT JOIN patients AS p ON p.patient_id = a.patient_id
LEFT JOIN rooms AS r ON r.room_id = a.room_id
WHERE a.discharge_date IS NULL
ORDER BY a.admission_date, a.admission_id;

-- 7. Stock review. The threshold is an example, not a clinical recommendation.
SET @reorder_point = 50;
SELECT medication_name, stock_quantity, price
FROM medications
WHERE stock_quantity <= @reorder_point
ORDER BY stock_quantity, medication_id;

-- 8. Patients whose appointment count exceeds the average across ALL patients,
-- including patients with zero appointments.
WITH patient_counts AS (
    SELECT p.patient_id, p.first_name, p.last_name,
           COUNT(a.appointments_id) AS appointment_count
    FROM patients AS p
    LEFT JOIN appointments AS a ON a.patient_id = p.patient_id
    GROUP BY p.patient_id, p.first_name, p.last_name
)
SELECT patient_id, CONCAT(first_name, ' ', last_name) AS patient,
       appointment_count
FROM patient_counts
WHERE appointment_count > (SELECT AVG(appointment_count) FROM patient_counts)
ORDER BY appointment_count DESC, patient_id;
