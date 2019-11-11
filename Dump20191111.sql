-- MySQL dump 10.13  Distrib 8.0.18, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: alcpt
-- ------------------------------------------------------
-- Server version	8.0.18

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
-- Table structure for table `alcpt_answersheet`
--

DROP TABLE IF EXISTS `alcpt_answersheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_answersheet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `questions` longtext,
  `answers` longtext,
  `finish_time` datetime(6) NOT NULL,
  `is_finished` tinyint(1) NOT NULL,
  `score` smallint(5) unsigned NOT NULL,
  `exam_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alcpt_answersheet_exam_id_147bc9a1_fk_alcpt_exam_id` (`exam_id`),
  KEY `alcpt_answersheet_user_id_8e290a44_fk_alcpt_student_id` (`user_id`),
  CONSTRAINT `alcpt_answersheet_exam_id_147bc9a1_fk_alcpt_exam_id` FOREIGN KEY (`exam_id`) REFERENCES `alcpt_exam` (`id`),
  CONSTRAINT `alcpt_answersheet_user_id_8e290a44_fk_alcpt_student_id` FOREIGN KEY (`user_id`) REFERENCES `alcpt_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_answersheet`
--

LOCK TABLES `alcpt_answersheet` WRITE;
/*!40000 ALTER TABLE `alcpt_answersheet` DISABLE KEYS */;
INSERT INTO `alcpt_answersheet` VALUES (9,'{\"0\": [28, [1, 2, 0, 3]], \"1\": [3, [1, 2, 0, 3]], \"2\": [12, [2, 3, 1, 0]], \"3\": [34, [2, 3, 0, 1]], \"4\": [20, [1, 2, 0, 3]], \"5\": [14, [0, 1, 2, 3]], \"6\": [39, [3, 1, 2, 0]], \"7\": [32, [2, 0, 1, 3]], \"8\": [13, [0, 3, 2, 1]], \"9\": [37, [0, 2, 1, 3]], \"10\": [36, [0, 3, 2, 1]], \"11\": [21, [0, 1, 3, 2]], \"12\": [26, [0, 2, 3, 1]], \"13\": [17, [2, 0, 3, 1]], \"14\": [6, [2, 3, 0, 1]], \"15\": [7, [2, 1, 3, 0]], \"16\": [5, [3, 0, 2, 1]], \"17\": [23, [3, 1, 2, 0]], \"18\": [9, [2, 0, 1, 3]], \"19\": [41, [3, 0, 2, 1]], \"20\": [4, [3, 0, 2, 1]], \"21\": [10, [3, 2, 1, 0]], \"22\": [29, [3, 0, 2, 1]], \"23\": [42, [2, 3, 1, 0]], \"24\": [18, [2, 0, 3, 1]], \"25\": [2, [2, 0, 3, 1]], \"26\": [38, [2, 3, 0, 1]], \"27\": [19, [2, 0, 3, 1]], \"28\": [22, [1, 2, 3, 0]], \"29\": [24, [0, 1, 3, 2]], \"30\": [31, [0, 3, 1, 2]], \"31\": [33, [3, 0, 1, 2]], \"32\": [40, [3, 0, 1, 2]], \"33\": [25, [2, 0, 3, 1]], \"34\": [35, [2, 3, 0, 1]], \"35\": [8, [3, 0, 1, 2]], \"36\": [11, [3, 2, 1, 0]], \"37\": [16, [1, 0, 2, 3]], \"38\": [27, [1, 0, 2, 3]], \"39\": [30, [2, 1, 3, 0]], \"40\": [79, [2, 1, 0, 3]], \"41\": [66, [1, 2, 3, 0]], \"42\": [54, [0, 1, 3, 2]], \"43\": [67, [0, 1, 3, 2]], \"44\": [63, [2, 0, 1, 3]], \"45\": [58, [1, 2, 0, 3]], \"46\": [68, [2, 1, 0, 3]], \"47\": [64, [2, 0, 3, 1]], \"48\": [70, [0, 2, 3, 1]], \"49\": [52, [3, 0, 2, 1]], \"50\": [77, [1, 2, 3, 0]], \"51\": [74, [0, 1, 3, 2]], \"52\": [53, [1, 2, 0, 3]], \"53\": [69, [3, 2, 1, 0]], \"54\": [80, [3, 1, 0, 2]], \"55\": [62, [2, 0, 3, 1]], \"56\": [90, [2, 3, 1, 0]], \"57\": [61, [3, 1, 2, 0]], \"58\": [89, [0, 1, 2, 3]], \"59\": [56, [2, 0, 1, 3]], \"60\": [123, [2, 0, 3, 1]], \"61\": [122, [1, 0, 3, 2]], \"62\": [128, [2, 0, 1, 3]], \"63\": [137, [2, 0, 1, 3]], \"64\": [136, [0, 1, 3, 2]], \"65\": [133, [2, 0, 1, 3]], \"66\": [126, [0, 3, 2, 1]], \"67\": [124, [1, 3, 0, 2]], \"68\": [130, [0, 2, 3, 1]], \"69\": [135, [0, 1, 2, 3]], \"70\": [132, [3, 0, 2, 1]], \"71\": [129, [0, 2, 3, 1]], \"72\": [134, [1, 0, 3, 2]], \"73\": [125, [0, 2, 1, 3]], \"74\": [127, [1, 0, 2, 3]], \"75\": [115, [1, 0, 3, 2]], \"76\": [93, [1, 0, 2, 3]], \"77\": [101, [0, 2, 1, 3]], \"78\": [107, [2, 3, 1, 0]], \"79\": [118, [0, 1, 2, 3]], \"80\": [100, [2, 1, 0, 3]], \"81\": [106, [0, 3, 1, 2]], \"82\": [97, [1, 0, 3, 2]], \"83\": [94, [3, 2, 1, 0]], \"84\": [109, [0, 3, 1, 2]], \"85\": [110, [1, 2, 3, 0]], \"86\": [95, [1, 0, 3, 2]], \"87\": [117, [3, 0, 1, 2]], \"88\": [96, [2, 3, 0, 1]], \"89\": [111, [0, 2, 1, 3]], \"90\": [161, [1, 3, 2, 0]], \"91\": [151, [2, 0, 1, 3]], \"92\": [149, [0, 2, 1, 3]], \"93\": [160, [1, 3, 2, 0]], \"94\": [158, [0, 1, 2, 3]], \"95\": [144, [3, 2, 0, 1]], \"96\": [145, [0, 1, 3, 2]], \"97\": [152, [0, 3, 2, 1]], \"98\": [159, [1, 3, 2, 0]], \"99\": [150, [1, 3, 2, 0]]}','{\"28\": -1, \"3\": -1, \"12\": -1, \"34\": -1, \"20\": -1, \"14\": -1, \"39\": -1, \"32\": -1, \"13\": -1, \"37\": -1, \"36\": -1, \"21\": -1, \"26\": -1, \"17\": -1, \"6\": -1, \"7\": -1, \"5\": -1, \"23\": -1, \"9\": -1, \"41\": -1, \"4\": -1, \"10\": -1, \"29\": -1, \"42\": -1, \"18\": -1, \"2\": -1, \"38\": -1, \"19\": -1, \"22\": -1, \"24\": -1, \"31\": -1, \"33\": -1, \"40\": -1, \"25\": -1, \"35\": -1, \"8\": -1, \"11\": -1, \"16\": -1, \"27\": -1, \"30\": -1, \"79\": -1, \"66\": -1, \"54\": -1, \"67\": -1, \"63\": -1, \"58\": -1, \"68\": -1, \"64\": -1, \"70\": -1, \"52\": -1, \"77\": -1, \"74\": -1, \"53\": -1, \"69\": -1, \"80\": -1, \"62\": -1, \"90\": -1, \"61\": -1, \"89\": -1, \"56\": -1, \"123\": -1, \"122\": -1, \"128\": -1, \"137\": -1, \"136\": -1, \"133\": -1, \"126\": -1, \"124\": -1, \"130\": -1, \"135\": -1, \"132\": -1, \"129\": -1, \"134\": -1, \"125\": -1, \"127\": -1, \"115\": -1, \"93\": -1, \"101\": -1, \"107\": -1, \"118\": -1, \"100\": -1, \"106\": -1, \"97\": -1, \"94\": -1, \"109\": -1, \"110\": -1, \"95\": -1, \"117\": -1, \"96\": -1, \"111\": -1, \"161\": -1, \"151\": -1, \"149\": -1, \"160\": -1, \"158\": -1, \"144\": -1, \"145\": -1, \"152\": -1, \"159\": -1, \"150\": -1}','2019-05-19 22:21:43.643566',0,0,7,1);
/*!40000 ALTER TABLE `alcpt_answersheet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_department`
--

DROP TABLE IF EXISTS `alcpt_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_department`
--

LOCK TABLES `alcpt_department` WRITE;
/*!40000 ALTER TABLE `alcpt_department` DISABLE KEYS */;
INSERT INTO `alcpt_department` VALUES (1,'法律系'),(4,'財管系'),(2,'資管系'),(3,'運籌系');
/*!40000 ALTER TABLE `alcpt_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_exam`
--

DROP TABLE IF EXISTS `alcpt_exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_exam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `exam_type` smallint(5) unsigned NOT NULL,
  `use_freq` int(11) NOT NULL,
  `modified_times` int(11) NOT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `created_time` datetime(6) NOT NULL,
  `duration` smallint(5) unsigned NOT NULL,
  `finish_time` datetime(6) NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `testpaper_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `alcpt_exam_created_by_id_3e8088e6_fk_alcpt_user_id` (`created_by_id`),
  KEY `alcpt_exam_group_id_6d1403ce_fk_alcpt_group_id` (`group_id`),
  KEY `alcpt_exam_testpaper_id_6048fb92_fk_alcpt_testpaper_id` (`testpaper_id`),
  CONSTRAINT `alcpt_exam_created_by_id_3e8088e6_fk_alcpt_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `alcpt_user` (`id`),
  CONSTRAINT `alcpt_exam_group_id_6d1403ce_fk_alcpt_group_id` FOREIGN KEY (`group_id`) REFERENCES `alcpt_group` (`id`),
  CONSTRAINT `alcpt_exam_testpaper_id_6048fb92_fk_alcpt_testpaper_id` FOREIGN KEY (`testpaper_id`) REFERENCES `alcpt_testpaper` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_exam`
--

LOCK TABLES `alcpt_exam` WRITE;
/*!40000 ALTER TABLE `alcpt_exam` DISABLE KEYS */;
INSERT INTO `alcpt_exam` VALUES (1,'109第一次模擬考',1,0,0,'2019-05-19 20:14:00.000000','2019-05-19 20:14:49.346434',90,'2019-05-20 00:40:57.180167',0,1,2,1),(2,'109第一次模擬考(更正)',1,0,0,'2019-05-19 20:34:00.000000','2019-05-19 20:34:29.356351',90,'2019-05-19 20:34:31.096947',1,1,2,1),(3,'109第二次模擬考',1,0,0,'2019-05-19 21:30:00.000000','2019-05-19 21:34:32.894746',90,'2019-05-19 21:38:08.302006',1,1,2,1),(4,'第三次',1,0,0,'2019-05-19 21:39:00.000000','2019-05-19 21:39:29.466983',90,'2019-05-19 21:39:29.467020',1,1,2,1),(5,'第四次',1,0,0,'2019-05-19 21:42:00.000000','2019-05-19 21:42:21.513967',90,'2019-05-19 21:42:21.514013',1,1,2,1),(6,'第五',1,0,0,'2019-05-19 21:43:00.000000','2019-05-19 21:43:13.950618',90,'2019-05-19 21:43:16.829657',1,1,2,1),(7,'第六次',1,0,0,'2019-11-19 21:49:00.000000','2019-05-19 21:53:29.086260',100,'2019-11-11 06:46:30.942604',0,1,1,2),(9,'dfdsfsdf',1,0,0,'2019-11-07 14:12:00.000000','2019-11-07 14:12:31.749964',90,'2019-11-07 14:13:25.388461',0,1,3,5);
/*!40000 ALTER TABLE `alcpt_exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_group`
--

DROP TABLE IF EXISTS `alcpt_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `alcpt_group_created_by_id_f15e6b32_fk_alcpt_user_id` (`created_by_id`),
  CONSTRAINT `alcpt_group_created_by_id_f15e6b32_fk_alcpt_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_group`
