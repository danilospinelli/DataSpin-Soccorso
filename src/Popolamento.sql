-- ==========================================
-- Popolamento del Database
-- ==========================================

-- Amministratori
INSERT INTO Amministratore (Nome, Cognome, DataNascita) VALUES
('Luca', 'Bianchi', '1980-03-15'),
('Anna', 'Rossi', '1975-07-22'),
('Marco', 'Verdi', '1982-11-10'),
('Giulia', 'Ferrari', '1990-05-02'),
('Paolo', 'Galli', '1988-01-30'),
('Francesca','Neri','1983-08-11'),
('Giorgio','Barbieri','1978-02-20'),
('Elena','Bianco','1985-12-05'),
('Riccardo','Cattaneo','1991-09-18'),
('Simona','Fabbri','1987-06-23');

-- Operatori
INSERT INTO Operatore (Nome, Cognome, DataNascita) VALUES
('Matteo', 'Romano', '1995-06-18'),
('Chiara', 'Colombo', '1992-12-25'),
('Davide', 'Ricci', '1989-09-09'),
('Elisa', 'Marini', '1994-04-14'),
('Francesco', 'Conti', '1990-10-05'),
('Sara','Gallo','1993-03-03'),
('Lorenzo','Grassi','1988-07-14'),
('Federica','Moretti','1990-11-22'),
('Alessandro','Riva','1992-05-09'),
('Valentina','Marchetti','1991-10-30');

-- Squadre
INSERT INTO Squadra (Nome) VALUES
('Alfa'),
('Bravo'),
('Charlie'),
('Delta'),
('Echo'),
('Foxtrot'),
('Golf'),
('Hotel'),
('India'),
('Juliet');

-- Patenti
INSERT INTO Patente (Tipo) VALUES
('A'),
('B'),
('C'),
('D'),
('E'),
('F'),
('G'),
('H'),
('I'),
('J');

-- Abilità
INSERT INTO Abilita (Nome) VALUES
('Primo Soccorso'),
('Spegnimento Incendi'),
('Uso Defibrillatore'),
('Guida Fuoristrada'),
('Alpinismo'),
('Nuoto di soccorso'),
('Orientamento GPS'),
('Uso radio'),
('Scalata'),
('Emergenze chimiche');

-- Mezzi
INSERT INTO Mezzo (Nome, Descrizione) VALUES
('Ambulanza', 'Ambulanza attrezzata per emergenze'),
('Fuoristrada', 'Veicolo 4x4 per terreni difficili'),
('Camion', 'Camion per trasporto materiali'),
('Motocicletta', 'Moto per interventi rapidi'),
('Elicottero', 'Elicottero per soccorsi aerei'),
('Gommone','Imbarcazione per soccorsi in acqua'),
('Quad','Veicolo agile per terreni difficili'),
('Camion frigo','Camion per trasporto medicinali'),
('Drago UAV','Drone per ricognizione'),
('Trattore','Veicolo per soccorso in campagna');

-- Materiali
INSERT INTO Materiale (Nome, Descrizione) VALUES
('Barelle', 'Barelle pieghevoli per trasporto feriti'),
('Kit Medico', 'Set completo di pronto soccorso'),
('Estintori', 'Estintori portatili'),
('Corde', 'Corde da alpinismo'),
('Tende', 'Tende per campo base'),
('Zattere','Zattere di salvataggio'),
('GPS','Dispositivo GPS portatile'),
('Radio','Radio per comunicazioni'),
('Imbrago','Imbrago per arrampicata'),
('Maschere chimiche','Maschere protettive per sostanze chimiche');

-- Segnalatori
INSERT INTO Segnalatore (Nome, Cognome, Email) VALUES
('Andrea', 'Fontana', 'andrea.fontana@mail.com'),
('Laura', 'Gentili', 'laura.gentili@mail.com'),
('Marta', 'Villa', 'marta.villa@mail.com'),
('Stefano', 'Costa', 'stefano.costa@mail.com'),
('Roberta', 'Testa', 'roberta.testa@mail.com'),
('Valerio','Ricci','valerio.ricci@mail.com'),
('Giada','Sala','giada.sala@mail.com'),
('Michele','Pellegrini','michele.pellegrini@mail.com'),
('Claudia','Villa','claudia.villa@mail.com'),
('Daniele','Ferraro','daniele.ferraro@mail.com');

