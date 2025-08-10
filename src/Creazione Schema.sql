DROP SCHEMA IF EXISTS soccorso;
CREATE SCHEMA soccorso;
USE soccorso;

DROP TABLE IF EXISTS Amministratori;
CREATE TABLE Amministratori(
	ID INT PRIMARY KEY AUTO_INCREMENT, 
    Nome varchar(20) NOT NULL, 
    Cognome varchar(20) NOT NULL, 
    DataNascita DATE
);

DROP TABLE IF EXISTS Operatori;
CREATE TABLE Operatori(
	ID INT PRIMARY KEY AUTO_INCREMENT, 
    Nome varchar(20) NOT NULL, 
    Cognome varchar(20) NOT NULL, 
    DataNascita DATE
);

DROP TABLE IF EXISTS Caposquadra;
CREATE TABLE Caposquadra(
	ID INT PRIMARY KEY, 
    FOREIGN KEY (ID) REFERENCES Operatori(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS Patenti;
CREATE TABLE Patenti(
	Tipo varchar(20) PRIMARY KEY
    -- facciamo enum?
);

DROP TABLE IF EXISTS Abilità;
CREATE TABLE Abilità(
	Nome varchar(50) PRIMARY KEY NOT NULL
);

DROP TABLE IF EXISTS Squadre;
CREATE TABLE Squadre(
	ID INT PRIMARY KEY AUTO_INCREMENT
);

DROP TABLE IF EXISTS Richieste;
CREATE TABLE Richieste(
	Link varchar(255) PRIMARY KEY, 
    IP varchar(45) PRIMARY KEY, 
    Stato enum('attiva', 'in corso', 'chiusa'), -- NOT NULL?
    Foto LONGBLOB,
    -- Coordinate
		Latitudine DECIMAL(9,6), 
		Longitudine DECIMAL(9,6), 
    Indirizzo varchar(255),
    Descrizione varchar(200) -- TEXT?
);

DROP TABLE IF EXISTS Segnalatori;
CREATE TABLE Segnalatori(
	ID INT PRIMARY KEY AUTO_INCREMENT, 
    Nome varchar(20) NOT NULL, 
    Cognome varchar(20) NOT NULL, 
    Email varchar(50) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS Missioni;
CREATE TABLE Missioni(
	ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    Obiettivo varchar(50), -- TEXT? NOT NULL?
    Commento varchar(200), -- TEXT?
    Successo INT,
		CHECK (Successo BETWEEN 1 AND 5), 
    TimestampInizio TIMESTAMP,
    TimestampFine TIMESTAMP
    -- Forse serve una tabella MissioniArchiviate con i dati finali, all'iniizo non lo sai il timestamp di fine o il successo
);

DROP TABLE IF EXISTS Mezzi;
CREATE TABLE Mezzi(
	Nome varchar(20) PRIMARY KEY, 
    Descrizione varchar(50) -- TEXT?
);

DROP TABLE IF EXISTS Materiali;
CREATE TABLE Materiali(
	Nome varchar(20) PRIMARY KEY, 
    Descrizione varchar(50) -- TEXT?
);