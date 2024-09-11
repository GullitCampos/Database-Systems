--Carlos Antônio de Melo Mendes – 12121BCC048
--Gullit Damião Teixeira de Campos - 12011BCC034
--João Vitor Gonçalves Oliveira - 11921BCC024
--Yuri Pio Macedo - 12021BCC025
SET search_path TO universidade;

--1)
--a)Liste o nome de todas as disciplinas juntamente com o nome das suas respectivasfaculdades;
SELECT disciplina.nome, faculdade.nome FROM disciplina, faculdade WHERE fac_disc = sigla;
--b)Listar o nome de todas as disciplinas juntamente com todos as informações sobresuas turmas;
SELECT disciplina.nome, turma.* from disciplina, turma WHERE codigo=cod_disc;
--c)Listar o nome do aluno e o nome de seu tutor;
SELECT estudante.nome, professor.nome FROM estudante, professor WHERE tutor = professor.id;
--d)Listar os nomes das disciplinas que tiveram turmas ofertadas no semestre atual(ano-semestre);
SELECT disciplina.nome,turma.ano,turma.semestre from disciplina, turma where semestre=1 and ano=2023;
--e)Listar o *nome* da disciplina e o *código* da(s) disciplina(s) que são seu pré-requisito;
SELECT disciplina.nome, pre_requisito.cod_disc FROM disciplina, pre_requisito WHERE pre_requisito.cod_pre = disciplina.codigo; 
--f)Listar o *nome* das disciplinas que são pré-requisito juntamente com os*códigos* das disciplinas que dependem delas.
SELECT disciplina.nome, pre_requisito.cod_pre FROM disciplina, pre_requisito WHERE pre_requisito.cod_disc = disciplina.codigo;

--2)
--a)Listar o nome dos professores juntamente com o nome das disciplinas que elesministram/ministraram;
select professor.nome, disciplina.nome from disciplina, professor, ensina, turma where professor.id = ensina.id_prof AND ensina.id_turma = turma.id AND disciplina.codigo = turma.cod_disc;
--b)Listar o nome dos professores juntamente com o nome das disciplinas que elesministram neste semestre (ano-semestre);
select professor.nome, disciplina.nome from disciplina, professor, ensina, turma where professor.id = ensina.id_prof AND ensina.id_turma = turma.id AND disciplina.codigo = turma.cod_disc AND turma.semestre = 2;
--c)Listar os nomes das disciplinas que são ofertadas (possuem turmas) em salas comcapacidade superior a 10 lugares;
select disciplina.nome from disciplina, turma, sala where disciplina.codigo = turma.cod_disc AND turma.predio_s = sala.predio AND turma.n_sala = sala.numero AND sala.capacidade > 10;
--d)Listar o nome do estudante juntamente com o nome de sua faculdade e com onome do seu professor tutor.  
select estudante.nome, faculdade.nome, professor.nome from estudante, faculdade, professor where estudante.fac_est = faculdade.sigla AND estudante.tutor = professor.id; 

--3)
--a)Liste o nome de todas as disciplinas juntamente com o nome das suas respectivasfaculdades;
select disciplina.nome, faculdade.nome from disciplina INNER JOIN faculdade ON disciplina.fac_disc = faculdade.sigla;
--b)Listar o nome de todas as disciplinas juntamente com todos as informações sobresuas turmas;
select disciplina.nome, * from disciplina RIGHT JOIN turma ON disciplina.codigo = turma.cod_disc;
--c)Listar o nome do aluno e o nome de seu tutor;
select estudante.nome, professor.nome from estudante INNER JOIN professor ON estudante.tutor = professor.id;
--d)Listar os nomes das disciplinas que tiveram turmas ofertadas no semestre atual(ano-semestre);
select disciplina.nome from disciplina INNER JOIN turma ON turma.semestre = 2 AND disciplina.codigo = turma.cod_disc;
--e)Listar o *nome* da disciplina e o *código* da(s) disciplina(s) que são seu pré-requisito;
select disciplina.nome, pre_requisito.cod_pre from disciplina INNER JOIN pre_requisito ON disciplina.codigo = pre_requisito.cod_disc;
--f)Listar   o   *nome*   das   disciplinas   que   são   pré-requisito   juntamente   com   os*códigos* das disciplinas que dependem delas.
select disciplina.nome, pre_requisito.cod_disc from disciplina INNER JOIN pre_requisito ON disciplina.codigo = pre_requisito.cod_pre;

