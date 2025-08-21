-- =========================
-- TRIGGER PER VINCOLI EXTRA
-- =========================

DELIMITER $$

-- Vincolo: quando chiudi una Missione in Missioni_Concluse ci deve essere una coerenza con la Squadra usata in quella missione 
-- (usiamo il trigger per non dover rispecificare ID_Squadra per chiudere una Missione)
DROP TRIGGER IF EXISTS trg_squadra_missione_conclusa $$
CREATE TRIGGER trg_squadra_missione_conclusa
BEFORE INSERT ON Missioni_Concluse
FOR EACH ROW
BEGIN
    SET NEW.ID_Squadra = (SELECT ID_Squadra FROM Missione WHERE ID_Missione = NEW.ID_Missione);
END$$

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

-- Vincolo: Una richiesta può diventare una missione se e solo se il suo stato è "Attiva"
DROP TRIGGER IF EXISTS check_richiesta_attiva $$
CREATE TRIGGER check_richiesta_attiva
BEFORE INSERT ON MISSIONE
FOR EACH ROW
BEGIN
    DECLARE stato_richiesta VARCHAR(20);

    SELECT Stato
    INTO stato_richiesta
    FROM Richiesta
    WHERE ID_Richiesta = NEW.ID_Richiesta;

    IF stato_richiesta = 'Attiva' THEN
		UPDATE Richiesta SET Stato = 'In Corso' WHERE ID_Richiesta = NEW.ID_Richiesta;
	ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Impossibile creare la missione: richiesta non attiva';
    END IF;
END$$

-- Vincolo: Una missione può essere conclusa se e solo se lo stato della richiesta relativa è "In Corso"
DROP TRIGGER IF EXISTS check_richiesta_in_corso $$
CREATE TRIGGER check_richiesta_in_corso
BEFORE INSERT ON Missioni_Concluse
FOR EACH ROW
BEGIN
	DECLARE richiesta INT;
    DECLARE stato_richiesta VARCHAR(20);

    SELECT ID_Richiesta
    INTO richiesta
    FROM Missione
    WHERE ID_Missione = NEW.ID_Missione;
    
    SELECT Stato
    INTO stato_richiesta
    FROM Richiesta
    WHERE ID_Richiesta = richiesta;

    IF stato_richiesta = 'In Corso' THEN
		UPDATE Richiesta SET Stato = 'Chiusa' WHERE ID_Richiesta = richiesta;
	ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Impossibile creare la missione: richiesta non attiva';
    END IF;
END$$

DELIMITER ;