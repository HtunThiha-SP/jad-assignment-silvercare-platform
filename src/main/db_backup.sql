CREATE DATABASE  IF NOT EXISTS `jad-silvercare-db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `jad-silvercare-db`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: jad-silvercare-db
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `service_id` int NOT NULL,
  `caregiver_id` int NOT NULL,
  `starts_on` timestamp NOT NULL,
  `ends_on` timestamp NOT NULL,
  `status` enum('completed','pending','approved','rejected') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `service_id` (`service_id`),
  KEY `caregiver_id` (`caregiver_id`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`),
  CONSTRAINT `appointment_ibfk_3` FOREIGN KEY (`caregiver_id`) REFERENCES `caregiver` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (1,3,5,1,'2025-11-10 00:00:00','2025-11-10 02:00:00','completed'),(2,1,12,3,'2025-11-08 06:00:00','2025-11-08 08:00:00','completed'),(3,4,2,4,'2025-11-05 02:00:00','2025-11-05 04:00:00','completed'),(4,6,9,2,'2025-11-15 08:00:00','2025-11-15 10:00:00','completed'),(5,5,14,5,'2025-11-20 10:00:00','2025-11-20 12:00:00','completed'),(6,3,7,1,'2025-11-18 04:00:00','2025-11-18 06:00:00','completed'),(7,1,3,2,'2025-11-12 00:00:00','2025-11-12 02:00:00','completed'),(8,6,11,5,'2025-11-09 12:00:00','2025-11-09 14:00:00','completed'),(9,4,1,3,'2025-11-04 02:00:00','2025-11-04 04:00:00','completed'),(10,5,6,4,'2025-11-02 06:00:00','2025-11-02 08:00:00','completed'),(11,1,8,2,'2025-12-02 02:00:00','2025-12-02 04:00:00','pending'),(12,3,13,1,'2025-12-05 06:00:00','2025-12-05 08:00:00','approved'),(13,6,4,4,'2025-12-03 08:00:00','2025-12-03 10:00:00','pending'),(14,4,10,3,'2025-12-07 04:00:00','2025-12-07 06:00:00','approved'),(15,5,2,1,'2025-12-09 12:00:00','2025-12-09 14:00:00','pending'),(16,3,15,5,'2025-12-11 00:00:00','2025-12-11 02:00:00','approved'),(17,6,16,2,'2025-12-01 10:00:00','2025-12-01 12:00:00','pending'),(18,1,7,4,'2025-12-10 06:00:00','2025-12-10 08:00:00','approved'),(19,4,9,3,'2025-12-04 02:00:00','2025-12-04 04:00:00','pending'),(20,5,12,5,'2025-12-06 08:00:00','2025-12-06 10:00:00','approved');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caregiver`
--

DROP TABLE IF EXISTS `caregiver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `caregiver` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `qualifications` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caregiver`
--

LOCK TABLES `caregiver` WRITE;
/*!40000 ALTER TABLE `caregiver` DISABLE KEYS */;
INSERT INTO `caregiver` VALUES (1,'Anna Lim','Certified Caregiver, Basic First Aid, Elderly Support'),(2,'Michael Tan','Nursing Aide Certificate, CPR & AED Certified'),(3,'Sarah Ong','Diploma in Community Care, Dementia Care Training'),(4,'Daniel Lee','Basic Caregiving Skills, Mobility Assistance Training'),(5,'Rachel Goh','Healthcare Support Certificate, Infection Control Trained');
/*!40000 ALTER TABLE `caregiver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (2,'admin'),(1,'user');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `price` decimal(7,2) NOT NULL,
  `duration` int NOT NULL,
  `category_id` int NOT NULL,
  `created_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_updated_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `img_index` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `service_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `service_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'Personal Care Session (30 min)','Bathing, grooming, dressing, toileting, and hygiene support.','A caring professional provides focused support for personal hygiene, ensuring your loved one feels comfortable, safe, and confident. Ideal for short daily routines or quick check-ins.',50.00,1800,1,'2025-11-25 09:32:07','2025-11-25 09:32:07',1),(2,'Personal Care Session (1 hour)','Bathing, grooming, dressing, toileting, and hygiene support.','A dedicated caregiver assists with full personal care routines including bathing, dressing, grooming, and mobility, offering companionship and reassurance throughout the visit.',90.00,3600,1,'2025-11-25 09:32:07','2025-11-27 15:34:42',2),(3,'Home Assistance Session (1 hour)','Light housekeeping, laundry, dishwashing, bed-making.','Our caregivers help maintain a clean and organized home, taking care of light chores, laundry, and tidying up to create a comfortable environment for your loved one.',80.00,3600,1,'2025-11-25 09:32:07','2025-11-27 15:34:42',3),(4,'Meal Preparation Session (1.5 hours)','Prepare meals based on client\'s dietary needs.','Enjoy nutritious, home-cooked meals prepared to meet dietary needs and preferences, with professional assistance to ensure balanced and delicious meals are served.',120.00,5400,1,'2025-11-25 09:32:07','2025-11-27 15:34:42',4),(5,'Medication Reminder Visit (30 min)','Caregiver checks in and reminds client to take medication on time.','Our caregivers provide timely reminders to take medications, ensuring your loved one maintains their health routine safely and consistently.',40.00,1800,1,'2025-11-25 09:32:07','2025-11-27 15:34:42',5),(6,'Companionship Visit (1 hour)','Conversation, games, emotional support, and social interaction.','A friendly caregiver offers engaging activities, meaningful conversations, and emotional support to keep your loved one socially connected and mentally active.',70.00,3600,1,'2025-11-25 09:32:07','2025-11-27 15:34:42',6),(7,'Dementia Care Support Session (1 hour)','Safety supervision, cognitive activities, routine support.','Focused support for clients with dementia, including memory exercises, safety monitoring, and emotional engagement, designed to enhance quality of life and provide peace of mind.',100.00,3600,2,'2025-11-25 09:32:07','2025-11-27 15:34:42',7),(8,'Dementia Care Support Session (1.5 hours)','Extended safety supervision, cognitive activities, and routine support.','Extended dementia care session providing comprehensive cognitive activities, routine assistance, and compassionate supervision tailored to individual needs, ensuring safety and comfort.',150.00,5400,2,'2025-11-25 09:32:07','2025-11-27 15:34:42',8),(9,'Post-Surgery Recovery Session (2 hours)','Mobility help, routine monitoring, wound-care reminders, comfort support.','Professional caregivers assist clients recovering from surgery with mobility, monitoring, and non-medical support, ensuring a smooth and safe recovery at home.',180.00,7200,2,'2025-11-25 09:32:07','2025-11-27 15:34:42',9),(10,'Chronic Illness Support Session (1 hour)','Assistance for clients with diabetes, stroke, arthritis, or mobility limitations.','Caregivers provide targeted support for clients managing chronic illnesses, helping with daily routines, mobility, and health adherence to maintain independence and comfort.',95.00,3600,2,'2025-11-25 09:32:07','2025-11-27 15:34:42',10),(11,'Palliative Comfort Visit (1.5 hours)','Comfort routines, emotional support, non-medical assistance.','Compassionate care focusing on comfort, emotional well-being, and quality of life for clients facing serious or terminal conditions, delivered with dignity and respect.',160.00,5400,2,'2025-11-25 09:32:07','2025-11-27 15:34:42',11),(12,'Mobility & Fall-Prevention Session (1 hour)','Walk support, transfer help, assistive device guidance, home safety checks.','Caregivers provide mobility assistance, fall-prevention support, and guidance on using assistive devices, ensuring safety and confidence in daily movements.',90.00,3600,2,'2025-11-25 09:32:07','2025-11-27 15:34:42',12),(13,'Medical Appointment Transport','Pick-up/drop-off to clinics, hospitals, therapy sessions.','Reliable transport service for medical appointments, ensuring clients arrive safely and on time, with optional caregiver accompaniment for comfort and assistance.',40.00,3600,3,'2025-11-25 09:32:07','2025-11-27 15:34:42',13),(14,'Grocery Shopping Transport','Caregiver drives or accompanies client to shop for essentials.','Our caregivers provide safe transportation to grocery stores and errands, assisting with carrying bags and ensuring a stress-free shopping experience.',50.00,3600,3,'2025-11-25 09:32:07','2025-11-27 15:34:42',14),(15,'Meal Delivery Drop-Off','Nutritious meals delivered to the client\'s home.','Fresh, balanced meals delivered directly to your home, designed to meet dietary needs and preferences, making mealtime convenient and enjoyable.',25.00,900,3,'2025-11-25 09:32:07','2025-11-27 15:34:42',15),(16,'Pharmacy Pickup Service','Prescription or medication pickup on behalf of the client.','Caregivers safely pick up and deliver medications, ensuring timely access to prescriptions without the stress of travel or long queues.',30.00,1800,3,'2025-11-25 09:32:07','2025-11-27 15:34:42',16),(17,'Accompanied Travel Support (2 hours)','Caregiver accompanies client to appointments or errands for mobility and safety.','Caregivers provide support during outings, offering mobility assistance and companionship to ensure safety and independence when traveling outside the home.',80.00,7200,3,'2025-11-25 09:32:07','2025-11-27 15:34:42',17),(18,'Home Exercise & Mobility Session (45 min)','Light physical activities, stretching, guided walking.','A guided exercise session to improve strength, balance, and flexibility, tailored to individual abilities and conducted in the comfort of home.',60.00,2700,4,'2025-11-25 09:32:07','2025-11-27 15:34:42',18),(19,'Cognitive Stimulation Session (1 hour)','Memory games, puzzles, reading, and mental engagement.','Engaging activities designed to stimulate memory, concentration, and cognitive function, helping clients stay mentally active and sharp.',70.00,3600,4,'2025-11-25 09:32:07','2025-11-27 15:34:42',19),(20,'Recreational Activity Session (1 hour)','Arts, crafts, music, hobby support, or leisure activities.','Fun and interactive recreational sessions that encourage creativity, enjoyment, and social interaction, enhancing quality of life and mental well-being.',65.00,3600,4,'2025-11-25 09:32:07','2025-11-27 15:34:42',20),(21,'Home Organization Support Session (1.5 hours)','Decluttering, organizing belongings, creating a safe home environment.','Professional support to organize and declutter the home, creating a safer, more comfortable living space that promotes independence and peace of mind.',120.00,5400,4,'2025-11-25 09:32:07','2025-11-27 15:34:42',21),(22,'Community Outing Support Session (2 hours)','Caregiver accompanies client to social or community activities.','Caregivers accompany clients on community outings, providing safety, mobility support, and companionship, encouraging social engagement and enriching experiences.',150.00,7200,4,'2025-11-25 09:32:07','2025-11-27 15:34:42',22);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_caregiver`
