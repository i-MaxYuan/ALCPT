-- MySQL dump 10.13  Distrib 8.0.18, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: alcpt2
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
-- Table structure for table `alcpt_answer`
--

DROP TABLE IF EXISTS `alcpt_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `selected` smallint(6) NOT NULL,
  `answer_sheet_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alcpt_answer_answer_sheet_id_c4fe1234_fk_alcpt_answersheet_id` (`answer_sheet_id`),
  KEY `alcpt_answer_question_id_af4ab1ab_fk_alcpt_question_id` (`question_id`),
  CONSTRAINT `alcpt_answer_answer_sheet_id_c4fe1234_fk_alcpt_answersheet_id` FOREIGN KEY (`answer_sheet_id`) REFERENCES `alcpt_answersheet` (`id`),
  CONSTRAINT `alcpt_answer_question_id_af4ab1ab_fk_alcpt_question_id` FOREIGN KEY (`question_id`) REFERENCES `alcpt_question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=268 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_answer`
--

LOCK TABLES `alcpt_answer` WRITE;
/*!40000 ALTER TABLE `alcpt_answer` DISABLE KEYS */;
INSERT INTO `alcpt_answer` VALUES (2,1,3,46),(3,2,3,30),(4,3,3,44),(5,1,3,45),(6,2,3,5),(7,1,3,43),(8,3,3,41),(9,1,3,1),(10,2,3,48),(11,4,3,47),(12,2,4,3),(13,2,4,2),(14,3,4,23),(15,1,4,6),(16,4,5,35),(17,2,5,44),(18,1,5,40),(19,1,5,32),(20,4,5,5),(21,4,5,34),(22,1,5,37),(23,3,5,33),(24,1,5,48),(25,2,5,47),(26,4,6,35),(27,2,6,44),(28,2,6,45),(29,4,6,29),(30,2,6,43),(31,3,6,41),(32,2,6,34),(33,1,6,42),(34,2,6,48),(35,3,6,47),(36,4,7,35),(37,2,7,36),(38,2,7,30),(39,2,7,44),(40,1,7,32),(41,4,7,29),(42,4,7,34),(43,3,7,1),(44,2,7,42),(45,1,7,48),(46,4,8,35),(47,2,8,46),(48,2,8,3),(49,2,8,2),(50,3,8,23),(51,2,8,43),(52,3,8,41),(53,1,8,48),(54,1,8,6),(68,1,10,35),(69,1,10,46),(70,1,10,36),(71,1,10,30),(72,1,10,60),(73,1,10,31),(74,1,10,5),(75,1,10,41),(76,1,10,34),(77,1,10,42),(88,1,12,46),(89,1,12,36),(90,1,12,44),(91,1,12,32),(92,1,12,5),(93,1,12,29),(94,1,12,34),(95,1,12,1),(96,1,12,33),(97,1,12,47),(98,2,13,3),(99,1,13,72),(100,3,13,58),(101,4,13,89),(102,3,13,73),(103,2,13,53),(104,3,13,113),(105,3,13,68),(106,2,13,54),(107,1,13,6),(108,1,14,35),(109,1,14,60),(110,1,14,31),(111,1,14,32),(112,1,14,45),(113,1,14,5),(114,1,14,43),(115,1,14,37),(116,1,14,33),(117,1,14,42),(118,1,15,135),(119,2,15,133),(120,3,15,141),(121,4,15,137),(122,3,15,131),(123,2,15,125),(124,1,15,142),(125,2,15,148),(126,3,15,127),(127,4,15,149),(128,1,16,65),(129,1,16,72),(130,1,16,108),(131,1,16,105),(132,1,16,51),(133,1,16,88),(134,1,16,113),(135,1,16,117),(136,1,16,70),(137,1,16,6),(138,1,17,137),(139,1,17,146),(140,1,17,147),(141,1,17,149),(142,1,17,148),(143,1,17,139),(144,1,17,140),(145,1,17,28),(146,1,17,134),(147,1,17,130),(148,4,18,35),(149,4,18,36),(150,1,18,74),(151,1,18,55),(152,2,18,2),(153,2,18,30),(154,1,18,40),(155,1,18,23),(156,1,18,108),(157,4,18,105),(158,1,18,60),(159,1,18,64),(160,2,18,78),(161,3,18,84),(162,4,18,31),(163,2,18,45),(164,2,18,117),(165,3,18,50),(166,2,18,68),(167,3,18,5),(168,2,18,29),(169,2,18,41),(170,2,18,34),(171,3,18,33),(172,3,18,42),(173,1,18,48),(174,2,18,85),(175,2,18,107),(176,1,18,47),(177,1,18,83),(178,1,19,48),(179,1,19,1),(180,1,19,44),(181,1,19,40),(182,2,19,34),(183,3,19,43),(184,1,19,60),(185,4,19,31),(186,2,19,47),(187,4,19,32),(188,3,20,146),(189,3,20,128),(190,1,20,152),(191,1,20,147),(192,2,20,140),(193,2,20,142),(194,2,20,148),(195,3,20,133),(196,3,20,143),(197,1,20,154),(198,1,21,125),(199,1,21,147),(200,1,21,128),(201,1,21,148),(202,1,21,129),(203,2,22,147),(204,3,22,125),(205,3,22,128),(206,2,22,148),(207,2,22,129),(213,1,24,125),(214,1,24,129),(215,2,24,128),(216,2,24,148),(217,3,24,147),(218,2,25,70),(219,2,25,71),(220,1,25,99),(221,1,25,105),(222,4,25,92),(223,2,25,113),(224,2,25,79),(225,3,25,117),(226,1,25,78),(227,2,25,93),(228,1,26,102),(229,1,26,104),(230,2,26,91),(231,2,26,75),(232,3,26,82),(233,3,26,92),(234,4,26,86),(235,4,26,114),(236,1,26,93),(237,1,26,62),(238,1,27,111),(239,1,27,64),(240,1,27,59),(241,1,27,58),(242,1,27,62),(243,1,27,49),(244,1,27,23),(245,1,27,89),(246,1,27,81),(247,1,27,6),(248,1,28,71),(249,2,28,58),(250,-1,28,93),(251,1,28,61),(252,1,28,100),(253,-1,28,107),(254,1,28,79),(255,-1,28,3),(256,-1,28,98),(257,3,28,51),(258,2,29,173),(259,2,29,268),(260,-1,29,134),(261,-1,29,215),(262,-1,29,126),(263,2,29,158),(264,-1,29,160),(265,-1,29,209),(266,1,29,269),(267,-1,29,186);
/*!40000 ALTER TABLE `alcpt_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_answersheet`
--

DROP TABLE IF EXISTS `alcpt_answersheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_answersheet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `finish_time` datetime(6) NOT NULL,
  `is_finished` tinyint(1) NOT NULL,
  `score` smallint(5) unsigned DEFAULT NULL,
  `exam_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alcpt_answersheet_exam_id_147bc9a1_fk_alcpt_exam_id` (`exam_id`),
  KEY `alcpt_answersheet_user_id_8e290a44_fk_alcpt_student_id` (`user_id`),
  CONSTRAINT `alcpt_answersheet_exam_id_147bc9a1_fk_alcpt_exam_id` FOREIGN KEY (`exam_id`) REFERENCES `alcpt_exam` (`id`),
  CONSTRAINT `alcpt_answersheet_user_id_8e290a44_fk_alcpt_student_id` FOREIGN KEY (`user_id`) REFERENCES `alcpt_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_answersheet`
--

