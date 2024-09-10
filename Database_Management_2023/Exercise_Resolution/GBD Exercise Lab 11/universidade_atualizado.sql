
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
  id		CHAR(11)		NOT NULL,
  nome		VARCHAR(255)	NOT NULL,
  fac_prof	CHAR(5)			NOT NULL,
  admissao	DATE,
  -- restrições
  CONSTRAINT pk_professor PRIMARY KEY (id),
  CONSTRAINT fk_faculdade FOREIGN KEY (fac_prof) REFERENCES faculdade (sigla)
);

-- -----------------------------------------------------
-- Tabela ESTUDANTE
-- -----------------------------------------------------
CREATE TABLE estudante (
  id		CHAR(11)		NOT NULL,
  nome		VARCHAR(255)	NOT NULL,
  datanasc	DATE,
  fac_est	CHAR(5)			NOT NULL,
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
  codigo	CHAR(10)	NOT NULL,
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
  cod_disc	CHAR(10)	NOT NULL,
  cod_pre	CHAR(10)		NOT NULL,
  -- restrições
  CONSTRAINT pk_pre_requisito PRIMARY KEY (cod_disc, cod_pre),
  CONSTRAINT fk_disciplina FOREIGN KEY (cod_disc) REFERENCES disciplina (codigo),
  CONSTRAINT fk_pre_requisito FOREIGN KEY (cod_pre) REFERENCES disciplina (codigo)
);

-- -----------------------------------------------------
-- Tabela SALA
-- -----------------------------------------------------
CREATE TABLE sala (
  predio		CHAR(5)		NOT NULL,
  numero		SMALLINT	NOT NULL,
  capacidade	INTEGER,
  -- restrições
  CONSTRAINT pk_sala PRIMARY KEY (predio, numero)
);

-- -----------------------------------------------------
-- Tabela TURMA
-- -----------------------------------------------------
CREATE TABLE turma (
  id		INTEGER		NOT NULL,
  turma		CHAR(2)		NOT NULL,
  semestre	INTEGER		NOT NULL,
  ano		INTEGER		NOT NULL,
  cod_disc	CHAR(10)	NOT NULL,
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
  id_turma	INTEGER		NOT NULL,
  nota		REAL,
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
  hora_fim		TIME,
  -- restrições
  CONSTRAINT pk_horario PRIMARY KEY (id_hora)
);


-- -----------------------------------------------------
-- Tabela SEMANA
-- -----------------------------------------------------
CREATE TABLE semana (
  id_sem	CHAR(1)	NOT NULL,	
  descricao VARCHAR(13),
  -- restrições
  CONSTRAINT pk_semana PRIMARY KEY (id_sem)
);

-- -----------------------------------------------------
-- Tabela HORARIO_AULA
-- -----------------------------------------------------
CREATE TABLE horario_aula (
  id_sem CHAR(1) 	NOT NULL,
  id_hora CHAR(1)	NOT NULL,
  id_turma INTEGER	NOT NULL,

  -- restrições
  CONSTRAINT pk_horario_aula PRIMARY KEY (id_sem,id_hora, id_turma),
  CONSTRAINT fk_horario_aula FOREIGN KEY (id_hora) REFERENCES horario (id_hora),
  CONSTRAINT fk_semana_aula FOREIGN KEY (id_sem) REFERENCES semana (id_sem),
  CONSTRAINT fk_aula_turma FOREIGN KEY (id_turma) REFERENCES turma (id)
);


/* 
   #######################################################################################
   #######################################################################################
*/
set search_path to universidade;
delete from horario_aula;
delete from ensina;
delete from frequenta;
delete from turma;
delete from sala;
delete from horario;
delete from semana;
delete from pre_requisito;
delete from disciplina;
delete from estudante;
delete from professor;
delete from faculdade;

INSERT INTO horario (id_hora, hora_inicio, hora_fim)
VALUES
('a','07:10:00','08:00:00'),
('b','08:00:00','08:50:00'),
('c','08:50:00','09:40:00'),
('d','09:50:00','10:40:00'),
('e','10:40:00','11:30:00'),
('q','11:30:00','12:20:00'),
('f','13:10:00','14:00:00'),
('g','14:00:00','14:50:00'),
('h','14:50:00','15:40:00'),
('i','16:00:00','16:50:00'),
('j','16:50:00','17:40:00'),
('k','17:40:00','18:30:00'),
('l','18:10:00','19:00:00'),
('m','19:00:00','19:50:00'),
('n','19:50:00','20:40:00'),
('o','20:50:00','21:40:00'),
('p','21:40:00','22:30:00');


INSERT INTO semana (id_sem, descricao)
VALUES
(1, 'Domingo'), (2, 'Segunda'), (3, 'Terça'), (4 , 'Quarta'), (5, 'Quinta'), (6, 'Sexta'), (7 , 'Sábado');

INSERT INTO faculdade VALUES ('FECIV', 'Faculdade de Engenharia Civil', '1b',3000000.00); 
INSERT INTO faculdade (sigla, nome, predio, orcamento) VALUES('FEELT','Faculdade de Engenharia Elétrica','3Q',1000000); 
INSERT INTO faculdade (sigla, nome, predio, orcamento) VALUES('FAUED','Faculdade de Arquitetura e Urbanismo e Design','5M',5000000); 
INSERT INTO faculdade(sigla, nome, predio, orcamento) VALUES ('FAMED', 'Faculdade de Medicina', '6R', 6000000); 
INSERT INTO faculdade VALUES ('FOUFU', 'Faculdade de Odontologia', '4L', 172837.63); 
INSERT INTO faculdade VALUES ('ICIAG', 'Instituto de Ciências Agrárias', 'CCG', 10.00); 
insert into faculdade (sigla, nome, predio, orcamento) VALUES ('IARTE', 'Instituto de Artes', '3E', '45794635.87'); 
INSERT INTO faculdade(sigla, nome, predio, orcamento) VALUES ('INBIO', 'Instituto de Biologia', '2D', 19000000.00); 
INSERT INTO faculdade(sigla,nome,predio,orcamento) VALUES ('ESTES', 'Escola Técnica de Saúde', '4K', 156980.86); 
insert into faculdade (sigla,nome,predio,orcamento) values ('FAGEN','Faculdade de Gestao e Negocios','1F',100000.00); 
INSERT INTO faculdade VALUES ('INGEB', 'Instituto de Genetica e Bioquimica', '9K', 6000000.00); 
INSERT INTO faculdade VALUES ('FAMEV', 'Faculdade de Medicina Veterinária', '1BCG', 13000000); 
INSERT INTO faculdade VALUES ('FAEFI', 'Faculdade de Educação Física e Fisioterapia', 'EDUCA',  2000000 ); 
INSERT INTO faculdade (sigla, nome, predio, orcamento) 
VALUES ('ICBIM', 'Instituto de Ciências Biologicas', 'BIO01', 1000000.00); 
INSERT INTO faculdade(sigla,nome,predio,orcamento) VALUES ('FADIR', 'Faculdade de Direito', '3D', 2143669); 

