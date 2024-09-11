--Carlos Antônio de Melo Mendes – 12121BCC048
--Gullit Damião Teixeira de Campos - 12011BCC034
--João Vitor Gonçalves Oliveira - 11921BCC024
--Yuri Pio Macedo - 12021BCC025
SET search_path TO universidade;

--2)
--a. Listar o nome das disciplinas que não possuem pré-requisitos;
SELECT nome FROM disciplina WHERE codigo NOT IN(SELECT cod_disc FROM pre_requisito);
--b. Listar as disciplinas que são pré-requisitos;
SELECT nome FROM disciplina WHERE codigo IN(SELECT cod_pre FROM pre_requisito);
--c. Listar o nome das disciplinas que não são pré-requisito de outras disciplinas;
SELECT nome FROM disciplina WHERE codigo NOT IN(SELECT cod_pre FROM pre_requisito);
--d. Listar o nome dos estudantes que não estão frequentando turmas;
SELECT nome FROM estudante WHERE estudante.id NOT IN(SELECT id_est FROM frequenta);
--e. Listar o prédio e sala que estão vazios (sem nenhuma aula - dica: use parênteses nos atributos envolvidos no WHERE);
SELECT predio, numero FROM sala WHERE (predio, numero) NOT IN(SELECT predio_s, n_sala FROM turma);
--f. Listar os nomes e data de admissão dos professores que não ministraram nenhuma disciplina;
SELECT nome, admissao FROM professor WHERE professor.id NOT IN(SELECT id_prof FROM ensina);
--g. Listar os nomes e data de admissão dos professores que não ministraram nenhuma disciplina no semestre atual (ano-semestre);
SELECT nome, admissao FROM professor WHERE professor.id IN(SELECT id_prof FROM ensina WHERE id_turma NOT IN(SELECT turma.id FROM turma WHERE semestre = 1 AND ano = 2023));
--h. Listar as turmas que estão sem horário cadastrado;
SELECT turma.id FROM turma WHERE turma.id NOT IN(SELECT id_turma FROM horario_aula);
--i. Listar quais horários não estão sendo usados para ministrar as aulas
SELECT horario.hora_inicio, horario.hora_fim, semana.id_sem FROM horario, semana WHERE (horario.id_hora, semana.id_sem)NOT IN(SELECT id_hora, id_sem FROM horario_aula);

--3)
--a. Mostre o número de Estudantes que estão cadastrados na base;
SELECT COUNT(*) FROM estudante;
--b. Mostre o número de Matrículas (frequenta) que existem na base;
SELECT COUNT(*) FROM frequenta;
--c. Faça o produto cartesiano entre as tabelas Estudante e Frequenta;
SELECT * FROM estudante, frequenta;
--d. Mostre o número de tuplas retornado pelo produto cartesiano. Explique o porquê deste número.
SELECT COUNT(*) FROM estudante, frequenta; -- Esse número ocorre pois esse formato de produto cartesiano
--irá combinar as duas tabelas sem nenhuma restrição, portanro será os 75 estudantes X os 75 frequenta.

--Refaça o produto cartesiano entre as tabelas Estudante e Frequenta utilizando o comando CROSS JOIN.
SELECT * FROM estudante CROSS JOIN frequenta;

--Faça o produto cartesiano entre as tabelas Estudante, Disciplina, Frequenta e Turma. Não utilize CROSS JOIN. Não mostrar o resultado, somente indicar o número de linhas obtidas e o tempo de execução.

--4)
--Dica: construa a consulta sem a função de agregação e observe os dados para verificar se atendem ao enunciado. 
--Em seguida aplica a função de agregação.

--a. Mostrar o horário mais cedo que existe;
select hora_inicio from horario; -- mais cedo é 7:10
select min(hora_inicio) from horario;

--b. Mostrar o CRA médio de todos os estudantes;
select avg(cra) from estudante;

--c. Mostrar a média e o desvio padrão do CRA de todos os alunos;
select avg(desvio) from (
select stddev(cra) as desvio from estudante);