--

DROP TABLE IF EXISTS `service_caregiver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_caregiver` (
  `id` int NOT NULL AUTO_INCREMENT,
  `service_id` int NOT NULL,
  `caregiver_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `service_id` (`service_id`,`caregiver_id`),
  KEY `caregiver_id` (`caregiver_id`),
  CONSTRAINT `service_caregiver_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`),
  CONSTRAINT `service_caregiver_ibfk_2` FOREIGN KEY (`caregiver_id`) REFERENCES `caregiver` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_caregiver`
--

LOCK TABLES `service_caregiver` WRITE;
/*!40000 ALTER TABLE `service_caregiver` DISABLE KEYS */;
INSERT INTO `service_caregiver` VALUES (1,1,3),(3,2,1),(2,2,4),(4,3,2),(5,4,4),(6,5,1),(7,6,4),(8,7,1),(9,7,4),(10,8,2),(11,9,2),(12,9,3),(13,10,3),(14,11,5),(15,12,3),(16,12,5),(17,13,1),(18,14,5),(19,15,5),(20,16,2);
/*!40000 ALTER TABLE `service_caregiver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_category`
--

DROP TABLE IF EXISTS `service_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `img_index` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_category`
--

LOCK TABLES `service_category` WRITE;
/*!40000 ALTER TABLE `service_category` DISABLE KEYS */;
INSERT INTO `service_category` VALUES (1,'In-home Care','Provides compassionate, non-medical assistance to help individuals remain safe and independent in the comfort of their own homes. Services may include help with daily activities, personal care, light housekeeping, meal preparation, medication reminders, and companionship tailored to each person’s needs.',1),(2,'Specialized Care','Offers focused support for individuals with specific health or cognitive conditions such as dementia, chronic illness, mobility challenges, or post-hospital recovery. Care plans are customized to ensure safety, comfort, and enhanced quality of life through skilled, attentive assistance.',2),(3,'Transportation and Meal Delivery','Ensures access to essential appointments, errands, and community activities through reliable, door-to-door transportation services. Meal delivery provides nutritious, prepared meals brought directly to the home, supporting health, convenience, and independence.',3),(4,'Lifestyle Wellness Support','Promotes overall well-being through services that encourage healthy routines, social engagement, and emotional support. This may include exercise assistance, hobby and activity participation, social companionship, home organization, and other enrichment services that enhance daily life.',4);
/*!40000 ALTER TABLE `service_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int NOT NULL,
  `created_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_updated_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'steve-helloworld','Steve','steve.hi@gmail.com','y9XeVpCk2S7Q1O4okQdN4j3I5DPTj9m8EnCMWf5n96ileOD6Rt8I8Va60UQOrTlW',1,'2025-11-27 10:08:56','2025-11-27 10:08:56'),(2,'admin-user123','Admin 1','example@gmail.com','L7lDx5clyPLVI8dHYHnEMBkuiTK8Yj+ORQbQWV1M/dRdBSiQTOODvzhPOCIlw8hu',2,'2025-11-27 10:34:14','2025-11-27 10:34:32'),(3,'emily-tan123','Emily Tan','emily@outlook.com','qSn2NTM0pOGy0xTRaVJYWZIYJUUdrYaRE/8Jy/53G2MgheFFgSxkMz9X/P/b57eR',1,'2025-11-27 11:14:23','2025-11-27 11:14:23'),(4,'java-lecturer254','Java Lec','java.oracle@gmail.com','ow1RBKInDKJvbavFPVx5yxvo/3+8rSBTp8IDFyEAORN6wNB6DGQwe4tTIXXJAIwB',1,'2025-11-27 11:14:53','2025-11-27 11:14:53'),(5,'bryan-lim6454','Bryan','bryan@ichat.com','12HaIPDIbWckSZUY4MPbumkMbzEirZuhqBtRlPnnHwxhCzhFqIt+rNCuVgBt1+ZA',1,'2025-11-27 11:15:30','2025-11-27 11:15:30'),(6,'hello-user1234','Hello User','hello@gmail.com','X3lfkMbGBIPtEyYg11QE9z0NcksUIazbhXZ2X/pTbS0RntBfBl8NVkZ+MNJlmPmC',1,'2025-11-27 11:16:09','2025-11-27 11:16:09');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-27 23:35:56