--4)
--a)Listar o nome dos professores juntamente com o nome das disciplinas que elesministram/ministraram;
SELECT professor.nome, disciplina.nome
FROM ensina, professor, disciplina
WHERE ensina.id_prof = professor.id
AND disciplina.codigo = (
    SELECT turma.cod_disc
    FROM turma
    WHERE turma.id = ensina.id_turma
);
--b)Listar o nome dos professores juntamente com o nome das disciplinas que elesministram neste semestre (ano-semestre);
SELECT DISTINCT professor.nome, disciplina.nome
FROM ensina, professor, disciplina, turma
WHERE ensina.id_prof = professor.id
AND disciplina.codigo = (
    SELECT turma.cod_disc
    FROM turma
    WHERE turma.id = ensina.id_turma
    AND turma.ano = 2023
    AND turma.semestre = 2
);
--c)Listar os nomes das disciplinas que são ofertadas (possuem turmas) em salas comcapacidade superior a 10 lugares;
SELECT DISTINCT disciplina.nome
FROM disciplina, turma, sala 
WHERE disciplina.codigo = (
    SELECT turma.cod_disc
    FROM turma
    WHERE turma.n_sala = sala.numero 
    AND turma.predio_s = sala.predio 
    AND sala.capacidade > 10
    LIMIT 1
);
--d)Listar o nome do estudante juntamente com o nome de sua faculdade e com onome do seu professor tutor;
SELECT estudante.nome, faculdade.nome, professor.nome
FROM estudante, faculdade, professor
WHERE estudante.fac_est = faculdade.sigla
AND estudante.tutor = professor.id;
--e)Listar todas as turmas juntamente com as salas;
SELECT turma.id, sala.numero, sala.predio
FROM turma, sala
WHERE turma.n_sala = sala.numero AND turma.predio_s = sala.predio;
--f)Inclua a data de nascimento em Professor e preencha aleatoriamente. Liste osnomes e idade dos professores e dos Estudantes que possuem a mesma idade. Acoluna que vai listar o nome do professor deve-se chamar professor e a colunaque listará o nome do Estudante deve-se chamar Estudante;
ALTER TABLE Professor
ADD COLUMN datanasc DATE;
UPDATE Professor
SET datanasc = 
   DATE '1960-01-01' + 
  (FLOOR(RANDOM() * (DATE '2000-01-01' - DATE '1960-01-01' + 1)))::INTEGER;

SELECT estudante.nome AS Estudante, professor.nome AS Professor, (2023-EXTRACT(YEAR FROM estudante.datanasc)) AS idade_estudante
FROM estudante, professor
WHERE estudante.datanasc = professor.datanasc;
--g)Lista os nomes dos professores e dos Estudantes que não possuem a mesmaidade. Também mostrar a idade do professor e do Estudante. As colunas que vãomostrar o nome e idade do professor devem-se chamar professor e prof_idaderespectivamente e as colunas que listarão o nome e a idade do Estudante devem-se chamar estudante e est_idade, respectivamente.
SELECT estudante.nome AS Estudante, professor.nome AS Professor, (2023-EXTRACT(YEAR FROM estudante.datanasc)) AS idade_estudante, (2023-EXTRACT(YEAR FROM professor.datanasc)) AS idade_professor
FROM estudante, professor
WHERE estudante.datanasc != professor.datanasc;

--5)
--a)Listar o nome de uma disciplina juntamente com o *nome* de seu pré-requisito.
--Renomeie o nome dos atributos da relação resultante para nome_disciplina enome_prereq, 
--respectivamente;
SELECT d.nome AS nome_disciplina, p.nome AS nome_prereq
FROM disciplina d
JOIN pre_requisito pr ON d.codigo = pr.cod_disc
JOIN disciplina p ON pr.cod_pre = p.codigo;
--b)Listar os nomes das disciplinas que possuem mais carga horária que seus pré-requisito;
--Ps.: se não houver nenhuma, cadastrar pelo menos 2 para testar.
SELECT d.nome AS nome_disciplina
FROM disciplina d
JOIN pre_requisito pr ON d.codigo = pr.cod_disc
WHERE d.ch > (SELECT ch FROM disciplina WHERE codigo = pr.cod_pre);
--c)Listar os nomes das disciplinas pertencem a faculdades distintas de seus pré-requisitos;
--Ps.: se não houver nenhuma, cadastrar pelo menos 2 para testar.
SELECT d.nome AS nome_disciplina
FROM disciplina d
JOIN pre_requisito pr ON d.codigo = pr.cod_disc
WHERE d.fac_disc <> (SELECT fac_disc FROM disciplina WHERE codigo = pr.cod_pre);
--d)Listar as faculdades dos alunos e seus tutores;- Na resposta mostrar o nome do aluno, 
--nome de sua faculdade, o nome doprofessor e o nome de sua faculdade.
SELECT
  est.nome AS nome_aluno,
  est.fac_est AS faculdade_aluno,
  prof.nome AS nome_tutor,
  prof.fac_prof AS faculdade_tutor
FROM
  estudante est
LEFT JOIN
  professor prof ON est.tutor = prof.id
--e)Listar os alunos que estão vinculados a faculdades distintas de seus tutores;- 
--Na resposta mostrar o nome do aluno, nome de sua faculdade, o nome doprofessor e o nome 
--de sua faculdade.
SELECT
  est.nome AS nome_aluno,
  est.fac_est AS faculdade_aluno,
  prof.nome AS nome_tutor,
  prof.fac_prof AS faculdade_tutor
FROM
  estudante est
INNER JOIN
  professor prof ON est.tutor = prof.id
INNER JOIN
  faculdade fac_est ON est.fac_est = fac_est.sigla
INNER JOIN
  faculdade fac_prof ON prof.fac_prof = fac_prof.sigla
