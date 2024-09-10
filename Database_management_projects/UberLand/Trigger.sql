CREATE OR REPLACE FUNCTION VerificarAvaliacaoMotorista()
RETURNS TRIGGER AS 
$$
BEGIN
    IF (select p.Avaliação from motorista p, VIAGEM v, UBER u where p.ID = u.MID AND u.UBER_ID = 'U99999' LIMIT 1) < 3.0 THEN
        RAISE EXCEPTION 'Avaliação do motorista muito baixa. Viagem não permitida.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE or replace TRIGGER Trigger_VerificarAvaliacaoMotorista
BEFORE INSERT ON VIAGEM
FOR EACH ROW
EXECUTE FUNCTION VerificarAvaliacaoMotorista();
	