INSERT INTO disciplina VALUES 
('CIV1','Desenho Técnico 1','FECIV',60),
('CIV2','Física 1','FECIV',60),
('CIV3','Termo-Quimica 1','FECIV',60),
('CIV4','Mecânica dos Fluídos','FECIV',90),
('CIV5','Programação Funcional','FECIV',60); 

INSERT INTO disciplina(codigo, nome, fac_disc, ch) 
VALUES 
  ('1100', 'Circuitos Elétricos 1', 'FEELT', 75), 
  ('1101', 'Circuitos Elétricos 2', 'FEELT', 60), 
  ('1102','Experimental de Circuitos Elétricos 1','FEELT',120), 
  ('1103','Experimental de Circuitos Elétricos 2','FEELT',120), 
  ('1104', 'Eletrônica Analógica 1', 'FEELT', 60); 

INSERT INTO  disciplina(codigo, nome, fac_disc, ch) VALUES   
  ('AQ01', 'Introdução a Arquitetura ', 'FAUED', 60),   
  ('DS15', 'Desenho Gráfico ', 'FAUED', 90),   
  ('URB01','Logistica Urbana 01','FAUED', 30),   
  ('AQ10','Introdução ao Autocad','FAUED', 60),   
  ('URB20', 'Politica Urbana', 'FAUED', 90); 

INSERT INTO disciplina(codigo, nome, fac_disc, ch) VALUES 
('31101', 'Saúde Coletiva 1', 'FAMED', 150), 
('31403', 'Medicina Integrada 1', 'FAMED', 390), 
('39101', 'Cuidados Paliativos', 'FAMED', 60), 
('31901', 'Estágio Supervisionado na Área Materna-Infantil', 'FAMED', 870), ('39511', 'Métodos Clínicos', 'FAMED', 60); 

INSERT INTO disciplina(codigo, nome, fac_disc, ch) VALUES  
('BIO104', 'Construção do Conhecimento Científico', 'INBIO', 30), 
('BIO105', 'Introdução ao Curso de Ciências Biológicas', 'INBIO', 30), 
('BIO106', 'Sistemática Biológica', 'INBIO', 45), 
('DIR301', 'Legislação e Direito Ambiental', 'INBIO', 45), 
('BIM206', 'Embriologia Geral', 'INBIO', 30); 

INSERT INTO  disciplina VALUES 
('ICBIM31204', 'Anatomia Humana Aplicada à Odontologia', 'FOUFU', 105), ('FOUFU31306', 'Prótese Fixa e Oclusão I', 'FOUFU', 60), 
('FOUFU31103', 'Saúde Coletiva I', 'FOUFU', 60), 
('FOUFU31305', 'Propedêutica Estomatológica III', 'FOUFU', 45), 
('FOUFU31304', 'Periodontia I', 'FOUFU', 45); 

INSERT INTO disciplina VALUES ('GAG022', 'Bioquímica', 'ICIAG', 75); 
INSERT INTO disciplina VALUES ('GAG019', 'Física do Solo', 'ICIAG', 45); 
INSERT INTO disciplina VALUES ('GAG038', 'Fitopatologia Geral', 'ICIAG', 90); 
INSERT INTO disciplina VALUES ('GAG047', 'Nutrição Animal', 'ICIAG', 45); 
INSERT INTO disciplina VALUES ('GAG057', 'Bovinocultura', 'ICIAG', 45); 

INSERT INTO disciplina (codigo, nome, fac_disc, ch) VALUES 
('1600', 'Ateliê de Desenho', 'IARTE', 60), 
('1601', 'Experimentações da Forma no Espaço', 'IARTE', 60), 
('1602', 'Imagens Técnicas', 'IARTE', 60), 
('1603', 'Ateliê de Fotografia', 'IARTE', 60), 
('1604', 'Pintura', 'IARTE', 60); 

INSERT INTO disciplina(codigo,nome,fac_disc,ch) VALUES ('EST001','prótese removível', 'ESTES', 60); 
INSERT INTO disciplina(codigo,nome,fac_disc,ch) VALUES ('EST002','biossegurança', 'ESTES', 60); 
INSERT INTO disciplina(codigo,nome,fac_disc,ch) VALUES ('EST003','Fundamentos de Laboratório I', 'ESTES', 90); 
INSERT INTO disciplina(codigo,nome,fac_disc,ch) VALUES ('EST004', 'hematologia I', 'ESTES', 30); 
INSERT INTO disciplina(codigo,nome,fac_disc,ch) VALUES ('EST005','hematologia II', 'ESTES', 60); 
 
insert into disciplina (codigo,nome,fac_disc,ch) 
values  ('FAGEN1','Empreendedorismo e Gestao de Ideias','FAGEN',60), 
        ('FAGEN2','Fundamentos de Administracao','FAGEN',60), 
        ('FAGEN3','Fundamentos de Marketing','FAGEN',60), 
        ('FAGEN4','Matematica 1','FAGEN',60), 
        ('FAGEN5','Comportamento Organizacional','FAGEN',60); 

INSERT INTO  disciplina VALUES 
('GEB00', 'Genetica', 'INGEB', 90), 
('GEB01', 'Bioquimica', 'INGEB', 90), 
('GEB36', 'Biologia Molecular', 'INGEB', 90), 
('GEB52', 'Citogenetica', 'INGEB', 60),
('GEB82', 'Sensores Biologicos', 'INGEB', 60); 

INSERT INTO disciplina VALUES 
('GMV003','Bioquímica 1','FAMEV',75), 
('GMV007','Bioquímica 2','FAMEV',75), 
('GMV005','Fundamentos de Anatomia Veterinária','FAMEV',75), 
('GMV006','Anatomia dos Animais Domésticos','FAMEV',75), 
('GMV001','Citologia, Histologia e Embriologia','FAMEV',75); 

