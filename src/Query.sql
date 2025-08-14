-- ========================
-- OPERAZIONI DA REALIZZARE
-- ========================

-- 1. Inserimento di una richiesta di soccorso.
INSERT INTO Richiesta (IP, Foto, Coordinate, Indirizzo, Descrizione, ID_Segnalatore, ID_Amministratore) VALUES
('192.168.0.2', NULL, '41.9028,12.4964',  'Via del Corso, Roma', 'Caduta di un albero', 2,  1);
-- ------------------- GESTIRE IP E FOTO -----------------

-- 2. Creazione di una missione connessa a una richiesta di soccorso attiva.
-- -------------------------- GESTIRE ATTIVAZIOnE LInK ------------------------------

-- 3. Chiusura di una missione.
INSERT INTO Missioni_Concluse (ID_Missione, Commenti, Successo, TimestampFine) VALUES
(4, 'Missione completata con successo, nessun ferito.', 5, '2025-08-14 16:30:00');

-- 4. Estrazione della lista degli operatori non coinvolti in missioni in corso.