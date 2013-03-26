-- execute as:
-- sqlite3 nnexus.db < schema.sql
-- also consult the README file

-- MySQL dump 10.13  Distrib 5.1.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: nnexusdev
-- ------------------------------------------------------
-- Server version	5.1.41-3ubuntu12.10

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `categoryid` integer primary key AUTOINCREMENT,
  `categoryname` varchar(100) NOT NULL DEFAULT '',
  `externalid` text,
  `scheme` varchar(50) NOT NULL DEFAULT ''
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classification`
--

DROP TABLE IF EXISTS `classification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classification` (
  `objectid` int(11) NOT NULL DEFAULT '0',
  `class` text,
  `scheme` varchar(50) DEFAULT NULL
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `concepthash`
--

DROP TABLE IF EXISTS `concepthash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concepthash` (
  `firstword` varchar(255) NOT NULL DEFAULT '',
  `concept` varchar(255) NOT NULL DEFAULT '',
  `objectid` int(11) NOT NULL DEFAULT '0'
   --KEY `firstword` (`firstword`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `domain`
--

DROP TABLE IF EXISTS `domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain` (
  `domainid` integer primary key AUTOINCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `urltemplate` varchar(100) DEFAULT NULL,
  `code` varchar(2) DEFAULT NULL,
  `priority` varchar(30) DEFAULT '',
  `nickname` varchar(50) DEFAULT NULL
--  UNIQUE KEY `nameindex` (`name`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_dfs`
--

DROP TABLE IF EXISTS `inv_dfs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_dfs` (
  `id` int(11) DEFAULT '0',
  `word_or_phrase` tinyint(4) DEFAULT '0',
  `count` int(11) DEFAULT '0'
--  KEY `ididx` (`id`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_idx`
--

DROP TABLE IF EXISTS `inv_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_idx` (
  `id` int(11) DEFAULT '0',
  `word_or_phrase` tinyint(4) DEFAULT '0',
  `objectid` int(11) DEFAULT '0'
--  KEY `ididx` (`id`),
--  KEY `objididx` (`objectid`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_phrases`
--

DROP TABLE IF EXISTS `inv_phrases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_phrases` (
  `id` integer primary key AUTOINCREMENT,
  `phrase` char(255) DEFAULT ''
  --KEY `phrase_idx` (`phrase`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_words`
--

DROP TABLE IF EXISTS `inv_words`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_words` (
  `id` integer primary key AUTOINCREMENT,
  `word` char(128) DEFAULT ''
 -- UNIQUE KEY `word_idx` (`word`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `links`
--

DROP TABLE IF EXISTS `links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `links` (
  `fromid` int(11) NOT NULL DEFAULT '0',
  `toid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`fromid`,`toid`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `object`
--

DROP TABLE IF EXISTS `object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object` (
  `objectid` integer primary key AUTOINCREMENT,
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `domainid` int(11) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  `linkpolicy` text,
  `authorid` int(11) DEFAULT '0',
  `valid` tinyint(4) DEFAULT '0',
  `body` text
--  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--  UNIQUE KEY `domainid` (`domainid`,`identifier`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ontology`
--

DROP TABLE IF EXISTS `ontology`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ontology` (
  `child` varchar(100) DEFAULT NULL,
  `parent` varchar(100) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL
 -- UNIQUE KEY `uniquetree` (`child`,`parent`,`weight`)
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-02-18 15:42:17