INSERT INTO disciplina VALUES ('400', 'Pscicologia do Esporte', 'FAEFI', 30.09), 
 ('410', 'Gestão em Educação Física', 'FAEFI', 31.72), 
 ('420', 'Fisiologia Humana', 'FAEFI', 50.20), 
 ('430', 'Cinesiologia', 'FAEFI', 51.30), 
 ('440', 'Comportamento Motor', 'FAEFI', 41.20), 
 ('460', 'Estágio Curricular', 'FAEFI', 180.00); 

INSERT INTO disciplina (codigo, nome, fac_disc, ch) VALUES  
    ('DSC001', 'Matemática Discreta', 'ICBIM', 60), 
    ('DSC002', 'Bioquímica Básica', 'ICBIM', 90), 
    ('DSC003', 'Biologia Celular', 'ICBIM', 75), 
    ('DSC004', 'Genética Molecular', 'ICBIM', 60), 
    ('DSC005', 'Imunologia', 'ICBIM', 90); 

INSERT INTO disciplina(codigo,nome,fac_disc,ch) VALUES  
('DIR001','Direito Cívil 1', 'FADIR', 30), 
('DIR002','Direito Constitucional', 'FADIR', 30), 
('DIR003','Metodologia e Epistemologia', 'FADIR', 60), 
('DIR004', 'Teoria do Direito (matutino)', 'FADIR', 30), 
('DIR005','Teoria do Estado e Democracia', 'FADIR', 60); 


INSERT INTO professor VALUES 
('1200','Joao','FECIV','2022-08-19'),
('1201','Maria','FECIV','2022-08-19'),
('1202','Roberto','FECIV','2022-08-19'),
('1203','Walter','FECIV','2022-08-19'),
('1204','Adriana','FECIV','2022-08-19'); 

INSERT INTO professor (id, nome, fac_prof, admissao) VALUES 
  ('1100','Alcimar Barbosa Soares','FEELT','2010-02-05'), 
  ('1101','Ana Beatriz Fernandes Silva','FEELT','2000-10-05'), 
  ('1102','Daniel Pereira de Carvalho','FEELT','2009-12-07'), 
  ('1103','Éder Alves de Moura','FEELT','2006-10-19'), 
  ('1104', 'Elise Saraiva', 'FEELT', '2000-10-05'); 

INSERT INTO professor (id, nome, fac_prof, admissao) VALUES   
  ('2200','Theodore Evelyn Mosby','FAUED','2005-09-19'),   
  ('2201','Tracy McConnell','FAUED','2013-05-13'),   
  ('2202','Michael Gary Scott','FAUED','2005-03-24'),   
  ('2203','Jim Duncan Halpert','FAUED','2008-10-01'),   
  ('2204', 'Walter Hartwell White', 'FAUED', '2008-01-20'); 

INSERT INTO professor (id, nome, fac_prof, admissao) values 
('1600', 'Alexander Gaiotto Miyoshi', 'IARTE', '01-06-2018'), 
('1601', 'Alexandre José Molina', 'IARTE', '01-06-2018'), 
('1602', 'Alexandre Teixeira', 'IARTE', '01-06-2018'), 
('1603', 'Ana Elvira Wuo', 'IARTE', '01-06-2018'), 
('1605', 'André Campos Machado', 'IARTE', '01-01-2022'); 

INSERT INTO professor(id, nome, fac_prof, admissao) VALUES  
('1700', 'Alan Nilo da Costa', 'INBIO', '2018-02-27'), 
('1701', 'Celine de Melo', 'INBIO', '2005-08-05'), 
('1702', 'Daniela Franco Carvalho', 'INBIO', '2008-09-26'), 
('1703', 'Flávio Popazoglo', 'INBIO', '2009-07-24'), 
('1704', 'Jimi Naoki Nakajima', 'INBIO', '1992-01-01'); 

INSERT INTO professor (id, nome, fac_prof, admissao) VALUES 
('800', 'Aércio Sebastião Borges', 'FAMED', '2000-03-14'), 
('801', 'Gustavo Antonio Raimondi', 'FAMED', '2015-03-04'), 
('802', 'Helena Borges Martins da Silva Paro', 'FAMED', '2011-08-08'), 
('803', 'Hélio Lopes da Silveira', 'FAMED', '1983-07-01'), 
('804', 'Guilherme Marques Andrade', 'FAMED', '2021-06-22'); 

INSERT INTO professor VALUES 	
('1500', 'Adriano Mota Loyola', 'FOUFU', '1988-12-01'), 
('1501', 'Alessandra Maia de Castro Prado', 'FOUFU', '2010-03-26'), 
('1502', 'Alex Moreira Herval', 'FOUFU', '2019-06-18'), 
('1503', 'Ana Paula Turrioni Hidalgo', 'FOUFU', '2015-12-01'), 
('1504', 'Jamil Carlos Lopes', 'FOUFU', '2023-04-19'), 
('1505', 'Carlos Salem Barbar', 'FOUFU', '1995-01-11'); 

INSERT INTO professor VALUES ('1800', 'Felipe Antunes Magalhães', 'ICIAG', '2022-02-02'); 
INSERT INTO professor VALUES ('1801', 'Leandro Martins Barbero', 'ICIAG', '2022-02-03'); 
INSERT INTO professor VALUES ('1802', 'Renata Santos Rodrigues', 'ICIAG', '2022-02-04'); 
INSERT INTO professor VALUES ('1803', 'Elias Nascentes Borges', 'ICIAG', '2022-02-05'); 
INSERT INTO professor VALUES ('1804', 'Alison Talis Martins Lima', 'ICIAG', '2022-02-06'); 

INSERT INTO professor(id, nome, fac_prof, admissao) VALUES ('904', 'Dnieber Chagas de Assis', 'ESTES', '2003-03-05'); 
INSERT INTO professor(id, nome, fac_prof, admissao) VALUES ('994', 'Mário Paulo de Elias', 'ESTES', '2008-03-07'); 
INSERT INTO professor(id, nome, fac_prof, admissao) VALUES ('992', 'Marisa Aparecida Pedroso', 'ESTES', '2010-02-15'); 
INSERT INTO professor(id, nome, fac_prof, admissao) VALUES ('920', 'Sebastião Marcos Tafuri', 'ESTES', '2012-07-25'); 
INSERT INTO professor(id, nome, fac_prof, admissao) VALUES ('953', 'Luiz Carlos Prestes', 'ESTES', '1998-10-22'); 
 
