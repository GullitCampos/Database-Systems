--Carlos Antônio de Melo Mendes – 12121BCC048
--Gullit Damião Teixeira de Campos - 12011BCC034
--João Vitor Gonçalves Oliveira - 11921BCC024
--Yuri Pio Macedo - 12021BCC025

SET search_path TO universidade;

--1 
--a)
CREATE TABLE auditoria_orcamento (
    sigla_faculdade CHAR(5) NOT NULL,
    orcamento_anterior DECIMAL(10, 2) ,
    novo_orcamento DECIMAL(10, 2),
    data_alteracao DATE
);

--b)
CREATE LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION orcamento_auditoria()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria_orcamento (sigla_faculdade, orcamento_anterior, novo_orcamento, data_alteracao)
    VALUES (OLD.sigla, OLD.orcamento, NEW.orcamento, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_auditoria_orcamento
AFTER UPDATE ON faculdade
FOR EACH ROW
EXECUTE FUNCTION orcamento_auditoria();


--c)
--os update na mao🤣
update faculdade set orcamento = orcamento*1.05 where sigla  = 'FECIV';
update faculdade set orcamento = orcamento*1.15 where sigla  = 'FEELT';
update faculdade set orcamento = orcamento*1.1 where sigla  = 'FAUED';
update faculdade set orcamento = orcamento*1.05 where sigla  = 'IARTE';
update faculdade set orcamento = orcamento*1.15 where sigla  = 'INBIO';
update faculdade set orcamento = orcamento*1.05 where sigla  = 'ESTES';
update faculdade set orcamento = orcamento*1.1 where sigla  = 'FAGEN';
update faculdade set orcamento = orcamento*1.1 where sigla  = 'INGEB';
update faculdade set orcamento = orcamento*1.05 where sigla  = 'FAMEV';
update faculdade set orcamento = orcamento*1.15 where sigla  = 'FAEFI';
update faculdade set orcamento = orcamento*1.1 where sigla  = 'ICBM';
update faculdade set orcamento = orcamento*1.05 where sigla  = 'FADIR';

--d)
SELECT f.nome, a.orcamento_anterior, a.novo_orcamento, a.data_alteracao
FROM auditoria_orcamento a
JOIN faculdade f ON a.sigla_faculdade = f.sigla;



--2)
-- Criação do trigger
CREATE OR REPLACE FUNCTION validar_professor_disciplina()
RETURNS TRIGGER AS $$
BEGIN
  -- Verifica se a faculdade do professor é a mesma da disciplina
  IF (SELECT fac_prof FROM professor WHERE id = NEW.id_prof) <> (SELECT fac_disc FROM disciplina WHERE codigo = NEW.cod_disc) THEN
    RAISE EXCEPTION 'Um professor só pode ministrar disciplinas de sua própria faculdade.';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validar_professor_disciplina
BEFORE INSERT ON ensina
FOR EACH ROW
EXECUTE FUNCTION validar_professor_disciplina();

--Válido
INSERT INTO ensina VALUES ('1102','1100');

--Inválido
INSERT INTO ensina VALUES ('1102', '410');



--3)
CREATE OR REPLACE FUNCTION verificar_disciplinas_professor()
RETURNS TRIGGER AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM ensina WHERE id_prof = NEW.id_prof) THEN
    RAISE NOTICE 'Atenção: Não há mais disciplinas alocadas para o Professor %', NEW.id_prof;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_disciplinas_professor
AFTER DELETE ON ensina
FOR EACH ROW
EXECUTE FUNCTION verificar_disciplinas_professor();

--Remover disciplinas de um professor
DELETE FROM ensina WHERE id_prof = '1100';



--4)
CREATE OR REPLACE FUNCTION check_max_disciplinas()
RETURNS TRIGGER AS $$
DECLARE
  disciplinas_count INTEGER;
BEGIN

  SELECT COUNT(*)
  INTO disciplinas_count
  FROM frequenta
  WHERE id_est = NEW.id_est AND id_turma IN (
    SELECT id
    FROM turma
    WHERE semestre = NEW.semestre AND ano = NEW.ano
  );


  IF disciplinas_count >= 7 THEN
    RAISE EXCEPTION 'Um aluno não pode cursar mais do que 7 disciplinas em um único semestre.';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER max_disciplinas_trigger
BEFORE INSERT
ON frequenta
FOR EACH ROW
EXECUTE FUNCTION check_max_disciplinas();

INSERT INTO frequenta(id_est, id_turma, nota) VALUES ('950', 901, 60); 
INSERT INTO frequenta(id_est, id_turma, nota) VALUES ('950', 902, 60); 
INSERT INTO frequenta(id_est, id_turma, nota) VALUES ('950', 903, 60); 
INSERT INTO frequenta(id_est, id_turma, nota) VALUES ('950', 904, 60); 
INSERT INTO frequenta(id_est, id_turma, nota) VALUES ('950', 1700, 60); 
INSERT INTO frequenta(id_est, id_turma, nota) VALUES ('950', 1701, 60); 
INSERT INTO frequenta(id_est, id_turma, nota) VALUES ('950', 1702, 60); 



--5)
CREATE OR REPLACE FUNCTION convert_to_uppercase()
RETURNS TRIGGER AS $$
BEGIN
  NEW.nome := UPPER(NEW.nome);     
  NEW.predio := UPPER(NEW.predio); 
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER uppercase_conversion_trigger_faculdade
BEFORE INSERT OR UPDATE
ON faculdade
FOR EACH ROW
EXECUTE FUNCTION convert_to_uppercase();

CREATE TRIGGER uppercase_conversion_trigger_professor
BEFORE INSERT OR UPDATE
ON professor
FOR EACH ROW
EXECUTE FUNCTION convert_to_uppercase();

