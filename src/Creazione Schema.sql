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



-- spin solo per te perchè sei magico



CREATE TABLE Amministratore (
    ID_Amministratore INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    DataNascita DATE NOT NULL
);

CREATE TABLE Operatore (
    ID_Operatore INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    DataNascita DATE NOT NULL
);

CREATE TABLE Squadra (
    ID_Squadra INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL
);

CREATE TABLE Patente (
    ID_Patente INT PRIMARY KEY AUTO_INCREMENT,
    Tipo VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE Abilita (
    ID_Abilita INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Mezzo (
    ID_Mezzo INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Descrizione TEXT
);

CREATE TABLE Materiale (
    ID_Materiale INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Descrizione TEXT
);

CREATE TABLE Segnalatore (
    ID_Segnalatore INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

CREATE TABLE Richiesta (
    ID_Richiesta INT PRIMARY KEY AUTO_INCREMENT,
    Link VARCHAR(255) NOT NULL,
    IP VARCHAR(45) NOT NULL,
    Stato ENUM('Attiva','InCorso','Chiusa','Annullata') NOT NULL,
    Foto VARCHAR(255), -- meglio salvare il percorso o URL
    Coordinate VARCHAR(100),
    Indirizzo VARCHAR(255),
    Descrizione TEXT NOT NULL,
    ID_Segnalatore INT NOT NULL,
    ID_Amministratore INT NOT NULL,
    FOREIGN KEY (ID_Segnalatore) REFERENCES Segnalatore(ID_Segnalatore),
    FOREIGN KEY (ID_Amministratore) REFERENCES Amministratore(ID_Amministratore)
);

CREATE TABLE Missione (
    ID_Missione INT PRIMARY KEY AUTO_INCREMENT,
    Obiettivo TEXT NOT NULL,
    TimestampInizio DATETIME NOT NULL,
    ID_Richiesta INT NOT NULL UNIQUE,
    ID_Squadra INT NOT NULL,
    FOREIGN KEY (ID_Richiesta) REFERENCES Richiesta(ID_Richiesta),
    FOREIGN KEY (ID_Squadra) REFERENCES Squadra(ID_Squadra)
);

CREATE TABLE Amministratore_Possiede_Patente (
    ID_Amministratore INT NOT NULL,
    ID_Patente INT NOT NULL,
    PRIMARY KEY (ID_Amministratore, ID_Patente),
    FOREIGN KEY (ID_Amministratore) REFERENCES Amministratore(ID_Amministratore),
    FOREIGN KEY (ID_Patente) REFERENCES Patente(ID_Patente)
);

CREATE TABLE Amministratore_Possiede_Abilita (
    ID_Amministratore INT NOT NULL,
    ID_Abilita INT NOT NULL,
    PRIMARY KEY (ID_Amministratore, ID_Abilita),
    FOREIGN KEY (ID_Amministratore) REFERENCES Amministratore(ID_Amministratore),
    FOREIGN KEY (ID_Abilita) REFERENCES Abilita(ID_Abilita)
);

CREATE TABLE Operatore_Possiede_Patente (
    ID_Operatore INT NOT NULL,
    ID_Patente INT NOT NULL,
    PRIMARY KEY (ID_Operatore, ID_Patente),
    FOREIGN KEY (ID_Operatore) REFERENCES Operatore(ID_Operatore),
    FOREIGN KEY (ID_Patente) REFERENCES Patente(ID_Patente)
);

CREATE TABLE Operatore_Possiede_Abilita (
    ID_Operatore INT NOT NULL,
    ID_Abilita INT NOT NULL,
    PRIMARY KEY (ID_Operatore, ID_Abilita),
    FOREIGN KEY (ID_Operatore) REFERENCES Operatore(ID_Operatore),
    FOREIGN KEY (ID_Abilita) REFERENCES Abilita(ID_Abilita)
);

CREATE TABLE Mezzi_Usati_Missione (
    ID_Missione INT NOT NULL,
    ID_Mezzo INT NOT NULL,
    PRIMARY KEY (ID_Missione, ID_Mezzo),
    FOREIGN KEY (ID_Missione) REFERENCES Missione(ID_Missione),
    FOREIGN KEY (ID_Mezzo) REFERENCES Mezzo(ID_Mezzo)
);

CREATE TABLE Materiali_Usati_Missione (
    ID_Missione INT NOT NULL,
    ID_Materiale INT NOT NULL,
    PRIMARY KEY (ID_Missione, ID_Materiale),
    FOREIGN KEY (ID_Missione) REFERENCES Missione(ID_Missione),
    FOREIGN KEY (ID_Materiale) REFERENCES Materiale(ID_Materiale)
);

CREATE TABLE Composizione_Squadra (
    ID_Squadra INT NOT NULL,
    ID_Operatore INT NOT NULL,
    Ruolo ENUM('Caposquadra','Operatore') NOT NULL,
    PRIMARY KEY (ID_Squadra, ID_Operatore),
    FOREIGN KEY (ID_Squadra) REFERENCES Squadra(ID_Squadra),
    FOREIGN KEY (ID_Operatore) REFERENCES Operatore(ID_Operatore)
);

CREATE TABLE Missioni_Concluse (
    ID_Missione INT PRIMARY KEY,
    ID_Squadra INT NOT NULL,
    Commenti TEXT,
    Successo TINYINT CHECK (Successo BETWEEN 0 AND 5),
    TimestampFine DATETIME NOT NULL,
    FOREIGN KEY (ID_Missione) REFERENCES Missione(ID_Missione),
    FOREIGN KEY (ID_Squadra) REFERENCES Squadra(ID_Squadra)
);

CREATE TABLE Missioni_Aggiornate (
    ID_Missione INT NOT NULL,
    ID_Amministratore INT NOT NULL,
    Timestamp DATETIME NOT NULL,
    Commento TEXT NOT NULL,
    PRIMARY KEY (ID_Missione, ID_Amministratore, Timestamp),
    FOREIGN KEY (ID_Missione) REFERENCES Missione(ID_Missione),
    FOREIGN KEY (ID_Amministratore) REFERENCES Amministratore(ID_Amministratore)
);

-- =====================================
-- 2) TRIGGER PER VINCOLI EXTRA
-- =====================================

DELIMITER $$

-- Vincolo: una squadra deve avere almeno un caposquadra
CREATE TRIGGER trg_check_caposquadra_insert
BEFORE INSERT ON Composizione_Squadra
FOR EACH ROW
BEGIN
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
END$$

-- Vincolo: una missione conclusa deve avere Successo e TimestampFine valorizzati
CREATE TRIGGER trg_check_missione_conclusa
BEFORE INSERT ON Missioni_Concluse
FOR EACH ROW
BEGIN
    IF NEW.Successo IS NULL OR NEW.TimestampFine IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Missione conclusa deve avere Successo e TimestampFine';
    END IF;
END$$

DELIMITER ;