insert into professor (id,nome,fac_prof,admissao) 
values  ('2100','Marcia Freire de Oliveira','FAGEN','2008-08-07'), 
        ('2101','Aleandra da Silva Figueira Sampaio','FAGEN','2017-09-16'), 
        ('2102','Rodrigo Miranda','FAGEN','2009-07-24'), 
        ('2103','Elisa Regina dos Santos','FAGEN','2013-07-15'), 
        ('2104','Aurea de Fatima Oliveira','FAGEN','1994-01-01'); 

INSERT INTO professor VALUES 	
('1000', 'Luizote Dias', 'INGEB', '2010-06-03'), 
('1001', 'Joao Gomes', 'INGEB', '2006-07-10'), 
('1002', 'Aurelio Carvalho', 'INGEB', '2022-08-17'), 
('1003', 'Matheus Rodrigues', 'INGEB', '2011-11-01'), 
('1004', 'Ana Paula Padrao', 'INGEB', '2021-09-03'); 

INSERT INTO professor VALUES 
('1300','Kelly Aparecida Geraldo Yoneyama Tudini','FAMEV','2000-09-09'),
('1301','Lucas de Assis Ribeiro','FAMEV','2005-07-26'),
('1302','Natália Mundim Tôrres','FAMEV','2007-07-09'),
('1303','Tiago Wilson Patriarca Mineo ','FAMEV','2004-10-07'),
('1304','Neide Maria da Silva ','FAMEV','2000-12-09'); 

INSERT INTO professor VALUES 
    ('411', 'Eduardo Henrique Rosa', 'FAEFI', '2019/06/10'), 
    ('401', 'Cristiano Lino Monteiro', 'FAEFI', '2020/03/21'), 
    ('421', 'Giselle Helena Tavares', 'FAEFI', '2016/06/01'), 
    ('431', 'Nadia Carla Cheik', 'FAEFI', '2018/02/09'), 
    ('441', 'João Elias Dias', 'FAEFI', '2017/10/21'); 

INSERT INTO professor (id, nome, fac_prof, admissao) VALUES  
    ('2000', 'João Silva', 'ICBIM', '2010-05-01'), 
    ('2001', 'Maria Souza', 'ICBIM', '2015-09-15'), 
    ('2002', 'Pedro Santos', 'ICBIM', '2018-01-01'), 
    ('2003', 'Carla Rocha', 'ICBIM', '2019-07-01'), 
    ('2004', 'Fernanda Oliveira', 'ICBIM', '2021-03-01'); 

INSERT INTO professor(id, nome, fac_prof, admissao) VALUES 
('690', 'Maribel Luciana', 'FADIR', '2015-02-27'), 
('621', 'Douglas Flaviano da Silva', 'FADIR', '2001-02-01'), 
('679', 'Henrique de Ferraz', 'FADIR', '2020-01-13'), 
('645', 'Marcelo Fagundes Peixoto', 'FADIR', '2000-07-23'), 
('623', 'Lucas Lascerda Ferreira', 'FADIR', '1995-12-22'); 

INSERT INTO estudante VALUES 
('1205','Lucas','2000-05-20','FECIV',72.5,'1200'),
('1206','Ana','1999-09-27','FECIV',86,'1201'),
('1207','Amanda','2000-08-20','FECIV',67,'1202'),
('1208','Nicole','2000-03-14','FECIV',78,'1203'),
('1209','Jorge','2000-01-08','FECIV',91,'1204'); 

INSERT INTO estudante (id, nome, datanasc, fac_est, cra, tutor) VALUES 
  ('1170','Ronan Lynch','1995-05-21', 'FEELT', 71.4,'1100'), 
  ('1171','Amanda Pereira','2000-06-26', 'FEELT', 80.1,'1101'), 
  ('1172','Fran Silva','2000-03-16','FEELT', 79.6,'1103' ), 
  ('1173','Paulo David','2000-08-15','FEELT',88.0,'1104'), 
  ('1174','Voldemort Borges','1996-01-26','FEELT',100.0,'1100'); 
 

INSERT INTO estudante (id, nome, datanasc, fac_est, cra, tutor) VALUES   
  ('2205','Anderson Alves','1997-10-15', 'FAUED', 15.3,'2200'),   
  ('2206','Pedro Murilo Brugger','2000-04-01', 'FAUED', 99.9,'2201'),   
  ('2207','Dwight Kurt Schrute III ','1970-02-20','FAUED', 100.0,'2202'),   
  ('2208','Pamela Morgan Halpert ','1979-03-25','FAUED', 59.9,'2203'),   
  ('2209','Jesse Bruce Pinkman','1984-09-24','FAUED', 10.1,'2204');   

INSERT INTO estudante (id, nome, datanasc, fac_est, cra, tutor) VALUES 
('800', 'João Kratos da Silva', '2000-01-01', 'FAMED', 99.32, '802'), 
('801', 'Godrick Rocha', '2004-06-21', 'FAMED', 75, '803'), 
('802', 'Malenia Robusta Thannus', '1995-07-03', 'FAMED', 44.91, '801'), 
('803', 'Ana Vitória Lemos Souza', '2003-11-21', 'FAMED', 88, '804'), 
('804', 'Caio Rolando da Rocha', '2001-12-31', 'FAMED', 71.2, '803'); 

INSERT INTO estudante VALUES  
('1506', 'Eric Caspas', '2002-03-13', 'FOUFU', 74.02, '1500'), 
('1507', 'Vincent Fabron', '1998-01-23', 'FOUFU', 91.1, '1501'), 
('1508', 'Pyke da Silva', '1997-05-18', 'FOUFU', 90.76, '1502'), 
('1509', 'Gabriel Toledo', '1982-12-03', 'FOUFU', 84.45, '1503'), 
('1510', 'Luzinete Camargo', '1955-03-12', 'FOUFU', 70.12, '1504'); 