CREATE TRIGGER uppercase_conversion_trigger_estudante
BEFORE INSERT OR UPDATE
ON estudante
FOR EACH ROW
EXECUTE FUNCTION convert_to_uppercase();

CREATE TRIGGER uppercase_conversion_trigger_disciplina
BEFORE INSERT OR UPDATE
ON disciplina
FOR EACH ROW
EXECUTE FUNCTION convert_to_uppercase();

INSERT INTO faculdade (sigla, nome, predio, orcamento)
VALUES ('facew', 'faculdade de sdad', '1B', 100000.00);



--6)
ALTER TABLE faculdade
ADD num_alunos INTEGER;


CREATE OR REPLACE FUNCTION atualizar_num_alunos_trigger()
RETURNS TRIGGER AS $$
BEGIN

  UPDATE faculdade AS f
  SET num_alunos = (
    SELECT COUNT(e.id)
    FROM estudante AS e
    WHERE e.fac_est = NEW.fac_est
  )
  WHERE f.sigla = NEW.fac_est;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_atualizar_num_alunos
AFTER INSERT OR UPDATE OR DELETE ON estudante
FOR EACH ROW
EXECUTE FUNCTION atualizar_num_alunos_trigger();

INSERT INTO estudante (id, nome, fac_est) VALUES ('1111', 'Carlos', 'ESTES');
select sigla, num_alunos from faculdade;
"FECIV"	15
"FEELT"	5
"FAUED"	5
"FAMED"	5
"FOUFU"	5
"ICIAG"	5
"IARTE"	5
"INBIO"	5
"FAGEN"	5
"INGEB"	5
"FAMEV"	5
"FAEFI"	5
"ICBIM"	5
"FADIR"	5
"FAMAT"	1
"ESTES"	6
INSERT INTO estudante (id, nome, fac_est) VALUES ('11111', 'Carlos', 'FADIR');
select sigla, num_alunos from faculdade;
"FECIV"	15
"FEELT"	5
"FAUED"	5
"FAMED"	5
"FOUFU"	5
"ICIAG"	5
"IARTE"	5
"INBIO"	5
"FAGEN"	5
"INGEB"	5
"FAMEV"	5
"FAEFI"	5
"ICBIM"	5
"FAMAT"	1
"ESTES"	6
"FADIR"	6



--7)
CREATE OR REPLACE VIEW TurmasFAMAT2022S01 AS
SELECT d.codigo AS codigo_disciplina, d.nome AS nome_disciplina, d.ch AS carga_horaria, t.turma, t.id
FROM disciplina d
JOIN turma t ON d.codigo = t.cod_disc
WHERE d.fac_disc = 'FAMAT' AND t.ano = 2022 AND t.semestre = 1;

CREATE OR REPLACE RULE insert_disciplina_turma AS
ON INSERT TO TurmasFAMAT2022S01
DO INSTEAD (
  INSERT INTO disciplina (codigo, nome, fac_disc, ch) 
  VALUES (NEW.codigo_disciplina, NEW.nome_disciplina, 'FAMAT', NEW.carga_horaria);
  INSERT INTO turma (id, turma, semestre, ano, cod_disc)
  VALUES (NEW.id, NEW.turma, 1, 2022, NEW.codigo_disciplina);
);

INSERT INTO TurmasFAMAT2022S01 (id, codigo_disciplina, nome_disciplina, carga_horaria, turma)
VALUES (54544, 'NOVA003', 'Nova Disciplina', 60, 'T1');



--8)
CREATE OR REPLACE VIEW faculdades_disciplinas_turmas_grandes AS
SELECT f.nome AS nome_faculdade, d.nome AS nome_disciplina, COUNT(fq.id_turma) AS total_alunos
FROM faculdade f
JOIN disciplina d ON f.sigla = d.fac_disc
JOIN turma t ON d.codigo = t.cod_disc
LEFT JOIN frequenta fq ON t.id = fq.id_turma
GROUP BY f.nome, d.nome
HAVING COUNT(fq.id_turma) > 40;




--9)
CREATE OR REPLACE VIEW alunos_matematica AS
SELECT e.id AS id_aluno, e.nome AS nome_aluno, COUNT(t.id) AS disciplinas_matriculadas
FROM estudante e
INNER JOIN frequenta f ON e.id = f.id_est
INNER JOIN turma t ON f.id_turma = t.id
INNER JOIN disciplina d ON t.cod_disc = d.codigo
WHERE d.fac_disc = 'FAMAT'  
GROUP BY e.id, e.nome
HAVING COUNT(t.id) > 2;




--10)
CREATE OR REPLACE FUNCTION calcular_porcentagem_alunos()
RETURNS TABLE (nome_faculdade VARCHAR(100), porcentagem NUMERIC) AS $$
BEGIN
  RETURN QUERY
    SELECT f.nome AS nome_faculdade, 
           (COUNT(e.id)::NUMERIC / (SELECT COUNT(id) FROM estudante)) * 100 AS porcentagem
    FROM faculdade f
    LEFT JOIN estudante e ON f.sigla = e.fac_est
    GROUP BY f.sigla, f.nome;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE VIEW porcentagem_alunos AS
SELECT * FROM calcular_porcentagem_alunos();





--11)
CREATE OR REPLACE FUNCTION criar_visao_tutoria()
RETURNS TABLE (nome_professor VARCHAR(255), nome_aluno VARCHAR(255)) AS $$
BEGIN
  RETURN QUERY
    SELECT p.nome AS nome_professor, e.nome AS nome_aluno
    FROM professor p
    LEFT JOIN estudante e ON p.id = e.tutor;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE VIEW tutoria AS
SELECT * FROM criar_visao_tutoria();

SELECT nome_professor
FROM tutoria
WHERE nome_aluno IS NULL;
--😎