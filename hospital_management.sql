-- Hospital Management Database | Lekan Toriola
-- MySQL 8.0.16 or later. Select an EMPTY database before running this file.
-- Creates 12 tables, inserts fictional demo records, and creates 2 views.
-- This script does not drop tables or choose a database for you.
-- Every person, date of birth, and contact detail below is generated demo data.

SET NAMES utf8mb4;

-- 1. Schema: parents are created before their dependent tables.

-- department
CREATE TABLE `department` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(100) NOT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `departmeant_name` (`department_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- doctors
CREATE TABLE `doctors` (
  `doctor_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `salary` decimal(10,3) DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`doctor_id`),
  UNIQUE KEY `email` (`email`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`),
  CONSTRAINT `doctors_chk_1` CHECK ((`salary` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- nurses
CREATE TABLE `nurses` (
  `nurse_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`nurse_id`),
  UNIQUE KEY `email` (`email`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `nurses_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- patients
CREATE TABLE `patients` (
  `patient_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `date_of_birth` date NOT NULL,
  `gender` enum('Male','Female') DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`patient_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- rooms
CREATE TABLE `rooms` (
  `room_id` int NOT NULL AUTO_INCREMENT,
  `room_number` varchar(50) NOT NULL,
  `room_type` varchar(50) NOT NULL,
  `status` varchar(50) DEFAULT 'Available',
  PRIMARY KEY (`room_id`),
  UNIQUE KEY `room_number` (`room_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- appointments
CREATE TABLE `appointments` (
  `appointments_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int DEFAULT NULL,
  `doctor_id` int DEFAULT NULL,
  `appointment_date` date NOT NULL,
  `reason` varchar(50) NOT NULL,
  `status` varchar(50) DEFAULT 'Scheduled',
  PRIMARY KEY (`appointments_id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- admissions
CREATE TABLE `admissions` (
  `admission_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int DEFAULT NULL,
  `room_id` int DEFAULT NULL,
  `admission_date` date NOT NULL,
  `discharge_date` date DEFAULT NULL,
  PRIMARY KEY (`admission_id`),
  KEY `patient_id` (`patient_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `admissions_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `admissions_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- medications
CREATE TABLE `medications` (
  `medication_id` int NOT NULL AUTO_INCREMENT,
  `medication_name` varchar(50) NOT NULL,
  `price` int DEFAULT NULL,
  `stock_quantity` int DEFAULT NULL,
  PRIMARY KEY (`medication_id`),
  UNIQUE KEY `medication_name` (`medication_name`),
  CONSTRAINT `medications_chk_1` CHECK ((`price` > 0)),
  CONSTRAINT `medications_chk_2` CHECK ((`stock_quantity` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- prescriptions
CREATE TABLE `prescriptions` (
  `prescription_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int DEFAULT NULL,
  `doctor_id` int DEFAULT NULL,
  `medication_id` int DEFAULT NULL,
  `dosage` varchar(200) NOT NULL,
  `prescription_date` date NOT NULL,
  PRIMARY KEY (`prescription_id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `medication_id` (`medication_id`),
  CONSTRAINT `prescriptions_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `prescriptions_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`),
  CONSTRAINT `prescriptions_ibfk_3` FOREIGN KEY (`medication_id`) REFERENCES `medications` (`medication_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- medical_tests
CREATE TABLE `medical_tests` (
  `test_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int DEFAULT NULL,
  `doctor_id` int DEFAULT NULL,
  `test_name` varchar(100) NOT NULL,
  `test_date` date NOT NULL,
  `result` varchar(255) DEFAULT NULL,
  `cost` int DEFAULT NULL,
  PRIMARY KEY (`test_id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `medical_tests_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `medical_tests_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`),
  CONSTRAINT `medical_tests_chk_1` CHECK ((`cost` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- payments
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `payment_date` date NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `payments_chk_1` CHECK ((`amount` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- audit_log
CREATE TABLE `audit_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(50) DEFAULT NULL,
  `record_id` int DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `log_date` datetime DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 2. Fictional seed data. Fixed dates make example results reproducible.

INSERT INTO `department` (`department_id`, `department_name`) VALUES
  (1, 'Cardiology'),
  (3, 'Emergency'),
  (6, 'General Medicine'),
  (4, 'Neurology'),
  (5, 'Orthopedics'),
  (2, 'Pediatrics');

INSERT INTO `doctors` (`doctor_id`, `first_name`, `last_name`, `email`, `salary`, `department_id`) VALUES
  (1, 'Doctor', '01', 'doctor01@example.test', 850000.0, 1),
  (2, 'Doctor', '02', 'doctor02@example.test', 780000.0, 2),
  (3, 'Doctor', '03', 'doctor03@example.test', 920000.0, 3),
  (4, 'Doctor', '04', 'doctor04@example.test', 880000.0, 4),
  (5, 'Doctor', '05', 'doctor05@example.test', 810000.0, 5),
  (6, 'Doctor', '06', 'doctor06@example.test', 750000.0, 6),
  (7, 'Doctor', '07', 'doctor07@example.test', 900000.0, 1),
  (8, 'Doctor', '08', 'doctor08@example.test', 800000.0, 3);

INSERT INTO `nurses` (`nurse_id`, `first_name`, `last_name`, `email`, `department_id`) VALUES
  (1, 'Nurse', '01', 'nurse01@example.test', 1),
  (2, 'Nurse', '02', 'nurse02@example.test', 2),
  (3, 'Nurse', '03', 'nurse03@example.test', 3),
  (4, 'Nurse', '04', 'nurse04@example.test', 4),
  (5, 'Nurse', '05', 'nurse05@example.test', 5),
  (6, 'Nurse', '06', 'nurse06@example.test', 6),
  (7, 'Nurse', '07', 'nurse07@example.test', 1),
  (8, 'Nurse', '08', 'nurse08@example.test', 3);

INSERT INTO `patients` (`patient_id`, `first_name`, `last_name`, `email`, `date_of_birth`, `gender`, `phone`, `department_id`) VALUES
  (1, 'Patient', '01', 'patient01@example.test', '1986-02-06', 'Male', 'DEMO-PATIENT-01', 6),
  (2, 'Patient', '02', 'patient02@example.test', '1987-03-14', 'Female', 'DEMO-PATIENT-02', 2),
  (3, 'Patient', '03', 'patient03@example.test', '1988-04-18', 'Male', 'DEMO-PATIENT-03', 1),
  (4, 'Patient', '04', 'patient04@example.test', '1989-05-24', 'Female', 'DEMO-PATIENT-04', 3),
  (5, 'Patient', '05', 'patient05@example.test', '1990-06-29', 'Male', 'DEMO-PATIENT-05', 4),
  (6, 'Patient', '06', 'patient06@example.test', '1991-08-04', 'Female', 'DEMO-PATIENT-06', 5),
  (7, 'Patient', '07', 'patient07@example.test', '1992-09-08', 'Male', 'DEMO-PATIENT-07', 6),
  (8, 'Patient', '08', 'patient08@example.test', '1993-10-14', 'Female', 'DEMO-PATIENT-08', 2),
  (9, 'Patient', '09', 'patient09@example.test', '1994-11-19', 'Male', 'DEMO-PATIENT-09', 3),
  (10, 'Patient', '10', 'patient10@example.test', '1995-12-25', 'Female', 'DEMO-PATIENT-10', 1),
  (11, 'Patient', '11', 'patient11@example.test', '1997-01-29', 'Male', 'DEMO-PATIENT-11', 4),
  (12, 'Patient', '12', 'patient12@example.test', '1998-03-06', 'Female', 'DEMO-PATIENT-12', 5);

INSERT INTO `rooms` (`room_id`, `room_number`, `room_type`, `status`) VALUES
  (1, 'G101', 'General', 'Occupied'),
  (2, 'G102', 'General', 'Occupied'),
  (3, 'P201', 'Private', 'Available'),
  (4, 'P202', 'Private', 'Available'),
  (5, 'I301', 'ICU', 'Available'),
  (6, 'I302', 'ICU', 'Available'),
  (7, 'E401', 'Emergency', 'Available'),
  (8, 'E402', 'Emergency', 'Available'),
  (9, 'G103', 'General', 'Available'),
  (10, 'P203', 'Private', 'Available');

INSERT INTO `appointments` (`appointments_id`, `patient_id`, `doctor_id`, `appointment_date`, `reason`, `status`) VALUES
  (1, 1, 6, '2026-09-01', 'Routine checkup', 'Completed'),
  (2, 2, 2, '2026-09-01', 'Child wellness check', 'Completed'),
  (3, 3, 1, '2026-09-02', 'Chest pain', 'Completed'),
  (4, 4, 3, '2026-09-02', 'Emergency consultation', 'Completed'),
  (5, 5, 4, '2026-09-03', 'Frequent headaches', 'Completed'),
  (6, 6, 5, '2026-09-03', 'Joint pain', 'Completed'),
  (7, 7, 6, '2026-09-04', 'General examination', 'Completed'),
  (8, 8, 2, '2026-09-04', 'Fever', 'Completed'),
  (9, 9, 8, '2026-09-05', 'Emergency treatment', 'Completed'),
  (10, 10, 7, '2026-09-05', 'Heart examination', 'Completed'),
  (11, 11, 4, '2026-09-06', 'Neurological assessment', 'Scheduled'),
  (12, 12, 5, '2026-09-06', 'Back pain', 'Scheduled'),
  (13, 1, 6, '2026-09-07', 'Follow-up examination', 'Scheduled'),
  (14, 3, 7, '2026-09-07', 'Cardiology follow-up', 'Scheduled'),
  (15, 4, 8, '2026-09-08', 'Emergency follow-up', 'Scheduled'),
  (16, 5, 4, '2026-09-08', 'Headache follow-up', 'Scheduled'),
  (17, 6, 5, '2026-09-09', 'Orthopedic review', 'Scheduled'),
  (18, 7, 6, '2026-09-09', 'Routine examination', 'Scheduled'),
  (19, 10, 1, '2026-09-10', 'Heart checkup', 'Scheduled'),
  (20, 11, 4, '2026-09-10', 'Neurology consultation', 'Scheduled');

INSERT INTO `admissions` (`admission_id`, `patient_id`, `room_id`, `admission_date`, `discharge_date`) VALUES
  (13, 3, 1, '2026-08-20', '2026-08-25'),
  (14, 4, 2, '2026-08-21', '2026-08-23'),
  (15, 5, 3, '2026-08-22', '2026-08-28'),
  (16, 6, 4, '2026-08-24', '2026-08-27'),
  (17, 7, 5, '2026-08-26', '2026-08-30'),
  (18, 8, 6, '2026-08-27', '2026-08-29'),
  (19, 9, 7, '2026-08-28', '2026-09-01'),
  (20, 10, 8, '2026-08-29', '2026-09-02'),
  (21, 11, 9, '2026-08-30', '2026-09-04'),
  (22, 12, 10, '2026-08-31', '2026-09-03'),
  (23, 1, 1, '2026-09-04', NULL),
  (24, 2, 2, '2026-09-05', NULL);

INSERT INTO `medications` (`medication_id`, `medication_name`, `price`, `stock_quantity`) VALUES
  (1, 'Paracetamol', 1500, 100),
  (2, 'Amoxicillin', 3500, 80),
  (3, 'Ibuprofen', 2000, 75),
  (4, 'Artemether', 4500, 60),
  (5, 'Metformin', 3000, 50),
  (6, 'Amlodipine', 2500, 65),
  (7, 'Omeprazole', 2800, 70),
  (8, 'Ciprofloxacin', 4000, 55),
  (9, 'Loratadine', 1800, 90),
  (10, 'Azithromycin', 5000, 45),
  (11, 'Diclofenac', 2200, 60),
  (12, 'Vitamin C', 1200, 120);

INSERT INTO `prescriptions` (`prescription_id`, `patient_id`, `doctor_id`, `medication_id`, `dosage`, `prescription_date`) VALUES
  (1, 1, 6, 1, '500mg twice daily', '2026-09-01'),
  (2, 2, 2, 1, '250mg twice daily', '2026-09-01'),
  (3, 3, 1, 6, '5mg once daily', '2026-09-02'),
  (4, 4, 3, 2, '500mg three times daily', '2026-09-02'),
  (5, 5, 4, 3, '400mg twice daily', '2026-09-03'),
  (6, 6, 5, 11, '50mg twice daily', '2026-09-03'),
  (7, 7, 6, 7, '20mg once daily', '2026-09-04'),
  (8, 8, 2, 4, '80mg once daily', '2026-09-04'),
  (9, 9, 8, 8, '500mg twice daily', '2026-09-05'),
  (10, 10, 7, 6, '10mg once daily', '2026-09-05'),
  (11, 11, 4, 1, '500mg twice daily', '2026-09-06'),
  (12, 12, 5, 3, '400mg twice daily', '2026-09-06'),
  (13, 1, 6, 12, '1000mg once daily', '2026-09-07'),
  (14, 3, 7, 7, '20mg once daily', '2026-09-07'),
  (15, 4, 8, 2, '500mg three times daily', '2026-09-08'),
  (16, 5, 4, 9, '10mg once daily', '2026-09-08'),
  (17, 6, 5, 11, '50mg twice daily', '2026-09-09'),
  (18, 7, 6, 1, '500mg twice daily', '2026-09-09'),
  (19, 10, 1, 6, '5mg once daily', '2026-09-10'),
  (20, 11, 4, 10, '500mg once daily', '2026-09-10');

INSERT INTO `payments` (`payment_id`, `patient_id`, `amount`, `payment_date`, `payment_method`) VALUES
  (1, 1, 15000, '2026-09-01', 'Card'),
  (2, 2, 8000, '2026-09-01', 'Cash'),
  (3, 3, 120000, '2026-09-02', 'Transfer'),
  (4, 4, 45000, '2026-09-02', 'Card'),
  (5, 5, 150000, '2026-09-03', 'Transfer'),
  (6, 6, 70000, '2026-09-03', 'Card'),
  (7, 7, 25000, '2026-09-04', 'Cash'),
  (8, 8, 18000, '2026-09-04', 'Transfer'),
  (9, 9, 50000, '2026-09-05', 'Card'),
  (10, 10, 90000, '2026-09-05', 'Transfer'),
  (11, 11, 95000, '2026-09-06', 'Card'),
  (12, 12, 60000, '2026-09-06', 'Cash'),
  (13, 1, 10000, '2026-09-07', 'Transfer'),
  (14, 3, 35000, '2026-09-07', 'Card'),
  (15, 5, 25000, '2026-09-08', 'Cash');

-- 3. Reporting views. Follow the doctor assigned to each event.
-- LEFT JOIN preserves an event even when an optional foreign key is NULL.

CREATE SQL SECURITY INVOKER VIEW patient_appointment_view AS
SELECT
    a.appointments_id AS appointment_id,
    a.patient_id,
    p.first_name,
    p.last_name,
    a.doctor_id,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    a.appointment_date,
    a.reason,
    a.status
FROM appointments AS a
LEFT JOIN patients AS p ON p.patient_id = a.patient_id
LEFT JOIN doctors AS d ON d.doctor_id = a.doctor_id;

CREATE SQL SECURITY INVOKER VIEW patient_medication_view AS
SELECT
    pr.prescription_id,
    pr.patient_id,
    p.first_name,
    p.last_name,
    pr.doctor_id,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    pr.medication_id,
    m.medication_name,
    pr.dosage,
    pr.prescription_date
FROM prescriptions AS pr
LEFT JOIN patients AS p ON p.patient_id = pr.patient_id
LEFT JOIN doctors AS d ON d.doctor_id = pr.doctor_id
LEFT JOIN medications AS m ON m.medication_id = pr.medication_id;