-- Richieste
INSERT INTO Richiesta (IP, Stato, Foto, Coordinate, Indirizzo, Descrizione, TimestampRichiesta, ID_Segnalatore, ID_Amministratore) VALUES
('192.168.0.1', 'Attiva', 'https://drive.google.com/file/d/1phBFwNtTshERYU7-qBAY7uN998Y2QZvc/view?usp=sharing', '45.4642,9.19', 'Via Roma 10, Milano', 'Incidente stradale', '2025-08-19 12:45:23', 1, 1),
('192.168.0.2', 'Attiva', NULL, '41.9028,12.4964', 'Piazza Venezia, Roma', 'Malore improvviso', '2025-08-19 09:18:57', 2, 2),
('192.168.0.3', 'Attiva', NULL, '40.8518,14.2681', 'Via Toledo, Napoli', 'Incendio appartamento', '2025-08-19 16:02:41', 3, 3),
('192.168.0.4', 'Attiva', NULL, '44.4949,11.3426', 'Piazza Maggiore, Bologna', 'Escursionista disperso', '2025-08-18 23:59:10', 4, 4),
('192.168.0.5', 'Attiva', NULL, '45.4384,10.9916', 'Piazza Bra, Verona', 'Caduta in montagna', '2025-08-19 14:37:05', 5, 5),
('192.168.0.6', 'Attiva', NULL,'45.0703,7.6869','Piazza Castello, Torino','Infortunio in montagna', '2025-08-19 08:12:48', 6,6),
('192.168.0.7', 'Attiva', 'https://drive.google.com/file/d/1Ssc4Qn03QhhmaQ96jGGx-MP2zucT1o15/view?usp=sharing','44.6471,10.9252','Piazza Verdi, Parma','Incendio bosco', '2025-08-19 15:50:33', 7,7),
('192.168.0.8', 'Attiva', NULL,'45.5017,9.2067','Via XX Settembre, Como','Persona dispersa', '2025-08-19 00:27:19', 8,8),
('192.168.0.9', 'Attiva', 'https://drive.google.com/file/d/1F7V3-q3eEf-imyrxSFG00uYpRsD90tOr/view?usp=sharing','46.0667,11.1211','Piazza Duomo, Bolzano','Alluvione', '2025-08-19 11:05:57', 9,9),
('192.168.0.10', 'Attiva', NULL,'44.4064,8.9339','Piazza San Giovanni, Genova','Incidente nautico', '2025-08-19 17:22:44', 10,10);

-- Missioni
INSERT INTO Missione (Obiettivo, TimestampInizio, TimestampFine, Commenti, Successo, ID_Richiesta, ID_Squadra) VALUES
	('Assistenza sanitaria', '2025-02-14 14:15:00', '2025-02-14 15:00:00', 'Paziente stabilizzato', 4, 2, 2),
    ('Spegnimento incendio', '2025-03-20 18:00:00', '2025-03-20 21:00:00', 'Incendio domato', 5, 3, 3);
INSERT INTO Missione (Obiettivo, TimestampInizio, ID_Richiesta, ID_Squadra) VALUES    
    ('Ricerca dispersi', '2025-04-05 09:45:00', 4, 4);
INSERT INTO Missione (Obiettivo, TimestampInizio, TimestampFine, Commenti, Successo, ID_Richiesta, ID_Squadra) VALUES
	('Soccorso montagna','2025-06-15 07:00:00', '2025-06-15 11:30:00', 'Soccorso completato', 5, 6, 6);
INSERT INTO Missione (Obiettivo, TimestampInizio, ID_Richiesta, ID_Squadra) VALUES 
	('Spegnimento incendio bosco','2025-07-20 13:30:00', 7, 7);
INSERT INTO Missione (Obiettivo, TimestampInizio, TimestampFine, Commenti, Successo, ID_Richiesta, ID_Squadra) VALUES
	('Gestione alluvione','2025-09-12 08:45:00', '2025-09-12 13:00:00', 'Alluvione gestita', 4, 9, 9),
    ('Recupero in mare','2025-10-01 10:00:00', '2025-10-01 12:45:00', 'Recupero riuscito', 5, 10, 10);

-- Relazioni Amministratori - Patenti
INSERT INTO Amministratore_Possiede_Patente VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);

-- Relazioni Amministratori - Abilità
INSERT INTO Amministratore_Possiede_Abilita VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);

-- Relazioni Operatori - Patenti
INSERT INTO Operatore_Possiede_Patente VALUES
(1,2),(2,3),(3,4),(4,5),(5,1),(6,7),(7,8),(8,9),(9,10),(10,6);

-- Relazioni Operatori - Abilità
INSERT INTO Operatore_Possiede_Abilita VALUES
(1,2),(2,3),(3,4),(4,5),(5,1),(6,7),(7,8),(8,9),(9,10),(10,6);

-- Mezzi usati nelle missioni
INSERT INTO Mezzi_Usati_Missione VALUES
(1,1),(1,2),
(2,1),(3,3),
(4,4),(5,5),
(6,6),(6,7),
(7,7);

-- Materiali usati nelle missioni
INSERT INTO Materiali_Usati_Missione VALUES
(1,1),(1,2),
(2,2),(3,3),
(4,4),(5,5),
(6,6),(6,7),
(7,7);

-- Composizione squadre
INSERT INTO Composizione_Squadra VALUES
(1,1,'Caposquadra'),
(1,2,'Operatore'),
(2,3,'Caposquadra'),
(3,4,'Caposquadra'),
(4,5,'Caposquadra'),
(6,6,'Caposquadra'),
(6,7,'Operatore'),
(7,8,'Caposquadra'),
(8,9,'Caposquadra'),
(9,10,'Caposquadra');

-- Missioni aggiornate
INSERT INTO Missioni_Aggiornate VALUES
(1,2,'2025-02-14 14:30:00','Aggiornamento: paziente trasportato'),
(2,3,'2025-03-20 19:00:00','Aggiornamento: incendio sotto controllo'),
(3,4,'2025-04-05 12:00:00','Aggiornamento: zona perimetrata'),
(4,6,'2025-06-15 08:00:00','Squadra in avvicinamento'),
(5,7,'2025-07-20 14:00:00','Fiamme sotto controllo'),
(6,9,'2025-09-12 09:15:00','Allerta fiumi'),
(7,10,'2025-10-01 10:30:00','Imbarcazioni pronte');