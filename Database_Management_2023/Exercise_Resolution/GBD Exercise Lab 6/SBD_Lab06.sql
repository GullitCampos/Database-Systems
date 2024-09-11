-- Carlos Antônio de Melo Mendes – 12121BCC048
-- João Vitor Gonçalves Oliveira - 11921BCC024
-- Yuri Pio Macedo - 12021BCC025

SET search_path TO universidade;

INSERT INTO faculdade VALUES ('FEELT', 'Faculdade de Engenharia Eletrica', '1E', 700000);

INSERT INTO professor VALUES ('1100', 'Alcimar Barbosa', 'FEELT', '1990-02-26');
INSERT INTO professor VALUES ('1101', 'Jamil Salem', 'FEELT', '1892-04-12');
INSERT INTO professor VALUES ('1102', 'Sergio Ricardo', 'FEELT', '1998-12-11');
INSERT INTO professor VALUES ('1103', 'Claudiney Ramos', 'FEELT', '2021-05-08');
INSERT INTO professor VALUES ('1104', 'Keiji Yamanaka', 'FEELT', '2002-08-18');

INSERT INTO estudante VALUES ('1150', 'Yuri Pio Macedo', '2003-02-26', 'FEELT', 81.5, '1100');
INSERT INTO estudante VALUES ('1151', 'Carlos Antonio', '2000-09-04', 'FEELT', 72.8, '1101');
INSERT INTO estudante VALUES ('1152', 'Joao Vitor Gonçalves', '2000-10-14', 'FEELT', 70.4, '1104');
INSERT INTO estudante VALUES ('1153', 'Nezuko Kamado', '2005-01-12', 'FEELT', 80.2, '1103');
INSERT INTO estudante VALUES ('1154', 'Cristiano Ronaldo', '1998-05-12', 'FEELT', 65.2, '1103');

INSERT INTO disciplina VALUES ('31108', 'Programação Funcional', 'FEELT', 60);
INSERT INTO disciplina VALUES ('31201', 'Programação Procedimental', 'FEELT', 90);
INSERT INTO disciplina VALUES ('31401', 'Eletrônica Analítica', 'FEELT', 60);
INSERT INTO disciplina VALUES ('31806', 'Instrumentação Biomédica', 'FEELT', 90);
INSERT INTO disciplina VALUES ('31606', 'Eletrônica de Potência', 'FEELT', 60);

INSERT INTO pre_requisito VALUES ('31108','31201');
INSERT INTO pre_requisito VALUES ('31401','31606');

INSERT INTO sala VALUES ('1B', 206, 80);
INSERT INTO sala VALUES ('1B', 102, 80);
INSERT INTO sala VALUES ('1E', 125, 40);

INSERT INTO turma VALUES (1160, 'A', 1, 2023, '31108', '1B', 102);
INSERT INTO turma VALUES (1161, 'A', 1, 2023, '31201', '1B', 102);
INSERT INTO turma VALUES (1162, 'A', 1, 2023, '31806', '1B', 206);
INSERT INTO turma VALUES (1163, 'A', 1, 2023, '31401', '1B', 206);
INSERT INTO turma VALUES (1164, 'A', 1, 2023, '31606', '1E', 125);
INSERT INTO turma VALUES (1165, 'B', 1, 2023, '31606', '1E', 125);

INSERT INTO horario VALUES ('a', '7:10:00', '8:00:00');
INSERT INTO horario VALUES ('b', '8:00:00', '8:50:00');
INSERT INTO horario VALUES ('c', '8:50:00', '9:40:00');
INSERT INTO horario VALUES ('d', '9:50:00', '10:40:00');
INSERT INTO horario VALUES ('e', '10:40:00', '11:30:00');
INSERT INTO horario VALUES ('q', '11:30:00', '12:20:00');
INSERT INTO horario VALUES ('f', '13:10:00', '14:00:00');
INSERT INTO horario VALUES ('g', '14:00:00', '14:50:00');
INSERT INTO horario VALUES ('h', '14:50:00', '15:40:00');
INSERT INTO horario VALUES ('i', '15:40:00', '16:50:00');
INSERT INTO horario VALUES ('j', '16:50:00', '17:40:00');
INSERT INTO horario VALUES ('k', '17:40:00', '18:30:00');
INSERT INTO horario VALUES ('l', '18:10:00', '19:00:00');
INSERT INTO horario VALUES ('m', '19:00:00', '19:50:00');
INSERT INTO horario VALUES ('n', '19:50:00', '20:40:00');
INSERT INTO horario VALUES ('o', '20:50:00', '21:40:00');
INSERT INTO horario VALUES ('p', '21:40:00', '22:30:00');

INSERT INTO semana VALUES ('1', 'Domingo');
INSERT INTO semana VALUES ('2', 'Segunda');
INSERT INTO semana VALUES ('3', 'Terça');
INSERT INTO semana VALUES ('4', 'Quarta');
INSERT INTO semana VALUES ('5', 'Quinta');
INSERT INTO semana VALUES ('6', 'Sexta');
INSERT INTO semana VALUES ('7', 'Sabado');