--d. Mostrar a quantidade de professores do banco;
select count(nome) from professor;

--e. Mostrar a quantidade de disciplinas da 'FACOM';
select count(nome) from disciplina where fac_disc = 'FACOM';

--f. Mostrar a quantidade de estudantes que fazem iniciação científica (possuem tutores);
select count(nome) from estudante where tutor IS NOT NULL;

--g. Mostrar a quantidade de orientadores de IC que existem;
--<71
select count(distinct estudante.tutor) from estudante where tutor is not null;

--h. Mostrar a quantidade de professores que não são tutores de estudantes;
--pega todos os id dos professores e compara com todos os ids de tutores e conta os ids que não tem na tabela de tutores
select count(professor.id) from professor left join estudante on professor.id = estudante.tutor where estudante.tutor is NULL; 


--i. Mostrar os nomes e data de nascimento do(s) aluno(s) mais velho(s);
select nome, datanasc from estudante order by datanasc asc LIMIT 10;


--j. Mostrar a quantidade de turmas que são ministradas em salas com capacidade superior a 10
select count(turma.id) from turma 
left join sala on turma.n_sala = sala.numero AND turma.predio_s = sala.predio AND sala.capacidade>10;


--k. Mostrar a quantidade total de turmas das disciplinas da FAMAT;
select count(turma) from turma left join disciplina on turma.cod_disc = disciplina.codigo AND disciplina.fac_disc = 'FAMAT';

--l. Mostrar a quantidade de disciplinas que são pré-requisitos para outras disciplinas;
SELECT cod_pre, COUNT(*) AS quantidade_de_pre_requisitos
FROM pre_requisito
GROUP BY cod_pre
ORDER BY quantidade_de_pre_requisitos DESC;

--m. Mostrar a quantidade de disciplinas que possuem pré-requisitos;
SELECT cod_disc, COUNT(*) AS quantidade_de_disciplinas_com_pre_requisitos
FROM pre_requisito
GROUP BY cod_disc
ORDER BY quantidade_de_disciplinas_com_pre_requisitos DESC;

--n. Mostrar a quantidade de disciplinas que não possuem pré-requisitos.
SELECT COUNT(*) AS quantidade_de_disciplinas_sem_pre_requisitos
FROM disciplina
WHERE codigo NOT IN (SELECT DISTINCT cod_disc FROM pre_requisito);

--5. CONSULTAS OPERADORES UNION/EXCEPT/INTERSECT

--a. Mostrar os nomes de todas as pessoas cadastradas no banco;
SELECT nome FROM professor
UNION
SELECT nome FROM estudante;
--b. Mostrar os nomes dos professores e dos alunos que não ensinam/frequentam turmas;

-- Professores que não ensinam turmas
SELECT nome AS nome_professor
FROM professor
EXCEPT
SELECT p.nome AS nome_professor
FROM professor p
INNER JOIN ensina e ON p.id = e.id_prof;

-- Alunos que não frequentam turmas
SELECT nome AS nome_aluno
FROM estudante
EXCEPT
SELECT est.nome AS nome_aluno
FROM estudante est
INNER JOIN frequenta f ON est.id = f.id_est;


--c. Mostrar os IDs das turmas que possuem docentes, mas não possuem alunos frequentando;
SELECT id
FROM turma
WHERE id IN (SELECT id_turma FROM ensina)
EXCEPT
SELECT id
FROM turma
WHERE id NOT IN (SELECT id_turma FROM frequenta);

--d. Mostrar os IDs das turmas que possuem docentes e que possuem alunos frequentando;

SELECT id
FROM turma
WHERE id IN (
  SELECT id_turma
  FROM ensina
)
INTERSECT
SELECT id_turma
FROM frequenta;


--e. Mostrar os IDs das turmas que possuem ou docentes ou alunos frequentando.

SELECT id_turma AS id
FROM ensina
UNION
SELECT id_turma AS id
FROM frequenta;
