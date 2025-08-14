-- ==========================================
-- Popolamento del Database
-- ==========================================

INSERT INTO Segnalatore (Nome, Cognome, Email) VALUES
('Luca', 'Rossi', 'luca.rossi@email.com'),
('Maria', 'Bianchi', 'maria.bianchi@email.com'),
('Giovanni', 'Verdi', 'giovanni.verdi@email.com');

INSERT INTO Amministratore (Nome, Cognome, DataNascita) VALUES
('Alessandro', 'Neri', '1980-03-12'),
('Francesca', 'Russo', '1975-07-22');

INSERT INTO Operatore (Nome, Cognome, DataNascita) VALUES
('Marco', 'Gialli', '1990-01-10'),
('Anna', 'Blu', '1988-11-05'),
('Paolo', 'Viola', '1992-06-15');

INSERT INTO Squadra (Nome) VALUES
('Squadra A'),
('Squadra B'),
('Squadra C');

INSERT INTO Patente (Tipo) VALUES
('A'), ('B'), ('C');

INSERT INTO Abilita (Nome) VALUES
('Primo Soccorso'), ('Guida Veicoli Pesanti'), ('Spegnimento Incendi');

INSERT INTO Mezzo (Nome, Descrizione) VALUES
('Ambulanza', 'Ambulanza di emergenza'),
('Autopompa', 'Veicolo antincendio'),
('Elicottero', 'Elicottero di soccorso');

INSERT INTO Materiale (Nome, Descrizione) VALUES
('Estintore', 'Estintore portatile'),
('Kit Primo Soccorso', 'Benda, medicazioni'),
('Corda', 'Corda di sicurezza');

-- Gestire IP e Foto
INSERT INTO Richiesta (IP, Stato, Foto, Coordinate, Indirizzo, Descrizione, ID_Segnalatore, ID_Amministratore) VALUES
('192.168.0.1', 'Attiva', NULL, '45.0703,7.6869', 'Via Roma 1', 'Persona bloccata in casa', 1, 1),
('192.168.0.2', 'In Corso', NULL, '45.0710,7.6870', 'Via Milano 2', 'Incendio controllato', 2, 2),
('192.168.0.3', 'Chiusa', NULL, '45.0720,7.6880', 'Via Torino 3', 'Allagamento in strada', 3, 1);

INSERT INTO Missione (Obiettivo, TimestampInizio, ID_Richiesta, ID_Squadra) VALUES
('Soccorso persona bloccata', '2025-08-14 08:00:00', 1, 1),
('Gestione incendio', '2025-08-14 09:00:00', 2, 2),
('Gestione allagamento', '2025-08-14 10:00:00', 3, 3);

INSERT INTO Composizione_Squadra (ID_Squadra, ID_Operatore, Ruolo) VALUES
(1, 1, 'Caposquadra'),
(1, 2, 'Operatore'),
(2, 2, 'Caposquadra'),
(2, 3, 'Operatore'),
(3, 1, 'Caposquadra'),
(3, 3, 'Operatore');

INSERT INTO Missioni_Concluse (ID_Missione, Commenti, Successo, TimestampFine) VALUES
(3, 'Allagamento gestito correttamente', 5, '2025-08-14 11:30:00');

INSERT INTO Mezzi_Usati_Missione (ID_Missione, ID_Mezzo) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Materiali_Usati_Missione (ID_Missione, ID_Materiale) VALUES
(1, 2),
(2, 1),
(3, 3);

INSERT INTO Amministratore_Possiede_Patente (ID_Amministratore, ID_Patente) VALUES
(1, 1), (1, 2),
(2, 3);

INSERT INTO Amministratore_Possiede_Abilita (ID_Amministratore, ID_Abilita) VALUES
(1, 1), (1, 2),
(2, 3);

INSERT INTO Operatore_Possiede_Patente (ID_Operatore, ID_Patente) VALUES
(1, 1), (2, 2), (3, 3);

INSERT INTO Operatore_Possiede_Abilita (ID_Operatore, ID_Abilita) VALUES
(1, 1), (2, 2), (3, 3);

INSERT INTO Missioni_Aggiornate (ID_Missione, ID_Amministratore, Commento) VALUES
(1, 1, 'Operazioni iniziate'),
(2, 2, 'Incendio sotto controllo'),
(3, 1, 'Allagamento gestito con successo');