INSERT INTO estudante VALUES ('12021CCG036', 'Gabriel Henrique de Oliveira', '2002-07-10', 'ICIAG', 10, '1804'); 
INSERT INTO estudante VALUES ('12011CCG009', 'Guilherme Henrique Andrade Otoni', '2001-05-17', 'ICIAG', 50, '1803'); 
INSERT INTO estudante VALUES ('12021CCG007', 'Luan Carrijo Ferreira', '2002-09-07', 'ICIAG', 90, '1804'); 
INSERT INTO estudante VALUES ('12021CCG055', 'Maria Eduarda Koyama de Moraes', '2002-06-29', 'ICIAG', 40, '1801'); 
INSERT INTO estudante VALUES ('12021CCG042', 'Isabela de Paula Barbosa', '2002-04-10', 'ICIAG', 64, '1802'); 

INSERT INTO estudante (id, nome, datanasc, fac_est, cra, tutor) VALUES 
('1600', 'ALYNE BORGES GUIMARAES', '2003-04-24', 'IARTE', 35, '1600'), 
('1601', 'STEPHANIE PADIU', '2001-03-14', 'IARTE', 98, NULL), 
('1602', 'AMANDA GABRIELLI PEREIRA', '1999-02-07', 'IARTE', 83, '1600'), 
('1603', 'PAULO VITOR DELMINDO', '2001-09-13', 'IARTE', 69, '1602'), 
('1604', 'VIVIANE AIKO', '1998-08-07', 'IARTE', 70, '1605'); 

INSERT INTO estudante(id, nome, datanasc, fac_est, cra, tutor) VALUES  
('1700', 'Joel Miller da Costa', '1980-05-13', 'INBIO', 82.0, '1702'), 
('1701', 'Joseph Manuel Gomes', '2001-04-20', 'INBIO', 90.0, '1700'), 
('1702', 'Geraldo Campos', '1999-11-21', 'INBIO', 74.6, '1704'), 
('1703', 'Lucas Copper da Silva', '2002-07-23', 'INBIO', 76.1, '1703'), 
('1704', 'Miguel Tyler Rocha', '2003-06-01', 'INBIO', 63.8, '1701'); 

INSERT INTO estudante(id, nome,datanasc, fac_est, cra, tutor) VALUES ('950', 'João Pedro de Souza', '2003-03-07', 'ESTES', 65, '904'); 
INSERT INTO estudante(id, nome,datanasc, fac_est, cra, tutor) VALUES ('910', 'Maria Luiza Antonieta', '2002-05-10', 'ESTES', 72, '994'); 
INSERT INTO estudante(id, nome,datanasc, fac_est, cra, tutor) VALUES ('911', 'Laura Menezes da Cruz', '2003-03-23', 'ESTES', 65, '920'); 
INSERT INTO estudante(id, nome,datanasc, fac_est, cra, tutor) VALUES ('997', 'Douglas Matos Fukushima', '2003-03-07', 'ESTES', 90, '953'); 
INSERT INTO estudante(id, nome,datanasc, fac_est, cra, tutor) VALUES ('998', 'Alex Paulo de Souza Lima', '2000-03-07', 'ESTES', 76, '992'); 

insert into estudante (id,nome,datanasc,fac_est,cra,tutor) 
values  ('21110BAD020','Joao','1998-06-21','FAGEN',63.5,'2100'), 
        ('21120BAD021','Pedrinho','1999-08-15','FAGEN',92.0,'2101'), 
        ('21130BAD022','Maria','1997-03-05','FAGEN',86.6,'2102'), 
        ('21140BAD023','Julia','1998-11-12','FAGEN',85.0,'2103'), 
        ('21150BAD024','Gabriela','1997-09-22','FAGEN',64.0,'2100'); 

INSERT INTO estudante VALUES  
('1005', 'Lucas Oliveira', '1998-03-29', 'INGEB', 66.5, '1000'), 
('1006', 'Lorenzo Costa', '2000-03-17', 'INGEB', 89.7, '1001'), 
('1007', 'Luisa Arantes', '1998-08-28', 'INGEB', 81.7, '1502'), 
('1008', 'Alice Ferreira', '1997-11-04', 'INGEB', 78.7, '1003'), 
('1009', 'Lucas Geraldo', '2000-02-22', 'INGEB', 72, '1004'); 

INSERT INTO estudante VALUES 
('1300','João Augusto Silva','2000-09-09','FAMEV',80,DEFAULT),
('1301','Pedro Nunes','2001-12-09','FAMEV',90,1300),
('1302','Augusto Pereira','1999-01-28','FAMEV',73,DEFAULT),
('1303','Maria Ferreira','2000-02-02','FAMEV',95,1304),
('1304','Ana Paula Freitas','2002-10-18','FAMEV',89,DEFAULT); 

INSERT INTO estudante VALUES 
('402', 'Anastasia Beatrice Ribeiro', '1997/05/12', 'FAEFI', 96.78, '401' ), 
('412', 'Bruno Rafael de Lima', '1992/06/01', 'FAEFI', 91.50, '421' ), 
('422', 'Carlos Alberto Pereira', '1995/12/03', 'FAEFI', 52.81, '401' ), 
('432', 'Gustavo Henrique da Silva', '1999/09/30', 'FAEFI', 74.25, '431' ), 
('442', 'Rafaela Cristina Oliveira', '1996/11/08', 'FAEFI', 62.31, '441' ); 

INSERT INTO estudante (id, nome, datanasc, fac_est, cra, tutor) VALUES  
    ('2005', 'Ana Souza', '2002-01-15', 'ICBIM', 90, '2000'), 
    ('2006', 'Bruno Santos', '2003-04-25', 'ICBIM', 85, '2001'), 
    ('2007', 'Camila Lima', '2001-09-10', 'ICBIM', 95, '2002'), 
    ('2008', 'Diego Pereira', '2004-06-18', 'ICBIM', 92, '2003'), 
    ('2009', 'Evelyn Costa', '2000-12-31', 'ICBIM', 88, '2004'); 

INSERT INTO estudante(id, nome,datanasc, fac_est, cra, tutor) VALUES  
('678', 'Gustavo Jesus da Silva', '2001-06-30', 'FADIR', 32, '690'), 
('666', 'Pedro Torres Borelli', '2004-08-12', 'FADIR', 72, '621'), 
('661', 'Gustavo Mamede', '2021-05-23', 'FADIR', 65, '679'), 
('653', 'Monica Matos', '2007-12-20', 'FADIR', 90, '645'), 
('679', 'Alexandre Souza Junqueira', '2000-03-07', 'FADIR', 76, '623'); 

INSERT INTO sala VALUES ('A',1,30),('B',2,35),('C',3,40); 

INSERT INTO sala (predio, numero, capacidade) VALUES 
  ('3Q', 306, 30), 
  ('3Q', 207, 40), 
  ('3Q', 108, 35); 