--

LOCK TABLES `alcpt_group` WRITE;
/*!40000 ALTER TABLE `alcpt_group` DISABLE KEYS */;
INSERT INTO `alcpt_group` VALUES (1,'109','2019-05-19 20:07:54.047644','2019-05-19 20:07:54.033649',1),(2,'三中隊','2019-11-06 15:16:30.466152','2019-05-19 20:08:31.369765',20),(3,'YANGtest','2019-10-08 03:34:52.307433','2019-10-08 03:26:11.940201',1);
/*!40000 ALTER TABLE `alcpt_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_group_member`
--

DROP TABLE IF EXISTS `alcpt_group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_group_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `alcpt_group_member_group_id_student_id_1f63dedb_uniq` (`group_id`,`student_id`),
  KEY `alcpt_group_member_student_id_14cba179_fk_alcpt_student_id` (`student_id`),
  CONSTRAINT `alcpt_group_member_group_id_b62cbe32_fk_alcpt_group_id` FOREIGN KEY (`group_id`) REFERENCES `alcpt_group` (`id`),
  CONSTRAINT `alcpt_group_member_student_id_14cba179_fk_alcpt_student_id` FOREIGN KEY (`student_id`) REFERENCES `alcpt_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_group_member`
--

LOCK TABLES `alcpt_group_member` WRITE;
/*!40000 ALTER TABLE `alcpt_group_member` DISABLE KEYS */;
INSERT INTO `alcpt_group_member` VALUES (1,1,16),(2,1,17),(3,1,18),(4,1,19),(27,2,1),(28,2,2),(29,2,3),(30,2,4),(31,2,5),(32,2,6),(33,2,7),(34,2,8),(35,2,9),(26,2,17),(20,3,19);
/*!40000 ALTER TABLE `alcpt_group_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_proclamation`
--

DROP TABLE IF EXISTS `alcpt_proclamation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_proclamation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext NOT NULL,
  `text` longtext NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alcpt_proclamation_created_by_id_02e079a0_fk_alcpt_user_id` (`created_by_id`),
  CONSTRAINT `alcpt_proclamation_created_by_id_02e079a0_fk_alcpt_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_proclamation`
--

LOCK TABLES `alcpt_proclamation` WRITE;
/*!40000 ALTER TABLE `alcpt_proclamation` DISABLE KEYS */;
INSERT INTO `alcpt_proclamation` VALUES (1,'109年第一次模擬考','預計於2020/3/21實施第一次模擬考',1,'2019-05-19 20:44:21.175440',1);
/*!40000 ALTER TABLE `alcpt_proclamation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_question`
--

DROP TABLE IF EXISTS `alcpt_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_type` smallint(5) unsigned NOT NULL,
  `question_file` longtext,
  `question` longtext,
  `option` longtext NOT NULL,
  `answer` smallint(5) unsigned NOT NULL,
  `difficulty` smallint(5) unsigned NOT NULL,
  `issued_freq` int(11) NOT NULL,
  `correct_freq` int(11) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_valid` tinyint(1) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `last_updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `alcpt_question_created_by_id_2c7db757_fk_alcpt_user_id` (`created_by_id`),
  KEY `alcpt_question_last_updated_by_id_7e7caa2c_fk_alcpt_user_id` (`last_updated_by_id`),
  CONSTRAINT `alcpt_question_created_by_id_2c7db757_fk_alcpt_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `alcpt_user` (`id`),
  CONSTRAINT `alcpt_question_last_updated_by_id_7e7caa2c_fk_alcpt_user_id` FOREIGN KEY (`last_updated_by_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=295 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_question`
--

LOCK TABLES `alcpt_question` WRITE;
/*!40000 ALTER TABLE `alcpt_question` DISABLE KEYS */;
INSERT INTO `alcpt_question` VALUES (162,1,'/media/documents/question_162.mp3',NULL,'[\"He will go.\", \"He canu2019t go.\", \"He finished his studies.\", \"He likes to study.\"]',1,1,0,0,'2019-05-22 13:31:13.384825','2019-10-14 11:51:32.356869',1,1,1),(163,1,'/media/documents/question_163.mp3',NULL,'[\"at 1005\", \"at 1315\", \"at 1515\", \"at.\"]',1,1,0,0,'2019-05-22 13:31:46.093751','2019-10-14 11:59:36.836546',1,1,1),(164,1,'/media/documents/question_164.mp3',NULL,'[\"put it on the desk\", \"look up words in it\", \"put a new cover on it\", \"correct it\"]',1,1,0,0,'2019-05-22 13:33:09.677955','2019-05-22 13:33:09.836831',1,1,1),(165,1,'/media/documents/question_165.mp3',NULL,'[\"for measuring lengths\", \"for painting boards\", \"for holding objects\", \"for sharpening tools\"]',0,1,0,0,'2019-05-22 13:33:30.669171','2019-10-14 12:31:45.708574',1,1,1),(166,1,'/media/documents/question_166.mp3',NULL,'[\"buy a plane\", \"sell a plane\", \"travel on a plane\", \"find an old plane\"]',2,1,0,0,'2019-05-22 13:35:02.141063','2019-10-14 12:35:43.612947',1,1,1),(167,1,'/media/documents/question_167.mp3',NULL,'[\"red\", \"wool\", \"rain\", \"small\"]',0,1,0,0,'2019-05-22 13:35:29.866308','2019-05-22 13:35:30.022099',1,1,1),(168,1,'/media/documents/question_168.mp3',NULL,'[\"a list of telephone numbers\", \"a new medicine\", \"a group of workers\", \"a place to eat\"]',3,1,0,0,'2019-05-22 13:35:50.165967','2019-05-22 13:35:50.554401',1,1,1),(169,1,'/media/documents/question_169.mp3',NULL,'[\"June\", \"April\", \"August\", \"September\"]',2,1,0,0,'2019-05-22 13:36:15.188132','2019-05-22 13:36:15.351947',1,1,1),(170,1,'/media/documents/question_170.mp3',NULL,'[\"He has a stomachache.\", \"He has a toothache.\", \"His feet hurt him.\", \"His eyes hurt him.\"]',1,1,0,0,'2019-05-22 13:36:36.900896','2019-05-22 13:36:37.065056',1,1,1),(171,1,'/media/documents/question_171.mp3',NULL,'[\"lesson one\", \"lesson two\", \"They are the same.\", \"Both are difficult.\"]',0,1,0,0,'2019-05-22 13:39:22.886743','2019-05-22 13:39:23.266358',1,1,1),(172,1,'/media/documents/question_172.mp3',NULL,'[\"your family name\", \"your fatheru2019s name\", \"your motheru2019s name\", \"your first name\"]',0,1,0,0,'2019-05-22 13:39:45.853276','2019-05-22 13:39:46.017290',1,1,1),(173,1,'/media/documents/question_173.mp3',NULL,'[\"cleaning\", \"price tags\", \"buttons\", \"changes\"]',3,1,0,0,'2019-05-22 13:40:20.686860','2019-05-22 13:40:20.793674',1,1,1),(174,1,'/media/documents/question_174.mp3',NULL,'[\"close the door\", \"follow him\", \"answer it\", \"look at them\"]',2,1,0,0,'2019-05-22 13:40:40.220754','2019-05-22 13:40:40.360289',1,1,1),(175,1,'/media/documents/question_175.mp3',NULL,'[\"They will fly.\", \"They will walk.\", \"They will run.\", \"They will drive.\"]',0,1,0,0,'2019-05-22 13:40:55.719577','2019-05-22 13:40:55.868148',1,1,1),(176,1,'/media/documents/question_176.mp3',NULL,'[\"yesterday\", \"on Saturday\", \"with George\", \"at the office\"]',1,1,0,0,'2019-05-22 13:41:15.908696','2019-05-22 13:41:16.034984',1,1,1),(177,1,'/media/documents/question_177.mp3',NULL,'[\"to board the ship\", \"to get a haircut\", \"to see the factory\", \"to meet his friendu2019s plane\"]',3,1,0,0,'2019-05-22 13:41:31.822465','2019-05-22 13:41:31.922333',1,1,1),(178,1,'/media/documents/question_178.mp3',NULL,'[\"stamping packages\", \"depositing letters\", \"filling envelopes\", \"collecting stamps\"]',1,1,0,0,'2019-05-22 13:41:55.732814','2019-05-22 13:41:55.877938',1,1,1),(179,1,'/media/documents/question_179.mp3',NULL,'[\"the ability to speed up\", \"the color of the car\", \"the slowing-down action\", \"the stopping action\"]',0,1,0,0,'2019-05-22 13:42:23.885340','2019-05-22 13:42:24.021034',1,1,1),(180,1,'/media/documents/question_180.mp3',NULL,'[\"in a large house\", \"in a small house\", \"in a crowded house\", \"in a busy house\"]',0,1,0,0,'2019-05-22 13:42:42.028181','2019-05-22 13:42:42.161082',1,1,1),(181,1,'/media/documents/question_181.mp3',NULL,'[\"a directional light\", \"a new headlight\", \"a spare tire\", \"a warning device\"]',3,1,0,0,'2019-05-22 13:42:59.990560','2019-05-22 13:43:00.122561',1,1,1),(182,1,'/media/documents/question_182.mp3',NULL,'[\"like him\", \"remember him\", \"contact him\", \"forget him\"]',2,1,0,0,'2019-05-22 13:44:00.541533','2019-05-22 13:44:00.646801',1,1,1),(183,1,'/media/documents/question_183.mp3',NULL,'[\"He got it at a store.\", \"He read it slowly.\", \"He looked at it for a long time.\", \"He read it quickly.\"]',3,1,0,0,'2019-05-22 13:44:17.693513','2019-05-22 13:44:17.838485',1,1,1),(184,1,'/media/documents/question_184.mp3',NULL,'[\"The wire is not good.\", \"The wire is not covered for protection.\", \"The wire is not carrying electricity.\", \"The wire is not visible.\"]',0,1,0,0,'2019-05-22 13:44:33.534335','2019-05-22 13:44:33.664847',1,1,1),(185,1,'/media/documents/question_185.mp3',NULL,'[\"Who used this book first?\", \"Who wants to use this book?\", \"Who used this book frequently?\", \"Who will be using this book?\"]',0,1,0,0,'2019-05-22 13:44:51.724765','2019-05-22 13:44:51.855780',1,1,1),(186,1,'/media/documents/question_186.mp3',NULL,'[\"Classes begin at eight ou2019clock.\", \"Only young children go to school there.\", \"The school is three miles from here.\", \"The school is closed for the day.\"]',2,1,0,0,'2019-05-22 13:45:11.223771','2019-05-22 13:45:11.357036',1,1,1),(187,1,'/media/documents/question_187.mp3',NULL,'[\"There are many people downtown.\", \"Many people are walking on Saturdays.\", \"There are many cars on the streets.\", \"There are many lights on the streets.\"]',2,1,0,0,'2019-05-22 13:45:32.325461','2019-05-22 13:45:32.455199',1,1,1),(188,1,'/media/documents/question_188.mp3',NULL,'[\"It canu2019t be seen.\", \"It is cool.\", \"It is not humid.\", \"It is warm.\"]',0,1,0,0,'2019-05-22 13:45:48.917831','2019-05-22 13:45:49.057756',1,1,1),(189,1,'/media/documents/question_189.mp3',NULL,'[\"He saw it.\", \"He made it.\", \"He moved it.\", \"He cut it.\"]',0,1,0,0,'2019-05-22 13:46:09.702789','2019-05-22 13:46:09.831513',1,1,1),(190,1,'/media/documents/question_190.mp3',NULL,'[\"It is easily bent.\", \"It is very hard.\", \"It is bright.\", \"It is heavy.\"]',0,1,0,0,'2019-05-22 13:46:25.573666','2019-05-22 13:46:25.707874',1,1,1),(191,1,'/media/documents/question_191.mp3',NULL,'[\"It plays too loudly.\", \"It needs repair.\", \"Itu2019s in good condition.\", \"Itu2019s a cheap radio.\"]',2,1,0,0,'2019-05-22 13:46:48.215674','2019-05-22 13:46:48.340905',1,1,1),(192,1,'/media/documents/question_192.mp3',NULL,'[\"He is well known.\", \"He is not known.\", \"He does not know anyone.\", \"He is a dangerous person.\"]',0,1,0,0,'2019-05-22 13:47:05.599636','2019-05-22 13:47:05.724861',1,1,1),(193,1,'/media/documents/question_193.mp3',NULL,'[\"He left a new student in class.\", \"He found a new student in class.\", \"He registered anew student.\", \"He presented a new student.\"]',3,1,0,0,'2019-05-22 13:47:22.480140','2019-05-22 13:47:22.573828',1,1,1),(194,1,'/media/documents/question_194.mp3',NULL,'[\"He is driving nails in the board.\", \"He is making holes in it.\", \"He is sawing the board.\", \"He is plugging holes.\"]',1,1,0,0,'2019-05-22 13:47:39.196789','2019-05-22 13:47:39.330899',1,1,1),(195,1,'/media/documents/question_195.mp3',NULL,'[\"He hears a high way noise.\", \"He hears an unfamiliar noise.\", \"He hears a familiar noise.\", \"He hears a low sound.\"]',1,1,0,0,'2019-05-22 13:47:57.357156','2019-05-22 13:47:57.483324',1,1,1),(196,1,'/media/documents/question_196.mp3',NULL,'[\"I want to sell this car.\", \"I will buy this car.\", \"I will follow this car.\", \"I have bought this car.\"]',1,1,0,0,'2019-05-22 13:48:27.741801','2019-05-22 13:48:27.867433',1,1,1),(197,1,'/media/documents/question_197.mp3',NULL,'[\"Bill called John.\", \"Bill hurt John.\", \"Bill telephoned John.\", \"Bill met John.\"]',3,1,0,0,'2019-05-22 13:48:44.468810','2019-05-22 13:48:44.592788',1,1,1),(198,1,'/media/documents/question_198.mp3',NULL,'[\"The lights are not working properly.\", \"They are colored.\", \"The lights are turned off completely.\", \"They are going on and off.\"]',3,1,0,0,'2019-05-22 13:49:05.342309','2019-05-22 13:49:05.470193',1,1,1),(199,1,'/media/documents/question_199.mp3',NULL,'[\"We eat different kinds of vegetables daily.\", \"We always eat the same vegetables.\", \"We eat vegetables with our meat every day.\", \"We eat only one vegetable every day.\"]',0,1,0,0,'2019-05-22 13:49:21.796256','2019-05-22 13:49:21.927230',1,1,1),(200,1,'/media/documents/question_200.mp3',NULL,'[\"There were many tickets for sale.\", \"We were lucky to get them.\", \"We could not get the tickets.\", \"There were no more games.\"]',1,1,0,0,'2019-05-22 13:49:37.717123','2019-05-22 13:49:37.843904',1,1,1),(201,1,'/media/documents/question_201.mp3',NULL,'[\"The airlines pay him for flying.\", \"He flies for the Air Force.\", \"He flies for sport.\", \"He sells airplanes.\"]',0,1,0,0,'2019-05-22 13:49:53.782150','2019-05-22 13:49:53.911068',1,1,1),(202,2,'/media/documents/question_202.mp3',NULL,'[\"to quit smoking\", \"to reduce his smoking\", \"that he didnu2019t need to smoke regularly\", \"that he could continue smoking\"]',0,1,0,0,'2019-05-22 13:51:55.439962','2019-05-22 13:51:55.831183',1,1,1),(203,2,'/media/documents/question_203.mp3',NULL,'[\"She likes roller-skating better.\", \"She has no choice.\", \"She prefers the movies.\", \"She doesnu2019t like either one.\"]',2,1,0,0,'2019-05-22 13:52:46.013889','2019-05-22 13:52:46.373266',1,1,1),(204,2,'/media/documents/question_204.mp3',NULL,'[\"He is very unhappy with his studies.\", \"He has no great interest in his studies.\", \"He wants to change courses.\", \"He is very interested in his studies.\"]',3,1,0,0,'2019-05-22 13:53:03.231954','2019-05-22 13:53:03.357890',1,1,1),(205,2,'/media/documents/question_205.mp3',NULL,'[\"He would repair it, but he wouldnu2019t replace it.\", \"He wouldnu2019t replace or repair it.\", \"He would replace it rather than repair it.\", \"He would repair it and replace it.\"]',2,1,0,0,'2019-05-22 13:53:24.305582','2019-05-22 13:53:24.429527',1,1,1),(206,2,'/media/documents/question_206.mp3',NULL,'[\"It will stay in good condition.\", \"It will decay quickly.\", \"It will be safe to eat.\", \"It will remain unchanged.\"]',1,1,0,0,'2019-05-22 13:53:41.665615','2019-05-22 13:53:41.790281',1,1,1),(207,2,'/media/documents/question_207.mp3',NULL,'[\"a happy one\", \"an unpleasant one\", \"an easy one\", \"a strange one\"]',1,1,0,0,'2019-05-22 13:54:00.533775','2019-05-22 13:54:00.663613',1,1,1),(208,2,'/media/documents/question_208.mp3',NULL,'[\"He has bacon and eggs every day.\", \"He sometimes has bacon and eggs.\", \"He doesnu2019t eat bacon and eggs.\", \"He always has bacon and eggs.\"]',1,1,0,0,'2019-05-22 13:54:29.974408','2019-05-22 13:54:30.100371',1,1,1),(209,2,'/media/documents/question_209.mp3',NULL,'[\"He is always tired.\", \"He is never tired.\", \"He is going to get up.\", \"He will be tired soon.\"]',3,1,0,0,'2019-05-22 13:54:50.799596','2019-05-22 13:54:50.923057',1,1,1),(210,2,'/media/documents/question_210.mp3',NULL,'[\"a mistake\", \"a complaint\", \"a visitor\", \"a rest period\"]',3,1,0,0,'2019-05-22 13:55:12.046942','2019-05-22 13:55:12.174790',1,1,1),(211,2,'/media/documents/question_211.mp3',NULL,'[\"He was undecided.\", \"He is going with John.\", \"He decided not to go.\", \"He went to the game.\"]',2,1,0,0,'2019-05-22 13:55:32.535747','2019-05-22 13:55:32.673242',1,1,1),(212,2,'/media/documents/question_212.mp3',NULL,'[\"a loan\", \"a dollar bill\", \"a quarter\", \"a stamp\"]',2,1,0,0,'2019-05-22 13:55:53.846650','2019-05-22 13:55:53.975380',1,1,1),(213,2,'/media/documents/question_213.mp3',NULL,'[\"a wrench\", \"the scissors\", \"a file\", \"the hammer\"]',0,1,0,0,'2019-05-22 13:56:13.712607','2019-05-22 13:56:13.840776',1,1,1),(214,2,'/media/documents/question_214.mp3',NULL,'[\"wait a minute\", \"take the telephone line\", \"open the telephone book\", \"hang up the phone\"]',0,1,0,0,'2019-05-22 13:56:37.278125','2019-05-22 13:56:37.408043',1,1,1),(215,2,'/media/documents/question_215.mp3',NULL,'[\"eat a big meal\", \"drink something hot\", \"eat a piece of candy\", \"eat something light\"]',0,1,0,0,'2019-05-22 13:57:09.574121','2019-05-22 13:57:09.704144',1,1,1),(216,2,'/media/documents/question_216.mp3',NULL,'[\"the large room\", \"the wrong room\", \"the room on the left\", \"the correct room\"]',3,1,0,0,'2019-05-22 13:57:30.886674','2019-05-22 13:57:31.009145',1,1,1),(217,2,'/media/documents/question_217.mp3',NULL,'[\"humidity\", \"atmospheric pressure\", \"temperature\", \"wind velocity\"]',2,1,0,0,'2019-05-22 13:57:53.421168','2019-05-22 13:57:53.551961',1,1,1),(218,2,'/media/documents/question_218.mp3',NULL,'[\"He has a very good watch.\", \"He doesnu2019t wear it.\", \"It doesnu2019t keep good time.\", \"It is too tight.\"]',2,1,0,0,'2019-05-22 13:58:14.568179','2019-05-22 13:58:14.692844',1,1,1),(219,2,'/media/documents/question_219.mp3',NULL,'[\"let the water run\", \"stop the flow of water\", \"make the water run more\", \"change the faucet\"]',1,1,0,0,'2019-05-22 13:58:33.776763','2019-05-22 13:58:33.909676',1,1,1),(220,2,'/media/documents/question_220.mp3',NULL,'[\"windy\", \"hot and dry\", \"cool\", \"very damp\"]',3,1,0,0,'2019-05-22 13:58:57.742987','2019-05-22 13:58:57.868650',1,1,1),(221,2,'/media/documents/question_221.mp3',NULL,'[\"in March\", \"in December\", \"every month\", \"in January\"]',0,1,0,0,'2019-05-22 13:59:19.007379','2019-05-22 13:59:19.136609',1,1,1),(222,4,NULL,'If he  ____ his sweater, he wouldn’t have caught a cold.','[\"wear\", \"had worn\", \"wears\", \"wearing\"]',1,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(223,4,NULL,'He is ____ in the military service.','[\"an officer\", \"officer\", \"a officer\", \"officers\"]',0,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(224,4,NULL,'I can’t go with you ____ I’m busy.','[\"that\",\"and\",\"but\",\"because\"]',0,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(225,4,NULL,'They have been waiting for me ____ 5 o’clock.','[\"during\",\"since\",\"between\",\"for\"]',3,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(226,4,NULL,'Most people ____  to read newspapers.','[\"likes\",\"like\",\"are alike\",\"were alike\"]',1,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(227,4,NULL,'John would have called the police if he ____ the accident.','[\"see\",\"saw\",\"had seen\",\"sees\"]',0,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(228,4,NULL,'He finished ____ his tape.','[\"listened to\",\"listens by\",\"to listen\",\"listening to\"]',2,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(229,4,NULL,'He left the office early ____ he could do some shopping.','[\"if\",\"unless\",\"that\",\"so\"]',3,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(230,4,NULL,'____ you mind closing the window?','[\"May\",\"Could\",\"If\",\"Would\"]',2,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(231,4,NULL,'You ____ review this lesson before you take the test.','[\"did\",\"had to\",\"ought to\",\"would\"]',3,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(232,4,NULL,'He has been studying English ____ four years.','[\"for\", \"since\", \"during\", \"until\"]',1,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(233,4,NULL,'The visibility was poor yesterday. I ____.','[\"couldn’t see very far\",\"didn’t have much money\",\"was sick\",\"made a bad grade\"]',0,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(234,4,NULL,'Howard finished ____ because he was the fastest.','[\"last\",\"lowest\",\"first\",\"slower\"]',0,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(235,4,NULL,'Get the red book.____ is on the shelf.','[\"What\",\"It\",\"She\",\"He\"]',2,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(236,4,NULL,'I am going ____ to buy a new car.','[\"for downtown\",\"downtown\",\"at downtown\",\"into downtown\"]',1,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(237,4,NULL,'The weather is ____ today than it was last night.','[\"good\",\"better\",\"nice\",\"best\"]',1,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(238,4,NULL,'In the U.S., conversation is ____ proper during meals.','[\"consider\",\"considering\",\"considered\",\"considers\"]',1,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(239,4,NULL,'____ spears for weapons, the men hunted wild animals.','[\"Will use\",\"Use\",\"To use\",\"Using\"]',2,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(240,4,NULL,'Aircraft pilots communicate ____ control towers.','[\"at\",\"for\",\"during\",\"with\"]',3,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(241,4,NULL,'Did the students ____ a lot of homework last night?','[\"has\",\"had\",\"having\",\"have\"]',3,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(242,3,NULL,'If he ____ his sweater, he wouldn’t have caught a cold.','[\"had worn\", \"wear\", \"wears\", \"wearing\"]',0,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(243,3,NULL,'He is ____ in the military service.','[\"an officer\",\"officer\",\"wears\",\"wearing\"]',0,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(244,3,NULL,'I can’t go with you ____ I’m busy.','[\"that\",\"and\",\"wears\",\"wearing\"]',3,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(245,3,NULL,'They have been waiting for me ____ 5 o’clock.','[\"during\",\"since\",\"wears\",\"wearing\"]',1,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(246,3,NULL,'Most people ____  to read newspapers.','[\"likes\",\"like\",\"wears\",\"wearing\"]',0,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(247,3,NULL,'John would have called the police if he ____ the accident.','[\"see\",\"saw\",\"wears\",\"wearing\"]',2,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(248,3,NULL,'He finished ____ his tape.','[\"listened to\",\"listens by\",\"wears\",\"wearing\"]',3,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(249,3,NULL,'He left the office early ____ he could do some shopping.','[\"if\",\"unless\",\"wears\",\"wearing\"]',2,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(250,3,NULL,'____ you mind closing the window?','[\"May\",\"Could\",\"wears\",\"wearing\"]',3,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(251,3,NULL,'You ____ review this lesson before you take the test.','[\"did\",\"had to\",\"wears\",\"wearing\"]',1,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(252,3,NULL,'He has been studying English ____ four years.','[\"for\",\"since\",\"wears\",\"wearing\"]',0,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(253,3,NULL,'The visibility was poor yesterday. I ____.','[\"couldn’t see very far\",\"didn’t have much money\",\"wears\",\"wearing\"]',0,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(254,3,NULL,'Howard finished ____ because he was the fastest.','[\"last\",\"lowest\",\"wears\",\"wearing\"]',2,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(255,3,NULL,'Get the red book.____ is on the shelf.','[\"What\",\"It\",\"wears\",\"wearing\"]',1,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(256,3,NULL,'I am going ____ to buy a new car.','[\"for downtown\",\"downtown\",\"wears\",\"wearing\"]',1,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(257,3,NULL,'The weather is ____ today than it was last night.','[\"good\",\"better\",\"wears\",\"wearing\"]',1,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(258,3,NULL,'In the U.S., conversation is ____ proper during meals.','[\"consider\",\"considering\",\"wears\",\"wearing\"]',2,1,0,0,'2019-05-19 16:18:54.592759','2019-10-07 07:06:04.132653',1,2,1),(259,3,NULL,'____ spears for weapons, the men hunted wild animals.','[\"Will use\",\"Use\",\"wears\",\"wearing\"]',3,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',0,2,NULL),(260,3,NULL,'Aircraft pilots communicate ____ control towers.','[\"at\",\"for\",\"wears\",\"wearing\"]',3,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',0,2,NULL),(261,3,NULL,'Did the students ____ a lot of homework last night?','[\"has\",\"had\",\"wears\",\"wearing\"]',3,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',0,2,NULL),(262,5,NULL,'Jones has only a few days to learn to drive.','[\"He will need a lot of time.\", \"He has studied every day.\", \"He has little time left.\", \"He has studied every day.\", \"He has many days.\"]',1,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(263,5,NULL,'Martin wants approximately one hundred fifty dollars for that table.\nHe will accept between ____.','[\"$50.00 and $54.00\",\"and $117.\",\"$100.00 and $104.00\",\"and $117.\",\"$50.00 and 00 152.00\"]',3,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(264,5,NULL,'I’m going to make reservations for my trip. I’m going to ____.','[\"make some fiends\",\"make some money.\",\"have some food saved\",\"make some money.\",\"make some seat saved\"]',3,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(265,5,NULL,'You should \"\"use your head\"\" when driving in heavy traffic.','[\"think intelligently\",\"turn your head often\",\"look straight ahead.\",\"think your head up\"]',0,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(266,5,NULL,'The waitress asked, “Sir, what kind of dressing would you like?” “____,” he answered.','[\"Oil and vinegar\",\"Well done\",\"French fries.\",\"Oil done and fork\"]',0,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(267,5,NULL,'How far is it to school?','[\"The school is three miles from here.\",\"Classes begin at eight o’clock.\",\"Only young children go to school here.\",\"The begin the day.\"]',0,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(268,5,NULL,'Can you tell me where the base is?','[\"Where is the base located?\",\"What is the base for?\",\"Where are you going.\",\"Where is you now?\"]',0,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(269,5,NULL,'Do you have a sufficient amount of gas to make the trip?','[\"Do you have an extra amount of gas?\",\"Do you have enough gas?\",\"Do you have some high power gas.\",\"Do you of gas?\"]',1,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(270,5,NULL,'When shall we meet you?','[\"at the barracks\",\"any time after 6:00\",\"Yes we shall.\",\"at time have met.\"]',1,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(271,5,NULL,'Do they still live in San Antonio?','[\"Yes, they visit there frequently.\",\"No, they have.\",\"No they don’t anymore.\",\"Yes they moved yesterday.\"]',2,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(272,5,NULL,'What did your roommate put on for the party?','[\"He left at 8:00.\",\"He went with a friend.\",\"He wore a dark suit.\",\"He went Officer’s Club.\"]',2,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(273,5,NULL,'Did you help her make up her mind?','[\"Yes, I decided for myself.\",\"Yes, I helped her decide.\",\"Yes I minded about the maid.\",\"Yes I new sign.\"]',1,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',1,2,NULL),(274,5,NULL,'Are you comfortable in this room?','[\"Yes, I came for the table.\",\"Yes, this room is too cold.\",\"Yes there are four tables here.\",\"Yes this at ease.\"]',3,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',0,2,NULL),(275,5,'','Was the room crowded at the party?','[\"No, there wasn’t much food.\",\"Yes, the party was in the blue room.\",\"Yes there were too many people.\",\"No the the party.\"]',2,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',0,2,NULL),(276,5,NULL,'When someone says they are all set, they ____ .','[\"are ready\",\"have the clock timed\",\"want to eat.\",\"are the sitting down\"]',0,1,0,0,'2019-05-19 16:18:54.592759','2019-05-19 16:18:54.592759',0,2,NULL),(282,3,NULL,'I __ a student.','[\"am\", \"are\", \"were\", \"is\"]',0,1,0,0,'2019-10-24 06:07:48.369498','2019-10-24 06:18:20.538127',1,1,1),(288,3,NULL,'this is gramma test','[\"a\", \"b\", \"c\", \"d\"]',0,1,0,0,'2019-11-10 14:28:05.327995','2019-11-10 14:28:05.347771',0,1,NULL),(289,4,NULL,'this is phrase test','[\"a\", \"b\", \"c\", \"d\"]',0,1,0,0,'2019-11-10 14:28:50.438725','2019-11-10 14:28:50.441235',0,1,NULL),(290,3,NULL,'here is gramma test from TBManager.','[\"a\", \"b\", \"c\", \"d\"]',0,1,0,0,'2019-11-10 14:33:13.360735','2019-11-10 14:33:13.363345',0,1,NULL),(291,4,NULL,'this is phrase test from TBManager.','[\"a\", \"b\", \"c\", \"d\"]',0,1,0,0,'2019-11-10 14:33:44.828520','2019-11-10 14:33:44.831815',0,1,NULL),(292,4,NULL,'this is phrase test from TB','[\"a\", \"b\", \"cd\", \"e\"]',0,1,0,0,'2019-11-10 14:56:58.935096','2019-11-10 14:56:58.939482',0,1,NULL),(293,5,NULL,'this is section test from TB','[\"A\", \"b\", \"C\", \"d\"]',0,1,0,0,'2019-11-10 14:59:59.403265','2019-11-10 14:59:59.405452',0,1,NULL),(294,5,NULL,'this is section test from TBOperator','[\"Z\", \"Y\", \"x\", \"w\"]',0,1,0,0,'2019-11-10 15:00:25.861445','2019-11-10 15:00:25.864361',0,1,NULL);
/*!40000 ALTER TABLE `alcpt_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_question_used_to`
--

DROP TABLE IF EXISTS `alcpt_question_used_to`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_question_used_to` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `testpaper_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `alcpt_question_used_to_question_id_testpaper_id_b10ac272_uniq` (`question_id`,`testpaper_id`),
  KEY `alcpt_question_used__testpaper_id_0baa5adc_fk_alcpt_tes` (`testpaper_id`),
  CONSTRAINT `alcpt_question_used__testpaper_id_0baa5adc_fk_alcpt_tes` FOREIGN KEY (`testpaper_id`) REFERENCES `alcpt_testpaper` (`id`),
  CONSTRAINT `alcpt_question_used_to_question_id_b6cbbeef_fk_alcpt_question_id` FOREIGN KEY (`question_id`) REFERENCES `alcpt_question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=946 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_question_used_to`
--

LOCK TABLES `alcpt_question_used_to` WRITE;
/*!40000 ALTER TABLE `alcpt_question_used_to` DISABLE KEYS */;
INSERT INTO `alcpt_question_used_to` VALUES (192,162,2),(261,162,3),(346,162,5),(215,163,2),(258,163,3),(363,163,5),(183,164,2),(268,164,3),(344,164,5),(214,165,2),(244,165,3),(375,165,5),(217,166,2),(265,166,3),(345,166,5),(220,167,2),(257,167,3),(354,167,5),(208,168,2),(280,168,3),(348,168,5),(189,169,2),(266,169,3),(370,169,5),(190,170,2),(264,170,3),(358,170,5),(204,171,2),(273,171,3),(378,171,5),(191,172,2),(263,172,3),(362,172,5),(207,173,2),(275,173,3),(369,173,5),(206,174,2),(251,174,3),(364,174,5),(187,175,2),(270,175,3),(365,175,5),(198,176,2),(281,176,3),(356,176,5),(194,177,2),(267,177,3),(380,177,5),(218,178,2),(250,178,3),(355,178,5),(210,179,2),(253,179,3),(342,179,5),(202,180,2),(271,180,3),(361,180,5),(197,181,2),(243,181,3),(372,181,5),(199,182,2),(249,182,3),(357,182,5),(221,183,2),(245,183,3),(379,183,5),(216,184,2),(254,184,3),(343,184,5),(188,185,2),(246,185,3),(352,185,5),(196,186,2),(262,186,3),(367,186,5),(201,187,2),(274,187,3),(353,187,5),(213,188,2),(248,188,3),(368,188,5),(186,189,2),(242,189,3),(350,189,5),(182,190,2),(277,190,3),(351,190,5),(203,191,2),(256,191,3),(360,191,5),(184,192,2),(278,192,3),(381,192,5),(209,193,2),(279,193,3),(376,193,5),(200,194,2),(260,194,3),(349,194,5),(195,195,2),(259,195,3),(366,195,5),(193,196,2),(252,196,3),(374,196,5),(219,197,2),(276,197,3),(373,197,5),(205,198,2),(255,198,3),(347,198,5),(211,199,2),(272,199,3),(359,199,5),(212,200,2),(269,200,3),(371,200,5),(185,201,2),(247,201,3),(377,201,5),(241,202,2),(299,202,3),(408,202,5),(226,203,2),(296,203,3),(422,203,5),(229,204,2),(295,204,3),(412,204,5),(235,205,2),(298,205,3),(420,205,5),(225,206,2),(289,206,3),(415,206,5),(224,207,2),(287,207,3),(425,207,5),(240,208,2),(290,208,3),(421,208,5),(236,209,2),(292,209,3),(416,209,5),(238,210,2),(297,210,3),(414,210,5),(233,211,2),(286,211,3),(423,211,5),(222,212,2),(301,212,3),(418,212,5),(239,213,2),(293,213,3),(419,213,5),(232,214,2),(284,214,3),(409,214,5),(223,215,2),(282,215,3),(413,215,5),(228,216,2),(283,216,3),(426,216,5),(234,217,2),(294,217,3),(410,217,5),(231,218,2),(288,218,3),(411,218,5),(227,219,2),(285,219,3),(424,219,5),(237,220,2),(291,220,3),(427,220,5),(230,221,2),(300,221,3),(417,221,5),(162,222,1),(140,222,2),(327,222,3),(167,223,1),(126,223,2),(319,223,3),(159,224,1),(139,224,2),(321,224,3),(429,224,5),(156,225,1),(440,225,5),(161,226,1),(138,226,2),(439,226,5),(164,227,1),(130,227,2),(320,227,3),(428,227,5),(166,228,1),(134,228,2),(432,228,5),(169,229,1),(131,229,2),(322,229,3),(170,230,1),(136,230,2),(318,230,3),(163,231,1),(127,231,2),(317,231,3),(431,231,5),(129,232,2),(326,232,3),(157,233,1),(132,233,2),(323,233,3),(430,233,5),(324,234,3),(441,234,5),(325,235,3),(434,235,5),(331,236,3),(437,236,5),(165,237,1),(128,237,2),(442,237,5),(160,238,1),(328,238,3),(435,238,5),(137,239,2),(330,239,3),(436,239,5),(168,240,1),(133,240,2),(329,240,3),(433,240,5),(158,241,1),(135,241,2),(438,241,5),(148,242,1),(106,242,2),(313,242,3),(743,242,5),(145,243,1),(113,243,2),(306,243,3),(382,243,5),(143,244,1),(104,244,2),(308,244,3),(383,244,5),(151,245,1),(105,245,2),(307,245,3),(386,245,5),(146,246,1),(108,246,2),(314,246,3),(154,247,1),(111,247,2),(305,247,3),(115,248,2),(304,248,3),(389,248,5),(153,249,1),(303,249,3),(396,249,5),(147,250,1),(112,250,2),(302,250,3),(745,250,5),(144,251,1),(102,251,2),(312,251,3),(388,251,5),(155,252,1),(107,252,2),(315,252,3),(391,252,5),(152,253,1),(110,253,2),(311,253,3),(744,253,5),(141,254,1),(109,254,2),(395,254,5),(150,255,1),(101,255,2),(316,255,3),(390,255,5),(149,256,1),(114,256,2),(310,256,3),(394,256,5),(142,257,1),(103,257,2),(309,257,3),(393,257,5),(387,258,5),(174,262,1),(117,262,2),(333,262,3),(403,262,5),(180,263,1),(125,263,2),(334,263,3),(397,263,5),(177,264,1),(124,264,2),(402,264,5),(120,265,2),(335,265,3),(400,265,5),(175,266,1),(332,266,3),(401,266,5),(179,267,1),(339,267,3),(406,267,5),(181,268,1),(122,268,2),(337,268,3),(404,268,5),(173,269,1),(119,269,2),(338,269,3),(172,270,1),(121,270,2),(340,270,3),(116,271,2),(336,271,3),(398,271,5),(171,272,1),(118,272,2),(341,272,3),(405,272,5),(178,273,1),(123,273,2),(399,273,5);
/*!40000 ALTER TABLE `alcpt_question_used_to` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_squadron`
--

DROP TABLE IF EXISTS `alcpt_squadron`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_squadron` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_squadron`
--

LOCK TABLES `alcpt_squadron` WRITE;
/*!40000 ALTER TABLE `alcpt_squadron` DISABLE KEYS */;
INSERT INTO `alcpt_squadron` VALUES (1,'學生一中隊'),(3,'學生三中隊'),(2,'學生二中隊'),(4,'學生四中隊');
/*!40000 ALTER TABLE `alcpt_squadron` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_student`
--

DROP TABLE IF EXISTS `alcpt_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grade` smallint(5) unsigned NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `squadron_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `alcpt_student_department_id_257bfbd3_fk_alcpt_department_id` (`department_id`),
  KEY `alcpt_student_squadron_id_4bbcc05a_fk_alcpt_squadron_id` (`squadron_id`),
  CONSTRAINT `alcpt_student_department_id_257bfbd3_fk_alcpt_department_id` FOREIGN KEY (`department_id`) REFERENCES `alcpt_department` (`id`),
  CONSTRAINT `alcpt_student_squadron_id_4bbcc05a_fk_alcpt_squadron_id` FOREIGN KEY (`squadron_id`) REFERENCES `alcpt_squadron` (`id`),
  CONSTRAINT `alcpt_student_user_id_c43c5a79_fk_alcpt_user_id` FOREIGN KEY (`user_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_student`
--

LOCK TABLES `alcpt_student` WRITE;
/*!40000 ALTER TABLE `alcpt_student` DISABLE KEYS */;
INSERT INTO `alcpt_student` VALUES (1,108,2,3,1),(2,108,2,3,2),(3,108,2,3,4),(4,108,2,3,3),(5,108,2,3,5),(6,108,2,3,6),(7,108,2,3,8),(8,108,2,3,7),(9,108,2,3,9),(10,108,1,4,10),(11,108,1,4,11),(12,108,2,3,12),(13,108,2,3,13),(14,108,1,4,14),(15,108,1,4,15),(16,108,2,3,16),(17,109,2,1,17),(18,108,2,3,18),(19,108,2,3,19),(20,108,1,3,20),(22,108,2,3,22);
/*!40000 ALTER TABLE `alcpt_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_testpaper`
--

DROP TABLE IF EXISTS `alcpt_testpaper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_testpaper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `valid` tinyint(1) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `alcpt_testpaper_created_by_id_def16d7a_fk_alcpt_user_id` (`created_by_id`),
  CONSTRAINT `alcpt_testpaper_created_by_id_def16d7a_fk_alcpt_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_testpaper`
--

LOCK TABLES `alcpt_testpaper` WRITE;
/*!40000 ALTER TABLE `alcpt_testpaper` DISABLE KEYS */;
INSERT INTO `alcpt_testpaper` VALUES (1,'109','2019-05-19 20:08:58.486983','2019-05-22 14:08:11.816656',0,1),(2,'新題庫測試','2019-05-22 14:07:21.596682','2019-05-22 14:08:58.441707',1,1),(3,'測試用','2019-05-23 02:23:37.950557','2019-05-23 02:23:46.078503',1,1),(5,'yang_test','2019-10-08 03:24:10.028486','2019-11-11 06:47:07.925407',1,1);
/*!40000 ALTER TABLE `alcpt_testpaper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_user`
--

DROP TABLE IF EXISTS `alcpt_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `reg_id` varchar(10) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `gender` smallint(5) unsigned DEFAULT NULL,
  `priviledge` smallint(5) unsigned NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial_number` (`reg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_user`
--

LOCK TABLES `alcpt_user` WRITE;
/*!40000 ALTER TABLE `alcpt_user` DISABLE KEYS */;
INSERT INTO `alcpt_user` VALUES (1,'pbkdf2_sha256$36000$3CdXe9nun0bo$/CdhvLoZcUEOE153Utb3qCNn2H23mVpPkJPUpoSibBU=','2019-11-11 08:42:09.104202','1080630206','許彥彬',0,63,'2019-05-19 15:02:57.619462','2019-05-19 18:17:09.717782'),(2,'pbkdf2_sha256$36000$jMbqVr27p6dw$AX9ATDIosZbbNQKFrVSBS8FnJn9ZMp6aBXiXLyWH1os=','2019-05-19 19:03:33.119334','1080630204','李維哲',0,15,'2019-05-19 16:16:55.674036','2019-05-19 18:19:15.435515'),(3,'pbkdf2_sha256$36000$pyVLfHCN9PSB$cyUYesdenxc1QY6S96Se7KSHpDMpbBneewAqDkt0i3s=',NULL,'1080630201','王泓勛',0,3,'2019-05-19 18:18:12.241000','2019-05-19 18:18:35.996244'),(4,'pbkdf2_sha256$36000$SVjmLMW1pKAz$zUHB1MjQ59284seh0+nQ4snW+eajfdzGBHnT2Bqfqz8=',NULL,'1080630202','Marco',0,25,'2019-05-19 18:18:12.241946','2019-05-19 18:18:54.156864'),(5,'pbkdf2_sha256$36000$7Dt75nanE7Y5$zcKe4NckS5mxahwXTMElvhCCsp3AYejzJe9xNXOdlRw=',NULL,'1080630203','王偉學',0,1,'2019-05-19 18:18:12.241999','2019-05-19 18:19:07.971534'),(6,'pbkdf2_sha256$36000$TbuY5Jvzih3p$dtNie1Fxnyw4wNdMwz/DWZoPJK/tly/I/kZBtg8eLBU=','2019-05-20 01:54:31.780195','1080630205','許冠浤',0,25,'2019-05-19 18:18:12.242049','2019-05-19 18:19:30.889497'),(7,'pbkdf2_sha256$36000$NfncGfi6kVgc$RJN1pUEPE4DJRKTivnlQo22Jhf4mLCTAZkaEvbpkm0w=',NULL,'1080630207','黃僊晉',0,1,'2019-05-19 18:19:57.563657','2019-05-19 18:20:52.416391'),(8,'pbkdf2_sha256$36000$x1ZGBl6HcLLH$mIbz/qD+y1VBklCvsQtEzCip1uZRs32Z99FsIcLy/6A=',NULL,'1080630208','楊椗鎮',0,1,'2019-05-19 18:19:57.563739','2019-05-19 18:20:24.073200'),(9,'pbkdf2_sha256$36000$K2mqimvn44PQ$uBp7/D1bJQ1iTLXvPdqyma2U1sm7I46Hg2R49/f/0V8=',NULL,'1080630209','劉瑋丞',0,1,'2019-05-19 18:19:57.563792','2019-05-19 18:21:09.938816'),(10,'pbkdf2_sha256$36000$ON5Egpz8pNev$CMWScLWa/kYiCYw1nX5hTWQ6AUQGdNO+tmbe85aeH1Y=',NULL,'1080630101','曾阿成',0,1,'2019-05-19 18:21:34.033310','2019-05-19 18:21:53.916407'),(11,'pbkdf2_sha256$36000$kjp7YKkywXau$YLVarKQZSorZK8cDT7ph6hFybH7u0BRHZneYT6puRwU=',NULL,'1080630102','吳船震',0,1,'2019-05-19 18:21:34.033392','2019-05-19 18:23:21.363239'),(12,'pbkdf2_sha256$36000$Il3ZJXTMrgCt$O7Johhnd8iD/cPQNWAkmETyLomU567NhITO6QZEelCg=','2019-10-24 06:22:02.500828','1080630103','何日雲',0,5,'2019-05-19 18:24:01.585138','2019-10-24 06:21:47.435066'),(13,'pbkdf2_sha256$36000$P7beRAdRkxzP$GQhNpv0Es3y0A8FriF4AL7Vl0XyGV/XTmN7S4mwn4tQ=',NULL,'1080630104','盧蔣暉',0,1,'2019-05-19 18:24:01.585218','2019-05-20 00:39:43.377757'),(14,'pbkdf2_sha256$36000$AH4AN3cigGmk$XQbaZMJqTbIhxonLjYjwMhf02SlYLpH106kraT9DP58=',NULL,'1080630105','將冠廷',0,1,'2019-05-19 18:24:01.585270','2019-05-19 18:26:55.439138'),(15,'pbkdf2_sha256$36000$Hxm7voqi5tNo$Dj+Zz8XNeyxj726cc1yzLAkWt5jIUi2MFwIcLrTbfqw=',NULL,'1080630106','張髒唐',0,1,'2019-05-19 18:24:01.585320','2019-05-19 18:27:25.910908'),(16,'pbkdf2_sha256$36000$rphqZzJbyjIv$ynEMJSQouhkVRWKNOdni5rCi/1e+iDCKDnA9VGbObzU=',NULL,'1090630201','王媛媛',0,1,'2019-05-19 18:27:53.635760','2019-05-20 00:39:09.850398'),(17,'pbkdf2_sha256$36000$USQzpOonV8zJ$yqyBHrhQ0BU+dYOyC/i1iEvJF1hlyoHhJ03z5bGOUfw=',NULL,'1090630202','李壽子',0,1,'2019-05-19 18:27:53.635843','2019-05-19 18:43:30.086179'),(18,'pbkdf2_sha256$36000$CpNflZtCSOGR$ML5reVajFsS3I9hxXJTcQfyEwwKm+dKbqWkdJS4oEfo=',NULL,'1090630203','張大智',0,1,'2019-05-19 18:27:53.635895','2019-05-20 00:38:48.416361'),(19,'pbkdf2_sha256$36000$c3sqFFSKPiNX$YjyovMokt+8tlHrHxeoak75IIZY4MCUFVvoVai0a0dg=','2019-10-13 03:07:40.935282','1090630204','chichi',0,1,'2019-05-19 18:27:53.635945','2019-10-08 03:33:31.628555'),(20,'pbkdf2_sha256$36000$yoX8FUYBKEBE$0SpUdzLVt1A+ipbOutYamo03sVbKui4P3YelCIlialU=','2019-05-19 20:08:08.429410','mcndu01','教師',0,27,'2019-05-19 18:41:47.152589','2019-05-19 18:42:18.440312'),(22,'pbkdf2_sha256$36000$4zEHqf8SAJFQ$OKTlAhNLNfeYxlM107ZYk9LDhOy+SsndWBQx5N2QwBY=','2019-11-07 09:58:28.897822','1090630218','蘇典煒',0,1,'2019-10-15 12:44:32.551175','2019-11-11 08:42:16.733551');
/*!40000 ALTER TABLE `alcpt_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add user',6,'add_user'),(17,'Can change user',6,'change_user'),(18,'Can delete user',6,'delete_user'),(19,'Can add answer sheet',7,'add_answersheet'),(20,'Can change answer sheet',7,'change_answersheet'),(21,'Can delete answer sheet',7,'delete_answersheet'),(22,'Can add department',8,'add_department'),(23,'Can change department',8,'change_department'),(24,'Can delete department',8,'delete_department'),(25,'Can add exam',9,'add_exam'),(26,'Can change exam',9,'change_exam'),(27,'Can delete exam',9,'delete_exam'),(28,'Can add group',10,'add_group'),(29,'Can change group',10,'change_group'),(30,'Can delete group',10,'delete_group'),(31,'Can add proclamation',11,'add_proclamation'),(32,'Can change proclamation',11,'change_proclamation'),(33,'Can delete proclamation',11,'delete_proclamation'),(34,'Can add question',12,'add_question'),(35,'Can change question',12,'change_question'),(36,'Can delete question',12,'delete_question'),(37,'Can add squadron',13,'add_squadron'),(38,'Can change squadron',13,'change_squadron'),(39,'Can delete squadron',13,'delete_squadron'),(40,'Can add student',14,'add_student'),(41,'Can change student',14,'change_student'),(42,'Can delete student',14,'delete_student'),(43,'Can add test paper',15,'add_testpaper'),(44,'Can change test paper',15,'change_testpaper'),(45,'Can delete test paper',15,'delete_testpaper');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_alcpt_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_alcpt_user_id` FOREIGN KEY (`user_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(7,'alcpt','answersheet'),(8,'alcpt','department'),(9,'alcpt','exam'),(10,'alcpt','group'),(11,'alcpt','proclamation'),(12,'alcpt','question'),(13,'alcpt','squadron'),(14,'alcpt','student'),(15,'alcpt','testpaper'),(6,'alcpt','user'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-10-31 07:33:22.174178'),(2,'alcpt','0001_initial','2019-10-31 07:33:22.987857'),(3,'admin','0001_initial','2019-10-31 07:33:23.071798'),(4,'admin','0002_logentry_remove_auto_add','2019-10-31 07:33:23.096803'),(5,'contenttypes','0002_remove_content_type_name','2019-10-31 07:33:23.161696'),(6,'auth','0001_initial','2019-10-31 07:33:23.298771'),(7,'auth','0002_alter_permission_name_max_length','2019-10-31 07:33:23.328990'),(8,'auth','0003_alter_user_email_max_length','2019-10-31 07:33:23.337981'),(9,'auth','0004_alter_user_username_opts','2019-10-31 07:33:23.346740'),(10,'auth','0005_alter_user_last_login_null','2019-10-31 07:33:23.356079'),(11,'auth','0006_require_contenttypes_0002','2019-10-31 07:33:23.360714'),(12,'auth','0007_alter_validators_add_error_messages','2019-10-31 07:33:23.367300'),(13,'auth','0008_alter_user_username_max_length','2019-10-31 07:33:23.375523'),(14,'sessions','0001_initial','2019-10-31 07:33:23.401222');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('1uxa79fsdwijlg7ykbnfj40c0ragkqd1','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-11-20 13:14:47.649102'),('29pgofya402cz34vvu2o2p11x6jua1tw','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-11-19 13:50:38.016336'),('3yzmrl3s5mncb5i29ijd3zf92n05tlqw','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-10-14 14:25:41.368576'),('4gw5u2f4gxiwgqply3htv8klpvsdfbbx','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-10-22 03:36:15.395173'),('4o3vx4yni3kftfcewz504dfxehyk1pb3','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-10-29 12:45:07.656493'),('75o7gadxl5zf473l8nbeiu32znd9o68b','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-11-06 15:37:15.534564'),('8eu2bd77gsu03fxjw52aqw7hi88t4cld','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-10-30 15:27:56.648000'),('92pzctheyedb1qwb9zys8t54bj615y4r','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-10-27 08:56:57.143746'),('a67wqw74udtv12fpgafi7ch66cxogxr9','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-10-28 15:17:52.359631'),('agjyl61alvsk0m57y9t982jndg8e69dr','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-06-03 00:50:48.473330'),('cj9yxh4fei1ka48g9xgzpfru8cwcal7m','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-06-03 01:58:17.383339'),('d12rle9u7g8aqt2h49ta1knoky3zn1fy','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-10-16 15:37:42.952692'),('d2o6hzhddhtre0ui7nippn0reha9qd77','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-10-14 16:30:57.622142'),('decxuih1nqfb6sif37vvt7h2nzbdu79g','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-11-07 02:33:29.310091'),('hgn18kplt3gpnr56sv8dasiaw9z9o3wo','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-11-14 14:13:45.043870'),('ishaodik4vf3ctrjzic7l74ioa7au41a','MTVlN2NhMmQ2MWY1MTVmODgyMTA4YTU5ODgwNjM2YjNjOTViMjMyYjp7Il9hdXRoX3VzZXJfaWQiOiI2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmMmQ2NTlhZTRhNWI0N2M2MGVlNmE5YTE4YmYxNjQ2ZTQyOTI1NjI4In0=','2019-06-03 01:12:10.093297'),('k6k8j9kmyiss2lctcf7c3yqqypk3anmy','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-11-15 05:11:25.069940'),('l1edmm249xlmfcseh6by3uarqtxdpnre','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-10-12 04:12:41.442712'),('nusytmdtlj8a42a06nbcujzqu10ukrha','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-06-03 01:42:56.568439'),('oi5qxdju1gedx3nzg4cjb8g9nuf9qqrq','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-06-03 00:50:48.057376'),('p7s0nf3cp386qmqgw28ym2tlsuwx25eg','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-06-02 20:08:46.933132'),('qqjlg9yd365q9l3u6sskrevdzfo445dq','ZmYwYjEwNjMyNTdjMGM2NzUxNTdhNjQwNGIyNjc1ZDkzYTkwYWJlZDp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzExNTI0MzIwMGYyMjZjMDY3ZGY3NTc5ODY2MGZkMDk2NDg3Njc0NyJ9','2019-11-07 06:22:02.503328'),('rdyffu7xxl7owt4smazffa8xnjwy2nsi','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-06-05 13:06:44.234721'),('tkf6j08lvuhdd21ort7n0lnnpbnixn2s','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-10-12 06:20:38.779654'),('uaaw1pf5ca4dfgenjrn694qwtkqzjnyz','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-11-25 08:42:09.106388'),('uxbcvwtkiefk4gat37tbchuao1ekrk8c','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-11-17 14:32:04.647061'),('xnag26ab7zbg65v4mwfoonwpw68pd5po','OTE2MWQwYzBlMWUxZGE5ZDc5OWM3OWIyYzY5NTdkZGYxODY5YzkyODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyYTNmZGQ2MGExZmFiNjBlNGYyNGYzNzhmZGMwMDA1MDE1YTZiNWQ5In0=','2019-11-21 02:58:27.496586');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-11 17:53:33
