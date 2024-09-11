SET search_path TO UBERLAND;

CREATE OR REPLACE FUNCTION GetVehicleCount()
RETURNS INTEGER AS $$
DECLARE
    vehicle_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO vehicle_count
    FROM Veiculo;

    RETURN vehicle_count;
END;
$$ LANGUAGE plpgsql;

SELECT GetVehicleCount();

-------------------------------------------------------------------------------------------------------------

create or replace procedure TotalViagensDoMotorista(IN p_motorista_id CHAR(6), OUT p_total_viagens INT)
AS 
$$
BEGIN
    SELECT COUNT(*) INTO p_total_viagens
    FROM VIAGEM
    WHERE Viajar_MID = p_motorista_id;
END;
$$ LANGUAGE plpgsql;