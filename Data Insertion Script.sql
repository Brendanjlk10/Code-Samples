-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: book_fetch_inc
-- ------------------------------------------------------
-- Server version	5.7.21-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book` (
  `ISBN_13` varchar(15) NOT NULL,
  `purchase_type` enum('rent','buy') NOT NULL,
  `book_condition` enum('new','old') NOT NULL,
  `the_format` enum('hardcover','paperback','electronic') NOT NULL,
  `price` decimal(9,2) DEFAULT NULL,
  `title` varchar(500) NOT NULL,
  `quantity` smallint(6) NOT NULL,
  `the_language` varchar(100) DEFAULT NULL,
  `publish_date` char(4) DEFAULT NULL,
  `ISBN` varchar(11) DEFAULT NULL,
  `publisher` varchar(100) DEFAULT NULL,
  `edition_num` smallint(6) NOT NULL,
  `weight` smallint(6) DEFAULT NULL,
  `total_purchases` smallint(6) DEFAULT NULL,
  `average_rating` double DEFAULT NULL,
  `category` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ISBN_13`,`purchase_type`,`book_condition`,`the_format`),
  KEY `purchased_books` (`total_purchases`),
  KEY `book_category` (`category`),
  KEY `book_title` (`title`),
  KEY `book_rating` (`average_rating`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES ('978-0307743657','buy','old','paperback',10.00,'The shining',10,'English','2012','1476444387','Anchor',3,0,0,NULL,'Fiction'),('978-0321558237','buy','new','hardcover',3.45,'Acrylic Painting Step by Step: Discover all the basics and a range of special techniques for creating your own masterpieces in acrylic',10,'English','2009','321558235','Benjamin Cummings',9,0,0,NULL,'Visual Arts'),('978-0470080245','buy','old','hardcover',117.00,'Rocket Propulsion Elements',30,'English','2010','9470080248','Wiley',8,4,0,NULL,'Mechanical Engineering'),('978-10529296110','rent','new','hardcover',25.00,'McGraw-Hill Handbook of English Grammar and Usage',2,'English','2002','10948949305','Benjamin Cummings',5,1,0,NULL,'English'),('978-11663489207','rent','new','paperback',19.00,'English Made Easy Volume One: Learning English through Pictures',4,'English','2002','12129770535','Worth Publishers',5,1,0,NULL,'English Language Institute'),('978-12797682304','rent','new','paperback',20.33,'A Conceptual Approach to the Mekilta',6,'English','2002','13310591765','Mosby',5,2,0,NULL,'Judaic Studies'),('978-13931875401','rent','old','paperback',19.83,'The New Politics of Old Age Policy',3,'English','2002','14491412995','Plume',4,1,0,NULL,'Management of Aging Services'),('978-13931875402','buy','new','paperback',41.00,'Music in Ancient Greece and Rome',29,'English','2001','19568944284','McDougal Littel',1,2,0,NULL,'Music'),('978-1455751334','buy','new','hardcover',78.54,'Applied Econometrics',20,'English','2008','1502379465','Saunders',8,0,0,NULL,'Business Technology Administration'),('978-1476770383','buy','new','paperback',24.00,'Revival: A Novel',30,'English','2014','1476770387','Scribner',1,1,0,NULL,'Fiction'),('978-15066068498','rent','old','paperback',13.00,'linear algebra',4,'English','2002','15672234225','Saunders',4,0,1,NULL,'Mathematics and Statistics'),('978-1563477799','buy','new','hardcover',67.00,'Elements of Propulsion: Gas Turbines and Rockets',30,'English','2006','1563477793','Aiaa',4,4,0,NULL,'Mechanical Engineering'),('978-1592575121','buy','new','hardcover',54.00,'The Humongous Book of linear algebra Problems',26,'English','2007','1592575129','ALPHA',1,3,0,NULL,'Mathematics and Statistics'),('978-16200261595','rent','old','paperback',17.00,'Understanding Flight',3,'English','2001','16853055455','Touchstone',4,0,0,NULL,'Mechanical Engineering'),('978-17334454692','rent','old','paperback',20.00,'Fearless Editing: Crafting Words and Images for Print, Web, and Public Relations',2,'English','1993','18033876685','Benjamin Cummings',4,1,0,NULL,'Media and Communication Studies'),('978-18468647789','rent','old','paperback',20.00,'Understanding Intercultural Communication',6,'English','1996','19214697915','Jerry Wyant',4,0,1,NULL,'Modern Languages, Linguistics and Intercultural Communication'),('978-19602840886','rent','old','paperback',20.00,'The Development of Western Music: A History',3,'English','1987','20395519145','Mosby',6,0,0,3.5,'Music'),('978-20737033983','rent','old','paperback',20.00,'Ancient Greek Philosophy: From the Presocratics to the Hellenistic Philosophers',2,'English','1995','21576340375','Benjamin Cummings',3,0,0,NULL,'Philosophy'),('978-21871227080','rent','old','paperback',20.00,'Pearson Textbook Reader: Reading in Applied and Academic Fields',3,'English','1990','22757161605','McDougal Littel',3,1,2,NULL,'Pre-Allied Health'),('978-23005420177','buy','old','electronic',45.00,'Sociology: A Brief Introduction',2,'English','1993','23937982835','Amazon Digital Services, Inc.',3,0,0,NULL,'Pre-Law'),('978-24139613274','buy','old','electronic',78.00,'Guyton and Hall Textbook of Medical Physiology',4,'English','1999','25118804065','Amazon Digital Services, Inc.',3,0,1,NULL,'Pre-Medicine and Pre-Dentistry'),('978-25273806371','buy','old','electronic',56.00,'Psychology',7,'English','2005','26299625295','Amazon Digital Services, Inc.',3,0,3,NULL,'Psychology'),('978-2589944431','buy','new','hardcover',90.00,'Organic Chemistry',15,'English','1967','2683200695','McDougal Littel',1,1,0,NULL,'Chemical, Biochemical & Environmental Engineering'),('978-26407999468','buy','old','electronic',98.00,'Christianity 101: A Textbook of Catholic Theology',8,'English','2001','27480446525','Amazon Digital Services, Inc.',2,0,0,NULL,'Religious Studies'),('978-27542192565','buy','old','electronic',34.00,'Ethical Issues in Social Work (Professional Ethics)',3,'English','2003','28661267755','Amazon Digital Services, Inc.',2,0,0,NULL,'Social Work'),('978-28676385662','buy','old','electronic',56.00,'Lies My Teacher Told Me: Everything Your American History Textbook Got Wrong',4,'English','2001','29842088985','Amazon Digital Services, Inc.',2,0,0,NULL,'Sociology'),('978-29810578759','buy','old','electronic',54.00,'The Art of Theatrical Design: Elements of Visual Composition, Methods, and Practice',5,'English','2012','31022910215','Amazon Digital Services, Inc.',2,0,0,NULL,'Theatre'),('978-3724137528','buy','new','hardcover',300.00,'Textbook of Biochemistry with Clinical Correlations',25,'English','1991','3864021925','Saunders',5,1,0,NULL,'Chemistry and Biochemistry'),('978-4858330625','buy','new','hardcover',23.00,'Modern Operating Systems',35,'English','2009','5044843155','Plume',5,1,2,4.25,'Computer Science and Electrical Engineering'),('978-5992523722','buy','new','hardcover',34.00,'Principles of Economics',12,'English','1993','18742369423','Cengage Learning',6,1,0,NULL,'Economics'),('978-5992523723','buy','new','hardcover',57.00,'The Great Salsa Book',10,'English','2006','6225664385','Mosby',5,1,0,NULL,'Dance'),('978-7126716819','buy','new','hardcover',123.11,'Basic Economics for Students and Non-Students Alike',10,'English','2004','7406485615','Benjamin Cummings',5,1,0,NULL,'Economics'),('978-8260909916','buy','new','hardcover',132.50,'Child Development: An Introduction',5,'English','2001','8587306845','Jerry Wyant',5,1,0,NULL,'Education'),('978-9395103013','rent','new','hardcover',20.00,'Epidemiology and Prevention of Vaccine-Preventable Diseases',6,'English','2002','9768128075','Touchstone',5,1,0,NULL,'Emergency Health Services');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_author`
--

DROP TABLE IF EXISTS `book_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_author` (
  `ISBN_13` varchar(15) NOT NULL,
  `purchase_type` enum('rent','buy') NOT NULL,
  `book_condition` enum('new','old') NOT NULL,
  `the_format` enum('hardcover','paperback','electronic') NOT NULL,
  `author` varchar(100) NOT NULL,
  PRIMARY KEY (`ISBN_13`,`purchase_type`,`book_condition`,`the_format`,`author`),
  CONSTRAINT `book_author_ibfk_1` FOREIGN KEY (`ISBN_13`, `purchase_type`, `book_condition`, `the_format`) REFERENCES `book` (`ISBN_13`, `purchase_type`, `book_condition`, `the_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_author`
--

LOCK TABLES `book_author` WRITE;
/*!40000 ALTER TABLE `book_author` DISABLE KEYS */;
INSERT INTO `book_author` VALUES ('978-0307743657','buy','old','paperback','Stephen King'),('978-0321558237','buy','new','hardcover','Tom Swimm'),('978-0470080245','buy','old','hardcover','George Sutton'),('978-10529296110','rent','new','hardcover','Larry Beason'),('978-11663489207','rent','new','paperback','Jonathan Crichton'),('978-12797682304','rent','new','paperback','Max Kadushin'),('978-13931875401','rent','old','paperback','Robert B. Hudson'),('978-13931875402','buy','new','paperback','John G Landels'),('978-1455751334','buy','new','hardcover','Dimitrios Asteriou'),('978-1476770383','buy','new','paperback','Stephen King'),('978-15066068498','rent','old','paperback','Ron Larson'),('978-1563477799','buy','new','hardcover','J Mattingly'),('978-1592575121','buy','new','hardcover','Michael Kelley'),('978-16200261595','rent','old','paperback','Scott Eberhardt'),('978-17334454692','rent','old','paperback','Carolyn Dale'),('978-18468647789','rent','old','paperback','Stella Ting-Toomey'),('978-19602840886','rent','old','paperback','K Stolba'),('978-20737033983','rent','old','paperback','Thomas A. Blackson'),('978-21871227080','rent','old','paperback','Dawn Lee'),('978-23005420177','buy','old','electronic','Richard T. Schaefer'),('978-24139613274','buy','old','electronic','John E. Hall'),('978-25273806371','buy','old','electronic','David G. Myers'),('978-2589944431','buy','new','hardcover','John E. McMurry'),('978-26407999468','buy','old','electronic','Gregory C. Higgins'),('978-27542192565','buy','old','electronic','Richard Hugman'),('978-28676385662','buy','old','electronic','James W. Loewen'),('978-29810578759','buy','old','electronic','Kaoime Malloy'),('978-3724137528','buy','new','hardcover','Thomas M. Devlin'),('978-4858330625','buy','new','hardcover','Andrew S. Tanenbaum'),('978-5992523722','buy','new','hardcover','N. Gregory Mankiw'),('978-5992523723','buy','new','hardcover','Mark Miller'),('978-7126716819','buy','new','hardcover','Jerry Wyant'),('978-8260909916','buy','new','hardcover','John Santrock'),('978-9395103013','rent','new','hardcover','Charles (Skip) Wolfe'),('978-9395103013','rent','new','hardcover','William Atkinson');
/*!40000 ALTER TABLE `book_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_keywords`
--

DROP TABLE IF EXISTS `book_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_keywords` (
  `ISBN_13` varchar(15) NOT NULL,
  `purchase_type` enum('rent','buy') NOT NULL,
  `book_condition` enum('new','old') NOT NULL,
  `the_format` enum('hardcover','paperback','electronic') NOT NULL,
  `keyword` varchar(100) NOT NULL,
  PRIMARY KEY (`ISBN_13`,`purchase_type`,`book_condition`,`the_format`,`keyword`),
  KEY `book_keyword` (`ISBN_13`),
  KEY `keywords` (`keyword`),
  CONSTRAINT `book_keywords_ibfk_1` FOREIGN KEY (`ISBN_13`, `purchase_type`, `book_condition`, `the_format`) REFERENCES `book` (`ISBN_13`, `purchase_type`, `book_condition`, `the_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_keywords`
--

LOCK TABLES `book_keywords` WRITE;
/*!40000 ALTER TABLE `book_keywords` DISABLE KEYS */;
INSERT INTO `book_keywords` VALUES ('978-0307743657','buy','old','paperback','King'),('978-0307743657','buy','old','paperback','shining'),('978-0307743657','buy','old','paperback','Stephen'),('978-0307743657','buy','old','paperback','The'),('978-0321558237','buy','new','hardcover','a'),('978-0321558237','buy','new','hardcover','Acrylic'),('978-0321558237','buy','new','hardcover','all'),('978-0321558237','buy','new','hardcover','and'),('978-0321558237','buy','new','hardcover','basics'),('978-0321558237','buy','new','hardcover','by'),('978-0321558237','buy','new','hardcover','creating'),('978-0321558237','buy','new','hardcover','Discover'),('978-0321558237','buy','new','hardcover','for'),('978-0321558237','buy','new','hardcover','in'),('978-0321558237','buy','new','hardcover','masterpieces'),('978-0321558237','buy','new','hardcover','of'),('978-0321558237','buy','new','hardcover','own'),('978-0321558237','buy','new','hardcover','Painting'),('978-0321558237','buy','new','hardcover','range'),('978-0321558237','buy','new','hardcover','special'),('978-0321558237','buy','new','hardcover','Step'),('978-0321558237','buy','new','hardcover','Step:'),('978-0321558237','buy','new','hardcover','Swimm'),('978-0321558237','buy','new','hardcover','techniques'),('978-0321558237','buy','new','hardcover','the'),('978-0321558237','buy','new','hardcover','Tom'),('978-0321558237','buy','new','hardcover','your'),('978-0470080245','buy','old','hardcover','Elements'),('978-0470080245','buy','old','hardcover','George'),('978-0470080245','buy','old','hardcover','Propulsion'),('978-0470080245','buy','old','hardcover','Rocket'),('978-0470080245','buy','old','hardcover','Sutton'),('978-10529296110','rent','new','hardcover','Adverbs'),('978-10529296110','rent','new','hardcover','and'),('978-10529296110','rent','new','hardcover','Beason'),('978-10529296110','rent','new','hardcover','English'),('978-10529296110','rent','new','hardcover','Grammar'),('978-10529296110','rent','new','hardcover','Handbook'),('978-10529296110','rent','new','hardcover','Larry'),('978-10529296110','rent','new','hardcover','McGraw-Hill'),('978-10529296110','rent','new','hardcover','of'),('978-10529296110','rent','new','hardcover','Usage'),('978-11663489207','rent','new','paperback','and'),('978-11663489207','rent','new','paperback','Crichton'),('978-11663489207','rent','new','paperback','Easy'),('978-11663489207','rent','new','paperback','English'),('978-11663489207','rent','new','paperback','International'),('978-11663489207','rent','new','paperback','Jonathan'),('978-11663489207','rent','new','paperback','Learning'),('978-11663489207','rent','new','paperback','Made'),('978-11663489207','rent','new','paperback','One:'),('978-11663489207','rent','new','paperback','Pictures'),('978-11663489207','rent','new','paperback','Students'),('978-11663489207','rent','new','paperback','through'),('978-11663489207','rent','new','paperback','Volume'),('978-12797682304','rent','new','paperback','A'),('978-12797682304','rent','new','paperback','Ancient'),('978-12797682304','rent','new','paperback','and'),('978-12797682304','rent','new','paperback','Approach'),('978-12797682304','rent','new','paperback','Conceptual'),('978-12797682304','rent','new','paperback','East'),('978-12797682304','rent','new','paperback','Israel'),('978-12797682304','rent','new','paperback','Kadushin'),('978-12797682304','rent','new','paperback','Max'),('978-12797682304','rent','new','paperback','Mekilta'),('978-12797682304','rent','new','paperback','Near'),('978-12797682304','rent','new','paperback','the'),('978-12797682304','rent','new','paperback','to'),('978-13931875401','rent','old','paperback','Age'),('978-13931875401','rent','old','paperback','and'),('978-13931875401','rent','old','paperback','B.'),('978-13931875401','rent','old','paperback','Health'),('978-13931875401','rent','old','paperback','Hudson'),('978-13931875401','rent','old','paperback','New'),('978-13931875401','rent','old','paperback','of'),('978-13931875401','rent','old','paperback','Old'),('978-13931875401','rent','old','paperback','Policy'),('978-13931875401','rent','old','paperback','Politics'),('978-13931875401','rent','old','paperback','Robert'),('978-13931875401','rent','old','paperback','The'),('978-13931875402','buy','new','paperback','Ancient'),('978-13931875402','buy','new','paperback','and'),('978-13931875402','buy','new','paperback','G'),('978-13931875402','buy','new','paperback','Greece'),('978-13931875402','buy','new','paperback','in'),('978-13931875402','buy','new','paperback','John'),('978-13931875402','buy','new','paperback','Landels'),('978-13931875402','buy','new','paperback','Music'),('978-13931875402','buy','new','paperback','Rome'),('978-13931875402','buy','new','paperback','Times'),('978-1455751334','buy','new','hardcover','Applied'),('978-1455751334','buy','new','hardcover','Asteriou'),('978-1455751334','buy','new','hardcover','Dimitrios'),('978-1455751334','buy','new','hardcover','Econometrics'),('978-1476770383','buy','new','paperback','A'),('978-1476770383','buy','new','paperback','King'),('978-1476770383','buy','new','paperback','Novel'),('978-1476770383','buy','new','paperback','Revival:'),('978-1476770383','buy','new','paperback','Stephen'),('978-15066068498','rent','old','paperback','algebra'),('978-15066068498','rent','old','paperback','Larson'),('978-15066068498','rent','old','paperback','linear'),('978-15066068498','rent','old','paperback','Ron'),('978-1563477799','buy','new','hardcover','and'),('978-1563477799','buy','new','hardcover','Elements'),('978-1563477799','buy','new','hardcover','Gas'),('978-1563477799','buy','new','hardcover','J'),('978-1563477799','buy','new','hardcover','Mattingly'),('978-1563477799','buy','new','hardcover','of'),('978-1563477799','buy','new','hardcover','Propulsion'),('978-1563477799','buy','new','hardcover','Propulsion:'),('978-1563477799','buy','new','hardcover','Rocket'),('978-1563477799','buy','new','hardcover','Rockets'),('978-1563477799','buy','new','hardcover','Turbines'),('978-1592575121','buy','new','hardcover','algebra'),('978-1592575121','buy','new','hardcover','Book'),('978-1592575121','buy','new','hardcover','Humongous'),('978-1592575121','buy','new','hardcover','Kelley'),('978-1592575121','buy','new','hardcover','linear'),('978-1592575121','buy','new','hardcover','Michael'),('978-1592575121','buy','new','hardcover','of'),('978-1592575121','buy','new','hardcover','Problems'),('978-1592575121','buy','new','hardcover','The'),('978-16200261595','rent','old','paperback','Design'),('978-16200261595','rent','old','paperback','Eberhardt'),('978-16200261595','rent','old','paperback','Flight'),('978-16200261595','rent','old','paperback','Scott'),('978-16200261595','rent','old','paperback','Understanding'),('978-16200261595','rent','old','paperback','Wing'),('978-17334454692','rent','old','paperback','and'),('978-17334454692','rent','old','paperback','Carolyn'),('978-17334454692','rent','old','paperback','Crafting'),('978-17334454692','rent','old','paperback','Dale'),('978-17334454692','rent','old','paperback','Editing:'),('978-17334454692','rent','old','paperback','Fearless'),('978-17334454692','rent','old','paperback','for'),('978-17334454692','rent','old','paperback','Images'),('978-17334454692','rent','old','paperback','Journalism'),('978-17334454692','rent','old','paperback','Print'),('978-17334454692','rent','old','paperback','Print,'),('978-17334454692','rent','old','paperback','Public'),('978-17334454692','rent','old','paperback','Relations'),('978-17334454692','rent','old','paperback','Web,'),('978-17334454692','rent','old','paperback','Words'),('978-18468647789','rent','old','paperback','Communication'),('978-18468647789','rent','old','paperback','Field'),('978-18468647789','rent','old','paperback','Intercultural'),('978-18468647789','rent','old','paperback','of'),('978-18468647789','rent','old','paperback','Stella'),('978-18468647789','rent','old','paperback','The'),('978-18468647789','rent','old','paperback','Ting-Toomey'),('978-18468647789','rent','old','paperback','Understanding'),('978-19602840886','rent','old','paperback','A'),('978-19602840886','rent','old','paperback','Development'),('978-19602840886','rent','old','paperback','History'),('978-19602840886','rent','old','paperback','in'),('978-19602840886','rent','old','paperback','K'),('978-19602840886','rent','old','paperback','Medivial'),('978-19602840886','rent','old','paperback','Music'),('978-19602840886','rent','old','paperback','Music:'),('978-19602840886','rent','old','paperback','of'),('978-19602840886','rent','old','paperback','Stolba'),('978-19602840886','rent','old','paperback','The'),('978-19602840886','rent','old','paperback','Times'),('978-19602840886','rent','old','paperback','Western'),('978-20737033983','rent','old','paperback','A.'),('978-20737033983','rent','old','paperback','Ancient'),('978-20737033983','rent','old','paperback','Blackson'),('978-20737033983','rent','old','paperback','From'),('978-20737033983','rent','old','paperback','Greek'),('978-20737033983','rent','old','paperback','Hellenistic'),('978-20737033983','rent','old','paperback','Philosophers'),('978-20737033983','rent','old','paperback','Philosophy'),('978-20737033983','rent','old','paperback','Philosophy:'),('978-20737033983','rent','old','paperback','Presocratics'),('978-20737033983','rent','old','paperback','the'),('978-20737033983','rent','old','paperback','Thomas'),('978-20737033983','rent','old','paperback','to'),('978-21871227080','rent','old','paperback','Academic'),('978-21871227080','rent','old','paperback','and'),('978-21871227080','rent','old','paperback','Applied'),('978-21871227080','rent','old','paperback','Dawn'),('978-21871227080','rent','old','paperback','Fields'),('978-21871227080','rent','old','paperback','in'),('978-21871227080','rent','old','paperback','Introduction'),('978-21871227080','rent','old','paperback','Lee'),('978-21871227080','rent','old','paperback','Pearson'),('978-21871227080','rent','old','paperback','Reader:'),('978-21871227080','rent','old','paperback','Reading'),('978-21871227080','rent','old','paperback','Textbook'),('978-21871227080','rent','old','paperback','to'),('978-23005420177','buy','old','electronic','A'),('978-23005420177','buy','old','electronic','Brief'),('978-23005420177','buy','old','electronic','Introduction'),('978-23005420177','buy','old','electronic','of'),('978-23005420177','buy','old','electronic','Principles'),('978-23005420177','buy','old','electronic','Richard'),('978-23005420177','buy','old','electronic','Schaefer'),('978-23005420177','buy','old','electronic','Sociology'),('978-23005420177','buy','old','electronic','Sociology:'),('978-23005420177','buy','old','electronic','T.'),('978-24139613274','buy','old','electronic','Anatomy'),('978-24139613274','buy','old','electronic','and'),('978-24139613274','buy','old','electronic','E.'),('978-24139613274','buy','old','electronic','Guyton'),('978-24139613274','buy','old','electronic','Hall'),('978-24139613274','buy','old','electronic','Human'),('978-24139613274','buy','old','electronic','John'),('978-24139613274','buy','old','electronic','Medical'),('978-24139613274','buy','old','electronic','of'),('978-24139613274','buy','old','electronic','Physiology'),('978-24139613274','buy','old','electronic','Textbook'),('978-25273806371','buy','old','electronic','David'),('978-25273806371','buy','old','electronic','G.'),('978-25273806371','buy','old','electronic','Introduction'),('978-25273806371','buy','old','electronic','Myers'),('978-25273806371','buy','old','electronic','Psychology'),('978-25273806371','buy','old','electronic','to'),('978-2589944431','buy','new','hardcover','Chemistry'),('978-2589944431','buy','new','hardcover','E.'),('978-2589944431','buy','new','hardcover','John'),('978-2589944431','buy','new','hardcover','McMurry'),('978-2589944431','buy','new','hardcover','Organic'),('978-26407999468','buy','old','electronic','101:'),('978-26407999468','buy','old','electronic','A'),('978-26407999468','buy','old','electronic','C.'),('978-26407999468','buy','old','electronic','Catholic'),('978-26407999468','buy','old','electronic','Christianity'),('978-26407999468','buy','old','electronic','Gregory'),('978-26407999468','buy','old','electronic','Higgins'),('978-26407999468','buy','old','electronic','of'),('978-26407999468','buy','old','electronic','Textbook'),('978-26407999468','buy','old','electronic','Theology'),('978-27542192565','buy','old','electronic','(Professional'),('978-27542192565','buy','old','electronic','and'),('978-27542192565','buy','old','electronic','Ethical'),('978-27542192565','buy','old','electronic','Ethics)'),('978-27542192565','buy','old','electronic','History'),('978-27542192565','buy','old','electronic','Hugman'),('978-27542192565','buy','old','electronic','in'),('978-27542192565','buy','old','electronic','Issues'),('978-27542192565','buy','old','electronic','of'),('978-27542192565','buy','old','electronic','Philosophy'),('978-27542192565','buy','old','electronic','Richard'),('978-27542192565','buy','old','electronic','Social'),('978-27542192565','buy','old','electronic','Welfare'),('978-27542192565','buy','old','electronic','Work'),('978-28676385662','buy','old','electronic','America'),('978-28676385662','buy','old','electronic','American'),('978-28676385662','buy','old','electronic','Culture'),('978-28676385662','buy','old','electronic','Everything'),('978-28676385662','buy','old','electronic','Got'),('978-28676385662','buy','old','electronic','History'),('978-28676385662','buy','old','electronic','in'),('978-28676385662','buy','old','electronic','James'),('978-28676385662','buy','old','electronic','Lies'),('978-28676385662','buy','old','electronic','Loewen'),('978-28676385662','buy','old','electronic','Me:'),('978-28676385662','buy','old','electronic','My'),('978-28676385662','buy','old','electronic','Teacher'),('978-28676385662','buy','old','electronic','Textbook'),('978-28676385662','buy','old','electronic','Told'),('978-28676385662','buy','old','electronic','W.'),('978-28676385662','buy','old','electronic','Wrong'),('978-28676385662','buy','old','electronic','Your'),('978-29810578759','buy','old','electronic','and'),('978-29810578759','buy','old','electronic','Art'),('978-29810578759','buy','old','electronic','Composition,'),('978-29810578759','buy','old','electronic','Design:'),('978-29810578759','buy','old','electronic','Elements'),('978-29810578759','buy','old','electronic','Kaoime'),('978-29810578759','buy','old','electronic','Malloy'),('978-29810578759','buy','old','electronic','Methods,'),('978-29810578759','buy','old','electronic','of'),('978-29810578759','buy','old','electronic','Practice'),('978-29810578759','buy','old','electronic','Practicum'),('978-29810578759','buy','old','electronic','Production'),('978-29810578759','buy','old','electronic','The'),('978-29810578759','buy','old','electronic','Theatrical'),('978-29810578759','buy','old','electronic','Visual'),('978-3724137528','buy','new','hardcover','Biochemistry'),('978-3724137528','buy','new','hardcover','Clinical'),('978-3724137528','buy','new','hardcover','Correlations'),('978-3724137528','buy','new','hardcover','Devlin'),('978-3724137528','buy','new','hardcover','M.'),('978-3724137528','buy','new','hardcover','of'),('978-3724137528','buy','new','hardcover','Textbook'),('978-3724137528','buy','new','hardcover','Thomas'),('978-3724137528','buy','new','hardcover','with'),('978-4858330625','buy','new','hardcover','Andrew'),('978-4858330625','buy','new','hardcover','Modern'),('978-4858330625','buy','new','hardcover','Operating'),('978-4858330625','buy','new','hardcover','S.'),('978-4858330625','buy','new','hardcover','System'),('978-4858330625','buy','new','hardcover','Systems'),('978-4858330625','buy','new','hardcover','Tanenbaum'),('978-5992523722','buy','new','hardcover','Economics'),('978-5992523722','buy','new','hardcover','Gregory'),('978-5992523722','buy','new','hardcover','Mankiw'),('978-5992523722','buy','new','hardcover','Microeconomics'),('978-5992523722','buy','new','hardcover','N.'),('978-5992523722','buy','new','hardcover','of'),('978-5992523722','buy','new','hardcover','Principles'),('978-5992523723','buy','new','hardcover','Book'),('978-5992523723','buy','new','hardcover','Great'),('978-5992523723','buy','new','hardcover','Mark'),('978-5992523723','buy','new','hardcover','Miller'),('978-5992523723','buy','new','hardcover','Salsa'),('978-5992523723','buy','new','hardcover','The'),('978-7126716819','buy','new','hardcover','Alike'),('978-7126716819','buy','new','hardcover','and'),('978-7126716819','buy','new','hardcover','Basic'),('978-7126716819','buy','new','hardcover','Economics'),('978-7126716819','buy','new','hardcover','for'),('978-7126716819','buy','new','hardcover','Jerry'),('978-7126716819','buy','new','hardcover','Macroeconomics'),('978-7126716819','buy','new','hardcover','Non-Students'),('978-7126716819','buy','new','hardcover','Students'),('978-7126716819','buy','new','hardcover','Wyant'),('978-8260909916','buy','new','hardcover','101'),('978-8260909916','buy','new','hardcover','An'),('978-8260909916','buy','new','hardcover','Child'),('978-8260909916','buy','new','hardcover','Development:'),('978-8260909916','buy','new','hardcover','Introduction'),('978-8260909916','buy','new','hardcover','John'),('978-8260909916','buy','new','hardcover','Santrock'),('978-8260909916','buy','new','hardcover','Teaching'),('978-9395103013','rent','new','hardcover','(Skip)'),('978-9395103013','rent','new','hardcover','and'),('978-9395103013','rent','new','hardcover','Atkinson,'),('978-9395103013','rent','new','hardcover','Charles'),('978-9395103013','rent','new','hardcover','Diseases'),('978-9395103013','rent','new','hardcover','Epidemiology'),('978-9395103013','rent','new','hardcover','of'),('978-9395103013','rent','new','hardcover','Prevention'),('978-9395103013','rent','new','hardcover','Vaccination'),('978-9395103013','rent','new','hardcover','Vaccine-Preventable'),('978-9395103013','rent','new','hardcover','William'),('978-9395103013','rent','new','hardcover','Wolfe');
/*!40000 ALTER TABLE `book_keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_rating`
--

DROP TABLE IF EXISTS `book_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_rating` (
  `student_email` varchar(100) NOT NULL,
  `ISBN_13` varchar(15) NOT NULL,
  `purchase_type` enum('rent','buy') NOT NULL,
  `book_condition` enum('new','old') NOT NULL,
  `the_format` enum('hardcover','paperback','electronic') NOT NULL,
  `rating` double DEFAULT NULL,
  `text_review` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`student_email`,`ISBN_13`,`purchase_type`,`book_condition`,`the_format`),
  KEY `ISBN_13` (`ISBN_13`,`purchase_type`,`book_condition`,`the_format`),
  KEY `the_rating` (`rating`),
  KEY `rater` (`student_email`),
  CONSTRAINT `book_rating_ibfk_1` FOREIGN KEY (`ISBN_13`, `purchase_type`, `book_condition`, `the_format`) REFERENCES `book` (`ISBN_13`, `purchase_type`, `book_condition`, `the_format`),
  CONSTRAINT `book_rating_ibfk_2` FOREIGN KEY (`student_email`) REFERENCES `student` (`student_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_rating`
--

LOCK TABLES `book_rating` WRITE;
/*!40000 ALTER TABLE `book_rating` DISABLE KEYS */;
INSERT INTO `book_rating` VALUES ('AnthonyFortin@gmail.com','978-4858330625','buy','new','hardcover',4,NULL),('DanielLavoie@gmail.com','978-19602840886','rent','old','paperback',4,NULL),('NancyMartínez@gmail.com','978-19602840886','rent','old','paperback',3,NULL),('PatriciaGagné@gmail.com','978-4858330625','buy','new','hardcover',4.5,NULL);
/*!40000 ALTER TABLE `book_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_subcategories`
--

DROP TABLE IF EXISTS `book_subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_subcategories` (
  `ISBN_13` varchar(15) NOT NULL,
  `purchase_type` enum('rent','buy') NOT NULL,
  `book_condition` enum('new','old') NOT NULL,
  `the_format` enum('hardcover','paperback','electronic') NOT NULL,
  `subcategory` varchar(100) NOT NULL,
  PRIMARY KEY (`ISBN_13`,`purchase_type`,`book_condition`,`the_format`,`subcategory`),
  KEY `other_category` (`subcategory`),
  CONSTRAINT `book_subcategories_ibfk_1` FOREIGN KEY (`ISBN_13`, `purchase_type`, `book_condition`, `the_format`) REFERENCES `book` (`ISBN_13`, `purchase_type`, `book_condition`, `the_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_subcategories`
--

LOCK TABLES `book_subcategories` WRITE;
/*!40000 ALTER TABLE `book_subcategories` DISABLE KEYS */;
INSERT INTO `book_subcategories` VALUES ('978-0321558237','buy','new','hardcover','Acrylic painting'),('978-10529296110','rent','new','hardcover','Adverbs'),('978-20737033983','rent','old','paperback','Ancient Greek Philosophy'),('978-3724137528','buy','new','hardcover','Biochemistry'),('978-26407999468','buy','old','electronic','Christianity '),('978-28676385662','buy','old','electronic','Culture in America'),('978-1455751334','buy','new','hardcover','Econometrics'),('978-11663489207','rent','new','paperback','English and International Students'),('978-13931875401','rent','old','paperback','Health and Age'),('978-27542192565','buy','old','electronic','History and Philosophy of Social Work and Social Welfare'),('978-24139613274','buy','old','electronic','Human Anatomy'),('978-21871227080','rent','old','paperback','Introduction to Academic Reading'),('978-25273806371','buy','old','electronic','Introduction to Psychology'),('978-12797682304','rent','new','paperback','Israel and the Ancient Near East'),('978-15066068498','rent','old','paperback','linear algebra'),('978-1592575121','buy','new','hardcover','linear algebra'),('978-7126716819','buy','new','hardcover','Macroeconomics'),('978-5992523722','buy','new','hardcover','Microeconomics'),('978-13931875402','buy','new','paperback','Music in Ancient Times'),('978-19602840886','rent','old','paperback','Music in Medivial Times'),('978-4858330625','buy','new','hardcover','Operating System'),('978-2589944431','buy','new','hardcover','Organic Chemistry'),('978-23005420177','buy','old','electronic','Principles of Sociology'),('978-17334454692','rent','old','paperback','Print Journalism '),('978-29810578759','buy','old','electronic','Production Practicum'),('978-0470080245','buy','old','hardcover','Rocket Propulsion '),('978-1563477799','buy','new','hardcover','Rocket Propulsion '),('978-5992523723','buy','new','hardcover','Salsa'),('978-8260909916','buy','new','hardcover','Teaching 101'),('978-18468647789','rent','old','paperback','The Field of Intercultural Communication'),('978-0307743657','buy','old','paperback','Thriller'),('978-1476770383','buy','new','paperback','Thriller'),('978-9395103013','rent','new','hardcover','Vaccination'),('978-16200261595','rent','old','paperback','Wing Design');
/*!40000 ALTER TABLE `book_subcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `cart_ID` smallint(6) NOT NULL,
  `student_email` varchar(100) DEFAULT NULL,
  `date_created` date NOT NULL,
  `date_updated` date DEFAULT NULL,
  PRIMARY KEY (`cart_ID`),
  KEY `student_email` (`student_email`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`student_email`) REFERENCES `student` (`student_email`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,'ChristopherRoy@gmail.com','2014-10-02','2014-10-03'),(2,'RonaldGagnon@gmail.com','2014-10-02','2014-10-03'),(3,'MaryCôté@gmail.com','2014-10-02','2014-10-03'),(4,'LisaBouchard@gmail.com','2014-10-03','2014-10-04'),(5,'MichelleGauthier@gmail.com','2014-10-04','2014-10-05'),(6,'LauraGarcía@gmail.com','2014-09-08','2014-12-15'),(7,'PaulGonzález@gmail.com','2014-11-07','2014-12-16'),(8,'LindaRodríguez@gmail.com','2014-05-01','2014-10-14'),(9,'SarahSánchez@gmail.com','2014-01-01','2014-06-17'),(10,'MarkFlores@gmail.com','2014-01-02','2014-02-07'),(11,'LeslieGarcía@gmail.com','2014-01-01','2014-03-05'),(12,'PatriciaGagné@gmail.com','2014-11-05','2014-11-05'),(13,'KarenPérez@gmail.com','2014-01-02','2014-02-01'),(14,'LewisRodríguez@gmail.com','2014-01-01','2014-03-05');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_books`
--

DROP TABLE IF EXISTS `cart_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_books` (
  `cart_ID` smallint(6) NOT NULL,
  `ISBN_13` varchar(15) NOT NULL,
  `purchase_type` enum('rent','buy') NOT NULL,
  `book_condition` enum('new','old') NOT NULL,
  `the_format` enum('hardcover','paperback','electronic') NOT NULL,
  `quantity` smallint(6) NOT NULL,
  PRIMARY KEY (`cart_ID`,`ISBN_13`,`purchase_type`,`book_condition`,`the_format`),
  KEY `ISBN_13` (`ISBN_13`,`purchase_type`,`book_condition`,`the_format`),
  CONSTRAINT `cart_books_ibfk_1` FOREIGN KEY (`cart_ID`) REFERENCES `cart` (`cart_ID`),
  CONSTRAINT `cart_books_ibfk_2` FOREIGN KEY (`ISBN_13`, `purchase_type`, `book_condition`, `the_format`) REFERENCES `book` (`ISBN_13`, `purchase_type`, `book_condition`, `the_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_books`
--

LOCK TABLES `cart_books` WRITE;
/*!40000 ALTER TABLE `cart_books` DISABLE KEYS */;
INSERT INTO `cart_books` VALUES (1,'978-11663489207','rent','new','paperback',1),(1,'978-17334454692','rent','old','paperback',1),(2,'978-10529296110','rent','new','hardcover',4),(2,'978-17334454692','rent','old','paperback',1),(3,'978-11663489207','rent','new','paperback',1),(4,'978-11663489207','rent','new','paperback',3),(5,'978-11663489207','rent','new','paperback',1),(6,'978-10529296110','rent','new','hardcover',2),(6,'978-19602840886','rent','old','paperback',1),(7,'978-10529296110','rent','new','hardcover',1),(7,'978-19602840886','rent','old','paperback',1),(8,'978-1455751334','buy','new','hardcover',2),(8,'978-15066068498','rent','old','paperback',1),(9,'978-1455751334','buy','new','hardcover',2),(10,'978-21871227080','rent','old','paperback',1),(10,'978-26407999468','buy','old','electronic',3),(11,'978-1455751334','buy','new','hardcover',2),(11,'978-15066068498','rent','old','paperback',1),(12,'978-15066068498','rent','old','paperback',1),(12,'978-17334454692','rent','old','paperback',1),(13,'978-21871227080','rent','old','paperback',2),(13,'978-26407999468','buy','old','electronic',2),(14,'978-15066068498','rent','old','paperback',1);
/*!40000 ALTER TABLE `cart_books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course` (
  `course_ID` varchar(125) NOT NULL,
  `semester` enum('Fall','Winter','Spring','Summer') NOT NULL,
  `the_year` smallint(6) NOT NULL,
  `university_ID` varchar(100) NOT NULL,
  `class_name` varchar(100) DEFAULT NULL,
  `department_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`course_ID`,`semester`,`the_year`,`university_ID`),
  KEY `university_ID` (`university_ID`),
  KEY `department_name` (`department_name`),
  KEY `class_ID` (`course_ID`),
  KEY `course_name` (`class_name`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`university_ID`) REFERENCES `university` (`university_ID`),
  CONSTRAINT `course_ibfk_2` FOREIGN KEY (`department_name`) REFERENCES `department` (`department_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES ('1','Fall',2014,'2','Acrylic painting','Visual Arts'),('10','Fall',2,'3','Introduction to Academic Reading','Pre-Allied Health'),('11','Fall',4,'2','Music in Medivial Times','Music'),('12','Fall',2,'2','The Field of Intercultural Communication','Modern Languages, Linguistics and Intercultural Communication'),('13','Fall',3,'2','Israel and the Ancient Near East','Judaic Studies'),('14','Fall',4,'1','Operating System','Computer Science and Electrical Engineering'),('15','Fall',2,'1','Adverbs','English'),('16','Spring',3,'1','Microeconomics','Economics'),('17','Winter',1,'3','History and Philosophy of Social Work and Social Welfare','Social Work'),('18','Fall',4,'2','Music in Ancient Times','Music'),('19','Fall',4,'3','Principles of Sociology','Pre-Law'),('2','Fall',4,'3','Acrylic painting','Visual Arts'),('20','Fall',2,'2','linear algebra','Mathematics and Statistics'),('21','Winter',3,'3','Production Practicum','Theatre'),('22','Winter',4,'3','Culture in America','Sociology'),('23','Winter',3,'3','Introduction to Psychology','Psychology'),('24','Fall',2,'1','Salsa','Dance'),('25','Fall',1,'2','Rocket Propulsion ','Mechanical Engineering'),('26','Fall',1,'3','Human Anatomy','Pre-Medicine and Pre-Dentistry'),('27','Winter',3,'1','Econometrics','Business Technology Administration'),('28','Winter',4,'1','Organic Chemistry','Chemical, Biochemical & Environmental Engineering'),('29','Winter',2,'3','Christianity ','Religious Studies'),('3','Fall',2,'2','linear algebra','Mathematics and Statistics'),('30','Fall',1,'2','Rocket Propulsion ','Mechanical Engineering'),('31','Fall',3,'1','Macroeconomics','Economics'),('32','Fall',2,'1','Teaching 101','Education'),('33','Fall',2,'1','Biochemistry','Chemistry and Biochemistry'),('4','Fall',1,'2','Wing Design','Mechanical Engineering'),('5','Fall',4,'1','English and International Students','English Language Institute'),('6','Fall',4,'2','Health and Age','Management of Aging Services'),('7','Fall',2,'2','Ancient Greek Philosophy','Philosophy'),('8','Fall',4,'1','Vaccination','Emergency Health Services'),('9','Fall',3,'2','Print Journalism ','Media and Communication Studies');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_instructor`
--

DROP TABLE IF EXISTS `course_instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_instructor` (
  `course_ID` varchar(125) NOT NULL,
  `semester` enum('Fall','Winter','Spring','Summer') NOT NULL,
  `the_year` smallint(6) NOT NULL,
  `university_ID` varchar(100) NOT NULL,
  `instructor_email` varchar(100) NOT NULL,
  PRIMARY KEY (`course_ID`,`semester`,`the_year`,`university_ID`,`instructor_email`),
  KEY `university_ID` (`university_ID`),
  KEY `instructor_email` (`instructor_email`),
  CONSTRAINT `course_instructor_ibfk_1` FOREIGN KEY (`course_ID`, `semester`, `the_year`) REFERENCES `course` (`course_ID`, `semester`, `the_year`),
  CONSTRAINT `course_instructor_ibfk_2` FOREIGN KEY (`university_ID`) REFERENCES `university` (`university_ID`),
  CONSTRAINT `course_instructor_ibfk_3` FOREIGN KEY (`instructor_email`) REFERENCES `instructor` (`instructor_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_instructor`
--

LOCK TABLES `course_instructor` WRITE;
/*!40000 ALTER TABLE `course_instructor` DISABLE KEYS */;
INSERT INTO `course_instructor` VALUES ('14','Fall',4,'1','harry.mills@umbc.edu'),('15','Fall',2,'1','fiona.hamilton@umbc.edu'),('16','Spring',3,'1','yvonne.wilkins@umbc.edu'),('24','Fall',2,'1','sean.lee@umbc.edu'),('27','Winter',3,'1','stephen.manning@umbc.edu'),('28','Winter',4,'1','jake.jackson@umbc.edu'),('31','Fall',3,'1','yvonne.wilkins@umbc.edu'),('32','Fall',2,'1','justin.turner@umbc.edu'),('33','Fall',2,'1','brian.lambert@umbc.edu'),('5','Fall',4,'1','alexander.clarkson@umbc.edu'),('8','Fall',4,'1','emma.kelly@umbc.edu'),('1','Fall',2014,'2','julia.lambert@towson.edu'),('11','Fall',4,'2','una.oliver@towson.edu'),('12','Fall',2,'2','lily.burgess@towson.edu'),('13','Fall',3,'2','piers.gray@towson.edu'),('18','Fall',4,'2','una.oliver@towson.edu'),('20','Fall',2,'2','connor.edmunds@towson.edu'),('25','Fall',1,'2','ian.gibson@towson.edu'),('3','Fall',2,'2','connor.edmunds@towson.edu'),('30','Fall',1,'2','ian.gibson@towson.edu'),('4','Fall',1,'2','ian.gibson@towson.edu'),('6','Fall',4,'2','felicity.buckland@towson.edu'),('7','Fall',2,'2','lucas.payne@towson.edu'),('9','Fall',3,'2','amelia.cameron@towson.edu'),('10','Fall',2,'3','isaac.anderson@umcp.edu'),('17','Winter',1,'3','piers.peters@umcp.edu'),('19','Fall',4,'3','hannah.bond@umcp.edu'),('2','Fall',4,'3','jessica.glover@umcp.edu'),('21','Winter',3,'3','mary.ogden@umcp.edu'),('22','Winter',4,'3','richard.clark@umcp.edu'),('23','Winter',3,'3','colin.nolan@umcp.edu'),('26','Fall',1,'3','leonard.wilkins@umcp.edu'),('29','Winter',2,'3','amanda.blake@umcp.edu');
/*!40000 ALTER TABLE `course_instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `department_name` varchar(100) NOT NULL,
  `university_ID` varchar(100) NOT NULL,
  PRIMARY KEY (`department_name`,`university_ID`),
  KEY `university_ID` (`university_ID`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`university_ID`) REFERENCES `university` (`university_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('Business Technology Administration','1'),('Chemical, Biochemical & Environmental Engineering','1'),('Chemistry and Biochemistry','1'),('Computer Science and Electrical Engineering','1'),('Dance','1'),('Economics','1'),('Education','1'),('Emergency Health Services','1'),('English','1'),('English Language Institute','1'),('Judaic Studies','2'),('Management of Aging Services','2'),('Mathematics and Statistics','2'),('Mechanical Engineering','2'),('Media and Communication Studies','2'),('Modern Languages, Linguistics and Intercultural Communication','2'),('Music','2'),('Philosophy','2'),('Visual Arts','2'),('Pre-Allied Health','3'),('Pre-Law','3'),('Pre-Medicine and Pre-Dentistry','3'),('Psychology','3'),('Religious Studies','3'),('Social Work','3'),('Sociology','3'),('Theatre','3'),('Visual Arts','3');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `SSN` char(11) NOT NULL,
  `job` enum('Administrators','SuperAdministrators','Customer Support') NOT NULL,
  `employee_ID` varchar(100) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `salary` int(11) DEFAULT NULL,
  `email_address` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `telephone_num` char(12) DEFAULT NULL,
  PRIMARY KEY (`SSN`),
  KEY `employee_type` (`job`),
  KEY `employee_salary` (`salary`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('234-45-1932','Administrators','30','Penelope','Ferguson','Female',50000,'penelope.ferguson@bookfetchinc.com','101 South 1st Street','775-555-0118'),('234-45-1933','Administrators','25','Lily','Randall','Female',50000,'lily.randall@bookfetchinc.com','2549 Livingston Road','775-555-0192'),('234-45-1934','Administrators','34','Rachel','Ball','Female',50000,'rachel.ball@bookfetchinc.com','306 Langdon Street','775-555-0162'),('234-45-1935','Administrators','31','Peter','Rees','Male',50000,'peter.rees@bookfetchinc.com','2313 M street, NW Suite 503','775-555-0150'),('234-45-1936','Administrators','13','Jack','Chapman','Male',60000,'jack.chapman@bookfetchinc.com','104 South 1st Street','775-555-0197'),('234-45-1937','Administrators','33','Phil','Skinner','Male',60000,'phil.skinner@bookfetchinc.com','2552 Livingston Road','775-555-0197'),('234-45-1938','Administrators','36','Sean','Berry','Male',50000,'sean.berry@bookfetchinc.com','309 Langdon Street','775-555-0130'),('394-70-1948','Customer Support','20','Julian','Rees','Female',20000,'julian.rees@bookfetchinc.com','600 Caisson Hill Road','775-555-0193'),('394-70-1949','Customer Support','32','Peter','Clarkson','Male',20000,'peter.clarkson@bookfetchinc.com','200 Hospital Drive','775-555-0167'),('394-70-1950','Customer Support','35','Ryan','Robertson','Male',20000,'ryan.robertson@bookfetchinc.com','1000 East 100 North','775-555-0141'),('394-70-1951','Customer Support','7','Boris','McGrath','Male',20000,'boris.mcgrath@bookfetchinc.com','2 West Lakeshore Drive','775-555-0197'),('394-70-1952','Customer Support','19','Joshua','Lee','Male',20000,'joshua.lee@bookfetchinc.com','3 West Lakeshore Drive','775-555-0127'),('394-70-1953','Customer Support','40','Zoe','Sharp','Female',40000,'zoe.sharp@bookfetchinc.com','2222 Canterbury Drive','775-555-0172'),('394-70-1954','Customer Support','29','Nicola','Roberts','Female',40000,'nicola.roberts@bookfetchinc.com','2223 Canterbury Drive','775-555-0198'),('394-70-2349','Administrators','39','Victor','Hill','Male',50000,'victor.hill@bookfetchinc.com','2548 Livingston Road','775-555-0176'),('394-70-2350','Administrators','9','Connor','Black','Male',50000,'connor.black@bookfetchinc.com','305 Langdon Street','775-555-0158'),('394-70-2351','Administrators','1','Andrew','Bower','Male',50000,'andrew.bower@bookfetchinc.com','2312 M street, NW Suite 503','775-555-0105'),('394-70-2352','Administrators','15','James','White','Male',50000,'james.white@bookfetchinc.com','103 South 1st Street','775-555-0199'),('394-70-2353','Administrators','27','Neil','Hodges','Male',60000,'neil.hodges@bookfetchinc.com','2551 Livingston Road','775-555-0175'),('394-70-2354','Administrators','6','Benjamin','Dyer','Male',60000,'benjamin.dyer@bookfetchinc.com','308 Langdon Street','775-555-0106'),('394-70-2355','Administrators','3','Anthony','Grant','Male',50000,'anthony.grant@bookfetchinc.com','2315 M street, NW Suite 503','775-555-0105'),('520-70-7854','Customer Support','23','Lauren','Mathis','Female',20000,'lauren.mathis@bookfetchinc.com','2220 Canterbury Drive','775-555-0175'),('520-70-7855','Customer Support','14','Jack','Allan','Male',20000,'jack.allan@bookfetchinc.com','2221 Canterbury Drive','775-555-0145'),('520-70-7856','Customer Support','17','Joan','Lawrence','Male',20000,'joan.lawrence@bookfetchinc.com','2222 Canterbury Drive','775-555-0142'),('520-70-7857','Customer Support','28','Nicola','Simpson','Female',20000,'nicola.simpson@bookfetchinc.com','601 Caisson Hill Road','775-555-0164'),('520-70-7858','Customer Support','2','Anne','Stewart','Female',20000,'anne.stewart@bookfetchinc.com','201 Hospital Drive','775-555-0130'),('520-70-7859','Customer Support','8','Caroline','Roberts','Female',20000,'caroline.roberts@bookfetchinc.com','1001 East 100 North','775-555-0143'),('520-70-7860','Customer Support','24','Lauren','Tucker','Female',40000,'lauren.tucker@bookfetchinc.com','3 West Lakeshore Drive','775-555-0152'),('530-70-2948','Customer Support','10','Dan','Martin','Male',20000,'dan.martin@bookfetchinc.com','1 West Lakeshore Drive','775-555-0171'),('530-70-2949','Customer Support','18','Joshua','Vaughan','Male',20000,'joshua.vaughan@bookfetchinc.com','2 West Lakeshore Drive','775-555-0172'),('530-70-2950','Customer Support','21','Karen','Parsons','Female',20000,'karen.parsons@bookfetchinc.com','2221 Canterbury Drive','775-555-0191'),('530-70-2951','Customer Support','26','Lucas','Rampling','Male',20000,'lucas.rampling@bookfetchinc.com','2222 Canterbury Drive','775-555-0188'),('530-70-2952','Customer Support','4','Austin','Morgan','Male',20000,'austin.morgan@bookfetchinc.com','2223 Canterbury Drive','775-555-0127'),('530-70-2953','Customer Support','22','Kevin','Carr','Male',40000,'kevin.carr@bookfetchinc.com','602 Caisson Hill Road','775-555-0172'),('589-42-7539','Customer Support','41','Patricia','Marable','Female',20000,'patritia.marable@bookfetchinc.com','418 Landon Court','775-555-4322'),('768-32-1432','Administrators','12','Heather','Powell','Female',50000,'heather.powell@bookfetchinc.com','2311 M street, NW Suite 503','775-555-0104'),('768-32-1433','Administrators','11','Donna','Scott','Female',50000,'donna.scott@bookfetchinc.com','102 South 1st Street','775-555-0112'),('768-32-1434','SuperAdministrators','5','Benjamin','Vaughan','Male',50000,'benjamin.vaughan@bookfetchinc.com','2550 Livingston Road','775-555-0189'),('768-32-1435','Administrators','37','Stephanie','Clarkson','Female',50000,'stephanie.clarkson@bookfetchinc.com','307 Langdon Street','775-555-0185'),('768-32-1436','Administrators','38','Tracey','Ogden','Female',60000,'tracey.ogden@bookfetchinc.com','2314 M street, NW Suite 503','775-555-0128'),('768-32-1437','Administrators','16','James','Bell','Male',60000,'james.bell@bookfetchinc.com','105 South 1st Street','775-555-0196');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor`
--

DROP TABLE IF EXISTS `instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructor` (
  `instructor_email` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `department_name` varchar(100) DEFAULT NULL,
  `university_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`instructor_email`),
  KEY `university_ID` (`university_ID`),
  KEY `department_name` (`department_name`),
  CONSTRAINT `instructor_ibfk_1` FOREIGN KEY (`university_ID`) REFERENCES `university` (`university_ID`) ON DELETE SET NULL,
  CONSTRAINT `instructor_ibfk_2` FOREIGN KEY (`department_name`) REFERENCES `department` (`department_name`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor`
--

LOCK TABLES `instructor` WRITE;
/*!40000 ALTER TABLE `instructor` DISABLE KEYS */;
INSERT INTO `instructor` VALUES ('alexander.clarkson@umbc.edu','Alexander','Clarkson','English Language Institute','1'),('amanda.blake@umcp.edu','Amanda','Blake','Religious Studies','3'),('amelia.cameron@towson.edu','Amelia','Cameron','Media and Communication Studies','2'),('brian.lambert@umbc.edu','Brian','Lambert','Chemistry and Biochemistry','1'),('colin.nolan@umcp.edu','Colin','Nolan','Psychology','3'),('connor.edmunds@towson.edu','Connor','Edmunds','Mathematics and Statistics','2'),('emma.kelly@umbc.edu','Emma','Kelly','Emergency Health Services','1'),('felicity.buckland@towson.edu','Felicity','Buckland','Management of Aging Services','2'),('fiona.hamilton@umbc.edu','Fiona','Hamilton','English','1'),('hannah.bond@umcp.edu','Hannah','Bond','Pre-Law','3'),('harry.mills@umbc.edu','Harry','Mills','Computer Science and Electrical Engineering','1'),('ian.gibson@towson.edu','Ian','Gibson','Mechanical Engineering','2'),('isaac.anderson@umcp.edu','Isaac','Anderson','Pre-Allied Health','3'),('jake.jackson@umbc.edu','Jake','Jackson','Chemical, Biochemical & Environmental Engineering','1'),('jessica.glover@umcp.edu','Jessica','Glover','Visual Arts','3'),('julia.lambert@towson.edu','Julia','Lambert','Visual Arts','2'),('justin.turner@umbc.edu','Justin','Turner','Education','1'),('leonard.wilkins@umcp.edu','Leonard','Wilkins','Pre-Medicine and Pre-Dentistry','3'),('lily.burgess@towson.edu','Lily','Burgess','Modern Languages, Linguistics and Intercultural Communication','2'),('lucas.payne@towson.edu','Lucas','Payne','Philosophy','2'),('mary.ogden@umcp.edu','Mary','Ogden','Theatre','3'),('piers.gray@towson.edu','Piers','Gray','Judaic Studies','2'),('piers.peters@umcp.edu','Piers','Peters','Social Work','3'),('richard.clark@umcp.edu','Richard','Clark','Sociology','3'),('sean.lee@umbc.edu','Sean','Lee','Dance','1'),('stephen.manning@umbc.edu','Stephen','Manning','Business Technology Administration','1'),('una.oliver@towson.edu','Una','Oliver','Music','2'),('yvonne.wilkins@umbc.edu','Yvonne','Wilkins','Economics','1');
/*!40000 ALTER TABLE `instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_books`
--

DROP TABLE IF EXISTS `order_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_books` (
  `order_ID` varchar(100) NOT NULL,
  `ISBN_13` varchar(15) NOT NULL,
  `purchase_type` enum('rent','buy') NOT NULL,
  `book_condition` enum('new','old') NOT NULL,
  `the_format` enum('hardcover','paperback','electronic') NOT NULL,
  `quantity` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`order_ID`,`ISBN_13`,`purchase_type`,`book_condition`,`the_format`),
  KEY `ISBN_13` (`ISBN_13`,`purchase_type`,`book_condition`,`the_format`),
  KEY `book_purchase_type` (`purchase_type`),
  CONSTRAINT `order_books_ibfk_1` FOREIGN KEY (`order_ID`) REFERENCES `orders` (`order_ID`),
  CONSTRAINT `order_books_ibfk_2` FOREIGN KEY (`ISBN_13`, `purchase_type`, `book_condition`, `the_format`) REFERENCES `book` (`ISBN_13`, `purchase_type`, `book_condition`, `the_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_books`
--

LOCK TABLES `order_books` WRITE;
/*!40000 ALTER TABLE `order_books` DISABLE KEYS */;
INSERT INTO `order_books` VALUES ('1','978-18468647789','rent','old','paperback',1),('2','978-25273806371','buy','old','electronic',2),('3','978-24139613274','buy','old','electronic',1),('3','978-4858330625','buy','new','hardcover',1),('4','978-21871227080','rent','old','paperback',1),('5','978-4858330625','buy','new','hardcover',1),('6','978-25273806371','buy','old','electronic',1),('7','978-21871227080','rent','old','paperback',1),('8','978-15066068498','rent','old','paperback',1);
/*!40000 ALTER TABLE `order_books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_ID` varchar(100) NOT NULL,
  `student_email` varchar(100) DEFAULT NULL,
  `date_created` date NOT NULL,
  `date_fulfilled` date DEFAULT NULL,
  `shipping_type` enum('standard','2-day','1-day','cancelled') NOT NULL,
  `credit_card_num` varchar(20) DEFAULT NULL,
  `credit_card_exp` date DEFAULT NULL,
  `credit_card_name` varchar(100) DEFAULT NULL,
  `credit_card_type` varchar(100) DEFAULT NULL,
  `order_status` enum('new','processed','awaiting shipping','shipping','shipped','cancelled') DEFAULT NULL,
  PRIMARY KEY (`order_ID`),
  KEY `student_email` (`student_email`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`student_email`) REFERENCES `student` (`student_email`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES ('1','JamesTremblay@gmail.com','2014-09-07','2014-09-11','1-day','4.485E+15','2016-03-02','card','VISA','shipped'),('2','KarenPérez@gmail.com','2014-11-04','2014-11-12','standard','4.485E+15','2016-03-01','card','VISA','shipped'),('3','MichaelRamírez@gmail.com','2014-10-06',NULL,'2-day','4.55649E+15','2015-05-01','plastic','VISA','shipping'),('4','MarkFlores@gmail.com','2014-07-04',NULL,'standard','4.92977E+15','2020-09-01','creditc','MASTERCARD','cancelled'),('5','MichaelRamírez@gmail.com','2014-10-13',NULL,'1-day','4.87868E+15','2019-04-01','mycard','VISA','new'),('6','PaulGonzález@gmail.com','2014-10-06','2014-10-07','standard','4.485E+15','2016-03-01','card','VISA','shipped'),('7','PaulGonzález@gmail.com','2014-09-23','2014-09-24','1-day','4.485E+15','2016-03-02','card','VISA','shipped'),('8','PaulGonzález@gmail.com','2014-10-25','2014-10-26','1-day','4.485E+15','2016-03-03','card','VISA','shipped');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommendations`
--

DROP TABLE IF EXISTS `recommendations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recommendations` (
  `student_email` varchar(100) NOT NULL,
  `ISBN_13` varchar(15) NOT NULL,
  `purchase_type` enum('rent','buy') NOT NULL,
  `book_condition` enum('new','old') NOT NULL,
  `the_format` enum('hardcover','paperback','electronic') NOT NULL,
  PRIMARY KEY (`student_email`,`ISBN_13`,`purchase_type`,`book_condition`,`the_format`),
  KEY `ISBN_13` (`ISBN_13`,`purchase_type`,`book_condition`,`the_format`),
  KEY `student_recommendations` (`student_email`),
  CONSTRAINT `recommendations_ibfk_1` FOREIGN KEY (`ISBN_13`, `purchase_type`, `book_condition`, `the_format`) REFERENCES `book` (`ISBN_13`, `purchase_type`, `book_condition`, `the_format`),
  CONSTRAINT `recommendations_ibfk_2` FOREIGN KEY (`student_email`) REFERENCES `student` (`student_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendations`
--

LOCK TABLES `recommendations` WRITE;
/*!40000 ALTER TABLE `recommendations` DISABLE KEYS */;
/*!40000 ALTER TABLE `recommendations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `required_books`
--

DROP TABLE IF EXISTS `required_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `required_books` (
  `course_ID` varchar(125) NOT NULL,
  `semester` enum('Fall','Winter','Spring','Summer') NOT NULL,
  `the_year` smallint(6) NOT NULL,
  `university_ID` varchar(100) NOT NULL,
  `ISBN_13` varchar(15) NOT NULL,
  `purchase_type` enum('rent','buy') NOT NULL,
  `book_condition` enum('new','old') NOT NULL,
  `the_format` enum('hardcover','paperback','electronic') NOT NULL,
  PRIMARY KEY (`course_ID`,`semester`,`the_year`,`university_ID`,`ISBN_13`,`purchase_type`,`book_condition`,`the_format`),
  KEY `university_ID` (`university_ID`),
  KEY `ISBN_13` (`ISBN_13`,`purchase_type`,`book_condition`,`the_format`),
  CONSTRAINT `required_books_ibfk_1` FOREIGN KEY (`course_ID`, `semester`, `the_year`) REFERENCES `course` (`course_ID`, `semester`, `the_year`),
  CONSTRAINT `required_books_ibfk_2` FOREIGN KEY (`university_ID`) REFERENCES `university` (`university_ID`),
  CONSTRAINT `required_books_ibfk_3` FOREIGN KEY (`ISBN_13`, `purchase_type`, `book_condition`, `the_format`) REFERENCES `book` (`ISBN_13`, `purchase_type`, `book_condition`, `the_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `required_books`
--

LOCK TABLES `required_books` WRITE;
/*!40000 ALTER TABLE `required_books` DISABLE KEYS */;
INSERT INTO `required_books` VALUES ('1','Fall',2014,'2','978-0321558237','buy','new','hardcover'),('2','Fall',4,'3','978-0321558237','buy','new','hardcover'),('30','Fall',1,'2','978-0470080245','buy','old','hardcover'),('15','Fall',2,'1','978-10529296110','rent','new','hardcover'),('5','Fall',4,'1','978-11663489207','rent','new','paperback'),('13','Fall',3,'2','978-12797682304','rent','new','paperback'),('6','Fall',4,'2','978-13931875401','rent','old','paperback'),('18','Fall',4,'2','978-13931875402','buy','new','paperback'),('27','Winter',3,'1','978-1455751334','buy','new','hardcover'),('3','Fall',2,'2','978-15066068498','rent','old','paperback'),('25','Fall',1,'2','978-1563477799','buy','new','hardcover'),('20','Fall',2,'2','978-1592575121','buy','new','hardcover'),('4','Fall',1,'2','978-16200261595','rent','old','paperback'),('9','Fall',3,'2','978-17334454692','rent','old','paperback'),('12','Fall',2,'2','978-18468647789','rent','old','paperback'),('11','Fall',4,'2','978-19602840886','rent','old','paperback'),('7','Fall',2,'2','978-20737033983','rent','old','paperback'),('10','Fall',2,'3','978-21871227080','rent','old','paperback'),('19','Fall',4,'3','978-23005420177','buy','old','electronic'),('26','Fall',1,'3','978-24139613274','buy','old','electronic'),('23','Winter',3,'3','978-25273806371','buy','old','electronic'),('28','Winter',4,'1','978-2589944431','buy','new','hardcover'),('29','Winter',2,'3','978-26407999468','buy','old','electronic'),('17','Winter',1,'3','978-27542192565','buy','old','electronic'),('22','Winter',4,'3','978-28676385662','buy','old','electronic'),('21','Winter',3,'3','978-29810578759','buy','old','electronic'),('33','Fall',2,'1','978-3724137528','buy','new','hardcover'),('14','Fall',4,'1','978-4858330625','buy','new','hardcover'),('16','Spring',3,'1','978-5992523722','buy','new','hardcover'),('24','Fall',2,'1','978-5992523723','buy','new','hardcover'),('31','Fall',3,'1','978-7126716819','buy','new','hardcover'),('32','Fall',2,'1','978-8260909916','buy','new','hardcover'),('8','Fall',4,'1','978-9395103013','rent','new','hardcover');
/*!40000 ALTER TABLE `required_books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `student_email` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `birth_date` date NOT NULL,
  `university_ID` varchar(100) DEFAULT NULL,
  `major` varchar(100) DEFAULT NULL,
  `student_status` enum('UnderGrad','Grad') NOT NULL,
  `current_year` smallint(6) NOT NULL,
  PRIMARY KEY (`student_email`),
  KEY `university_ID` (`university_ID`),
  KEY `graduate` (`student_status`),
  KEY `degree` (`major`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`university_ID`) REFERENCES `university` (`university_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('AnthonyFortin@gmail.com','Anthony','Fortin','6946 Oak Drive, Baltimore','1986-08-01','1','Computer Science','UnderGrad',2),('ChristopherRoy@gmail.com','Christopher','Roy','1131 Third Drive, Baltimore','1992-04-24','2','English','UnderGrad',3),('DanielLavoie@gmail.com','Daniel','Lavoie','7283 Sixth Drive, Baltimore','1987-05-27','1','English','UnderGrad',4),('JamesTremblay@gmail.com','James','Tremblay','1866 Second Drive, Baltimore','1992-01-04','2','English','UnderGrad',1),('JohnMorin@gmail.com','John','Morin','7644 Main Drive, Baltimore','1988-03-21','2','English','UnderGrad',1),('KarenPérez@gmail.com','Karen','Pérez','4974 Washington Drive, Baltimore','1980-01-13','3','Sociology','Grad',5),('KevinLópez@gmail.com','Kevin','López','5233 Elm Drive, Baltimore','1981-09-02','1','Sociology','Grad',2),('LauraGarcía@gmail.com','Laura','García','6103 Maple Drive, Baltimore','1984-02-16','1','History','Grad',2),('LeslieGarcía@gmail.com','Leslie','García','6103 Dancer Drive, Baltimore','1984-02-16','1','History','Grad',2),('LewisRodríguez@gmail.com','Lewis','Rodríguez','5202 View Drive, Baltimore','1980-11-07','1','Sociology','Grad',3),('LindaRodríguez@gmail.com','Linda','Rodríguez','5202 View Drive, Baltimore','1980-11-07','1','Sociology','Grad',3),('LisaBouchard@gmail.com','Lisa','Bouchard','8926 Park Drive, Baltimore','1989-11-09','2','English','UnderGrad',4),('MarkFlores@gmail.com','Mark','Flores','4877 Hill Drive, Baltimore','1977-07-30','3','History','Grad',2),('MaryCôté@gmail.com','Mary','Côté','9190 Fourth Drive, Baltimore','1990-09-04','2','English','UnderGrad',3),('MichaelRamírez@gmail.com','Michael','Ramírez','4901 Lake Drive, Baltimore','1978-05-25','3','Sociology','Grad',4),('MichelleGauthier@gmail.com','Michelle','Gauthier','8186 Fifth Drive, Baltimore','1989-01-14','2','English','UnderGrad',2),('NancyMartínez@gmail.com','Nancy','Martínez','6170 Pine Drive, Baltimore','1984-12-11','1','History','Grad',4),('PatriciaGagné@gmail.com','Patricia','Gagné','6377 Seventh Drive, Baltimore','1985-10-06','1','Computer Science','Grad',3),('PaulGonzález@gmail.com','Paul','González','5524 Eighth Drive, Baltimore','1982-06-28','1','History','Grad',1),('RobertHernandez@gmail.com','Robert','Hernandez','5644 Cedar Drive, Baltimore','1983-04-23','1','History','Grad',3),('RonaldGagnon@gmail.com','Ronald','Gagnon','9898 First Drive, Baltimore','1991-06-30','2','English','UnderGrad',2),('SarahSánchez@gmail.com','Sarah','Sánchez','4908 Ninth Drive, Baltimore','1979-03-20','3','Sociology','Grad',2);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_phone_num`
--

DROP TABLE IF EXISTS `student_phone_num`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_phone_num` (
  `student_email` varchar(100) NOT NULL,
  `phone_number` char(10) NOT NULL,
  PRIMARY KEY (`student_email`,`phone_number`),
  CONSTRAINT `student_phone_num_ibfk_1` FOREIGN KEY (`student_email`) REFERENCES `student` (`student_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_phone_num`
--

LOCK TABLES `student_phone_num` WRITE;
/*!40000 ALTER TABLE `student_phone_num` DISABLE KEYS */;
INSERT INTO `student_phone_num` VALUES ('AnthonyFortin@gmail.com','4155992679'),('ChristopherRoy@gmail.com','4155992672'),('DanielLavoie@gmail.com','4155992678'),('JamesTremblay@gmail.com','4155992671'),('JohnMorin@gmail.com','4155992677'),('KarenPérez@gmail.com','4155992687'),('KarenPérez@gmail.com','4155992774'),('KevinLópez@gmail.com','4155992685'),('KevinLópez@gmail.com','4155992703'),('LauraGarcía@gmail.com','4155992682'),('LeslieGarcía@gmail.com','4155992705'),('LewisRodríguez@gmail.com','4155992775'),('LindaRodríguez@gmail.com','4155992686'),('LisaBouchard@gmail.com','4155992675'),('MarkFlores@gmail.com','4155992690'),('MarkFlores@gmail.com','4155992691'),('MarkFlores@gmail.com','4155992692'),('MaryCôté@gmail.com','4155992674'),('MichaelRamírez@gmail.com','4155992689'),('MichaelRamírez@gmail.com','4155992693'),('MichaelRamírez@gmail.com','4155992694'),('MichaelRamírez@gmail.com','4155992695'),('MichelleGauthier@gmail.com','4155992676'),('NancyMartínez@gmail.com','4155992681'),('NancyMartínez@gmail.com','4155992702'),('NancyMartínez@gmail.com','4155992779'),('NancyMartínez@gmail.com','4155992780'),('PatriciaGagné@gmail.com','4155992680'),('PatriciaGagné@gmail.com','4155992773'),('PaulGonzález@gmail.com','4155992684'),('PaulGonzález@gmail.com','4155992696'),('PaulGonzález@gmail.com','4155992697'),('PaulGonzález@gmail.com','4155992698'),('PaulGonzález@gmail.com','4155992699'),('RobertHernandez@gmail.com','4155992683'),('RobertHernandez@gmail.com','4155992776'),('RobertHernandez@gmail.com','4155992777'),('RobertHernandez@gmail.com','4155992778'),('RobertHernandez@gmail.com','4155992780'),('RonaldGagnon@gmail.com','4155992673'),('SarahSánchez@gmail.com','4155992688');
/*!40000 ALTER TABLE `student_phone_num` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_changes`
--

DROP TABLE IF EXISTS `ticket_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_changes` (
  `ticket_ID` char(4) NOT NULL,
  `date_changed` date NOT NULL,
  `changer_ID` char(11) NOT NULL,
  `new_state` enum('new','assigned','in-process','completed') NOT NULL,
  PRIMARY KEY (`ticket_ID`,`date_changed`,`changer_ID`,`new_state`),
  KEY `changer_ID` (`changer_ID`),
  KEY `tickets_changed` (`ticket_ID`),
  CONSTRAINT `ticket_changes_ibfk_1` FOREIGN KEY (`ticket_ID`) REFERENCES `trouble_ticket` (`ticket_ID`),
  CONSTRAINT `ticket_changes_ibfk_2` FOREIGN KEY (`changer_ID`) REFERENCES `employee` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_changes`
--

LOCK TABLES `ticket_changes` WRITE;
/*!40000 ALTER TABLE `ticket_changes` DISABLE KEYS */;
INSERT INTO `ticket_changes` VALUES ('T100','2014-10-24','394-70-2355','assigned'),('T100','2014-10-24','530-70-2948','new'),('T101','2014-07-15','589-42-7539','new'),('T102','2014-08-23','394-70-1948','new'),('T103','2014-02-04','394-70-1948','new'),('T103','2014-02-05','768-32-1435','assigned'),('T103','2014-02-06','768-32-1435','in-process'),('T104','2014-10-05','394-70-1948','new'),('T106','2014-08-05','394-70-1948','new'),('T106','2014-08-06','768-32-1435','assigned'),('T106','2014-08-07','768-32-1435','in-process'),('T106','2014-08-09','768-32-1435','completed'),('T114','2014-09-05','394-70-1948','new'),('T120','2014-08-31','520-70-7856','new'),('T121','2014-10-24','520-70-7856','new'),('T121','2014-10-25','234-45-1935','assigned'),('T130','2014-12-01','530-70-2953','new');
/*!40000 ALTER TABLE `ticket_changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trouble_ticket`
--

DROP TABLE IF EXISTS `trouble_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trouble_ticket` (
  `ticket_ID` char(4) NOT NULL,
  `category` char(100) NOT NULL,
  `date_created` date DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `date_completed` date DEFAULT NULL,
  `problem_description` varchar(200) DEFAULT NULL,
  `problem_fix` varchar(200) DEFAULT NULL,
  `state` enum('new','assigned','in-process','completed') DEFAULT NULL,
  `fixer_ID` char(11) DEFAULT NULL,
  PRIMARY KEY (`ticket_ID`),
  KEY `fixer_ID` (`fixer_ID`),
  KEY `ticket_state` (`state`),
  CONSTRAINT `trouble_ticket_ibfk_1` FOREIGN KEY (`fixer_ID`) REFERENCES `employee` (`SSN`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trouble_ticket`
--

LOCK TABLES `trouble_ticket` WRITE;
/*!40000 ALTER TABLE `trouble_ticket` DISABLE KEYS */;
INSERT INTO `trouble_ticket` VALUES ('T100','orders','2014-10-24','bug in orders',NULL,'1 order got cancelled automatically',NULL,'assigned',NULL),('T101','userprofile','2014-07-15','unable to log in',NULL,'password reset needed',NULL,'new',NULL),('T102','products','2014-08-23','bad / damaged product recieved ',NULL,'',NULL,'new',NULL),('T103','cart','2014-02-04','cart not updating',NULL,'cant delete stuff from the cart',NULL,'in-process',NULL),('T104','orders','2014-10-05','order not recieved',NULL,'i have still not recieved my order. it has been 10 days',NULL,'new',NULL),('T106','userprofile','2014-08-05','password lost','2014-08-09','','new password issued','completed','768-32-1435'),('T114','userprofile','2014-09-05','unable to edit details on profile',NULL,'',NULL,'new',NULL),('T120','products','2014-08-31','pages missing from the book',NULL,'chapter 5 of the book i ordered is missing',NULL,'new',NULL),('T121','userprofile','2014-10-24','forgotten password',NULL,'password needs to be reset after verification',NULL,'assigned',NULL),('T130','cart','2014-12-01','proposed maintance work',NULL,'yearly update scheduled',NULL,'new',NULL);
/*!40000 ALTER TABLE `trouble_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trouble_ticket_employee`
--

DROP TABLE IF EXISTS `trouble_ticket_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trouble_ticket_employee` (
  `ticket_ID` char(4) NOT NULL,
  `creator_ID` char(11) DEFAULT NULL,
  PRIMARY KEY (`ticket_ID`),
  KEY `creator_ID` (`creator_ID`),
  CONSTRAINT `trouble_ticket_employee_ibfk_1` FOREIGN KEY (`ticket_ID`) REFERENCES `trouble_ticket` (`ticket_ID`),
  CONSTRAINT `trouble_ticket_employee_ibfk_2` FOREIGN KEY (`creator_ID`) REFERENCES `employee` (`SSN`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trouble_ticket_employee`
--

LOCK TABLES `trouble_ticket_employee` WRITE;
/*!40000 ALTER TABLE `trouble_ticket_employee` DISABLE KEYS */;
INSERT INTO `trouble_ticket_employee` VALUES ('T100','530-70-2948'),('T130','530-70-2953');
/*!40000 ALTER TABLE `trouble_ticket_employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trouble_ticket_student`
--

DROP TABLE IF EXISTS `trouble_ticket_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trouble_ticket_student` (
  `ticket_ID` char(4) NOT NULL,
  `creator_ID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ticket_ID`),
  KEY `creator_ID` (`creator_ID`),
  CONSTRAINT `trouble_ticket_student_ibfk_1` FOREIGN KEY (`ticket_ID`) REFERENCES `trouble_ticket` (`ticket_ID`),
  CONSTRAINT `trouble_ticket_student_ibfk_2` FOREIGN KEY (`creator_ID`) REFERENCES `student` (`student_email`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trouble_ticket_student`
--

LOCK TABLES `trouble_ticket_student` WRITE;
/*!40000 ALTER TABLE `trouble_ticket_student` DISABLE KEYS */;
INSERT INTO `trouble_ticket_student` VALUES ('T121','JohnMorin@gmail.com'),('T120','KevinLópez@gmail.com'),('T101','MarkFlores@gmail.com'),('T102','MichaelRamírez@gmail.com'),('T114','MichaelRamírez@gmail.com'),('T103','NancyMartínez@gmail.com'),('T104','PaulGonzález@gmail.com'),('T106','RobertHernandez@gmail.com');
/*!40000 ALTER TABLE `trouble_ticket_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `university`
--

DROP TABLE IF EXISTS `university`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `university` (
  `university_ID` varchar(100) NOT NULL,
  `university_name` varchar(100) NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`university_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `university`
--

LOCK TABLES `university` WRITE;
/*!40000 ALTER TABLE `university` DISABLE KEYS */;
INSERT INTO `university` VALUES ('1','UMBC','1000 Hilltop Cir, Baltimore, MD 21250'),('2','Towson','8000 York Rd, Towson, MD 21252'),('3','UMCP','College Park, MD 20742');
/*!40000 ALTER TABLE `university` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `university_rep`
--

DROP TABLE IF EXISTS `university_rep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `university_rep` (
  `SSN` char(11) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `university_ID` varchar(100) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `phone_num` char(12) DEFAULT NULL,
  `gender` enum('Male','Female') DEFAULT NULL,
  PRIMARY KEY (`SSN`),
  KEY `university_ID` (`university_ID`),
  CONSTRAINT `university_rep_ibfk_1` FOREIGN KEY (`university_ID`) REFERENCES `university` (`university_ID`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `university_rep`
--

LOCK TABLES `university_rep` WRITE;
/*!40000 ALTER TABLE `university_rep` DISABLE KEYS */;
INSERT INTO `university_rep` VALUES ('307-55-0159','ruth.north@towson.edu','2','Ruth','North','307-555-0159','Female'),('307-55-0183','dominic.lambert@umbc.edu','1','Dominic','Lambert','307-555-0183','Male'),('307-55-0192','victoria.murray@umcp.edu','3','Victoria','Murray','307-555-0192','Female');
/*!40000 ALTER TABLE `university_rep` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-12  2:46:19
