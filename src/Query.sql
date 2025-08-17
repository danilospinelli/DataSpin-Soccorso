-- ========================
-- OPERAZIONI DA REALIZZARE
-- ========================


-- 1. Inserimento di una richiesta di soccorso.
INSERT INTO Richiesta (IP, Foto, Coordinate, Indirizzo, Descrizione, ID_Segnalatore, ID_Amministratore) VALUES
('192.168.0.2', NULL, '41.9028,12.4964',  'Via del Corso, Roma', 'Caduta di un albero', 2,  1);


-- 2. Creazione di una missione connessa a una richiesta di soccorso attiva. 
INSERT INTO MISSIONE (Obiettivo, TimeStampInizio, ID_Richiesta, ID_Squadra) VALUES
('Rimuovere un albero', NOW(), 1, 1);
  

-- 3. Chiusura di una missione.
INSERT INTO Missioni_Concluse (ID_Missione, Commenti, Successo, TimestampFine) VALUES
(4, 'Missione completata con successo, nessun ferito.', 5, '2025-08-14 16:30:00');


-- 4. Estrazione della lista degli operatori non coinvolti in missioni in corso.
SELECT o.ID_Operatore, o.Nome, o.Cognome
FROM Operatore o
WHERE o.ID_Operatore NOT IN (
    SELECT cs.ID_Operatore
    FROM Composizione_Squadra cs
    JOIN Missione m ON cs.ID_Squadra = m.ID_Squadra
    JOIN Richiesta r ON m.ID_Richiesta = r.ID_Richiesta
    WHERE r.Stato = 'In Corso'
);


-- 5. Calcolo del numero di missioni svolte da un operatore.
DELIMITER $$
CREATE PROCEDURE query5 (IN operatore INT)
BEGIN
	SELECT COUNT(m.ID_Missione) AS NumeroMissioni
    FROM Missione m
    JOIN Composizione_Squadra cs ON m.ID_Squadra = cs.ID_Squadra
    WHERE cs.ID_Operatore = operatore;
END$$
DELIMITER ;

CALL query5(1); -- Conta il numero di Missioni svolte dall'Operatore 1



-- 6. Calcolo del tempo medio di svolgimento delle missioni (dalla creazione alla chiusura) in un anno specifico o per ciascun caposquadra.
DELIMITER $$
CREATE PROCEDURE query6 (IN anno INT)
BEGIN
	IF anno IS NOT NULL THEN
		-- in un anno specifico
		SELECT SEC_TO_TIME(AVG(TIMESTAMPDIFF(SECOND, m.TimestampInizio, mc.TimestampFine))) AS TempoMedio
		FROM Missione m
		JOIN Missioni_Concluse mc ON m.ID_Missione = mc.ID_Missione
		WHERE YEAR(m.TimestampInizio) = anno;
    ELSE
		-- per ciascun caposquadra
		SELECT cs.ID_Operatore, SEC_TO_TIME(AVG(TIMESTAMPDIFF(SECOND, m.TimestampInizio, mc.TimestampFine))) AS TempoMedio
		FROM Missione m
		JOIN Missioni_Concluse mc ON m.ID_Missione = mc.ID_Missione
		JOIN Composizione_Squadra cs ON m.ID_Squadra = cs.ID_Squadra
		WHERE cs.Ruolo = 'Caposquadra'
		GROUP BY cs.ID_Operatore;
    END IF;
END$$
DELIMITER ;

SELECT * FROM Missione;
SELECT * FROM Missioni_Concluse;
SELECT * FROM Missione m 
		JOIN Missioni_Concluse mc ON m.ID_Missione = mc.ID_Missione;
SELECT * FROM Missione m
		JOIN Missioni_Concluse mc ON m.ID_Missione = mc.ID_Missione
		JOIN Composizione_Squadra cs ON m.ID_Squadra = cs.ID_Squadra;

CALL query6(2025); -- Che anno?
CALL query6(NULL);