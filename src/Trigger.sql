-- =========================
-- TRIGGER PER VINCOLI EXTRA
-- =========================

DELIMITER $$

-- Vincolo: Alle Richieste devono essere associate delle stringhe lunghe e casuali, che saranno poi i Link
DROP TRIGGER IF EXISTS trg_link_casuale $$
CREATE TRIGGER trg_link_casuale
BEFORE INSERT ON Richiesta
FOR EACH ROW
BEGIN
   IF NEW.Link IS NULL OR NEW.Link = '' THEN
		SET NEW.Link = CONCAT('https://', UUID());
   END IF;
END$$

-- Vincolo: una squadra deve avere almeno un Caposquadra
DROP TRIGGER IF EXISTS trg_check_caposquadra_insert $$
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

-- Vincolo: se elimini un operatore da una squadra ci deve sempre rimanere almeno un caposquadra
DROP TRIGGER IF EXISTS trg_check_caposquadra_delete $$
CREATE TRIGGER trg_check_caposquadra_delete
BEFORE DELETE ON Composizione_Squadra
FOR EACH ROW
BEGIN
    DECLARE caposquadra_count INT;

    IF OLD.ruolo = 'Caposquadra' THEN
        SELECT COUNT(*) INTO caposquadra_count
        FROM Composizione_Squadra
        WHERE ID_Squadra = OLD.ID_Squadra
          AND Ruolo = 'Caposquadra'
          AND ID_Operatore <> OLD.ID_Operatore;

        IF caposquadra_count = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Non puoi rimuovere l\'ultimo caposquadra della squadra.';
        END IF;
    END IF;
END$$


-- Vincolo: se aggiorni il ruolo di un operatore, deve comunque rimanere almeno un Caposquadra
DROP TRIGGER IF EXISTS trg_check_caposquadra_update $$
CREATE TRIGGER trg_check_caposquadra_update
BEFORE UPDATE ON Composizione_Squadra
FOR EACH ROW
BEGIN
    DECLARE caposquadra_count INT;

    IF OLD.Ruolo = 'Caposquadra' AND NEW.Ruolo = 'Operatore' THEN
        SELECT COUNT(*) INTO caposquadra_count
        FROM Composizione_Squadra
        WHERE ID_Squadra = OLD.ID_Squadra
          AND Ruolo = 'Caposquadra'
          AND ID_Operatore <> OLD.ID_Operatore;

        IF caposquadra_count = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Non puoi degradare l\'ultimo caposquadra della squadra.';
        END IF;
    END IF;
END$$

-- Vincolo: Una richiesta può diventare una missione se e solo se il suo stato è "Attiva" e gli attributi TimestampFine, Successo e Commenti
-- sono NULL
DROP TRIGGER IF EXISTS check_richiesta_attiva $$
CREATE TRIGGER check_richiesta_attiva
BEFORE INSERT ON MISSIONE
FOR EACH ROW
PRECEDES check_missione_tsinizio
BEGIN
    DECLARE stato_richiesta VARCHAR(20);

    SELECT Stato
    INTO stato_richiesta
    FROM Richiesta
    WHERE ID_Richiesta = NEW.ID_Richiesta;

    IF stato_richiesta <> 'Attiva' THEN
		SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Impossibile creare la missione: richiesta non attiva';
	ELSE -- La Richiesta è Attiva
		IF (NEW.TimestampFine IS NULL) AND (NEW.Successo IS NULL) AND (NEW.Commenti IS NULL) THEN
			UPDATE Richiesta SET Stato = 'In Corso' WHERE ID_Richiesta = NEW.ID_Richiesta;
		ELSE
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Impossibile creare la missione: stai chiudendo una Missione non ancora creata';
		END IF;
    END IF;
END$$

-- Vincolo: Gli attributi TimestampFine, Successo e Commenti se vengono inseriti (tranne Commenti che è opzionale), lo stato passa a "Chiusa"
CREATE TRIGGER chiudi_richiesta_after_update
AFTER UPDATE ON Missione
FOR EACH ROW
BEGIN
    IF NEW.Successo IS NOT NULL AND NEW.TimestampFine IS NOT NULL THEN
        UPDATE Richiesta
        SET Stato = 'Chiusa'
        WHERE ID_Richiesta = NEW.ID_Richiesta
          AND Stato <> 'Chiusa';
    END IF;
END$$


