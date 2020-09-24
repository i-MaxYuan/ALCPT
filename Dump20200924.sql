-- MySQL dump 10.13  Distrib 8.0.21, for macos10.15 (x86_64)
--
-- Host: 127.0.0.1    Database: ALCPT
-- ------------------------------------------------------
-- Server version	8.0.21

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
  `id` int NOT NULL AUTO_INCREMENT,
  `selected` smallint NOT NULL,
  `answer_sheet_id` int NOT NULL,
  `question_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alcpt_answer_answer_sheet_id_c4fe1234_fk_alcpt_answersheet_id` (`answer_sheet_id`),
  KEY `alcpt_answer_question_id_af4ab1ab_fk_alcpt_question_id` (`question_id`),
  CONSTRAINT `alcpt_answer_answer_sheet_id_c4fe1234_fk_alcpt_answersheet_id` FOREIGN KEY (`answer_sheet_id`) REFERENCES `alcpt_answersheet` (`id`),
  CONSTRAINT `alcpt_answer_question_id_af4ab1ab_fk_alcpt_question_id` FOREIGN KEY (`question_id`) REFERENCES `alcpt_question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=768 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_answer`
--

LOCK TABLES `alcpt_answer` WRITE;
/*!40000 ALTER TABLE `alcpt_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `alcpt_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_answersheet`
--

DROP TABLE IF EXISTS `alcpt_answersheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_answersheet` (
  `id` int NOT NULL AUTO_INCREMENT,
  `finish_time` datetime(6) NOT NULL,
  `is_finished` tinyint(1) NOT NULL,
  `score` smallint unsigned DEFAULT NULL,
  `exam_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alcpt_answersheet_exam_id_147bc9a1_fk_alcpt_exam_id` (`exam_id`),
  KEY `alcpt_answersheet_user_id_8e290a44_fk_alcpt_user_id` (`user_id`),
  CONSTRAINT `alcpt_answersheet_exam_id_147bc9a1_fk_alcpt_exam_id` FOREIGN KEY (`exam_id`) REFERENCES `alcpt_exam` (`id`),
  CONSTRAINT `alcpt_answersheet_user_id_8e290a44_fk_alcpt_user_id` FOREIGN KEY (`user_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_answersheet`
--

LOCK TABLES `alcpt_answersheet` WRITE;
/*!40000 ALTER TABLE `alcpt_answersheet` DISABLE KEYS */;
/*!40000 ALTER TABLE `alcpt_answersheet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_choice`
--

DROP TABLE IF EXISTS `alcpt_choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_choice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `c_content` varchar(255) NOT NULL,
  `is_answer` tinyint(1) NOT NULL,
  `question_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alcpt_choice_question_id_cdc3736d_fk_alcpt_question_id` (`question_id`),
  CONSTRAINT `alcpt_choice_question_id_cdc3736d_fk_alcpt_question_id` FOREIGN KEY (`question_id`) REFERENCES `alcpt_question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2109 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_choice`
--

LOCK TABLES `alcpt_choice` WRITE;
/*!40000 ALTER TABLE `alcpt_choice` DISABLE KEYS */;
INSERT INTO `alcpt_choice` VALUES (1,'officer',0,1),(2,'officers',0,1),(3,'a officer',0,1),(4,'an officer',1,1),(5,'ICBM',0,2),(6,'IRBM',1,2),(7,'MRBM',0,2),(8,'SRBM',0,2),(9,'machine gun',0,3),(10,'pistol',1,3),(11,'grenade',0,3),(12,'tank',0,3),(17,'wear',0,5),(18,'had worn',1,5),(19,'wears',0,5),(20,'wearing',0,5),(21,'infantrymen',1,6),(22,'artillerymen',0,6),(23,'paratrooper',0,6),(24,'scout',0,6),(65,'Urban Operations',0,23),(66,'Engineers',0,23),(67,'engagement',1,23),(68,'Armor',0,23),(69,'鄧紫棋',1,28),(70,'林宥嘉',0,28),(71,'吳青峰',0,28),(72,'華晨宇',0,28),(89,'that',0,29),(90,'and',0,29),(91,'but',0,29),(92,'because',1,29),(93,'during',0,30),(94,'since',0,30),(95,'between',0,30),(96,'for',1,30),(97,'likes',0,31),(98,'like',1,31),(99,'are like',0,31),(100,'were alike',0,31),(101,'see',1,32),(102,'sees',0,32),(103,'saw',0,32),(104,'had seen',0,32),(105,'listen to',0,33),(106,'listens by',0,33),(107,'to listen',0,33),(108,'listening to',1,33),(109,'if',0,34),(110,'unless',0,34),(111,'that',0,34),(112,'so',1,34),(113,'May',0,35),(114,'Could',0,35),(115,'If',0,35),(116,'Would',1,35),(117,'did',0,36),(118,'had to',0,36),(119,'ought to',1,36),(120,'would',0,36),(121,'for',1,37),(122,'since',0,37),(123,'during',0,37),(124,'until',0,37),(133,'couldn\'t see very far',1,40),(134,'didn\'t have much money',0,40),(135,'was sick',0,40),(136,'made a bad grade',0,40),(137,'last',0,41),(138,'lowest',0,41),(139,'first',1,41),(140,'slower',0,41),(141,'What',0,42),(142,'It',1,42),(143,'She',0,42),(144,'He',0,42),(145,'for downtown',0,43),(146,'downtown',1,43),(147,'at downtown',0,43),(148,'into downtown',0,43),(149,'good',0,44),(150,'better',1,44),(151,'nice',0,44),(152,'best',0,44),(153,'consider',0,45),(154,'considering',1,45),(155,'considered',0,45),(156,'considers',0,45),(157,'Will use',0,46),(158,'Use',0,46),(159,'To use',1,46),(160,'Using',0,46),(161,'at',0,47),(162,'for',0,47),(163,'during',0,47),(164,'with',1,47),(165,'have',1,48),(166,'had',0,48),(167,'has',0,48),(168,'having',0,48),(169,'rifle',1,49),(170,'commander',0,49),(171,'grenade',0,49),(172,'pistol',0,49),(173,'rifles',0,50),(174,'surrenders',0,50),(175,'service pistols',1,50),(176,'bullets',0,50),(177,'large',0,51),(178,'designed',0,51),(179,'indirect',0,51),(180,'portable',1,51),(181,'They use smoothbore machine guns.',1,52),(182,'They use tracks to travel over rough land.',0,52),(183,'They use three different types of weapons.',0,52),(184,'They can aim their weapons automatically.',0,52),(185,'disappointed',1,53),(186,'satisfied',0,53),(187,'cheerful',0,53),(188,'capable',0,53),(189,'complicated',1,54),(190,'energetic',0,54),(191,'extravagant',0,54),(192,'intelligent',0,54),(193,'cherished',0,55),(194,'easygoing',0,55),(195,'flexible',0,55),(196,'negative',1,55),(197,'is lacking an address',0,56),(198,'is lost among my papers',0,56),(199,'requires your urgent comment',1,56),(200,'has been posted as you requested',0,56),(201,'rented out lately',0,57),(202,'seriously deteriorating',1,57),(203,'well-cared by its tenants',0,57),(204,'unfortunately occupied',0,57),(205,'debated',1,58),(206,'alternated',0,58),(207,'founded',0,58),(208,'inherited',0,58),(209,'discipline',0,59),(210,'facility',0,59),(211,'privacy',1,59),(212,'representation',0,59),(213,'eager',0,60),(214,'liberal ',0,60),(215,'mean',1,60),(216,'inferior',0,60),(217,'conveyed',0,61),(218,'associated',0,61),(219,'interpreted',0,61),(220,'predicted',1,61),(221,'landmarks',0,62),(222,'restrictions',1,62),(223,'percentages',0,62),(224,'circumstances',0,62),(225,'advised',0,63),(226,'occupied',0,63),(227,'proposed',1,63),(228,'recognized',0,63),(229,' sociable',0,64),(230,' expressive',1,64),(231,' reasonable',0,64),(232,' objective',0,64),(233,' particularly',1,65),(234,'sensibly',0,65),(235,'moderately',0,65),(236,' considerably',0,65),(237,' stumble',1,66),(238,' graze',0,66),(239,'navigate',0,66),(240,' dwell',0,66),(241,' initial ',0,67),(242,' annual',1,67),(243,' evident',0,67),(244,' occasional',0,67),(245,' factors',1,68),(246,'outcomes',0,68),(247,' missions',0,68),(248,' identities',0,68),(249,' distantly',0,69),(250,' meaningfully',0,69),(251,' cheerfully',0,69),(252,' vividly',1,69),(253,'napping',0,70),(254,' scooping',0,70),(255,'flipping',0,70),(256,' chirping',1,70),(257,' benefit',0,71),(258,' contact',1,71),(259,' gesture',0,71),(260,' favor',0,71),(261,' causal',0,72),(262,'durable',0,72),(263,' manual ',1,72),(264,'violent',0,72),(265,' mature',0,73),(266,' usual',0,73),(267,' seasonal',1,73),(268,' particular',0,73),(269,' requirements',1,74),(270,' techniques',0,74),(271,' situations',0,74),(272,'principles',0,74),(273,' distribute',0,75),(274,' fulfill',1,75),(275,' convince',0,75),(276,'monitor',0,75),(277,' chilly',0,76),(278,' liberal',0,76),(279,' hollow',1,76),(280,' definite',0,76),(281,'slipped',0,77),(282,'dumped',0,77),(283,' twisted',1,77),(284,'recovered',0,77),(285,' decisions',0,78),(286,' beliefs',1,78),(287,' styles',0,78),(288,' degrees',0,78),(289,' persuasive',0,79),(290,' tolerable',0,79),(291,' suspicious',0,79),(292,' demanding',1,79),(293,' anxiously',1,80),(294,' precisely',0,80),(295,'evidently',0,80),(296,' distinctly',0,80),(297,' deposited',0,81),(298,' reserved',0,81),(299,' vanished',0,81),(300,' surrounded',1,81),(301,' credit',0,82),(302,' impress',1,82),(303,' relieve',0,82),(304,' acquire',0,82),(305,' flake',0,83),(306,' blossom',0,83),(307,' blanket',1,83),(308,' flash',0,83),(309,' angles',0,84),(310,' margins',1,84),(311,' exceptions',0,84),(312,' limitations',0,84),(313,' hardship',0,85),(314,'comment',0,85),(315,' bargain',0,85),(316,'penalty',1,85),(317,' conducted',1,86),(318,' confirmed',0,86),(319,' implied',0,86),(320,' improved',0,86),(321,' efficient',0,87),(322,' reliable',0,87),(323,'massive',1,87),(324,' adequate',0,87),(325,' tenderly',0,88),(326,' properly',1,88),(327,' solidly',0,88),(328,' favorably',0,88),(329,'pursue',1,89),(330,'swear',0,89),(331,' reserve',0,89),(332,'draft',0,89),(333,' native',1,90),(334,'tricky',0,90),(335,' remote',0,90),(336,'vacant',0,90),(337,' appoint',0,91),(338,'eliminate',0,91),(339,' occupy',0,91),(340,' identify',1,91),(341,'relaxing',0,92),(342,' embarrassing',1,92),(343,' appealing',0,92),(344,' defending',0,92),(345,' barely',1,93),(346,' fairly',0,93),(347,' merely',0,93),(348,'readily',0,93),(349,' guide',0,94),(350,' trace',1,94),(351,' code',0,94),(352,'print',0,94),(353,' accessed',0,95),(354,' edited',0,95),(355,' imposed',0,95),(356,' urged',1,95),(357,'constitutions',0,96),(358,'objections',0,96),(359,' sculptures',1,96),(360,'adventures',0,96),(361,' dip',0,97),(362,' beam',1,97),(363,' spark',0,97),(364,' path',0,97),(365,' enclosed',1,98),(366,' installed',0,98),(367,' preserved',0,98),(368,' rewarded',0,98),(369,' signal',0,99),(370,'glory',0,99),(371,'medal',1,99),(372,' profit',0,99),(373,'balanced',0,100),(374,' calculated',0,100),(375,'disguised',1,100),(376,' registered',0,100),(377,' aware',1,101),(378,'ashamed',0,101),(379,'doubtful',0,101),(380,'guilty',0,101),(381,' innocence',0,102),(382,' estimation',0,102),(383,'assurance',0,102),(384,'observation',1,102),(385,' journey',0,103),(386,' traffic',0,103),(387,' concert',1,103),(388,'record',0,103),(389,' awful',0,104),(390,' drowsy',0,104),(391,' tragic',0,104),(392,' upset',1,104),(393,' accent',1,105),(394,' identity',0,105),(395,'gratitude',0,105),(396,'signature',0,105),(397,' ceased',0,106),(398,' committed',0,106),(399,' confined',1,106),(400,' conveyed',0,106),(401,' injury',1,107),(402,' offense',0,107),(403,'sacrifice',0,107),(404,' victim',0,107),(405,'security',0,108),(406,'maturity',0,108),(407,' facility',0,108),(408,' generosity',1,108),(409,' tolerates',0,109),(410,' associates',0,109),(411,' demonstrates',1,109),(412,'exaggerates',0,109),(413,'durable',0,110),(414,'private',0,110),(415,'realistic',0,110),(416,'numerous',1,110),(417,'Occasionally',1,111),(418,'Automatically',0,111),(419,'Enormously',0,111),(420,' Innocently',0,111),(421,' isolation',0,112),(422,' promotion',0,112),(423,' retirement',1,112),(424,' announcement',0,112),(425,' alert',0,113),(426,' itchy',1,113),(427,'steady',0,113),(428,' flexible',0,113),(429,' conquered',1,114),(430,'estimated',0,114),(431,' guaranteed',0,114),(432,' intensified',0,114),(433,' ruined',1,115),(434,'cracked',0,115),(435,'hastened',0,115),(436,'neglected',0,115),(437,' primitive',0,116),(438,'spiritual',0,116),(439,' representative',1,116),(440,' informative',0,116),(441,' liberally',0,117),(442,'individually',0,117),(443,'financially',0,117),(444,'environmentally',1,117),(473,'when there is no danger',0,125),(474,'when the building is on fire',1,125),(475,'when there is a high-ranking visitor',0,125),(476,'when the weather is cold',0,125),(477,'happy',1,126),(478,'sad',0,126),(479,'angry',0,126),(480,'jealous',0,126),(481,'find',0,127),(482,'plan',1,127),(483,'enjoy',0,127),(484,'suggest',0,127),(485,'a leader',0,128),(486,'a commander',0,128),(487,'an instructor',0,128),(488,'a specialist',1,128),(489,'He should increase his speed.',0,129),(490,'He should continue at the same speed.',0,129),(491,'He should decrease his speed.',1,129),(492,'He should stop.',0,129),(493,'to begin',1,130),(494,'to change',0,130),(495,'to process',0,130),(496,'to finish',0,130),(497,'a few',0,131),(498,'none',0,131),(499,'a little',0,131),(500,'a lot',1,131),(501,'It was established.',1,132),(502,'It stopped operating.',0,132),(503,'It was making a lot of money.',0,132),(504,'A new branch office was set up.',0,132),(505,'Were you involved?',1,133),(506,'Did you wash him?',0,133),(507,'Did you assist him?',0,133),(508,'Did you watch what he did?',0,133),(509,'an argument',0,134),(510,'a command',0,134),(511,'a farm',0,134),(512,'a report',1,134),(513,'something expensive',1,135),(514,'something delicious',0,135),(515,'something cheap',0,135),(516,'something heavy',0,135),(517,'The heat should be very hot.',0,136),(518,'The heat should be medium.',1,136),(519,'The heat should be very low.',0,136),(520,'The heat should be turned off.',0,136),(521,'to start again',0,137),(522,'to be stolen',0,137),(523,'to break into pieces',0,137),(524,'to stop working suddenly',1,137),(525,'a stick',1,138),(526,'a ball',0,138),(527,'a hole',0,138),(528,'a box',0,138),(529,'a little hot',1,139),(530,'very warm',0,139),(531,'quite cold',0,139),(532,'freezing',0,139),(533,'on top of the refrigerator',0,140),(534,'in front of the refrigerator',0,140),(535,'behind the refrigerator',1,140),(536,'to the left of the refrigerator',0,140),(537,'houses for sale',0,141),(538,'houses to let',1,141),(539,'houses to buy',0,141),(540,'land to build a house on',0,141),(541,'The wire is not good.',0,142),(542,'The wire is not protected.',1,142),(543,'The wire is not carrying electricity.',0,142),(544,'The wire is not visible.',0,142),(545,'an unusual one',0,143),(546,'the first one',0,143),(547,'an ordinary one',1,143),(548,'the last one',0,143),(549,'It was too expensive.',0,144),(550,'There was a lot of fruit in stock.',0,144),(551,'It had gone bad.',1,144),(552,'She didn\'t feel like eating fruit.',0,144),(553,'I\'ll tell you anything you want to know.',0,145),(554,'I\'ll help in any way I can.',1,145),(555,'I won\'t be able to stop laughing.',0,145),(556,'I haven\'t thought about him in years.',0,145),(557,'The camera is out of order.',0,146),(558,'The film is out of order.',1,146),(559,'There is no film in the camera.',0,146),(560,'The film is sold out.',0,146),(561,'through blood',1,147),(562,'by a human mistake',0,147),(563,'through an animal',0,147),(564,'through food',0,147),(565,'His eye was hit by a baseball.',1,148),(566,'The light of the sun hurt his eyes.',0,148),(567,'He sat through last night\'s game.',0,148),(568,'He was expelled from last night\'s game.',0,148),(569,'I\'d like to have them both.',1,149),(570,'I drink it when it\'s cold.',0,149),(571,'We don\'t have to stay here long.',0,149),(572,'I\'d like a cup of coffee, please.',0,149),(573,'She has just graduated from college.',0,150),(574,'She never graduated from college.',0,150),(575,'She will be studying at college.',0,150),(576,'She is going to graduate from college.',1,150),(577,'They were alternated.',0,151),(578,'They were congratulated.',0,151),(579,'They were discharged.',1,151),(580,'They were graduated.',0,151),(581,'He frightened them.',0,152),(582,'He repelled them.',1,152),(583,'He trusted them.',0,152),(584,'He made friends with them.',0,152),(585,'Her voice is beautiful.',0,153),(586,'Her house is beautiful.',0,153),(587,'Her face is beautiful.',0,153),(588,'Her body shape is beautiful.',1,153),(589,'He was chosen to deal with the crisis.',1,154),(590,'He couldn\'t get out of the trouble.',0,154),(591,'He was blamed for the mistake.',0,154),(592,'He successfully solved the problem.',0,154),(593,'He drew it up.',0,155),(594,'He is against it.',1,155),(595,'He is explaining it.',0,155),(596,'He will carry it out.',0,155),(597,'He is searching for a brand-new car.',1,156),(598,'He is testing his new car.',0,156),(599,'He is shopping for a second-hand car.',0,156),(600,'He is selling a second -hand car.',0,156),(601,'He went ahead of us.',0,157),(602,'He would come with us.',0,157),(603,'He wanted to join us.',1,157),(604,'He could go with us.',0,157),(605,'A schedule was lost.',0,158),(606,'A schedule was destroyed.',0,158),(607,'A schedule was found.',0,158),(608,'A schedule was established.',1,158),(609,'I\'m grateful to you.',1,159),(610,'I think nothing of it.',0,159),(611,'I can\'t wait to have it.',0,159),(612,'I totally agree with you.',0,159),(613,'There is no one in the waiting room.',0,160),(614,'There are a lot of people in the waiting room.',1,160),(615,'There are few people in the waiting room.',0,160),(616,'There are a few people in the waiting room.',0,160),(617,'She must roll it up.',1,161),(618,'She must double it over.',0,161),(619,'She must clean it up.',0,161),(620,'She must read it again.',0,161),(621,'It was raining.',0,162),(622,'There was a lot of snow.',0,162),(623,'It was getting dark.',0,162),(624,'The visibility was poor.',1,162),(625,'She became very happy.',0,163),(626,'She received a surprise.',0,163),(627,'She felt unsteady.',1,163),(628,'She got a good deal.',0,163),(629,'Mr. Johnson is their cousin.',0,164),(630,'Mr. Johnson is their father.',1,164),(631,'Mr. Johnson is their brother.',0,164),(632,'Mr. Johnson is their uncle.',0,164),(633,'Harry wanted a sedan.',0,165),(634,'Harry didn\'t want a sports car.',0,165),(635,'Harry bought a sedan.',1,165),(636,'Harry bought a sports car.',0,165),(637,'They have to receive extensive training.',1,166),(638,'They train lightly because of exhaustion.',0,166),(639,'They skip extensive training.',0,166),(640,'They dislike extensive training.',0,166),(641,'It is just around the corner.',1,167),(642,'It is coming to an end.',0,167),(643,'It is about to finish.',0,167),(644,'It is never too late.',0,167),(645,'It mixed the shells up.',1,168),(646,'It put in the shells.',0,168),(647,'It fired the shells out.',0,168),(648,'It threw away the shells.',0,168),(649,'Their friends won\'t use the seats.',1,169),(650,'Their friends are in the seats.',0,169),(651,'The seats for their friends are cheap.',0,169),(652,'The seats are being held for their friends.',0,169),(653,'He is behind in his schoolwork.',1,170),(654,'He is good at his schoolwork.',0,170),(655,'He is the best student in class.',0,170),(656,'He is sitting in the back row of the classroom.',0,170),(657,'It is not working.',1,171),(658,'It has broken into pieces.',0,171),(659,'It is ready for sale.',0,171),(660,'It was broadcast live.',0,171),(661,'You and I are alike.',0,172),(662,'I think I\'ve seen you before.',1,172),(663,'I know you very well.',0,172),(664,'You look like someone in my family.',0,172),(665,'He is getting a shot.',1,173),(666,'He is getting weighed.',0,173),(667,'He is being examined.',0,173),(668,'He is being rescued.',0,173),(673,'cost',0,175),(674,'length',0,175),(675,'size',0,175),(676,'temperature',1,175),(677,'a steering device',0,176),(678,'a source of power',1,176),(679,'a job to do',0,176),(680,'a way of stopping',0,176),(681,'show her how to write',0,177),(682,'give her something to do',0,177),(683,'give her a pen to use',1,177),(684,'show her around',0,177),(685,'look for mistakes',1,178),(686,'write it again',0,178),(687,'begin a new job',0,178),(688,'pay him for his work',0,178),(689,'a way into the room',0,179),(690,'a way out of the room',1,179),(691,'a way to go though the window',0,179),(692,'a way to lock the door',0,179),(693,'in a fancy restaurant',0,180),(694,'at a noodle stand',0,180),(695,'in a fast food restaurant',1,180),(696,'in a Chinese restaurant',0,180),(697,'It was just cooked.',1,181),(698,'It was a warm day.',0,181),(699,'I already finished eating.',0,181),(700,'That\'s my favorite meal.',0,181),(701,'The girl looks nothing like her sister',0,182),(702,'The girl looks a lot like the woman\'s sister.',1,182),(703,'The girl acts like she\'s the woman\'s sister.',0,182),(704,'The girl is a little taller.',0,182),(705,'The cars are too heavy.',0,183),(706,'The road is quite wide.',0,183),(707,'The cars cannot go very fast.',0,183),(708,'The cars cannot pass each other.',1,183),(709,'It\'s a good place for exercising.',0,184),(710,'It\'s quiet there.',1,184),(711,'It\'s noisy there.',0,184),(712,'It\'s near their house.',0,184),(717,'slowly',0,186),(718,'fast',1,186),(719,'well',0,186),(720,'straight',0,186),(721,'It will probably rain.',1,187),(722,'It will not rain.',0,187),(723,'It will rain for sure.',0,187),(724,'It is impossible to rain this weekend.',0,187),(725,'They moved to the city.',0,188),(726,'They left the city.',0,188),(727,'They did some sightseeing.',1,188),(728,'The didn\'t like the city.',0,188),(729,'It is very important.',0,189),(730,'It is not woking very well.',1,189),(731,'It is destroyed.',0,189),(732,'It needs to be recharged.',0,189),(733,'A disaster was avoided.',0,190),(734,'A disaster was predicted.',0,190),(735,'A disaster occurred.',1,190),(736,'A disaster passed.',0,190),(737,'We had breakfast.',0,191),(738,'We exercised.',0,191),(739,'We talked.',1,191),(740,'We relaxed.',0,191),(741,'She wants us to stop playing around.',0,192),(742,'She wants us to wake up soon.',0,192),(743,'She wants us not to ride the horses.',1,192),(744,'She wants us to stop hanging around.',0,192),(745,'the dock',1,193),(746,'the raft',0,193),(747,'the truck',0,193),(748,'the swimming pool',0,193),(749,'drink it ',0,194),(750,'rub it on',1,194),(751,'dry it out',0,194),(752,'paint it',0,194),(753,'before they learned English',0,195),(754,'before 2005',0,195),(755,'in 2005',1,195),(756,'to attend flight school',0,195),(757,'a weapon',0,196),(758,'a signal',0,196),(759,'an award',0,196),(760,'an assignment',1,196),(761,'David drilled it.',1,197),(762,'David sewed it.',0,197),(763,'David wrote it.',0,197),(764,'David bought it.',0,197),(765,'He wants to wait before going to the beach.',0,198),(766,'He is excited about going to the beach.',1,198),(767,'He doesn\'t care for being outdoors.',0,198),(768,'He has to wait on the beach.',0,198),(769,'once a day',0,199),(770,'two times a day',1,199),(771,'once each two days',0,199),(772,'three times a day',0,199),(773,'It rains very often.',0,200),(774,'It remains the same.',0,200),(775,'It is always hot.',0,200),(776,'It changes often.',1,200),(777,'Yes, they use traffic lights.',0,201),(778,'Yes, they use helicopters.',1,201),(779,'Yes, they use radios.',0,201),(780,'Yes, they use police cars.',0,201),(781,'handle the books',0,202),(782,'test the magazines',0,202),(783,'have a quick look at them',1,202),(784,'buy a few of them',0,202),(785,'I answer James\' call.',0,203),(786,'I fought with James.',0,203),(787,'I met James',1,203),(788,'I scolded James.',0,203),(789,'Yes, she is happy and carefree.',1,204),(790,'Yes, she is English.',0,204),(791,'Nom she is carefree and happy.',0,204),(792,'No, she is saleswoman.',0,204),(793,'to indicate atmospheric pressure',0,205),(794,'to record air speed',0,205),(795,'to measure precipitation',0,205),(796,'to regulate temperature',1,205),(797,'because the car is rough',0,206),(798,'because the car is hot and dry',0,206),(799,'because the car stops',0,206),(800,'because the car slides easily',1,206),(801,'buy a newspaper',0,207),(802,'take a bus',1,207),(803,'see a doctor',0,207),(804,'go to bed early',0,207),(805,'She thinks she will fail the course.',0,208),(806,'She thinks she will succeed.',1,208),(807,'She wants to drop the course.',0,208),(808,'She wants to take it over.',0,208),(809,'He can\'t see very well.',0,209),(810,'He is mute.',0,209),(811,'Ir is hard to listen to him sing.',0,209),(812,'There is a problem with his hearing.',1,209),(813,'He is worse than David.',0,210),(814,'He is more handsome than David.',0,210),(815,'He is much better than David.',1,210),(816,'He is a better friend than David.',0,210),(817,'He gave them a briefing.',0,211),(818,'He organized their vehicles.',0,211),(819,'He gave them a big hand.',0,211),(820,'He watched them march.',1,211),(821,'You will very likely feel cold.',0,212),(822,'You will very likely feel warm.',0,212),(823,'You will very likely get sick.',1,212),(824,'You will very likely buy a coat.',0,212),(825,'I don\'t like to read.',0,213),(826,'I like to read all the time.',0,213),(827,'I like to read about cars.',0,213),(828,'I like to read when I am free.',1,213),(829,'There was an ambulance behind John.',1,214),(830,'There was a taxi behind John.',0,214),(831,'There was music behind John.',0,214),(832,'There was a bicycle behind John.',0,214),(833,'The weather is bad.',0,215),(834,'The work is too hard.',1,215),(835,'The road is rough.',0,215),(836,'The picture is all right.',0,215),(837,'He took it away.',1,216),(838,'He bought it.',0,216),(839,'He took off its cover.',0,216),(840,'He read it.',0,216),(841,'The solution was unknown.',0,217),(842,'The solution was apparent.',1,217),(843,'The solution was dangerous.',0,217),(844,'The solution was essential.',0,217),(845,'It must be flat.',1,218),(846,'It must be long.',0,218),(847,'It must be square.',0,218),(848,'It must be large.',0,218),(849,'We confused the enemy.',0,219),(850,'We met the enemy.',1,219),(851,'We defeated the enemy.',0,219),(852,'We avoided the enemy.',0,219),(853,'Mary will compete with the female candidate.',0,220),(854,'Mary will choose the female candidate.',1,220),(855,'Mary doesn\'t like the female candidate.',0,220),(856,'Mary will work for the female candidate.',0,220),(857,'It can\'t fit.',1,221),(858,'He doesn\'t own it.',0,221),(859,'It was too heavy for him.',0,221),(860,'He doesn\'t like it.',0,221),(861,'He didn\'t see the passengers.',0,222),(862,'He didn\'t like the noise it made.',0,222),(863,'He didn\'t see the plane landing.',0,222),(864,'He didn\'t know the arrival time.',1,222),(865,'Peter can\'t understand them.',1,223),(866,'Peter can\'t stand up to them.',0,223),(867,'Peter will make them stand up.',0,223),(868,'Peter can\'t tolerate them.',0,223),(869,'They\'re becoming longer.',1,224),(870,'They\'re becoming more interesting.',0,224),(871,'They\'re becoming more rigid.',0,224),(872,'They\'re becoming more important.',0,224),(873,'They saved him.',1,225),(874,'They surrounded him.',0,225),(875,'They located him.',0,225),(876,'They buried him.',0,225),(877,'She doesn\'t know the truth.',1,226),(878,'She wants to tell the truth.',0,226),(879,'She is willing to tell the truth.',0,226),(880,'She doesn\'t want to tell the truth.',0,226),(881,'They neglected his warning.',1,227),(882,'They liked his warning.',0,227),(883,'They forgot his warning.',0,227),(884,'They remembered his warning.',0,227),(885,'this kind of watch is very expensive.',1,228),(886,'This kind of watch breaks easily.',0,228),(887,'You cannot buy this kind of watch anymore.',0,228),(888,'You will not like this kind of watch.',0,228),(889,'It is good for insulation.',1,229),(890,'It burns easily.',0,229),(891,'It is easy to lose.',0,229),(892,'It is very expensive.',0,229),(893,'He dislikes them very much.',1,230),(894,'He makes them angry.',0,230),(895,'He has great trouble working with them.',0,230),(896,'He has a high regard for them.',0,230),(897,'I was sick last night.',1,231),(898,'I finished last night.',0,231),(899,'I went running last night.',0,231),(900,'I was in a rush last night.',0,231),(901,'I don’t want to see your new home.',1,232),(902,'I don’t  want anything in your new home.',0,232),(903,'I really want to see your new home.',0,232),(904,'I would give anything to have a new home.',0,232),(905,'The damage wasn’t necessary.',1,233),(906,'There was only a little damage.',0,233),(907,'No damage was detected.',0,233),(908,'There was major damage.',0,233),(909,'He has enough time',1,234),(910,'He hasn’t enough time.',0,234),(911,'He has extra time. ',0,234),(912,'He has limited time.',0,234),(913,'She wanted to know the cost. ',1,235),(914,'She wanted to know the means.',0,235),(915,'She wanted to know the answer.',0,235),(916,'She wanted to know the reason.',0,235),(917,'a house ',0,236),(918,'a trip',1,236),(919,'a car',0,236),(920,'a friend',0,236),(921,'The man should buy new clothing.',1,237),(922,'The man has poor taste in clothing.',0,237),(923,'The man should try to find his belt.',0,237),(924,'The man should lose weight.',0,237),(925,'It was expanded five months ago.',0,238),(926,'It was started five months ago.',1,238),(927,'It was moved five months ago.',0,238),(928,'It was closed five months ago.',0,238),(929,'It matched her furniture.',1,239),(930,'It was a bargain.',0,239),(931,'It was nice to site in.',0,239),(932,'It was a pretty color.',0,239),(933,'He paid for it ahead of time.',1,240),(934,'He paid for it little by little.',0,240),(935,'He paid for it with a loan.',0,240),(936,'He paid for it with a check.',0,240),(937,'to work',1,241),(938,'on a trip',0,241),(939,'to school',0,241),(940,'on a picnic',0,241),(941,'He wanted to go to bed.',1,242),(942,'He wanted to get cleaned up.',0,242),(943,'He wanted to drink something cold.',0,242),(944,'He wanted to get somewhere fast.',0,242),(945,'His house was pretty.',0,243),(946,'His house was old.',0,243),(947,'His house was big.',1,243),(948,'His house was modern.',0,243),(949,'She was studying how to build things.',1,244),(950,'She was studying how to write stories.',0,244),(951,'She was studying how to teach children.',0,244),(952,'She was studying how to fix teeth.',0,244),(953,'descending',1,245),(954,'shacking',0,245),(955,'rolling',0,245),(956,'climbing',0,245),(957,'He is careless.',1,246),(958,'He is at fault.',0,246),(959,'He is lazy.',0,246),(960,'He likes to criticize.',0,246),(961,'play ball',1,247),(962,'eat supper',0,247),(963,'work',0,247),(964,'sleep',0,247),(965,'putting off the meeting',1,248),(966,'canceling the meeting',0,248),(967,'attending the meeting',0,248),(968,'holding a meeting',0,248),(969,'took some medicine',1,249),(970,'ran away',0,249),(971,'got a ticket',0,249),(972,'said he was sorry',0,249),(973,' in a trailer home',1,250),(974,'far from the base',0,250),(975,'near from the base',0,250),(976,'on the other side of town',0,250),(977,'give them a briefing',1,251),(978,'see how the class was conduct',0,251),(979,'teach the class ',0,251),(980,'interview the student',0,251),(985,'the speed',1,253),(986,'the angle',0,253),(987,'the diameter',0,253),(988,'the circumference',0,253),(989,'decorating a house',1,254),(990,'selling a house',0,254),(991,'building a house',0,254),(992,'tearing down a house',0,254),(993,'to be net',1,255),(994,'to be fair',0,255),(995,'to be truthful',0,255),(996,'to be on time',0,255),(997,'He threw them away.',1,256),(998,'He published them.',0,256),(999,'He put them on.',0,256),(1000,'He kicked them off.',0,256),(1001,'go up and down',1,257),(1002,'stay the same',0,257),(1003,'rise steadily',0,257),(1004,'fall steadily',0,257),(1005,'a sharp mind ',1,258),(1006,'explosives',0,258),(1007,'the desire to succeed',0,258),(1008,'a prolonged illness',0,258),(1009,'come and pick him up',0,259),(1010,'cook some food for him',0,259),(1011,'buy some food',1,259),(1012,'order some food at home',0,259),(1013,'to write to the doctor',0,260),(1014,'to call the doctor',0,260),(1015,'to find out about the doctor',0,260),(1016,'to go see the doctor',1,260),(1017,'She allowed John to take the car.',1,261),(1018,'She warned John not to take the car.',0,261),(1019,'She ordered John to drive the car.',0,261),(1020,'She gave John a ride in the car.',0,261),(1021,'the time of the meeting',1,262),(1022,'how to repair the radio',0,262),(1023,'where Main Street is',0,262),(1024,'what to buy ',0,262),(1025,'She’ll ask for the money.',0,263),(1026,'She’ll complain.',0,263),(1027,'She’ll stop working so hard.',0,263),(1028,'She’ll leave her job.',1,263),(1029,'after a while',0,264),(1030,'within minutes',1,264),(1031,'after a week',0,264),(1032,'in a day',0,264),(1033,'We agree with them.',0,265),(1034,'We employ them.',0,265),(1035,'We unite them.',0,265),(1036,'We contact them.',1,265),(1037,'act like their parents ',1,266),(1038,'help their parents',0,266),(1039,'admire the parents',0,266),(1040,'live with their parents',0,266),(1041,'She turned him down.',0,267),(1042,'She got lost.',0,267),(1043,'She didn’t show up.',1,267),(1044,'She was late.',0,267),(1045,'He found that his work was hard.',0,268),(1046,'He started doing his work.',0,268),(1047,'He started looking for work.',0,268),(1048,'He made sure his work was right.',1,268),(1049,'He was not sure of the scores.',0,269),(1050,'He was unhappy with the scores.',1,269),(1051,'He was studying the scores.',0,269),(1052,'He was evaluating the scores.',0,269),(1053,'There were no results.',0,270),(1054,'There were no expectations.',0,270),(1055,'The results were not what Major Wilson expected.',1,270),(1056,'The results were what Major Wilson expected.',0,270),(1057,'I’m not surprised by the results.',0,271),(1058,'I didn’t I would pass the exam.',0,271),(1059,'I didn’t think I would pass the exam.	',1,271),(1060,'I knew I would pass the exam.',0,271),(1061,'They were praised.',0,272),(1062,'They were congratulated.',0,272),(1063,'They were kicked out.',1,272),(1064,'They graduated.',0,272),(1065,'They repelled it.',1,273),(1066,'They prevented it.',0,273),(1067,'They missed it.',0,273),(1068,'They started it.',0,273),(1069,'There was a traffic jam this morning.',1,274),(1070,'There was a car accident this morning.',0,274),(1071,'Cars were going at a high speed.',0,274),(1072,'The traffic light was out of order.',0,274),(1073,'The song makes her sad.',0,275),(1074,'The song is about love.',0,275),(1075,'She knows the singer very well.',0,275),(1076,'She has memorized the song.',1,275),(1077,'We must feed them.',0,276),(1078,'We must hit them.',0,276),(1079,'We must treat them.',0,276),(1080,'We must locate them.',1,276),(1081,'The washing machine is not working properly.',1,277),(1082,'The machine is user-friendly.',0,277),(1083,'The price of this washing machine is going up.',0,277),(1084,'The washing machine is now for sale.',0,277),(1085,'He won the lottery.',0,278),(1086,'He always thinks of the lottery.',1,278),(1087,'He has never bought any lottery tickets.',0,278),(1088,'Winning the lottery made him rich.',0,278),(1089,'I hailed a taxi.',0,279),(1090,'I was diving taxi.',0,279),(1091,'The taxi almost hit me.',1,279),(1092,'I was waiting for a taxi.',0,279),(1093,'A schedule was destroyed.',0,280),(1094,'A schedule was lost.',0,280),(1095,'A schedule was established.',1,280),(1096,'A schedule was found.',0,280),(1097,'James is confident about himself.',0,281),(1098,'James is proud of them.',0,281),(1099,'James is not true to himself.',0,281),(1100,'James lacks self-confidence.',1,281),(1101,'They had a normal day.',0,282),(1102,'They worked hard during the emergency.',1,282),(1103,'They had a practice drill.',0,282),(1104,'They had a false alarm.',0,282),(1105,'Don’t let her tell.',0,283),(1106,'Don’t tell her.',1,283),(1107,'Don’t talk about her.',0,283),(1108,'Don’t forget to tell her.',0,283),(1109,'It is said that he is having an affair.',1,284),(1110,'We believe he is having an affair.',0,284),(1111,'The rumor is not fair.',0,284),(1112,'We’ve never heard the rumer.',0,284),(1113,'It was raining.',0,285),(1114,'The visibility was poor.',1,285),(1115,'It was getting dark.',0,285),(1116,'There was a lot of snow.',0,285),(1117,'She received a surprise.',0,286),(1118,'She became very happy.',0,286),(1119,'She got a good deal.',0,286),(1120,'She felt unsteady.',1,286),(1121,'That medicine tasted bitter.',0,287),(1122,'That medicine worked miracles.',1,287),(1123,'The medicine tasted like wine.',0,287),(1124,'The medicine was prescribed carefully.',0,287),(1125,'They deserted their children.',0,288),(1126,'They moved because of their children.',1,288),(1127,'Their children didn’t move with them.',0,288),(1128,'They sent their children to Manhattan.',0,288),(1129,'Harry bought a sedan.',1,289),(1130,'Harry bought a sports car.',0,289),(1131,'Harry wanted a sedan.',0,289),(1132,'Harry didn’t want a sports car.',0,289),(1133,'They skip extensive training.',0,290),(1134,'They dislike extensive training.',0,290),(1135,'They have to receive extensive training.',1,290),(1136,'They train lightly because of exhaustion.',0,290),(1137,'You should have called me.',0,291),(1138,'You are supposed to call me after meeting me.',0,291),(1139,'Let me know if you cannot come.',1,291),(1140,'Call me when you arrive.',0,291),(1141,'It pulled in the shells.',0,292),(1142,'It mixed the shells.',0,292),(1143,'It threw out the shells.',1,292),(1144,'It fired the shells.',0,292),(1145,'The table is being held for their friends.',1,293),(1146,'The table for their friends is cheap.',0,293),(1147,'Their friends are in the seats.',0,293),(1148,'Their friends won’t use the seats.',0,293),(1149,'It is good to hear you say that.',0,294),(1150,'It’s getting chilly.',0,294),(1151,'It’s perfect for cooking.',0,294),(1152,'It feels very hot.',1,294),(1153,'Don’t forget to write her a letter.',0,295),(1154,'Don\'t forget to see her tomorrow.',0,295),(1155,'Don\'t forget to send her an e-mail.',0,295),(1156,'Don\'t forget to telephone her.',1,295),(1157,'turn right at the next corner',0,296),(1158,'give the woman a ride',0,296),(1159,'look for the taxi',0,296),(1160,'send a taxi immediately.',1,296),(1161,'She doesn’t like the man.',0,297),(1162,'She doesn’t know how to paint.',0,297),(1163,'It’s in the morning.',0,297),(1164,'She has an appointment to meet someone.',1,297),(1165,'He received a present at the meeting.',0,298),(1166,'He enjoying the meeting.',0,298),(1167,'He attended the meeting.',1,298),(1168,'He was the speaker.',0,298),(1169,'Richard has been standing in the wrong place.',0,299),(1170,'Richard hasn’t heard it correctly.',0,299),(1171,'Richard doesn’t know what it means.',1,299),(1172,'Richard means everything he says.',0,299),(1173,'She should treat him to dinner.',0,300),(1174,'It’s very easy .',0,300),(1175,'He’s hungry.',0,300),(1176,'It’s too difficult for him.',1,300),(1177,'He doesn’t like his new apartment.',1,301),(1178,'Someone is standing behind him.',0,301),(1179,'He back aches.',0,301),(1180,'Someone is trying to kill them.',0,301),(1181,'Colonel Roberts will not to give a speech.',0,302),(1182,'Colonel Roberts will ignore the speaker.',0,302),(1183,'Colonel Roberts will be the main speaker.',1,302),(1184,'Colonel Roberts will introduce the speaker.',0,302),(1185,'a chief',0,303),(1186,'a customer',0,303),(1187,'a waitress ',1,303),(1188,'a janitor',0,303),(1189,'one',1,304),(1190,'a few',0,304),(1191,'Two',0,304),(1192,'none',0,304),(1193,' stop working ',0,305),(1194,'do the work better',0,305),(1195,'continue to work ',1,305),(1196,'do the work over again',0,305),(1329,'Steps to get rid of bedbugs.',0,339),(1330,'Ways to use foggers correctly.',0,339),(1331,'The ineffectiveness of bug bombs.',1,339),(1332,'The problems caused by insects.',0,339),(1333,' It is a creature living inside our ears.',0,340),(1334,'It is a tune memorized in a personal way.',0,340),(1335,'It is a melody repeating in our heads.',1,340),(1336,'It is a commercial recalled through lyrics.',0,340),(1337,'Being a cleaner for other fish.',1,341),(1338,'Being a bodyguard for other fish.',0,341),(1339,'Being a gardener for roots and plants.',0,341),(1340,'Being a caretaker for sponge and algae.',0,341),(1341,'The trees were taller and stronger.',0,342),(1342,'The soil was softer for seeds to sprout.',0,342),(1343,'The climate was warmer and more humid.',1,342),(1344,'The temperature was lower along the Pacific coast.',0,342),(1345,'A Painful Mistake',0,343),(1346,'A Great Adventure',0,343),(1347,'A Lifelong Punishment',0,343),(1348,'A New Direction in Life',1,343),(1349,'Maasai people are a threat to elephants.',1,344),(1350,'Kamba people raise elephants for farming.',0,344),(1351,'Both Kamba and Maasai people are elephant hunters.',0,344),(1352,'Both Kamba and Maasai people traditionally wear red clothing.',0,344),(1353,'Facial expressions.',1,345),(1354,'Physical contact.',0,345),(1355,'Rate of speech.',0,345),(1356,'Eye contact.',0,345),(1357,'They are quick in movement.',0,346),(1358,'They are very active in the daytime.',0,346),(1359,'They are decreasing in number.',1,346),(1360,'They have a short lifespan for insects.',0,346),(1361,'They are part of the graduation ceremony.',0,347),(1362,'They are occasions for teens to show off their limousines.',0,347),(1363,'They are important events for teenagers to learn social skills.',1,347),(1364,'They are formal events in which teens share their traumatic experiences.',0,347),(1365,'personal wearable device',0,348),(1366,'graphic process unit',1,348),(1367,'cloud sharing service',0,348),(1368,'media streaming service',0,348),(1377,'when there is no danger',0,353),(1378,'when the building is on fire',1,353),(1379,'when there is a high-ranking visitor',0,353),(1380,'when the weather is cold',0,353),(1381,'happy',1,354),(1382,'sad',0,354),(1383,'angry',0,354),(1384,'jealous',0,354),(1385,'find',0,355),(1386,'plan',1,355),(1387,'enjoy',0,355),(1388,'suggest',0,355),(1389,'a leader',0,356),(1390,'a commander',0,356),(1391,'an instructor',0,356),(1392,'a specialist',1,356),(1393,'He should increase his speed.',0,357),(1394,'He should continue at the same speed.',0,357),(1395,'He should decrease his speed.',1,357),(1396,'He should stop.',0,357),(1397,'to begin',1,358),(1398,'to change',0,358),(1399,'to process',0,358),(1400,'to finish',0,358),(1401,'a few',0,359),(1402,'none',0,359),(1403,'a little',0,359),(1404,'a lot',1,359),(1405,'It was established.',1,360),(1406,'It stopped operating.',0,360),(1407,'It was making a lot of money.',0,360),(1408,'A new branch office was set up.',0,360),(1409,'Were you involved?',1,361),(1410,'Did you wash him?',0,361),(1411,'Did you assist him?',0,361),(1412,'Did you watch what he did?',0,361),(1413,'an argument',0,362),(1414,'a command',0,362),(1415,'a farm',0,362),(1416,'a report',1,362),(1417,'something expensive',1,363),(1418,'something delicious',0,363),(1419,'something cheap',0,363),(1420,'something heavy',0,363),(1421,'The heat should be very hot.',0,364),(1422,'The heat should be medium.',1,364),(1423,'The heat should be very low.',0,364),(1424,'The heat should be turned off.',0,364),(1425,'to start again',0,365),(1426,'to be stolen',0,365),(1427,'to break into pieces',0,365),(1428,'to stop working suddenly',1,365),(1429,'a stick',1,366),(1430,'a ball',0,366),(1431,'a hole',0,366),(1432,'a box',0,366),(1433,'a little hot',1,367),(1434,'very warm',0,367),(1435,'quite cold',0,367),(1436,'freezing',0,367),(1437,'on top of the refrigerator',0,368),(1438,'in front of the refrigerator',0,368),(1439,'behind the refrigerator',1,368),(1440,'to the left of the refrigerator',0,368),(1441,'houses for sale',0,369),(1442,'houses to let',1,369),(1443,'houses to buy',0,369),(1444,'land to build a house on',0,369),(1445,'The wire is not good.',0,370),(1446,'The wire is not protected.',1,370),(1447,'The wire is not carrying electricity.',0,370),(1448,'The wire is not visible.',0,370),(1449,'an unusual one',0,371),(1450,'the first one',0,371),(1451,'an ordinary one',1,371),(1452,'the last one',0,371),(1453,'It was too expensive.',0,372),(1454,'There was a lot of fruit in stock.',0,372),(1455,'It had gone bad.',1,372),(1456,'She didn\'t feel like eating fruit.',0,372),(1457,'I\'ll tell you anything you want to know.',0,373),(1458,'I\'ll help in any way I can.',1,373),(1459,'I won\'t be able to stop laughing.',0,373),(1460,'I haven\'t thought about him in years.',0,373),(1461,'The camera is out of order.',0,374),(1462,'The film is out of order.',1,374),(1463,'There is no film in the camera.',0,374),(1464,'The film is sold out.',0,374),(1465,'through blood',1,375),(1466,'by a human mistake',0,375),(1467,'through an animal',0,375),(1468,'through food',0,375),(1469,'His eye was hit by a baseball.',1,376),(1470,'The light of the sun hurt his eyes.',0,376),(1471,'He sat through last night\'s game.',0,376),(1472,'He was expelled from last night\'s game.',0,376),(1473,'I\'d like to have them both.',1,377),(1474,'I drink it when it\'s cold.',0,377),(1475,'We don\'t have to stay here long.',0,377),(1476,'I\'d like a cup of coffee, please.',0,377),(1477,'She has just graduated from college.',0,378),(1478,'She never graduated from college.',0,378),(1479,'She will be studying at college.',0,378),(1480,'She is going to graduate from college.',1,378),(1481,'They were alternated.',0,379),(1482,'They were congratulated.',0,379),(1483,'They were discharged.',1,379),(1484,'They were graduated.',0,379),(1485,'He frightened them.',0,380),(1486,'He repelled them.',1,380),(1487,'He trusted them.',0,380),(1488,'He made friends with them.',0,380),(1489,'Her voice is beautiful.',0,381),(1490,'Her house is beautiful.',0,381),(1491,'Her face is beautiful.',0,381),(1492,'Her body shape is beautiful.',1,381),(1493,'He was chosen to deal with the crisis.',1,382),(1494,'He couldn\'t get out of the trouble.',0,382),(1495,'He was blamed for the mistake.',0,382),(1496,'He successfully solved the problem.',0,382),(1497,'He drew it up.',0,383),(1498,'He is against it.',1,383),(1499,'He is explaining it.',0,383),(1500,'He will carry it out.',0,383),(1501,'He is searching for a brand-new car.',1,384),(1502,'He is testing his new car.',0,384),(1503,'He is shopping for a second-hand car.',0,384),(1504,'He is selling a second-hand car.',0,384),(1505,'He went ahead of us.',0,385),(1506,'He would come with us.',0,385),(1507,'He wanted to join us.',1,385),(1508,'He could go with us.',0,385),(1509,'A schedule was lost.',0,386),(1510,'A schedule was destroyed.',0,386),(1511,'A schedule was found.',0,386),(1512,'A schedule was established.',1,386),(1513,'I\'m grateful to you.',1,387),(1514,'I think nothing of it.',0,387),(1515,'I can\'t wait to have it.',0,387),(1516,'I totally agree with you.',0,387),(1517,'There is no one in the waiting room.',0,388),(1518,'There are a lot of people in the waiting room.',1,388),(1519,'There are few people in the waiting room.',0,388),(1520,'There are a few people in the waiting room.',0,388),(1521,'She must roll it up.',1,389),(1522,' She must double it over.',0,389),(1523,'She must clean it up.',0,389),(1524,'She must read it again.',0,389),(1525,'It was raining.',0,390),(1526,'There was a lot of snow.',0,390),(1527,'It was getting dark.',0,390),(1528,'The visibility was poor.',1,390),(1529,'She became very happy.',0,391),(1530,'She received a surprise.',0,391),(1531,'She felt unsteady.',1,391),(1532,'She got a good deal.',0,391),(1533,'Mr. Johnson is their cousin.',0,392),(1534,'Mr. Johnson is their father.',1,392),(1535,'Mr. Johnson is their brother.',0,392),(1536,'Mr. Johnson is their uncle.',0,392),(1537,'Harry wanted a sedan.',0,393),(1538,'Harry didn\'t want a sports car.',0,393),(1539,'Harry bought a sedan.',1,393),(1540,'Harry bought a sports car.',0,393),(1541,'They have to receive extensive training.',1,394),(1542,'They train lightly because of exhaustion.',0,394),(1543,'They skip extensive training.',0,394),(1544,'They dislike extensive training.',0,394),(1545,'It is just around the corner.',1,395),(1546,'It is coming to an end.',0,395),(1547,'It is about to finish.',0,395),(1548,'It is never too late.',0,395),(1549,'It mixed the shells up.',1,396),(1550,'It put in the shells.',0,396),(1551,'It fired the shells out.',0,396),(1552,'It threw away the shells.',0,396),(1553,'Their friends won\'t use the seats.',1,397),(1554,'Their friends are in the seats.',0,397),(1555,'The seats for their friends are cheap.',0,397),(1556,'The seats are being held for their friends.',0,397),(1557,'He is behind in his schoolwork.',1,398),(1558,'He is good at his schoolwork.',0,398),(1559,'He is the best student in class.',0,398),(1560,'He is sitting in the back row of the classroom.',0,398),(1561,'It is not working.',1,399),(1562,'It has broken into pieces.',0,399),(1563,'It is ready for sale.',0,399),(1564,'It was broadcast live.',0,399),(1565,'You and I are alike.',0,400),(1566,'I think I\'ve seen you before.',1,400),(1567,'I know you very well.',0,400),(1568,'You look like someone in my family.',0,400),(1569,'He is getting a shot.',1,401),(1570,'He is getting weighed.',0,401),(1571,'He is being examined.',0,401),(1572,'He is being rescued.',0,401),(1573,'Don\'t forget to write her a letter.',0,402),(1574,'Don\'t forget to see her tomorrow.',0,402),(1575,'Don\'t forget to send her a telegram.',0,402),(1576,'Don\'t forget to telephone her.',1,402),(1577,'cost',0,403),(1578,'length',0,403),(1579,'size',0,403),(1580,'temperature',1,403),(1581,'a steering device',0,404),(1582,'a source of power',1,404),(1583,'a job to do',0,404),(1584,'a way of stopping',0,404),(1585,'show her how to write',0,405),(1586,'give her something to do',0,405),(1587,'give her a pen to use',1,405),(1588,'show her around',0,405),(1589,'look for mistakes',1,406),(1590,'write it again',0,406),(1591,'begin a new job',0,406),(1592,'pay him for his work',0,406),(1593,'a way into the room',0,407),(1594,'a way out of the room',1,407),(1595,'a way to go though the window',0,407),(1596,'a way to lock the door',0,407),(1597,'in a fancy restaurant',0,408),(1598,'at a noodle stand',0,408),(1599,'in a fast food restaurant',1,408),(1600,'in a Chinese restaurant',0,408),(1601,'It was just cooked.',1,409),(1602,'It was a warm day.',0,409),(1603,'I already finished eating.',0,409),(1604,'That\'s my favorite meal.',0,409),(1605,'The girl looks nothing like her sister.',0,410),(1606,'The girl looks a lot like the woman\'s sister.',1,410),(1607,'The girl acts like she\'s the woman\'s sister.',0,410),(1608,'The girl is a little taller.',0,410),(1609,'The cars are too heavy.',0,411),(1610,'The road is quite wide.',0,411),(1611,'The cars cannot go very fast.',0,411),(1612,'The cars cannot pass each other.',1,411),(1613,'It\'s a good place for exercising.',0,412),(1614,'It\'s quiet there.',1,412),(1615,'It\'s noisy there.',0,412),(1616,'It\'s near their house.',0,412),(1617,'slowly',0,413),(1618,'fast',1,413),(1619,'well',0,413),(1620,'straight',0,413),(1621,'It will probably rain.',1,414),(1622,'It will not rain.',0,414),(1623,'It will rain for sure.',0,414),(1624,'It is impossible to rain this weekend.',0,414),(1625,'They moved to the city.',0,415),(1626,'They left the city.',0,415),(1627,'They did some sightseeing.',1,415),(1628,'The didn\'t like the city.',0,415),(1629,'It is very important.',0,416),(1630,'It is not woking very well.',1,416),(1631,'It is destroyed.',0,416),(1632,'It needs to be recharged.',0,416),(1633,'A disaster was avoided.',0,417),(1634,'A disaster was predicted.',0,417),(1635,'A disaster occurred.',1,417),(1636,'A disaster passed.',0,417),(1637,'We had breakfast.',0,418),(1638,'We exercised.',0,418),(1639,'We talked.',1,418),(1640,'We relaxed.',0,418),(1641,'She wants us to stop playing around.',0,419),(1642,'She wants us to wake up soon.',0,419),(1643,'She wants us not to ride the horses.',0,419),(1644,'She wants us to stop hanging around.',1,419),(1645,'the dock',1,420),(1646,'the raft',0,420),(1647,'the truck',0,420),(1648,'the swimming pool',0,420),(1649,'drink it ',0,421),(1650,'rub it on',1,421),(1651,'dry it out',0,421),(1652,'paint it',0,421),(1653,'before they learned English',0,422),(1654,'before 2005',0,422),(1655,'in 2005',1,422),(1656,'to attend flight school',0,422),(1657,'a weapon',0,423),(1658,'a signal',0,423),(1659,'an award',0,423),(1660,'an assignment',1,423),(1661,'David drilled it.',1,424),(1662,'David sewed it.',0,424),(1663,'David wrote it.',0,424),(1664,'David bought it.',0,424),(1665,'He wants to wait before going to the beach.',0,425),(1666,'He is excited about going to the beach.',1,425),(1667,'He doesn\'t care for being outdoors.',0,425),(1668,'He has to wait on the beach.',0,425),(1669,'once a day',0,426),(1670,'two times a day',1,426),(1671,'once each two days',0,426),(1672,'three times a day',0,426),(1673,'It rains very often.',0,427),(1674,'It remains the same.',0,427),(1675,'It is always hot.',0,427),(1676,'It changes often.',1,427),(1677,'Yes, they use traffic lights.',1,428),(1678,'Yes, they use helicopters.',0,428),(1679,'Yes, they use radios.',0,428),(1680,'Yes, they use police cars.',0,428),(1681,'handle the books',0,429),(1682,'test the magazines',0,429),(1683,'have a quick look at them',1,429),(1684,'buy a few of them',0,429),(1685,'I answer James\' call.',0,430),(1686,'I fought with James.',0,430),(1687,'I met James',1,430),(1688,'I scolded James.',0,430),(1689,'Yes, she is happy and carefree.',1,431),(1690,'Yes, she is English.',0,431),(1691,'Nom she is carefree and happy.',0,431),(1692,'No, she is saleswoman.',0,431),(1693,'to indicate atmospheric pressure',0,432),(1694,'to record air speed',0,432),(1695,'to measure precipitation',0,432),(1696,'to regulate temperature',1,432),(1697,'because the car is rough',0,433),(1698,'because the car is hot and dry',0,433),(1699,'because the car stops',0,433),(1700,'because the car slides easily',1,433),(1701,'buy a newspaper',0,434),(1702,'take a bus',1,434),(1703,'see a doctor',0,434),(1704,'go to bed early',0,434),(1705,'She thinks she will fail the course.',0,435),(1706,'She thinks she will succeed.',1,435),(1707,'She wants to drop the course.',0,435),(1708,'She wants to take it over.',0,435),(1709,'Yes, they will provide one for us.',1,436),(1710,'Yes, they will sell one to us.',0,436),(1711,'Yes, they will want one from us.',0,436),(1712,'Yes, they will change one.',0,436),(1713,'He can\'t see very well.',0,437),(1714,'He is mute.',0,437),(1715,'It is hard to listen to him singing.',0,437),(1716,'There is a problem with his hearing.',1,437),(1717,'He is worse than David.',0,438),(1718,'He is more handsome than David.',0,438),(1719,'He is much better than David.',1,438),(1720,'He is a better friend than David.',0,438),(1721,'He gave them a briefing.',0,439),(1722,'He organized their vehicles.',0,439),(1723,'He gave them a big hand.',0,439),(1724,'He watched them march.',1,439),(1725,'You will very likely feel cold.',0,440),(1726,'You will very likely feel warm.',0,440),(1727,'You will very likely get sick.',1,440),(1728,'You will very likely buy a coat.',0,440),(1729,'I don\'t like to read.',0,441),(1730,'I like to read all the time.',0,441),(1731,'I like to read about cars.',0,441),(1732,'I like to read when I am free.',1,441),(1733,'There was an ambulance behind John.',1,442),(1734,'There was a taxi behind John.',0,442),(1735,'There was music behind John.',0,442),(1736,'There was a bicycle behind John.',0,442),(1737,'The weather is bad.',0,443),(1738,'The work is too hard.',0,443),(1739,'The road is rough.',1,443),(1740,'The picture is all right.',0,443),(1741,'He took it away.',1,444),(1742,'He bought it.',0,444),(1743,'He took off its cover.',0,444),(1744,'He read it.',0,444),(1745,'The solution was unknown.',0,445),(1746,'The solution was apparent.',1,445),(1747,'The solution was dangerous.',0,445),(1748,'The solution was essential.',0,445),(1749,'It must be flat.',1,446),(1750,'It must be long.',0,446),(1751,'It must be square.',0,446),(1752,'It must be large.',0,446),(1753,'We confused the enemy.',0,447),(1754,'We met the enemy.',1,447),(1755,'We defeated the enemy.',0,447),(1756,'We avoided the enemy.',0,447),(1757,'Mary will compete with the female candidate.',0,448),(1758,'Mary will choose the female candidate.',1,448),(1759,'Mary doesn\'t like the female candidate.',0,448),(1760,'Mary will work for the female candidate.',0,448),(1761,'It can\'t fit.',0,449),(1762,'He doesn\'t own it.',1,449),(1763,'It was too heavy for him.',0,449),(1764,'He doesn\'t like it.',0,449),(1765,'He didn\'t see the passengers.',0,450),(1766,'He didn\'t like the noise it made.',0,450),(1767,'He didn\'t see the plane landing.',1,450),(1768,'He didn\'t know the arrival time.',0,450),(1769,'Peter can\'t understand them.',0,451),(1770,'Peter can\'t stand up to them.',0,451),(1771,'Peter will make them stand up.',0,451),(1772,'Peter can\'t tolerate them.',1,451),(1773,'They\'re becoming longer.',0,452),(1774,'They\'re becoming more interesting.',0,452),(1775,'They\'re becoming more rigid.',1,452),(1776,'They\'re becoming more important.',0,452),(1777,'They saved him.',1,453),(1778,'They surrounded him.',0,453),(1779,'They located him.',0,453),(1780,'They buried him.',0,453),(1781,'She doesn\'t know the truth.',0,454),(1782,'She wants to tell the truth.',0,454),(1783,'She is willing to tell the truth.',0,454),(1784,'She doesn\'t want to tell the truth.',1,454),(1785,'They neglected his warning.',0,455),(1786,'They liked his warning.',0,455),(1787,'They forgot his warning.',0,455),(1788,'They remembered his warning.',1,455),(1789,'this kind of watch is very expensive.',0,456),(1790,'This kind of watch breaks easily.',0,456),(1791,'You cannot buy this kind of watch anymore.',1,456),(1792,'You will not like this kind of watch.',0,456),(1793,'It is good for insulation.',0,457),(1794,'It burns easily.',1,457),(1795,'It is easy to lose.',0,457),(1796,'It is very expensive.',0,457),(1797,'He dislikes them very much.',0,458),(1798,'He makes them angry.',0,458),(1799,'He has great trouble working with them.',0,458),(1800,'He has a high regard for them.',1,458),(1801,'I was sick last night.',1,459),(1802,'I finished last night.',0,459),(1803,'I went running last night.',0,459),(1804,'I was in a rush last night.',0,459),(1805,'I don’t want to see your new home.',0,460),(1806,'I don’t  want anything in your new home.',0,460),(1807,'I really want to see your new home.',1,460),(1808,'I would give anything to have a new home.',0,460),(1809,'The damage wasn’t necessary.',0,461),(1810,'There was only a little damage.',1,461),(1811,'No damage was detected.',0,461),(1812,'There was major damage.',0,461),(1813,'He has enough time',1,462),(1814,'He hasn’t enough time.',0,462),(1815,'He has extra time.',0,462),(1816,'He has limited time.',0,462),(1817,'She wanted to know the cost.',0,463),(1818,'She wanted to know the means.',1,463),(1819,'She wanted to know the answer.',0,463),(1820,'She wanted to know the reason.',0,463),(1821,'a house',0,464),(1822,'a trip',0,464),(1823,'a car',1,464),(1824,'a friend',0,464),(1825,'The man should buy new clothing.',0,465),(1826,'The man has poor taste in clothing.',0,465),(1827,'The man should try to find his belt.',0,465),(1828,'The man should lose weight.',1,465),(1829,'It was expanded five months ago.',0,466),(1830,'It was started five months ago.',1,466),(1831,'It was moved five months ago.',0,466),(1832,'It was closed five months ago.',0,466),(1833,'It matched her furniture.',0,467),(1834,'It was a bargain.',0,467),(1835,'It was nice to site in.',1,467),(1836,'It was a pretty color.',0,467),(1837,'He paid for it ahead of time.',1,468),(1838,'He paid for it little by little.',0,468),(1839,'He paid for it with a loan.',0,468),(1840,'He paid for it with a check.',0,468),(1841,'to work',0,469),(1842,'on a trip',1,469),(1843,'to school',0,469),(1844,'on a picnic',0,469),(1845,'He wanted to go to bed.',0,470),(1846,'He wanted to get cleaned up.',0,470),(1847,'He wanted to drink something cold.',0,470),(1848,'He wanted to get somewhere fast.',1,470),(1849,'His house was pretty.',0,471),(1850,'His house was old.',0,471),(1851,'His house was big.',1,471),(1852,'His house was modern.',0,471),(1853,'She was studying how to build things.',1,472),(1854,'She was studying how to write stories.',0,472),(1855,'She was studying how to teach children.',0,472),(1856,'She was studying how to fix teeth.',0,472),(1857,'descending',0,473),(1858,'shacking',1,473),(1859,'rolling',0,473),(1860,'climbing',0,473),(1861,'He is careless.',0,474),(1862,'He is at fault.',0,474),(1863,'He is lazy.',0,474),(1864,'He likes to criticize.',1,474),(1865,'play ball',1,475),(1866,'eat supper',0,475),(1867,'work',0,475),(1868,'sleep',0,475),(1869,'putting off the meeting',1,476),(1870,'canceling the meeting',0,476),(1871,'attending the meeting',0,476),(1872,'holding a meeting',0,476),(1873,'took some medicine',0,477),(1874,'ran away',0,477),(1875,'got a ticket',0,477),(1876,'said he was sorry',1,477),(1877,'in a trailer home',0,478),(1878,'far from the base',0,478),(1879,'near from the base',1,478),(1880,'on the other side of town',0,478),(1881,'give them a briefing',0,479),(1882,'see how the class was conduct',0,479),(1883,'teach the class',1,479),(1884,'interview the student',0,479),(1885,'the speed',1,480),(1886,'the angle',0,480),(1887,'the diameter',0,480),(1888,'the circumference',0,480),(1889,'decorating a house',0,481),(1890,'selling a house',0,481),(1891,'building a house',1,481),(1892,'tearing down a house',0,481),(1893,'to be net',0,482),(1894,'to be fair',0,482),(1895,'to be truthful',0,482),(1896,'to be on time',1,482),(1897,'He threw them away.',1,483),(1898,'He published them.',0,483),(1899,'He put them on.',0,483),(1900,'He kicked them off.',0,483),(1901,'go up and down',1,484),(1902,'stay the same',0,484),(1903,'rise steadily',0,484),(1904,'fall steadily',0,484),(1905,'a sharp mind',0,485),(1906,'explosives',0,485),(1907,'the desire to succeed',1,485),(1908,'a prolonged illness',0,485),(1909,'come and pick him up',0,486),(1910,'cook some food for him',0,486),(1911,'buy some food',1,486),(1912,'order some food at home',0,486),(1913,'to write to the doctor',0,487),(1914,'to call the doctor',0,487),(1915,'to find out about the doctor',0,487),(1916,'to go see the doctor',1,487),(1917,'She allowed John to take the car.',1,488),(1918,'She warned John not to take the car.',0,488),(1919,'She ordered John to drive the car.',0,488),(1920,'She gave John a ride in the car.',0,488),(1921,'the time of the meeting',1,489),(1922,'how to repair the radio',0,489),(1923,'where Main Street is',0,489),(1924,'what to buy',0,489),(1925,'She’ll ask for the money.',0,490),(1926,'She’ll complain.',0,490),(1927,'She’ll stop working so hard.',0,490),(1928,'She’ll leave her job.',1,490),(1929,'after a while',0,491),(1930,'within minutes',1,491),(1931,'after a week',0,491),(1932,'in a day',0,491),(1933,'We agree with them.',0,492),(1934,'We employ them.',0,492),(1935,'We unite them.',0,492),(1936,'We contact them.',1,492),(1937,'act like their parents',1,493),(1938,'help their parents',0,493),(1939,'admire the parents',0,493),(1940,'live with their parents',0,493),(1941,'She turned him down.',0,494),(1942,'She got lost.',0,494),(1943,'She didn’t show up.',1,494),(1944,'She was late.',0,494),(1945,'He found that his work was hard.',0,495),(1946,'He started doing his work.',0,495),(1947,'He started looking for work.',0,495),(1948,'He made sure his work was right.',1,495),(1949,'He was not sure of the scores.',0,496),(1950,'He was unhappy with the scores.',1,496),(1951,'He was studying the scores.',0,496),(1952,'He was evaluating the scores.',0,496),(1953,'There were no results.',0,497),(1954,'There were no expectations.',0,497),(1955,'The results were not what Major Wilson expected.',1,497),(1956,'The results were what Major Wilson expected.',0,497),(1957,'I knew I would pass the exam.',0,498),(1958,'I didn’t make it.',0,498),(1959,'I didn’t think I would pass the exam.',1,498),(1960,'I’m not surprised by the results.',0,498),(1961,'They were praised.',0,499),(1962,'They were congratulated.',0,499),(1963,'They were kicked out.',1,499),(1964,'They graduated.',0,499),(1965,'They repelled it.',1,500),(1966,'They prevented it.',0,500),(1967,'They missed it.',0,500),(1968,'They started it.',0,500),(1969,'There was a traffic jam this morning.',1,501),(1970,'There was a car accident this morning.',0,501),(1971,'Cars were going at a high speed.',0,501),(1972,'The traffic light was out of order.',0,501),(1973,'The song makes her sad.',0,502),(1974,'The song is about love.',0,502),(1975,'She knows the singer very well.',0,502),(1976,'She has memorized the song.',1,502),(1977,'We must feed them.',0,503),(1978,'We must hit them.',0,503),(1979,'We must treat them.',0,503),(1980,'We must locate them.',1,503),(1981,'The washing machine is not working properly.',1,504),(1982,'The machine is user-friendly.',0,504),(1983,'The price of this washing machine is going up.',0,504),(1984,'The washing machine is now for sale.',0,504),(1985,'He won the lottery.',0,505),(1986,'He always thinks of the lottery.',1,505),(1987,'He has never bought any lottery tickets.',0,505),(1988,'Winning the lottery made him rich.',0,505),(1989,'I hailed a taxi.',0,506),(1990,'I was diving taxi.',0,506),(1991,'The taxi almost hit me.',1,506),(1992,'I was waiting for a taxi.',0,506),(1993,'A schedule was destroyed.',0,507),(1994,'A schedule was lost.',0,507),(1995,'A schedule was established.',1,507),(1996,'A schedule was found.',0,507),(1997,'James is confident about himself.',0,508),(1998,'James is proud of them.',0,508),(1999,'James is not true to himself.',0,508),(2000,'James lacks self-confidence.',1,508),(2001,'They had a normal day.',0,509),(2002,'They worked hard during the emergency.',1,509),(2003,'They had a practice drill.',0,509),(2004,'They had a false alarm.',0,509),(2005,'Don\'t let her tell.',0,510),(2006,'Don\'t tell her.',1,510),(2007,'Don\'t talk about her.',0,510),(2008,'Don\'t forget to tell her.',0,510),(2009,'It is said that he is having an affair.',1,511),(2010,'We believe he is having an affair.',0,511),(2011,'The rumor is not fair.',0,511),(2012,'We\'ve never heard the rumor.',0,511),(2013,'It was raining.',0,512),(2014,'The visibility was poor.',1,512),(2015,'It was getting dark.',0,512),(2016,'There was a lot of snow.',0,512),(2017,'She received a surprise.',0,513),(2018,'She became very happy.',0,513),(2019,'She got a good deal.',0,513),(2020,'She felt unsteady.',1,513),(2021,'That medicine tasted bitter.',0,514),(2022,'That medicine worked miracles.',1,514),(2023,'The medicine tasted like wine.',0,514),(2024,'The medicine was prescribed carefully.',0,514),(2025,'They deserted their children.',0,515),(2026,'They moved because of their children.',1,515),(2027,'Their children didn\'t move with them.',0,515),(2028,'They sent their children to Manhattan.',0,515),(2029,'Harry bought a sedan.',1,516),(2030,'Harry bought a sports car.',0,516),(2031,'Harry wanted a sedan.',0,516),(2032,'Harry didn\'t want a sports car.',0,516),(2033,'They skip extensive training.',0,517),(2034,'They dislike extensive training.',0,517),(2035,'They have to receive extensive training.',1,517),(2036,'They train lightly because of exhaustion.',0,517),(2037,'You should have called me.',0,518),(2038,'You are supposed to call me after meeting me.',0,518),(2039,'Let me know if you cannot come.',1,518),(2040,'Call me when you arrive.',0,518),(2041,'It put in the shells.',0,519),(2042,'It mixed the shells.',0,519),(2043,'It threw out the shells.',0,519),(2044,'It fired the shells.',1,519),(2045,'The table is being held for their friends.',1,520),(2046,'The table for their friends is cheap.',0,520),(2047,'Their friends are in the seats.',0,520),(2048,'Their friends won\'t use the seats.',0,520),(2049,'It is good to hear you say that.',0,521),(2050,'It\'s getting chilly.',0,521),(2051,'It\'s perfect for cooking.',0,521),(2052,'It feels very hot.',1,521),(2053,'Don\'t forget to write her a letter.',0,522),(2054,'Don\'t forget to see her tomorrow.',0,522),(2055,'Don\'t forget to send her an e-mail.',0,522),(2056,'Don\'t forget to telephone her.',1,522),(2057,'turn right at the next corner',0,523),(2058,'give the woman a ride',0,523),(2059,'look for a taxi',1,523),(2060,'send a taxi immediately',0,523),(2061,'She doesn\'t like the man.',0,524),(2062,'She doesn\'t know how to paint.',0,524),(2063,'It\'s in the morning.',0,524),(2064,'She has an appointment to meet someone.',1,524),(2065,'He received a present at the meeting.',0,525),(2066,'He enjoyed the meeting.',0,525),(2067,'He attended the meeting.',1,525),(2068,'He was the speaker.',0,525),(2069,'Richard has been standing in the wrong place.',0,526),(2070,'Richard hasn\'t heard it correctly.',0,526),(2071,'Richard doesn\'t know what it means.',1,526),(2072,'Richard means everything he says.',0,526),(2073,'She should treat him to dinner.',0,527),(2074,'It\'s very easy.',0,527),(2075,'He\'s hungry.',0,527),(2076,'It\'s too difficult for him.',1,527),(2077,'He doesn\'t like his new apartment.',0,528),(2078,'Someone is standing behind him.',0,528),(2079,'His back aches.',1,528),(2080,'Someone is trying to kill him.',0,528),(2081,'Colonel Roberts will not give a speech.',0,529),(2082,'Colonel Roberts will ignore the speaker.',0,529),(2083,'Colonel Roberts will be the main speaker.',1,529),(2084,'Colonel Roberts will introduce the speaker.',0,529),(2085,'a chef',0,530),(2086,'a customer',0,530),(2087,'a waitress',1,530),(2088,'a janitor',0,530),(2089,'one',1,531),(2090,'a few',0,531),(2091,'two',0,531),(2092,'none',0,531),(2093,'stop working',0,532),(2094,'do the work better',0,532),(2095,'continue to work',1,532),(2096,'do the work over again',0,532),(2101,'during',0,537),(2102,'since',1,537),(2103,'between',0,537),(2104,'for',0,537);
/*!40000 ALTER TABLE `alcpt_choice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_department`
--

DROP TABLE IF EXISTS `alcpt_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_department` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_department`
--

LOCK TABLES `alcpt_department` WRITE;
/*!40000 ALTER TABLE `alcpt_department` DISABLE KEYS */;
INSERT INTO `alcpt_department` VALUES (2,'法律系'),(3,'財管系'),(1,'資管系'),(4,'運籌系');
/*!40000 ALTER TABLE `alcpt_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_exam`
--

DROP TABLE IF EXISTS `alcpt_exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_exam` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `exam_type` smallint unsigned NOT NULL,
  `use_freq` int NOT NULL,
  `modified_times` int NOT NULL,
  `average_score` double NOT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `created_time` datetime(6) NOT NULL,
  `duration` smallint unsigned NOT NULL,
  `finish_time` datetime(6) DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `created_by_id` int NOT NULL,
  `testpaper_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `alcpt_exam_created_by_id_3e8088e6_fk_alcpt_user_id` (`created_by_id`),
  KEY `alcpt_exam_testpaper_id_6048fb92_fk_alcpt_testpaper_id` (`testpaper_id`),
  CONSTRAINT `alcpt_exam_created_by_id_3e8088e6_fk_alcpt_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `alcpt_user` (`id`),
  CONSTRAINT `alcpt_exam_testpaper_id_6048fb92_fk_alcpt_testpaper_id` FOREIGN KEY (`testpaper_id`) REFERENCES `alcpt_testpaper` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_exam`
--

LOCK TABLES `alcpt_exam` WRITE;
/*!40000 ALTER TABLE `alcpt_exam` DISABLE KEYS */;
/*!40000 ALTER TABLE `alcpt_exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_exam_testeelist`
--

DROP TABLE IF EXISTS `alcpt_exam_testeelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_exam_testeelist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `exam_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `alcpt_exam_testeeList_exam_id_user_id_3c6f3f1f_uniq` (`exam_id`,`user_id`),
  KEY `alcpt_exam_testeeList_user_id_465cf978_fk_alcpt_user_id` (`user_id`),
  CONSTRAINT `alcpt_exam_testeeList_exam_id_3b6c9639_fk_alcpt_exam_id` FOREIGN KEY (`exam_id`) REFERENCES `alcpt_exam` (`id`),
  CONSTRAINT `alcpt_exam_testeeList_user_id_465cf978_fk_alcpt_user_id` FOREIGN KEY (`user_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=225 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_exam_testeelist`
--

LOCK TABLES `alcpt_exam_testeelist` WRITE;
/*!40000 ALTER TABLE `alcpt_exam_testeelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `alcpt_exam_testeelist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_group`
--

DROP TABLE IF EXISTS `alcpt_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `created_by_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `alcpt_group_created_by_id_f15e6b32_fk_alcpt_user_id` (`created_by_id`),
  CONSTRAINT `alcpt_group_created_by_id_f15e6b32_fk_alcpt_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_group`
--

LOCK TABLES `alcpt_group` WRITE;
/*!40000 ALTER TABLE `alcpt_group` DISABLE KEYS */;
INSERT INTO `alcpt_group` VALUES (1,'資管系','2020-02-11 13:39:37.002878','2020-02-11 13:39:37.001069',1),(2,'109年班','2020-02-24 23:11:28.996531','2020-02-24 23:11:28.984803',1),(3,'資管系109年班','2020-03-19 01:00:30.974127','2020-03-19 01:00:30.972082',1),(4,'資管系110年班','2020-03-19 00:59:41.772846','2020-03-19 00:59:41.768574',1);
/*!40000 ALTER TABLE `alcpt_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_group_member`
--

DROP TABLE IF EXISTS `alcpt_group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_group_member` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `alcpt_group_member_group_id_user_id_5bfb75ae_uniq` (`group_id`,`user_id`),
  KEY `alcpt_group_member_user_id_6268bc82_fk_alcpt_user_id` (`user_id`),
  CONSTRAINT `alcpt_group_member_group_id_b62cbe32_fk_alcpt_group_id` FOREIGN KEY (`group_id`) REFERENCES `alcpt_group` (`id`),
  CONSTRAINT `alcpt_group_member_user_id_6268bc82_fk_alcpt_user_id` FOREIGN KEY (`user_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_group_member`
--

LOCK TABLES `alcpt_group_member` WRITE;
/*!40000 ALTER TABLE `alcpt_group_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `alcpt_group_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_proclamation`
--

DROP TABLE IF EXISTS `alcpt_proclamation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_proclamation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` longtext NOT NULL,
  `text` longtext NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `created_by_id` int DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL,
  `recipient_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `alcpt_proclamation_created_by_id_02e079a0_fk_alcpt_user_id` (`created_by_id`),
  KEY `alcpt_proclamation_recipient_id_dc91a846_fk_alcpt_user_id` (`recipient_id`),
  CONSTRAINT `alcpt_proclamation_created_by_id_02e079a0_fk_alcpt_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `alcpt_user` (`id`),
  CONSTRAINT `alcpt_proclamation_recipient_id_dc91a846_fk_alcpt_user_id` FOREIGN KEY (`recipient_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_proclamation`
--

LOCK TABLES `alcpt_proclamation` WRITE;
/*!40000 ALTER TABLE `alcpt_proclamation` DISABLE KEYS */;
INSERT INTO `alcpt_proclamation` VALUES (1,'ProjectDemo','You will start ProjectDemo\nStart Time: 2020-04-14 10:50\nDuration: 1 minutes.\nPlease notice the time, do not forget it.',0,'2020-04-14 10:47:27.247086',1,0,2),(2,'ProjectDemo','You will start ProjectDemo\nStart Time: 2020-04-14 10:50\nDuration: 1 minutes.\nPlease notice the time, do not forget it.',0,'2020-04-14 10:47:27.247122',1,1,4),(64,'Email Verification','Please check out your email to complete the email verification.\n\nThank you for your cooperation.',0,'2020-04-21 23:07:07.330005',1,0,1);
/*!40000 ALTER TABLE `alcpt_proclamation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_question`
--

DROP TABLE IF EXISTS `alcpt_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `q_type` smallint unsigned NOT NULL,
  `q_file` longtext,
  `q_content` longtext,
  `difficulty` smallint unsigned NOT NULL,
  `issued_freq` int NOT NULL,
  `correct_freq` int NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_valid` tinyint(1) NOT NULL,
  `state` smallint NOT NULL,
  `created_by_id` int NOT NULL,
  `last_updated_by_id` int DEFAULT NULL,
  `faulted_reason` varchar(255) DEFAULT NULL,
  `q_correct_time` int NOT NULL,
  `q_time` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alcpt_question_created_by_id_2c7db757_fk_alcpt_user_id` (`created_by_id`),
  KEY `alcpt_question_last_updated_by_id_7e7caa2c_fk_alcpt_user_id` (`last_updated_by_id`),
  CONSTRAINT `alcpt_question_created_by_id_2c7db757_fk_alcpt_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `alcpt_user` (`id`),
  CONSTRAINT `alcpt_question_last_updated_by_id_7e7caa2c_fk_alcpt_user_id` FOREIGN KEY (`last_updated_by_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=539 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_question`
--

LOCK TABLES `alcpt_question` WRITE;
/*!40000 ALTER TABLE `alcpt_question` DISABLE KEYS */;
INSERT INTO `alcpt_question` VALUES (1,3,NULL,'He is ____ in the military service.',1,9,0,'2019-05-19 16:18:54.592000','2020-03-17 00:31:53.041229',0,1,1,1,NULL,0,0),(2,4,NULL,'What kind of missile that distance is from 1000 km to 3000km?',1,4,0,'2019-12-13 12:34:07.004452','2020-02-20 11:31:36.466127',0,1,1,1,'',0,0),(3,4,NULL,'Which of the following options matches accuracy, durability, and fitness?',1,2,0,'2019-12-14 06:48:42.496852','2020-02-24 11:14:44.887823',0,1,1,1,'',0,0),(5,3,NULL,'If he  ____ his sweater, he wouldn’t have caught a cold.',1,11,0,'2019-12-17 12:03:07.417097','2020-03-16 22:14:39.204742',0,1,1,1,'',0,0),(6,4,NULL,'\"Victory is still measured by foot.\" is a common saying in the Indian Army.\r\nThis means that, while many types of units fight in a war, it is the __________ who ultimately win or lose wars.',1,4,0,'2019-12-17 14:22:04.373493','2020-02-24 11:14:44.903003',0,1,1,1,'',0,0),(23,4,NULL,'The rule of ______ in UO are often very strict in order to minimize collateral damage.',1,0,0,'2019-12-18 13:19:04.544839','2020-01-05 00:04:41.045340',0,1,1,1,'',0,0),(28,1,'question_files/question_28.mp3',NULL,1,3,0,'2019-12-18 16:30:52.424219','2020-04-05 22:44:21.445525',0,1,1,1,'鄧紫棋太正',0,0),(29,3,NULL,'I can\'t go with you ______ I\'m busy.',1,5,0,'2019-12-18 12:24:40.346544','2020-03-16 22:19:34.108504',0,1,1,1,'',0,0),(30,3,'','They have been waiting for me ______ 5 o\'clock.',1,4,0,'2019-12-18 12:26:59.413803','2020-04-12 23:42:10.986821',0,5,1,1,'',0,0),(31,3,NULL,'Most people ______ to red newspapers.',1,6,0,'2019-12-18 12:29:04.000232','2020-03-16 22:19:34.102614',0,1,1,1,'',0,0),(32,3,NULL,'John would have called the police if he ____ the accident.',1,7,0,'2019-12-18 12:41:20.098003','2020-03-16 22:19:34.081787',0,1,1,1,'',0,0),(33,3,NULL,'He finished _____ his tape.',1,8,0,'2019-12-18 12:44:37.305665','2020-03-16 22:19:34.091520',0,1,1,1,'',0,0),(34,3,NULL,'He left the office early ____ he could do some shopping.',1,6,0,'2019-12-18 12:46:07.538020','2020-03-16 22:19:34.117850',0,1,1,1,'',0,0),(35,3,NULL,'______ you mind closing the window?',1,7,0,'2019-12-18 12:46:52.892223','2020-03-16 22:19:34.113342',0,1,1,1,'',0,0),(36,3,NULL,'You ______ review this lesson before you take the test.',1,5,0,'2019-12-18 12:50:56.110807','2020-03-17 00:31:53.039062',0,1,1,1,'',0,0),(37,3,NULL,'He has been studying English _____ four years.',1,8,0,'2019-12-18 12:52:35.977609','2020-03-16 22:19:34.105947',0,1,1,1,'',0,0),(40,3,NULL,'The visibility was poor yesterday. I _______.',1,8,0,'2019-12-18 13:09:06.167496','2020-02-24 11:14:44.878850',0,1,1,1,'',0,0),(41,3,NULL,'Howard finished ________ because he was the fastest.',1,8,0,'2019-12-18 13:11:47.679947','2020-03-16 22:19:34.099926',0,1,1,1,'',0,0),(42,3,NULL,'Get the red book. _______ is on the shelf.',1,8,0,'2019-12-18 13:14:11.897504','2020-03-17 00:31:53.044835',0,1,1,1,'',0,0),(43,3,NULL,'I am going _______ to buy a new car.',1,4,0,'2019-12-18 13:15:43.150014','2020-03-16 22:19:34.110542',0,1,1,1,'',0,0),(44,3,NULL,'The weather is ______ today than it was last night.',1,6,0,'2019-12-18 13:16:38.833223','2020-02-16 22:31:39.420014',0,1,1,1,'',0,0),(45,3,NULL,'In the U.S., conversation is _______ proper during meals.',1,5,0,'2019-12-18 13:34:36.708340','2020-03-17 00:31:53.036478',0,1,1,1,'',0,0),(46,3,NULL,'______ spears for weapons, the men hunted wild animals.',1,5,0,'2019-12-18 13:38:41.449990','2020-03-17 00:31:53.043134',0,1,1,1,'',0,0),(47,3,NULL,'Aircraft pilots communicate ______ control towers.',1,9,0,'2019-12-18 13:39:49.363301','2020-03-16 02:38:05.207422',0,1,1,1,'',0,0),(48,3,'','Did the students ______ a lot of homework last night?',1,8,0,'2019-12-18 13:40:48.026545','2020-04-14 11:19:43.488619',0,1,1,1,'',0,0),(49,4,NULL,'The ______ is a common military firearm. Soldiers fire it from the shoulder. It has a built-in sight.',1,1,0,'2019-12-20 06:58:58.709023','2020-01-05 00:04:41.057392',0,1,1,1,'',0,0),(50,4,NULL,'In fact, ________ have great symbolic meaning. When a unit is defeated, the commanding officer often gives his sidearm to the enemy commander.',1,2,0,'2019-12-20 07:02:22.291929','2020-02-16 22:13:51.768638',0,1,1,1,'',0,0),(51,4,NULL,'Small mortars are _______ and used by infantry units.',1,1,0,'2019-12-20 07:20:14.774868','2020-01-05 21:24:59.105996',0,1,1,1,'',0,0),(52,5,NULL,'What does the passage say about tanks?',1,9,0,'2019-12-20 07:24:04.722459','2020-02-28 11:37:58.376740',0,1,1,1,'',0,0),(53,4,NULL,'Joe could not find a job that he really wanted. Therefore, he felt very _______.',1,0,0,'2019-12-21 19:15:16.742985','2020-02-16 22:13:51.775885',0,1,1,1,'',0,0),(54,4,NULL,'I need someone to help me solve this _______ math problem. It is not easy for me to understand.',1,0,0,'2019-12-21 19:17:11.091771','2020-02-16 22:13:51.734820',0,1,1,1,'',0,0),(55,4,NULL,'When you are depressed, try to replace all your _______ thoughts with positive ones.',1,1,0,'2019-12-21 19:18:18.603990','2019-12-22 06:04:24.235730',0,1,1,1,'',0,0),(56,4,NULL,'The letter _______, so you should reply to it as soon as possible.',1,0,0,'2019-12-21 19:20:47.518982','2020-02-16 22:29:44.658914',0,1,1,1,'',0,0),(57,4,NULL,'The old building has been discovered to be _______. It is vacant precisely for this reason.',1,2,0,'2019-12-21 19:22:11.623838','2020-02-20 11:31:36.457369',0,1,1,1,'',0,0),(58,4,NULL,'Scientists have _______ that the greenhouse effect caused global warming.',1,2,0,'2019-12-21 19:24:19.309120','2020-02-16 22:13:51.726872',0,1,1,1,'',0,0),(59,4,NULL,'Bobby cared a lot about his _____ at home and asked his parents not to go through his things without his permission.',1,3,0,'2019-12-21 19:32:03.154157','2020-03-16 02:38:05.230902',0,1,1,1,'',0,0),(60,3,NULL,'The new manager is a real gentleman. He is  kind and humble, totally different from the former manager,\r\nwho was _____ and bossy.',1,8,0,'2019-12-21 19:33:47.066982','2020-03-16 02:38:05.210184',0,1,1,1,'',0,0),(61,4,NULL,'The weather bureau _____ that the typhoon would bring strong winds and heavy rains, and warned everyone of the possible danger.',1,1,0,'2019-12-21 19:35:38.516608','2020-01-05 21:24:59.107983',0,1,1,1,'',0,0),(62,4,NULL,'Different airlines have different _____ for carry-on luggage, but many international airlines limit a carry-on piece to 7 kilograms.',1,1,0,'2019-12-22 03:06:55.597684','2020-01-05 00:04:41.041391',0,1,1,1,'',0,0),(63,4,NULL,'To reach the goal of making her company a market leader, Michelle _______ a plan to open ten new stores around the country this year.',1,0,0,'2019-12-24 12:54:51.363684','2020-02-16 22:29:44.667440',0,1,1,1,'',0,0),(64,4,NULL,'Silence in some way is as _____ as speech. It can be used to show, for example, disagreement or lack\r\nof interest.',1,1,0,'2019-12-25 08:09:16.845920','2020-02-24 11:14:44.885972',0,1,1,1,'',0,0),(65,4,NULL,'This TV program is designed for children, _____ for those under five. It contains no violence or strong language.',1,1,0,'2019-12-25 08:10:20.484738','2019-12-31 07:36:05.334955',0,1,1,1,'',0,0),(66,4,NULL,'Tommy, please put away the toys in the box, or you might _____ on them and hurt yourself.\r\n',1,2,0,'2019-12-25 08:11:09.275821','2020-02-16 22:31:39.445495',0,1,1,1,'',0,0),(67,4,NULL,'The _____ costume party, held every September, is one of the biggest events of the school year.',1,0,0,'2019-12-25 08:12:06.799790','2020-02-16 22:13:51.764830',0,1,1,1,'',0,0),(68,4,NULL,'In a job interview, attitude and personality are usually important _____ that influence the decision of the interviewers.',1,4,0,'2019-12-25 08:13:02.205312','2020-02-16 22:29:44.679837',0,1,1,1,'',0,0),(69,4,NULL,'The snow-capped mountain is described so _____ in the book that the scene seems to come alive in\r\nfront of the reader’s eyes.',1,2,0,'2019-12-25 08:14:17.086109','2020-03-16 02:38:05.233540',0,1,1,1,'',0,0),(70,4,NULL,'. Surrounded by flowers blooming and birds _____ merrily, the Wangs had a good time hiking in the\r\nnational park.\r\n',1,2,0,'2019-12-25 08:15:19.386222','2020-03-17 00:31:53.051285',0,1,1,1,'',0,0),(71,4,NULL,'It is essential for us to maintain constant _____ with our friends to ensure that we have someone to talk to in times of need.',1,1,0,'2019-12-25 08:16:08.286657','2020-02-16 22:13:51.738979',0,1,1,1,'',0,0),(72,4,NULL,'The young generation in this country has shown less interest in factory work and other _____ labor jobs, such as house construction and fruit picking.',1,2,0,'2019-12-25 08:17:04.767922','2020-02-16 22:31:39.458588',0,1,1,1,'',0,0),(73,4,NULL,'Mangoes are a _____ fruit here in Taiwan; most of them reach their peak of sweetness in July.',1,3,0,'2019-12-25 08:18:41.941366','2019-12-31 06:34:15.717730',0,1,1,1,'',0,0),(74,4,NULL,'Writing term papers and giving oral reports are typical course _____ for college students.',1,0,0,'2019-12-25 08:21:44.015877','2019-12-29 07:00:09.861395',0,1,1,1,'',0,0),(75,4,NULL,'If we work hard to _____ our dreams when we are young, we will not feel that we missed out on\r\nsomething when we get old.',1,3,0,'2019-12-25 08:23:09.645550','2020-02-16 22:13:51.721653',0,1,1,1,'',0,0),(76,4,NULL,'Few people will trust you if you continue making _____ promises and never make efforts to keep them.',1,1,0,'2019-12-25 08:24:12.164544','2020-02-16 22:13:51.743378',0,1,1,1,'',0,0),(77,4,NULL,'Becky _____ her ankle while she was playing tennis last week. Now it still hurts badly.',1,0,0,'2019-12-25 08:25:01.108884','2019-12-29 08:03:38.745798',0,1,1,1,'',0,0),(78,4,NULL,'Research shows that men and women usually think differently. For example, they have quite different\r\n_____ about what marriage means in their life.',1,2,0,'2019-12-25 08:26:18.111187','2020-03-17 00:31:53.053037',0,1,1,1,'',0,0),(79,4,NULL,'The new manager is very _____. For instance, the employees are given much shorter deadlines for the\r\nsame tasks than before.',1,2,0,'2019-12-25 08:27:04.893096','2020-01-05 21:24:59.092478',0,1,1,1,'',0,0),(80,4,NULL,'While the couple were looking _____ for their missing children, the kids were actually having fun in\r\nthe woods nearby.',1,4,0,'2019-12-25 08:28:00.176428','2020-02-16 22:13:51.753504',0,1,1,1,'',0,0),(81,4,NULL,'After delivering a very powerful speech, the award winner was _____ by a group of fans asking for her signature.',1,2,0,'2019-12-25 08:29:05.623123','2020-03-16 02:38:05.235488',0,1,1,1,'',0,0),(82,4,NULL,'The interviewees were trying very hard to _____ the interviewers that they were very capable and\r\nshould be given the job.',1,2,0,'2019-12-25 08:30:01.784400','2020-03-16 02:38:05.226377',0,1,1,1,'',0,0),(83,4,NULL,'After the first snow of the year, the entire grassland disappeared under a _____ of snow.\r\n',1,2,0,'2019-12-25 08:31:04.892996','2019-12-29 08:05:37.761839',0,1,1,1,'',0,0),(84,4,NULL,'Peter likes books with wide _____, which provide him with enough space to write notes.',1,2,0,'2019-12-25 08:31:57.216138','2020-02-24 11:14:44.894880',0,1,1,1,'',0,0),(85,4,NULL,'At the beginning of the semester, the teacher told the students that late assignments would receive a low grade as a _____.',1,3,0,'2019-12-25 08:32:54.928532','2020-03-16 02:38:05.237619',0,1,1,1,'',0,0),(86,4,NULL,'Various studies have been _____ in this hospital to explore the link between a high-fat diet and cancer.',1,3,0,'2019-12-25 08:33:54.946537','2020-02-16 22:13:51.707041',0,1,1,1,'',0,0),(87,4,NULL,'Intense, fast-moving fires raged across much of California last week. The _____ firestorm has claimed the lives of thirty people.',1,3,0,'2019-12-25 08:35:05.531916','2020-02-16 22:13:51.762678',0,1,1,1,'',0,0),(88,4,NULL,'John’s clock is not functioning _____. The alarm rings even when it’s not set to go off.',1,4,0,'2019-12-25 23:49:18.117495','2020-03-17 00:31:53.054818',0,1,1,1,'',0,0),(89,4,NULL,'Michael has decided to _____ a career in physics and has set his mind on becoming a professor.',1,2,0,'2019-12-25 23:50:17.718596','2020-01-05 00:04:41.062973',0,1,1,1,'',0,0),(90,4,'','Peter plans to hike in a _____ part of Africa, where he might not meet another human being for days.',1,1,0,'2019-12-25 23:51:05.015013','2020-04-13 20:02:06.401745',0,1,1,1,'',0,0),(91,4,NULL,'People in this community tend to _____ with the group they belong to, and often put group interests\r\nbefore personal ones.',1,2,0,'2019-12-25 23:51:50.144780','2020-03-16 02:38:05.222633',0,1,1,1,'',0,0),(92,4,NULL,'I mistook the man for a well-known actor and asked for his autograph; it was really _____.',1,2,0,'2019-12-25 23:52:38.895877','2020-01-04 23:49:20.856671',0,1,1,1,'',0,0),(93,4,NULL,'After spending most of her salary on rent and food, Amelia _____ had any money left for\r\nentertainment and other expenses.',1,6,0,'2019-12-25 23:53:25.278731','2020-03-17 00:31:53.049550',0,1,1,1,'',0,0),(94,4,NULL,'In the Bermuda Triangle, a region in the western part of the North Atlantic Ocean, some airplanes and ships were reported to have mysteriously disappeared without a _____.',1,0,0,'2019-12-25 23:54:19.531493','2020-02-16 22:31:39.454291',0,1,1,1,'',0,0),(95,4,NULL,'Shouting greetings and waving a big sign, Tony _____ the passing shoppers to visit his shop and buy\r\nthe freshly baked bread.',1,2,0,'2019-12-25 23:55:00.695972','2020-02-16 22:13:51.701170',0,1,1,1,'',0,0),(96,4,NULL,'With a continuous 3 km stretch of golden sand, the beach attracts artists around the world each\r\nsummer to create amazing _____ with its fine soft sand.\r\n',1,1,0,'2019-12-25 23:55:58.308430','2020-02-24 11:14:44.892568',0,1,1,1,'',0,0),(97,4,NULL,'The clouds parted and a _____ of light fell on the church, through the windows, and onto the floor.',1,2,0,'2019-12-25 23:56:54.583673','2020-03-16 02:38:05.239438',0,1,1,1,'',0,0),(98,4,NULL,'. Instead of a gift, Tim’s grandmother always _____ some money in the birthday card she gave him.',1,1,0,'2019-12-25 23:57:42.612180','2020-03-16 02:38:05.224701',0,1,1,1,'',0,0),(99,4,NULL,'While winning a gold _____ is what every Olympic athlete dreams of, it becomes meaningless if it is\r\nachieved by cheating.',1,0,0,'2019-12-25 23:58:36.839143','2020-01-04 21:29:45.164267',0,1,1,1,'',0,0),(100,4,NULL,'The thief went into the apartment building and stole some jewelry. He then _____ himself as a\r\nsecurity guard and walked out the front gate.',1,2,0,'2019-12-25 23:59:21.652007','2020-02-16 22:31:39.439309',0,1,1,1,'',0,0),(101,4,NULL,'Due to numerous accidents that occurred while people were playing Pokémon GO, players were\r\nadvised to be _____ of possible dangers in the environment.',1,0,0,'2019-12-26 00:00:17.186295','2019-12-29 08:02:40.199485',0,1,1,1,'',0,0),(102,4,NULL,'Sherlock Holmes, a detective in a popular fiction series, has impressed readers with his amazing\r\npowers of _____ and his knowledge of trivial facts.',1,0,0,'2019-12-26 00:01:02.927972','2020-02-16 22:29:44.674138',0,1,1,1,'',0,0),(103,4,NULL,'Posters of the local rock band were displayed in store windows to promote the sale of their _____ tickets.',1,0,0,'2019-12-26 00:02:19.550592','2019-12-29 07:52:45.445505',0,1,1,1,'',0,0),(104,4,NULL,'Maria didn’t want to deliver the bad news to David about his failing the job interview. She herself was quite _____ about it.',1,4,0,'2019-12-26 00:03:11.445915','2020-02-24 11:14:44.890368',0,1,1,1,'',0,0),(105,4,NULL,'The newcomer speaks with a strong Irish _____; he must be from Ireland.',1,2,0,'2019-12-26 00:03:58.416180','2020-03-17 00:31:53.047010',0,1,1,1,'',0,0),(106,4,NULL,'Although Maggie has been physically _____ to her wheelchair since the car accident, she does not limit herself to indoor activities.',1,2,0,'2019-12-26 00:04:53.752826','2020-02-24 11:14:44.897399',0,1,1,1,'',0,0),(107,4,NULL,'All passengers riding in cars are required to fasten their seatbelts in order to reduce the risk of _____ in case of an accident.',1,1,0,'2019-12-26 00:05:52.019692','2020-02-16 22:29:44.670378',0,1,1,1,'',0,0),(108,4,NULL,'The principal of this school is a man of exceptional _____. He sets aside a part of his salary for a\r\nscholarship fund for children from needy families.',1,0,0,'2019-12-26 00:15:53.205410','2019-12-31 07:36:05.384021',0,1,1,1,'',0,0),(109,4,NULL,'The science teacher always _____ the use of the laboratory equipment before she lets her students use it on their own.',1,1,0,'2019-12-26 00:16:45.679511','2020-02-16 22:31:39.456825',0,1,1,1,'',0,0),(110,4,NULL,'Most of the area is covered by woods, where bird species are so _____ that it is a paradise for\r\nbirdwatchers.',1,2,0,'2019-12-26 00:17:32.236214','2019-12-29 07:55:33.491791',0,1,1,1,'',0,0),(111,4,NULL,'In most cases, the committee members can reach agreement quickly. _____, however, they differ\r\ngreatly in opinion and have a hard time making decisions.\r\n',1,4,0,'2019-12-26 00:18:10.994916','2020-03-16 02:38:05.241126',0,1,1,1,'',0,0),(112,4,NULL,'Many people try to save a lot of money before _____, since having enough money would give them a\r\nsense of security for their future.',1,2,0,'2019-12-26 00:18:52.005813','2020-02-20 11:31:36.459718',0,1,1,1,'',0,0),(113,4,NULL,'In winter, our skin tends to become dry and _____, a problem which is usually treated by applying\r\nlotions or creams.',1,2,0,'2019-12-26 00:19:29.820016','2020-02-16 22:31:39.460666',0,1,1,1,'',0,0),(114,4,NULL,'Benson married Julie soon after he had _____ her heart and gained her parents’ approval.',1,0,0,'2019-12-26 00:20:11.296244','2020-02-16 22:29:44.641026',0,1,1,1,'',0,0),(115,4,NULL,'The recent flood completely _____ my parents’ farm. The farmhouse and fruit trees were all gone and\r\nnothing was left.',1,5,0,'2019-12-26 00:20:51.224284','2020-02-24 11:14:44.904903',0,1,1,1,'',0,0),(116,4,NULL,'The results of this survey are not reliable because the people it questioned were not a typical or _____ sample of the entire population that was studied.',1,1,0,'2019-12-26 00:21:34.775035','2020-02-16 22:29:44.677404',0,1,1,1,'',0,0),(117,4,NULL,'In line with the worldwide green movement, carmakers have been working hard to make their new\r\nmodels more _____ friendly to reduce pollution.',1,1,0,'2019-12-26 00:22:25.904673','2020-01-04 21:29:45.178508',0,1,1,1,'',0,0),(125,1,'question_files/question_125.mp3',NULL,1,2,0,'2019-12-26 03:09:41.553574','2020-04-05 22:44:21.448058',0,1,1,1,'',0,0),(126,1,'question_files/question_126.mp3',NULL,1,3,0,'2019-12-26 03:22:19.579554','2020-04-05 22:44:21.450380',0,1,1,1,'',0,0),(127,1,'question_files/question_127.mp3',NULL,1,3,0,'2019-12-26 03:27:43.982979','2020-04-05 22:44:21.452820',0,1,1,1,'',0,0),(128,1,'question_files/question_128.mp3',NULL,1,2,0,'2019-12-26 03:30:18.122344','2020-04-05 22:44:21.455117',0,1,1,1,'',0,0),(129,1,'question_files/question_129.mp3',NULL,1,5,0,'2019-12-26 03:33:19.089663','2020-04-05 22:44:21.457200',0,1,1,1,'',0,0),(130,1,'question_files/question_130.mp3',NULL,1,3,0,'2019-12-26 03:37:09.229280','2020-04-05 22:44:21.459198',0,1,1,1,'',0,0),(131,1,'question_files/question_131.mp3',NULL,1,1,0,'2019-12-26 06:04:50.722261','2020-04-05 22:44:21.461611',0,1,1,1,'',0,0),(132,1,'question_files/question_132.mp3',NULL,1,0,0,'2019-12-26 06:08:58.012976','2020-04-05 22:44:21.463488',0,1,1,1,'',0,0),(133,1,'question_files/question_133.mp3',NULL,1,4,0,'2019-12-26 06:11:53.890894','2020-04-05 22:44:21.465715',0,1,1,1,'',0,0),(134,1,'question_files/question_134.mp3',NULL,1,2,0,'2019-12-26 06:17:00.972463','2020-04-05 22:44:21.468331',0,1,1,1,'',0,0),(135,1,'question_files/question_135.mp3',NULL,1,1,0,'2019-12-26 06:20:19.431249','2020-04-05 22:44:21.470644',0,1,1,1,'',0,0),(136,1,'question_files/question_136.mp3',NULL,1,0,0,'2019-12-26 06:23:48.337419','2020-04-05 22:44:21.472969',0,1,1,1,'',0,0),(137,1,'question_files/question_137.mp3',NULL,1,4,0,'2019-12-26 06:26:58.197782','2020-04-05 22:44:21.475687',0,1,1,1,'',0,0),(138,1,'question_files/question_138.mp3',NULL,1,0,0,'2019-12-26 06:32:30.462517','2020-04-05 22:44:21.478066',0,2,1,1,'聽不太懂',0,0),(139,1,'question_files/question_139.mp3',NULL,1,3,0,'2019-12-26 06:35:12.781862','2020-04-05 22:44:21.480668',0,1,1,1,'',0,0),(140,1,'question_files/question_140.mp3',NULL,1,4,0,'2019-12-26 06:39:23.967520','2020-04-05 22:44:21.483043',0,1,1,1,'',0,0),(141,1,'question_files/question_141.mp3',NULL,1,3,0,'2019-12-26 06:42:31.268421','2020-04-05 22:44:21.485482',0,1,1,1,'',0,0),(142,1,'question_files/question_142.mp3',NULL,1,2,0,'2019-12-26 06:46:30.796314','2020-04-05 22:44:21.488079',0,1,1,1,'',0,0),(143,1,'question_files/question_143.mp3',NULL,1,4,0,'2019-12-26 06:49:39.177467','2020-04-05 22:44:21.490296',0,1,1,1,'',0,0),(144,1,'question_files/question_144.mp3',NULL,1,3,0,'2019-12-26 06:54:08.787461','2020-04-05 22:44:21.492659',0,1,1,1,'',0,0),(145,1,'question_files/question_145.mp3',NULL,1,2,0,'2019-12-26 07:07:02.339676','2020-04-05 22:44:21.495066',0,1,1,1,'',0,0),(146,1,'question_files/question_146.mp3',NULL,1,1,0,'2019-12-26 07:13:59.679023','2020-04-05 22:44:21.497460',0,1,1,1,'',0,0),(147,1,'question_files/question_147.mp3',NULL,1,2,0,'2019-12-26 07:17:00.663406','2020-04-05 22:44:21.500152',0,1,1,1,'',0,0),(148,1,'question_files/question_148.mp3',NULL,1,3,0,'2019-12-26 07:23:00.514240','2020-04-05 22:44:21.502342',0,1,1,1,'',0,0),(149,1,'question_files/question_149.mp3',NULL,1,4,0,'2019-12-26 07:26:47.400984','2020-04-05 22:44:21.504367',0,1,1,1,'',0,0),(150,1,'question_files/question_150.mp3',NULL,1,3,0,'2019-12-26 07:41:56.109196','2020-04-05 22:44:21.506622',0,1,1,1,'雖然可以選出答案，但是音檔缺少問句的部分',0,0),(151,1,'question_files/question_151.mp3',NULL,1,2,0,'2019-12-26 07:45:42.139566','2020-04-05 22:44:21.509297',0,1,1,1,'',0,0),(152,1,'question_files/question_152.mp3',NULL,1,1,0,'2019-12-26 07:50:29.395450','2020-04-05 22:44:21.511950',0,1,1,1,'',0,0),(153,1,'question_files/question_153.mp3',NULL,1,3,0,'2019-12-26 07:53:08.891499','2020-04-05 22:44:21.514692',0,1,1,1,'',0,0),(154,1,'question_files/question_154.mp3',NULL,1,3,0,'2019-12-26 07:58:00.692136','2020-04-05 22:44:21.516870',0,1,1,1,'',0,0),(155,1,'question_files/question_155.mp3',NULL,1,1,0,'2019-12-31 00:46:56.236122','2020-04-05 22:44:21.519274',0,1,1,1,'',0,0),(156,1,'question_files/question_156.mp3',NULL,1,3,0,'2019-12-31 00:54:23.533230','2020-04-05 22:44:21.521810',0,1,1,1,'',0,0),(157,1,'question_files/question_157.mp3',NULL,1,1,0,'2019-12-31 00:55:37.802431','2020-04-05 22:44:21.523729',0,1,1,1,'',0,0),(158,1,'question_files/question_158.mp3',NULL,1,1,0,'2019-12-31 00:57:01.360611','2020-04-05 22:44:21.526313',0,1,1,1,'',0,0),(159,1,'question_files/question_159.mp3',NULL,1,4,0,'2019-12-31 00:58:11.312295','2020-04-05 22:44:21.528773',0,1,1,1,'',0,0),(160,1,'question_files/question_160.mp3',NULL,1,4,0,'2019-12-31 01:00:01.545383','2020-04-05 22:44:21.530881',0,1,1,1,'',0,0),(161,1,'question_files/question_161.mp3',NULL,1,0,0,'2019-12-31 01:01:05.176691','2020-04-05 22:44:21.533629',0,2,1,1,'聽不太懂',0,0),(162,1,'question_files/question_162.mp3',NULL,1,3,0,'2019-12-31 01:02:07.772268','2020-04-05 22:44:21.536137',0,1,1,1,'',0,0),(163,1,'question_files/question_163.mp3',NULL,1,3,0,'2019-12-31 01:03:17.137776','2020-04-05 22:44:21.538835',0,1,1,1,'',0,0),(164,1,'question_files/question_164.mp3',NULL,1,0,0,'2019-12-31 01:04:38.150599','2020-04-05 22:44:21.541597',0,1,1,1,'',0,0),(165,1,'question_files/question_165.mp3',NULL,1,4,0,'2019-12-31 01:06:13.342088','2020-04-05 22:44:21.543578',0,1,1,1,'',0,0),(166,1,'question_files/question_166.mp3',NULL,1,3,0,'2019-12-31 01:08:24.370943','2020-04-05 22:44:21.545934',0,1,1,1,'',0,0),(167,1,'question_files/question_167.mp3',NULL,1,3,0,'2019-12-31 01:10:05.525811','2020-04-05 22:44:21.548106',0,1,1,1,'',0,0),(168,1,'question_files/question_168.mp3',NULL,1,0,0,'2019-12-31 01:11:33.647824','2020-04-05 22:44:21.550803',0,2,1,1,'重複了',0,0),(169,1,'question_files/question_169.mp3',NULL,1,0,0,'2019-12-31 01:15:53.747340','2020-04-05 22:44:21.552984',0,2,1,1,'重複了',0,0),(170,1,'question_files/question_170.mp3',NULL,1,0,0,'2019-12-31 01:17:55.752327','2020-04-05 22:44:21.554833',0,2,1,1,'聽不太懂\r\n\r\n',0,0),(171,1,'question_files/question_171.mp3',NULL,1,2,0,'2019-12-31 01:19:06.620106','2020-04-05 22:44:21.556795',0,1,1,1,'',0,0),(172,1,'question_files/question_172.mp3',NULL,1,1,0,'2019-12-31 01:20:07.903854','2020-04-05 22:44:21.559237',0,1,1,1,'',0,0),(173,1,'question_files/question_173.mp3',NULL,1,0,0,'2019-12-31 01:21:08.906488','2020-04-05 22:44:21.561172',0,1,1,1,'',0,0),(174,1,'question_files/question_174.mp3',NULL,1,0,0,'2019-12-31 01:22:37.554419','2020-04-05 22:44:21.562759',0,6,1,1,'重複',0,0),(175,2,'question_files/question_175.mp3',NULL,1,4,0,'2019-12-31 01:25:08.452279','2020-04-05 22:44:21.565162',0,1,1,1,'',0,0),(176,2,'question_files/question_176.mp3',NULL,1,6,0,'2019-12-31 01:35:26.171595','2020-04-05 22:44:21.566800',0,1,1,1,'',0,0),(177,2,'question_files/question_177.mp3',NULL,1,6,0,'2019-12-31 01:36:23.550289','2020-04-05 22:44:21.568350',0,1,1,1,'',0,0),(178,2,'question_files/question_178.mp3',NULL,1,6,0,'2019-12-31 03:09:49.996004','2020-04-05 22:44:21.570593',0,1,1,1,'',0,0),(179,2,'question_files/question_179.mp3',NULL,1,5,0,'2019-12-31 03:22:18.400906','2020-04-05 22:44:21.572688',0,1,1,1,'',0,0),(180,2,'question_files/question_180.mp3',NULL,1,6,0,'2019-12-31 03:36:34.520015','2020-04-05 22:44:21.575249',0,1,1,1,'',0,0),(181,2,'question_files/question_181.mp3',NULL,1,6,0,'2019-12-31 03:37:49.760395','2020-04-05 22:44:21.578042',0,1,1,1,'',0,0),(182,2,'question_files/question_182.mp3',NULL,1,7,0,'2019-12-31 03:40:20.103403','2020-04-05 22:44:21.580318',0,1,1,1,'',0,0),(183,2,'question_files/question_183.mp3',NULL,1,6,0,'2019-12-31 03:41:32.399519','2020-04-05 22:44:21.582399',0,1,1,1,'',0,0),(184,2,'question_files/question_184.mp3',NULL,1,6,0,'2019-12-31 03:43:09.988883','2020-04-05 22:44:21.584475',0,1,1,1,'',0,0),(186,1,'question_files/question_186.mp3',NULL,1,6,0,'2020-01-01 16:02:50.237482','2020-04-05 22:44:21.586503',0,1,1,1,'',0,0),(187,1,'question_files/question_187.mp3',NULL,1,1,0,'2020-01-01 16:05:52.080960','2020-04-05 22:44:21.588340',0,1,1,1,'',0,0),(188,1,'question_files/question_188.mp3',NULL,1,1,0,'2020-01-01 16:07:35.962083','2020-04-05 22:44:21.590337',0,1,1,1,'',0,0),(189,1,'question_files/question_189.mp3',NULL,1,0,0,'2020-01-01 16:10:14.396142','2020-04-05 22:44:21.592736',0,1,1,1,'',0,0),(190,1,'question_files/question_190.mp3',NULL,1,3,0,'2020-01-01 16:11:52.280240','2020-04-05 22:44:21.595053',0,1,1,1,'',0,0),(191,1,'question_files/question_191.mp3',NULL,1,4,0,'2020-01-01 16:13:13.976888','2020-04-05 22:44:21.597966',0,1,1,1,'',0,0),(192,1,'question_files/question_192.mp3',NULL,1,1,0,'2020-01-01 16:15:31.756286','2020-04-05 22:44:21.600566',0,1,1,1,'',0,0),(193,1,'question_files/question_193.mp3',NULL,1,1,0,'2020-01-01 16:16:28.205044','2020-04-05 22:44:21.602921',0,1,1,1,'',0,0),(194,1,'question_files/question_194.mp3',NULL,1,1,0,'2020-01-01 16:17:21.729672','2020-04-05 22:44:21.605627',0,1,1,1,'',0,0),(195,1,'question_files/question_195.mp3',NULL,1,5,0,'2020-01-01 16:19:14.579817','2020-04-05 22:44:21.608040',0,1,1,1,'',0,0),(196,1,'question_files/question_196.mp3',NULL,1,1,0,'2020-01-01 16:20:05.224447','2020-04-05 22:44:21.610105',0,1,1,1,'',0,0),(197,1,'question_files/question_197.mp3',NULL,1,1,0,'2020-01-01 16:22:03.613290','2020-04-05 22:44:21.612189',0,1,1,1,'',0,0),(198,1,'question_files/question_198.mp3',NULL,1,7,0,'2020-01-01 16:23:41.872538','2020-04-05 22:44:21.614547',0,1,1,1,'',0,0),(199,1,'question_files/question_199.mp3',NULL,1,1,0,'2020-01-01 16:24:42.730861','2020-04-05 22:44:21.616861',0,1,1,1,'',0,0),(200,1,'question_files/question_200.mp3',NULL,1,5,0,'2020-01-01 16:25:42.844632','2020-04-05 22:44:21.619371',0,1,1,1,'',0,0),(201,1,'question_files/question_201.mp3',NULL,1,2,0,'2020-01-01 23:47:09.940770','2020-04-05 22:44:21.622169',0,1,1,1,'',0,0),(202,1,'question_files/question_202.mp3',NULL,1,2,0,'2020-01-01 23:48:31.777422','2020-04-05 22:44:21.624519',0,1,1,1,'',0,0),(203,1,'question_files/question_203.mp3',NULL,1,3,0,'2020-01-01 23:49:40.747913','2020-04-05 22:44:21.627279',0,1,1,1,'',0,0),(204,1,'question_files/question_204.mp3',NULL,1,1,0,'2020-01-01 23:51:07.607177','2020-04-05 22:44:21.629784',0,1,1,1,'',0,0),(205,1,'question_files/question_205.mp3',NULL,1,1,0,'2020-01-02 00:12:15.013826','2020-04-05 22:44:21.632777',0,1,1,1,'',0,0),(206,1,'question_files/question_206.mp3',NULL,1,1,0,'2020-01-02 00:15:34.706242','2020-04-05 22:44:21.635568',0,1,1,1,'',0,0),(207,1,'question_files/question_207.mp3',NULL,1,3,0,'2020-01-02 00:16:36.994048','2020-04-05 22:44:21.637846',0,1,1,1,'',0,0),(208,1,'question_files/question_208.mp3',NULL,1,6,0,'2020-01-02 00:18:15.199358','2020-04-05 22:44:21.640033',0,1,1,1,'',0,0),(209,1,'question_files/question_209.mp3',NULL,1,2,0,'2020-01-02 00:19:25.499366','2020-04-05 22:44:21.642200',0,1,1,1,'',0,0),(210,1,'question_files/question_210.mp3',NULL,1,2,0,'2020-01-02 03:13:02.891840','2020-04-05 22:44:21.644371',0,1,1,1,'',0,0),(211,1,'question_files/question_211.mp3',NULL,1,3,0,'2020-01-02 03:16:06.203910','2020-04-05 22:44:21.646068',0,1,1,1,'',0,0),(212,1,'question_files/question_212.mp3',NULL,1,1,0,'2020-01-02 03:18:03.862115','2020-04-05 22:44:21.648226',0,1,1,1,'',0,0),(213,1,'question_files/question_213.mp3',NULL,1,4,0,'2020-01-02 03:20:28.900512','2020-04-05 22:44:21.651098',0,1,1,1,'',0,0),(214,1,'question_files/question_214.mp3',NULL,1,0,0,'2020-01-02 03:22:59.682877','2020-04-05 22:44:21.653657',0,1,1,1,'',0,0),(215,1,'question_files/question_215.mp3',NULL,1,1,0,'2020-01-02 03:25:33.637488','2020-04-05 22:44:21.655825',0,1,1,1,'',0,0),(216,1,'question_files/question_216.mp3',NULL,1,0,0,'2020-01-02 03:27:29.396692','2020-04-05 22:44:21.657983',0,3,1,NULL,'',0,0),(217,1,'question_files/question_217.mp3',NULL,1,2,0,'2020-01-02 03:29:05.277246','2020-04-05 22:44:21.659845',0,1,1,1,'',0,0),(218,1,'question_files/question_218.mp3',NULL,1,2,0,'2020-01-02 03:30:11.193289','2020-04-05 22:44:21.661880',0,1,1,1,'',0,0),(219,1,'question_files/question_219.mp3',NULL,1,3,0,'2020-01-02 03:31:42.891768','2020-04-05 22:44:21.663849',0,1,1,1,'',0,0),(220,1,'question_files/question_220.mp3',NULL,1,2,0,'2020-01-02 03:35:04.615173','2020-04-05 22:44:21.665895',0,1,1,1,'',0,0),(221,1,'question_files/question_221.mp3',NULL,1,0,0,'2020-01-02 03:43:08.392012','2020-04-05 22:44:21.668743',0,3,1,NULL,'',0,0),(222,1,'question_files/question_222.mp3',NULL,1,2,0,'2020-01-02 14:32:19.212100','2020-04-05 22:44:21.671503',0,1,1,1,'',0,0),(223,1,'question_files/question_223.mp3',NULL,1,0,0,'2020-01-02 14:34:10.631745','2020-04-05 22:44:21.673358',0,3,1,NULL,'',0,0),(224,1,'question_files/question_224.mp3',NULL,1,0,0,'2020-01-02 14:35:55.005009','2020-04-05 22:44:21.675257',0,3,1,NULL,'',0,0),(225,1,'question_files/question_225.mp3',NULL,1,0,0,'2020-01-02 14:37:26.922694','2020-04-05 22:44:21.678153',0,1,1,1,'',0,0),(226,1,'question_files/question_226.mp3',NULL,1,0,0,'2020-01-02 14:39:47.878449','2020-04-05 22:44:21.680419',0,3,1,NULL,'',0,0),(227,1,'question_files/question_227.mp3',NULL,1,0,0,'2020-01-02 14:43:14.930114','2020-04-05 22:44:21.683214',0,3,1,NULL,'',0,0),(228,1,'question_files/question_228.mp3',NULL,1,0,0,'2020-01-02 14:46:26.029960','2020-04-05 22:44:21.685339',0,3,1,NULL,'',0,0),(229,1,'question_files/question_229.mp3',NULL,1,0,0,'2020-01-02 15:18:20.186313','2020-04-05 22:44:21.687568',0,3,1,NULL,'',0,0),(230,1,'question_files/question_230.mp3',NULL,1,0,0,'2020-01-02 15:19:26.414794','2020-04-05 22:44:21.689705',0,3,1,NULL,'',0,0),(231,1,'question_files/question_231.mp3',NULL,1,0,0,'2020-01-02 15:20:12.842126','2020-04-05 22:44:21.691861',0,3,1,NULL,'',0,0),(232,1,'question_files/question_232.mp3',NULL,1,0,0,'2020-01-02 15:21:07.245042','2020-04-05 22:44:21.694870',0,3,1,NULL,'',0,0),(233,1,'question_files/question_233.mp3',NULL,1,0,0,'2020-01-02 15:21:45.726040','2020-04-05 22:44:21.696924',0,3,1,NULL,'',0,0),(234,1,'question_files/question_234.mp3',NULL,1,0,0,'2020-01-02 15:22:44.457560','2020-04-05 22:44:21.698902',0,3,1,NULL,'',0,0),(235,2,'question_files/question_235.mp3',NULL,1,0,0,'2020-01-02 15:23:58.097504','2020-04-05 22:44:21.700528',0,3,1,NULL,'',0,0),(236,2,'question_files/question_236.mp3',NULL,1,3,0,'2020-01-02 15:24:37.810894','2020-04-14 15:39:19.376480',0,1,1,7,'',0,0),(237,2,'question_files/question_237.mp3',NULL,1,0,0,'2020-01-02 15:25:48.764638','2020-04-05 22:44:21.704986',0,3,1,NULL,'',0,0),(238,2,'question_files/question_238.mp3',NULL,1,4,0,'2020-01-02 15:26:27.477890','2020-04-05 22:44:21.707109',0,1,1,1,'',0,0),(239,2,'question_files/question_239.mp3',NULL,1,0,0,'2020-01-02 15:27:22.088590','2020-04-05 22:44:21.709182',0,3,1,NULL,'',0,0),(240,2,'question_files/question_240.mp3',NULL,1,0,0,'2020-01-02 15:28:04.153013','2020-04-05 22:44:21.711184',0,3,1,NULL,'',0,0),(241,2,'question_files/question_241.mp3',NULL,1,0,0,'2020-01-02 15:28:41.584090','2020-04-05 22:44:21.714673',0,3,1,NULL,'',0,0),(242,2,'question_files/question_242.mp3',NULL,1,0,0,'2020-01-02 15:29:17.535518','2020-04-05 22:44:21.716483',0,3,1,NULL,'',0,0),(243,2,'question_files/question_243.mp3',NULL,1,6,0,'2020-01-02 15:29:50.534627','2020-04-05 22:44:21.718543',0,1,1,1,'',0,0),(244,2,'question_files/question_244.mp3',NULL,1,0,0,'2020-01-02 15:30:25.738837','2020-04-05 22:44:21.720418',0,3,1,NULL,'',0,0),(245,1,'question_files/question_245.mp3',NULL,1,0,0,'2020-01-02 16:24:50.751925','2020-04-05 22:44:21.722047',0,3,1,NULL,'',0,0),(246,1,'question_files/question_246.mp3',NULL,1,0,0,'2020-01-02 16:25:25.555041','2020-04-05 22:44:21.723770',0,3,1,NULL,'',0,0),(247,1,'question_files/question_247.mp3',NULL,1,0,0,'2020-01-02 16:26:05.587564','2020-04-05 22:44:21.725120',0,3,1,NULL,'',0,0),(248,1,'question_files/question_248.mp3',NULL,1,0,0,'2020-01-02 16:26:43.678631','2020-04-05 22:44:21.726928',0,3,1,NULL,'',0,0),(249,1,'question_files/question_249.mp3',NULL,1,0,0,'2020-01-02 16:27:15.779198','2020-04-05 22:44:21.728514',0,3,1,NULL,'',0,0),(250,1,'question_files/question_250.mp3',NULL,1,0,0,'2020-01-02 16:27:57.094970','2020-04-05 22:44:21.730093',0,3,1,NULL,'',0,0),(251,1,'question_files/question_251.mp3',NULL,1,0,0,'2020-01-02 16:28:31.802595','2020-04-05 22:44:21.731615',0,3,1,NULL,'',0,0),(253,1,'question_files/question_253.mp3',NULL,1,0,0,'2020-01-02 16:29:13.338635','2020-04-05 22:44:21.733211',0,3,1,NULL,'',0,0),(254,1,'question_files/question_254.mp3',NULL,1,0,0,'2020-01-02 16:34:51.251249','2020-04-05 22:44:21.735134',0,3,1,NULL,'',0,0),(255,1,'question_files/question_255.mp3',NULL,1,0,0,'2020-01-02 16:35:21.544493','2020-04-05 22:44:21.737066',0,3,1,NULL,'',0,0),(256,1,'question_files/question_256.mp3',NULL,1,3,0,'2020-01-02 16:35:57.793308','2020-04-05 22:44:21.739371',0,1,1,1,'',0,0),(257,1,'question_files/question_257.mp3',NULL,1,2,0,'2020-01-02 16:36:45.200118','2020-04-05 22:44:21.740876',0,1,1,1,'',0,0),(258,1,'question_files/question_258.mp3',NULL,1,0,0,'2020-01-02 16:37:18.785821','2020-04-05 22:44:21.742469',0,1,1,1,'',0,0),(259,1,'question_files/question_259.mp3',NULL,1,4,0,'2020-01-02 16:37:58.174302','2020-04-05 22:44:21.744222',0,1,1,1,'',0,0),(260,1,'question_files/question_260.mp3',NULL,1,2,0,'2020-01-02 16:38:37.076677','2020-04-05 22:44:21.746054',0,1,1,1,'',0,0),(261,1,'question_files/question_261.mp3',NULL,1,1,0,'2020-01-02 16:39:14.654273','2020-04-05 22:44:21.747621',0,1,1,1,'',0,0),(262,1,'question_files/question_262.mp3',NULL,1,1,0,'2020-01-02 16:39:54.846016','2020-04-05 22:44:21.749096',0,1,1,1,'',0,0),(263,1,'question_files/question_263.mp3',NULL,1,2,0,'2020-01-02 16:40:40.790361','2020-04-05 22:44:21.750904',0,1,1,1,'',0,0),(264,1,'question_files/question_264.mp3',NULL,1,3,0,'2020-01-02 16:41:21.842370','2020-04-05 22:44:21.753261',0,1,1,1,'',0,0),(265,1,'question_files/question_265.mp3',NULL,1,0,0,'2020-01-02 16:41:58.145047','2020-04-05 22:44:21.755019',0,1,1,1,'',0,0),(266,1,'question_files/question_266.mp3',NULL,1,4,0,'2020-01-02 16:42:40.402035','2020-04-05 22:44:21.756461',0,1,1,1,'',0,0),(267,1,'question_files/question_267.mp3',NULL,1,0,0,'2020-01-02 16:43:18.001049','2020-04-05 22:44:21.758126',0,1,1,1,'',0,0),(268,1,'question_files/question_268.mp3',NULL,1,3,0,'2020-01-02 16:43:53.009901','2020-04-05 22:44:21.759894',0,1,1,1,'',0,0),(269,1,'question_files/question_269.mp3',NULL,1,1,0,'2020-01-02 16:44:28.553077','2020-04-05 22:44:21.761593',0,1,1,1,'',0,0),(270,1,'question_files/question_270.mp3',NULL,1,4,0,'2020-01-02 16:45:11.022337','2020-04-05 22:44:21.763382',0,1,1,1,'',0,0),(271,1,'question_files/question_271.mp3',NULL,1,1,0,'2020-01-02 16:45:52.218651','2020-04-05 22:44:21.764943',0,1,1,1,'',0,0),(272,1,'question_files/question_272.mp3',NULL,1,3,0,'2020-01-02 16:46:26.843378','2020-04-05 22:44:21.766772',0,1,1,1,'',0,0),(273,1,'question_files/question_273.mp3',NULL,1,3,0,'2020-01-02 16:47:05.133520','2020-04-05 22:44:21.768929',0,1,1,1,'',0,0),(274,1,'question_files/question_274.mp3',NULL,1,2,0,'2020-01-02 16:47:38.563030','2020-04-05 22:44:21.770873',0,1,1,1,'',0,0),(275,1,'question_files/question_275.mp3',NULL,1,2,0,'2020-01-02 16:48:19.844277','2020-04-05 22:44:21.772553',0,1,1,1,'',0,0),(276,1,'question_files/question_276.mp3',NULL,1,3,0,'2020-01-02 16:48:57.950132','2020-04-05 22:44:21.774345',0,1,1,1,'',0,0),(277,1,'question_files/question_277.mp3',NULL,1,3,0,'2020-01-02 16:49:54.338822','2020-04-05 22:44:21.776347',0,1,1,1,'',0,0),(278,1,'question_files/question_278.mp3',NULL,1,5,0,'2020-01-02 16:53:59.921940','2020-04-05 22:44:21.778011',0,1,1,1,'',0,0),(279,1,'question_files/question_279.mp3',NULL,1,2,0,'2020-01-02 16:54:39.007154','2020-04-05 22:44:21.779530',0,1,1,1,'',0,0),(280,1,'question_files/question_280.mp3',NULL,1,2,0,'2020-01-02 16:55:17.770811','2020-04-05 22:44:21.781507',0,1,1,1,'',0,0),(281,1,'question_files/question_281.mp3',NULL,1,4,0,'2020-01-02 16:55:49.089345','2020-04-05 22:44:21.783114',0,1,1,1,'',0,0),(282,1,'question_files/question_282.mp3',NULL,1,3,0,'2020-01-02 16:56:20.370296','2020-04-05 22:44:21.785278',0,1,1,1,'',0,0),(283,1,'question_files/question_283.mp3',NULL,1,2,0,'2020-01-02 16:56:54.991254','2020-04-05 22:44:21.787112',0,1,1,1,'',0,0),(284,1,'question_files/question_284.mp3',NULL,1,2,0,'2020-01-02 16:57:23.739157','2020-04-05 22:44:21.788706',0,1,1,1,'',0,0),(285,1,'question_files/question_285.mp3',NULL,1,1,0,'2020-01-02 16:57:55.602738','2020-04-14 11:26:43.677595',0,1,1,1,'',0,0),(286,1,'question_files/question_286.mp3',NULL,1,4,0,'2020-01-02 16:58:25.652093','2020-04-05 22:44:21.792040',0,1,1,1,'',0,0),(287,1,'question_files/question_287.mp3',NULL,1,6,0,'2020-01-02 16:59:01.474151','2020-04-05 22:44:21.793739',0,1,1,1,'',0,0),(288,1,'question_files/question_288.mp3',NULL,1,3,0,'2020-01-02 16:59:36.062098','2020-04-05 22:44:21.795649',0,1,1,1,'',0,0),(289,1,'question_files/question_289.mp3',NULL,1,0,0,'2020-01-02 17:00:08.406622','2020-04-05 22:44:21.797267',0,1,1,1,'',0,0),(290,1,'question_files/question_290.mp3',NULL,1,1,0,'2020-01-02 17:00:46.717024','2020-04-05 22:44:21.798828',0,1,1,1,'',0,0),(291,1,'question_files/question_291.mp3',NULL,1,4,0,'2020-01-02 17:01:34.535043','2020-04-05 22:44:21.800640',0,1,1,1,'',0,0),(292,1,'question_files/question_292.mp3',NULL,1,2,0,'2020-01-02 17:02:13.898856','2020-04-05 22:44:21.802816',0,1,1,1,'',0,0),(293,1,'question_files/question_293.mp3',NULL,1,2,0,'2020-01-02 17:02:47.136140','2020-04-05 22:44:21.804627',0,1,1,1,'',0,0),(294,1,'question_files/question_294.mp3',NULL,1,1,0,'2020-01-02 17:03:19.339940','2020-04-05 22:44:21.806241',0,1,1,1,'',0,0),(295,1,'question_files/question_295.mp3',NULL,1,4,0,'2020-01-02 17:03:56.039821','2020-04-05 22:44:21.808007',0,1,1,1,'',0,0),(296,2,'question_files/question_296.mp3',NULL,1,6,0,'2020-01-02 17:06:48.471096','2020-04-05 22:44:21.810309',0,1,1,1,'',0,0),(297,2,'question_files/question_297.mp3',NULL,1,6,0,'2020-01-02 17:07:23.639309','2020-04-05 22:44:21.812062',0,1,1,1,'',0,0),(298,2,'question_files/question_298.mp3',NULL,1,6,0,'2020-01-02 17:07:59.474161','2020-04-05 22:44:21.813444',0,1,1,1,'',0,0),(299,2,'question_files/question_299.mp3',NULL,1,6,0,'2020-01-02 17:09:02.910464','2020-04-05 22:44:21.815043',0,1,1,1,'',0,0),(300,2,'question_files/question_300.mp3',NULL,1,6,0,'2020-01-02 17:09:37.001828','2020-04-05 22:44:21.817549',0,1,1,1,'',0,0),(301,2,'question_files/question_301.mp3',NULL,1,0,0,'2020-01-02 17:10:09.957856','2020-04-05 22:44:21.820326',0,3,1,1,'He back aches.選項有問題',0,0),(302,2,'question_files/question_302.mp3',NULL,1,6,0,'2020-01-02 17:10:43.221566','2020-04-05 22:44:21.822054',0,1,1,1,'',0,0),(303,2,'question_files/question_303.mp3',NULL,1,6,0,'2020-01-02 17:11:27.349246','2020-04-05 22:44:21.824016',0,1,1,1,'',0,0),(304,2,'question_files/question_304.mp3',NULL,1,6,0,'2020-01-02 17:12:00.584808','2020-04-05 22:44:21.826539',0,1,1,1,'',0,0),(305,2,'question_files/question_305.mp3',NULL,1,6,0,'2020-01-02 17:12:35.417227','2020-04-05 22:44:21.828331',0,1,1,1,'',0,0),(339,5,NULL,'Got a bug bite problem? Many people who are troubled by skin rashes caused by bug bites use\r\n“foggers,” or “bug bombs,” to get rid of the annoying crawlers in their homes. Many people think these bug killers or pesticides will penetrate every place where the insects hide. Actually, quite the opposite is true. Once the pests detect the chemical fog in the room, they’ll hide themselves in walls or other hideaways, where you’ll never be able to treat them effectively.\r\nOhio State University researchers tested three commercially sold foggers in a study on the effect of foggers on bedbugs. After testing these brands on five different groups of live bedbugs for two hours, the scientists saw that the foggers had little—if any—effect on the insects. The researchers said bedbugs hide in cracks and crevices such as under sheets and mattresses, or deep in carpets where foggers won’t reach. Moreover, bugs that do come in contact with the mist may be resistant to the pesticide.\r\nFoggers, or bug bombs, should really be a measure of last resort. First of all, the gases used in bug bombs are highly flammable and thus pose a serious risk of fire or explosion if the product is not used properly. Second, once a bug bomb is used, every surface in your home will be covered with the toxic pesticide. When you use a bug bomb, a chemical mixture rains down on your counters, furniture, floors, and walls, leaving behind oily and toxic substances. Your health might thus be endangered. Therefore, it is suggested that people leave the problem to the professionals.\r\n\r\nWhat is this passage mainly about?',1,8,0,'2020-02-20 10:27:20.702517','2020-02-28 11:37:58.383105',0,1,1,1,'',0,0),(340,5,NULL,'Earworms often take the form of song fragments rather than entire songs, and the song is usually a familiar one. Researchers are not sure why some songs are more likely to get stuck in our heads than others, but everyone has their own tunes. Often those songs have a simple, upbeat melody and catchy, repetitive lyrics, such as popular commercial jingles and slightly annoying radio hits. Recent or repeated exposure to a song or even a small part of a song can also trigger earworms, as can word associations, such as a phrase similar to the lyrics of a song.\r\nWhile earworms might be annoying, most people who experience them nevertheless report that they are pleasant or at least neutral. Only a third of people are disturbed by the song in their heads. How people cope with their earworms seems to depend on how they feel about them. Those who have positive feelings about their stuck songs prefer to just “let them be,” while those with negative feelings turn to more behavioral responses, which include coping strategies such as singing, talking, or even praying.\r\n\r\nAccording to the passage, which of the following is true about an earworm?',1,8,0,'2020-02-20 11:03:59.831897','2020-03-16 22:14:39.224458',0,1,1,1,'',0,0),(341,5,NULL,'Angelfish, often found in the warm seas and coral reefs, are among the most brightly colored fish of\r\nthe ocean. Brilliant colors and stripes form amazing patterns on their body. These patterns actually help the fish to hide from danger among roots and plants. At night, when these fish become inactive, their colors may become pale. Often, the young ones are differently colored than the adults. Some scientists believe that the color difference between the young and the old indicates their different social positions.\r\nAnother interesting fact about angelfish is that they have an occupation in the fish world. Most of them act as cleaners for other fish and pick dead tissue from their bodies. This is not their food, though. Their diet consists mainly of sponge and algae.\r\n\r\nWhat is the job of an angelfish in the sea?',1,8,0,'2020-02-20 11:27:34.292146','2020-02-28 11:37:58.314740',0,1,1,1,'',0,0),(342,5,NULL,'Redwood trees are the tallest plants on the earth, reaching heights of up to 100 meters. They are also known for their longevity, typically 500 to 1000 years, but sometimes more than 2000 years. A hundred million years ago, in the age of dinosaurs, redwoods were common in the forests of a much more moist and tropical North America. As the climate became drier and colder, they retreated to a narrow strip along the Pacific coast of Northern California.\r\nThe trunk of redwood trees is very stout and usually forms a single straight column. It is covered with a beautiful soft, spongy bark. This bark can be pretty thick, well over two feet in the more mature trees. It gives the older trees a certain kind of protection from insects, but the main benefit is that it keeps the center of the tree intact from moderate forest fires because of its thickness. This fire resistant quality explains why the giant redwood grows to live that long. While most other types of trees are destroyed by forest fires, the giant redwood actually prospers because of them. Moderate fires will clear the ground of competing plant life, and the rising heat dries and opens the ripe cones of the redwood, releasing many thousands of seeds onto the ground below.\r\nNew trees are often produced from sprouts, little baby trees, which form at the base of the trunk. These sprouts grow slowly, nourished by the root system of the “mother” tree. When the main tree dies, the sprouts are then free to grow as full trees, forming a “fairy ring” of trees around the initial tree. These trees, in turn, may give rise to more sprouts, and the cycle continues.\r\n\r\nWhy were redwood trees more prominent in the forests of North America millions of years ago?',1,5,0,'2020-02-29 15:34:53.444568','2020-02-29 17:45:13.521720',0,1,1,5,'',0,0),(343,5,NULL,'It was something she had dreamed of since she was five. Finally, after years of training and intensive workouts, Deborah Duffey was going to compete in her first high school basketball game. The goals of becoming an outstanding player and playing college ball were never far from Deborah’s mind.\r\nThe game was against Mills High School. With 1:42 minutes left in the game, Deborah’s team led by one point. A player of Mills had possession of the ball, and Deborah ran to guard against her. As Deborah shuffled sideways to block the player, her knee went out and she collapsed on the court in burning pain. Just like that, Deborah’s season was over.\r\nAfter suffering the bad injury, Deborah found that, for the first time in her life, she was in a situation beyond her control. Game after game, she could do nothing but sit on the sidelines watching others play the game that she loved so much.\r\nInjuries limited Deborah’s time on the court as she hurt her knees three more times in the next five years. She had to spend countless hours in a physical therapy clinic to receive treatment. Her frequent visits there gave her a passion and respect for the profession. And Deborah began to see a new light in her life.\r\nCurrently a senior in college, Deborah focuses on pursuing a degree in physical therapy. After she graduates, Deborah plans to use her knowledge to educate people how to best take care of their bodies\r\nand cope with the feelings of hopelessness that she remembers so well.\r\n\r\nWhat is the best title for this passage?',1,7,0,'2020-02-29 15:39:29.093587','2020-03-16 22:14:39.219206',0,1,1,5,'',0,0),(344,5,NULL,'It is easy for us to tell our friends from our enemies. But can other animals do the same? Elephants\r\ncan! They can use their sense of vision and smell to tell the difference between people who pose a threat and those who do not.\r\nIn Kenya, researchers found that elephants react differently to clothing worn by men of the Maasai and Kamba ethnic groups. Young Maasai men spear animals and thus pose a threat to elephants; Kamba men are mainly farmers and are not a danger to elephants.\r\nIn an experiment conducted by animal scientists, elephants were first presented with clean clothing or clothing that had been worn for five days by either a Maasai or a Kamba man. When the elephants detected the smell of clothing worn by a Maasai man, they moved away from the smell faster and took longer to relax than when they detected the smells of either clothing worn by Kamba men or clothing that had not been worn at all.\r\nGarment color also plays a role, though in a different way. In the same study, when the elephants saw red clothing not worn before, they reacted angrily, as red is typically worn by Maasai men. Rather than running away as they did with the smell, the elephants acted aggressively toward the red clothing.\r\nThe researchers believe that the elephants’ emotional reactions are due to their different interpretations of the smells and the sights. Smelling a potential danger means that a threat is nearby and the best thing to do is run away and hide. Seeing a potential threat without its smell means that risk is low. Therefore, instead of showing fear and running away, the elephants express their anger and become aggressive.\r\n\r\nAccording to the passage, which of the following statements is true about Kamba and Maasai people?',1,6,0,'2020-02-29 15:48:45.946223','2020-02-29 17:45:17.732332',0,1,1,5,'',0,0),(345,5,NULL,'There is a long-held belief that when meeting someone, the more eye contact we have with the\r\nperson, the better. The result is an unfortunate tendency for people making initial contact—in a job interview, for example—to stare fixedly at the other individual. However, this behavior is likely to make the interviewer feel very uncomfortable. Most of us are comfortable with eye contact lasting a few seconds. But eye contact which persists longer than that can make us nervous.\r\nAnother widely accepted belief is that powerful people in a society—often men—show their dominance over others by touching them in a variety of ways. In fact, research shows that in almost all cases, lower-status people initiate touch. Women also initiate touch more often than men do.\r\nThe belief that rapid speech and lying go together is also widespread and enduring. We react strongly—and suspiciously—to fast talk. However, the opposite is a greater cause for suspicion. Speech that is slow, because it is laced with pauses or errors, is a more reliable indicator of lying than the opposite.\r\n\r\nWhich of the following is NOT discussed in the passage?',1,7,0,'2020-02-29 15:55:36.145688','2020-03-16 22:14:39.226580',0,1,1,5,'',0,0),(346,5,NULL,'On the island of New Zealand, there is a grasshopper-like species of insect that is found nowhere else on earth. New Zealanders have given it the nickname weta, which is a native Maori word meaning “god of bad looks.” It’s easy to see why anyone would call this insect a bad-looking bug. Most people feel disgusted at the sight of these bulky, slow-moving creatures.\r\nWetas are nocturnal creatures; they come out of their caves and holes only after dark. A giant weta can grow to over three inches long and weigh as much as 1.5 ounces. Giant wetas can hop up to two feet at a time. Some of them live in trees, and others live in caves. They are very long-lived for insects, and some adult wetas can live as long as two years. Just like their cousins grasshoppers and crickets, wetas are able to “sing” by rubbing their leg parts together, or against their lower bodies.\r\nMost people probably don’t feel sympathy for these endangered creatures, but they do need protecting. The slow and clumsy wetas have been around on the island since the times of the dinosaurs, and have evolved and survived in an environment where they had no enemies until rats came to the island with European immigrants. Since rats love to hunt and eat wetas, the rat population on the island has grown into a real problem for many of the native species that are unaccustomed to its presence, and poses a serious threat to the native weta population.\r\n\r\nWhich of the following descriptions of wetas is accurate?',1,6,0,'2020-02-29 16:42:12.673107','2020-03-16 22:14:39.222141',0,1,1,5,'',0,0),(347,5,NULL,'The high school prom is the first formal social event for most American teenagers. It has also been a\r\nrite of passage for young Americans for nearly a century.\r\nThe word “prom” was first used in the 1890s, referring to formal dances in which the guests of a\r\nparty would display their fashions and dancing skills during the evening’s grand march. In the United States, parents and educators have come to regard the prom as an important lesson in social skills. Therefore, proms have been held every year in high schools for students to learn proper social behavior.\r\nThe first high school proms were held in the 1920s in America. By the 1930s, proms were common across the country. For many older Americans, the prom was a modest, home-grown affair in the school gymnasium. Prom-goers were well dressed but not fancily dressed up for the occasion: boys wore jackets and ties and girls their Sunday dresses. Couples danced to music provided by a local amateur band or a record player. After the 1960s, and especially since the 1980s, the high school prom in many areas has become a serious exercise in excessive consumption, with boys renting expensive tuxedos and girls wearing designer gowns. Stretch limousines were hired to drive the prom-goers to expensive restaurants or discos for an all-night extravaganza.\r\nWhether simple or lavish, proms have always been more or less traumatic events for adolescents who worry about self-image and fitting in with their peers. Prom night can be a dreadful experience for socially awkward teens or for those who do not secure dates. Since the 1990s, alternative proms have been organized in some areas to meet the needs of particular students. For example, proms organized by and for homeless youth were reported. There were also “couple-free” proms to which all students are welcome.\r\n\r\nIn what way are high school proms significant to American teenagers?',1,6,0,'2020-02-29 16:48:27.820614','2020-02-29 17:45:11.681537',0,1,1,5,'',0,0),(348,5,NULL,'Apple Inc. is an American multinational technology company headquartered in Cupertino, California, that designs, develops, and sells consumer electronics, computer software, and online services. It is considered one of the Big Four technology companies, alongside Amazon, Google, and Facebook.\r\n\r\nThe company\'s hardware products include the iPhone smartphone, the iPad tablet computer, the Mac personal computer, the iPod portable media player, the Apple Watch smartwatch, the Apple TV digital media player, the AirPods wireless earbuds and the HomePod smart speaker. Apple\'s software includes the macOS, iOS, iPadOS, watchOS, and tvOS operating systems, the iTunes media player, the Safari web browser, the Shazam acoustic fingerprint utility, and the iLife and iWork creativity and productivity suites, as well as professional applications like Final Cut Pro, Logic Pro, and Xcode. Its online services include the iTunes Store, the iOS App Store, Mac App Store, Apple Music, Apple TV+, iMessage, and iCloud. Other services include Apple Store, Genius Bar, AppleCare, Apple Pay, Apple Pay Cash, and Apple Card.\r\n\r\nwhich of the following product may not offer by Apple?',1,6,0,'2020-02-29 17:43:24.715578','2020-02-29 17:45:19.261592',0,1,1,5,'',0,0),(353,1,'question_files/question_353.mp3',NULL,1,0,0,'2020-03-30 10:12:42.576193','2020-03-30 10:24:07.036262',0,3,6,NULL,'',0,0),(354,1,'question_files/question_354.mp3',NULL,1,0,0,'2020-03-30 10:24:46.397485','2020-03-30 10:25:02.620939',0,3,6,NULL,'',0,0),(355,1,'question_files/question_355.mp3',NULL,1,0,0,'2020-03-30 10:25:36.129900','2020-03-30 10:25:54.811594',0,3,6,NULL,'',0,0),(356,1,'question_files/question_356.mp3',NULL,1,0,0,'2020-03-30 10:26:27.701408','2020-03-30 10:26:47.394044',0,3,6,NULL,'',0,0),(357,1,'question_files/question_357.mp3',NULL,1,0,0,'2020-03-30 10:27:24.463794','2020-03-30 10:27:39.152832',0,3,6,NULL,'',0,0),(358,1,'question_files/question_358.mp3',NULL,1,0,0,'2020-03-30 10:28:23.621289','2020-03-30 10:28:53.237788',0,3,6,NULL,'',0,0),(359,1,'question_files/question_359.mp3',NULL,1,0,0,'2020-03-30 10:29:38.673084','2020-03-30 10:29:53.710939',0,3,6,NULL,'',0,0),(360,1,'question_files/question_360.mp3',NULL,1,0,0,'2020-03-30 10:30:29.360507','2020-03-30 10:30:45.326626',0,3,6,NULL,'',0,0),(361,1,'question_files/question_361.mp3',NULL,1,0,0,'2020-03-30 10:31:31.194595','2020-03-30 10:32:11.042497',0,3,6,NULL,'',0,0),(362,1,'question_files/question_362.mp3',NULL,1,0,0,'2020-03-30 10:32:54.970692','2020-03-30 10:33:13.200453',0,3,6,NULL,'',0,0),(363,1,'question_files/question_363.mp3',NULL,1,0,0,'2020-03-30 10:34:03.525982','2020-03-30 10:34:31.959712',0,3,6,NULL,'',0,0),(364,1,'question_files/question_364.mp3',NULL,1,0,0,'2020-03-30 10:35:09.836305','2020-03-30 10:35:25.187118',0,3,6,NULL,'',0,0),(365,1,'question_files/question_365.mp3',NULL,1,0,0,'2020-03-30 10:36:11.893831','2020-03-30 10:36:35.057711',0,3,6,NULL,'',0,0),(366,1,'question_files/question_366.mp3',NULL,1,0,0,'2020-03-30 10:37:12.334462','2020-03-30 10:37:25.346910',0,3,6,NULL,'',0,0),(367,1,'question_files/question_367.mp3',NULL,1,0,0,'2020-03-30 10:38:21.082850','2020-03-30 10:38:38.905294',0,3,6,NULL,'',0,0),(368,1,'question_files/question_368.mp3',NULL,1,0,0,'2020-03-30 10:39:22.025197','2020-03-30 10:39:41.863617',0,3,6,NULL,'',0,0),(369,1,'question_files/question_369.mp3',NULL,1,0,0,'2020-03-30 10:40:31.809529','2020-03-30 10:40:44.944241',0,3,6,NULL,'',0,0),(370,1,'question_files/question_370.mp3',NULL,1,0,0,'2020-03-30 10:41:26.513213','2020-03-30 10:41:44.940591',0,3,6,NULL,'',0,0),(371,1,'question_files/question_371.mp3',NULL,1,0,0,'2020-03-30 10:42:41.808911','2020-03-30 10:42:57.360360',0,3,6,NULL,'',0,0),(372,1,'question_files/question_372.mp3',NULL,1,0,0,'2020-03-30 10:43:37.757573','2020-03-30 10:43:51.711809',0,3,6,NULL,'',0,0),(373,1,'question_files/question_373.mp3',NULL,1,0,0,'2020-03-30 10:44:41.183476','2020-03-30 10:44:58.315564',0,3,6,NULL,'',0,0),(374,1,'question_files/question_374.mp3',NULL,1,0,0,'2020-03-30 10:45:35.772454','2020-03-30 10:45:51.040799',0,3,6,NULL,'',0,0),(375,1,'question_files/question_375.mp3',NULL,1,0,0,'2020-03-30 10:46:27.705277','2020-03-30 10:46:42.549645',0,3,6,NULL,'',0,0),(376,1,'question_files/question_376.mp3',NULL,1,0,0,'2020-03-30 10:47:33.808315','2020-03-30 10:47:47.795333',0,3,6,NULL,'',0,0),(377,1,'question_files/question_377.mp3',NULL,1,0,0,'2020-03-30 10:48:48.680798','2020-03-30 10:49:10.431317',0,3,6,NULL,'',0,0),(378,1,'question_files/question_378.mp3',NULL,1,0,0,'2020-03-30 10:49:48.323913','2020-03-30 10:50:17.413006',0,3,6,NULL,'',0,0),(379,1,'question_files/question_379.mp3',NULL,1,0,0,'2020-03-30 10:50:53.559730','2020-03-30 10:51:12.086651',0,3,6,NULL,'',0,0),(380,1,'question_files/question_380.mp3',NULL,1,0,0,'2020-03-30 10:53:31.728789','2020-03-30 10:53:43.654725',0,3,6,NULL,'',0,0),(381,1,'question_files/question_381.mp3',NULL,1,0,0,'2020-03-30 10:54:58.584770','2020-03-30 10:55:38.955062',0,3,6,NULL,'',0,0),(382,1,'question_files/question_382.mp3',NULL,1,0,0,'2020-03-30 11:05:40.125707','2020-03-30 11:05:53.119697',0,3,6,NULL,'',0,0),(383,1,'question_files/question_383.mp3',NULL,1,0,0,'2020-03-30 11:10:37.977102','2020-03-30 11:11:09.894887',0,3,6,NULL,'',0,0),(384,1,'question_files/question_384.mp3',NULL,1,0,0,'2020-03-30 11:11:44.874687','2020-03-30 11:11:57.690972',0,3,6,NULL,'',0,0),(385,1,'question_files/question_385.mp3',NULL,1,0,0,'2020-03-30 11:12:36.039738','2020-03-30 11:12:53.238834',0,3,6,NULL,'',0,0),(386,1,'question_files/question_386.mp3',NULL,1,0,0,'2020-03-30 11:13:32.135991','2020-03-30 11:13:46.722863',0,3,6,NULL,'',0,0),(387,1,'question_files/question_387.mp3',NULL,1,0,0,'2020-03-30 11:14:20.944127','2020-03-30 11:14:34.927984',0,3,6,NULL,'',0,0),(388,1,'question_files/question_388.mp3',NULL,1,0,0,'2020-03-30 11:15:20.165403','2020-03-30 11:15:36.639465',0,3,6,NULL,'',0,0),(389,1,'question_files/question_389.mp3',NULL,1,0,0,'2020-03-30 11:16:17.464051','2020-03-30 11:16:31.207444',0,3,6,NULL,'',0,0),(390,1,'question_files/question_390.mp3',NULL,1,0,0,'2020-03-30 11:18:05.646310','2020-03-30 11:18:40.037558',0,3,6,NULL,'',0,0),(391,1,'question_files/question_391.mp3',NULL,1,0,0,'2020-03-30 11:19:20.431982','2020-03-30 11:19:33.862901',0,3,6,NULL,'',0,0),(392,1,'question_files/question_392.mp3',NULL,1,0,0,'2020-03-30 11:20:08.015260','2020-03-30 11:20:19.659781',0,3,6,NULL,'',0,0),(393,1,'question_files/question_393.mp3',NULL,1,0,0,'2020-03-30 11:20:59.030138','2020-03-30 11:21:11.699669',0,3,6,NULL,'',0,0),(394,1,'question_files/question_394.mp3',NULL,1,0,0,'2020-03-30 11:21:46.656070','2020-03-30 11:21:59.661861',0,3,6,NULL,'',0,0),(395,1,'question_files/question_395.mp3',NULL,1,0,0,'2020-03-30 11:22:30.491798','2020-03-30 11:22:45.398043',0,3,6,NULL,'',0,0),(396,1,'question_files/question_396.mp3',NULL,1,0,0,'2020-03-30 11:23:17.495300','2020-03-30 11:23:29.697040',0,3,6,NULL,'',0,0),(397,1,'question_files/question_397.mp3',NULL,1,0,0,'2020-03-30 11:24:02.453217','2020-03-30 11:24:15.988998',0,3,6,NULL,'',0,0),(398,1,'question_files/question_398.mp3',NULL,1,0,0,'2020-03-30 11:24:47.866242','2020-03-30 11:25:00.129503',0,3,6,NULL,'',0,0),(399,1,'question_files/question_399.mp3',NULL,1,0,0,'2020-03-30 11:25:31.887300','2020-03-30 11:25:46.616685',0,3,6,NULL,'',0,0),(400,1,'question_files/question_400.mp3',NULL,1,0,0,'2020-03-30 11:26:19.022679','2020-03-30 11:26:32.425501',0,3,6,NULL,'',0,0),(401,1,'question_files/question_401.mp3',NULL,1,0,0,'2020-03-30 11:27:04.880603','2020-03-30 11:27:16.509442',0,3,6,NULL,'',0,0),(402,1,'question_files/question_402.mp3',NULL,1,0,0,'2020-03-30 11:27:51.983037','2020-03-30 11:28:03.738830',0,3,6,NULL,'',0,0),(403,2,'question_files/question_403.mp3',NULL,1,0,0,'2020-03-30 11:28:51.284568','2020-03-30 11:29:13.609544',0,3,6,NULL,'',0,0),(404,2,'question_files/question_404.mp3',NULL,1,0,0,'2020-03-30 11:29:55.504574','2020-03-30 11:30:20.472267',0,3,6,NULL,'',0,0),(405,2,'question_files/question_405.mp3',NULL,1,0,0,'2020-03-30 11:30:52.760833','2020-03-30 11:31:23.149564',0,3,6,NULL,'',0,0),(406,2,'question_files/question_406.mp3',NULL,1,0,0,'2020-03-30 11:32:02.774159','2020-03-30 11:32:16.361227',0,3,6,NULL,'',0,0),(407,2,'question_files/question_407.mp3',NULL,1,0,0,'2020-03-30 11:32:53.986204','2020-03-30 11:33:09.291073',0,3,6,NULL,'',0,0),(408,2,'question_files/question_408.mp3',NULL,1,0,0,'2020-03-30 11:33:40.291335','2020-03-30 11:35:07.878723',0,3,6,NULL,'',0,0),(409,2,'question_files/question_409.mp3',NULL,1,0,0,'2020-03-30 11:35:51.080545','2020-03-30 11:36:25.658789',0,3,6,NULL,'',0,0),(410,2,'question_files/question_410.mp3',NULL,1,0,0,'2020-03-30 11:37:12.894903','2020-03-30 11:37:30.195754',0,3,6,NULL,'',0,0),(411,2,'question_files/question_411.mp3',NULL,1,0,0,'2020-03-30 11:38:04.832734','2020-03-30 11:38:20.737325',0,3,6,NULL,'',0,0),(412,2,'question_files/question_412.mp3',NULL,1,0,0,'2020-03-30 11:38:54.470786','2020-03-30 11:39:08.677646',0,3,6,NULL,'',0,0),(413,1,'question_files/question_413.mp3',NULL,1,0,0,'2020-04-04 02:25:48.999508','2020-04-04 16:51:57.513443',0,3,6,6,'',0,0),(414,1,'question_files/question_414.mp3',NULL,1,0,0,'2020-04-04 02:26:45.337210','2020-04-04 16:51:30.313113',0,3,6,6,'',0,0),(415,1,'question_files/question_415.mp3',NULL,1,0,0,'2020-04-04 02:27:24.003739','2020-04-04 16:51:03.858101',0,3,6,6,'',0,0),(416,1,'question_files/question_416.mp3',NULL,1,0,0,'2020-04-04 02:27:57.652239','2020-04-04 16:50:38.316905',0,3,6,6,'',0,0),(417,1,'question_files/question_417.mp3',NULL,1,0,0,'2020-04-04 02:28:48.653614','2020-04-04 16:49:47.367011',0,3,6,6,'',0,0),(418,1,'question_files/question_418.mp3',NULL,1,0,0,'2020-04-04 02:29:23.503424','2020-04-04 16:48:20.966736',0,3,6,6,'',0,0),(419,1,'question_files/question_419.mp3',NULL,1,0,0,'2020-04-04 02:30:27.765244','2020-04-04 16:47:47.976072',0,3,6,6,'',0,0),(420,1,'question_files/question_420.mp3',NULL,1,0,0,'2020-04-04 02:30:59.942843','2020-04-04 16:46:53.086532',0,3,6,6,'',0,0),(421,1,'question_files/question_421.mp3',NULL,1,0,0,'2020-04-04 02:31:43.449326','2020-04-04 16:45:35.918983',0,3,6,6,'',0,0),(422,1,'question_files/question_422.mp3',NULL,1,0,0,'2020-04-04 02:32:12.397454','2020-04-04 16:44:49.577224',0,3,6,6,'',0,0),(423,1,'question_files/question_423.mp3',NULL,1,0,0,'2020-04-04 02:32:44.730804','2020-04-04 16:44:18.250121',0,3,6,6,'',0,0),(424,1,'question_files/question_424.mp3',NULL,1,0,0,'2020-04-04 02:33:17.919168','2020-04-04 16:43:53.442850',0,3,6,6,'',0,0),(425,1,'question_files/question_425.mp3',NULL,1,0,0,'2020-04-04 02:33:51.387018','2020-04-04 16:43:22.690587',0,3,6,6,'',0,0),(426,1,'question_files/question_426.mp3',NULL,1,0,0,'2020-04-04 02:34:22.884512','2020-04-04 16:42:57.139529',0,3,6,6,'',0,0),(427,1,'question_files/question_427.mp3',NULL,1,0,0,'2020-04-04 02:34:56.907151','2020-04-04 16:42:26.604349',0,3,6,6,'',0,0),(428,1,'question_files/question_428.mp3',NULL,1,0,0,'2020-04-04 02:37:00.265056','2020-04-04 16:41:48.774641',0,3,6,6,'',0,0),(429,1,'question_files/question_429.mp3',NULL,1,0,0,'2020-04-04 02:37:35.193038','2020-04-04 16:39:55.942483',0,3,6,6,'',0,0),(430,1,'question_files/question_430.mp3',NULL,1,0,0,'2020-04-04 02:38:11.942070','2020-04-04 16:38:55.920911',0,3,6,6,'',0,0),(431,1,'question_files/question_431.mp3',NULL,1,0,0,'2020-04-04 02:38:51.069882','2020-04-04 16:38:27.220728',0,3,6,6,'',0,0),(432,1,'question_files/question_432.mp3',NULL,1,0,0,'2020-04-04 02:39:22.076141','2020-04-04 16:36:54.955818',0,3,6,6,'',0,0),(433,1,'question_files/question_433.mp3',NULL,1,0,0,'2020-04-04 02:39:57.237147','2020-04-04 16:35:51.871127',0,3,6,6,'',0,0),(434,1,'question_files/question_434.mp3',NULL,1,0,0,'2020-04-04 02:40:28.191692','2020-04-04 16:35:13.071234',0,3,6,6,'',0,0),(435,1,'question_files/question_435.mp3',NULL,1,0,0,'2020-04-04 02:41:00.691171','2020-04-04 16:34:16.288459',0,3,6,6,'',0,0),(436,1,'question_files/question_436.mp3',NULL,1,0,0,'2020-04-04 02:41:30.062443','2020-04-04 16:33:50.751095',0,3,6,6,'',0,0),(437,1,'question_files/question_437.mp3',NULL,1,0,0,'2020-04-04 02:42:11.057074','2020-04-04 16:33:10.532042',0,3,6,6,'',0,0),(438,1,'question_files/question_438.mp3',NULL,1,0,0,'2020-04-04 02:42:42.362099','2020-04-04 16:27:49.483727',0,3,6,6,'',0,0),(439,1,'question_files/question_439.mp3',NULL,1,0,0,'2020-04-04 02:43:13.773638','2020-04-04 16:27:21.764810',0,3,6,6,'',0,0),(440,1,'question_files/question_440.mp3',NULL,1,0,0,'2020-04-04 02:43:46.712907','2020-04-04 16:26:16.345535',0,3,6,6,'',0,0),(441,1,'question_files/question_441.mp3',NULL,1,0,0,'2020-04-04 02:44:19.535603','2020-04-04 16:25:43.304034',0,3,6,6,'',0,0),(442,1,'question_files/question_442.mp3',NULL,1,0,0,'2020-04-04 02:44:53.782230','2020-04-04 16:25:19.376055',0,3,6,6,'',0,0),(443,1,'question_files/question_443.mp3',NULL,1,0,0,'2020-04-04 02:45:29.156434','2020-04-04 16:24:52.107407',0,3,6,6,'',0,0),(444,1,'question_files/question_444.mp3',NULL,1,0,0,'2020-04-04 02:46:01.483958','2020-04-04 16:23:33.975814',0,3,6,6,'',0,0),(445,1,'question_files/question_445.mp3',NULL,1,0,0,'2020-04-04 02:46:34.097831','2020-04-04 16:23:07.043613',0,3,6,6,'',0,0),(446,1,'question_files/question_446.mp3',NULL,1,0,0,'2020-04-04 02:47:10.703833','2020-04-04 16:22:30.477004',0,3,6,6,'',0,0),(447,1,'question_files/question_447.mp3',NULL,1,0,0,'2020-04-04 02:48:01.710268','2020-04-04 16:21:49.268165',0,3,6,6,'',0,0),(448,1,'question_files/question_448.mp3',NULL,1,0,0,'2020-04-04 02:48:37.584852','2020-04-04 16:21:20.761055',0,3,6,6,'',0,0),(449,1,'question_files/question_449.mp3',NULL,1,0,0,'2020-04-04 02:49:09.774453','2020-04-04 16:20:48.772908',0,3,6,6,'',0,0),(450,1,'question_files/question_450.mp3',NULL,1,0,0,'2020-04-04 02:49:40.943750','2020-04-04 16:20:22.432025',0,3,6,6,'',0,0),(451,1,'question_files/question_451.mp3',NULL,1,0,0,'2020-04-04 02:50:15.230946','2020-04-04 16:19:56.970358',0,3,6,6,'',0,0),(452,1,'question_files/question_452.mp3',NULL,1,0,0,'2020-04-04 02:50:51.867701','2020-04-04 16:19:03.044880',0,3,6,6,'',0,0),(453,1,'question_files/question_453.mp3',NULL,1,0,0,'2020-04-04 02:51:26.775996','2020-04-04 16:17:03.470392',0,3,6,6,'',0,0),(454,1,'question_files/question_454.mp3',NULL,1,0,0,'2020-04-04 02:52:02.952360','2020-04-04 16:16:24.332496',0,3,6,6,'',0,0),(455,1,'question_files/question_455.mp3',NULL,1,0,0,'2020-04-04 02:52:31.876871','2020-04-04 16:15:57.622564',0,3,6,6,'',0,0),(456,1,'question_files/question_456.mp3',NULL,1,0,0,'2020-04-04 02:53:02.847365','2020-04-04 16:15:32.744428',0,3,6,6,'',0,0),(457,1,'question_files/question_457.mp3',NULL,1,0,0,'2020-04-04 02:53:36.222416','2020-04-04 16:14:57.993386',0,3,6,6,'',0,0),(458,1,'question_files/question_458.mp3',NULL,1,0,0,'2020-04-04 02:54:08.824102','2020-04-04 16:14:22.767477',0,3,6,6,'',0,0),(459,1,'question_files/question_459.mp3',NULL,1,0,0,'2020-04-04 02:54:43.597906','2020-04-04 16:13:36.354452',0,3,6,6,'',0,0),(460,1,'question_files/question_460.mp3',NULL,1,0,0,'2020-04-04 02:55:17.054061','2020-04-04 16:13:10.363891',0,3,6,6,'',0,0),(461,1,'question_files/question_461.mp3',NULL,1,0,0,'2020-04-04 02:55:47.761474','2020-04-04 16:11:44.034720',0,3,6,6,'',0,0),(462,1,'question_files/question_462.mp3',NULL,1,0,0,'2020-04-04 02:56:19.722922','2020-04-04 16:10:58.009189',0,3,6,6,'',0,0),(463,2,'question_files/question_463.mp3',NULL,1,0,0,'2020-04-04 02:56:55.951865','2020-04-04 16:10:04.831887',0,3,6,6,'',0,0),(464,2,'question_files/question_464.mp3',NULL,1,0,0,'2020-04-04 02:57:26.364989','2020-04-04 16:09:03.433682',0,3,6,6,'',0,0),(465,2,'question_files/question_465.mp3',NULL,1,0,0,'2020-04-04 02:57:57.777908','2020-04-04 16:07:57.470282',0,3,6,6,'',0,0),(466,2,'question_files/question_466.mp3',NULL,1,0,0,'2020-04-04 02:58:27.990564','2020-04-04 16:06:59.874450',0,3,6,6,'',0,0),(467,2,'question_files/question_467.mp3',NULL,1,0,0,'2020-04-04 02:59:01.101587','2020-04-04 16:06:06.308298',0,3,6,6,'',0,0),(468,2,'question_files/question_468.mp3',NULL,1,0,0,'2020-04-04 02:59:34.774367','2020-04-04 16:04:46.239144',0,3,6,6,'',0,0),(469,2,'question_files/question_469.mp3',NULL,1,0,0,'2020-04-04 03:00:05.862923','2020-04-04 16:04:00.824038',0,3,6,6,'',0,0),(470,2,'question_files/question_470.mp3',NULL,1,0,0,'2020-04-04 03:00:38.517842','2020-04-04 16:03:18.611100',0,3,6,6,'',0,0),(471,2,'question_files/question_471.mp3',NULL,1,0,0,'2020-04-04 03:01:08.799221','2020-04-04 16:02:33.198873',0,3,6,6,'',0,0),(472,2,'question_files/question_472.mp3',NULL,1,0,0,'2020-04-04 03:01:46.069326','2020-04-04 16:02:05.653612',0,3,6,6,'',0,0),(473,1,'question_files/question_473.mp3',NULL,1,0,0,'2020-04-04 11:45:05.680088','2020-04-04 16:01:19.538152',0,3,6,6,'',0,0),(474,1,'question_files/question_474.mp3',NULL,1,0,0,'2020-04-04 11:45:34.733166','2020-04-04 16:00:50.353489',0,3,6,6,'',0,0),(475,1,'question_files/question_475.mp3',NULL,1,0,0,'2020-04-04 11:46:06.013864','2020-04-04 16:00:02.814097',0,3,6,6,'',0,0),(476,1,'question_files/question_476.mp3',NULL,1,0,0,'2020-04-04 11:46:41.554679','2020-04-04 15:59:38.644130',0,3,6,6,'',0,0),(477,1,'question_files/question_477.mp3',NULL,1,0,0,'2020-04-04 11:47:13.401295','2020-04-04 15:55:32.465613',0,3,6,6,'',0,0),(478,1,'question_files/question_478.mp3',NULL,1,0,0,'2020-04-04 11:47:44.213594','2020-04-04 15:54:44.948311',0,3,6,6,'',0,0),(479,1,'question_files/question_479.mp3',NULL,1,0,0,'2020-04-04 11:48:15.106323','2020-04-04 15:52:47.476517',0,3,6,6,'',0,0),(480,1,'question_files/question_480.mp3',NULL,1,0,0,'2020-04-04 11:48:48.448320','2020-04-04 15:51:43.942609',0,3,6,6,'',0,0),(481,1,'question_files/question_481.mp3',NULL,1,0,0,'2020-04-04 11:49:19.822470','2020-04-04 15:51:11.558559',0,3,6,6,'',0,0),(482,1,'question_files/question_482.mp3',NULL,1,0,0,'2020-04-04 11:49:49.888989','2020-04-04 15:50:39.552700',0,3,6,6,'',0,0),(483,1,'question_files/question_483.mp3',NULL,1,0,0,'2020-04-04 11:50:22.531962','2020-04-04 15:50:11.881504',0,3,6,6,'',0,0),(484,1,'question_files/question_484.mp3',NULL,1,0,0,'2020-04-04 11:50:54.558458','2020-04-04 15:49:11.532383',0,3,6,6,'',0,0),(485,1,'question_files/question_485.mp3',NULL,1,0,0,'2020-04-04 11:51:27.309118','2020-04-04 15:48:41.772239',0,3,6,6,'',0,0),(486,1,'question_files/question_486.mp3',NULL,1,0,0,'2020-04-04 11:51:59.953436','2020-04-04 15:47:38.690949',0,3,6,6,'',0,0),(487,1,'question_files/question_487.mp3',NULL,1,0,0,'2020-04-04 11:52:32.766767','2020-04-04 15:47:02.996952',0,3,6,6,'',0,0),(488,1,'question_files/question_488.mp3',NULL,1,0,0,'2020-04-04 11:53:04.780275','2020-04-04 15:46:34.796525',0,3,6,6,'',0,0),(489,1,'question_files/question_489.mp3',NULL,1,0,0,'2020-04-04 11:53:38.404508','2020-04-04 15:45:51.530310',0,3,6,6,'',0,0),(490,1,'question_files/question_490.mp3',NULL,1,0,0,'2020-04-04 11:54:13.114330','2020-04-04 15:45:23.376544',0,3,6,6,'',0,0),(491,1,'question_files/question_491.mp3',NULL,1,0,0,'2020-04-04 11:54:44.244333','2020-04-04 15:43:58.233270',0,3,6,6,'',0,0),(492,1,'question_files/question_492.mp3',NULL,1,0,0,'2020-04-04 11:55:26.408065','2020-04-04 15:34:15.698227',0,3,6,6,'',0,0),(493,1,'question_files/question_493.mp3',NULL,1,0,0,'2020-04-04 11:55:57.157565','2020-04-04 15:33:51.034062',0,3,6,6,'',0,0),(494,1,'question_files/question_494.mp3',NULL,1,0,0,'2020-04-04 11:56:31.161894','2020-04-04 15:33:18.468395',0,3,6,6,'',0,0),(495,1,'question_files/question_495.mp3',NULL,1,0,0,'2020-04-04 11:56:59.479229','2020-04-04 15:28:56.530090',0,3,6,6,'',0,0),(496,1,'question_files/question_496.mp3',NULL,1,0,0,'2020-04-04 11:57:28.916574','2020-04-04 15:28:31.169275',0,3,6,6,'',0,0),(497,1,'question_files/question_497.mp3',NULL,1,0,0,'2020-04-04 11:57:57.218010','2020-04-04 15:27:51.993906',0,3,6,6,'',0,0),(498,1,'question_files/question_498.mp3',NULL,1,0,0,'2020-04-04 11:58:29.997965','2020-04-04 15:27:11.696729',0,3,6,6,'',0,0),(499,1,'question_files/question_499.mp3',NULL,1,0,0,'2020-04-04 11:58:59.735703','2020-04-04 15:26:40.455532',0,3,6,6,'',0,0),(500,1,'question_files/question_500.mp3',NULL,1,0,0,'2020-04-04 11:59:29.594061','2020-04-04 15:26:08.448849',0,3,6,6,'',0,0),(501,1,'question_files/question_501.mp3',NULL,1,0,0,'2020-04-04 12:00:01.144727','2020-04-04 15:25:30.800668',0,3,6,6,'',0,0),(502,1,'question_files/question_502.mp3',NULL,1,0,0,'2020-04-04 12:00:31.042068','2020-04-04 15:25:03.904490',0,3,6,6,'',0,0),(503,1,'question_files/question_503.mp3',NULL,1,0,0,'2020-04-04 12:01:10.183240','2020-04-04 15:24:32.468416',0,3,6,6,'',0,0),(504,1,'question_files/question_504.mp3',NULL,1,0,0,'2020-04-04 12:01:44.750875','2020-04-04 15:24:04.797515',0,3,6,6,'',0,0),(505,1,'question_files/question_505.mp3',NULL,1,0,0,'2020-04-04 12:02:14.108025','2020-04-04 15:21:38.121004',0,3,6,6,'',0,0),(506,1,'question_files/question_506.mp3',NULL,1,0,0,'2020-04-04 12:02:45.549742','2020-04-04 15:21:03.254304',0,3,6,6,'',0,0),(507,1,'question_files/question_507.mp3',NULL,1,0,0,'2020-04-04 12:03:17.264038','2020-04-04 15:20:24.241095',0,3,6,6,'',0,0),(508,1,'question_files/question_508.mp3',NULL,1,0,0,'2020-04-04 12:03:45.377164','2020-04-04 15:19:41.636181',0,3,6,6,'',0,0),(509,1,'question_files/question_509.mp3',NULL,1,0,0,'2020-04-04 12:04:16.729668','2020-04-04 15:18:22.444084',0,3,6,6,'',0,0),(510,1,'question_files/question_510.mp3',NULL,1,0,0,'2020-04-04 12:04:46.872378','2020-04-04 15:17:26.066925',0,3,6,6,'',0,0),(511,1,'question_files/question_511.mp3',NULL,1,0,0,'2020-04-04 12:05:19.552313','2020-04-04 15:16:56.692269',0,3,6,6,'',0,0),(512,1,'question_files/question_512.mp3',NULL,1,0,0,'2020-04-04 12:05:49.463556','2020-04-04 15:15:47.709607',0,3,6,6,'',0,0),(513,1,'question_files/question_513.mp3',NULL,1,0,0,'2020-04-04 12:06:16.408462','2020-04-04 15:15:08.141985',0,3,6,6,'',0,0),(514,1,'question_files/question_514.mp3',NULL,1,0,0,'2020-04-04 12:06:52.268870','2020-04-04 15:14:20.990258',0,3,6,6,'',0,0),(515,1,'question_files/question_515.mp3',NULL,1,0,0,'2020-04-04 12:07:23.477293','2020-04-04 15:13:35.463337',0,3,6,6,'',0,0),(516,1,'question_files/question_516.mp3',NULL,1,0,0,'2020-04-04 12:07:56.376204','2020-04-04 15:12:41.149531',0,3,6,6,'',0,0),(517,1,'question_files/question_517.mp3',NULL,1,0,0,'2020-04-04 12:08:28.741104','2020-04-04 15:11:53.452082',0,3,6,6,'',0,0),(518,1,'question_files/question_518.mp3',NULL,1,0,0,'2020-04-04 12:09:01.166806','2020-04-04 15:11:10.630794',0,3,6,6,'',0,0),(519,1,'question_files/question_519.mp3',NULL,1,0,0,'2020-04-04 12:09:31.281067','2020-04-04 15:10:18.684100',0,3,6,6,'',0,0),(520,1,'question_files/question_520.mp3',NULL,1,0,0,'2020-04-04 12:09:59.765130','2020-04-04 15:09:24.475889',0,3,6,6,'',0,0),(521,1,'question_files/question_521.mp3',NULL,1,0,0,'2020-04-04 12:10:32.360666','2020-04-04 15:08:54.324045',0,3,6,6,'',0,0),(522,1,'question_files/question_522.mp3',NULL,1,0,0,'2020-04-04 12:11:02.605948','2020-04-04 15:08:00.371152',0,3,6,6,'',0,0),(523,2,'question_files/question_523.mp3',NULL,1,0,0,'2020-04-04 12:11:33.542354','2020-04-04 15:07:13.072014',0,3,6,6,'',0,0),(524,2,'question_files/question_524.mp3',NULL,1,0,0,'2020-04-04 12:12:04.680755','2020-04-04 15:05:00.641169',0,3,6,6,'',0,0),(525,2,'question_files/question_525.mp3',NULL,1,0,0,'2020-04-04 12:12:35.810981','2020-04-04 15:04:19.814574',0,3,6,6,'',0,0),(526,2,'question_files/question_526.mp3',NULL,1,0,0,'2020-04-04 12:13:07.665848','2020-04-04 15:03:35.921124',0,3,6,6,'',0,0),(527,2,'question_files/question_527.mp3',NULL,1,0,0,'2020-04-04 12:13:37.504855','2020-04-04 15:02:51.097617',0,3,6,6,'',0,0),(528,2,'question_files/question_528.mp3',NULL,1,0,0,'2020-04-04 12:14:10.295439','2020-04-04 15:02:13.042685',0,3,6,6,'',0,0),(529,2,'question_files/question_529.mp3',NULL,1,0,0,'2020-04-04 12:14:40.325391','2020-04-04 15:00:47.822866',0,3,6,6,'',0,0),(530,2,'question_files/question_530.mp3',NULL,1,0,0,'2020-04-04 12:15:14.823758','2020-04-04 14:59:42.589002',0,3,6,6,'',0,0),(531,2,'question_files/question_531.mp3',NULL,1,0,0,'2020-04-04 12:15:49.304561','2020-04-04 14:58:55.122065',0,3,6,6,'',0,0),(532,2,'question_files/question_532.mp3',NULL,1,0,0,'2020-04-04 12:16:23.343586','2020-04-04 14:58:12.012163',0,3,6,6,'',0,0),(537,3,'','They have been waiting for me ______ 5 o\'clock.',1,7,0,'2020-04-12 23:42:10.958293','2020-04-12 23:42:10.960979',0,1,1,1,'',0,0);
/*!40000 ALTER TABLE `alcpt_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_question_favorite`
--

DROP TABLE IF EXISTS `alcpt_question_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_question_favorite` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `alcpt_question_favorite_question_id_user_id_c0064f48_uniq` (`question_id`,`user_id`),
  KEY `alcpt_question_favorite_user_id_8d37521c_fk_alcpt_user_id` (`user_id`),
  CONSTRAINT `alcpt_question_favor_question_id_e0108f03_fk_alcpt_que` FOREIGN KEY (`question_id`) REFERENCES `alcpt_question` (`id`),
  CONSTRAINT `alcpt_question_favorite_user_id_8d37521c_fk_alcpt_user_id` FOREIGN KEY (`user_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_question_favorite`
--

LOCK TABLES `alcpt_question_favorite` WRITE;
/*!40000 ALTER TABLE `alcpt_question_favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `alcpt_question_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_reply`
--

DROP TABLE IF EXISTS `alcpt_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_reply` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `created_by_id` int DEFAULT NULL,
  `source_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `alcpt_reply_created_by_id_40250197_fk_alcpt_user_id` (`created_by_id`),
  KEY `alcpt_reply_source_id_0390ee54_fk_alcpt_report_id` (`source_id`),
  CONSTRAINT `alcpt_reply_created_by_id_40250197_fk_alcpt_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `alcpt_user` (`id`),
  CONSTRAINT `alcpt_reply_source_id_0390ee54_fk_alcpt_report_id` FOREIGN KEY (`source_id`) REFERENCES `alcpt_report` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_reply`
--

LOCK TABLES `alcpt_reply` WRITE;
/*!40000 ALTER TABLE `alcpt_reply` DISABLE KEYS */;
INSERT INTO `alcpt_reply` VALUES (1,'經過重新審核之後，這題並沒有問題喔','2020-04-14 15:32:08.540848',7,1),(2,'是這樣嗎？好的。了解了，不好意思麻煩你了＠＠','2020-04-14 15:33:11.683360',1,1),(3,'好的，請問您想要更改為哪種Identity？「Visitor」或「Teacher」','2020-04-15 08:40:25.126216',1,2),(4,'Visitor，謝謝～～','2020-04-15 08:53:28.643181',5,2),(5,'好的，已做好更改。請至個人資料中確認喔！','2020-04-15 08:54:18.226701',1,2);
/*!40000 ALTER TABLE `alcpt_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_report`
--

DROP TABLE IF EXISTS `alcpt_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_report` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_notification` tinyint(1) NOT NULL,
  `staff_notification` tinyint(1) NOT NULL,
  `supplement_note` longtext NOT NULL,
  `state` smallint NOT NULL,
  `created_time` datetime(6) DEFAULT NULL,
  `resolved_time` datetime(6) DEFAULT NULL,
  `category_id` int NOT NULL,
  `created_by_id` int NOT NULL,
  `question_id` int DEFAULT NULL,
  `resolved_by_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `alcpt_report_category_id_108323c9_fk_alcpt_reportcategory_id` (`category_id`),
  KEY `alcpt_report_created_by_id_82b9f434_fk_alcpt_user_id` (`created_by_id`),
  KEY `alcpt_report_question_id_171cd9d9_fk_alcpt_question_id` (`question_id`),
  KEY `alcpt_report_resolved_by_id_4dc90590_fk_alcpt_user_id` (`resolved_by_id`),
  CONSTRAINT `alcpt_report_category_id_108323c9_fk_alcpt_reportcategory_id` FOREIGN KEY (`category_id`) REFERENCES `alcpt_reportcategory` (`id`),
  CONSTRAINT `alcpt_report_created_by_id_82b9f434_fk_alcpt_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `alcpt_user` (`id`),
  CONSTRAINT `alcpt_report_question_id_171cd9d9_fk_alcpt_question_id` FOREIGN KEY (`question_id`) REFERENCES `alcpt_question` (`id`),
  CONSTRAINT `alcpt_report_resolved_by_id_4dc90590_fk_alcpt_user_id` FOREIGN KEY (`resolved_by_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_report`
--

LOCK TABLES `alcpt_report` WRITE;
/*!40000 ALTER TABLE `alcpt_report` DISABLE KEYS */;
INSERT INTO `alcpt_report` VALUES (1,0,0,'這題選項有問題吧',2,'2020-04-14 15:29:52.850218','2020-04-14 15:33:11.686809',3,1,236,NULL),(2,0,0,'我快畢業了，我想更改我的Identity。',3,'2020-04-15 08:23:09.842594','2020-04-15 08:54:20.906961',1,5,NULL,1);
/*!40000 ALTER TABLE `alcpt_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_reportcategory`
--

DROP TABLE IF EXISTS `alcpt_reportcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_reportcategory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `responsibility` smallint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_reportcategory`
--

LOCK TABLES `alcpt_reportcategory` WRITE;
/*!40000 ALTER TABLE `alcpt_reportcategory` DISABLE KEYS */;
INSERT INTO `alcpt_reportcategory` VALUES (1,'帳號問題',32),(2,'成績問題',16),(3,'試題問題',8),(4,'其他',32);
/*!40000 ALTER TABLE `alcpt_reportcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_squadron`
--

DROP TABLE IF EXISTS `alcpt_squadron`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_squadron` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_squadron`
--

LOCK TABLES `alcpt_squadron` WRITE;
/*!40000 ALTER TABLE `alcpt_squadron` DISABLE KEYS */;
INSERT INTO `alcpt_squadron` VALUES (1,'學生一中隊'),(3,'學生三中隊'),(2,'學生二中隊'),(4,'學生四中隊'),(5,'實習旅部');
/*!40000 ALTER TABLE `alcpt_squadron` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_student`
--

DROP TABLE IF EXISTS `alcpt_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stu_id` varchar(50) NOT NULL,
  `grade` smallint unsigned NOT NULL,
  `department_id` int DEFAULT NULL,
  `squadron_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stu_id` (`stu_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `alcpt_student_department_id_257bfbd3_fk_alcpt_department_id` (`department_id`),
  KEY `alcpt_student_squadron_id_4bbcc05a_fk_alcpt_squadron_id` (`squadron_id`),
  CONSTRAINT `alcpt_student_department_id_257bfbd3_fk_alcpt_department_id` FOREIGN KEY (`department_id`) REFERENCES `alcpt_department` (`id`),
  CONSTRAINT `alcpt_student_squadron_id_4bbcc05a_fk_alcpt_squadron_id` FOREIGN KEY (`squadron_id`) REFERENCES `alcpt_squadron` (`id`),
  CONSTRAINT `alcpt_student_user_id_c43c5a79_fk_alcpt_user_id` FOREIGN KEY (`user_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_student`
--

LOCK TABLES `alcpt_student` WRITE;
/*!40000 ALTER TABLE `alcpt_student` DISABLE KEYS */;
INSERT INTO `alcpt_student` VALUES (1,'1090630218',109,1,1,1),(2,'qaz74159',110,1,3,2),(3,'1090630220',109,1,1,7),(4,'1100630220',110,1,3,8),(5,'1100630204',110,1,3,9),(6,'1090630204',109,1,1,10),(7,'1100630224',110,1,3,5),(8,'1090630212',109,1,1,6);
/*!40000 ALTER TABLE `alcpt_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_testpaper`
--

DROP TABLE IF EXISTS `alcpt_testpaper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_testpaper` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `is_testpaper` tinyint(1) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `valid` tinyint(1) NOT NULL,
  `created_by_id` int NOT NULL,
  `is_used` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `alcpt_testpaper_created_by_id_def16d7a_fk_alcpt_user_id` (`created_by_id`),
  CONSTRAINT `alcpt_testpaper_created_by_id_def16d7a_fk_alcpt_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `alcpt_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_testpaper`
--

LOCK TABLES `alcpt_testpaper` WRITE;
/*!40000 ALTER TABLE `alcpt_testpaper` DISABLE KEYS */;
/*!40000 ALTER TABLE `alcpt_testpaper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_testpaper_question_list`
--

DROP TABLE IF EXISTS `alcpt_testpaper_question_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_testpaper_question_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `testpaper_id` int NOT NULL,
  `question_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `alcpt_testpaper_question_testpaper_id_question_id_88653a3a_uniq` (`testpaper_id`,`question_id`),
  KEY `alcpt_testpaper_ques_question_id_980638fa_fk_alcpt_que` (`question_id`),
  CONSTRAINT `alcpt_testpaper_ques_question_id_980638fa_fk_alcpt_que` FOREIGN KEY (`question_id`) REFERENCES `alcpt_question` (`id`),
  CONSTRAINT `alcpt_testpaper_ques_testpaper_id_6848bb19_fk_alcpt_tes` FOREIGN KEY (`testpaper_id`) REFERENCES `alcpt_testpaper` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1144 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_testpaper_question_list`
--

LOCK TABLES `alcpt_testpaper_question_list` WRITE;
/*!40000 ALTER TABLE `alcpt_testpaper_question_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `alcpt_testpaper_question_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alcpt_user`
--

DROP TABLE IF EXISTS `alcpt_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alcpt_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `reg_id` varchar(50) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `gender` smallint unsigned DEFAULT NULL,
  `identity` smallint unsigned DEFAULT NULL,
  `privilege` smallint unsigned NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `email_is_verified` tinyint(1) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `introduction` longtext,
  `photo` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reg_id` (`reg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alcpt_user`
--

LOCK TABLES `alcpt_user` WRITE;
/*!40000 ALTER TABLE `alcpt_user` DISABLE KEYS */;
INSERT INTO `alcpt_user` VALUES (1,'pbkdf2_sha256$180000$oTBTGig3RK5k$FhXD0UVPuiTiM+u6BsWeJA4pis6KlnTCIPlN6Z4b/2Q=','Maxium1997','蘇典煒',1,2,59,'wei860925@gmail.com',1,'2020-04-27 10:21:05.554946','2019-10-15 12:44:32.551000','2020-04-27 10:21:05.545087','1090630218\r\nNational Defense University\r\nInformation Management','photos/Maxium1997_IMG_9559.jpg'),(2,'pbkdf2_sha256$36000$TUIs91DOxZeV$E1ZIH0SMU7b5RXdihn2uuskQvEsXbzPT1Q1nsXlAULM=','qaz74159','黃柏豪',1,2,63,'qaz74159@yahoo.com.tw',0,'2020-04-16 09:46:50.482867','2020-02-11 13:02:52.789648',NULL,NULL,''),(4,'pbkdf2_sha256$180000$pSz5ws6jqokY$ElB2cOb0dAXOVhZS7qBWBwk5Iv4uAgL0zDBcK2xkQvE=','mcndu0001','袁葆宏',1,3,2,'max_yuan_i@gmail.com',0,'2020-04-16 09:19:50.836809','2020-02-11 14:47:59.132463','2020-04-16 09:19:50.834488',NULL,''),(5,'pbkdf2_sha256$216000$iXDJtOXY1TDu$vuITuhj1A2HI/j4e2qEN6COMxG2uBUboi0x8U+rXDG8=','joy9517538246','劉昀昕',2,2,63,'joy9517538246@gmail.com',0,'2020-09-24 11:39:30.694301','2020-02-12 13:07:00.411616','2020-09-24 11:38:56.864932','MCNDU','photos/joy9517538246_profile_photo_D9JMebf.jpg'),(6,'pbkdf2_sha256$180000$qZyeHIu6TwYz$VR6qvUuvuHudtKxKDpWOrR+jkI0CRNDOAmTX+AiH914=','TonyChen9305','陳信綸',1,2,4,'gmvup4xjp6@gmail.com',0,'2020-04-16 09:48:03.188463','2020-02-12 13:12:58.230412','2020-04-15 22:15:15.481541',NULL,''),(7,'pbkdf2_sha256$180000$mGWgaVkhdl5T$w2Ae2vzEAXxUSJUm0ZqlI6+x+sP8/WPRrUvZhg0F/HQ=','smile100226','傅晴俞',2,2,8,'smile100226@gmail.com',0,'2020-04-16 09:50:50.195881','2020-02-12 13:16:21.354390','2020-04-16 09:50:50.193535',NULL,''),(8,'pbkdf2_sha256$180000$1lFO00qItmwO$RKtFjJaOH4wd03XER5Kqs5e8cCGC0aktwcaRf8CFFeM=','mayou66321','賴昱婷',2,2,63,'mayou66321@gmail.com',0,'2020-04-16 09:54:43.196971','2020-02-14 13:24:38.246472','2020-04-16 09:54:43.195055',NULL,''),(9,'pbkdf2_sha256$180000$X0wAOCZWRMK6$cdJaK4WPHfDm9GjI5Y5+cuDKLeUB+PBJTuntphfm/4Y=','1100630204','黃子祐',1,2,63,'zi_you_huang@gmail.com',0,'2020-04-16 09:57:09.804213','2020-02-14 13:25:18.142812','2020-04-16 09:57:09.802422',NULL,''),(10,'pbkdf2_sha256$180000$UxGqLrZnZSDU$5N60fls8VBBuQcJW2vh3Te8LaMGk9Dzrux7m8mm2VUY=','terry90209','楊家齊',1,2,16,'terry90209@gmail.com',0,'2020-04-16 09:50:20.857451','2020-03-18 15:31:27.930608','2020-04-16 09:50:20.854515','','');
/*!40000 ALTER TABLE `alcpt_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audio_file`
--

DROP TABLE IF EXISTS `audio_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audio_file` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `audio_file` varchar(100) NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
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
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
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
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
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
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add user',6,'add_user'),(17,'Can change user',6,'change_user'),(18,'Can delete user',6,'delete_user'),(19,'Can add answer',7,'add_answer'),(20,'Can change answer',7,'change_answer'),(21,'Can delete answer',7,'delete_answer'),(22,'Can add answer sheet',8,'add_answersheet'),(23,'Can change answer sheet',8,'change_answersheet'),(24,'Can delete answer sheet',8,'delete_answersheet'),(25,'Can add choice',9,'add_choice'),(26,'Can change choice',9,'change_choice'),(27,'Can delete choice',9,'delete_choice'),(28,'Can add department',10,'add_department'),(29,'Can change department',10,'change_department'),(30,'Can delete department',10,'delete_department'),(31,'Can add exam',11,'add_exam'),(32,'Can change exam',11,'change_exam'),(33,'Can delete exam',11,'delete_exam'),(34,'Can add group',12,'add_group'),(35,'Can change group',12,'change_group'),(36,'Can delete group',12,'delete_group'),(37,'Can add option list',13,'add_optionlist'),(38,'Can change option list',13,'change_optionlist'),(39,'Can delete option list',13,'delete_optionlist'),(40,'Can add proclamation',14,'add_proclamation'),(41,'Can change proclamation',14,'change_proclamation'),(42,'Can delete proclamation',14,'delete_proclamation'),(43,'Can add question',15,'add_question'),(44,'Can change question',15,'change_question'),(45,'Can delete question',15,'delete_question'),(46,'Can add report',16,'add_report'),(47,'Can change report',16,'change_report'),(48,'Can delete report',16,'delete_report'),(49,'Can add report category',17,'add_reportcategory'),(50,'Can change report category',17,'change_reportcategory'),(51,'Can delete report category',17,'delete_reportcategory'),(52,'Can add squadron',18,'add_squadron'),(53,'Can change squadron',18,'change_squadron'),(54,'Can delete squadron',18,'delete_squadron'),(55,'Can add student',19,'add_student'),(56,'Can change student',19,'change_student'),(57,'Can delete student',19,'delete_student'),(58,'Can add test paper',20,'add_testpaper'),(59,'Can change test paper',20,'change_testpaper'),(60,'Can delete test paper',20,'delete_testpaper'),(61,'Can add captcha store',21,'add_captchastore'),(62,'Can change captcha store',21,'change_captchastore'),(63,'Can delete captcha store',21,'delete_captchastore'),(64,'Can add testee list',22,'add_testeelist'),(65,'Can change testee list',22,'change_testeelist'),(66,'Can delete testee list',22,'delete_testeelist'),(67,'Can add reply',23,'add_reply'),(68,'Can change reply',23,'change_reply'),(69,'Can delete reply',23,'delete_reply'),(70,'Can view log entry',1,'view_logentry'),(71,'Can view permission',2,'view_permission'),(72,'Can view group',3,'view_group'),(73,'Can view content type',4,'view_contenttype'),(74,'Can view session',5,'view_session'),(75,'Can view user',6,'view_user'),(76,'Can view answer',7,'view_answer'),(77,'Can view answer sheet',8,'view_answersheet'),(78,'Can view choice',9,'view_choice'),(79,'Can view department',10,'view_department'),(80,'Can view exam',11,'view_exam'),(81,'Can view group',12,'view_group'),(82,'Can view proclamation',14,'view_proclamation'),(83,'Can view question',15,'view_question'),(84,'Can view report',16,'view_report'),(85,'Can view report category',17,'view_reportcategory'),(86,'Can view squadron',18,'view_squadron'),(87,'Can view student',19,'view_student'),(88,'Can view test paper',20,'view_testpaper'),(89,'Can view testee list',22,'view_testeelist'),(90,'Can view reply',23,'view_reply'),(91,'Can view captcha store',21,'view_captchastore'),(92,'Can add notification',24,'add_notification'),(93,'Can change notification',24,'change_notification'),(94,'Can delete notification',24,'delete_notification'),(95,'Can view notification',24,'view_notification'),(96,'Can add dash app',25,'add_dashapp'),(97,'Can change dash app',25,'change_dashapp'),(98,'Can delete dash app',25,'delete_dashapp'),(99,'Can view dash app',25,'view_dashapp'),(100,'Can add stateless app',26,'add_statelessapp'),(101,'Can change stateless app',26,'change_statelessapp'),(102,'Can delete stateless app',26,'delete_statelessapp'),(103,'Can view stateless app',26,'view_statelessapp');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
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
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
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
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
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
  `id` int NOT NULL AUTO_INCREMENT,
  `challenge` varchar(32) NOT NULL,
  `response` varchar(32) NOT NULL,
  `hashkey` varchar(40) NOT NULL,
  `expiration` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashkey` (`hashkey`)
) ENGINE=InnoDB AUTO_INCREMENT=404 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captcha_captchastore`
--

LOCK TABLES `captcha_captchastore` WRITE;
/*!40000 ALTER TABLE `captcha_captchastore` DISABLE KEYS */;
INSERT INTO `captcha_captchastore` VALUES (403,'BRLH','brlh','964f4fa76e9c1371db45745e5ee44e190e7515cf','2020-09-24 11:43:45.907214');
/*!40000 ALTER TABLE `captcha_captchastore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
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
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(7,'alcpt','answer'),(8,'alcpt','answersheet'),(9,'alcpt','choice'),(10,'alcpt','department'),(11,'alcpt','exam'),(12,'alcpt','group'),(24,'alcpt','notification'),(13,'alcpt','optionlist'),(14,'alcpt','proclamation'),(15,'alcpt','question'),(23,'alcpt','reply'),(16,'alcpt','report'),(17,'alcpt','reportcategory'),(18,'alcpt','squadron'),(19,'alcpt','student'),(22,'alcpt','testeelist'),(20,'alcpt','testpaper'),(6,'alcpt','user'),(3,'auth','group'),(2,'auth','permission'),(21,'captcha','captchastore'),(4,'contenttypes','contenttype'),(25,'django_plotly_dash','dashapp'),(26,'django_plotly_dash','statelessapp'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-02-11 12:55:28.154105'),(2,'alcpt','0001_initial','2020-02-11 12:55:29.436003'),(3,'admin','0001_initial','2020-02-11 12:55:29.523835'),(4,'admin','0002_logentry_remove_auto_add','2020-02-11 12:55:29.551044'),(5,'contenttypes','0002_remove_content_type_name','2020-02-11 12:55:29.627345'),(6,'auth','0001_initial','2020-02-11 12:55:29.799531'),(7,'auth','0002_alter_permission_name_max_length','2020-02-11 12:55:29.834748'),(8,'auth','0003_alter_user_email_max_length','2020-02-11 12:55:29.852611'),(9,'auth','0004_alter_user_username_opts','2020-02-11 12:55:29.861920'),(10,'auth','0005_alter_user_last_login_null','2020-02-11 12:55:29.871194'),(11,'auth','0006_require_contenttypes_0002','2020-02-11 12:55:29.873803'),(12,'auth','0007_alter_validators_add_error_messages','2020-02-11 12:55:29.887929'),(13,'auth','0008_alter_user_username_max_length','2020-02-11 12:55:29.896072'),(14,'captcha','0001_initial','2020-02-11 12:55:29.918277'),(15,'sessions','0001_initial','2020-02-11 12:55:29.945620'),(16,'alcpt','0002_auto_20200211_1457','2020-02-11 14:57:20.133290'),(17,'alcpt','0002_auto_20200212_2312','2020-02-12 23:13:10.729115'),(18,'alcpt','0003_testpaper_is_used','2020-02-12 23:32:05.156396'),(19,'alcpt','0004_auto_20200214_0950','2020-02-14 09:50:44.665963'),(20,'alcpt','0005_auto_20200216_0016','2020-02-18 11:44:28.056102'),(21,'alcpt','0006_remove_question_used_freq','2020-02-18 11:44:28.218210'),(22,'alcpt','0007_auto_20200219_0102','2020-02-19 01:02:20.889312'),(23,'alcpt','0008_auto_20200220_0855','2020-02-20 08:55:12.109729'),(24,'alcpt','0009_auto_20200223_0054','2020-02-23 00:54:56.335952'),(25,'alcpt','0010_user_introduction','2020-02-24 01:48:36.068849'),(26,'alcpt','0011_auto_20200228_0224','2020-02-28 02:24:43.896742'),(27,'alcpt','0012_user_photo','2020-03-02 11:23:51.184589'),(28,'admin','0003_logentry_add_action_flag_choices','2020-03-06 00:28:02.820436'),(29,'auth','0009_alter_user_last_name_max_length','2020-03-06 00:28:02.858645'),(30,'auth','0010_alter_group_name_max_length','2020-03-06 00:28:02.935353'),(31,'auth','0011_update_proxy_permissions','2020-03-06 00:28:02.962196'),(32,'alcpt','0013_exam_testeelist','2020-03-12 00:41:54.833163'),(33,'alcpt','0014_delete_testeelist','2020-03-12 00:41:54.982885'),(34,'alcpt','0015_notification','2020-03-17 19:04:42.665041'),(35,'alcpt','0015_auto_20200318_0845','2020-03-18 08:45:45.492761'),(36,'alcpt','0016_auto_20200318_1708','2020-03-19 01:08:23.122393'),(37,'alcpt','0017_auto_20200319_0108','2020-03-19 01:08:23.212788'),(38,'auth','0012_alter_user_first_name_max_length','2020-09-24 11:36:35.280240'),(39,'django_plotly_dash','0001_initial','2020-09-24 11:36:35.324549'),(40,'django_plotly_dash','0002_add_examples','2020-09-24 11:36:35.344285'),(41,'alcpt','0002_auto_20200924_1137','2020-09-24 11:37:25.837784');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_plotly_dash_dashapp`
--

DROP TABLE IF EXISTS `django_plotly_dash_dashapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_plotly_dash_dashapp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `instance_name` varchar(100) NOT NULL,
  `slug` varchar(110) NOT NULL,
  `base_state` longtext NOT NULL,
  `creation` datetime(6) NOT NULL,
  `update` datetime(6) NOT NULL,
  `save_on_change` tinyint(1) NOT NULL,
  `stateless_app_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `instance_name` (`instance_name`),
  UNIQUE KEY `slug` (`slug`),
  KEY `django_plotly_dash_d_stateless_app_id_220444de_fk_django_pl` (`stateless_app_id`),
  CONSTRAINT `django_plotly_dash_d_stateless_app_id_220444de_fk_django_pl` FOREIGN KEY (`stateless_app_id`) REFERENCES `django_plotly_dash_statelessapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_plotly_dash_dashapp`
--

LOCK TABLES `django_plotly_dash_dashapp` WRITE;
/*!40000 ALTER TABLE `django_plotly_dash_dashapp` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_plotly_dash_dashapp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_plotly_dash_statelessapp`
--

DROP TABLE IF EXISTS `django_plotly_dash_statelessapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_plotly_dash_statelessapp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_name` varchar(100) NOT NULL,
  `slug` varchar(110) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_name` (`app_name`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_plotly_dash_statelessapp`
--

LOCK TABLES `django_plotly_dash_statelessapp` WRITE;
/*!40000 ALTER TABLE `django_plotly_dash_statelessapp` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_plotly_dash_statelessapp` ENABLE KEYS */;
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
INSERT INTO `django_session` VALUES ('00be7hpe2kbt6ou9tooaep5vxc6m9hna','NjRiMzliZGY5YTg2ZDI3ZTE4YTFkODViMGRhMzE0ZDhjODRkNTRmOTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyN2MzNWRlNzNjMzZhODcxNzQ4OWNhMzlmZGQ5M2Y1ZGQyNDEzNTFmIn0=','2020-04-01 16:20:28.787148'),('0k13tzrw24accqvha1sfhtn76071ww84','YzRjMWQ0MzY2OWI1MzMyZGQ5Mjc5MGQ5N2Y4MzUyZWVkMDhiN2YzMjp7Il9hdXRoX3VzZXJfaWQiOiIxNiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMjdhODE1NDdhZDFmNzIxMzU1NjJkOGRiNDFlYjA5Y2Y1MDUxZTU5MSJ9','2020-04-28 11:08:17.700032'),('0xxern4lu45f75ta06ldxrf7j72ou1ba','.eJxVjMEOwiAQRP-FsyFLKMJ69O43kAUWqRpISnsy_rs06UEPk0zmzcxbeNrW4rfOi5-TuAgjTr9ZoPjkuoP0oHpvMra6LnOQe0UetMtbS_y6Ht2_g0K9jHWEM2sAZM7oMiNaIONIZ4cMIdnIwzqDaihpZ3SYGLIzGVXQVk3i8wXrTzen:1kLI5w:WKTtIy0YIw3Iowy4TJ53Nrob0THYaqXEM2f-6_blFO0','2020-10-08 11:38:56.867290'),('10mp5574oxf8eq4egr1wvoqwpsgwfl54','NjZiYTM5NzNiNDUwNzk4NDgyMWRjZTBhNzliZDQ3N2RlZmU4ZTViNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmY2RiNzE3NTNiZmE1OGEyYTVjYjBlYTZkMWIzYmE4NjM5ODgxNjMxIn0=','2020-03-18 19:58:36.227155'),('2stzviqbmsosxnu9uzw7n6kfaz9t6mop','ZTIyY2QxNDIzNjcxMzVhYTNkMGRlMmJmZGY1YTI3OTFmMjNmNmMzYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzMWQ4MzMxOGM2ZDlkODM2YzE1NTVmYmU5ZWJiZWIwODdmYTI3OWUzIn0=','2020-02-27 16:35:15.282861'),('4tmw6r9ziyzln7ofu70o1k0433h9xjq4','ZWY5NTQ4NDgyNWZiMDYwNDBhMmJlMjlhOGZjZGE3MDA4YTc5OWMyMDp7Il9hdXRoX3VzZXJfaWQiOiI2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3ZjNlYzc0YWY1MWRjNWRjZmFmZTJiMjFkMzYwZGE2Y2Q2YWE1ZTIwIn0=','2020-04-12 23:58:49.739580'),('7g5gt377if0wratijhgqstk9p76lhacq','ZjNiZmNiYzAxOWZkNzdhZDk1MmYyOGQzOWQ3ZmJiOWNmZDg0OWQ4Yzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzNmUyY2NmMjJlOTE1MDBkZTdmNmRjY2QyMWM5Y2Q4NTliMjI3YTIwIn0=','2020-03-16 16:39:20.849575'),('a3d2ulqe9nfz1i8zsxt02o13gebszblt','ZjNiZmNiYzAxOWZkNzdhZDk1MmYyOGQzOWQ3ZmJiOWNmZDg0OWQ4Yzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzNmUyY2NmMjJlOTE1MDBkZTdmNmRjY2QyMWM5Y2Q4NTliMjI3YTIwIn0=','2020-03-16 10:26:33.142668'),('aank85e5rogr0xd4zzz5udn6bw81ij5l','OTEwOTA3ODQzOWFiM2QwZGRkMDUwN2Q0YWMwNjM5NTU0MDkyZTExYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwYjU1ZGY4ZjdlMzhiNjRkMDVkM2M4MTMyZDZlODRiZTVkMTAyYWFmIn0=','2020-05-11 10:21:05.558514'),('cxvn7gyxsu80agryf0k2hyi4js62nuqr','OTEwOTA3ODQzOWFiM2QwZGRkMDUwN2Q0YWMwNjM5NTU0MDkyZTExYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwYjU1ZGY4ZjdlMzhiNjRkMDVkM2M4MTMyZDZlODRiZTVkMTAyYWFmIn0=','2020-04-30 09:57:36.865305'),('da8qatewgj3o7iz7umr7xogrcpx4w5dd','OTEwOTA3ODQzOWFiM2QwZGRkMDUwN2Q0YWMwNjM5NTU0MDkyZTExYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwYjU1ZGY4ZjdlMzhiNjRkMDVkM2M4MTMyZDZlODRiZTVkMTAyYWFmIn0=','2020-04-02 01:10:37.935014'),('e4g29i9bcmnw3sqh8oejqhgk4bd7lkd5','ZjdiYzQ2MWZhNzIyMTU1YjE1MTFlYTJiYTZmN2VkMjk1MWFjYmQxMDp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmNTAzYjQyNzdmMTc2NjMzZjg5Nzk0YTRmNWY4N2VlMTgzOGRjMWE1In0=','2020-04-20 22:31:42.278008'),('flibkl1869ftlhzdtdvzfgg7og1exp02','ZTIyY2QxNDIzNjcxMzVhYTNkMGRlMmJmZGY1YTI3OTFmMjNmNmMzYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzMWQ4MzMxOGM2ZDlkODM2YzE1NTVmYmU5ZWJiZWIwODdmYTI3OWUzIn0=','2020-03-09 10:03:41.905289'),('gnt1lppycz8z2v0p6ch1tttq94iborq2','MmMzMzBlMDA2MjE5MmRiZGJjNzIyMWNjZTBjY2RlMmVlNWMyYzYzODp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmMmVkNjlmMzdlOGQwYmRlYjk1MWI0ZGYwZWVkYjc5OTkxYTlhMjljIn0=','2020-02-26 00:55:55.517976'),('j1d0um7489keat0wn42pb4ore19fpw7x','ZWY5NTQ4NDgyNWZiMDYwNDBhMmJlMjlhOGZjZGE3MDA4YTc5OWMyMDp7Il9hdXRoX3VzZXJfaWQiOiI2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3ZjNlYzc0YWY1MWRjNWRjZmFmZTJiMjFkMzYwZGE2Y2Q2YWE1ZTIwIn0=','2020-04-29 22:15:15.486029'),('mb43m678gya5be2qiovq7gozzry16b2p','ZjNiZmNiYzAxOWZkNzdhZDk1MmYyOGQzOWQ3ZmJiOWNmZDg0OWQ4Yzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzNmUyY2NmMjJlOTE1MDBkZTdmNmRjY2QyMWM5Y2Q4NTliMjI3YTIwIn0=','2020-03-16 16:18:44.410010'),('mggmzfjyy58cm334ch9ubs34xl7prbio','NjZiYTM5NzNiNDUwNzk4NDgyMWRjZTBhNzliZDQ3N2RlZmU4ZTViNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmY2RiNzE3NTNiZmE1OGEyYTVjYjBlYTZkMWIzYmE4NjM5ODgxNjMxIn0=','2020-03-18 20:24:33.063765'),('nabun9yq5v1b14pb8c7lsofkfk7100eg','ZjNiZmNiYzAxOWZkNzdhZDk1MmYyOGQzOWQ3ZmJiOWNmZDg0OWQ4Yzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzNmUyY2NmMjJlOTE1MDBkZTdmNmRjY2QyMWM5Y2Q4NTliMjI3YTIwIn0=','2020-03-17 20:36:56.194636'),('qd8ir1ggzn0gsviulku0ja6fhun4ruz0','NjZiYTM5NzNiNDUwNzk4NDgyMWRjZTBhNzliZDQ3N2RlZmU4ZTViNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmY2RiNzE3NTNiZmE1OGEyYTVjYjBlYTZkMWIzYmE4NjM5ODgxNjMxIn0=','2020-03-18 20:13:43.094693'),('tcvqk2gx6h4hem5e9zvetchi5s5r8lrc','OTEwOTA3ODQzOWFiM2QwZGRkMDUwN2Q0YWMwNjM5NTU0MDkyZTExYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwYjU1ZGY4ZjdlMzhiNjRkMDVkM2M4MTMyZDZlODRiZTVkMTAyYWFmIn0=','2020-04-24 08:12:23.224556'),('v829p49eq1fotkzwf19hc7iv411v7el5','OTEwOTA3ODQzOWFiM2QwZGRkMDUwN2Q0YWMwNjM5NTU0MDkyZTExYzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwYjU1ZGY4ZjdlMzhiNjRkMDVkM2M4MTMyZDZlODRiZTVkMTAyYWFmIn0=','2020-05-05 20:57:56.513253'),('yubs6nefayz2wfof5ng1hoat6qge53kz','NjZiYTM5NzNiNDUwNzk4NDgyMWRjZTBhNzliZDQ3N2RlZmU4ZTViNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmY2RiNzE3NTNiZmE1OGEyYTVjYjBlYTZkMWIzYmE4NjM5ODgxNjMxIn0=','2020-03-18 13:51:42.386922'),('z3elbd8e2233fftjfaen22cyclpc1iu3','ZTIyY2QxNDIzNjcxMzVhYTNkMGRlMmJmZGY1YTI3OTFmMjNmNmMzYTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzMWQ4MzMxOGM2ZDlkODM2YzE1NTVmYmU5ZWJiZWIwODdmYTI3OWUzIn0=','2020-02-28 13:20:20.652045');
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

-- Dump completed on 2020-09-24 11:41:21
