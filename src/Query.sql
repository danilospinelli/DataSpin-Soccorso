-- ========================
-- OPERAZIONI DA REALIZZARE
-- ========================


-- 1. Inserimento di una richiesta di soccorso.
INSERT INTO Richiesta (IP, Foto, Coordinate, Indirizzo, Descrizione, ID_Segnalatore, ID_Amministratore) VALUES
('192.168.0.2', NULL, '41.9028,12.4964',  'Via del Corso, Roma', 'Caduta di un albero', 2,  1);


-- 2. Creazione di una missione connessa a una richiesta di soccorso attiva. 
INSERT INTO Missione (Obiettivo, TimeStampInizio, ID_Richiesta, ID_Squadra) VALUES
('Rimuovere un albero', NOW(), 5, 1);
  

-- 3. Chiusura di una missione.
UPDATE Missione
SET TimestampFine = '2025-04-05 16:00:00',
	Commenti = 'Dispersi ritrovati indenni',
    Successo = 5
WHERE ID_Missione = 3; -- Chiude la Missione 3


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
		SELECT SEC_TO_TIME(AVG(TIMESTAMPDIFF(SECOND, m.TimestampInizio, m.TimestampFine))) AS TempoMedio
		FROM Missione m
		WHERE YEAR(m.TimestampInizio) = anno;
    ELSE
		-- per ciascun caposquadra
		SELECT cs.ID_Operatore, SEC_TO_TIME(AVG(TIMESTAMPDIFF(SECOND, m.TimestampInizio, m.TimestampFine))) AS TempoMedio
		FROM Missione m
		JOIN Composizione_Squadra cs ON m.ID_Squadra = cs.ID_Squadra
		WHERE cs.Ruolo = 'Caposquadra'
		GROUP BY cs.ID_Operatore;
    END IF;
END$$
DELIMITER ;

CALL query6(2025);
CALL query6(NULL);

-- 7. Calcolo del numero di richieste provenienti da un certo soggetto segnalante (identificato dall'indirizzo email) 
-- o da un certo indirizzo IP nelle ultime 36 ore.
DELIMITER $$
CREATE PROCEDURE query7(IN email VARCHAR(255), IN ip VARCHAR(45))
BEGIN
    SELECT COUNT(*) AS NumeroRichieste
    FROM Richiesta R
    LEFT JOIN Segnalatore S ON S.ID_Segnalatore = R.ID_Segnalatore
    WHERE R.TimeStampRichiesta >= NOW() - INTERVAL 36 HOUR
      AND (
           (email IS NOT NULL AND S.Email = email)
           OR (ip IS NOT NULL AND R.IP = ip)
      );
END$$
DELIMITER ;

CALL query7('andrea.fontana@mail.com', NULL);
CALL query7(NULL, '192.168.0.5');


-- 8. Calcolo del tempo totale di impiego in missione di un certo operatore (cioè somma delle durata delle missioni in cui è stato coinvolto)
DELIMITER $$
CREATE PROCEDURE query8(IN operatore INT)
BEGIN
    SELECT O.ID_Operatore,
           O.Nome,
           O.Cognome,
           SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, M.TimeStampInizio, M.TimestampFine))) AS TempoTotale
    FROM Operatore O
    JOIN Composizione_Squadra CS ON O.ID_Operatore = CS.ID_Operatore
    JOIN Missione M ON CS.ID_Squadra = M.ID_Squadra
    WHERE O.ID_Operatore = operatore
    GROUP BY O.ID_Operatore, O.Nome, O.Cognome;
END$$
DELIMITER ;

CALL query8(3); -- Calcola il tempo per l'Operatore 3


-- 9. Estrazione delle missioni svoltesi negli ultimi tre anni nello stesso luogo di una missione data.
-- (Qui noi supponiamo che i dati siano consistenti tra di loro, così da evitare indirzzi uguali e cordinate diverse o viceversa)
DELIMITER $$
CREATE PROCEDURE query9(IN missione INT)
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
      AND M2.TimeStampInizio >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
      AND (R2.Indirizzo = R1.Indirizzo OR R2.Coordinate = R1.Coordinate);
END$$
DELIMITER ;

CALL query9(5); -- Calcola per la Missione 5


-- 10. Estrazione della lista delle richieste di soccorso chiuse con risultato non totalmente positivo (livello di successo minore di 5).
CREATE OR REPLACE VIEW RichiesteNonPositive AS
SELECT R.ID_Richiesta,
       R.Descrizione,
       R.Indirizzo,
       R.Coordinate,
       M.TimestampFine,
       M.Successo,
       M.Commenti
FROM Richiesta R
JOIN Missione M ON R.ID_Richiesta = M.ID_Richiesta
WHERE M.Successo IS NOT NULL AND M.Successo < 5;

SELECT * FROM RichiesteNonPositive;


-- 11. Estrazione degli operatori maggiormente coinvolti nelle richieste di soccorso chiuse con risultato non totalmente positivo
-- (calcolate come alla query precedente).
SELECT O.ID_Operatore,
	   O.Nome,
	   O.Cognome,
       COUNT(M.ID_Missione) AS NumeroMissioniNonPositive
FROM Operatore O
JOIN Composizione_Squadra CS ON O.ID_Operatore = CS.ID_Operatore
JOIN Missione M ON CS.ID_Squadra = M.ID_Squadra
JOIN RichiesteNonPositive V ON V.ID_Richiesta = M.ID_Richiesta
GROUP BY O.ID_Operatore, O.Nome, O.Cognome
ORDER BY NumeroMissioniNonPositive DESC;


-- 12. Estrazione dello storico delle missioni in cui è stato coinvolto un certo mezzo.
DELIMITER $$
CREATE PROCEDURE query12(IN mezzo INT)
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
END$$
DELIMITER ;

CALL query12(3); -- Estrae o storico per il Mezzo 3


-- 13. Calcolo delle ore d'uso di un certo materiale (supponiamo che il tempo d'uso uso corrisponda alla durata totale 
-- della missione in cui è stato assegnato).
DELIMITER $$
CREATE PROCEDURE query13(IN materiale INT)
BEGIN
    SELECT 
        Mat.ID_Materiale,
        Mat.Nome,
        SEC_TO_TIME(SUM(TIMESTAMPDIFF(SECOND, M.TimeStampInizio, M.TimestampFine))) AS OreTotaliUso
    FROM Materiale Mat
    JOIN Materiali_Usati_Missione MU ON Mat.ID_Materiale = MU.ID_Materiale
    JOIN Missione M ON MU.ID_Missione = M.ID_Missione
    WHERE Mat.ID_Materiale = materiale
    GROUP BY Mat.ID_Materiale, Mat.Nome;
END$$
DELIMITER ;

CALL query13(2); -- Calcola per il Materiale 2