-- Vincolo: Se la missione è già completa (ha Successo e TimestampFine) richiesta diventa 'Chiusa'. 
-- Se la missione non è completa richiesta passa da 'Attiva' a 'In Corso'.
CREATE TRIGGER aggiorna_richiesta_after_insert
AFTER INSERT ON Missione
FOR EACH ROW
BEGIN
    -- Se la missione ha Successo e TimestampFine valorizzati → Chiusa
    IF NEW.Successo IS NOT NULL AND NEW.TimestampFine IS NOT NULL THEN
        UPDATE Richiesta
        SET Stato = 'Chiusa'
        WHERE ID_Richiesta = NEW.ID_Richiesta;
    ELSE
        -- Altrimenti, se la richiesta era solo 'Inviata', passa a 'In Corso'
        UPDATE Richiesta
        SET Stato = 'In Corso'
        WHERE ID_Richiesta = NEW.ID_Richiesta
          AND Stato = 'Attiva';
    END IF;
END$$

-- Vincolo: Se inserisco una nuova Missione, il suo TimestampInzio deve essere successivo al TimestampRichiesta della Richiesta relativa
DROP TRIGGER IF EXISTS check_missione_tsinizio $$
CREATE TRIGGER check_missione_tsinizio
BEFORE INSERT ON MISSIONE
FOR EACH ROW
FOLLOWS check_richiesta_attiva
BEGIN
    DECLARE ts_richiesta DATETIME;

	SELECT TimestampRichiesta
	INTO ts_richiesta
	FROM Richiesta
	WHERE ID_Richiesta = NEW.ID_Richiesta;
        
	IF NEW.TimestampInizio < ts_richiesta THEN
		SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Impossibile inserire la missione: Timestamp incoerente con la Richiesta';
	END IF;
END$$

-- Vincolo: Se chiudo una Missione, il suo TimestampFine deve essere successivo al TimestampInizio
DROP TRIGGER IF EXISTS check_missione_tsfine $$
CREATE TRIGGER check_missione_tsfine
BEFORE UPDATE ON MISSIONE
FOR EACH ROW
FOLLOWS check_fine_missione
BEGIN
    IF NEW.TimestampFine < NEW.TimestampInizio THEN
		SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Impossibile inserire la missione: Timestamp incoerente con la Missione';
	END IF;
END$$

-- Vincolo: Se modifico lo stato di una Richiesta, l'unico che posso inserire manualmente è 'Annullata', altrimenti errore
DROP TRIGGER IF EXISTS check_richiesta_update_stato $$
CREATE TRIGGER check_richiesta_update_stato
AFTER UPDATE ON Richiesta
FOR EACH ROW
BEGIN
    DECLARE missione INT;
    
    IF OLD.Stato <> NEW.Stato AND NEW.Stato <> 'Annullata'THEN
		SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Impossibile cambiare stato richiesta: incoerenza con la missione relativa';
	END IF;
END$$

-- Vincolo: Lo stato iniziale di una Richiesta deve essere 'Attiva'; se così non fosse, lo corregge e lo notifica
DROP TRIGGER IF EXISTS check_richiesta_stato_before_insert $$
CREATE TRIGGER check_richiesta_stato_before_insert
BEFORE INSERT ON Richiesta
FOR EACH ROW
BEGIN
	IF NEW.Stato <> 'Attiva' THEN
		SET NEW.Stato = 'Attiva';
        
        -- Genero un warning (non blocca l’Insert)
        SIGNAL SQLSTATE '01000'
            SET MESSAGE_TEXT = 'Stato iniziale non valido: impostato automaticamente a Attiva';
    END IF;
END$$

-- Vincolo: Se una Richiesta è Chiusa o Annullata (terminata), la Missione relativa è ormai archiviata e non può più essere modificata
DROP TRIGGER IF EXISTS check_missione_chiusa $$
CREATE TRIGGER check_missione_chiusa
BEFORE UPDATE ON Missione
FOR EACH ROW
PRECEDES check_fine_missione
BEGIN
     DECLARE stato_richiesta VARCHAR(20);

    SELECT Stato
    INTO stato_richiesta
    FROM Richiesta
    WHERE ID_Richiesta = NEW.ID_Richiesta;

    IF stato_richiesta = 'Chiusa' OR stato_richiesta = 'Annullata' THEN
		SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = 'Impossibile aggiornare la missione: la missione è ormai archiviata';
    END IF;
END$$

DELIMITER ;