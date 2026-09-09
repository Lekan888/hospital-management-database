-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hospital_management
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admissions`
--

DROP TABLE IF EXISTS `admissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admissions`
--

LOCK TABLES `admissions` WRITE;
/*!40000 ALTER TABLE `admissions` DISABLE KEYS */;
INSERT INTO `admissions` VALUES (13,3,1,'2026-08-20','2026-08-25'),(14,4,2,'2026-08-21','2026-08-23'),(15,5,3,'2026-08-22','2026-08-28'),(16,6,4,'2026-08-24','2026-08-27'),(17,7,5,'2026-08-26','2026-08-30'),(18,8,6,'2026-08-27','2026-08-29'),(19,9,7,'2026-08-28','2026-09-01'),(20,10,8,'2026-08-29','2026-09-02'),(21,11,9,'2026-08-30','2026-09-04'),(22,12,10,'2026-08-31','2026-09-03'),(23,1,1,'2026-09-04',NULL),(24,2,2,'2026-09-05',NULL);
/*!40000 ALTER TABLE `admissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (1,1,6,'2026-09-01','Routine checkup','Completed'),(2,2,2,'2026-09-01','Child wellness check','Completed'),(3,3,1,'2026-09-02','Chest pain','Completed'),(4,4,3,'2026-09-02','Emergency consultation','Completed'),(5,5,4,'2026-09-03','Frequent headaches','Completed'),(6,6,5,'2026-09-03','Joint pain','Completed'),(7,7,6,'2026-09-04','General examination','Completed'),(8,8,2,'2026-09-04','Fever','Completed'),(9,9,8,'2026-09-05','Emergency treatment','Completed'),(10,10,7,'2026-09-05','Heart examination','Completed'),(11,11,4,'2026-09-06','Neurological assessment','Scheduled'),(12,12,5,'2026-09-06','Back pain','Scheduled'),(13,1,6,'2026-09-07','Follow-up examination','Scheduled'),(14,3,7,'2026-09-07','Cardiology follow-up','Scheduled'),(15,4,8,'2026-09-08','Emergency follow-up','Scheduled'),(16,5,4,'2026-09-08','Headache follow-up','Scheduled'),(17,6,5,'2026-09-09','Orthopedic review','Scheduled'),(18,7,6,'2026-09-09','Routine examination','Scheduled'),(19,10,1,'2026-09-10','Heart checkup','Scheduled'),(20,11,4,'2026-09-10','Neurology consultation','Scheduled');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(50) DEFAULT NULL,
  `record_id` int DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `log_date` datetime DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(100) NOT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `departmeant_name` (`department_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Cardiology'),(3,'Emergency'),(6,'General Medicine'),(4,'Neurology'),(5,'Orthopedics'),(2,'Pediatrics');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,'Daniel','Adeyemi','daniel.adeyemi@hospital.com',850000.000,1),(2,'Sarah','Okafor','sarah.okafor@hospital.com',780000.000,2),(3,'Michael','Williams','michael.williams@hospital.com',920000.000,3),(4,'David','Ibrahim','david.ibrahim@hospital.com',880000.000,4),(5,'Grace','Johnson','grace.johnson@hospital.com',810000.000,5),(6,'Samuel','Adebayo','samuel.adebayo@hospital.com',750000.000,6),(7,'Jennifer','Eze','jennifer.eze@hospital.com',900000.000,1),(8,'Paul','Musa','paul.musa@hospital.com',800000.000,3);
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_tests`
--

DROP TABLE IF EXISTS `medical_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_tests`
--

LOCK TABLES `medical_tests` WRITE;
/*!40000 ALTER TABLE `medical_tests` DISABLE KEYS */;
/*!40000 ALTER TABLE `medical_tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medications`
--

DROP TABLE IF EXISTS `medications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medications` (
  `medication_id` int NOT NULL AUTO_INCREMENT,
  `medication_name` varchar(50) NOT NULL,
  `price` int DEFAULT NULL,
  `stock_quantity` int DEFAULT NULL,
  PRIMARY KEY (`medication_id`),
  UNIQUE KEY `medication_name` (`medication_name`),
  CONSTRAINT `medications_chk_1` CHECK ((`price` > 0)),
  CONSTRAINT `medications_chk_2` CHECK ((`stock_quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medications`
--

LOCK TABLES `medications` WRITE;
/*!40000 ALTER TABLE `medications` DISABLE KEYS */;
INSERT INTO `medications` VALUES (1,'Paracetamol',1500,100),(2,'Amoxicillin',3500,80),(3,'Ibuprofen',2000,75),(4,'Artemether',4500,60),(5,'Metformin',3000,50),(6,'Amlodipine',2500,65),(7,'Omeprazole',2800,70),(8,'Ciprofloxacin',4000,55),(9,'Loratadine',1800,90),(10,'Azithromycin',5000,45),(11,'Diclofenac',2200,60),(12,'Vitamin C',1200,120);
/*!40000 ALTER TABLE `medications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurses`
--

DROP TABLE IF EXISTS `nurses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurses`
--

LOCK TABLES `nurses` WRITE;
/*!40000 ALTER TABLE `nurses` DISABLE KEYS */;
INSERT INTO `nurses` VALUES (1,'Mary','Adekunle','mary.adekunle@hospital.com',1),(2,'Blessing','Okoro','blessing.okoro@hospital.com',2),(3,'Esther','Bello','esther.bello@hospital.com',3),(4,'Janet','Obi','janet.obi@hospital.com',4),(5,'Ruth','Akinyemi','ruth.akinyemi@hospital.com',5),(6,'Helen','Uche','helen.uche@hospital.com',6),(7,'Joy','Olawale','joy.olawale@hospital.com',1),(8,'Faith','Nwachukwu','faith.nwachukwu@hospital.com',3);
/*!40000 ALTER TABLE `nurses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `patient_appointment_view`
--

DROP TABLE IF EXISTS `patient_appointment_view`;
/*!50001 DROP VIEW IF EXISTS `patient_appointment_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `patient_appointment_view` AS SELECT 
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `doctor_first_name`,
 1 AS `doctor_last_name`,
 1 AS `appointment_date`,
 1 AS `reason`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `patient_medication_view`
--

DROP TABLE IF EXISTS `patient_medication_view`;
/*!50001 DROP VIEW IF EXISTS `patient_medication_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `patient_medication_view` AS SELECT 
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `doctor_first_name`,
 1 AS `doctor_last_name`,
 1 AS `medication_name`,
 1 AS `dosage`,
 1 AS `prescription_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,'Lekan','Toriola','lekan.toriola@email.com','2004-05-12','Male','08030000001',6),(2,'Sophia','Williams','sophia.williams@email.com','2005-08-21','Female','08030000002',2),(3,'Emmanuel','Adeyemi','emmanuel.adeyemi@email.com','1998-03-15','Male','08030000003',1),(4,'Amaka','Okafor','amaka.okafor@email.com','2001-11-09','Female','08030000004',3),(5,'Daniel','Ibrahim','daniel.ibrahim@email.com','1995-07-18','Male','08030000005',4),(6,'Chioma','Eze','chioma.eze@email.com','2003-02-25','Female','08030000006',5),(7,'Tunde','Adebayo','tunde.adebayo@email.com','1992-09-30','Male','08030000007',6),(8,'Mary','Johnson','mary.johnson@email.com','2000-06-14','Female','08030000008',2),(9,'Yusuf','Musa','yusuf.musa@email.com','1997-12-03','Male','08030000009',3),(10,'Grace','Obi','grace.obi@email.com','2002-04-19','Female','08030000010',1),(11,'Peter','Okoro','peter.okoro@email.com','1989-10-27','Male','08030000011',4),(12,'Esther','Bello','esther.bello@email.com','1999-01-11','Female','08030000012',5);
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,15000,'2026-09-01','Card'),(2,2,8000,'2026-09-01','Cash'),(3,3,120000,'2026-09-02','Transfer'),(4,4,45000,'2026-09-02','Card'),(5,5,150000,'2026-09-03','Transfer'),(6,6,70000,'2026-09-03','Card'),(7,7,25000,'2026-09-04','Cash'),(8,8,18000,'2026-09-04','Transfer'),(9,9,50000,'2026-09-05','Card'),(10,10,90000,'2026-09-05','Transfer'),(11,11,95000,'2026-09-06','Card'),(12,12,60000,'2026-09-06','Cash'),(13,1,10000,'2026-09-07','Transfer'),(14,3,35000,'2026-09-07','Card'),(15,5,25000,'2026-09-08','Cash');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescriptions`
--

DROP TABLE IF EXISTS `prescriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescriptions`
--

LOCK TABLES `prescriptions` WRITE;
/*!40000 ALTER TABLE `prescriptions` DISABLE KEYS */;
INSERT INTO `prescriptions` VALUES (1,1,6,1,'500mg twice daily','2026-09-01'),(2,2,2,1,'250mg twice daily','2026-09-01'),(3,3,1,6,'5mg once daily','2026-09-02'),(4,4,3,2,'500mg three times daily','2026-09-02'),(5,5,4,3,'400mg twice daily','2026-09-03'),(6,6,5,11,'50mg twice daily','2026-09-03'),(7,7,6,7,'20mg once daily','2026-09-04'),(8,8,2,4,'80mg once daily','2026-09-04'),(9,9,8,8,'500mg twice daily','2026-09-05'),(10,10,7,6,'10mg once daily','2026-09-05'),(11,11,4,1,'500mg twice daily','2026-09-06'),(12,12,5,3,'400mg twice daily','2026-09-06'),(13,1,6,12,'1000mg once daily','2026-09-07'),(14,3,7,7,'20mg once daily','2026-09-07'),(15,4,8,2,'500mg three times daily','2026-09-08'),(16,5,4,9,'10mg once daily','2026-09-08'),(17,6,5,11,'50mg twice daily','2026-09-09'),(18,7,6,1,'500mg twice daily','2026-09-09'),(19,10,1,6,'5mg once daily','2026-09-10'),(20,11,4,10,'500mg once daily','2026-09-10');
/*!40000 ALTER TABLE `prescriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `room_id` int NOT NULL AUTO_INCREMENT,
  `room_number` varchar(50) NOT NULL,
  `room_type` varchar(50) NOT NULL,
  `status` varchar(50) DEFAULT 'Available',
  PRIMARY KEY (`room_id`),
  UNIQUE KEY `room_number` (`room_number`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,'G101','General','Available'),(2,'G102','General','Available'),(3,'P201','Private','Available'),(4,'P202','Private','Available'),(5,'I301','ICU','Available'),(6,'I302','ICU','Available'),(7,'E401','Emergency','Available'),(8,'E402','Emergency','Available'),(9,'G103','General','Available'),(10,'P203','Private','Available');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `patient_appointment_view`
--

/*!50001 DROP VIEW IF EXISTS `patient_appointment_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `patient_appointment_view` AS select `patients`.`first_name` AS `first_name`,`patients`.`last_name` AS `last_name`,`doctors`.`first_name` AS `doctor_first_name`,`doctors`.`last_name` AS `doctor_last_name`,`appointments`.`appointment_date` AS `appointment_date`,`appointments`.`reason` AS `reason`,`appointments`.`status` AS `status` from ((`patients` join `doctors` on((`patients`.`department_id` = `doctors`.`department_id`))) join `appointments` on((`patients`.`patient_id` = `appointments`.`patient_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `patient_medication_view`
--

/*!50001 DROP VIEW IF EXISTS `patient_medication_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `patient_medication_view` AS select `patients`.`first_name` AS `first_name`,`patients`.`last_name` AS `last_name`,`doctors`.`first_name` AS `doctor_first_name`,`doctors`.`last_name` AS `doctor_last_name`,`medications`.`medication_name` AS `medication_name`,`prescriptions`.`dosage` AS `dosage`,`prescriptions`.`prescription_date` AS `prescription_date` from (((`patients` join `doctors` on((`patients`.`department_id` = `doctors`.`department_id`))) join `prescriptions` on((`patients`.`patient_id` = `prescriptions`.`patient_id`))) join `medications` on((`medications`.`medication_id` = `prescriptions`.`medication_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-09 11:02:45
