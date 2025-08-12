DROP SCHEMA IF EXISTS soccorso;
CREATE SCHEMA soccorso;
USE soccorso;

-- ==========================================
-- CREAZIONE TABELLE DALLO SCHEMA RELAZIONALE
-- ==========================================

-- Entità

DROP TABLE IF EXISTS Amministratore;
CREATE TABLE Amministratore (
    ID_Amministratore INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    DataNascita DATE NOT NULL
);

DROP TABLE IF EXISTS Operatore;
CREATE TABLE Operatore (
    ID_Operatore INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    DataNascita DATE NOT NULL
);

DROP TABLE IF EXISTS Squadra;
CREATE TABLE Squadra (
    ID_Squadra INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS Patente;
CREATE TABLE Patente (
    ID_Patente INT PRIMARY KEY AUTO_INCREMENT,
    Tipo VARCHAR(30) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS Abilita;
CREATE TABLE Abilita (
    ID_Abilita INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS Mezzo;
CREATE TABLE Mezzo (
    ID_Mezzo INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Descrizione TEXT
);

DROP TABLE IF EXISTS Materiale;
CREATE TABLE Materiale (
    ID_Materiale INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Descrizione TEXT
);

DROP TABLE IF EXISTS Segnalatore;
CREATE TABLE Segnalatore (
    ID_Segnalatore INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS Richiesta;
CREATE TABLE Richiesta (
    ID_Richiesta INT PRIMARY KEY AUTO_INCREMENT,
    Link VARCHAR(255) NOT NULL,
    IP VARCHAR(45) NOT NULL,
    Stato ENUM('Attiva','In Corso','Chiusa','Annullata') NOT NULL,
    Foto VARCHAR(255), -- meglio salvare il percorso o URL / LONGBLOB?
    Coordinate VARCHAR(100) NOT NULL, -- Longitudine e Latitudine?
    Indirizzo VARCHAR(255) NOT NULL,
    Descrizione TEXT NOT NULL,
    ID_Segnalatore INT NOT NULL,
    ID_Amministratore INT NOT NULL,
    FOREIGN KEY (ID_Segnalatore) REFERENCES Segnalatore(ID_Segnalatore),
    FOREIGN KEY (ID_Amministratore) REFERENCES Amministratore(ID_Amministratore)
);

DROP TABLE IF EXISTS Missione;
CREATE TABLE Missione (
    ID_Missione INT PRIMARY KEY AUTO_INCREMENT,
    Obiettivo TEXT NOT NULL,
    TimestampInizio DATETIME NOT NULL,
    ID_Richiesta INT NOT NULL UNIQUE,
    ID_Squadra INT NOT NULL,
    FOREIGN KEY (ID_Richiesta) REFERENCES Richiesta(ID_Richiesta),
    FOREIGN KEY (ID_Squadra) REFERENCES Squadra(ID_Squadra)
);


-- Relazioni

DROP TABLE IF EXISTS Amministratore_Possiede_Patente;
CREATE TABLE Amministratore_Possiede_Patente (
    ID_Amministratore INT NOT NULL,
    ID_Patente INT NOT NULL,
    PRIMARY KEY (ID_Amministratore, ID_Patente),
    FOREIGN KEY (ID_Amministratore) REFERENCES Amministratore(ID_Amministratore),
    FOREIGN KEY (ID_Patente) REFERENCES Patente(ID_Patente)
);

DROP TABLE IF EXISTS Amministratore_Possiede_Abilita;
CREATE TABLE Amministratore_Possiede_Abilita (
    ID_Amministratore INT NOT NULL,
    ID_Abilita INT NOT NULL,
    PRIMARY KEY (ID_Amministratore, ID_Abilita),
    FOREIGN KEY (ID_Amministratore) REFERENCES Amministratore(ID_Amministratore),
    FOREIGN KEY (ID_Abilita) REFERENCES Abilita(ID_Abilita)
);

DROP TABLE IF EXISTS Operatore_Possiede_Patente;
CREATE TABLE Operatore_Possiede_Patente (
    ID_Operatore INT NOT NULL,
    ID_Patente INT NOT NULL,
    PRIMARY KEY (ID_Operatore, ID_Patente),
    FOREIGN KEY (ID_Operatore) REFERENCES Operatore(ID_Operatore),
    FOREIGN KEY (ID_Patente) REFERENCES Patente(ID_Patente)
);

DROP TABLE IF EXISTS Operatore_Possiede_Abilita;
CREATE TABLE Operatore_Possiede_Abilita (
    ID_Operatore INT NOT NULL,
    ID_Abilita INT NOT NULL,
    PRIMARY KEY (ID_Operatore, ID_Abilita),
    FOREIGN KEY (ID_Operatore) REFERENCES Operatore(ID_Operatore),
    FOREIGN KEY (ID_Abilita) REFERENCES Abilita(ID_Abilita)
);

DROP TABLE IF EXISTS Mezzi_Usati_Missione;
CREATE TABLE Mezzi_Usati_Missione (
    ID_Missione INT NOT NULL,
    ID_Mezzo INT NOT NULL,
    PRIMARY KEY (ID_Missione, ID_Mezzo),
    FOREIGN KEY (ID_Missione) REFERENCES Missione(ID_Missione),
    FOREIGN KEY (ID_Mezzo) REFERENCES Mezzo(ID_Mezzo) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Materiali_Usati_Missione;
CREATE TABLE Materiali_Usati_Missione (
    ID_Missione INT NOT NULL,
    ID_Materiale INT NOT NULL,
    PRIMARY KEY (ID_Missione, ID_Materiale),
    FOREIGN KEY (ID_Missione) REFERENCES Missione(ID_Missione),
    FOREIGN KEY (ID_Materiale) REFERENCES Materiale(ID_Materiale) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Composizione_Squadra;
CREATE TABLE Composizione_Squadra (
    ID_Squadra INT NOT NULL,
    ID_Operatore INT NOT NULL,
    Ruolo ENUM('Caposquadra','Operatore') NOT NULL,
    PRIMARY KEY (ID_Squadra, ID_Operatore),
    FOREIGN KEY (ID_Squadra) REFERENCES Squadra(ID_Squadra),
    FOREIGN KEY (ID_Operatore) REFERENCES Operatore(ID_Operatore)
);

DROP TABLE IF EXISTS Missioni_Concluse;
CREATE TABLE Missioni_Concluse (
    ID_Missione INT PRIMARY KEY,
    ID_Squadra INT NOT NULL,
    Commenti TEXT,
    Successo TINYINT CHECK (Successo BETWEEN 1 AND 5) NOT NULL,
    TimestampFine DATETIME NOT NULL,
    FOREIGN KEY (ID_Missione) REFERENCES Missione(ID_Missione),
    FOREIGN KEY (ID_Squadra) REFERENCES Squadra(ID_Squadra)
);

DROP TABLE IF EXISTS Missioni_Aggiornate;
CREATE TABLE Missioni_Aggiornate (
    ID_Missione INT NOT NULL,
    ID_Amministratore INT NOT NULL,
    TimestampInserimento DATETIME NOT NULL,
    Commento TEXT NOT NULL,
    PRIMARY KEY (ID_Missione, ID_Amministratore, TimestampInserimento),
    FOREIGN KEY (ID_Missione) REFERENCES Missione(ID_Missione),
    FOREIGN KEY (ID_Amministratore) REFERENCES Amministratore(ID_Amministratore)
);