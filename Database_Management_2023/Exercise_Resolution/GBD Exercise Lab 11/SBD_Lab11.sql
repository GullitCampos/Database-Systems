--1)
Create sequence incrementa_id
	INCREMENT 1;

CREATE OR REPLACE FUNCTION NOVO_Estu ()
RETURNS Void AS
$$
BEGIN
 INSERT INTO estudante VALUES 
(nextval('incrementa_id'),'Carlos','2000-04-09','FECIV',80.5,'1200');
END;
$$ language 'plpgsql';

Select NOVO_Estu();

--2)

CREATE OR REPLACE FUNCTION insert_3tabelas(
    f_id_prof ensina.id_prof%TYPE,
	f_id_turma frequenta.id_turma%TYPE,
	f_id_est frequenta.id_est%TYPE,
    f_nota frequenta.nota%TYPE,
	f_turma turma.turma%TYPE,
	f_semestre turma.semestre%TYPE,
	f_ano turma.ano%TYPE,
	f_cod_disc turma.cod_disc%TYPE,
	f_predio_s turma.predio_s%TYPE,
	f_n_sala turma.n_sala%TYPE
) RETURNS VOID AS
$$
BEGIN
	
	INSERT INTO turma (id, turma, semestre, ano, cod_disc, predio_s, n_sala) VALUES 
	(f_id_turma, f_turma, f_semestre, f_ano, f_cod_disc, f_predio_s, f_n_sala);
    INSERT INTO ensina(id_prof, id_turma) VALUES (f_id_prof, f_id_turma);  
	INSERT INTO frequenta(id_est, id_turma, nota) VALUES (f_id_est, f_id_turma, f_nota); 
    
    RAISE NOTICE 'sucesso';
END;
$$
LANGUAGE plpgsql;


SELECT insert_3tabelas('1100', 1155, '1205', 90.2, 'GG', 1, 2023, '1100', '3Q', 306);

3)

CREATE OR REPLACE FUNCTION inserir_professor(
	f_id professor.id%TYPE,
	f_nome professor.nome%TYPE,
	f_fac_prof professor.fac_prof%TYPE,
	f_admissao professor.admissao%TYPE
) RETURNS VOID AS 
$$
BEGIN
  IF f_nome IS NULL OR f_nome = '' THEN
    RAISE EXCEPTION 'Erro semântico: Nome do professor não pode ser nulo ou vazio.';
  ELSE

    INSERT INTO professor (id, nome, fac_prof, admissao)
    VALUES (f_id, f_nome, f_fac_prof, f_admissao);

	RAISE NOTICE 'Professor inserido com sucesso.';
  END IF;
END;
$$ LANGUAGE plpgsql;


SELECT inserir_professor('1206', '', 'FECIV', '2023-01-01');


4)

5)

CREATE OR REPLACE FUNCTION remover_turmas(
  f_ano INTEGER,
  f_semestre INTEGER,
  f_min_alunos INTEGER
) RETURNS VOID AS
$$
BEGIN
  -- Deletar turmas com menos de N alunos
  DELETE FROM turma
  WHERE ano = f_ano
  AND semestre = f_semestre
  AND (SELECT COUNT(*) FROM frequenta WHERE id_turma = turma.id) < f_min_alunos;
END;
$$ LANGUAGE plpgsql;

select remover_turmas(2023, 1 , 1);