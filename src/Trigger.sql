-- =========================
-- TRIGGER PER VINCOLI EXTRA
-- =========================

DELIMITER $$

-- Vincolo: una squadra deve avere almeno un Caposquadra
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

-- Vincolo: se elimini un operatore da una squadra ci deve sempre rimanere almeno un Caposquadra
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
CREATE TRIGGER check_richiesta_attiva
BEFORE INSERT ON MISSIONE
FOR EACH ROW
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
			SET @skip_richiesta_check = 1;
			UPDATE Richiesta SET Stato = 'In Corso' WHERE ID_Richiesta = NEW.ID_Richiesta;
            SET @skip_richiesta_check = NULL;
		ELSE
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Impossibile creare la missione: stai chiudendo una Missione non ancora creata';
		END IF;
    END IF;
END$$

-- Vincolo: Gli attributi TimestampFine, Successo e Commenti di Missione possono essere inseriti se e solo se lo stato della Richiesta relativa
-- è "In Corso"; se tutti vengono inseriti (tranne Commenti che è opzionale), lo stato passa a "Chiusa"
CREATE TRIGGER check_fine_missione
BEFORE UPDATE ON Missione
FOR EACH ROW
BEGIN
	DECLARE richiesta INT;
	DECLARE stato_richiesta VARCHAR(20);
    -- Il Trigger agisce solo se sto aggiornando gli attributi interessati
    IF (NEW.TimestampFine IS NOT NULL) OR (NEW.Successo IS NOT NULL) OR (NEW.Commenti IS NOT NULL) THEN
		SELECT ID_Richiesta
		INTO richiesta
		FROM Missione
		WHERE ID_Missione = NEW.ID_Missione;
    
		SELECT Stato
		INTO stato_richiesta
		FROM Richiesta
		WHERE ID_Richiesta = richiesta;

		IF stato_richiesta <> 'In Corso' THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Impossibile chiudere la missione: richiesta non in corso';
		ELSE -- La Richiesta è In Corso
			IF (NEW.TimestampFine IS NOT NULL) AND (NEW.Successo IS NOT NULL) THEN
				SET @skip_richiesta_check = 1;
				UPDATE Richiesta SET Stato = 'Chiusa' WHERE ID_Richiesta = richiesta;
                SET @skip_richiesta_check = NULL;
			ELSE
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Impossibile chiudere la missione: mancano alcuni valori';
			END IF;
		END IF;
    END IF;
END$$

-- Vincolo: Se inserisco una nuova Missione, il suo TimestampInzio deve essere successivo al TimestampRichiesta della Richiesta relativa
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

-- Vincolo: Se modifico lo stato di una Richiesta, l'unico che posso inserire manualmente è 'Annullata', altrimenti errore; il trigger
-- parte solo se la modifica avviene manualmente, se avviene tramite trigger (che stabiliscono l'ordine corretto dei cambi di stato)
-- questo trigger non parte
CREATE TRIGGER check_richiesta_update_stato
AFTER UPDATE ON Richiesta
FOR EACH ROW
BEGIN
    IF @skip_richiesta_check IS NULL THEN
		IF OLD.Stato <> NEW.Stato AND NEW.Stato <> 'Annullata'THEN
			SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = 'Impossibile cambiare stato richiesta: incoerenza con la missione relativa';
		END IF;
	END IF;
END$$

-- Vincolo: Lo stato iniziale di una Richiesta deve essere 'Inviata'; se così non fosse, lo corregge e lo notifica
CREATE TRIGGER check_richiesta_stato_iniziale
BEFORE INSERT ON Richiesta
FOR EACH ROW
BEGIN
	IF NEW.Stato <> 'Inviata' THEN
		SET NEW.Stato = 'Inviata';
        
        -- Genero un warning (non blocca l’Insert)
        SIGNAL SQLSTATE '01000'
            SET MESSAGE_TEXT = 'Stato iniziale non valido: impostato automaticamente a Inviata';
    END IF;
END$$

-- Vincolo: Se una Richiesta è Chiusa o Annullata (terminata), la Missione relativa è ormai archiviata e non può più essere modificata
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