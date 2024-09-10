
-----------------------------------------------
-- Criando o esquema universidade
-----------------------------------------------
DROP SCHEMA IF EXISTS universidade CASCADE;
CREATE SCHEMA universidade;
SET search_path TO universidade;


-- -----------------------------------------------------
-- Tabela FACULDADE
-- -----------------------------------------------------
CREATE TABLE faculdade (
  sigla		CHAR(5)		NOT NULL,
  nome		VARCHAR(100),
  predio	CHAR(5),
  orcamento	DECIMAL(10,2),
  -- restrições
  CONSTRAINT pk_faculdade PRIMARY KEY (sigla)
);

-- -----------------------------------------------------
-- Tabela PROFESSOR
-- -----------------------------------------------------
CREATE TABLE professor (
  id		CHAR(11)	NOT NULL,
  nome		VARCHAR(255)	NOT NULL,
  fac_prof	CHAR(5)		NOT NULL,
  admissao	DATE,
  -- restrições
  CONSTRAINT pk_professor PRIMARY KEY (id),
  CONSTRAINT fk_faculdade FOREIGN KEY (fac_prof) REFERENCES faculdade (sigla)
);

-- -----------------------------------------------------
-- Tabela ESTUDANTE
-- -----------------------------------------------------
CREATE TABLE estudante (
  id		CHAR(11)	NOT NULL,
  nome		VARCHAR(255)	NOT NULL,
  datanasc	DATE,
  fac_est	CHAR(5)		NOT NULL,
  cra		REAL,
  tutor		CHAR(11),
  -- restrições
  CONSTRAINT pk_estudante PRIMARY KEY (id),
  CONSTRAINT fk_faculdade FOREIGN KEY (fac_est) REFERENCES faculdade (sigla),
  CONSTRAINT fk_tutor FOREIGN KEY (tutor) REFERENCES professor (id)
);

-- -----------------------------------------------------
-- Tabela DISCIPLINA
-- -----------------------------------------------------
CREATE TABLE disciplina (
  codigo	CHAR(6)		NOT NULL,
  nome		VARCHAR(70)	NOT NULL,
  fac_disc	CHAR(5)		NOT NULL,
  ch	    SMALLINT, -- carga horária
  -- restrições
  CONSTRAINT pk_disciplina PRIMARY KEY (codigo),
  CONSTRAINT fk_faculdade FOREIGN KEY (fac_disc) REFERENCES faculdade (sigla)
);

-- -----------------------------------------------------
-- Tabela PRE-REQUISITO
-- -----------------------------------------------------
CREATE TABLE pre_requisito (
  cod_disc	CHAR(6)	NOT NULL,
  cod_pre	CHAR(6)	NOT NULL,
  -- restrições
  CONSTRAINT pk_pre_requisito PRIMARY KEY (cod_disc, cod_pre),
  CONSTRAINT fk_disciplina FOREIGN KEY (cod_disc) REFERENCES disciplina (codigo),
  CONSTRAINT fk_pre_requisito FOREIGN KEY (cod_pre) REFERENCES disciplina (codigo)
);

-- -----------------------------------------------------
-- Tabela SALA
-- -----------------------------------------------------
CREATE TABLE sala (
  predio	CHAR(5)		NOT NULL,
  numero	SMALLINT		NOT NULL,
  capacidade	INTEGER,
  -- restrições
  CONSTRAINT pk_sala PRIMARY KEY (predio, numero)
);

-- -----------------------------------------------------
-- Tabela TURMA
-- -----------------------------------------------------
CREATE TABLE turma (
  id		INTEGER	NOT NULL,
  turma		CHAR(2)		NOT NULL,
  semestre	INTEGER		NOT NULL,
  ano		INTEGER		NOT NULL,
  cod_disc	CHAR(6)		NOT NULL,
  predio_s	CHAR(5),
  n_sala	INTEGER,
  -- restrições
  CONSTRAINT pk_turma PRIMARY KEY (id),
  CONSTRAINT uq_turma UNIQUE (turma, semestre, ano, cod_disc),
  CONSTRAINT fk_disciplina FOREIGN KEY (cod_disc) REFERENCES disciplina (codigo),
  CONSTRAINT fk_sala FOREIGN KEY (predio_s, n_sala) REFERENCES sala (predio, numero)
);

-- -----------------------------------------------------
-- Tabela ENSINA
-- -----------------------------------------------------
CREATE TABLE ensina (
  id_prof	CHAR(11)	NOT NULL,
  id_turma	INTEGER		NOT NULL,
  -- restrições
  CONSTRAINT pk_ensina PRIMARY KEY (id_prof, id_turma),
  CONSTRAINT fk_prof_ensina FOREIGN KEY (id_prof) REFERENCES professor (id),
  CONSTRAINT fk_ensina_turma FOREIGN KEY (id_turma) REFERENCES turma (id)
);

-- -----------------------------------------------------
-- Tabela FREQUENTA
-- -----------------------------------------------------
CREATE TABLE frequenta (
  id_est	CHAR(11)	NOT NULL,
  id_turma	INTEGER	NOT NULL,
  nota	REAL,
  -- restrições
  CONSTRAINT pk_frequenta PRIMARY KEY (id_est, id_turma),
  CONSTRAINT fk_est_frequenta FOREIGN KEY (id_est) REFERENCES estudante (id),
  CONSTRAINT fk_frequenta_turma FOREIGN KEY (id_turma) REFERENCES turma (id)
);

-- -----------------------------------------------------
-- Tabela HORARIO
-- -----------------------------------------------------
CREATE TABLE horario (
  id_hora		CHAR(1)	NOT NULL,	
  hora_inicio	TIME,
  hora_fim	TIME,
  -- restrições
  CONSTRAINT pk_horario PRIMARY KEY (id_hora)
);


-- -----------------------------------------------------
-- Tabela SEMANA
-- -----------------------------------------------------
CREATE TABLE semana (
  id_sem		CHAR(1)	NOT NULL,	
  descricao VARCHAR(13),
  -- restrições
  CONSTRAINT pk_semana PRIMARY KEY (id_sem)
);

-- -----------------------------------------------------
-- Tabela HORARIO_AULA
-- -----------------------------------------------------
CREATE TABLE horario_aula (
  id_sem CHAR(1) NOT NULL,
  id_hora	CHAR(1)	NOT NULL,
  id_turma	INTEGER		NOT NULL,

  -- restrições
  CONSTRAINT pk_horario_aula PRIMARY KEY (id_sem,id_hora, id_turma),
  CONSTRAINT fk_horario_aula FOREIGN KEY (id_hora) REFERENCES horario (id_hora),
  CONSTRAINT fk_semana_aula FOREIGN KEY (id_sem) REFERENCES semana (id_sem),
  CONSTRAINT fk_aula_turma FOREIGN KEY (id_turma) REFERENCES turma (id)
);