INSERT INTO sala (predio, numero, capacidade)   VALUES   
  ('5M', 001, 90),   
  ('5M', 010, 60),   
  ('5M', 011, 30); 

INSERT INTO sala (predio, numero, capacidade) VALUES ('8C', 222, 60), ('8D', 223, 40), ('5S', 101, 60); 

INSERT INTO sala VALUES  ('4L', 202, 50), ('4L', 204, 45), ('4L', 206, 50); 

INSERT INTO sala VALUES ('CCG', 203, 30); 
INSERT INTO sala VALUES ('CCG', 204, 30); 
INSERT INTO sala VALUES ('CCG', 205, 30); 

INSERT INTO sala (predio, numero, capacidade) VALUES 
('3E', 201, 60), 
('3E', 202, 60), 
('3E', 102, 40); 

INSERT INTO sala(predio, numero, capacidade) VALUES  
('2D', 101, 45), 
('2D', 201, 50), 
('2D', 203, 60); 

INSERT INTO sala(predio, numero, capacidade) VALUES ('4K', 103, 75); 
INSERT INTO sala(predio, numero, capacidade) VALUES ('4K', 104, 80); 
INSERT INTO sala(predio, numero, capacidade) VALUES ('4K', 105, 75); 
 
insert into sala (predio,numero,capacidade) 
values  ('3Q','301',60), 
        ('3Q','302',60), 
        ('3Q','303',60); 

INSERT INTO sala VALUES ('9K', 100, 40), 
('9K', 102, 40),  
('9K', 104, 40); 

INSERT INTO sala VALUES ('1BCG', 101, 50), ('1BCG', 102, 40), ('1BCG', 103, 90); 

INSERT INTO sala VALUES ('4J', 102, 100), 
('4K', 107, 100), 
('4L', 106, 100), 
('4M', 106, 100), 
('4N', 108, 100), 
('5O', 102, 300), 
('5P', 104, 300); 

INSERT INTO sala (predio, numero, capacidade) VALUES 
  ('ICB01', 101, 50), 
  ('ICB02', 201, 40), 
  ('ICB03', 301, 30); 

INSERT INTO sala(predio, numero, capacidade) VALUES 
('3D', 206, 60), 
('4K', 210, 45), 
('4K', 208, 55); 

INSERT INTO turma VALUES 
(1210,'A',1,2023,'CIV1','A',1),(1211,'B',2,2023,'CIV2','B',2),(1212,'C',3,2023,'CIV3','C',3),(1213,'D',4,2023,'CIV4','A',1),(1214,'E',5,2023,'CIV5','B',2),(1215,'F',5,2023,'CIV5','C',3); 

INSERT INTO turma (id, turma, semestre, ano, cod_disc, predio_s, n_sala) VALUES 
  (1150, 'AA', 1, 2023, '1100', '3Q', 306), 
  (1151, 'AB', 1, 2023, '1100', '3Q', 306), 
  (1152, 'JJ', 1, 2022, '1101', '3Q', 207), 
  (1153, 'KK', 1, 2022, '1102', '3Q', 207), 
  (1154, 'DD', 1, 2021, '1103', '3Q', 108); 

INSERT INTO turma (id, turma, semestre, ano, cod_disc, predio_s, n_sala)  VALUES 
  (2210, 'AA', 1, 2023, 'AQ01',  '5M', 001),   
  (2211, 'BA', 2, 2022, 'URB01', '5M', 010),   
  (2212, 'CA', 1, 2021, 'DS15',  '5M', 011),   
  (2213, 'DA', 2, 2020, 'AQ10',  '5M', 010),   
  (2214, 'EA', 1, 2019, 'URB20', '5M', 011);   

INSERT INTO turma (id, turma, semestre, ano, cod_disc, predio_s, n_sala) VALUES (800, '67', 4, 2023, '31101', '8C', 222), 
(801, '68', 4, 2023, '31101', '8C', 222), 
(802, '65', 6, 2020, '31403', '8D', 223), 
(803, '66', 5, 2022, '39101', '5S', 101), 
(804, '66', 5, 2023, '31901', '5S', 101); 

INSERT INTO turma VALUES 
(1511, '1A', 1, 2023, 'ICBIM31204', '4L', 202), 
(1512, '1B', 2, 2022, 'FOUFU31304', '4L', 204), 
(1513, '2A', 2, 2023, 'FOUFU31304', '4L', 204),
(1514, '2B', 1, 2023, 'FOUFU31305', '4L', 206), 
(1515, '2C', 2, 2022, 'FOUFU31103', '4L', 204); 

INSERT INTO turma VALUES (1800, '1A', 1, 2022, 'GAG022', 'CCG', 203); 
INSERT INTO turma VALUES (1801, '1A', 1, 2022, 'GAG019', 'CCG', 204); 
INSERT INTO turma VALUES (1802, '1B', 1, 2022, 'GAG019', 'CCG', 204); 
INSERT INTO turma VALUES (1803, '1A', 1, 2022, 'GAG047', 'CCG', 205); 
INSERT INTO turma VALUES (1804, '1A', 1, 2022, 'GAG057', 'CCG', 205); 

INSERT INTO turma (id, turma, semestre, ano, cod_disc, predio_s, n_sala) VALUES 
(1600, 'A', 2, 2023, '1600', '3E', 201), 
(1601, 'A', 2, 2023, '1601', '3E', 202), 
(1602, 'A', 2, 2023, '1602', '3E', 102), 
(1603, 'B', 2, 2023, '1602', '3E', 102), 
(1604, 'A', 2, 2023, '1604', '3E', 201); 

INSERT INTO turma(id, turma, semestre, ano, cod_disc, predio_s, n_sala) VALUES  
(1700, '43', 1, 2022, 'BIO104', '2D', 101), 
(1701, '38', 2, 2021, 'BIO105', '2D', 101), 
(1702, '76', 1, 2023, 'BIO106', '2D', 201), 
(1703, '50', 1, 2023, 'DIR301', '2D', 201), 
(1704, '63', 2, 2023, 'BIM206', '2D', 203), 
(1705, '57', 2, 2023, 'BIM206', '2D', 203); 

