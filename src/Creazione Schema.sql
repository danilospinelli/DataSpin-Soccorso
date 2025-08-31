CREATE SCHEMA soccorso;
USE soccorso;

-- ==========================================
-- CREAZIONE TABELLE DALLO SCHEMA RELAZIONALE
-- ==========================================

-- Entità

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
    Email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Richiesta (
    ID_Richiesta INT PRIMARY KEY AUTO_INCREMENT,
    Link VARCHAR(255) NOT NULL,
    IP VARCHAR(45) NOT NULL,
    Stato ENUM('Inviata','Attiva','In Corso','Chiusa','Annullata') NOT NULL DEFAULT 'Inviata',
    Foto VARCHAR(255), 
    Coordinate VARCHAR(100) NOT NULL,
    Indirizzo VARCHAR(255) NOT NULL,
    Descrizione TEXT NOT NULL,
    TimestampRichiesta DATETIME NOT NULL, 
    ID_Segnalatore INT NOT NULL,
    ID_Amministratore INT NOT NULL,
    FOREIGN KEY (ID_Segnalatore) REFERENCES Segnalatore(ID_Segnalatore),
    FOREIGN KEY (ID_Amministratore) REFERENCES Amministratore(ID_Amministratore)
);

CREATE TABLE Missione (
    ID_Missione INT PRIMARY KEY AUTO_INCREMENT,
    Obiettivo TEXT NOT NULL,
    TimestampInizio DATETIME NOT NULL,
    -- Fine Missione
    TimestampFine DATETIME DEFAULT NULL,
    Commenti TEXT DEFAULT NULL,
    Successo TINYINT UNSIGNED CHECK (Successo BETWEEN 0 AND 5) DEFAULT NULL,
    -- --------------
    ID_Richiesta INT NOT NULL UNIQUE,
    ID_Squadra INT NOT NULL,
    FOREIGN KEY (ID_Richiesta) REFERENCES Richiesta(ID_Richiesta),
    FOREIGN KEY (ID_Squadra) REFERENCES Squadra(ID_Squadra)
);


-- Relazioni

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
    FOREIGN KEY (ID_Mezzo) REFERENCES Mezzo(ID_Mezzo) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE Materiali_Usati_Missione (
    ID_Missione INT NOT NULL,
    ID_Materiale INT NOT NULL,
    PRIMARY KEY (ID_Missione, ID_Materiale),
    FOREIGN KEY (ID_Missione) REFERENCES Missione(ID_Missione),
    FOREIGN KEY (ID_Materiale) REFERENCES Materiale(ID_Materiale) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE Composizione_Squadra (
    ID_Squadra INT NOT NULL,
    ID_Operatore INT NOT NULL,
    Ruolo ENUM('Caposquadra','Operatore') NOT NULL,
    PRIMARY KEY (ID_Squadra, ID_Operatore),
    FOREIGN KEY (ID_Squadra) REFERENCES Squadra(ID_Squadra),
    FOREIGN KEY (ID_Operatore) REFERENCES Operatore(ID_Operatore)
);

CREATE TABLE Missioni_Aggiornate (
    ID_Missione INT NOT NULL,
    ID_Amministratore INT NOT NULL,
    TimestampInserimento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Commento TEXT NOT NULL,
    PRIMARY KEY (ID_Missione, ID_Amministratore, TimestampInserimento),
    FOREIGN KEY (ID_Missione) REFERENCES Missione(ID_Missione),
    FOREIGN KEY (ID_Amministratore) REFERENCES Amministratore(ID_Amministratore)
);



DELIMITER $$
-- Alle Richieste devono essere associate delle stringhe lunghe e casuali, che saranno poi i Link
CREATE TRIGGER trg_link_casuale
BEFORE INSERT ON Richiesta
FOR EACH ROW
BEGIN
   IF NEW.Link IS NULL OR NEW.Link = '' THEN
		SET NEW.Link = CONCAT('https://', UUID());
   END IF;
END$$
DELIMITER ;



-- Ruolo con tutti i permessi da dare agli Amministratori
CREATE ROLE amministratore;
GRANT INSERT ON soccorso.Amministratore TO amministratore WITH GRANT OPTION; -- Creare account per Operatori e Amministratori
GRANT INSERT ON soccorso.Operatore TO amministratore WITH GRANT OPTION;
GRANT INSERT, UPDATE, DELETE ON soccorso.Mezzo TO amministratore WITH GRANT OPTION; -- Aggiungere, modificare, eliminare Mezzi e Materiali
GRANT INSERT, UPDATE, DELETE ON soccorso.Materiale TO amministratore WITH GRANT OPTION;
GRANT INSERT ON soccorso.Missioni_Aggiornate TO amministratore WITH GRANT OPTION; -- Inserire Aggiornamenti sulle Missioni
GRANT UPDATE ON soccorso.Missione TO amministratore WITH GRANT OPTION; -- Marcare una Missione come conclusa (aggiungere gli attributi finali)
-- Permessi Extra
GRANT INSERT ON soccorso.Missione TO amministratore WITH GRANT OPTION; -- Inserire Missioni
GRANT INSERT ON soccorso.Amministratore_Possiede_Patente TO amministratore WITH GRANT OPTION; -- Assegnare Patenti e Abilità a 
GRANT INSERT ON soccorso.Amministratore_Possiede_Abilita TO amministratore WITH GRANT OPTION; -- Operatori e Amministratori
GRANT INSERT ON soccorso.Operatore_Possiede_Patente TO amministratore WITH GRANT OPTION;
GRANT INSERT ON soccorso.Operatore_Possiede_Abilita TO amministratore WITH GRANT OPTION;
GRANT INSERT ON soccorso.Mezzi_Usati_Missione TO amministratore WITH GRANT OPTION; -- Assegnare Mezzi e Materiali alle Missioni
GRANT INSERT ON soccorso.Materiali_Usati_Missione TO amministratore WITH GRANT OPTION;
GRANT INSERT ON soccorso.Composizione_Squadra TO amministratore WITH GRANT OPTION; -- Assegnare Operatori alle Squadre
GRANT INSERT ON soccorso.Squadra TO amministratore WITH GRANT OPTION; -- Creare Squadre
GRANT UPDATE ON soccorso.Richiesta TO amministratore WITH GRANT OPTION; -- Aggiornare le Richieste (per marcarle come Annullate)

-- Creazione utente con tutti i privilegi per loggare sul codice java
DROP USER IF EXISTS 'superuser'@'localhost';
CREATE USER 'superuser'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT ON soccorso.* TO 'superuser'@'localhost' WITH GRANT OPTION;
GRANT CREATE USER, GRANT OPTION, ROLE_ADMIN ON *.* TO 'superuser'@'localhost';
FLUSH PRIVILEGES;