LOCK TABLES `alcpt_answersheet` WRITE;
/*!40000 ALTER TABLE `alcpt_answersheet` DISABLE KEYS */;
INSERT INTO `alcpt_answersheet` VALUES (3,'2019-12-19 08:08:49.682437',1,30,10,1),(4,'2019-12-19 12:53:43.225769',1,100,11,1),(5,'2019-12-19 13:00:32.849824',1,70,12,1),(6,'2019-12-19 13:02:52.619729',1,60,13,1),(7,'2019-12-20 05:26:05.974108',1,70,14,1),(8,'2019-12-20 05:31:26.777265',1,88,15,1),(10,'2019-12-28 16:10:19.618454',1,0,17,1),(12,'2019-12-31 06:14:53.903686',1,10,20,1),(13,'2019-12-31 06:36:18.745224',1,30,21,1),(14,'2019-12-31 07:24:29.011369',1,20,22,1),(15,'2019-12-31 07:26:28.135653',1,30,23,1),(16,'2019-12-31 07:36:34.963078',1,30,24,1),(17,'2019-12-31 07:54:36.553581',1,50,25,1),(18,'2020-01-04 01:22:33.038463',1,26,1,1),(19,'2020-01-04 02:48:08.026621',1,20,26,1),(20,'2020-01-04 12:35:08.661738',1,40,27,1),(21,'2020-01-04 13:50:23.388841',1,40,1,15),(22,'2020-01-04 14:59:28.040552',1,0,1,18),(24,'2020-01-04 21:21:14.959550',1,0,1,17),(25,'2020-01-04 21:29:47.216073',1,30,28,17),(26,'2020-01-04 23:51:55.595932',1,20,29,18),(27,'2020-01-05 00:08:00.882904',1,50,30,1),(28,'2020-01-05 21:25:02.119675',0,NULL,31,1),(29,'2020-01-13 11:38:58.118559',0,NULL,32,1);
/*!40000 ALTER TABLE `alcpt_answersheet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_choice`
--

DROP TABLE IF EXISTS `alcpt_choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_choice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `c_content` varchar(255) NOT NULL,
  `is_answer` tinyint(1) NOT NULL,
  `question_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alcpt_choice_question_id_cdc3736d_fk_alcpt_question_id` (`question_id`),
  CONSTRAINT `alcpt_choice_question_id_cdc3736d_fk_alcpt_question_id` FOREIGN KEY (`question_id`) REFERENCES `alcpt_question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1197 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_choice`
--

LOCK TABLES `alcpt_choice` WRITE;
/*!40000 ALTER TABLE `alcpt_choice` DISABLE KEYS */;
INSERT INTO `alcpt_choice` VALUES (1,'officer',0,1),(2,'officers',0,1),(3,'a officer',0,1),(4,'an officer',1,1),(5,'ICBM',0,2),(6,'IRBM',1,2),(7,'MRBM',0,2),(8,'SRBM',0,2),(9,'machine gun',0,3),(10,'pistol',1,3),(11,'grenade',0,3),(12,'tank',0,3),(17,'wear',0,5),(18,'had worn',1,5),(19,'wears',0,5),(20,'wearing',0,5),(21,'infantrymen',1,6),(22,'artillerymen',0,6),(23,'paratrooper',0,6),(24,'scout',0,6),(65,'Urban Operations',0,23),(66,'Engineers',0,23),(67,'engagement',1,23),(68,'Armor',0,23),(69,'鄧紫棋',1,28),(70,'林宥嘉',0,28),(71,'吳青峰',0,28),(72,'華晨宇',0,28),(89,'that',0,29),(90,'and',0,29),(91,'but',0,29),(92,'because',1,29),(93,'during',0,30),(94,'since',0,30),(95,'between',0,30),(96,'for',1,30),(97,'likes',0,31),(98,'like',1,31),(99,'are like',0,31),(100,'were alike',0,31),(101,'see',1,32),(102,'sees',0,32),(103,'saw',0,32),(104,'had seen',0,32),(105,'listen to',0,33),(106,'listens by',0,33),(107,'to listen',0,33),(108,'listening to',1,33),(109,'if',0,34),(110,'unless',0,34),(111,'that',0,34),(112,'so',1,34),(113,'May',0,35),(114,'Could',0,35),(115,'If',0,35),(116,'Would',1,35),(117,'did',0,36),(118,'had to',0,36),(119,'ought to',1,36),(120,'would',0,36),(121,'for',1,37),(122,'since',0,37),(123,'during',0,37),(124,'until',0,37),(133,'couldn\'t see very far',1,40),(134,'didn\'t have much money',0,40),(135,'was sick',0,40),(136,'made a bad grade',0,40),(137,'last',0,41),(138,'lowest',0,41),(139,'first',1,41),(140,'slower',0,41),(141,'What',0,42),(142,'It',1,42),(143,'She',0,42),(144,'He',0,42),(145,'for downtown',0,43),(146,'downtown',1,43),(147,'at downtown',0,43),(148,'into downtown',0,43),(149,'good',0,44),(150,'better',1,44),(151,'nice',0,44),(152,'best',0,44),(153,'consider',0,45),(154,'considering',1,45),(155,'considered',0,45),(156,'considers',0,45),(157,'Will use',0,46),(158,'Use',0,46),(159,'To use',1,46),(160,'Using',0,46),(161,'at',0,47),(162,'for',0,47),(163,'during',0,47),(164,'with',1,47),(165,'have',1,48),(166,'had',0,48),(167,'has',0,48),(168,'having',0,48),(169,'rifle',1,49),(170,'commander',0,49),(171,'grenade',0,49),(172,'pistol',0,49),(173,'rifles',0,50),(174,'surrenders',0,50),(175,'service pistols',1,50),(176,'bullets',0,50),(177,'large',0,51),(178,'designed',0,51),(179,'indirect',0,51),(180,'portable',1,51),(181,'They use smoothbore machine guns.',1,52),(182,'They use tracks to travel over rough land.',0,52),(183,'They use three different types of weapons.',0,52),(184,'They can aim their weapons automatically.',0,52),(185,'disappointed',1,53),(186,'satisfied',0,53),(187,'cheerful',0,53),(188,'capable',0,53),(189,'complicated',1,54),(190,'energetic',0,54),(191,'extravagant',0,54),(192,'intelligent',0,54),(193,'cherished',0,55),(194,'easygoing',0,55),(195,'flexible',0,55),(196,'negative',1,55),(197,'is lacking an address',0,56),(198,'is lost among my papers',0,56),(199,'requires your urgent comment',1,56),(200,'has been posted as you requested',0,56),(201,'rented out lately',0,57),(202,'seriously deteriorating',1,57),(203,'well-cared by its tenants',0,57),(204,'unfortunately occupied',0,57),(205,'debated',1,58),(206,'alternated',0,58),(207,'founded',0,58),(208,'inherited',0,58),(209,'discipline',0,59),(210,'facility',0,59),(211,'privacy',1,59),(212,'representation',0,59),(213,'eager',0,60),(214,'liberal ',0,60),(215,'mean',1,60),(216,'inferior',0,60),(217,'conveyed',0,61),(218,'associated',0,61),(219,'interpreted',0,61),(220,'predicted',1,61),(221,'landmarks',0,62),(222,'restrictions',1,62),(223,'percentages',0,62),(224,'circumstances',0,62),(225,'advised',0,63),(226,'occupied',0,63),(227,'proposed',1,63),(228,'recognized',0,63),(229,' sociable',0,64),(230,' expressive',1,64),(231,' reasonable',0,64),(232,' objective',0,64),(233,' particularly',1,65),(234,'sensibly',0,65),(235,'moderately',0,65),(236,' considerably',0,65),(237,' stumble',1,66),(238,' graze',0,66),(239,'navigate',0,66),(240,' dwell',0,66),(241,' initial ',0,67),(242,' annual',1,67),(243,' evident',0,67),(244,' occasional',0,67),(245,' factors',1,68),(246,'outcomes',0,68),(247,' missions',0,68),(248,' identities',0,68),(249,' distantly',0,69),(250,' meaningfully',0,69),(251,' cheerfully',0,69),(252,' vividly',1,69),(253,'napping',0,70),(254,' scooping',0,70),(255,'flipping',0,70),(256,' chirping',1,70),(257,' benefit',0,71),(258,' contact',1,71),(259,' gesture',0,71),(260,' favor',0,71),(261,' causal',0,72),(262,'durable',0,72),(263,' manual ',1,72),(264,'violent',0,72),(265,' mature',0,73),(266,' usual',0,73),(267,' seasonal',1,73),(268,' particular',0,73),(269,' requirements',1,74),(270,' techniques',0,74),(271,' situations',0,74),(272,'principles',0,74),(273,' distribute',0,75),(274,' fulfill',1,75),(275,' convince',0,75),(276,'monitor',0,75),(277,' chilly',0,76),(278,' liberal',0,76),(279,' hollow',1,76),(280,' definite',0,76),(281,'slipped',0,77),(282,'dumped',0,77),(283,' twisted',1,77),(284,'recovered',0,77),(285,' decisions',0,78),(286,' beliefs',1,78),(287,' styles',0,78),(288,' degrees',0,78),(289,' persuasive',0,79),(290,' tolerable',0,79),(291,' suspicious',0,79),(292,' demanding',1,79),(293,' anxiously',1,80),(294,' precisely',0,80),(295,'evidently',0,80),(296,' distinctly',0,80),(297,' deposited',0,81),(298,' reserved',0,81),(299,' vanished',0,81),(300,' surrounded',1,81),(301,' credit',0,82),(302,' impress',1,82),(303,' relieve',0,82),(304,' acquire',0,82),(305,' flake',0,83),(306,' blossom',0,83),(307,' blanket',1,83),(308,' flash',0,83),(309,' angles',0,84),(310,' margins',1,84),(311,' exceptions',0,84),(312,' limitations',0,84),(313,' hardship',0,85),(314,'comment',0,85),(315,' bargain',0,85),(316,'penalty',1,85),(317,' conducted',1,86),(318,' confirmed',0,86),(319,' implied',0,86),(320,' improved',0,86),(321,' efficient',0,87),(322,' reliable',0,87),(323,'massive',1,87),(324,' adequate',0,87),(325,' tenderly',0,88),(326,' properly',1,88),(327,' solidly',0,88),(328,' favorably',0,88),(329,'pursue',1,89),(330,'swear',0,89),(331,' reserve',0,89),(332,'draft',0,89),(333,' native',1,90),(334,'tricky',0,90),(335,' remote',0,90),(336,'vacant',0,90),(337,' appoint',0,91),(338,'eliminate',0,91),(339,' occupy',0,91),(340,' identify',1,91),(341,'relaxing',0,92),(342,' embarrassing',1,92),(343,' appealing',0,92),(344,' defending',0,92),(345,' barely',1,93),(346,' fairly',0,93),(347,' merely',0,93),(348,'readily',0,93),(349,' guide',0,94),(350,' trace',1,94),(351,' code',0,94),(352,'print',0,94),(353,' accessed',0,95),(354,' edited',0,95),(355,' imposed',0,95),(356,' urged',1,95),(357,'constitutions',0,96),(358,'objections',0,96),(359,' sculptures',1,96),(360,'adventures',0,96),(361,' dip',0,97),(362,' beam',1,97),(363,' spark',0,97),(364,' path',0,97),(365,' enclosed',1,98),(366,' installed',0,98),(367,' preserved',0,98),(368,' rewarded',0,98),(369,' signal',0,99),(370,'glory',0,99),(371,'medal',1,99),(372,' profit',0,99),(373,'balanced',0,100),(374,' calculated',0,100),(375,'disguised',1,100),(376,' registered',0,100),(377,' aware',1,101),(378,'ashamed',0,101),(379,'doubtful',0,101),(380,'guilty',0,101),(381,' innocence',0,102),(382,' estimation',0,102),(383,'assurance',0,102),(384,'observation',1,102),(385,' journey',0,103),(386,' traffic',0,103),(387,' concert',1,103),(388,'record',0,103),(389,' awful',0,104),(390,' drowsy',0,104),(391,' tragic',0,104),(392,' upset',1,104),(393,' accent',1,105),(394,' identity',0,105),(395,'gratitude',0,105),(396,'signature',0,105),(397,' ceased',0,106),(398,' committed',0,106),(399,' confined',1,106),(400,' conveyed',0,106),(401,' injury',1,107),(402,' offense',0,107),(403,'sacrifice',0,107),(404,' victim',0,107),(405,'security',0,108),(406,'maturity',0,108),(407,' facility',0,108),(408,' generosity',1,108),(409,' tolerates',0,109),(410,' associates',0,109),(411,' demonstrates',1,109),(412,'exaggerates',0,109),(413,'durable',0,110),(414,'private',0,110),(415,'realistic',0,110),(416,'numerous',1,110),(417,'Occasionally',1,111),(418,'Automatically',0,111),(419,'Enormously',0,111),(420,' Innocently',0,111),(421,' isolation',0,112),(422,' promotion',0,112),(423,' retirement',1,112),(424,' announcement',0,112),(425,' alert',0,113),(426,' itchy',1,113),(427,'steady',0,113),(428,' flexible',0,113),(429,' conquered',1,114),(430,'estimated',0,114),(431,' guaranteed',0,114),(432,' intensified',0,114),(433,' ruined',1,115),(434,'cracked',0,115),(435,'hastened',0,115),(436,'neglected',0,115),(437,' primitive',0,116),(438,'spiritual',0,116),(439,' representative',1,116),(440,' informative',0,116),(441,' liberally',0,117),(442,'individually',0,117),(443,'financially',0,117),(444,'environmentally',1,117),(473,'when there is no danger',0,125),(474,'when the building is on fire',1,125),(475,'when there is a high-ranking visitor',0,125),(476,'when the weather is cold',0,125),(477,'happy',1,126),(478,'sad',0,126),(479,'angry',0,126),(480,'jealous',0,126),(481,'find',0,127),(482,'plan',1,127),(483,'enjoy',0,127),(484,'suggest',0,127),(485,'a leader',0,128),(486,'a commander',0,128),(487,'an instructor',0,128),(488,'a specialist',1,128),(489,'He should increase his speed.',0,129),(490,'He should continue at the same speed.',0,129),(491,'He should decrease his speed.',1,129),(492,'He should stop.',0,129),(493,'to begin',1,130),(494,'to change',0,130),(495,'to process',0,130),(496,'to finish',0,130),(497,'a few',0,131),(498,'none',0,131),(499,'a little',0,131),(500,'a lot',1,131),(501,'It was established.',1,132),(502,'It stopped operating.',0,132),(503,'It was making a lot of money.',0,132),(504,'A new branch office was set up.',0,132),(505,'Were you involved?',1,133),(506,'Did you wash him?',0,133),(507,'Did you assist him?',0,133),(508,'Did you watch what he did?',0,133),(509,'an argument',0,134),(510,'a command',0,134),(511,'a farm',0,134),(512,'a report',1,134),(513,'something expensive',1,135),(514,'something delicious',0,135),(515,'something cheap',0,135),(516,'something heavy',0,135),(517,'The heat should be very hot.',0,136),(518,'The heat should be medium.',1,136),(519,'The heat should be very low.',0,136),(520,'The heat should be turned off.',0,136),(521,'to start again',0,137),(522,'to be stolen',0,137),(523,'to break into pieces',0,137),(524,'to stop working suddenly',1,137),(525,'a stick',1,138),(526,'a ball',0,138),(527,'a hole',0,138),(528,'a box',0,138),(529,'a little hot',1,139),(530,'very warm',0,139),(531,'quite cold',0,139),(532,'freezing',0,139),(533,'on top of the refrigerator',0,140),(534,'in front of the refrigerator',0,140),(535,'behind the refrigerator',1,140),(536,'to the left of the refrigerator',0,140),(537,'houses for sale',0,141),(538,'houses to let',1,141),(539,'houses to buy',0,141),(540,'land to build a house on',0,141),(541,'The wire is not good.',0,142),(542,'The wire is not protected.',1,142),(543,'The wire is not carrying electricity.',0,142),(544,'The wire is not visible.',0,142),(545,'an unusual one',0,143),(546,'the first one',0,143),(547,'an ordinary one',1,143),(548,'the last one',0,143),(549,'It was too expensive.',0,144),(550,'There was a lot of fruit in stock.',0,144),(551,'It had gone bad.',1,144),(552,'She didn\'t feel like eating fruit.',0,144),(553,'I\'ll tell you anything you want to know.',0,145),(554,'I\'ll help in any way I can.',1,145),(555,'I won\'t be able to stop laughing.',0,145),(556,'I haven\'t thought about him in years.',0,145),(557,'The camera is out of order.',0,146),(558,'The film is out of order.',1,146),(559,'There is no film in the camera.',0,146),(560,'The film is sold out.',0,146),(561,'through blood',1,147),(562,'by a human mistake',0,147),(563,'through an animal',0,147),(564,'through food',0,147),(565,'His eye was hit by a baseball.',1,148),(566,'The light of the sun hurt his eyes.',0,148),(567,'He sat through last night\'s game.',0,148),(568,'He was expelled from last night\'s game.',0,148),(569,'I\'d like to have them both.',1,149),(570,'I drink it when it\'s cold.',0,149),(571,'We don\'t have to stay here long.',0,149),(572,'I\'d like a cup of coffee, please.',0,149),(573,'She has just graduated from college.',1,150),(574,'She never graduated from college.',0,150),(575,'She will be studying at college.',0,150),(576,'She is going to graduate from college.',0,150),(577,'They were alternated.',0,151),(578,'They were congratulated.',0,151),(579,'They were discharged.',1,151),(580,'They were graduated.',0,151),(581,'He frightened them.',0,152),(582,'He repelled them.',1,152),(583,'He trusted them.',0,152),(584,'He made friends with them.',0,152),(585,'Her voice is beautiful.',0,153),(586,'Her house is beautiful.',0,153),(587,'Her face is beautiful.',0,153),(588,'Her body shape is beautiful.',1,153),(589,'He was chosen to deal with the crisis.',1,154),(590,'He couldn\'t get out of the trouble.',0,154),(591,'He was blamed for the mistake.',0,154),(592,'He successfully solved the problem.',0,154),(593,'He drew it up.',0,155),(594,'He is against it.',1,155),(595,'He is explaining it.',0,155),(596,'He will carry it out.',0,155),(597,'He is searching for a brand-new car.',1,156),(598,'He is testing his new car.',0,156),(599,'He is shopping for a second-hand car.',0,156),(600,'He is selling a second -hand car.',0,156),(601,'He went ahead of us.',0,157),(602,'He would come with us.',0,157),(603,'He wanted to join us.',1,157),(604,'He could go with us.',0,157),(605,'A schedule was lost.',0,158),(606,'A schedule was destroyed.',0,158),(607,'A schedule was found.',0,158),(608,'A schedule was established.',1,158),(609,'I\'m grateful to you.',1,159),(610,'I think nothing of it.',0,159),(611,'I can\'t wait to have it.',0,159),(612,'I totally agree with you.',0,159),(613,'There is no one in the waiting room.',0,160),(614,'There are a lot of people in the waiting room.',1,160),(615,'There are few people in the waiting room.',0,160),(616,'There are a few people in the waiting room.',0,160),(617,'She must roll it up.',1,161),(618,'She must double it over.',0,161),(619,'She must clean it up.',0,161),(620,'She must read it again.',0,161),(621,'It was raining.',0,162),(622,'There was a lot of snow.',0,162),(623,'It was getting dark.',0,162),(624,'The visibility was poor.',1,162),(625,'She became very happy.',0,163),(626,'She received a surprise.',0,163),(627,'She felt unsteady.',1,163),(628,'She got a good deal.',0,163),(629,'Mr. Johnson is their cousin.',0,164),(630,'Mr. Johnson is their father.',1,164),(631,'Mr. Johnson is their brother.',0,164),(632,'Mr. Johnson is their uncle.',0,164),(633,'Harry wanted a sedan.',0,165),(634,'Harry didn\'t want a sports car.',0,165),(635,'Harry bought a sedan.',1,165),(636,'Harry bought a sports car.',0,165),(637,'They have to receive extensive training.',1,166),(638,'They train lightly because of exhaustion.',0,166),(639,'They skip extensive training.',0,166),(640,'They dislike extensive training.',0,166),(641,'It is just around the corner.',1,167),(642,'It is coming to an end.',0,167),(643,'It is about to finish.',0,167),(644,'It is never too late.',0,167),(645,'It mixed the shells up.',1,168),(646,'It put in the shells.',0,168),(647,'It fired the shells out.',0,168),(648,'It threw away the shells.',0,168),(649,'Their friends won\'t use the seats.',1,169),(650,'Their friends are in the seats.',0,169),(651,'The seats for their friends are cheap.',0,169),(652,'The seats are being held for their friends.',0,169),(653,'He is behind in his schoolwork.',1,170),(654,'He is good at his schoolwork.',0,170),(655,'He is the best student in class.',0,170),(656,'He is sitting in the back row of the classroom.',0,170),(657,'It is not working.',1,171),(658,'It has broken into pieces.',0,171),(659,'It is ready for sale.',0,171),(660,'It was broadcast live.',0,171),(661,'You and I are alike.',0,172),(662,'I think I\'ve seen you before.',1,172),(663,'I know you very well.',0,172),(664,'You look like someone in my family.',0,172),(665,'He is getting a shot.',1,173),(666,'He is getting weighed.',0,173),(667,'He is being examined.',0,173),(668,'He is being rescued.',0,173),(669,'Don\'t forget to write her a letter.',1,174),(670,'Don\'t forget to see her tomorrow.',0,174),(671,'Don\'t forget to send her a telegram.',0,174),(672,'Don\'t forget to telephone her.',0,174),(673,'cost',0,175),(674,'length',0,175),(675,'size',0,175),(676,'temperature',1,175),(677,'a steering device',0,176),(678,'a source of power',1,176),(679,'a job to do',0,176),(680,'a way of stopping',0,176),(681,'show her how to write',0,177),(682,'give her something to do',0,177),(683,'give her a pen to use',1,177),(684,'show her around',0,177),(685,'look for mistakes',1,178),(686,'write it again',0,178),(687,'begin a new job',0,178),(688,'pay him for his work',0,178),(689,'a way into the room',0,179),(690,'a way out of the room',1,179),(691,'a way to go though the window',0,179),(692,'a way to lock the door',0,179),(693,'in a fancy restaurant',0,180),(694,'at a noodle stand',0,180),(695,'in a fast food restaurant',1,180),(696,'in a Chinese restaurant',0,180),(697,'It was just cooked.',1,181),(698,'It was a warm day.',0,181),(699,'I already finished eating.',0,181),(700,'That\'s my favorite meal.',0,181),(701,'The girl looks nothing like her sister',0,182),(702,'The girl looks a lot like the woman\'s sister.',1,182),(703,'The girl acts like she\'s the woman\'s sister.',0,182),(704,'The girl is a little taller.',0,182),(705,'The cars are too heavy.',0,183),(706,'The road is quite wide.',0,183),(707,'The cars cannot go very fast.',0,183),(708,'The cars cannot pass each other.',1,183),(709,'It\'s a good place for exercising.',0,184),(710,'It\'s quiet there.',1,184),(711,'It\'s noisy there.',0,184),(712,'It\'s near their house.',0,184),(717,'slowly',0,186),(718,'fast',1,186),(719,'well',0,186),(720,'straight',0,186),(721,'It will probably rain.',1,187),(722,'It will not rain.',0,187),(723,'It will rain for sure.',0,187),(724,'It is impossible to rain this weekend.',0,187),(725,'They moved to the city.',0,188),(726,'They left the city.',0,188),(727,'They did some sightseeing.',1,188),(728,'The didn\'t like the city.',0,188),(729,'It is very important.',0,189),(730,'It is not woking very well.',1,189),(731,'It is destroyed.',0,189),(732,'It needs to be recharged.',0,189),(733,'A disaster was avoided.',0,190),(734,'A disaster was predicted.',0,190),(735,'A disaster occurred.',1,190),(736,'A disaster passed.',0,190),(737,'We had breakfast.',0,191),(738,'We exercised.',0,191),(739,'We talked.',1,191),(740,'We relaxed.',0,191),(741,'She wants us to stop playing around.',0,192),(742,'She wants us to wake up soon.',0,192),(743,'She wants us not to ride the horses.',1,192),(744,'She wants us to stop hanging around.',0,192),(745,'the dock',1,193),(746,'the raft',0,193),(747,'the truck',0,193),(748,'the swimming pool',0,193),(749,'drink it ',1,194),(750,'rub it on',0,194),(751,'dry it out',0,194),(752,'paint it',0,194),(753,'before they learned English',0,195),(754,'before 2005',0,195),(755,'in 2005',1,195),(756,'to attend flight school',0,195),(757,'a weapon',0,196),(758,'a signal',0,196),(759,'an award',0,196),(760,'an assignment',1,196),(761,'David drilled it.',1,197),(762,'David sewed it.',0,197),(763,'David wrote it.',0,197),(764,'David bought it.',0,197),(765,'He wants to wait before going to the beach.',0,198),(766,'He is excited about going to the beach.',1,198),(767,'He doesn\'t care for being outdoors.',0,198),(768,'He has to wait on the beach.',0,198),(769,'once a day',0,199),(770,'two times a day',1,199),(771,'once each two days',0,199),(772,'three times a day',0,199),(773,'It rains very often.',0,200),(774,'It remains the same.',0,200),(775,'It is always hot.',0,200),(776,'It changes often.',1,200),(777,'Yes, they use traffic lights.',0,201),(778,'Yes, they use helicopters.',1,201),(779,'Yes, they use radios.',0,201),(780,'Yes, they use police cars.',0,201),(781,'handle the books',0,202),(782,'test the magazines',0,202),(783,'have a quick look at them',1,202),(784,'buy a few of them',0,202),(785,'I answer James\' call.',0,203),(786,'I fought with James.',0,203),(787,'I met James',1,203),(788,'I scolded James.',0,203),(789,'Yes, she is happy and carefree.',1,204),(790,'Yes, she is English.',0,204),(791,'Nom she is carefree and happy.',0,204),(792,'No, she is saleswoman.',0,204),(793,'to indicate atmospheric pressure',0,205),(794,'to record air speed',0,205),(795,'to measure precipitation',0,205),(796,'to regulate temperature',1,205),(797,'because the car is rough',0,206),(798,'because the car is hot and dry',0,206),(799,'because the car stops',0,206),(800,'because the car slides easily',1,206),(801,'buy a newspaper',0,207),(802,'take a bus',1,207),(803,'see a doctor',0,207),(804,'go to bed early',0,207),(805,'She thinks she will fail the course.',0,208),(806,'She thinks she will succeed.',1,208),(807,'She wants to drop the course.',0,208),(808,'She wants to take it over.',0,208),(809,'He can\'t see very well.',0,209),(810,'He is mute.',0,209),(811,'Ir is hard to listen to him sing.',0,209),(812,'There is a problem with his hearing.',1,209),(813,'He is worse than David.',0,210),(814,'He is more handsome than David.',0,210),(815,'He is much better than David.',1,210),(816,'He is a better friend than David.',0,210),(817,'He gave them a briefing.',0,211),(818,'He organized their vehicles.',0,211),(819,'He gave them a big hand.',0,211),(820,'He watched them march.',1,211),(821,'You will very likely feel cold.',0,212),(822,'You will very likely feel warm.',0,212),(823,'You will very likely get sick.',1,212),(824,'You will very likely buy a coat.',0,212),(825,'I don\'t like to read.',0,213),(826,'I like to read all the time.',0,213),(827,'I like to read about cars.',0,213),(828,'I like to read when I am free.',1,213),(829,'There was an ambulance behind John.',1,214),(830,'There was a taxi behind John.',0,214),(831,'There was music behind John.',0,214),(832,'There was a bicycle behind John.',0,214),(833,'The weather is bad.',0,215),(834,'The work is too hard.',1,215),(835,'The road is rough.',0,215),(836,'The picture is all right.',0,215),(837,'He took it away.',1,216),(838,'He bought it.',0,216),(839,'He took off its cover.',0,216),(840,'He read it.',0,216),(841,'The solution was unknown.',0,217),(842,'The solution was apparent.',1,217),(843,'The solution was dangerous.',0,217),(844,'The solution was essential.',0,217),(845,'It must be flat.',1,218),(846,'It must be long.',0,218),(847,'It must be square.',0,218),(848,'It must be large.',0,218),(849,'We confused the enemy.',0,219),(850,'We met the enemy.',1,219),(851,'We defeated the enemy.',0,219),(852,'We avoided the enemy.',0,219),(853,'Mary will compete with the female candidate.',0,220),(854,'Mary will choose the female candidate.',1,220),(855,'Mary doesn\'t like the female candidate.',0,220),(856,'Mary will work for the female candidate.',0,220),(857,'It can\'t fit.',1,221),(858,'He doesn\'t own it.',0,221),(859,'It was too heavy for him.',0,221),(860,'He doesn\'t like it.',0,221),(861,'He didn\'t see the passengers.',1,222),(862,'He didn\'t like the noise it made.',0,222),(863,'He didn\'t see the plane landing.',0,222),(864,'He didn\'t know the arrival time.',0,222),(865,'Peter can\'t understand them.',1,223),(866,'Peter can\'t stand up to them.',0,223),(867,'Peter will make them stand up.',0,223),(868,'Peter can\'t tolerate them.',0,223),(869,'They\'re becoming longer.',1,224),(870,'They\'re becoming more interesting.',0,224),(871,'They\'re becoming more rigid.',0,224),(872,'They\'re becoming more important.',0,224),(873,'They saved him.',1,225),(874,'They surrounded him.',0,225),(875,'They located him.',0,225),(876,'They buried him.',0,225),(877,'She doesn\'t know the truth.',1,226),(878,'She wants to tell the truth.',0,226),(879,'She is willing to tell the truth.',0,226),(880,'She doesn\'t want to tell the truth.',0,226),(881,'They neglected his warning.',1,227),(882,'They liked his warning.',0,227),(883,'They forgot his warning.',0,227),(884,'They remembered his warning.',0,227),(885,'this kind of watch is very expensive.',1,228),(886,'This kind of watch breaks easily.',0,228),(887,'You cannot buy this kind of watch anymore.',0,228),(888,'You will not like this kind of watch.',0,228),(889,'It is good for insulation.',1,229),(890,'It burns easily.',0,229),(891,'It is easy to lose.',0,229),(892,'It is very expensive.',0,229),(893,'He dislikes them very much.',1,230),(894,'He makes them angry.',0,230),(895,'He has great trouble working with them.',0,230),(896,'He has a high regard for them.',0,230),(897,'I was sick last night.',1,231),(898,'I finished last night.',0,231),(899,'I went running last night.',0,231),(900,'I was in a rush last night.',0,231),(901,'I don’t want to see your new home.',1,232),(902,'I don’t  want anything in your new home.',0,232),(903,'I really want to see your new home.',0,232),(904,'I would give anything to have a new home.',0,232),(905,'The damage wasn’t necessary.',1,233),(906,'There was only a little damage.',0,233),(907,'No damage was detected.',0,233),(908,'There was major damage.',0,233),(909,'He has enough time',1,234),(910,'He hasn’t enough time.',0,234),(911,'He has extra time. ',0,234),(912,'He has limited time.',0,234),(913,'She wanted to know the cost. ',1,235),(914,'She wanted to know the means.',0,235),(915,'She wanted to know the answer.',0,235),(916,'She wanted to know the reason.',0,235),(917,'a house ',1,236),(918,'a trip',0,236),(919,'a car',0,236),(920,'a friend',0,236),(921,'The man should buy new clothing.',1,237),(922,'The man has poor taste in clothing.',0,237),(923,'The man should try to find his belt.',0,237),(924,'The man should lose weight.',0,237),(925,'It was expanded five months ago.',1,238),(926,'It was started five months ago.',0,238),(927,'It was moved five months ago.',0,238),(928,'It was closed five months ago.',0,238),(929,'It matched her furniture.',1,239),(930,'It was a bargain.',0,239),(931,'It was nice to site in.',0,239),(932,'It was a pretty color.',0,239),(933,'He paid for it ahead of time.',1,240),(934,'He paid for it little by little.',0,240),(935,'He paid for it with a loan.',0,240),(936,'He paid for it with a check.',0,240),(937,'to work',1,241),(938,'on a trip',0,241),(939,'to school',0,241),(940,'on a picnic',0,241),(941,'He wanted to go to bed.',1,242),(942,'He wanted to get cleaned up.',0,242),(943,'He wanted to drink something cold.',0,242),(944,'He wanted to get somewhere fast.',0,242),(945,'His house was pretty.',1,243),(946,'His house was old.',0,243),(947,'His house was big.',0,243),(948,'His house was modern.',0,243),(949,'She was studying how to build things.',1,244),(950,'She was studying how to write stories.',0,244),(951,'She was studying how to teach children.',0,244),(952,'She was studying how to fix teeth.',0,244),(953,'descending',1,245),(954,'shacking',0,245),(955,'rolling',0,245),(956,'climbing',0,245),(957,'He is careless.',1,246),(958,'He is at fault.',0,246),(959,'He is lazy.',0,246),(960,'He likes to criticize.',0,246),(961,'play ball',1,247),(962,'eat supper',0,247),(963,'work',0,247),(964,'sleep',0,247),(965,'putting off the meeting',1,248),(966,'canceling the meeting',0,248),(967,'attending the meeting',0,248),(968,'holding a meeting',0,248),(969,'took some medicine',1,249),(970,'ran away',0,249),(971,'got a ticket',0,249),(972,'said he was sorry',0,249),(973,' in a trailer home',1,250),(974,'far from the base',0,250),(975,'near from the base',0,250),(976,'on the other side of town',0,250),(977,'give them a briefing',1,251),(978,'see how the class was conduct',0,251),(979,'teach the class ',0,251),(980,'interview the student',0,251),(985,'the speed',1,253),(986,'the angle',0,253),(987,'the diameter',0,253),(988,'the circumference',0,253),(989,'decorating a house',1,254),(990,'selling a house',0,254),(991,'building a house',0,254),(992,'tearing down a house',0,254),(993,'to be net',1,255),(994,'to be fair',0,255),(995,'to be truthful',0,255),(996,'to be on time',0,255),(997,'He threw them away.',1,256),(998,'He published them.',0,256),(999,'He put them on.',0,256),(1000,'He kicked them off.',0,256),(1001,'go up and down',1,257),(1002,'stay the same',0,257),(1003,'rise steadily',0,257),(1004,'fall steadily',0,257),(1005,'a sharp mind ',1,258),(1006,'explosives',0,258),(1007,'the desire to succeed',0,258),(1008,'a prolonged illness',0,258),(1009,'come and pick him up',0,259),(1010,'cook some food for him',0,259),(1011,'buy some food',1,259),(1012,'order some food at home',0,259),(1013,'to write to the doctor',0,260),(1014,'to call the doctor',0,260),(1015,'to find out about the doctor',0,260),(1016,'to go see the doctor',1,260),(1017,'She allowed John to take the car.',1,261),(1018,'She warned John not to take the car.',0,261),(1019,'She ordered John to drive the car.',0,261),(1020,'She gave John a ride in the car.',0,261),(1021,'the time of the meeting',1,262),(1022,'how to repair the radio',0,262),(1023,'where Main Street is',0,262),(1024,'what to buy ',0,262),(1025,'She’ll ask for the money.',0,263),(1026,'She’ll complain.',0,263),(1027,'She’ll stop working so hard.',0,263),(1028,'She’ll leave her job.',1,263),(1029,'after a while',0,264),(1030,'within minutes',1,264),(1031,'after a week',0,264),(1032,'in a day',0,264),(1033,'We agree with them.',0,265),(1034,'We employ them.',0,265),(1035,'We unite them.',0,265),(1036,'We contact them.',1,265),(1037,'act like their parents ',1,266),(1038,'help their parents',0,266),(1039,'admire the parents',0,266),(1040,'live with their parents',0,266),(1041,'She turned him down.',0,267),(1042,'She got lost.',0,267),(1043,'She didn’t show up.',1,267),(1044,'She was late.',0,267),(1045,'He found that his work was hard.',0,268),(1046,'He started doing his work.',0,268),(1047,'He started looking for work.',0,268),(1048,'He made sure his work was right.',1,268),(1049,'He was not sure of the scores.',0,269),(1050,'He was unhappy with the scores.',1,269),(1051,'He was studying the scores.',0,269),(1052,'He was evaluating the scores.',0,269),(1053,'There were no results.',0,270),(1054,'There were no expectations.',0,270),(1055,'The results were not what Major Wilson expected.',1,270),(1056,'The results were what Major Wilson expected.',0,270),(1057,'I’m not surprised by the results.',0,271),(1058,'I didn’t I would pass the exam.',0,271),(1059,'I didn’t think I would pass the exam.	',1,271),(1060,'I knew I would pass the exam.',0,271),(1061,'They were praised.',0,272),(1062,'They were congratulated.',0,272),(1063,'They were kicked out.',1,272),(1064,'They graduated.',0,272),(1065,'They repelled it.',1,273),(1066,'They prevented it.',0,273),(1067,'They missed it.',0,273),(1068,'They started it.',0,273),(1069,'There was a traffic jam this morning.',1,274),(1070,'There was a car accident this morning.',0,274),(1071,'Cars were going at a high speed.',0,274),(1072,'The traffic light was out of order.',0,274),(1073,'The song makes her sad.',0,275),(1074,'The song is about love.',0,275),(1075,'She knows the singer very well.',0,275),(1076,'She has memorized the song.',1,275),(1077,'We must feed them.',0,276),(1078,'We must hit them.',0,276),(1079,'We must treat them.',0,276),(1080,'We must locate them.',1,276),(1081,'The washing machine is not working properly.',1,277),(1082,'The machine is user-friendly.',0,277),(1083,'The price of this washing machine is going up.',0,277),(1084,'The washing machine is now for sale.',0,277),(1085,'He won the lottery.',0,278),(1086,'He always thinks of the lottery.',1,278),(1087,'He has never bought any lottery tickets.',0,278),(1088,'Winning the lottery made him rich.',0,278),(1089,'I hailed a taxi.',0,279),(1090,'I was diving taxi.',0,279),(1091,'The taxi almost hit me.',1,279),(1092,'I was waiting for a taxi.',0,279),(1093,'A schedule was destroyed.',0,280),(1094,'A schedule was lost.',0,280),(1095,'A schedule was established.',1,280),(1096,'A schedule was found.',0,280),(1097,'James is confident about himself.',0,281),(1098,'James is proud of them.',0,281),(1099,'James is not true to himself.',0,281),(1100,'James lacks self-confidence.',1,281),(1101,'They had a normal day.',0,282),(1102,'They worked hard during the emergency.',1,282),(1103,'They had a practice drill.',0,282),(1104,'They had a false alarm.',0,282),(1105,'Don’t let her tell.',0,283),(1106,'Don’t tell her.',1,283),(1107,'Don’t talk about her.',0,283),(1108,'Don’t forget to tell her.',0,283),(1109,'It is said that he is having an affair.',1,284),(1110,'We believe he is having an affair.',0,284),(1111,'The rumor is not fair.',0,284),(1112,'We’ve never heard the rumer.',0,284),(1113,'It was raining.',0,285),(1114,'The visibility was poor.',1,285),(1115,'It was getting dark.',0,285),(1116,'There was a lot of snow.',0,285),(1117,'She received a surprise.',0,286),(1118,'She became very happy.',0,286),(1119,'She got a good deal.',0,286),(1120,'She felt unsteady.',1,286),(1121,'That medicine tasted bitter.',0,287),(1122,'That medicine worked miracles.',1,287),(1123,'The medicine tasted like wine.',0,287),(1124,'The medicine was prescribed carefully.',0,287),(1125,'They deserted their children.',0,288),(1126,'They moved because of their children.',1,288),(1127,'Their children didn’t move with them.',0,288),(1128,'They sent their children to Manhattan.',0,288),(1129,'Harry bought a sedan.',1,289),(1130,'Harry bought a sports car.',0,289),(1131,'Harry wanted a sedan.',0,289),(1132,'Harry didn’t want a sports car.',0,289),(1133,'They skip extensive training.',0,290),(1134,'They dislike extensive training.',0,290),(1135,'They have to receive extensive training.',1,290),(1136,'They train lightly because of exhaustion.',0,290),(1137,'You should have called me.',0,291),(1138,'You are supposed to call me after meeting me.',0,291),(1139,'Let me know if you cannot come.',1,291),(1140,'Call me when you arrive.',0,291),(1141,'It pulled in the shells.',0,292),(1142,'It mixed the shells.',0,292),(1143,'It threw out the shells.',1,292),(1144,'It fired the shells.',0,292),(1145,'The table is being held for their friends.',1,293),(1146,'The table for their friends is cheap.',0,293),(1147,'Their friends are in the seats.',0,293),(1148,'Their friends won’t use the seats.',0,293),(1149,'It is good to hear you say that.',0,294),(1150,'It’s getting chilly.',0,294),(1151,'It’s perfect for cooking.',0,294),(1152,'It feels very hot.',1,294),(1153,'Don’t forget to write her a letter.',0,295),(1154,'Don\'t forget to see her tomorrow.',0,295),(1155,'Don\'t forget to send her an e-mail.',0,295),(1156,'Don\'t forget to telephone her.',1,295),(1157,'turn right at the next corner',0,296),(1158,'give the woman a ride',0,296),(1159,'look for the taxi',0,296),(1160,'send a taxi immediately.',1,296),(1161,'She doesn’t like the man.',0,297),(1162,'She doesn’t know how to paint.',0,297),(1163,'It’s in the morning.',0,297),(1164,'She has an appointment to meet someone.',1,297),(1165,'He received a present at the meeting.',0,298),(1166,'He enjoying the meeting.',0,298),(1167,'He attended the meeting.',1,298),(1168,'He was the speaker.',0,298),(1169,'Richard has been standing in the wrong place.',0,299),(1170,'Richard hasn’t heard it correctly.',0,299),(1171,'Richard doesn’t know what it means.',1,299),(1172,'Richard means everything he says.',0,299),(1173,'She should treat him to dinner.',0,300),(1174,'It’s very easy .',0,300),(1175,'He’s hungry.',0,300),(1176,'It’s too difficult for him.',1,300),(1177,'He doesn’t like his new apartment.',1,301),(1178,'Someone is standing behind him.',0,301),(1179,'He back aches.',0,301),(1180,'Someone is trying to kill them.',0,301),(1181,'Colonel Roberts will not to give a speech.',0,302),(1182,'Colonel Roberts will ignore the speaker.',0,302),(1183,'Colonel Roberts will be the main speaker.',1,302),(1184,'Colonel Roberts will introduce the speaker.',0,302),(1185,'a chief',0,303),(1186,'a customer',0,303),(1187,'a waitress ',1,303),(1188,'a janitor',0,303),(1189,'one',1,304),(1190,'a few',0,304),(1191,'Two',0,304),(1192,'none',0,304),(1193,' stop working ',0,305),(1194,'do the work better',0,305),(1195,'continue to work ',1,305),(1196,'do the work over again',0,305);
/*!40000 ALTER TABLE `alcpt_choice` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_department`
--

LOCK TABLES `alcpt_department` WRITE;
/*!40000 ALTER TABLE `alcpt_department` DISABLE KEYS */;
INSERT INTO `alcpt_department` VALUES (8,'y ej03vu4'),(1,'法律系'),(4,'財管系'),(5,'資工系'),(2,'資管系'),(3,'運籌系');
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
  `finish_time` datetime(6) DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `testpaper_id` int(11) DEFAULT NULL,
  `average_score` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `alcpt_exam_created_by_id_3e8088e6_fk_alcpt_user_id` (`created_by_id`),
  KEY `alcpt_exam_group_id_6d1403ce_fk_alcpt_group_id` (`group_id`),
  KEY `alcpt_exam_testpaper_id_6048fb92_fk_alcpt_testpaper_id` (`testpaper_id`),
  CONSTRAINT `alcpt_exam_created_by_id_3e8088e6_fk_alcpt_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `alcpt_user` (`id`),
  CONSTRAINT `alcpt_exam_group_id_6d1403ce_fk_alcpt_group_id` FOREIGN KEY (`group_id`) REFERENCES `alcpt_group` (`id`),
  CONSTRAINT `alcpt_exam_testpaper_id_6048fb92_fk_alcpt_testpaper_id` FOREIGN KEY (`testpaper_id`) REFERENCES `alcpt_testpaper` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_exam`