INSERT INTO turma(id, turma, semestre, ano, cod_disc, predio_s, n_sala) VALUES (901, '50', 1, 2023, 'EST001', '4K', 103); 
INSERT INTO turma(id, turma, semestre, ano, cod_disc, predio_s, n_sala) VALUES (902, '49', 2, 2022, 'EST002', '4K', 104); 
INSERT INTO turma(id, turma, semestre, ano, cod_disc, predio_s, n_sala) VALUES (903, '50', 1, 2023, 'EST003', '4K', 103); 
INSERT INTO turma(id, turma, semestre, ano, cod_disc, predio_s, n_sala) VALUES (904, '50', 1, 2023, 'EST004', '4K', 105); 
INSERT INTO turma(id, turma, semestre, ano, cod_disc, predio_s, n_sala) VALUES (905, '49', 2, 2022, 'EST004', '4K', 105); 

insert into turma (id,turma,semestre,ano,cod_disc,predio_s,n_sala) 
values  (2120,'01',1,2017,'FAGEN1','3Q',301), 
        (2121,'02',1,2018,'FAGEN2','3Q',301), 
        (2122,'03',2,2019,'FAGEN3','3Q',302), 
        (2123,'04',2,2020,'FAGEN4','3Q',302), 
        (2124,'05',1,2021,'FAGEN5','3Q',303), 
        (2125,'06',1,2022,'FAGEN5','3Q',303); 

INSERT INTO turma VALUES 
(1050, '60', 2, 2022, 'GEB00', '9K', 100),  
(1051, '60', 2, 2022, 'GEB01', '9K', 100),  
(1052, '61', 2, 2022, 'GEB36', '9K', 102),  
(1053, '61', 2, 2023, 'GEB52', '9K', 102),  
(1054, '61', 2, 2023, 'GEB82', '9K', 104); 

INSERT INTO turma VALUES 
(1300, 'A', 1, 2022, 'GMV003', '1BCG', 101), 
(1301, 'B', 1, 2022, 'GMV007', '1BCG', 102), 
(1302, 'C', 1, 2022, 'GMV005', '1BCG', 103), 
(1303, 'D', 1, 2022, 'GMV006', '1BCG', 103), 
(1304, 'E', 1, 2022, 'GMV001', '1BCG', 102), 
(1305, 'F', 1, 2022, 'GMV005', '1BCG', 103); 

INSERT INTO turma VALUES (403, 'CA', 2, 2020, '400' ,'4J', 102), 
(413, 'CA', 1, 2021, '400', '4J', 102), 
(423, 'CB', 2, 2021, '410', '4M', 106), 
(433, 'CB', 1, 2022, '420', '5O', 102), 
(443, 'CA', 2, 2022, '460', '5P', 104);
 

INSERT INTO turma (id, turma, semestre, ano, cod_disc, predio_s, n_sala) VALUES 
  (2010, 'A', 1, 2022, 'DSC001', 'ICB01', 101), 
  (2011, 'B', 1, 2022, 'DSC002', 'ICB01', 101), 
  (2012, 'C', 2, 2022, 'DSC003', 'ICB01', 101), 
  (2013, 'D', 2, 2022, 'DSC004', 'ICB01', 101);

INSERT INTO turma(id, turma, semestre, ano, cod_disc, predio_s, n_sala) VALUES  
(669, '34', 5, 2021, 'DIR001', '3D', 206), 
(661, '45', 2, 2021, 'DIR002', '3D', 206), 
(665, '35', 6, 2022, 'DIR003', '4K', 210), 
(670, '36', 5, 2022, 'DIR005', '4K', 208); 

INSERT INTO pre_requisito VALUES ('CIV4','CIV2'),('CIV5','CIV1'); 

INSERT INTO pre_requisito(cod_disc, cod_pre) VALUES 
  ('1101', '1100'), 
  ('1103', '1102'); 

INSERT INTO pre_requisito(cod_disc, cod_pre) VALUES   
  ('AQ10', 'AQ01'),   
  ('URB20','URB01'); 

INSERT INTO pre_requisito(cod_disc, cod_pre) VALUES  
('BIM206', 'BIO105'), 
('DIR301', 'BIO106'); 

INSERT INTO pre_requisito (cod_disc, cod_pre) VALUES ('31901', '31101'), ('39511', '39101'); 
INSERT INTO pre_requisito VALUES ('ICBIM31204', 'FOUFU31304'), ('FOUFU31305', 'FOUFU31103'), ('FOUFU31306', 'FOUFU31305'); 

INSERT INTO pre_requisito VALUES ('GAG022', 'GAG019'); 
INSERT INTO pre_requisito VALUES ('GAG019', 'GAG057'); 
INSERT INTO pre_requisito VALUES ('GAG019', 'GAG038'); 
INSERT INTO pre_requisito VALUES ('GAG057', 'GAG047'); 
INSERT INTO pre_requisito VALUES ('GAG057', 'GAG022'); 

insert into pre_requisito (cod_disc, cod_pre) VALUES 
('1603', '1600'), 
('1604', '1601'); 

INSERT INTO pre_requisito(cod_disc,cod_pre) VALUES ('EST005', 'EST004'); 
INSERT INTO pre_requisito(cod_disc,cod_pre) VALUES ('EST001', 'EST002'); 

insert into pre_requisito (cod_disc,cod_pre) 
values  ('FAGEN1','FAGEN5'), 
        ('FAGEN2','FAGEN3'); 

INSERT INTO pre_requisito VALUES ('GEB36', 'GEB01'), ('GEB52', 'GEB00'); 
INSERT INTO pre_requisito VALUES ('GMV007', 'GMV003'), ('GMV006', 'GMV005'); 
INSERT INTO pre_requisito VALUES ('400', '410'),('420', '430'); 

INSERT INTO pre_requisito (cod_disc, cod_pre) 
VALUES  
    ('DSC002', 'DSC001'), 
    ('DSC003', 'DSC002'), 
    ('DSC004', 'DSC003'), 
    ('DSC005', 'DSC002'), 
    ('DSC005', 'DSC003'); 

INSERT INTO pre_requisito(cod_disc,cod_pre) VALUES 
('DIR001', 'DIR005'), 
('DIR002', 'DIR003'); 

INSERT INTO ensina VALUES ('1200',1210),('1201',1211),('1202',1212),('1203',1213),('1204',1214); 

INSERT INTO frequenta VALUES ('1205',1210,85),('1206',1211,76.5),('1207',1212,65),('1208',1213,78),('1209',1214,97.5);  

