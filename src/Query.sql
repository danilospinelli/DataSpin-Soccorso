-- ========================
-- OPERAZIONI DA REALIZZARE
-- ========================

-- 1. Inserimento di una richiesta di soccorso.
INSERT INTO Richiesta (Link, IP, Foto, Coordinate, Indirizzo, Descrizione, ID_Segnalatore, ID_Amministratore) VALUES
(CONCAT('https://', UUID()), '192.168.0.2', NULL, '41.9028,12.4964',  'Via del Corso, Roma', 'Caduta di un albero', 2,  1);


-- 2. Creazione di una missione connessa a una richiesta di soccorso attiva.
-- ------------------------------ GESTIRE ATTIVAZIONE LINK ------------------------------
-- Creo la missione se la richiesta è attiva
INSERT INTO MISSIONE (Obiettivo, TimeStampInizio, ID_Richiesta, ID_Squadra)
SELECT 'Rimuovere un albero', NOW(), r.ID_Richiesta, 1
FROM RICHIESTA r
WHERE r.ID_Richiesta = 1
  AND r.Stato = 'Attiva';

-- Aggiorno lo stato della richiesta
UPDATE RICHIESTA
SET Stato = 'In Corso'
WHERE ID_Richiesta = 1
  AND Stato = 'Attiva';


-- 3. Chiusura di una missione.
INSERT INTO Missioni_Concluse (ID_Missione, Commenti, Successo, TimestampFine) VALUES
(4, 'Missione completata con successo, nessun ferito.', 5, '2025-08-14 16:30:00');

-- 4. Estrazione della lista degli operatori non coinvolti in missioni in corso.