--

LOCK TABLES `alcpt_exam` WRITE;
/*!40000 ALTER TABLE `alcpt_exam` DISABLE KEYS */;
INSERT INTO `alcpt_exam` VALUES (1,'第一次模擬考',1,0,0,'2020-01-04 21:15:35.256649','2020-01-02 10:25:35.256740',300,'2020-01-05 02:15:35.256649',1,1,1,20,16.5),(10,'閱讀練習-practice-1090630218-2019-12-19 11:11:16.584208',4,0,0,NULL,'2019-12-19 03:11:16.629833',0,NULL,0,1,NULL,10,30),(11,'閱讀練習-practice-1090630218-2019-12-19 19:08:47.418520',4,0,0,NULL,'2019-12-19 11:08:47.441227',0,NULL,0,1,NULL,11,100),(12,'閱讀練習-practice-1090630218-2019-12-19 20:58:00.977096',4,0,0,NULL,'2019-12-19 12:58:01.021252',0,NULL,0,1,NULL,12,70),(13,'閱讀練習-practice-1090630218-2019-12-19 21:00:03.583008',4,0,0,NULL,'2019-12-19 13:00:03.627403',0,NULL,0,1,NULL,13,60),(14,'閱讀練習-practice-1090630218-2019-12-20 13:26:03.870011',4,0,0,NULL,'2019-12-20 05:26:03.953700',0,NULL,0,1,NULL,14,70),(15,'閱讀練習-practice-1090630218-2019-12-20 13:31:24.105144',4,0,0,NULL,'2019-12-20 05:31:24.167379',0,NULL,0,1,NULL,15,88),(17,'閱讀練習-practice-1090630218-2019-12-29 00:10:17.882042',4,0,0,NULL,'2019-12-28 16:10:17.945702',0,NULL,0,1,NULL,17,0),(20,'閱讀練習-practice-1090630218-2019-12-31 14:14:52.703424',4,0,0,NULL,'2019-12-31 06:14:52.771892',0,NULL,0,1,NULL,23,10),(21,'閱讀練習-practice-1090630218-2019-12-31 14:34:15.677266',4,0,0,NULL,'2019-12-31 06:34:15.765396',0,NULL,0,1,NULL,24,30),(22,'閱讀練習-practice-1090630218-2019-12-31 14:37:14.577271',4,0,0,NULL,'2019-12-31 06:37:14.651895',0,NULL,0,1,NULL,25,20),(23,'聽力練習-practice-1090630218-2019-12-31 15:18:27.159497',3,0,0,NULL,'2019-12-31 07:18:27.265301',0,NULL,0,1,NULL,26,30),(24,'閱讀練習-practice-1090630218-2019-12-31 15:36:05.319577',4,0,0,NULL,'2019-12-31 07:36:05.431738',0,NULL,0,1,NULL,27,30),(25,'聽力練習-practice-1090630218-2019-12-31 15:54:35.174701',3,0,0,NULL,'2019-12-31 07:54:35.256649',0,NULL,0,1,NULL,28,50),(26,'閱讀練習-practice-1090630218-2020-01-04 02:48:04.309985',4,0,0,NULL,'2020-01-04 02:48:04.383332',0,NULL,0,1,NULL,29,20),(27,'聽力練習-practice-1090630218-2020-01-04 12:34:56.746687',3,0,0,NULL,'2020-01-04 12:34:56.826624',0,NULL,0,1,NULL,30,40),(28,'閱讀練習-practice-1090630216-2020-01-04 21:29:45.143670',4,0,0,NULL,'2020-01-04 21:29:45.215376',0,NULL,0,27,NULL,31,30),(29,'閱讀練習-practice-1090630220-2020-01-04 23:49:20.832601',4,0,0,NULL,'2020-01-04 23:49:20.908872',0,NULL,0,28,NULL,32,20),(30,'閱讀練習-practice-1090630218-2020-01-05 00:04:41.027504',4,0,0,NULL,'2020-01-05 00:04:41.097880',0,NULL,0,1,NULL,33,50),(31,'閱讀練習-practice-1090630218-2020-01-05 21:24:59.071834',4,0,0,NULL,'2020-01-05 21:24:59.146853',0,NULL,0,1,NULL,34,0),(32,'聽力練習-practice-1090630218-2020-01-13 11:38:10.288748',3,0,0,NULL,'2020-01-13 11:38:10.474798',0,NULL,0,1,NULL,35,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_group`
--

LOCK TABLES `alcpt_group` WRITE;
/*!40000 ALTER TABLE `alcpt_group` DISABLE KEYS */;
INSERT INTO `alcpt_group` VALUES (1,'109','2019-05-19 20:07:54.047000','2019-05-19 20:07:54.033000',1),(2,'資管系','2020-02-02 02:59:29.054721','2020-02-02 02:59:29.037714',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_group_member`
--

LOCK TABLES `alcpt_group_member` WRITE;
/*!40000 ALTER TABLE `alcpt_group_member` DISABLE KEYS */;
INSERT INTO `alcpt_group_member` VALUES (24,1,1),(25,1,4),(26,1,5),(27,1,6),(28,1,7),(29,1,8),(30,1,9),(31,1,10),(32,1,11),(33,1,12),(34,1,13),(35,1,14),(36,1,15),(37,1,16),(38,1,17),(39,1,18),(40,1,19),(41,1,20),(42,1,21),(43,1,22),(44,1,23),(45,1,24),(46,1,25),(74,2,1),(75,2,4),(76,2,5),(77,2,6),(78,2,7),(79,2,8),(80,2,9),(81,2,10),(82,2,11),(83,2,12),(84,2,13),(85,2,14),(86,2,15),(87,2,16),(88,2,17),(89,2,18),(90,2,19),(91,2,20),(92,2,21),(93,2,22),(94,2,23),(95,2,24),(96,2,25);
/*!40000 ALTER TABLE `alcpt_group_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_optionlist`
--

DROP TABLE IF EXISTS `alcpt_optionlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_optionlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `added_time` datetime(6) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `choice_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alcpt_optionlist_answer_id_a63ecefe_fk_alcpt_answer_id` (`answer_id`),
  KEY `alcpt_optionlist_choice_id_f03826ca_fk_alcpt_choice_id` (`choice_id`),
  CONSTRAINT `alcpt_optionlist_answer_id_a63ecefe_fk_alcpt_answer_id` FOREIGN KEY (`answer_id`) REFERENCES `alcpt_answer` (`id`),
  CONSTRAINT `alcpt_optionlist_choice_id_f03826ca_fk_alcpt_choice_id` FOREIGN KEY (`choice_id`) REFERENCES `alcpt_choice` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_optionlist`
--

LOCK TABLES `alcpt_optionlist` WRITE;
/*!40000 ALTER TABLE `alcpt_optionlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `alcpt_optionlist` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_proclamation`
--

LOCK TABLES `alcpt_proclamation` WRITE;
/*!40000 ALTER TABLE `alcpt_proclamation` DISABLE KEYS */;
INSERT INTO `alcpt_proclamation` VALUES (5,'12月份體測','1、12月份體測已公布，各教授班確認好施測時間。\r\n2、所有人務必做好自身暖身，勿有受傷情事。\r\n3、請各位同學務必遵守榮譽信條，勿有謊報成績之情事。',1,'2019-12-15 16:02:43.579695',1),(6,'流行性感冒','近期流感疫情嚴重，請各單位務必多注意自身身體狀況。',1,'2019-12-27 14:27:38.820585',1),(7,'元旦升旗典禮','1、將於109年1月1日舉行的升旗典禮，與會人員務必將自身服儀整理至最高標準。\r\n2、軍歌部分務必熟記，勿有不會唱之情事發生。',1,'2019-12-27 14:29:31.656622',1),(8,'ALCPT練習平台啟用','1、此英文練習系統，適用於與軍校有關任何人員。\r\n2、為精進單位人員相關語言能力而開發此系統，請所有人員務必於時間內進行練習。',1,'2019-12-27 14:31:39.641987',1),(9,'寒假','將於1/17 1700實施為期2個禮拜的寒假假期。',1,'2020-01-01 15:58:56.822755',1);
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
  `q_type` smallint(5) unsigned NOT NULL,
  `q_file` longtext,
  `q_content` longtext,
  `difficulty` smallint(5) unsigned NOT NULL,
  `used_freq` int(11) NOT NULL,
  `issued_freq` int(11) NOT NULL,
  `correct_freq` int(11) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_valid` tinyint(1) NOT NULL,
  `state` smallint(6) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `last_updated_by_id` int(11) DEFAULT NULL,
  `faulted_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `alcpt_question_created_by_id_2c7db757_fk_alcpt_user_id` (`created_by_id`),
  KEY `alcpt_question_last_updated_by_id_7e7caa2c_fk_alcpt_user_id` (`last_updated_by_id`),
  CONSTRAINT `alcpt_question_created_by_id_2c7db757_fk_alcpt_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `alcpt_user` (`id`),
  CONSTRAINT `alcpt_question_last_updated_by_id_7e7caa2c_fk_alcpt_user_id` FOREIGN KEY (`last_updated_by_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=306 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_question`
--

LOCK TABLES `alcpt_question` WRITE;
/*!40000 ALTER TABLE `alcpt_question` DISABLE KEYS */;
INSERT INTO `alcpt_question` VALUES (1,3,NULL,'He is ____ in the military service.',1,2,0,0,'2019-05-19 16:18:54.592000','2020-01-04 02:48:04.334091',0,1,1,1,NULL),(2,4,NULL,'What kind of missile that distance is from 1000 km to 3000km?',1,1,0,0,'2019-12-13 12:34:07.004452','2019-12-20 05:31:24.136974',0,1,1,1,''),(3,4,NULL,'Which of the following options matches accuracy, durability, and fitness?',1,4,0,0,'2019-12-14 06:48:42.496852','2020-01-05 21:24:59.109753',0,1,1,1,''),(5,3,NULL,'If he  ____ his sweater, he wouldn’t have caught a cold.',1,3,0,0,'2019-12-17 12:03:07.417097','2019-12-31 06:37:14.617994',0,1,1,1,''),(6,4,NULL,'\"Victory is still measured by foot.\" is a common saying in the Indian Army.\r\nThis means that, while many types of units fight in a war, it is the __________ who ultimately win or lose wars.',1,4,0,0,'2019-12-17 14:22:04.373493','2020-01-05 00:04:41.068604',0,1,1,1,''),(23,4,NULL,'The rule of ______ in UO are often very strict in order to minimize collateral damage.',1,3,0,0,'2019-12-18 13:19:04.544839','2020-01-05 00:04:41.045340',0,1,1,1,''),(28,1,'/media/question_28',NULL,1,1,0,0,'2019-12-18 16:30:52.424219','2019-12-31 07:54:35.203196',0,1,1,1,'鄧紫棋太正'),(29,3,NULL,'I can\'t go with you ______ I\'m busy.',1,1,0,0,'2019-12-18 12:24:40.346544','2019-12-31 06:14:52.720692',0,1,1,1,''),(30,3,NULL,'They have been waiting for me ______ 5 o\'clock.',1,2,0,0,'2019-12-18 12:26:59.413803','2019-12-28 16:10:17.898472',0,1,1,1,''),(31,3,NULL,'Most people ______ to red newspapers.',1,3,0,0,'2019-12-18 12:29:04.000232','2020-01-04 02:48:04.336144',0,1,1,1,''),(32,3,NULL,'John would have called the police if he ____ the accident.',1,3,0,0,'2019-12-18 12:41:20.098003','2020-01-04 02:48:04.343337',0,1,1,1,''),(33,3,NULL,'He finished _____ his tape.',1,2,0,0,'2019-12-18 12:44:37.305665','2019-12-31 06:37:14.613518',0,1,1,1,''),(34,3,NULL,'He left the office early ____ he could do some shopping.',1,3,0,0,'2019-12-18 12:46:07.538020','2020-01-04 02:48:04.338382',0,1,1,1,''),(35,3,NULL,'______ you mind closing the window?',1,3,0,0,'2019-12-18 12:46:52.892223','2019-12-31 06:37:14.602387',0,1,1,1,''),(36,3,NULL,'You ______ review this lesson before you take the test.',1,3,0,0,'2019-12-18 12:50:56.110807','2019-12-31 06:14:52.737876',0,1,1,1,''),(37,3,NULL,'He has been studying English _____ four years.',1,2,0,0,'2019-12-18 12:52:35.977609','2019-12-31 06:37:14.620135',0,1,1,1,''),(40,3,NULL,'The visibility was poor yesterday. I _______.',1,1,0,0,'2019-12-18 13:09:06.167496','2020-01-04 02:48:04.340642',0,1,1,1,''),(41,3,NULL,'Howard finished ________ because he was the fastest.',1,3,0,0,'2019-12-18 13:11:47.679947','2019-12-28 16:10:17.894602',0,1,1,1,''),(42,3,NULL,'Get the red book. _______ is on the shelf.',1,2,0,0,'2019-12-18 13:14:11.897504','2019-12-31 06:37:14.610293',0,1,1,1,''),(43,3,NULL,'I am going _______ to buy a new car.',1,4,0,0,'2019-12-18 13:15:43.150014','2020-01-04 02:48:04.350393',0,1,1,1,''),(44,3,NULL,'The weather is ______ today than it was last night.',1,2,0,0,'2019-12-18 13:16:38.833223','2020-01-04 02:48:04.330994',0,1,1,1,''),(45,3,NULL,'In the U.S., conversation is _______ proper during meals.',1,1,0,0,'2019-12-18 13:34:36.708340','2019-12-31 06:37:14.607860',0,1,1,1,''),(46,3,NULL,'______ spears for weapons, the men hunted wild animals.',1,3,0,0,'2019-12-18 13:38:41.449990','2019-12-31 06:14:52.717378',0,1,1,1,''),(47,3,NULL,'Aircraft pilots communicate ______ control towers.',1,3,0,0,'2019-12-18 13:39:49.363301','2020-01-04 02:48:04.347086',0,1,1,1,''),(48,3,NULL,'Did the students ______ a lot of homework last night?',1,2,0,0,'2019-12-18 13:40:48.026545','2020-01-04 02:48:04.324368',0,1,1,1,''),(49,4,NULL,'The ______ is a common military firearm. Soldiers fire it from the shoulder. It has a built-in sight.',1,1,0,0,'2019-12-20 06:58:58.709023','2020-01-05 00:04:41.057392',0,1,1,1,''),(50,4,NULL,'In fact, ________ have great symbolic meaning. When a unit is defeated, the commanding officer often gives his sidearm to the enemy commander.',1,0,0,0,'2019-12-20 07:02:22.291929','2019-12-22 06:16:23.814622',0,1,1,1,''),(51,4,NULL,'Small mortars are _______ and used by infantry units.',1,3,0,0,'2019-12-20 07:20:14.774868','2020-01-05 21:24:59.105996',0,1,1,1,''),(52,5,NULL,'What does the passage say about tanks?',1,1,0,0,'2019-12-20 07:24:04.722459','2019-12-28 06:24:19.968214',0,1,1,1,''),(53,4,NULL,'Joe could not find a job that he really wanted. Therefore, he felt very _______.',1,2,0,0,'2019-12-21 19:15:16.742985','2019-12-31 06:34:15.725181',0,1,1,1,''),(54,4,NULL,'I need someone to help me solve this _______ math problem. It is not easy for me to understand.',1,1,0,0,'2019-12-21 19:17:11.091771','2019-12-31 06:34:15.695076',0,1,1,1,''),(55,4,NULL,'When you are depressed, try to replace all your _______ thoughts with positive ones.',1,0,0,0,'2019-12-21 19:18:18.603990','2019-12-22 06:04:24.235730',0,1,1,1,''),(56,4,NULL,'The letter _______, so you should reply to it as soon as possible.',1,0,0,0,'2019-12-21 19:20:47.518982','2019-12-22 06:08:57.656825',0,1,1,1,''),(57,4,NULL,'The old building has been discovered to be _______. It is vacant precisely for this reason.',1,1,0,0,'2019-12-21 19:22:11.623838','2019-12-28 06:24:19.951806',0,1,1,1,''),(58,4,NULL,'Scientists have _______ that the greenhouse effect caused global warming.',1,3,0,0,'2019-12-21 19:24:19.309120','2020-01-05 21:24:59.111730',0,1,1,1,''),(59,4,NULL,'Bobby cared a lot about his _____ at home and asked his parents not to go through his things without his permission.',1,1,0,0,'2019-12-21 19:32:03.154157','2020-01-05 00:04:41.054295',0,1,1,1,''),(60,3,NULL,'The new manager is a real gentleman. He is  kind and humble, totally different from the former manager,\r\nwho was _____ and bossy.',1,3,0,0,'2019-12-21 19:33:47.066982','2020-01-04 02:48:04.327577',0,1,1,1,''),(61,4,NULL,'The weather bureau _____ that the typhoon would bring strong winds and heavy rains, and warned everyone of the possible danger.',1,1,0,0,'2019-12-21 19:35:38.516608','2020-01-05 21:24:59.107983',0,1,1,1,''),(62,4,NULL,'Different airlines have different _____ for carry-on luggage, but many international airlines limit a carry-on piece to 7 kilograms.',1,3,0,0,'2019-12-22 03:06:55.597684','2020-01-05 00:04:41.041391',0,1,1,1,''),(63,4,NULL,'To reach the goal of making her company a market leader, Michelle _______ a plan to open ten new stores around the country this year.',1,0,0,0,'2019-12-24 12:54:51.363684','2019-12-29 07:04:49.410888',0,1,1,1,''),(64,4,NULL,'Silence in some way is as _____ as speech. It can be used to show, for example, disagreement or lack\r\nof interest.',1,1,0,0,'2019-12-25 08:09:16.845920','2020-01-05 00:04:41.065637',0,1,1,1,''),(65,4,NULL,'This TV program is designed for children, _____ for those under five. It contains no violence or strong language.',1,1,0,0,'2019-12-25 08:10:20.484738','2019-12-31 07:36:05.334955',0,1,1,1,''),(66,4,NULL,'Tommy, please put away the toys in the box, or you might _____ on them and hurt yourself.\r\n',1,0,0,0,'2019-12-25 08:11:09.275821','2019-12-29 07:04:05.514787',0,1,1,1,''),(67,4,NULL,'The _____ costume party, held every September, is one of the biggest events of the school year.',1,0,0,0,'2019-12-25 08:12:06.799790','2019-12-29 07:05:28.515026',0,1,1,1,''),(68,4,NULL,'In a job interview, attitude and personality are usually important _____ that influence the decision of the interviewers.',1,1,0,0,'2019-12-25 08:13:02.205312','2019-12-31 06:34:15.727468',0,1,1,1,''),(69,4,NULL,'The snow-capped mountain is described so _____ in the book that the scene seems to come alive in\r\nfront of the reader’s eyes.',1,0,0,0,'2019-12-25 08:14:17.086109','2019-12-29 07:24:30.386602',0,1,1,1,''),(70,4,NULL,'. Surrounded by flowers blooming and birds _____ merrily, the Wangs had a good time hiking in the\r\nnational park.\r\n',1,2,0,0,'2019-12-25 08:15:19.386222','2020-01-04 21:29:45.162135',0,1,1,1,''),(71,4,NULL,'It is essential for us to maintain constant _____ with our friends to ensure that we have someone to talk to in times of need.',1,2,0,0,'2019-12-25 08:16:08.286657','2020-01-05 21:24:59.096061',0,1,1,1,''),(72,4,NULL,'The young generation in this country has shown less interest in factory work and other _____ labor jobs, such as house construction and fruit picking.',1,2,0,0,'2019-12-25 08:17:04.767922','2019-12-31 07:36:05.361567',0,1,1,1,''),(73,4,NULL,'Mangoes are a _____ fruit here in Taiwan; most of them reach their peak of sweetness in July.',1,1,0,0,'2019-12-25 08:18:41.941366','2019-12-31 06:34:15.717730',0,1,1,1,''),(74,4,NULL,'Writing term papers and giving oral reports are typical course _____ for college students.',1,0,0,0,'2019-12-25 08:21:44.015877','2019-12-29 07:00:09.861395',0,1,1,1,''),(75,4,NULL,'If we work hard to _____ our dreams when we are young, we will not feel that we missed out on\r\nsomething when we get old.',1,1,0,0,'2019-12-25 08:23:09.645550','2020-01-04 23:49:20.854656',0,1,1,1,''),(76,4,NULL,'Few people will trust you if you continue making _____ promises and never make efforts to keep them.',1,0,0,0,'2019-12-25 08:24:12.164544','2019-12-29 08:02:17.573941',0,1,1,1,''),(77,4,NULL,'Becky _____ her ankle while she was playing tennis last week. Now it still hurts badly.',1,0,0,0,'2019-12-25 08:25:01.108884','2019-12-29 08:03:38.745798',0,1,1,1,''),(78,4,NULL,'Research shows that men and women usually think differently. For example, they have quite different\r\n_____ about what marriage means in their life.',1,1,0,0,'2019-12-25 08:26:18.111187','2020-01-04 21:29:45.167797',0,1,1,1,''),(79,4,NULL,'The new manager is very _____. For instance, the employees are given much shorter deadlines for the\r\nsame tasks than before.',1,2,0,0,'2019-12-25 08:27:04.893096','2020-01-05 21:24:59.092478',0,1,1,1,''),(80,4,NULL,'While the couple were looking _____ for their missing children, the kids were actually having fun in\r\nthe woods nearby.',1,0,0,0,'2019-12-25 08:28:00.176428','2019-12-29 07:01:20.296228',0,1,1,1,''),(81,4,NULL,'After delivering a very powerful speech, the award winner was _____ by a group of fans asking for her signature.',1,1,0,0,'2019-12-25 08:29:05.623123','2020-01-05 00:04:41.050584',0,1,1,1,''),(82,4,NULL,'The interviewees were trying very hard to _____ the interviewers that they were very capable and\r\nshould be given the job.',1,1,0,0,'2019-12-25 08:30:01.784400','2020-01-04 23:49:20.865993',0,1,1,1,''),(83,4,NULL,'After the first snow of the year, the entire grassland disappeared under a _____ of snow.\r\n',1,0,0,0,'2019-12-25 08:31:04.892996','2019-12-29 08:05:37.761839',0,1,1,1,''),(84,4,NULL,'Peter likes books with wide _____, which provide him with enough space to write notes.',1,0,0,0,'2019-12-25 08:31:57.216138','2019-12-29 07:53:46.052659',0,1,1,1,''),(85,4,NULL,'At the beginning of the semester, the teacher told the students that late assignments would receive a low grade as a _____.',1,0,0,0,'2019-12-25 08:32:54.928532','2019-12-29 08:04:07.688035',0,1,1,1,''),(86,4,NULL,'Various studies have been _____ in this hospital to explore the link between a high-fat diet and cancer.',1,1,0,0,'2019-12-25 08:33:54.946537','2020-01-04 23:49:20.852257',0,1,1,1,''),(87,4,NULL,'Intense, fast-moving fires raged across much of California last week. The _____ firestorm has claimed the lives of thirty people.',1,0,0,0,'2019-12-25 08:35:05.531916','2019-12-29 07:57:42.412147',0,1,1,1,''),(88,4,NULL,'John’s clock is not functioning _____. The alarm rings even when it’s not set to go off.',1,1,0,0,'2019-12-25 23:49:18.117495','2019-12-31 07:36:05.378331',0,1,1,1,''),(89,4,NULL,'Michael has decided to _____ a career in physics and has set his mind on becoming a professor.',1,2,0,0,'2019-12-25 23:50:17.718596','2020-01-05 00:04:41.062973',0,1,1,1,''),(90,4,NULL,'Peter plans to hike in a _____ part of Africa, where he might not meet another human being for days.',1,0,0,0,'2019-12-25 23:51:05.015013','2019-12-29 07:53:06.382141',0,1,1,1,''),(91,4,NULL,'People in this community tend to _____ with the group they belong to, and often put group interests\r\nbefore personal ones.',1,1,0,0,'2019-12-25 23:51:50.144780','2020-01-04 23:49:20.861584',0,1,1,1,''),(92,4,NULL,'I mistook the man for a well-known actor and asked for his autograph; it was really _____.',1,2,0,0,'2019-12-25 23:52:38.895877','2020-01-04 23:49:20.856671',0,1,1,1,''),(93,4,NULL,'After spending most of her salary on rent and food, Amelia _____ had any money left for\r\nentertainment and other expenses.',1,3,0,0,'2019-12-25 23:53:25.278731','2020-01-05 21:24:59.098828',0,1,1,1,''),(94,4,NULL,'In the Bermuda Triangle, a region in the western part of the North Atlantic Ocean, some airplanes and ships were reported to have mysteriously disappeared without a _____.',1,0,0,0,'2019-12-25 23:54:19.531493','2019-12-29 07:58:12.689591',0,1,1,1,''),(95,4,NULL,'Shouting greetings and waving a big sign, Tony _____ the passing shoppers to visit his shop and buy\r\nthe freshly baked bread.',1,0,0,0,'2019-12-25 23:55:00.695972','2019-12-29 07:42:07.984730',0,1,1,1,''),(96,4,NULL,'With a continuous 3 km stretch of golden sand, the beach attracts artists around the world each\r\nsummer to create amazing _____ with its fine soft sand.\r\n',1,0,0,0,'2019-12-25 23:55:58.308430','2019-12-29 07:01:00.974665',0,1,1,1,''),(97,4,NULL,'The clouds parted and a _____ of light fell on the church, through the windows, and onto the floor.',1,0,0,0,'2019-12-25 23:56:54.583673','2019-12-29 07:40:00.523364',0,1,1,1,''),(98,4,NULL,'. Instead of a gift, Tim’s grandmother always _____ some money in the birthday card she gave him.',1,1,0,0,'2019-12-25 23:57:42.612180','2020-01-05 21:24:59.104271',0,1,1,1,''),(99,4,NULL,'While winning a gold _____ is what every Olympic athlete dreams of, it becomes meaningless if it is\r\nachieved by cheating.',1,1,0,0,'2019-12-25 23:58:36.839143','2020-01-04 21:29:45.164267',0,1,1,1,''),(100,4,NULL,'The thief went into the apartment building and stole some jewelry. He then _____ himself as a\r\nsecurity guard and walked out the front gate.',1,1,0,0,'2019-12-25 23:59:21.652007','2020-01-05 21:24:59.101337',0,1,1,1,''),(101,4,NULL,'Due to numerous accidents that occurred while people were playing Pokémon GO, players were\r\nadvised to be _____ of possible dangers in the environment.',1,0,0,0,'2019-12-26 00:00:17.186295','2019-12-29 08:02:40.199485',0,1,1,1,''),(102,4,NULL,'Sherlock Holmes, a detective in a popular fiction series, has impressed readers with his amazing\r\npowers of _____ and his knowledge of trivial facts.',1,1,0,0,'2019-12-26 00:01:02.927972','2020-01-04 23:49:20.868055',0,1,1,1,''),(103,4,NULL,'Posters of the local rock band were displayed in store windows to promote the sale of their _____ tickets.',1,0,0,0,'2019-12-26 00:02:19.550592','2019-12-29 07:52:45.445505',0,1,1,1,''),(104,4,NULL,'Maria didn’t want to deliver the bad news to David about his failing the job interview. She herself was quite _____ about it.',1,1,0,0,'2019-12-26 00:03:11.445915','2020-01-04 23:49:20.870028',0,1,1,1,''),(105,4,NULL,'The newcomer speaks with a strong Irish _____; he must be from Ireland.',1,2,0,0,'2019-12-26 00:03:58.416180','2020-01-04 21:29:45.169357',0,1,1,1,''),(106,4,NULL,'Although Maggie has been physically _____ to her wheelchair since the car accident, she does not limit herself to indoor activities.',1,0,0,0,'2019-12-26 00:04:53.752826','2019-12-29 08:04:37.110019',0,1,1,1,''),(107,4,NULL,'All passengers riding in cars are required to fasten their seatbelts in order to reduce the risk of _____ in case of an accident.',1,1,0,0,'2019-12-26 00:05:52.019692','2020-01-05 21:24:59.113384',0,1,1,1,''),(108,4,NULL,'The principal of this school is a man of exceptional _____. He sets aside a part of his salary for a\r\nscholarship fund for children from needy families.',1,1,0,0,'2019-12-26 00:15:53.205410','2019-12-31 07:36:05.384021',0,1,1,1,''),(109,4,NULL,'The science teacher always _____ the use of the laboratory equipment before she lets her students use it on their own.',1,0,0,0,'2019-12-26 00:16:45.679511','2019-12-29 07:25:44.003478',0,1,1,1,''),(110,4,NULL,'Most of the area is covered by woods, where bird species are so _____ that it is a paradise for\r\nbirdwatchers.',1,0,0,0,'2019-12-26 00:17:32.236214','2019-12-29 07:55:33.491791',0,1,1,1,''),(111,4,NULL,'In most cases, the committee members can reach agreement quickly. _____, however, they differ\r\ngreatly in opinion and have a hard time making decisions.\r\n',1,1,0,0,'2019-12-26 00:18:10.994916','2020-01-05 00:04:41.060497',0,1,1,1,''),(112,4,NULL,'Many people try to save a lot of money before _____, since having enough money would give them a\r\nsense of security for their future.',1,0,0,0,'2019-12-26 00:18:52.005813','2019-12-29 07:56:31.811162',0,1,1,1,''),(113,4,NULL,'In winter, our skin tends to become dry and _____, a problem which is usually treated by applying\r\nlotions or creams.',1,3,0,0,'2019-12-26 00:19:29.820016','2020-01-04 21:29:45.166123',0,1,1,1,''),(114,4,NULL,'Benson married Julie soon after he had _____ her heart and gained her parents’ approval.',1,1,0,0,'2019-12-26 00:20:11.296244','2020-01-04 23:49:20.863780',0,1,1,1,''),(115,4,NULL,'The recent flood completely _____ my parents’ farm. The farmhouse and fruit trees were all gone and\r\nnothing was left.',1,0,0,0,'2019-12-26 00:20:51.224284','2019-12-29 07:31:48.027941',0,1,1,1,''),(116,4,NULL,'The results of this survey are not reliable because the people it questioned were not a typical or _____ sample of the entire population that was studied.',1,0,0,0,'2019-12-26 00:21:34.775035','2019-12-29 07:26:37.548942',0,1,1,1,''),(117,4,NULL,'In line with the worldwide green movement, carmakers have been working hard to make their new\r\nmodels more _____ friendly to reduce pollution.',1,2,0,0,'2019-12-26 00:22:25.904673','2020-01-04 21:29:45.178508',0,1,1,1,''),(125,1,'/media/question_125',NULL,1,1,0,0,'2019-12-26 03:09:41.553574','2019-12-31 07:18:27.200229',0,1,1,1,''),(126,1,'/media/question_126',NULL,1,1,0,0,'2019-12-26 03:22:19.579554','2020-01-13 11:38:10.342565',0,1,1,1,''),(127,1,'/media/question_127',NULL,1,2,0,0,'2019-12-26 03:27:43.982979','2019-12-31 07:18:27.211187',0,1,1,1,''),(128,1,'/media/question_128',NULL,1,1,0,0,'2019-12-26 03:30:18.122344','2020-01-04 12:34:56.761634',0,1,1,1,''),(129,1,'/media/question_129',NULL,1,0,0,0,'2019-12-26 03:33:19.089663','2019-12-29 08:09:08.665241',0,1,1,1,''),(130,1,'/media/question_130',NULL,1,1,0,0,'2019-12-26 03:37:09.229280','2019-12-31 07:54:35.209923',0,1,1,1,''),(131,1,'/media/question_131',NULL,1,2,0,0,'2019-12-26 06:04:50.722261','2019-12-31 07:18:27.222232',0,1,1,1,''),(132,1,'/media/question_132',NULL,1,0,0,0,'2019-12-26 06:08:58.012976','2019-12-29 08:11:47.317205',0,1,1,1,''),(133,1,'/media/question_133',NULL,1,4,0,0,'2019-12-26 06:11:53.890894','2020-01-04 12:34:56.776363',0,1,1,1,''),(134,1,'/media/question_134',NULL,1,4,0,0,'2019-12-26 06:17:00.972463','2020-01-13 11:38:10.355838',0,1,1,1,''),(135,1,'/media/question_135',NULL,1,2,0,0,'2019-12-26 06:20:19.431249','2019-12-31 07:18:27.216496',0,1,1,1,''),(136,1,'/media/question_136',NULL,1,1,0,0,'2019-12-26 06:23:48.337419','2019-12-31 06:12:07.973605',0,1,1,1,''),(137,1,'/media/question_137',NULL,1,3,0,0,'2019-12-26 06:26:58.197782','2019-12-31 07:54:35.212413',0,1,1,1,''),(138,1,'/media/question_138',NULL,1,0,0,0,'2019-12-26 06:32:30.462517','2019-12-29 08:19:41.911807',0,2,1,1,'聽不太懂'),(139,1,'/media/question_139',NULL,1,2,0,0,'2019-12-26 06:35:12.781862','2019-12-31 07:54:35.198719',0,1,1,1,''),(140,1,'/media/question_140',NULL,1,3,0,0,'2019-12-26 06:39:23.967520','2020-01-04 12:34:56.771682',0,1,1,1,''),(141,1,'/media/question_141',NULL,1,2,0,0,'2019-12-26 06:42:31.268421','2019-12-31 07:18:27.218402',0,1,1,1,''),(142,1,'/media/question_142',NULL,1,2,0,0,'2019-12-26 06:46:30.796314','2020-01-04 12:34:56.783912',0,1,1,1,''),(143,1,'/media/question_143',NULL,1,1,0,0,'2019-12-26 06:49:39.177467','2020-01-04 12:34:56.786546',0,1,1,1,''),(144,1,'/media/question_144',NULL,1,2,0,0,'2019-12-26 06:54:08.787461','2019-12-31 06:13:50.084035',0,1,1,1,''),(145,1,'/media/question_145',NULL,1,0,0,0,'2019-12-26 07:07:02.339676','2019-12-29 08:26:50.345973',0,1,1,1,''),(146,1,'/media/question_146',NULL,1,2,0,0,'2019-12-26 07:13:59.679023','2020-01-04 12:34:56.791974',0,1,1,1,''),(147,1,'/media/question_147',NULL,1,3,0,0,'2019-12-26 07:17:00.663406','2020-01-04 12:34:56.774152',0,1,1,1,''),(148,1,'/media/question_148',NULL,1,3,0,0,'2019-12-26 07:23:00.514240','2020-01-04 12:34:56.766817',0,1,1,1,''),(149,1,'/media/question_149',NULL,1,3,0,0,'2019-12-26 07:26:47.400984','2019-12-31 07:54:35.196225',0,1,1,1,''),(150,1,'/media/question_150',NULL,1,0,0,0,'2019-12-26 07:41:56.109196','2020-01-07 18:55:35.622692',0,0,1,1,'雖然可以選出答案，但是音檔缺少問句的部分'),(151,1,'/media/question_151',NULL,1,0,0,0,'2019-12-26 07:45:42.139566','2019-12-29 08:31:26.014425',0,1,1,1,''),(152,1,'/media/question_152',NULL,1,3,0,0,'2019-12-26 07:50:29.395450','2020-01-04 12:34:56.789016',0,1,1,1,''),(153,1,'/media/question_153',NULL,1,1,0,0,'2019-12-26 07:53:08.891499','2019-12-31 06:13:50.078536',0,1,1,1,''),(154,1,'/media/question_154',NULL,1,2,0,0,'2019-12-26 07:58:00.692136','2020-01-04 12:34:56.769386',0,1,1,1,''),(155,1,'/media/question_155',NULL,1,0,0,0,'2019-12-31 00:46:56.236122','2020-01-05 15:11:45.321963',0,1,1,1,''),(156,1,'/media/question_156',NULL,1,0,0,0,'2019-12-31 00:54:23.533230','2020-01-05 15:12:17.080930',0,1,1,1,''),(157,1,'/media/question_157',NULL,1,0,0,0,'2019-12-31 00:55:37.802431','2020-01-05 15:12:37.081029',0,1,1,1,''),(158,1,'/media/question_158',NULL,1,1,0,0,'2019-12-31 00:57:01.360611','2020-01-13 11:38:10.340016',0,1,1,1,''),(159,1,'/media/question_159',NULL,1,0,0,0,'2019-12-31 00:58:11.312295','2020-01-05 15:13:11.438798',0,1,1,1,''),(160,1,'/media/question_160',NULL,1,1,0,0,'2019-12-31 01:00:01.545383','2020-01-13 11:38:10.325980',0,1,1,1,''),(161,1,'/media/question_161',NULL,1,0,0,0,'2019-12-31 01:01:05.176691','2020-01-05 15:22:34.277400',0,2,1,1,'聽不太懂'),(162,1,'/media/question_162',NULL,1,0,0,0,'2019-12-31 01:02:07.772268','2020-01-05 15:17:20.256638',0,1,1,1,''),(163,1,'/media/question_163',NULL,1,0,0,0,'2019-12-31 01:03:17.137776','2020-01-05 15:17:56.691297',0,1,1,1,''),(164,1,'/media/question_164',NULL,1,0,0,0,'2019-12-31 01:04:38.150599','2020-01-05 15:19:45.097489',0,1,1,1,''),(165,1,'/media/question_165',NULL,1,0,0,0,'2019-12-31 01:06:13.342088','2020-01-05 15:18:19.750306',0,1,1,1,''),(166,1,'/media/question_166',NULL,1,0,0,0,'2019-12-31 01:08:24.370943','2020-01-05 15:20:00.980976',0,1,1,1,''),(167,1,'/media/question_167',NULL,1,0,0,0,'2019-12-31 01:10:05.525811','2020-01-05 15:20:42.112127',0,1,1,1,''),(168,1,'/media/question_168',NULL,1,0,0,0,'2019-12-31 01:11:33.647824','2020-01-05 15:20:26.266459',0,2,1,1,'重複了'),(169,1,'/media/question_169',NULL,1,0,0,0,'2019-12-31 01:15:53.747340','2020-01-05 15:21:00.423631',0,2,1,1,'重複了'),(170,1,'/media/question_170',NULL,1,0,0,0,'2019-12-31 01:17:55.752327','2020-01-05 15:22:23.947015',0,2,1,1,'聽不太懂\r\n\r\n'),(171,1,'/media/question_171',NULL,1,0,0,0,'2019-12-31 01:19:06.620106','2020-01-05 15:22:01.353229',0,1,1,1,''),(172,1,'/media/question_172',NULL,1,0,0,0,'2019-12-31 01:20:07.903854','2020-01-05 15:22:49.883061',0,1,1,1,''),(173,1,'/media/question_173',NULL,1,1,0,0,'2019-12-31 01:21:08.906488','2020-01-13 11:38:10.353336',0,1,1,1,''),(174,1,'/media/question_174',NULL,1,0,0,0,'2019-12-31 01:22:37.554419','2020-01-05 15:23:45.597508',0,2,1,1,'重複'),(175,2,'/media/question_175',NULL,1,0,0,0,'2019-12-31 01:25:08.452279','2020-01-05 15:24:20.447007',0,1,1,1,''),(176,2,'/media/question_176',NULL,1,0,0,0,'2019-12-31 01:35:26.171595','2020-01-05 15:24:52.591109',0,1,1,1,''),(177,2,'/media/question_177',NULL,1,0,0,0,'2019-12-31 01:36:23.550289','2020-01-05 15:25:17.372542',0,1,1,1,''),(178,2,'/media/question_178',NULL,1,0,0,0,'2019-12-31 03:09:49.996004','2020-01-05 15:25:35.418968',0,1,1,1,''),(179,2,'/media/question_179',NULL,1,0,0,0,'2019-12-31 03:22:18.400906','2020-01-05 15:25:50.164400',0,1,1,1,''),(180,2,'/media/question_180',NULL,1,0,0,0,'2019-12-31 03:36:34.520015','2020-01-05 15:26:06.850981',0,1,1,1,''),(181,2,'/media/question_181',NULL,1,0,0,0,'2019-12-31 03:37:49.760395','2020-01-05 15:26:21.594083',0,1,1,1,''),(182,2,'/media/question_182',NULL,1,0,0,0,'2019-12-31 03:40:20.103403','2020-01-05 15:26:56.489812',0,1,1,1,''),(183,2,'/media/question_183',NULL,1,0,0,0,'2019-12-31 03:41:32.399519','2020-01-05 15:27:26.916496',0,1,1,1,''),(184,2,'/media/question_184',NULL,1,0,0,0,'2019-12-31 03:43:09.988883','2020-01-05 15:27:52.779861',0,1,1,1,''),(186,1,'/media/question_186',NULL,1,1,0,0,'2020-01-01 16:02:50.237482','2020-01-13 11:38:10.346808',0,1,1,1,''),(187,1,'/media/question_187',NULL,1,0,0,0,'2020-01-01 16:05:52.080960','2020-01-05 15:28:38.978722',0,1,1,1,''),(188,1,'/media/question_188',NULL,1,0,0,0,'2020-01-01 16:07:35.962083','2020-01-05 15:29:03.678562',0,1,1,1,''),(189,1,'/media/question_189',NULL,1,0,0,0,'2020-01-01 16:10:14.396142','2020-01-05 15:29:24.297734',0,1,1,1,''),(190,1,'/media/question_190',NULL,1,0,0,0,'2020-01-01 16:11:52.280240','2020-01-05 15:29:40.840022',0,1,1,1,''),(191,1,'/media/question_191',NULL,1,0,0,0,'2020-01-01 16:13:13.976888','2020-01-05 15:29:57.669338',0,1,1,1,''),(192,1,'/media/question_192',NULL,1,0,0,0,'2020-01-01 16:15:31.756286','2020-01-05 15:30:41.989683',0,1,1,1,''),(193,1,'/media/question_193',NULL,1,0,0,0,'2020-01-01 16:16:28.205044','2020-01-05 15:31:49.610846',0,1,1,1,''),(194,1,'/media/question_194',NULL,1,0,0,0,'2020-01-01 16:17:21.729672','2020-01-05 15:32:32.523074',0,2,1,1,''),(195,1,'/media/question_195',NULL,1,0,0,0,'2020-01-01 16:19:14.579817','2020-01-05 15:32:53.180289',0,1,1,1,''),(196,1,'/media/question_196',NULL,1,0,0,0,'2020-01-01 16:20:05.224447','2020-01-05 15:33:21.314140',0,1,1,1,''),(197,1,'/media/question_197',NULL,1,0,0,0,'2020-01-01 16:22:03.613290','2020-01-07 18:49:53.086362',0,1,1,1,''),(198,1,'/media/question_198',NULL,1,0,0,0,'2020-01-01 16:23:41.872538','2020-01-05 15:34:47.122911',0,1,1,1,''),(199,1,'/media/question_199',NULL,1,0,0,0,'2020-01-01 16:24:42.730861','2020-01-05 15:35:01.591084',0,1,1,1,''),(200,1,'/media/question_200',NULL,1,0,0,0,'2020-01-01 16:25:42.844632','2020-01-05 15:35:23.841275',0,1,1,1,''),(201,1,'/media/question_201',NULL,1,0,0,0,'2020-01-01 23:47:09.940770','2020-01-05 15:37:08.170545',0,1,1,1,''),(202,1,'/media/question_202',NULL,1,0,0,0,'2020-01-01 23:48:31.777422','2020-01-05 15:38:11.761794',0,1,1,1,''),(203,1,'/media/question_203',NULL,1,0,0,0,'2020-01-01 23:49:40.747913','2020-01-05 15:38:32.996780',0,1,1,1,''),(204,1,'/media/question_204',NULL,1,0,0,0,'2020-01-01 23:51:07.607177','2020-01-07 18:49:55.693550',0,1,1,1,''),(205,1,'/media/question_205',NULL,1,0,0,0,'2020-01-02 00:12:15.013826','2020-01-05 15:41:52.243906',0,1,1,1,''),(206,1,'/media/question_206',NULL,1,0,0,0,'2020-01-02 00:15:34.706242','2020-01-05 15:42:50.263468',0,1,1,1,''),(207,1,'/media/question_207',NULL,1,0,0,0,'2020-01-02 00:16:36.994048','2020-01-05 15:43:00.974174',0,1,1,1,''),(208,1,'/media/question_208',NULL,1,0,0,0,'2020-01-02 00:18:15.199358','2020-01-05 15:43:14.060697',0,1,1,1,''),(209,1,'/media/question_209',NULL,1,1,0,0,'2020-01-02 00:19:25.499366','2020-01-13 11:38:10.349167',0,1,1,1,''),(210,1,'/media/question_210',NULL,1,0,0,0,'2020-01-02 03:13:02.891840','2020-01-05 15:44:15.737317',0,1,1,1,''),(211,1,'/media/question_211',NULL,1,0,0,0,'2020-01-02 03:16:06.203910','2020-01-05 15:45:03.001432',0,1,1,1,''),(212,1,'/media/question_212',NULL,1,0,0,0,'2020-01-02 03:18:03.862115','2020-01-05 15:45:15.955899',0,1,1,1,''),(213,1,'/media/question_213',NULL,1,0,0,0,'2020-01-02 03:20:28.900512','2020-01-05 15:46:07.164473',0,1,1,1,''),(214,1,'/media/question_214',NULL,1,0,0,0,'2020-01-02 03:22:59.682877','2020-01-05 15:46:17.296623',0,1,1,1,''),(215,1,'/media/question_215',NULL,1,1,0,0,'2020-01-02 03:25:33.637488','2020-01-13 11:38:10.351524',0,1,1,1,''),(216,1,'/media/question_216',NULL,1,0,0,0,'2020-01-02 03:27:29.396692','2020-01-02 03:27:36.175487',0,3,1,NULL,''),(217,1,'/media/question_217',NULL,1,0,0,0,'2020-01-02 03:29:05.277246','2020-01-05 15:49:22.615923',0,1,1,1,''),(218,1,'/media/question_218',NULL,1,0,0,0,'2020-01-02 03:30:11.193289','2020-01-05 15:53:10.375314',0,1,1,1,''),(219,1,'/media/question_219',NULL,1,0,0,0,'2020-01-02 03:31:42.891768','2020-01-05 15:49:41.582991',0,1,1,1,''),(220,1,'/media/question_220',NULL,1,0,0,0,'2020-01-02 03:35:04.615173','2020-01-05 15:50:41.728205',0,1,1,1,''),(221,1,'/media/question_221',NULL,1,0,0,0,'2020-01-02 03:43:08.392012','2020-01-02 03:43:16.942765',0,3,1,NULL,''),(222,1,'/media/question_222',NULL,1,0,0,0,'2020-01-02 14:32:19.212100','2020-01-02 14:32:26.840114',0,3,1,NULL,''),(223,1,'/media/question_223',NULL,1,0,0,0,'2020-01-02 14:34:10.631745','2020-01-02 14:34:18.504946',0,3,1,NULL,''),(224,1,'/media/question_224',NULL,1,0,0,0,'2020-01-02 14:35:55.005009','2020-01-02 14:36:03.328703',0,3,1,NULL,''),(225,1,'/media/question_225',NULL,1,0,0,0,'2020-01-02 14:37:26.922694','2020-01-02 14:37:33.572050',0,3,1,NULL,''),(226,1,'/media/question_226',NULL,1,0,0,0,'2020-01-02 14:39:47.878449','2020-01-02 14:39:56.723049',0,3,1,NULL,''),(227,1,'/media/question_227',NULL,1,0,0,0,'2020-01-02 14:43:14.930114','2020-01-02 14:43:22.563619',0,3,1,NULL,''),(228,1,'/media/question_228',NULL,1,0,0,0,'2020-01-02 14:46:26.029960','2020-01-02 14:46:33.900555',0,3,1,NULL,''),(229,1,'/media/question_229',NULL,1,0,0,0,'2020-01-02 15:18:20.186313','2020-01-02 15:18:31.958765',0,3,1,NULL,''),(230,1,'/media/question_230',NULL,1,0,0,0,'2020-01-02 15:19:26.414794','2020-01-02 15:19:33.347365',0,3,1,NULL,''),(231,1,'/media/question_231',NULL,1,0,0,0,'2020-01-02 15:20:12.842126','2020-01-02 15:31:09.071994',0,3,1,NULL,''),(232,1,'/media/question_232',NULL,1,0,0,0,'2020-01-02 15:21:07.245042','2020-01-02 15:31:06.483094',0,3,1,NULL,''),(233,1,'/media/question_233',NULL,1,0,0,0,'2020-01-02 15:21:45.726040','2020-01-02 15:31:04.107501',0,3,1,NULL,''),(234,1,'/media/question_234',NULL,1,0,0,0,'2020-01-02 15:22:44.457560','2020-01-02 15:31:01.780248',0,3,1,NULL,''),(235,2,'/media/question_235',NULL,1,0,0,0,'2020-01-02 15:23:58.097504','2020-01-02 15:30:59.106867',0,3,1,NULL,''),(236,2,'/media/question_236',NULL,1,0,0,0,'2020-01-02 15:24:37.810894','2020-01-02 15:30:56.662916',0,3,1,NULL,''),(237,2,'/media/question_237',NULL,1,0,0,0,'2020-01-02 15:25:48.764638','2020-01-02 15:30:53.710312',0,3,1,NULL,''),(238,2,'/media/question_238',NULL,1,0,0,0,'2020-01-02 15:26:27.477890','2020-01-02 15:30:50.575993',0,3,1,NULL,''),(239,2,'/media/question_239',NULL,1,0,0,0,'2020-01-02 15:27:22.088590','2020-01-02 15:30:47.934735',0,3,1,NULL,''),(240,2,'/media/question_240',NULL,1,0,0,0,'2020-01-02 15:28:04.153013','2020-01-02 15:30:45.457853',0,3,1,NULL,''),(241,2,'/media/question_241',NULL,1,0,0,0,'2020-01-02 15:28:41.584090','2020-01-02 15:30:42.867420',0,3,1,NULL,''),(242,2,'/media/question_242',NULL,1,0,0,0,'2020-01-02 15:29:17.535518','2020-01-02 15:30:40.322843',0,3,1,NULL,''),(243,2,'/media/question_243',NULL,1,0,0,0,'2020-01-02 15:29:50.534627','2020-01-02 15:30:37.576811',0,3,1,NULL,''),(244,2,'/media/question_244',NULL,1,0,0,0,'2020-01-02 15:30:25.738837','2020-01-02 15:30:34.744566',0,3,1,NULL,''),(245,1,'/media/question_245',NULL,1,0,0,0,'2020-01-02 16:24:50.751925','2020-01-02 16:24:58.264385',0,3,1,NULL,''),(246,1,'/media/question_246',NULL,1,0,0,0,'2020-01-02 16:25:25.555041','2020-01-02 16:25:31.265698',0,3,1,NULL,''),(247,1,'/media/question_247',NULL,1,0,0,0,'2020-01-02 16:26:05.587564','2020-01-02 16:26:11.366827',0,3,1,NULL,''),(248,1,'/media/question_248',NULL,1,0,0,0,'2020-01-02 16:26:43.678631','2020-01-02 16:26:48.644293',0,3,1,NULL,''),(249,1,'/media/question_249',NULL,1,0,0,0,'2020-01-02 16:27:15.779198','2020-01-02 16:27:20.239834',0,3,1,NULL,''),(250,1,'/media/question_250',NULL,1,0,0,0,'2020-01-02 16:27:57.094970','2020-01-02 16:28:03.161953',0,3,1,NULL,''),(251,1,'/media/question_251',NULL,1,0,0,0,'2020-01-02 16:28:31.802595','2020-01-02 16:28:37.276263',0,3,1,NULL,''),(253,1,'/media/question_253',NULL,1,0,0,0,'2020-01-02 16:29:13.338635','2020-01-02 16:29:19.424392',0,3,1,NULL,''),(254,1,'/media/question_254',NULL,1,0,0,0,'2020-01-02 16:34:51.251249','2020-01-02 16:34:56.158289',0,3,1,NULL,''),(255,1,'/media/question_255',NULL,1,0,0,0,'2020-01-02 16:35:21.544493','2020-01-02 16:35:27.366406',0,3,1,NULL,''),(256,1,'/media/question_256',NULL,1,0,0,0,'2020-01-02 16:35:57.793308','2020-01-05 14:24:34.241462',0,1,1,1,''),(257,1,'/media/question_257',NULL,1,0,0,0,'2020-01-02 16:36:45.200118','2020-01-07 18:49:50.847223',0,1,1,1,''),(258,1,'/media/question_258',NULL,1,0,0,0,'2020-01-02 16:37:18.785821','2020-01-05 14:26:38.306852',0,1,1,1,''),(259,1,'/media/question_259',NULL,1,0,0,0,'2020-01-02 16:37:58.174302','2020-01-05 14:27:02.097501',0,1,1,1,''),(260,1,'/media/question_260',NULL,1,0,0,0,'2020-01-02 16:38:37.076677','2020-01-05 14:27:29.898205',0,1,1,1,''),(261,1,'/media/question_261',NULL,1,0,0,0,'2020-01-02 16:39:14.654273','2020-01-05 14:28:05.744955',0,1,1,1,''),(262,1,'/media/question_262',NULL,1,0,0,0,'2020-01-02 16:39:54.846016','2020-01-05 14:29:09.118173',0,1,1,1,''),(263,1,'/media/question_263',NULL,1,0,0,0,'2020-01-02 16:40:40.790361','2020-01-05 14:29:44.762009',0,1,1,1,''),(264,1,'/media/question_264',NULL,1,0,0,0,'2020-01-02 16:41:21.842370','2020-01-05 14:30:15.237614',0,1,1,1,''),(265,1,'/media/question_265',NULL,1,0,0,0,'2020-01-02 16:41:58.145047','2020-01-05 14:30:33.512520',0,1,1,1,''),(266,1,'/media/question_266',NULL,1,0,0,0,'2020-01-02 16:42:40.402035','2020-01-05 14:30:49.633600',0,1,1,1,''),(267,1,'/media/question_267',NULL,1,0,0,0,'2020-01-02 16:43:18.001049','2020-01-05 14:32:13.156813',0,1,1,1,''),(268,1,'/media/question_268',NULL,1,1,0,0,'2020-01-02 16:43:53.009901','2020-01-13 11:38:10.344677',0,1,1,1,''),(269,1,'/media/question_269',NULL,1,1,0,0,'2020-01-02 16:44:28.553077','2020-01-13 11:38:10.336864',0,1,1,1,''),(270,1,'/media/question_270',NULL,1,0,0,0,'2020-01-02 16:45:11.022337','2020-01-05 14:34:11.093120',0,1,1,1,''),(271,1,'/media/question_271',NULL,1,0,0,0,'2020-01-02 16:45:52.218651','2020-01-05 14:34:35.582578',0,1,1,1,''),(272,1,'/media/question_272',NULL,1,0,0,0,'2020-01-02 16:46:26.843378','2020-01-05 14:34:58.416253',0,1,1,1,''),(273,1,'/media/question_273',NULL,1,0,0,0,'2020-01-02 16:47:05.133520','2020-01-05 14:36:24.626508',0,1,1,1,''),(274,1,'/media/question_274',NULL,1,0,0,0,'2020-01-02 16:47:38.563030','2020-01-05 14:37:07.882842',0,1,1,1,''),(275,1,'/media/question_275',NULL,1,0,0,0,'2020-01-02 16:48:19.844277','2020-01-05 14:37:32.657903',0,1,1,1,''),(276,1,'/media/question_276',NULL,1,0,0,0,'2020-01-02 16:48:57.950132','2020-01-05 14:38:00.439193',0,1,1,1,''),(277,1,'/media/question_277',NULL,1,0,0,0,'2020-01-02 16:49:54.338822','2020-01-05 14:38:56.873949',0,1,1,1,''),(278,1,'/media/question_278',NULL,1,0,0,0,'2020-01-02 16:53:59.921940','2020-01-05 14:39:41.463764',0,1,1,1,''),(279,1,'/media/question_279',NULL,1,0,0,0,'2020-01-02 16:54:39.007154','2020-01-05 14:40:06.609586',0,1,1,1,''),(280,1,'/media/question_280',NULL,1,0,0,0,'2020-01-02 16:55:17.770811','2020-01-05 14:40:42.951139',0,1,1,1,''),(281,1,'/media/question_281',NULL,1,0,0,0,'2020-01-02 16:55:49.089345','2020-01-05 14:41:02.735705',0,1,1,1,''),(282,1,'/media/question_282',NULL,1,0,0,0,'2020-01-02 16:56:20.370296','2020-01-05 14:41:24.244081',0,1,1,1,''),(283,1,'/media/question_283',NULL,1,0,0,0,'2020-01-02 16:56:54.991254','2020-01-05 14:41:42.752586',0,1,1,1,''),(284,1,'/media/question_284',NULL,1,0,0,0,'2020-01-02 16:57:23.739157','2020-01-05 14:42:17.248317',0,1,1,1,''),(285,1,'/media/question_285',NULL,1,0,0,0,'2020-01-02 16:57:55.602738','2020-01-05 14:42:54.888778',0,1,1,1,''),(286,1,'/media/question_286',NULL,1,0,0,0,'2020-01-02 16:58:25.652093','2020-01-05 14:46:25.212666',0,1,1,1,''),(287,1,'/media/question_287',NULL,1,0,0,0,'2020-01-02 16:59:01.474151','2020-01-05 14:46:50.852417',0,1,1,1,''),(288,1,'/media/question_288',NULL,1,0,0,0,'2020-01-02 16:59:36.062098','2020-01-05 14:47:17.197148',0,1,1,1,''),(289,1,'/media/question_289',NULL,1,0,0,0,'2020-01-02 17:00:08.406622','2020-01-05 14:47:43.930236',0,1,1,1,''),(290,1,'/media/question_290',NULL,1,0,0,0,'2020-01-02 17:00:46.717024','2020-01-05 14:48:07.703677',0,1,1,1,''),(291,1,'/media/question_291',NULL,1,0,0,0,'2020-01-02 17:01:34.535043','2020-01-05 14:48:47.440488',0,1,1,1,''),(292,1,'/media/question_292',NULL,1,0,0,0,'2020-01-02 17:02:13.898856','2020-01-05 14:50:33.168809',0,1,1,1,''),(293,1,'/media/question_293',NULL,1,0,0,0,'2020-01-02 17:02:47.136140','2020-01-05 14:50:52.765982',0,1,1,1,''),(294,1,'/media/question_294',NULL,1,0,0,0,'2020-01-02 17:03:19.339940','2020-01-05 14:51:10.830035',0,1,1,1,''),(295,1,'/media/question_295',NULL,1,0,0,0,'2020-01-02 17:03:56.039821','2020-01-05 14:56:33.253297',0,1,1,1,''),(296,2,'/media/question_296',NULL,1,0,0,0,'2020-01-02 17:06:48.471096','2020-01-05 14:57:03.195584',0,1,1,1,''),(297,2,'/media/question_297',NULL,1,0,0,0,'2020-01-02 17:07:23.639309','2020-01-05 14:57:32.881618',0,1,1,1,''),(298,2,'/media/question_298',NULL,1,0,0,0,'2020-01-02 17:07:59.474161','2020-01-05 14:58:10.046530',0,1,1,1,''),(299,2,'/media/question_299',NULL,1,0,0,0,'2020-01-02 17:09:02.910464','2020-01-05 14:58:30.180194',0,1,1,1,''),(300,2,'/media/question_300',NULL,1,0,0,0,'2020-01-02 17:09:37.001828','2020-01-05 14:58:57.977910',0,1,1,1,''),(301,2,'/media/question_301',NULL,1,0,0,0,'2020-01-02 17:10:09.957856','2020-01-05 15:02:33.876837',0,2,1,1,'He back aches.選項有問題'),(302,2,'/media/question_302',NULL,1,0,0,0,'2020-01-02 17:10:43.221566','2020-01-05 15:08:05.127164',0,1,1,1,''),(303,2,'/media/question_303',NULL,1,0,0,0,'2020-01-02 17:11:27.349246','2020-01-05 15:08:22.777899',0,1,1,1,''),(304,2,'/media/question_304',NULL,1,0,0,0,'2020-01-02 17:12:00.584808','2020-01-05 15:08:52.362091',0,1,1,1,''),(305,2,'/media/question_305',NULL,1,0,0,0,'2020-01-02 17:12:35.417227','2020-01-05 15:10:39.790291',0,1,1,1,'');
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
) ENGINE=InnoDB AUTO_INCREMENT=348 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_question_used_to`
--

LOCK TABLES `alcpt_question_used_to` WRITE;
/*!40000 ALTER TABLE `alcpt_question_used_to` DISABLE KEYS */;
INSERT INTO `alcpt_question_used_to` VALUES (76,1,10),(111,1,14),(326,1,20),(205,1,23),(260,1,29),(82,2,11),(123,2,15),(84,3,11),(121,3,15),(216,3,24),(335,3,34),(77,5,10),(93,5,12),(141,5,17),(316,5,20),(199,5,23),(224,5,25),(83,6,11),(120,6,15),(209,6,24),(245,6,27),(312,6,33),(81,23,11),(122,23,15),(304,23,33),(251,28,28),(98,29,13),(106,29,14),(323,29,20),(198,29,23),(78,30,10),(108,30,14),(139,30,17),(322,30,20),(140,31,17),(223,31,25),(261,31,29),(88,32,12),(107,32,14),(315,32,20),(204,32,23),(217,32,25),(264,32,29),(94,33,12),(321,33,20),(200,33,23),(222,33,25),(90,34,12),(99,34,13),(109,34,14),(137,34,17),(202,34,23),(262,34,29),(91,35,12),(97,35,13),(110,35,14),(117,35,15),(144,35,17),(313,35,20),(218,35,25),(105,36,14),(145,36,17),(324,36,20),(206,36,23),(92,37,12),(319,37,20),(225,37,25),(86,40,12),(320,40,20),(263,40,29),(71,41,10),(102,41,13),(116,41,15),(138,41,17),(318,41,20),(103,42,13),(114,42,14),(143,42,17),(317,42,20),(221,42,25),(72,43,10),(100,43,13),(115,43,15),(226,43,25),(266,43,29),(73,44,10),(87,44,12),(96,44,13),(112,44,14),(327,44,20),(201,44,23),(259,44,29),(74,45,10),(101,45,13),(325,45,20),(220,45,25),(79,46,10),(118,46,15),(142,46,17),(197,46,23),(75,47,10),(85,47,12),(104,47,13),(203,47,23),(265,47,29),(80,48,10),(89,48,12),(95,48,13),(113,48,14),(119,48,15),(314,48,20),(257,48,29),(308,49,33),(246,51,27),(333,51,34),(210,53,24),(207,54,24),(214,58,24),(305,58,33),(336,58,34),(307,59,33),(146,60,17),(219,60,25),(258,60,29),(334,61,34),(293,62,32),(303,62,33),(311,64,33),(237,65,27),(211,68,24),(241,70,27),(284,70,31),(283,71,31),(329,71,34),(213,72,24),(240,72,27),(208,73,24),(295,75,32),(287,78,31),(291,79,31),(328,79,34),(306,81,33),(300,82,32),(294,86,32),(242,88,27),(212,89,24),(310,89,33),(298,91,32),(289,92,31),(296,92,32),(290,93,31),(297,93,32),(330,93,34),(332,98,34),(285,99,31),(331,100,34),(301,102,32),(302,104,32),(238,105,27),(288,105,31),(337,107,34),(244,108,27),(309,111,33),(215,113,24),(239,113,27),(286,113,31),(299,114,32),(243,117,27),(292,117,31),(229,125,26),(341,126,35),(232,127,26),(273,128,30),(253,130,28),(236,131,26),(227,133,26),(278,133,30),(252,134,28),(347,134,35),(234,135,26),(228,137,26),(254,137,28),(249,139,28),(250,140,28),(276,140,30),(235,141,26),(230,142,26),(279,142,30),(280,143,30),(247,146,28),(282,146,30),(255,147,28),(277,147,30),(231,148,26),(256,148,28),(274,148,30),(233,149,26),(248,149,28),(281,152,30),(275,154,30),(340,158,35),(338,160,35),(346,173,35),(343,186,35),(344,209,35),(345,215,35),(342,268,35),(339,269,35);
/*!40000 ALTER TABLE `alcpt_question_used_to` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_report`
--

DROP TABLE IF EXISTS `alcpt_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_notification` tinyint(1) NOT NULL,
  `staff_notification` tinyint(1) NOT NULL,
  `category_id` int(11) NOT NULL,
  `supplement_note` longtext NOT NULL,
  `reply` longtext NOT NULL,
  `state` smallint(6) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  `resolved_by_id` int(11) DEFAULT NULL,
  `created_time` datetime(6),
  `resolved_time` datetime(6),
  PRIMARY KEY (`id`),
  KEY `alcpt_report_category_id_108323c9_fk_alcpt_reportcategory_id` (`category_id`),
  KEY `alcpt_report_created_by_id_82b9f434_fk_alcpt_user_id` (`created_by_id`),
  KEY `alcpt_report_question_id_171cd9d9_fk_alcpt_question_id` (`question_id`),
  KEY `alcpt_report_resolved_by_id_4dc90590_fk_alcpt_user_id` (`resolved_by_id`),
  CONSTRAINT `alcpt_report_category_id_108323c9_fk_alcpt_reportcategory_id` FOREIGN KEY (`category_id`) REFERENCES `alcpt_reportcategory` (`id`),
  CONSTRAINT `alcpt_report_created_by_id_82b9f434_fk_alcpt_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `alcpt_user` (`id`),
  CONSTRAINT `alcpt_report_question_id_171cd9d9_fk_alcpt_question_id` FOREIGN KEY (`question_id`) REFERENCES `alcpt_question` (`id`),
  CONSTRAINT `alcpt_report_resolved_by_id_4dc90590_fk_alcpt_user_id` FOREIGN KEY (`resolved_by_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_report`
--

LOCK TABLES `alcpt_report` WRITE;
/*!40000 ALTER TABLE `alcpt_report` DISABLE KEYS */;
INSERT INTO `alcpt_report` VALUES (12,0,0,4,'我在編輯個人基本資料時無法更改身分證字號。<br>2020-02-07 09:03:03.510055: S125038891<br>2020-02-07 09:05:26.292237: 好的，了解，謝謝您。<br>','請您留言您的身分證字號，由系統管理員協助您做更改。<br>收到，會儘速協助您做更改的動作，謝謝。<br>2020-02-07 09:05:48.181158: Love U<3<br>',3,1,NULL,1,'2020-02-07 09:01:37.843757','2020-02-07 15:31:24.373690'),(13,0,0,2,'在昨天的時候，我進去「測驗紀錄」點「第一次模擬考」，結果沒辦法測驗誒，太誇張了吧＠＠<br>2020-02-07 15:11:24.688589: 誒？？好像是誒，不好意思打擾您了，拍謝＠＠<br>','2020-02-07 15:05:42.657693: 那請問你是不是已經過了考試時間才去點即開始測驗的？<br>',3,1,NULL,1,'2020-02-07 15:04:42.161082','2020-02-08 22:00:09.593923');
/*!40000 ALTER TABLE `alcpt_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_reportcategory`
--

DROP TABLE IF EXISTS `alcpt_reportcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_reportcategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `responsibility` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_reportcategory`
--

LOCK TABLES `alcpt_reportcategory` WRITE;
/*!40000 ALTER TABLE `alcpt_reportcategory` DISABLE KEYS */;
INSERT INTO `alcpt_reportcategory` VALUES (1,'權限問題',32),(2,'考試問題',16),(3,'成績問題',48),(4,'帳號問題',32),(5,'試題問題',24),(6,'其他',32);
/*!40000 ALTER TABLE `alcpt_reportcategory` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
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
  `stu_id` varchar(10) NOT NULL,
  `grade` smallint(5) unsigned NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `squadron_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stu_id` (`stu_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `alcpt_student_department_id_257bfbd3_fk_alcpt_department_id` (`department_id`),
  KEY `alcpt_student_squadron_id_4bbcc05a_fk_alcpt_squadron_id` (`squadron_id`),
  CONSTRAINT `alcpt_student_department_id_257bfbd3_fk_alcpt_department_id` FOREIGN KEY (`department_id`) REFERENCES `alcpt_department` (`id`),
  CONSTRAINT `alcpt_student_squadron_id_4bbcc05a_fk_alcpt_squadron_id` FOREIGN KEY (`squadron_id`) REFERENCES `alcpt_squadron` (`id`),
  CONSTRAINT `alcpt_student_user_id_c43c5a79_fk_alcpt_user_id` FOREIGN KEY (`user_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_student`
--

LOCK TABLES `alcpt_student` WRITE;
/*!40000 ALTER TABLE `alcpt_student` DISABLE KEYS */;
INSERT INTO `alcpt_student` VALUES (1,'1090630218',109,2,3,1),(4,'1090630201',108,NULL,NULL,12),(5,'1090630202',109,2,3,13),(6,'1090630203',108,NULL,NULL,16),(7,'1090630204',108,NULL,NULL,17),(8,'1090630205',108,NULL,NULL,18),(9,'1090630206',108,NULL,NULL,19),(10,'1090630207',108,NULL,NULL,20),(11,'1090630208',108,NULL,NULL,21),(12,'1090630209',108,NULL,NULL,22),(13,'1090630210',108,NULL,NULL,23),(14,'1090630211',108,NULL,NULL,24),(15,'1090630212',108,2,3,25),(16,'1090630214',108,NULL,NULL,26),(17,'1090630216',108,NULL,NULL,27),(18,'1090630220',108,NULL,NULL,28),(19,'1090630222',108,NULL,NULL,29),(20,'1090630224',108,NULL,NULL,30),(21,'1090630225',108,NULL,NULL,31),(22,'1090630226',108,NULL,NULL,32),(23,'1090630227',108,NULL,NULL,33),(24,'1090630229',108,NULL,NULL,34),(25,'1090630230',108,NULL,NULL,35);
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
  `is_testpaper` tinyint(1) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `valid` tinyint(1) NOT NULL,
  `created_by_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `alcpt_testpaper_created_by_id_def16d7a_fk_alcpt_user_id` (`created_by_id`),
  CONSTRAINT `alcpt_testpaper_created_by_id_def16d7a_fk_alcpt_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_testpaper`
--

LOCK TABLES `alcpt_testpaper` WRITE;
/*!40000 ALTER TABLE `alcpt_testpaper` DISABLE KEYS */;
INSERT INTO `alcpt_testpaper` VALUES (10,'閱讀練習-practice-1090630218-2019-12-19 11:11:16.584208','2019-12-19 03:11:16.591815',0,'2019-12-19 03:11:16.591862',0,1),(11,'閱讀練習-practice-1090630218-2019-12-19 19:08:47.418520','2019-12-19 11:08:47.426459',0,'2019-12-19 11:08:47.426507',0,1),(12,'閱讀練習-practice-1090630218-2019-12-19 20:58:00.977096','2019-12-19 12:58:00.984450',0,'2019-12-19 12:58:00.984508',0,1),(13,'閱讀練習-practice-1090630218-2019-12-19 21:00:03.583008','2019-12-19 13:00:03.590973',0,'2019-12-19 13:00:03.591020',0,1),(14,'閱讀練習-practice-1090630218-2019-12-20 13:26:03.870011','2019-12-20 05:26:03.919328',0,'2019-12-20 05:26:03.919382',0,1),(15,'閱讀練習-practice-1090630218-2019-12-20 13:31:24.105144','2019-12-20 05:31:24.140080',0,'2019-12-20 05:31:24.140137',0,1),(17,'閱讀練習-practice-1090630218-2019-12-29 00:10:17.882042','2019-12-28 16:10:17.917780',0,'2019-12-28 16:10:17.918981',0,1),(20,'第一次模擬考','2019-12-31 00:11:40.668445',1,'2020-01-05 21:21:14.008388',0,1),(23,'閱讀練習-practice-1090630218-2019-12-31 14:14:52.703424','2019-12-31 06:14:52.740265',0,'2019-12-31 06:14:52.742598',0,1),(24,'閱讀練習-practice-1090630218-2019-12-31 14:34:15.677266','2019-12-31 06:34:15.740995',0,'2019-12-31 06:34:15.742549',0,1),(25,'閱讀練習-practice-1090630218-2019-12-31 14:37:14.577271','2019-12-31 06:37:14.624749',0,'2019-12-31 06:37:14.625977',0,1),(26,'聽力練習-practice-1090630218-2019-12-31 15:18:27.159497','2019-12-31 07:18:27.227511',0,'2019-12-31 07:18:27.230627',0,1),(27,'閱讀練習-practice-1090630218-2019-12-31 15:36:05.319577','2019-12-31 07:36:05.391943',0,'2019-12-31 07:36:05.394295',0,1),(28,'聽力練習-practice-1090630218-2019-12-31 15:54:35.174701','2019-12-31 07:54:35.219723',0,'2019-12-31 07:54:35.221782',0,1),(29,'閱讀練習-practice-1090630218-2020-01-04 02:48:04.309985','2020-01-04 02:48:04.353014',0,'2020-01-04 02:48:04.354971',0,1),(30,'聽力練習-practice-1090630218-2020-01-04 12:34:56.746687','2020-01-04 12:34:56.795067',0,'2020-01-04 12:34:56.796749',0,1),(31,'閱讀練習-practice-1090630216-2020-01-04 21:29:45.143670','2020-01-04 21:29:45.180681',0,'2020-01-04 21:29:45.182426',0,27),(32,'閱讀練習-practice-1090630220-2020-01-04 23:49:20.832601','2020-01-04 23:49:20.872095',0,'2020-01-04 23:49:20.873610',0,28),(33,'閱讀練習-practice-1090630218-2020-01-05 00:04:41.027504','2020-01-05 00:04:41.071905',0,'2020-01-05 00:04:41.073110',0,1),(34,'閱讀練習-practice-1090630218-2020-01-05 21:24:59.071834','2020-01-05 21:24:59.114970',0,'2020-01-05 21:24:59.116146',0,1),(35,'聽力練習-practice-1090630218-2020-01-13 11:38:10.288748','2020-01-13 11:38:10.359071',0,'2020-01-13 11:38:10.426085',0,1),(36,'第二次模擬考','2020-02-08 21:57:47.374510',1,'2020-02-08 21:57:47.381705',0,1),(37,'第三次模擬考','2020-02-08 21:58:49.130661',1,'2020-02-08 21:58:49.134465',0,1);
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
  `reg_id` varchar(50) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `email_is_verified` tinyint(1) NOT NULL,
  `gender` smallint(5) unsigned DEFAULT NULL,
  `privilege` smallint(5) unsigned NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reg_id` (`reg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_user`
--

LOCK TABLES `alcpt_user` WRITE;
/*!40000 ALTER TABLE `alcpt_user` DISABLE KEYS */;
INSERT INTO `alcpt_user` VALUES (1,'pbkdf2_sha256$36000$4zEHqf8SAJFQ$OKTlAhNLNfeYxlM107ZYk9LDhOy+SsndWBQx5N2QwBY=','1090630218','蘇典煒','wei860925@gmail.com',1,0,32,'2019-10-15 12:44:32.551000','2020-02-10 08:11:49.179420','2020-02-10 08:02:16.387597'),(2,'pbkdf2_sha256$36000$yoX8FUYBKEBE$0SpUdzLVt1A+ipbOutYamo03sVbKui4P3YelCIlialU=','mcndu01','楊顓豪','',0,0,27,'2019-05-19 18:41:47.152000','2019-12-28 14:02:35.418188','2020-01-06 09:16:01.754479'),(12,'pbkdf2_sha256$36000$7EVGxGb00JYI$kJtP5tBX8El7tULJCwzM3qpevI1BPHRbREAbbCFu78s=','1090630201','蘇治宇','',0,NULL,1,'2019-12-16 13:22:40.739726','2019-12-30 14:09:19.454645','2019-12-30 14:12:52.481943'),(13,'pbkdf2_sha256$36000$BxXsKtylZDp3$foYRyg+hDEON6Id81qT7QrlAvUaMj72NhlllFK1OQ3M=','1090630202','王仁','wang@gmail.com',0,0,1,'2019-12-16 13:22:40.739788','2020-01-01 15:48:31.045222','2020-01-01 15:47:59.212169'),(14,'pbkdf2_sha256$36000$wX9f2Tt1jM96$7uCA4byRA1hm4iJwoe0cOvxzamyxLv/5IaBp3Oa0cM4=','mcndu0001','袁葆宏','i.max.yuan@gmail.com',1,0,16,'2019-12-16 13:42:44.546743','2020-02-07 11:31:29.774477','2020-02-07 11:31:29.772410'),(16,'pbkdf2_sha256$36000$sdOqMbdPPRCe$zQKQeUk79FdH5btcIQKGu9RbQswR+k1AHb1FpX+tky8=','1090630203','李傳瑋','',0,NULL,1,'2019-12-27 14:35:39.032587','2019-12-27 14:35:39.032620',NULL),(17,'pbkdf2_sha256$36000$jcRGWAa392gw$dvMxqIoJ+RlNwArRLkrQDk64XkiBKq2KY/+bPJvGoeQ=','1090630204','楊家齊','',0,NULL,1,'2019-12-27 14:35:39.032649','2019-12-27 14:35:39.032661',NULL),(18,'pbkdf2_sha256$36000$3nT5OvhG0ecv$2oUH52OJ0bpH7vbNwqARINb5RfBwHBEkRB4F4oUBQec=','1090630205','陳彥揚','',0,NULL,1,'2019-12-27 14:35:39.032686','2019-12-27 14:35:39.032698',NULL),(19,'pbkdf2_sha256$36000$7AvaOOKFog11$50J5/taq8VxE8eQFgoYuW0eRRVArTR7JnWvhOWXSF70=','1090630206','陳昱豪','',0,NULL,1,'2019-12-27 14:37:31.063031','2019-12-27 14:37:31.063065','2020-01-06 09:29:33.569359'),(20,'pbkdf2_sha256$36000$6I5iDPFSlxLC$mloyU9Bl28VVhSsOX+K6pXJXK54LiiyPORw+tDRw8tY=','1090630207','古盛樑','',0,NULL,1,'2019-12-27 14:37:31.063094','2019-12-27 14:37:31.063106',NULL),(21,'pbkdf2_sha256$36000$Nqko3Ewl5QCT$p4dwliy6Td72LxE9oe2/qg3ghFWnJbK7apkbJ5fR6sU=','1090630208','葉浚豪','',0,NULL,1,'2019-12-27 14:37:31.063132','2019-12-27 14:37:31.063143',NULL),(22,'pbkdf2_sha256$36000$qxHrOLsTjBtL$8IwY/XGlqqeTcH+utvhxt34Mfej+S9+NbyM4DdhGrFs=','1090630209','周奕志','',0,NULL,1,'2019-12-27 14:37:31.063167','2019-12-27 14:37:31.063179',NULL),(23,'pbkdf2_sha256$36000$GDUGTAxQWIjO$aBgGJ/3gyQVpwIOAwvQus5/V6bIW8t0YnhzSvAKkhqA=','1090630210','柯瑞林','',0,NULL,1,'2019-12-27 14:37:31.063203','2019-12-27 14:37:31.063214',NULL),(24,'pbkdf2_sha256$36000$K51yJhRjC1Df$PbGTSJLw3ywx2nreyJFQZCCr3vMbfit3rSYeSTWybQs=','1090630211','蔡承晏','',0,NULL,1,'2019-12-27 14:37:31.063239','2019-12-27 14:37:31.063252',NULL),(25,'pbkdf2_sha256$36000$YjBXHNznmfYG$cSD0psqaRY0OW9ryvyehCzWgL8v/Ltpq8dm/gloD1e4=','1090630212','陳信綸','gmvup4xjp6@gmail.com',1,0,1,'2019-12-27 14:37:31.063277','2019-12-31 00:45:07.569157','2020-01-04 13:59:05.320584'),(26,'pbkdf2_sha256$36000$zwoL8iC7tBnJ$qfy8x2fwz6JHh0dvBS4R9+XbT3FhB7rQkcvUJIILuEY=','1090630214','蔡侑利','',0,NULL,1,'2019-12-27 14:37:31.063313','2019-12-27 14:37:31.063324',NULL),(27,'pbkdf2_sha256$36000$Pu4VRsqGVxBc$6wRy8M8OtXvWUdZQVG8ulsNWPFhExTZFoUs6NGNKbkw=','1090630216','陳弘奕','',0,NULL,1,'2019-12-27 14:37:31.063348','2019-12-27 14:37:31.063359','2020-01-04 20:50:44.139699'),(28,'pbkdf2_sha256$36000$TKNXlAlDWFhq$nqEpxT0iD67pc/IfglWo8QwDr/gazqe7kapc6IiPZsw=','1090630220','傅晴俞','',0,NULL,1,'2019-12-27 14:40:28.419031','2019-12-27 14:40:28.419063','2020-01-04 23:49:02.596321'),(29,'pbkdf2_sha256$36000$LtPv0ntHZsyo$Ry6JpgOZf5RqhcUEhyDTMbmK4xNniAaOofgVPp83AKw=','1090630222','史鎬瑄','',0,NULL,1,'2019-12-27 14:40:28.419092','2019-12-27 14:40:28.419104',NULL),(30,'pbkdf2_sha256$36000$SP0Q9tefVr1F$BtXnytR+bWW55fqrAv25OjVPcqGheADKhU0UeLmzd0M=','1090630224','胡佳惠','',0,NULL,1,'2019-12-27 14:40:28.419129','2019-12-27 14:40:28.419141',NULL),(31,'pbkdf2_sha256$36000$YndCEHgKHW9h$JZeP4DD8ammxIrfbNGFNP9eiSzgWd7HYIgUcxyGBWPA=','1090630225','吳佳穎','',0,NULL,1,'2019-12-27 14:40:28.419166','2019-12-27 14:40:28.419177',NULL),(32,'pbkdf2_sha256$36000$pNHWadjcV71q$Zsljd6nyyG9ytS6fo1EABn/uI785n20/kZIYhQdH3O4=','1090630226','洪怡萱','',0,NULL,1,'2019-12-27 14:40:28.419202','2019-12-27 14:40:28.419213',NULL),(33,'pbkdf2_sha256$36000$aH7XncHZwzSq$Q/RzdVU5aEgjxBP6yeV/8i3xb2LXQu9Yg3aiCxji1MY=','1090630227','黃頎惠','',0,NULL,1,'2019-12-27 14:40:28.419237','2019-12-27 14:40:28.419248',NULL),(34,'pbkdf2_sha256$36000$yU6seCtwPoRi$v0w/b5F711guOrCmi6Cku6eeezdxsMvDOJKgCTV3Kac=','1090630229','郭冠林','',0,NULL,1,'2019-12-27 14:40:28.419273','2019-12-27 14:40:28.419284',NULL),(35,'pbkdf2_sha256$36000$WLerYLeam3ME$V6NFBpgydIO/tDa2ZXvPjROOz4tGB6Z5uxakUfNcv30=','1090630230','任晉賢','',0,NULL,1,'2019-12-27 14:40:28.419308','2019-12-27 14:40:28.419319',NULL),(36,'pbkdf2_sha256$36000$uPX2ame8iWcJ$UZZmJFKaq5vVNFFeHlc26IZ/fdhcsFOCrWEBAZeaYbc=','1100630210','黃柏豪','qaz74159@yahoo.com.tw',1,0,1,'2020-01-06 09:24:10.568397','2020-01-06 09:25:55.944843','2020-01-06 09:24:32.148503');
/*!40000 ALTER TABLE `alcpt_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audio_file`
--

DROP TABLE IF EXISTS `audio_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audio_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `audio_file` varchar(100) NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `audio_file_user_id_ada556f9_fk_alcpt_user_id` (`user_id`),
  CONSTRAINT `audio_file_user_id_ada556f9_fk_alcpt_user_id` FOREIGN KEY (`user_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audio_file`
--

LOCK TABLES `audio_file` WRITE;
/*!40000 ALTER TABLE `audio_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `audio_file` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add answer',7,'add_answer'),(20,'Can change answer',7,'change_answer'),(21,'Can delete answer',7,'delete_answer'),(22,'Can add answer sheet',8,'add_answersheet'),(23,'Can change answer sheet',8,'change_answersheet'),(24,'Can delete answer sheet',8,'delete_answersheet'),(25,'Can add choice',9,'add_choice'),(26,'Can change choice',9,'change_choice'),(27,'Can delete choice',9,'delete_choice'),(28,'Can add department',10,'add_department'),(29,'Can change department',10,'change_department'),(30,'Can delete department',10,'delete_department'),(31,'Can add exam',11,'add_exam'),(32,'Can change exam',11,'change_exam'),(33,'Can delete exam',11,'delete_exam'),(34,'Can add group',12,'add_group'),(35,'Can change group',12,'change_group'),(36,'Can delete group',12,'delete_group'),(37,'Can add proclamation',13,'add_proclamation'),(38,'Can change proclamation',13,'change_proclamation'),(39,'Can delete proclamation',13,'delete_proclamation'),(40,'Can add question',14,'add_question'),(41,'Can change question',14,'change_question'),(42,'Can delete question',14,'delete_question'),(43,'Can add squadron',15,'add_squadron'),(44,'Can change squadron',15,'change_squadron'),(45,'Can delete squadron',15,'delete_squadron'),(46,'Can add student',16,'add_student'),(47,'Can change student',16,'change_student'),(48,'Can delete student',16,'delete_student'),(49,'Can add test paper',17,'add_testpaper'),(50,'Can change test paper',17,'change_testpaper'),(51,'Can delete test paper',17,'delete_testpaper'),(52,'Can add user',18,'add_user'),(53,'Can change user',18,'change_user'),(54,'Can delete user',18,'delete_user'),(55,'Can add option list',19,'add_optionlist'),(56,'Can change option list',19,'change_optionlist'),(57,'Can delete option list',19,'delete_optionlist'),(58,'Can add audio file',20,'add_audiofile'),(59,'Can change audio file',20,'change_audiofile'),(60,'Can delete audio file',20,'delete_audiofile'),(61,'can see Audio Files',20,'view_audiofile'),(62,'Can add captcha store',21,'add_captchastore'),(63,'Can change captcha store',21,'change_captchastore'),(64,'Can delete captcha store',21,'delete_captchastore'),(65,'Can add report category',22,'add_reportcategory'),(66,'Can change report category',22,'change_reportcategory'),(67,'Can delete report category',22,'delete_reportcategory'),(68,'Can add report',23,'add_report'),(69,'Can change report',23,'change_report'),(70,'Can delete report',23,'delete_report');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$NR3ItP0hMf3C$gpm4p9l5r6Y+20rzeD4lte1tOsuN9nQPgPNgooeQJsY=','2019-12-18 08:11:02.232747',1,'d.wsu','','','wei860925@gmail.com',1,1,'2019-12-18 08:10:55.194024');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `captcha_captchastore`
--

DROP TABLE IF EXISTS `captcha_captchastore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `captcha_captchastore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge` varchar(32) NOT NULL,
  `response` varchar(32) NOT NULL,
  `hashkey` varchar(40) NOT NULL,
  `expiration` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashkey` (`hashkey`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captcha_captchastore`
--

LOCK TABLES `captcha_captchastore` WRITE;
/*!40000 ALTER TABLE `captcha_captchastore` DISABLE KEYS */;
/*!40000 ALTER TABLE `captcha_captchastore` ENABLE KEYS */;
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
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(7,'alcpt','answer'),(8,'alcpt','answersheet'),(9,'alcpt','choice'),(10,'alcpt','department'),(11,'alcpt','exam'),(12,'alcpt','group'),(19,'alcpt','optionlist'),(13,'alcpt','proclamation'),(14,'alcpt','question'),(23,'alcpt','report'),(22,'alcpt','reportcategory'),(15,'alcpt','squadron'),(16,'alcpt','student'),(17,'alcpt','testpaper'),(18,'alcpt','user'),(20,'audiofield','audiofile'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(21,'captcha','captchastore'),(5,'contenttypes','contenttype'),(6,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-12-11 06:45:06.093900'),(2,'auth','0001_initial','2019-12-11 06:45:06.386045'),(3,'admin','0001_initial','2019-12-11 06:45:06.469952'),(4,'admin','0002_logentry_remove_auto_add','2019-12-11 06:45:06.493655'),(5,'alcpt','0001_initial','2019-12-11 06:45:07.580557'),(6,'contenttypes','0002_remove_content_type_name','2019-12-11 06:45:07.656881'),(7,'auth','0002_alter_permission_name_max_length','2019-12-11 06:45:07.693015'),(8,'auth','0003_alter_user_email_max_length','2019-12-11 06:45:07.730940'),(9,'auth','0004_alter_user_username_opts','2019-12-11 06:45:07.753866'),(10,'auth','0005_alter_user_last_login_null','2019-12-11 06:45:07.791635'),(11,'auth','0006_require_contenttypes_0002','2019-12-11 06:45:07.794423'),(12,'auth','0007_alter_validators_add_error_messages','2019-12-11 06:45:07.812398'),(13,'auth','0008_alter_user_username_max_length','2019-12-11 06:45:07.852193'),(14,'sessions','0001_initial','2019-12-11 06:45:07.876841'),(15,'alcpt','0002_auto_20191211_1515','2019-12-11 07:15:28.993398'),(16,'alcpt','0003_auto_20191213_1715','2019-12-13 09:15:13.751913'),(17,'alcpt','0002_exam_total_score','2019-12-16 23:48:36.954443'),(18,'alcpt','0002_exam_average_score','2019-12-17 14:43:52.199762'),(19,'audiofield','0001_initial','2019-12-18 12:47:40.669675'),(20,'audiofield','0002_auto_20180121_0750','2019-12-18 12:47:40.687705'),(21,'alcpt','0003_auto_20191218_1541','2019-12-18 15:41:45.384870'),(22,'alcpt','0004_auto_20191219_1608','2019-12-19 08:08:41.653631'),(23,'alcpt','0005_auto_20191220_0849','2019-12-20 05:29:31.562034'),(24,'alcpt','0006_question_used_freq','2019-12-20 05:29:31.658875'),(25,'alcpt','0007_auto_20191220_1544','2019-12-20 07:44:36.327387'),(26,'alcpt','0007_auto_20191220_1604','2019-12-20 08:04:39.313311'),(27,'captcha','0001_initial','2019-12-21 07:42:07.456999'),(28,'alcpt','0007_auto_20191230_1430','2019-12-30 06:30:58.106039'),(29,'alcpt','0007_auto_20191230_1908','2019-12-30 11:09:41.329018'),(30,'alcpt','0008_report_resolved_by','2019-12-30 11:20:40.174669'),(31,'alcpt','0009_user_email','2019-12-30 13:56:55.903218'),(32,'alcpt','0010_auto_20191230_2156','2019-12-30 13:56:56.093408'),(33,'alcpt','0011_user_email_is_verified','2019-12-30 14:45:14.673995'),(34,'alcpt','0012_auto_20200204_2113','2020-02-04 21:14:19.128887'),(35,'alcpt','0013_report_notification','2020-02-06 15:13:07.694861'),(36,'alcpt','0014_auto_20200207_0843','2020-02-07 08:43:32.488817');
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
INSERT INTO `django_session` VALUES ('0veeoeji3wb2nfuc6qe9oqmgq8mz2aw3','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-29 04:00:07.817450'),('16s8haitjrcwqgkx97lzp381m06m76u3','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-13 14:46:39.276158'),('1dq0l2uxxpe3uv6qxdqg1qwpcgknrm7c','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-18 22:15:47.105947'),('1tl5qp7vrjwbuv5owfqrlel0qwqjtv5o','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-10 15:09:07.461828'),('347whx9lxevlmy430gvk2ztmdi3aauiv','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-07 12:41:34.817122'),('36yo69947aqrs98kjhp3mu7du4elwcyx','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-16 02:48:20.808559'),('3arwht0j8v0qs7s2cqgkyfwg9m7x0ks7','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-25 13:30:13.580620'),('4i9xub4ez2yah5ei9wnfgywqk6p6pnqn','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-29 04:02:51.062693'),('5r8zdvtgcwm7owy47k90c7ac0n44k9nn','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-25 23:42:41.863050'),('5x42pyn4akdhn50m4c8bypn3e583x254','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-27 03:55:48.773107'),('64z4jg8vi8kd6vwunqg957znb8bxd84y','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-11 16:16:28.606648'),('6t66gm6pkv2ut582fgvjh8qxm84m3yoa','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-30 12:31:42.054066'),('70im5puoo9q1ug2tz63h0gm9khkoxxxp','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-27 07:49:34.063181'),('763bw26v25c07km6oiyrjcthg509b3d2','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-27 11:37:58.196273'),('78hykzhbawq9c0kodz6dko1ftzbuw3zu','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-16 03:04:07.275722'),('8nq3zmlkmhcqo3ch4m8dox0zvylewtkv','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-02-14 07:44:09.032719'),('8nsgozlc40m8hb520qf1s0sptk3mnb02','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-25 13:03:30.343816'),('8va3pu44hiazp3aptza48ngkksyt5drt','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-27 09:05:21.239909'),('9i0sscl0wrcjmpgwzii7peum2ewanih9','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-30 07:41:16.558036'),('9ib1668m2oydtis2dzvg0av043sjkosf','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-27 09:18:26.510459'),('a3a6a4nayglc9x65rnwuy74rb930pv8e','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-26 06:52:50.816391'),('askluw19rj93wutaf2ht3sfdk26adlrz','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-01 09:43:05.037648'),('awozklgrqpswfpeail11nnvlx54fko7p','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-27 16:18:15.418631'),('ayz9o0e3rdc4b3a6orjwgz13m0q161fd','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-01 16:51:53.622254'),('b2pwnuhnp6i515ns9nyqxejryl5vvpbb','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-27 16:01:37.234928'),('b6mavq95pukmduk7v9cdzgkgmlqmt40o','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-27 16:09:07.941016'),('bi0nh2y9ntvjwsdvhd5ypqtgh6zhdf6y','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-04 19:05:15.239617'),('c79ustd8up7mmof95db1nxq4umt3w8j3','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-05 03:40:16.710998'),('df4w13zo0j1sl5khxf2tx7f2v6z39qbu','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-29 15:45:12.540765'),('dl3arqfexvcx7occumshytlnklf2gtbo','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-21 17:54:32.484615'),('dqzrkkzyae2va917oqsms25ipudporqa','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-02-14 07:18:46.217060'),('ecss2clo5mrcz6umznj74swtk4dht63c','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-28 06:05:50.043900'),('epe94oagt6sdx7dx2yh4tlqvud7qad5v','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-27 00:36:11.355384'),('fk2ltyucvs7olizo58a0hs5bfz1pslk9','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-02-22 17:31:04.200113'),('fpfx9ctjnld0anr7gpomfqdilopzzl9n','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-01 00:14:19.591255'),('g2myu52g699afzudd83g5xvkbyni3ar4','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-29 14:35:13.242546'),('hai90iaz8fo3ldjhfzi6jeeio2mis4sf','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-01 11:39:49.207978'),('hefyq6q6bj479tj9ak2veaeh87fav49h','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-26 06:59:54.520278'),('ia83pzla8zdf2p4x54qc8nye6u45jq2r','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-26 07:32:17.685807'),('iu2e1mhr434dmgrrhrch24cqpm9pe3sy','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-30 05:05:43.889120'),('jhyh2qe53modfleljqmbf5lk13bnbb7h','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-27 05:46:25.319505'),('ktrl3wblfll2laoz54bkt9m7kmz6dzg1','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-02-24 08:02:16.394891'),('l0c0bbijap9rmiign4z2x4ptvawvqja2','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-23 18:48:14.769672'),('l7u08owxck348w09fg2hl26fs8hvqmlx','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-02-14 07:28:53.787792'),('lh1rrroa0r4tnfnsvq117i99rv9b8981','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-26 00:12:48.959859'),('ln6dhjj2te29f9xflszgo99u7sbgj55o','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-25 14:57:08.825304'),('m7yqla1oc9w0tb414qr5nruf0n3kity5','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-02 09:45:30.753687'),('na3leiq48g0l5sfvtol10xx3prk83poz','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-27 07:39:44.767182'),('nepusmzc9te3isbn01dch3w4g4nmcsa8','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-01 16:30:39.886947'),('ovujewez78fhuz4ltum5uh2r6pucx1lz','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-15 15:48:53.780925'),('pbyhgmyl8phz0uffv9bfkk10bckfndic','MzNlYTRlMmIwNzZmZjJiNDFiNmFjNTI0NjU2NDA3ZGY5ZGFiYWU0Zjp7Il9hdXRoX3VzZXJfaWQiOiIxMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYjMxYjg4ZGEwMjc5YjZiNjgwODNmZTRjZTMzMmQ2NTEzZTIyODlhNyJ9','2020-01-13 14:17:19.781434'),('pn6t9kviqnthm23dhbmuwdve6o8j4wt1','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-27 02:57:54.328539'),('pxi9bw5h8q1tq8g2ygo1zf19yveo15xz','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-03 03:56:54.660977'),('pynpainw5v2nfe1o9rjo8n4o9l32qpcr','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-25 15:18:24.177363'),('q902zu5e1y09jklszy6vr36baprv4s7b','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-26 06:39:06.200696'),('qjx73fkh69h4z7ko19wd6vwg32u5jo3l','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-01 15:29:45.587402'),('r3ij7hjqaak7mm4xhpfu6q8vfbzkfdey','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-02-16 02:54:53.737887'),('r775uzdwmhni73n5i468gbutspypwueg','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-02-14 07:22:37.016881'),('sf0tmmb5oj2hikvlmnm92tzqqbmgkr2m','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-30 07:46:32.409752'),('t4jbhqp9yawgxbgus7rlziz6mwthoa1q','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-27 04:40:52.917480'),('t51q3pan3c14p39sldec0nv6lj4e96uj','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-27 01:01:16.083843'),('u29or6l9f0r9o8xmvc80152uhd27i2wn','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-26 10:36:56.565146'),('uer56k0e08wvkclf2j3fcufwetavh1m2','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-01 16:18:42.962437'),('uwq7a7mh3wtzxscqkgrkeshidzvdz0aa','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-27 16:08:55.779832'),('v5vbleenm1f0k3nitxza5u95x6vw0zk0','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-25 15:10:29.676317'),('v7i387yl9x45vgylqaeybft8bwzrw6ve','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-27 15:48:18.491601'),('vbwidxo3fef6bs1m1b6eihzjbkue2y77','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-04 08:01:14.307932'),('vumpp4uwy37ubimm2t23aolojp74v03n','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-25 23:39:57.936251'),('xcus9ip3yh7ucffym1d0g2hrczvolb9g','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-26 08:41:28.550917'),('xm721anxdq31s377yd80dc6vl35a7p8x','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-03 03:49:36.868743'),('xx482c3vxtuhqdm7v0lne8e2v18nn0km','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-01-04 11:32:15.882206'),('y59b0h25h70moal7wjxqvhjv7ibpcolj','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-26 02:05:54.531797'),('z01u2t1b0oa858unkpx4587khcdc9cdf','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2019-12-26 09:09:51.560080'),('z3254rbshoqm4umt9tq5cu1rb726oltw','YWFiNTRjNjE4NjI0MGY2NjAzZDY5ZTk2MzE0NWUzZmRkMzFjOGQ2Nzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MzBkNWM3NzA3NTYzYjkzNzc3MmIzYTk1MjIwOWU1NTY1Y2E5ZmNiIn0=','2020-02-17 18:32:32.292839');
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

-- Dump completed on 2020-02-10  8:49:07