INSERT INTO ensina(id_prof, id_turma) 
VALUES 
  ('1100', 1150), 
  ('1101', 1151), 
  ('1102', 1152), 
  ('1103', 1153), 
  ('1104', 1154); 

INSERT INTO frequenta(id_est, id_turma, nota) 
VALUES 
  ('1170', 1150, 75.0), 
  ('1171', 1151, 67.0), 
  ('1172', 1152, 99.0), 
  ('1173', 1153, 97.0), 
  ('1174', 1154, 64.0); 

INSERT INTO ensina(id_prof, id_turma)  VALUES  
  ('2200', 2210),  
  ('2201', 2211),  
  ('2202', 2212),  
  ('2203', 2213),  
  ('2204', 2214);  

INSERT INTO frequenta(id_est, id_turma, nota)  VALUES  
  ('2205', 2210, 90.0),  
  ('2206', 2211, 100.0),  
  ('2207', 2212, 99.9),  
  ('2208', 2213, 60.0),  
  ('2209', 2214, 10.0);  

INSERT INTO frequenta (id_est, id_turma, nota) VALUES 
('800', 803, 77), 
('804', 800, 44), 
('802', 801, 99), 
('801', 802, 59.99), 
('803', 804, 61);  

INSERT INTO ensina (id_prof, id_turma) 
VALUES ('800', 803), ('803', 804), ('801', 800), ('804', 801), ('802', 802); 

INSERT INTO ensina VALUES   ('1500',1511), ('1501',1512), ('1502',1513), ('1503',1514),('1504',1511);  

INSERT INTO frequenta VALUES ('1506',1511,90.2), ('1507',1512,88.7), ('1508',1513,68.2), ('1509',1514,60.0), ('1510',1511,91.3);					 
INSERT INTO frequenta VALUES('12021CCG036', 1804, 10); 
INSERT INTO frequenta VALUES('12011CCG009', 1802, 50); 
INSERT INTO frequenta VALUES('12021CCG007', 1803, 90); 
INSERT INTO frequenta VALUES('12021CCG055', 1802, 40); 
INSERT INTO frequenta VALUES('12021CCG042', 1803, 64); 

INSERT INTO ensina VALUES('1800', 1800); 
INSERT INTO ensina VALUES('1801', 1801); 
INSERT INTO ensina VALUES('1801', 1802); 
INSERT INTO ensina VALUES('1802', 1803); 
INSERT INTO ensina VALUES('1803', 1804); 

insert into ensina (id_prof, id_turma) VALUES 
('1600', 1600), 
('1601', 1601), 
('1602', 1602), 
('1603', 1603), 
('1605', 1604); 
 
insert into frequenta (id_est, id_turma, nota) VALUES 
('1600', 1600, 30.5), 
('1601', 1601, 90.8), 
('1602', 1602, 73.0), 
('1603', 1603, 67.1), 
('1604', 1604, 74.5); 
 
INSERT INTO ensina(id_prof, id_turma) VALUES  
('1700', 1700), 
('1701', 1701), 
('1702', 1702), 
('1703', 1703), 
('1704', 1704); 

INSERT INTO frequenta(id_est, id_turma, nota) VALUES  
('1700', 1700, 96.0), 
('1701', 1701, 45.2), 
('1702', 1702, 68.5), 
('1703', 1703, 77.9), 
('1704', 1704, 85.1); 

INSERT INTO ensina(id_prof, id_turma) VALUES ('904', 901); 
INSERT INTO ensina(id_prof, id_turma) VALUES ('994', 902); 
INSERT INTO ensina(id_prof, id_turma) VALUES ('992', 904); 
INSERT INTO ensina(id_prof, id_turma) VALUES ('920', 903); 
INSERT INTO ensina(id_prof, id_turma) VALUES ('953', 904); 

INSERT INTO frequenta(id_est, id_turma, nota) VALUES ('950', 903, 60); 
INSERT INTO frequenta(id_est, id_turma, nota) VALUES ('910', 904, 75); 
INSERT INTO frequenta(id_est, id_turma, nota) VALUES ('911', 901, 54); 
INSERT INTO frequenta(id_est, id_turma, nota) VALUES ('997', 902, 90); 
INSERT INTO frequenta(id_est, id_turma, nota) VALUES ('998', 901, 73); 

insert into ensina (id_prof,id_turma) 
values  ('2100',2120), 
        ('2101',2121), 
        ('2102',2122), 
        ('2103',2123), 
        ('2104',2124); 

insert into frequenta (id_est,id_turma,nota) 
values  ('21110BAD020',2120,60), 
        ('21120BAD021',2121,65), 
        ('21130BAD022',2122,70), 
        ('21140BAD023',2123,75), 
        ('21150BAD024',2124,80); 

INSERT INTO frequenta VALUES 
('1005',1052,70),('1006',1050,90),('1007',1053,80),('1008',1054,75),('1009',1051,75);  
INSERT INTO ensina VALUES ('1000',1050),('1001',1051),('1002',1052),('1003',1053),('1004',1054); 
INSERT INTO ensina VALUES ('1300', 1300), ('1301',1300), ('1302',1301), ('1303',1302), ('1304',1300); 
INSERT INTO frequenta VALUES ('1300', 1300, 80), ('1301',1300,70), ('1302',1301,90), ('1303',1302,90), ('1304',1300,95); 

INSERT INTO ensina (id_prof, id_turma) VALUES 
('2000', 2010), 
('2001', 2011), 
('2002', 2012), 
('2003', 2013), 
('2004', 2010); 
 
INSERT INTO frequenta (id_est, id_turma, nota) VALUES 
('2005', 2010, 9), 
('2006', 2011, 8.5), 
('2007', 2012, 10), 
('2008', 2013, 9), 
('2009', 2010, 7); 

INSERT INTO ensina VALUES 
('401', 403), 
('411', 413), 
('421', 423), 
('431', 433), 
('441', 443); 

INSERT INTO frequenta VALUES ('402', 403, 86.00), 
('412', 413, 90.50), 
('422', 423, 60.00), 
('432', 433, 75.00), 
('442', 443, 55.00); 

INSERT INTO ensina(id_prof, id_turma) VALUES 
('690', 669), 
('621', 670), 
('645', 665), 
('679', 661); 

INSERT INTO frequenta(id_est, id_turma, nota) VALUES 
('678', 669, 100), 
('666', 669, 75), 
('661', 665, 30), 
('653', 665, 100), 
('679', 670, 60);
