CREATE DATABASE  IF NOT EXISTS `soccorso` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `soccorso`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: soccorso
-- ------------------------------------------------------
-- Server version	8.4.5

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
-- Table structure for table `abilita`
--

DROP TABLE IF EXISTS `abilita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abilita` (
  `ID_Abilita` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_Abilita`),
  UNIQUE KEY `Nome` (`Nome`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abilita`
--

LOCK TABLES `abilita` WRITE;
/*!40000 ALTER TABLE `abilita` DISABLE KEYS */;
INSERT INTO `abilita` VALUES (5,'Alpinismo'),(10,'Emergenze chimiche'),(4,'Guida Fuoristrada'),(6,'Nuoto di soccorso'),(7,'Orientamento GPS'),(1,'Primo Soccorso'),(9,'Scalata'),(2,'Spegnimento Incendi'),(3,'Uso Defibrillatore'),(8,'Uso radio');
/*!40000 ALTER TABLE `abilita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amministratore`
--

DROP TABLE IF EXISTS `amministratore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amministratore` (
  `ID_Amministratore` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(50) NOT NULL,
  `Cognome` varchar(50) NOT NULL,
  `DataNascita` date NOT NULL,
  PRIMARY KEY (`ID_Amministratore`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amministratore`
--

LOCK TABLES `amministratore` WRITE;
/*!40000 ALTER TABLE `amministratore` DISABLE KEYS */;
INSERT INTO `amministratore` VALUES (1,'Luca','Bianchi','1980-03-15'),(2,'Anna','Rossi','1975-07-22'),(3,'Marco','Verdi','1982-11-10'),(4,'Giulia','Ferrari','1990-05-02'),(5,'Paolo','Galli','1988-01-30'),(6,'Francesca','Neri','1983-08-11'),(7,'Giorgio','Barbieri','1978-02-20'),(8,'Elena','Bianco','1985-12-05'),(9,'Riccardo','Cattaneo','1991-09-18'),(10,'Simona','Fabbri','1987-06-23');
/*!40000 ALTER TABLE `amministratore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amministratore_possiede_abilita`
--

DROP TABLE IF EXISTS `amministratore_possiede_abilita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amministratore_possiede_abilita` (
  `ID_Amministratore` int NOT NULL,
  `ID_Abilita` int NOT NULL,
  PRIMARY KEY (`ID_Amministratore`,`ID_Abilita`),
  KEY `ID_Abilita` (`ID_Abilita`),
  CONSTRAINT `amministratore_possiede_abilita_ibfk_1` FOREIGN KEY (`ID_Amministratore`) REFERENCES `amministratore` (`ID_Amministratore`),
  CONSTRAINT `amministratore_possiede_abilita_ibfk_2` FOREIGN KEY (`ID_Abilita`) REFERENCES `abilita` (`ID_Abilita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amministratore_possiede_abilita`
--

LOCK TABLES `amministratore_possiede_abilita` WRITE;
/*!40000 ALTER TABLE `amministratore_possiede_abilita` DISABLE KEYS */;
INSERT INTO `amministratore_possiede_abilita` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `amministratore_possiede_abilita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `amministratore_possiede_patente`
--

DROP TABLE IF EXISTS `amministratore_possiede_patente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amministratore_possiede_patente` (
  `ID_Amministratore` int NOT NULL,
  `ID_Patente` int NOT NULL,
  PRIMARY KEY (`ID_Amministratore`,`ID_Patente`),
  KEY `ID_Patente` (`ID_Patente`),
  CONSTRAINT `amministratore_possiede_patente_ibfk_1` FOREIGN KEY (`ID_Amministratore`) REFERENCES `amministratore` (`ID_Amministratore`),
  CONSTRAINT `amministratore_possiede_patente_ibfk_2` FOREIGN KEY (`ID_Patente`) REFERENCES `patente` (`ID_Patente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amministratore_possiede_patente`
--

LOCK TABLES `amministratore_possiede_patente` WRITE;
/*!40000 ALTER TABLE `amministratore_possiede_patente` DISABLE KEYS */;
INSERT INTO `amministratore_possiede_patente` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `amministratore_possiede_patente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `composizione_squadra`
--

DROP TABLE IF EXISTS `composizione_squadra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `composizione_squadra` (
  `ID_Squadra` int NOT NULL,
  `ID_Operatore` int NOT NULL,
  `Ruolo` enum('Caposquadra','Operatore') NOT NULL,
  PRIMARY KEY (`ID_Squadra`,`ID_Operatore`),
  KEY `ID_Operatore` (`ID_Operatore`),
  CONSTRAINT `composizione_squadra_ibfk_1` FOREIGN KEY (`ID_Squadra`) REFERENCES `squadra` (`ID_Squadra`),
  CONSTRAINT `composizione_squadra_ibfk_2` FOREIGN KEY (`ID_Operatore`) REFERENCES `operatore` (`ID_Operatore`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `composizione_squadra`
--

LOCK TABLES `composizione_squadra` WRITE;
/*!40000 ALTER TABLE `composizione_squadra` DISABLE KEYS */;
INSERT INTO `composizione_squadra` VALUES (1,1,'Caposquadra'),(1,2,'Operatore'),(2,3,'Caposquadra'),(3,4,'Caposquadra'),(4,5,'Caposquadra'),(6,6,'Caposquadra'),(6,7,'Operatore'),(7,8,'Caposquadra'),(8,9,'Caposquadra'),(9,10,'Caposquadra');
/*!40000 ALTER TABLE `composizione_squadra` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_check_caposquadra_insert` BEFORE INSERT ON `composizione_squadra` FOR EACH ROW BEGIN
    DECLARE caposquadra_count INT;
    IF NEW.Ruolo = 'Operatore' THEN
        SELECT COUNT(*) INTO caposquadra_count
        FROM Composizione_Squadra
        WHERE ID_Squadra = NEW.ID_Squadra
          AND Ruolo = 'Caposquadra';
        IF caposquadra_count = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Ogni squadra deve avere almeno un caposquadra';
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_check_caposquadra_update` BEFORE UPDATE ON `composizione_squadra` FOR EACH ROW BEGIN
    DECLARE caposquadra_count INT;

    IF OLD.Ruolo = 'Caposquadra' AND NEW.Ruolo = 'Operatore' THEN
        SELECT COUNT(*) INTO caposquadra_count
        FROM Composizione_Squadra
        WHERE ID_Squadra = OLD.ID_Squadra
          AND Ruolo = 'Caposquadra'
          AND ID_Operatore <> OLD.ID_Operatore;

        IF caposquadra_count = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Non puoi degradare l\'ultimo caposquadra della squadra.';
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_check_caposquadra_delete` BEFORE DELETE ON `composizione_squadra` FOR EACH ROW BEGIN
    DECLARE caposquadra_count INT;

    IF OLD.ruolo = 'Caposquadra' THEN
        SELECT COUNT(*) INTO caposquadra_count
        FROM Composizione_Squadra
        WHERE ID_Squadra = OLD.ID_Squadra
          AND Ruolo = 'Caposquadra'
          AND ID_Operatore <> OLD.ID_Operatore;

        IF caposquadra_count = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Non puoi rimuovere l\'ultimo caposquadra della squadra.';
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `materiale`
--

DROP TABLE IF EXISTS `materiale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materiale` (
  `ID_Materiale` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(50) NOT NULL,
  `Descrizione` text,
  PRIMARY KEY (`ID_Materiale`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materiale`
--

LOCK TABLES `materiale` WRITE;
/*!40000 ALTER TABLE `materiale` DISABLE KEYS */;
INSERT INTO `materiale` VALUES (1,'Barelle','Barelle pieghevoli per trasporto feriti'),(2,'Kit Medico','Set completo di pronto soccorso'),(3,'Estintori','Estintori portatili'),(4,'Corde','Corde da alpinismo'),(5,'Tende','Tende per campo base'),(6,'Zattere','Zattere di salvataggio'),(7,'GPS','Dispositivo GPS portatile'),(8,'Radio','Radio per comunicazioni'),(9,'Imbrago','Imbrago per arrampicata'),(10,'Maschere chimiche','Maschere protettive per sostanze chimiche');
/*!40000 ALTER TABLE `materiale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materiali_usati_missione`
--

DROP TABLE IF EXISTS `materiali_usati_missione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materiali_usati_missione` (
  `ID_Missione` int NOT NULL,
  `ID_Materiale` int NOT NULL,
  PRIMARY KEY (`ID_Missione`,`ID_Materiale`),
  KEY `ID_Materiale` (`ID_Materiale`),
  CONSTRAINT `materiali_usati_missione_ibfk_1` FOREIGN KEY (`ID_Missione`) REFERENCES `missione` (`ID_Missione`),
  CONSTRAINT `materiali_usati_missione_ibfk_2` FOREIGN KEY (`ID_Materiale`) REFERENCES `materiale` (`ID_Materiale`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materiali_usati_missione`
--

LOCK TABLES `materiali_usati_missione` WRITE;
/*!40000 ALTER TABLE `materiali_usati_missione` DISABLE KEYS */;
INSERT INTO `materiali_usati_missione` VALUES (1,1),(1,2),(2,2),(3,3),(4,4),(5,5),(6,6),(6,7),(7,7);
/*!40000 ALTER TABLE `materiali_usati_missione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mezzi_usati_missione`
--

DROP TABLE IF EXISTS `mezzi_usati_missione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mezzi_usati_missione` (
  `ID_Missione` int NOT NULL,
  `ID_Mezzo` int NOT NULL,
  PRIMARY KEY (`ID_Missione`,`ID_Mezzo`),
  KEY `ID_Mezzo` (`ID_Mezzo`),
  CONSTRAINT `mezzi_usati_missione_ibfk_1` FOREIGN KEY (`ID_Missione`) REFERENCES `missione` (`ID_Missione`),
  CONSTRAINT `mezzi_usati_missione_ibfk_2` FOREIGN KEY (`ID_Mezzo`) REFERENCES `mezzo` (`ID_Mezzo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mezzi_usati_missione`
--

LOCK TABLES `mezzi_usati_missione` WRITE;
/*!40000 ALTER TABLE `mezzi_usati_missione` DISABLE KEYS */;
INSERT INTO `mezzi_usati_missione` VALUES (1,1),(2,1),(1,2),(3,3),(4,4),(5,5),(6,6),(6,7),(7,7);
/*!40000 ALTER TABLE `mezzi_usati_missione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mezzo`
--

DROP TABLE IF EXISTS `mezzo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mezzo` (
  `ID_Mezzo` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(50) NOT NULL,
  `Descrizione` text,
  PRIMARY KEY (`ID_Mezzo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mezzo`
--

LOCK TABLES `mezzo` WRITE;
/*!40000 ALTER TABLE `mezzo` DISABLE KEYS */;
INSERT INTO `mezzo` VALUES (1,'Ambulanza','Ambulanza attrezzata per emergenze'),(2,'Fuoristrada','Veicolo 4x4 per terreni difficili'),(3,'Camion','Camion per trasporto materiali'),(4,'Motocicletta','Moto per interventi rapidi'),(5,'Elicottero','Elicottero per soccorsi aerei'),(6,'Gommone','Imbarcazione per soccorsi in acqua'),(7,'Quad','Veicolo agile per terreni difficili'),(8,'Camion frigo','Camion per trasporto medicinali'),(9,'Drago UAV','Drone per ricognizione'),(10,'Trattore','Veicolo per soccorso in campagna');
/*!40000 ALTER TABLE `mezzo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `missione`
--

DROP TABLE IF EXISTS `missione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `missione` (
  `ID_Missione` int NOT NULL AUTO_INCREMENT,
  `Obiettivo` text NOT NULL,
  `TimestampInizio` datetime NOT NULL,
  `TimestampFine` datetime DEFAULT NULL,
  `Commenti` text,
  `Successo` tinyint unsigned DEFAULT NULL,
  `ID_Richiesta` int NOT NULL,
  `ID_Squadra` int NOT NULL,
  PRIMARY KEY (`ID_Missione`),
  UNIQUE KEY `ID_Richiesta` (`ID_Richiesta`),
  KEY `ID_Squadra` (`ID_Squadra`),
  CONSTRAINT `missione_ibfk_1` FOREIGN KEY (`ID_Richiesta`) REFERENCES `richiesta` (`ID_Richiesta`),
  CONSTRAINT `missione_ibfk_2` FOREIGN KEY (`ID_Squadra`) REFERENCES `squadra` (`ID_Squadra`),
  CONSTRAINT `missione_chk_1` CHECK ((`Successo` between 0 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `missione`
--

LOCK TABLES `missione` WRITE;
/*!40000 ALTER TABLE `missione` DISABLE KEYS */;
INSERT INTO `missione` VALUES (1,'Assistenza sanitaria','2025-02-14 14:15:00','2025-02-14 15:00:00','Paziente stabilizzato',4,2,2),(2,'Spegnimento incendio','2025-03-20 18:00:00','2025-03-20 21:00:00','Incendio domato',5,3,3),(3,'Ricerca dispersi','2025-04-05 09:45:00','2025-04-05 16:00:00','Dispersi ritrovati indenni',5,4,4),(4,'Soccorso montagna','2025-06-15 07:00:00','2025-06-15 11:30:00','Soccorso completato',5,6,6),(5,'Spegnimento incendio bosco','2025-07-20 13:30:00',NULL,NULL,NULL,7,7),(6,'Gestione alluvione','2025-09-12 08:45:00','2025-09-12 13:00:00','Alluvione gestita',4,9,9),(7,'Recupero in mare','2025-10-01 10:00:00','2025-10-01 12:45:00','Recupero riuscito',5,10,10),(8,'Soccorso in montagna','2025-08-31 18:58:01',NULL,NULL,NULL,5,1);
/*!40000 ALTER TABLE `missione` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_richiesta_attiva` BEFORE INSERT ON `missione` FOR EACH ROW BEGIN
    DECLARE stato_richiesta VARCHAR(20);

    SELECT Stato
    INTO stato_richiesta
    FROM Richiesta
    WHERE ID_Richiesta = NEW.ID_Richiesta;

    IF stato_richiesta <> 'Attiva' THEN
		SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Impossibile creare la missione: richiesta non attiva';
	ELSE -- La Richiesta è Attiva
		IF (NEW.TimestampFine IS NULL) AND (NEW.Successo IS NULL) AND (NEW.Commenti IS NULL) THEN
			SET @skip_richiesta_check = 1;
			UPDATE Richiesta SET Stato = 'In Corso' WHERE ID_Richiesta = NEW.ID_Richiesta;
            SET @skip_richiesta_check = NULL;
		ELSE
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Impossibile creare la missione: stai chiudendo una Missione non ancora creata';
		END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_missione_tsinizio` BEFORE INSERT ON `missione` FOR EACH ROW BEGIN
    DECLARE ts_richiesta DATETIME;

	SELECT TimestampRichiesta
	INTO ts_richiesta
	FROM Richiesta
	WHERE ID_Richiesta = NEW.ID_Richiesta;
        
	IF NEW.TimestampInizio < ts_richiesta THEN
		SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Impossibile inserire la missione: Timestamp incoerente con la Richiesta';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_missione_chiusa` BEFORE UPDATE ON `missione` FOR EACH ROW BEGIN
     DECLARE stato_richiesta VARCHAR(20);

    SELECT Stato
    INTO stato_richiesta
    FROM Richiesta
    WHERE ID_Richiesta = NEW.ID_Richiesta;

    IF stato_richiesta = 'Chiusa' OR stato_richiesta = 'Annullata' THEN
		SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = 'Impossibile aggiornare la missione: la missione è ormai archiviata';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_fine_missione` BEFORE UPDATE ON `missione` FOR EACH ROW BEGIN
	DECLARE richiesta INT;
	DECLARE stato_richiesta VARCHAR(20);
    -- Il Trigger agisce solo se sto aggiornando gli attributi interessati
    IF (NEW.TimestampFine IS NOT NULL) OR (NEW.Successo IS NOT NULL) OR (NEW.Commenti IS NOT NULL) THEN
		SELECT ID_Richiesta
		INTO richiesta
		FROM Missione
		WHERE ID_Missione = NEW.ID_Missione;
    
		SELECT Stato
		INTO stato_richiesta
		FROM Richiesta
		WHERE ID_Richiesta = richiesta;

		IF stato_richiesta <> 'In Corso' THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Impossibile chiudere la missione: richiesta non in corso';
		ELSE -- La Richiesta è In Corso
			IF (NEW.TimestampFine IS NOT NULL) AND (NEW.Successo IS NOT NULL) THEN
				SET @skip_richiesta_check = 1;
				UPDATE Richiesta SET Stato = 'Chiusa' WHERE ID_Richiesta = richiesta;
                SET @skip_richiesta_check = NULL;
			ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Impossibile chiudere la missione: mancano alcuni valori';
			END IF;
		END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_missione_tsfine` BEFORE UPDATE ON `missione` FOR EACH ROW BEGIN
    IF NEW.TimestampFine < NEW.TimestampInizio THEN
		SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Impossibile inserire la missione: Timestamp incoerente con la Missione';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `missioni_aggiornate`
--

DROP TABLE IF EXISTS `missioni_aggiornate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `missioni_aggiornate` (
  `ID_Missione` int NOT NULL,
  `ID_Amministratore` int NOT NULL,
  `TimestampInserimento` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Commento` text NOT NULL,
  PRIMARY KEY (`ID_Missione`,`ID_Amministratore`,`TimestampInserimento`),
  KEY `ID_Amministratore` (`ID_Amministratore`),
  CONSTRAINT `missioni_aggiornate_ibfk_1` FOREIGN KEY (`ID_Missione`) REFERENCES `missione` (`ID_Missione`),
  CONSTRAINT `missioni_aggiornate_ibfk_2` FOREIGN KEY (`ID_Amministratore`) REFERENCES `amministratore` (`ID_Amministratore`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `missioni_aggiornate`
--

LOCK TABLES `missioni_aggiornate` WRITE;
/*!40000 ALTER TABLE `missioni_aggiornate` DISABLE KEYS */;
INSERT INTO `missioni_aggiornate` VALUES (1,2,'2025-02-14 14:30:00','Aggiornamento: paziente trasportato'),(2,3,'2025-03-20 19:00:00','Aggiornamento: incendio sotto controllo'),(3,4,'2025-04-05 12:00:00','Aggiornamento: zona perimetrata'),(4,6,'2025-06-15 08:00:00','Squadra in avvicinamento'),(5,7,'2025-07-20 14:00:00','Fiamme sotto controllo'),(6,9,'2025-09-12 09:15:00','Allerta fiumi'),(7,10,'2025-10-01 10:30:00','Imbarcazioni pronte');
/*!40000 ALTER TABLE `missioni_aggiornate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operatore`
--

DROP TABLE IF EXISTS `operatore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operatore` (
  `ID_Operatore` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(50) NOT NULL,
  `Cognome` varchar(50) NOT NULL,
  `DataNascita` date NOT NULL,
  PRIMARY KEY (`ID_Operatore`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operatore`
--

LOCK TABLES `operatore` WRITE;
/*!40000 ALTER TABLE `operatore` DISABLE KEYS */;
INSERT INTO `operatore` VALUES (1,'Matteo','Romano','1995-06-18'),(2,'Chiara','Colombo','1992-12-25'),(3,'Davide','Ricci','1989-09-09'),(4,'Elisa','Marini','1994-04-14'),(5,'Francesco','Conti','1990-10-05'),(6,'Sara','Gallo','1993-03-03'),(7,'Lorenzo','Grassi','1988-07-14'),(8,'Federica','Moretti','1990-11-22'),(9,'Alessandro','Riva','1992-05-09'),(10,'Valentina','Marchetti','1991-10-30');
/*!40000 ALTER TABLE `operatore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operatore_possiede_abilita`
--

DROP TABLE IF EXISTS `operatore_possiede_abilita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operatore_possiede_abilita` (
  `ID_Operatore` int NOT NULL,
  `ID_Abilita` int NOT NULL,
  PRIMARY KEY (`ID_Operatore`,`ID_Abilita`),
  KEY `ID_Abilita` (`ID_Abilita`),
  CONSTRAINT `operatore_possiede_abilita_ibfk_1` FOREIGN KEY (`ID_Operatore`) REFERENCES `operatore` (`ID_Operatore`),
  CONSTRAINT `operatore_possiede_abilita_ibfk_2` FOREIGN KEY (`ID_Abilita`) REFERENCES `abilita` (`ID_Abilita`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operatore_possiede_abilita`
--

LOCK TABLES `operatore_possiede_abilita` WRITE;
/*!40000 ALTER TABLE `operatore_possiede_abilita` DISABLE KEYS */;
INSERT INTO `operatore_possiede_abilita` VALUES (5,1),(1,2),(2,3),(3,4),(4,5),(10,6),(6,7),(7,8),(8,9),(9,10);
/*!40000 ALTER TABLE `operatore_possiede_abilita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operatore_possiede_patente`
--

DROP TABLE IF EXISTS `operatore_possiede_patente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operatore_possiede_patente` (
  `ID_Operatore` int NOT NULL,
  `ID_Patente` int NOT NULL,
  PRIMARY KEY (`ID_Operatore`,`ID_Patente`),
  KEY `ID_Patente` (`ID_Patente`),
  CONSTRAINT `operatore_possiede_patente_ibfk_1` FOREIGN KEY (`ID_Operatore`) REFERENCES `operatore` (`ID_Operatore`),
  CONSTRAINT `operatore_possiede_patente_ibfk_2` FOREIGN KEY (`ID_Patente`) REFERENCES `patente` (`ID_Patente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operatore_possiede_patente`
--

LOCK TABLES `operatore_possiede_patente` WRITE;
/*!40000 ALTER TABLE `operatore_possiede_patente` DISABLE KEYS */;
INSERT INTO `operatore_possiede_patente` VALUES (5,1),(1,2),(2,3),(3,4),(4,5),(10,6),(6,7),(7,8),(8,9),(9,10);
/*!40000 ALTER TABLE `operatore_possiede_patente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patente`
--

DROP TABLE IF EXISTS `patente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patente` (
  `ID_Patente` int NOT NULL AUTO_INCREMENT,
  `Tipo` varchar(30) NOT NULL,
  PRIMARY KEY (`ID_Patente`),
  UNIQUE KEY `Tipo` (`Tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patente`
--

LOCK TABLES `patente` WRITE;
/*!40000 ALTER TABLE `patente` DISABLE KEYS */;
INSERT INTO `patente` VALUES (1,'A'),(2,'B'),(3,'C'),(4,'D'),(5,'E'),(6,'F'),(7,'G'),(8,'H'),(9,'I'),(10,'J');
/*!40000 ALTER TABLE `patente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `query10`
--

DROP TABLE IF EXISTS `query10`;
/*!50001 DROP VIEW IF EXISTS `query10`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `query10` AS SELECT 
 1 AS `ID_Richiesta`,
 1 AS `Descrizione`,
 1 AS `Indirizzo`,
 1 AS `Coordinate`,
 1 AS `TimestampFine`,
 1 AS `Successo`,
 1 AS `Commenti`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `query11`
--

DROP TABLE IF EXISTS `query11`;
/*!50001 DROP VIEW IF EXISTS `query11`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `query11` AS SELECT 
 1 AS `ID_Operatore`,
 1 AS `Nome`,
 1 AS `Cognome`,
 1 AS `NumeroMissioniNonPositive`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `query4`
--

DROP TABLE IF EXISTS `query4`;
/*!50001 DROP VIEW IF EXISTS `query4`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `query4` AS SELECT 
 1 AS `ID_Operatore`,
 1 AS `Nome`,
 1 AS `Cognome`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `richiesta`
--

DROP TABLE IF EXISTS `richiesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `richiesta` (
  `ID_Richiesta` int NOT NULL AUTO_INCREMENT,
  `Link` varchar(255) NOT NULL,
  `IP` varchar(45) NOT NULL,
  `Stato` enum('Inviata','Attiva','In Corso','Chiusa','Annullata') NOT NULL DEFAULT 'Inviata',
  `Foto` varchar(255) DEFAULT NULL,
  `Coordinate` varchar(100) NOT NULL,
  `Indirizzo` varchar(255) NOT NULL,
  `Descrizione` text NOT NULL,
  `TimestampRichiesta` datetime NOT NULL,
  `ID_Segnalatore` int NOT NULL,
  `ID_Amministratore` int NOT NULL,
  PRIMARY KEY (`ID_Richiesta`),
  KEY `ID_Segnalatore` (`ID_Segnalatore`),
  KEY `ID_Amministratore` (`ID_Amministratore`),
  CONSTRAINT `richiesta_ibfk_1` FOREIGN KEY (`ID_Segnalatore`) REFERENCES `segnalatore` (`ID_Segnalatore`),
  CONSTRAINT `richiesta_ibfk_2` FOREIGN KEY (`ID_Amministratore`) REFERENCES `amministratore` (`ID_Amministratore`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `richiesta`
--

LOCK TABLES `richiesta` WRITE;
/*!40000 ALTER TABLE `richiesta` DISABLE KEYS */;
INSERT INTO `richiesta` VALUES (1,'https://a0416dd4-868b-11f0-b883-c8d9d2a9c9d0','192.168.0.1','Inviata','https://drive.google.com/file/d/1phBFwNtTshERYU7-qBAY7uN998Y2QZvc/view?usp=sharing','45.4642,9.19','Via Roma 10, Milano','Incidente stradale','2025-08-19 12:45:23',1,1),(2,'https://a0417c0b-868b-11f0-b883-c8d9d2a9c9d0','192.168.0.2','Chiusa',NULL,'41.9028,12.4964','Piazza Venezia, Roma','Malore improvviso','2025-08-19 09:18:57',2,2),(3,'https://a0418116-868b-11f0-b883-c8d9d2a9c9d0','192.168.0.3','Chiusa',NULL,'40.8518,14.2681','Via Toledo, Napoli','Incendio appartamento','2025-08-19 16:02:41',3,3),(4,'https://a041851d-868b-11f0-b883-c8d9d2a9c9d0','192.168.0.4','Chiusa',NULL,'44.4949,11.3426','Piazza Maggiore, Bologna','Escursionista disperso','2025-08-18 23:59:10',4,4),(5,'https://a0418e87-868b-11f0-b883-c8d9d2a9c9d0','192.168.0.5','In Corso',NULL,'45.4384,10.9916','Piazza Bra, Verona','Caduta in montagna','2025-08-19 14:37:05',5,5),(6,'https://a04190e2-868b-11f0-b883-c8d9d2a9c9d0','192.168.0.6','Chiusa',NULL,'45.0703,7.6869','Piazza Castello, Torino','Infortunio in montagna','2025-08-19 08:12:48',6,6),(7,'https://a041938a-868b-11f0-b883-c8d9d2a9c9d0','192.168.0.7','In Corso','https://drive.google.com/file/d/1Ssc4Qn03QhhmaQ96jGGx-MP2zucT1o15/view?usp=sharing','44.6471,10.9252','Piazza Verdi, Parma','Incendio bosco','2025-08-19 15:50:33',7,7),(8,'https://a041980a-868b-11f0-b883-c8d9d2a9c9d0','192.168.0.8','Attiva',NULL,'45.5017,9.2067','Via XX Settembre, Como','Persona dispersa','2025-08-19 00:27:19',8,8),(9,'https://a0419ac6-868b-11f0-b883-c8d9d2a9c9d0','192.168.0.9','Chiusa','https://drive.google.com/file/d/1F7V3-q3eEf-imyrxSFG00uYpRsD90tOr/view?usp=sharing','46.0667,11.1211','Piazza Duomo, Bolzano','Alluvione','2025-08-19 11:05:57',9,9),(10,'https://a0419cfa-868b-11f0-b883-c8d9d2a9c9d0','192.168.0.10','Chiusa',NULL,'44.4064,8.9339','Piazza San Giovanni, Genova','Incidente nautico','2025-08-19 17:22:44',10,10),(11,'https://a74a8977-868b-11f0-b883-c8d9d2a9c9d0','192.168.0.2','Inviata',NULL,'41.9028,12.4964','Via del Corso, Roma','Caduta di un albero','2025-08-31 18:58:01',2,1);
/*!40000 ALTER TABLE `richiesta` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_link_casuale` BEFORE INSERT ON `richiesta` FOR EACH ROW BEGIN
   IF NEW.Link IS NULL OR NEW.Link = '' THEN
		SET NEW.Link = CONCAT('https://', UUID());
   END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_richiesta_stato_iniziale` BEFORE INSERT ON `richiesta` FOR EACH ROW BEGIN
	IF NEW.Stato <> 'Inviata' THEN
		SET NEW.Stato = 'Inviata';
        
        -- Genero un warning (non blocca l’Insert)
        SIGNAL SQLSTATE '01000'
            SET MESSAGE_TEXT = 'Stato iniziale non valido: impostato automaticamente a Inviata';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_richiesta_update_stato` AFTER UPDATE ON `richiesta` FOR EACH ROW BEGIN
    IF @skip_richiesta_check IS NULL THEN
		IF OLD.Stato <> NEW.Stato AND NEW.Stato <> 'Annullata'THEN
			SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = 'Impossibile cambiare stato richiesta: incoerenza con la missione relativa';
		END IF;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `segnalatore`
--

DROP TABLE IF EXISTS `segnalatore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `segnalatore` (
  `ID_Segnalatore` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(50) NOT NULL,
  `Cognome` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  PRIMARY KEY (`ID_Segnalatore`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `segnalatore`
--

LOCK TABLES `segnalatore` WRITE;
/*!40000 ALTER TABLE `segnalatore` DISABLE KEYS */;
INSERT INTO `segnalatore` VALUES (1,'Andrea','Fontana','andrea.fontana@mail.com'),(2,'Laura','Gentili','laura.gentili@mail.com'),(3,'Marta','Villa','marta.villa@mail.com'),(4,'Stefano','Costa','stefano.costa@mail.com'),(5,'Roberta','Testa','roberta.testa@mail.com'),(6,'Valerio','Ricci','valerio.ricci@mail.com'),(7,'Giada','Sala','giada.sala@mail.com'),(8,'Michele','Pellegrini','michele.pellegrini@mail.com'),(9,'Claudia','Villa','claudia.villa@mail.com'),(10,'Daniele','Ferraro','daniele.ferraro@mail.com');
/*!40000 ALTER TABLE `segnalatore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `squadra`
--

DROP TABLE IF EXISTS `squadra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `squadra` (
  `ID_Squadra` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_Squadra`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `squadra`
--

LOCK TABLES `squadra` WRITE;
/*!40000 ALTER TABLE `squadra` DISABLE KEYS */;
INSERT INTO `squadra` VALUES (1,'Alfa'),(2,'Bravo'),(3,'Charlie'),(4,'Delta'),(5,'Echo'),(6,'Foxtrot'),(7,'Golf'),(8,'Hotel'),(9,'India'),(10,'Juliet');
/*!40000 ALTER TABLE `squadra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'soccorso'
--

--
-- Dumping routines for database 'soccorso'
--
/*!50003 DROP PROCEDURE IF EXISTS `query1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `query1`(IN ip VARCHAR(45), IN foto VARCHAR(255), iN coord VARCHAR(100), IN indirizzo VARCHAR(255), IN descrizione TEXT, IN tsr DATETIME, IN id_s INT, IN id_a INT)
BEGIN
	INSERT INTO Richiesta (IP, Foto, Coordinate, Indirizzo, Descrizione, TimestampRichiesta, ID_Segnalatore, ID_Amministratore) VALUES
	(ip, foto, coord, indirizzo, descrizione, tsr, id_s, id_a);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `query12` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `query12`(IN mezzo INT)
BEGIN
    SELECT 
        M.ID_Missione,
        M.Obiettivo,
        M.TimeStampInizio,
        M.TimestampFine,
        M.Commenti,
        M.Successo
    FROM Mezzo Z
    JOIN Mezzi_Usati_Missione MU ON Z.ID_Mezzo = MU.ID_Mezzo
    JOIN Missione M ON MU.ID_Missione = M.ID_Missione
    WHERE Z.ID_Mezzo = mezzo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `query13` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `query13`(IN materiale INT)
BEGIN
    SELECT 
        Mat.ID_Materiale,
        Mat.Nome,
        SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, M.TimeStampInizio, M.TimestampFine))) AS OreTotaliUso
    FROM Materiale Mat
    JOIN Materiali_Usati_Missione MU ON Mat.ID_Materiale = MU.ID_Materiale
    JOIN Missione M ON MU.ID_Missione = M.ID_Missione
    WHERE Mat.ID_Materiale = materiale AND M.TimestampFine IS NOT NULL
    GROUP BY Mat.ID_Materiale, Mat.Nome;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `query2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `query2`(IN obiettivo TEXT, IN tsi DATETIME, IN id_r INT, IN id_s INT)
BEGIN
	INSERT INTO Missione (Obiettivo, TimeStampInizio, ID_Richiesta, ID_Squadra) VALUES
	(obiettivo, tsi, id_r, id_s);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `query3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `query3`(IN missione INT, IN tsf DATETIME, IN commenti TEXT, IN successo TINYINT UNSIGNED)
BEGIN
	UPDATE Missione
	SET TimestampFine = tsf,
		Commenti = commenti,
		Successo = successo
	WHERE ID_Missione = missione;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `query5` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `query5`(IN operatore INT)
BEGIN
	SELECT COUNT(m.ID_Missione) AS NumeroMissioni
    FROM Missione m
    JOIN Composizione_Squadra cs ON m.ID_Squadra = cs.ID_Squadra
    WHERE cs.ID_Operatore = operatore;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `query6` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `query6`(IN anno INT)
BEGIN
	IF anno IS NOT NULL THEN
		-- in un anno specifico
		SELECT SEC_TO_TIME(AVG(TIMESTAMPDIFF(SECOND, m.TimestampInizio, m.TimestampFine))) AS TempoMedio
		FROM Missione m
		WHERE YEAR(m.TimestampInizio) = anno AND m.TimestampFine IS NOT NULL;
    ELSE
		-- per ciascun caposquadra
		SELECT cs.ID_Operatore as ID_Caposquadra, SEC_TO_TIME(AVG(TIMESTAMPDIFF(SECOND, m.TimestampInizio, m.TimestampFine))) AS TempoMedio
		FROM Missione m
		JOIN Composizione_Squadra cs ON m.ID_Squadra = cs.ID_Squadra
		WHERE cs.Ruolo = 'Caposquadra' AND m.TimestampFine IS NOT NULL
		GROUP BY cs.ID_Operatore;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `query7` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `query7`(IN email VARCHAR(255), IN ip VARCHAR(45))
BEGIN
    SELECT COUNT(*) AS NumeroRichieste
    FROM Richiesta R
    LEFT JOIN Segnalatore S ON S.ID_Segnalatore = R.ID_Segnalatore
    WHERE R.TimeStampRichiesta >= NOW() - INTERVAL 36 HOUR
      AND (
           (email IS NOT NULL AND S.Email = email)
           OR (ip IS NOT NULL AND R.IP = ip)
      );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `query8` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `query8`(IN operatore INT)
BEGIN
    SELECT O.ID_Operatore,
           O.Nome,
           O.Cognome,
           SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, M.TimestampInizio, M.TimestampFine))) AS TempoTotale
    FROM Operatore O
    JOIN Composizione_Squadra CS ON O.ID_Operatore = CS.ID_Operatore
    JOIN Missione M ON CS.ID_Squadra = M.ID_Squadra
    WHERE O.ID_Operatore = operatore
    GROUP BY O.ID_Operatore, O.Nome, O.Cognome;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `query9` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `query9`(IN missione INT)
BEGIN
    SELECT M2.ID_Missione, 
           M2.Obiettivo, 
           M2.TimeStampInizio, 
           R2.Indirizzo
    FROM Missione M2
    JOIN Richiesta R2 ON R2.ID_Richiesta = M2.ID_Richiesta
    JOIN Missione M1 ON M1.ID_Missione = missione
    JOIN Richiesta R1 ON R1.ID_Richiesta = M1.ID_Richiesta
    WHERE M2.ID_Missione <> missione  
      AND M2.TimestampInizio >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
      AND (R2.Indirizzo = R1.Indirizzo OR R2.Coordinate = R1.Coordinate);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `query10`
--

/*!50001 DROP VIEW IF EXISTS `query10`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `query10` AS select `r`.`ID_Richiesta` AS `ID_Richiesta`,`r`.`Descrizione` AS `Descrizione`,`r`.`Indirizzo` AS `Indirizzo`,`r`.`Coordinate` AS `Coordinate`,`m`.`TimestampFine` AS `TimestampFine`,`m`.`Successo` AS `Successo`,`m`.`Commenti` AS `Commenti` from (`richiesta` `r` join `missione` `m` on((`r`.`ID_Richiesta` = `m`.`ID_Richiesta`))) where ((`m`.`Successo` is not null) and (`m`.`Successo` < 5)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `query11`
--

/*!50001 DROP VIEW IF EXISTS `query11`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `query11` AS select `o`.`ID_Operatore` AS `ID_Operatore`,`o`.`Nome` AS `Nome`,`o`.`Cognome` AS `Cognome`,count(`m`.`ID_Missione`) AS `NumeroMissioniNonPositive` from (((`operatore` `o` join `composizione_squadra` `cs` on((`o`.`ID_Operatore` = `cs`.`ID_Operatore`))) join `missione` `m` on((`cs`.`ID_Squadra` = `m`.`ID_Squadra`))) join `query10` `v` on((`v`.`ID_Richiesta` = `m`.`ID_Richiesta`))) group by `o`.`ID_Operatore`,`o`.`Nome`,`o`.`Cognome` order by `NumeroMissioniNonPositive` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `query4`
--

/*!50001 DROP VIEW IF EXISTS `query4`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `query4` AS select `o`.`ID_Operatore` AS `ID_Operatore`,`o`.`Nome` AS `Nome`,`o`.`Cognome` AS `Cognome` from `operatore` `o` where `o`.`ID_Operatore` in (select `cs`.`ID_Operatore` from ((`composizione_squadra` `cs` join `missione` `m` on((`cs`.`ID_Squadra` = `m`.`ID_Squadra`))) join `richiesta` `r` on((`m`.`ID_Richiesta` = `r`.`ID_Richiesta`))) where (`r`.`Stato` = 'In Corso')) is false */;
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

-- Dump completed on 2025-08-31 19:07:53