WHERE
  est.fac_est <> prof.fac_prof;
--f)Mostrar os estudantes que estão frequentando turmas de disciplinas que 
--são ofertadas por outras faculdades;- 
--Na resposta mostrar o nome do aluno, nome de sua faculdade, o nome dadisciplina e a 
--faculdade da disciplina.Ps.: se não houver nenhuma, cadastrar pelo menos 2 para testar.
SELECT
  est.nome AS nome_aluno,
  est.fac_est AS faculdade_aluno,
  d.nome AS nome_disciplina,
  d.fac_disc AS faculdade_disciplina
FROM
  estudante est
JOIN
  frequenta f ON est.id = f.id_est
JOIN
  turma t ON f.id_turma = t.id
JOIN
  disciplina d ON t.cod_disc = d.codigo
WHERE
  est.fac_est <> d.fac_disc;
--g)Listar todas as matrículas existentes, indicando para cada uma o nome doEstudante e o nome da 
--disciplina.
SELECT
  est.nome AS nome_estudante,
  d.nome AS nome_disciplina
FROM
  estudante est
JOIN
  frequenta f ON est.id = f.id_est
JOIN
  turma t ON f.id_turma = t.id
JOIN
  disciplina d ON t.cod_disc = d.codigo;

--6)
--a)Listar o nome dos professores juntamente com o *nome* de seus alunos de IC(quem eles tutoram;- 
--Renomeie o nome dos atributos da relação resultante para nome_professor enome_aluno, 
--respectivamente.-  Se  um  professor  não  possuir  orientandos,  ele  deve  aparecer 
--na  respostatambém.
SELECT
    P.nome AS nome_professor,
    COALESCE(E.nome, 'Sem orientandos') AS nome_aluno
FROM
    professor P
LEFT JOIN
    estudante E ON P.id = E.tutor
WHERE
    E.tutor IS NOT NULL
OR
    NOT EXISTS (SELECT 1 FROM estudante WHERE tutor = P.id);	
--b)Listar o nome da disciplina juntamente com o nome de seus pré-requisitos. 
--Caso adisciplina tenha mais de um pré-requisito, ela constará na resposta mais de umavez 
--(uma vez para cada pré-requisito). Caso a disciplina não tenha pré-requisitos,
--ela também deve aparecer na resposta;
SELECT d.nome AS disciplina, p.nome AS pre_requisito
FROM disciplina d
LEFT JOIN pre_requisito pr ON d.codigo = pr.cod_disc
LEFT JOIN disciplina p ON pr.cod_pre = p.codigo;
--c)Listar todos os nomes dos professores juntamente com as turmas que ministram
--(turma,semestre,ano,codigo_disc). Se o professor não possuir disciplina eletambém deve aparecer na 
--resposta. No lugar do código da disciplina deveaparecer a mensagem ('<professor sem disciplina>'). 
--Dica:COALESCE();
SELECT
    pr.nome AS professor,
    COALESCE(
        CONCAT(t.turma, ' ', t.semestre, '/', t.ano, ' ', d.nome),
        '<professor sem disciplina>'
    ) AS turma_disciplina
FROM
    professor pr
LEFT JOIN
    (
        SELECT DISTINCT
            t1.id AS turma_id,
            t1.turma,
            t1.semestre,
            t1.ano,
            t1.cod_disc
        FROM
            turma t1
    ) AS t
ON
    pr.id = t.cod_disc
LEFT JOIN
    disciplina d
ON
    t.cod_disc = d.codigo;	
--d)Utilizando OUTER JOIN, o nome das disciplinas que não possuem pré-requisitos;
SELECT d.nome AS disciplina
FROM disciplina d
LEFT JOIN pre_requisito pr ON d.codigo = pr.cod_disc
WHERE pr.cod_pre IS NULL;
--e)Utilizando  OUTER JOIN, o nome dos estudantes que não estão frequentando turmas;
SELECT e.nome AS estudante
FROM estudante e
LEFT JOIN turma t ON e.id = t.cod_disc
WHERE t.cod_disc IS NULL;
--f)Utilizando  OUTER JOIN, listar as informações das turmas cujas aulas são nasegunda ou quinta 
--que não possuem estudantes frequentando a mesma (se nãoexistir tuplas, cadastre algumas para atender 
--a consulta).
SELECT turma.*
FROM turma t
LEFT JOIN (
    SELECT DISTINCT turma_id
    FROM turma
    WHERE EXTRACT(DOW FROM to_date(CAST(ano AS TEXT) || '-' || CAST(semestre AS TEXT) || '-01', 'YYYY-MM-DD')) IN (1, 4)
) subquery ON t.id = subquery.turma_id
WHERE subquery.turma_id IS NULL;
--g)Utilizando  OUTER JOIN, listar as informações das turmas cujas aulas são nasegunda ou quinta 
--que não possuem estudantes frequentando a mesma 
SELECT t.turma
FROM turma t
LEFT JOIN horario_aula ha ON t.id = ha.id_turma
LEFT JOIN semana s ON ha.id_sem = s.id_sem
WHERE (s.descricao = 'Segunda' OR s.descricao = 'Quinta')