--2)CONSULTAS USANDO AGRUPAMENTOS SIMPLES e condição de seleção.→ 
--Em todas as questões as respostas devem ser **sem repetições**. 
--Em muitoscasos o DISTINCT resolveria a questão, mas para as questões a seguir não useDISTINCT.
--a)Listar todos os prédios das faculdades;
SELECT predio
FROM universidade.faculdade;
--b)Listar todas as SIGLAS de faculdades. Comparar o tamanho da resposta com o número de faculdades 
--e justificar;
SELECT sigla
FROM universidade.faculdade;

SELECT count(faculdade)
FROM universidade.faculdade;

--numero de sigla=numero de faculdades

--c)Listar todos os semestres-ano que existem turmas;

SELECT semestre, ano
FROM universidade.turma
GROUP BY semestre, ano;

--d)Listar todos os prédios e salas que possuem turmas;

SELECT s.predio, s.numero
FROM universidade.turma t
JOIN universidade.sala s ON t.predio_s = s.predio AND t.n_sala = s.numero;

--e)Listar todas as datas de nascimento, tutor e faculdade dos alunos;

SELECT e.datanasc, e.tutor, f.nome AS faculdade
FROM universidade.estudante e
JOIN universidade.faculdade f ON e.fac_est = f.sigla
LEFT JOIN universidade.professor p ON e.tutor = p.id;

--f)Listar todos os códigos de disciplinas das turmas dos anos de 2022 e 2021.

SELECT t.cod_disc
FROM universidade.turma t
WHERE t.ano = 2021 OR t.ano = 2022;

--3)CONSULTAS   COM   CONDIÇÃO   DE   SELEÇÃO,   AGRUPAMENTOS   EFUNÇÕES AGREGADAS.→ 
--Pense bem na elaboração das consultas. Não há necessidade de usar Junções.
--a)Listar a quantidade de professores por faculdade (mostrar o código da faculdadee o número 
--de professores);
SELECT f.sigla AS codigo_faculdade, COUNT(p.id) AS numero_professores
FROM universidade.faculdade f
LEFT JOIN universidade.professor p ON f.sigla = p.fac_prof
GROUP BY f.sigla;
--b)Listar para cada data cadastrada a quantidade de alunos que nasceram narespectiva data;
SELECT datanasc, COUNT(id) AS quantidade_alunos
FROM universidade.estudante
GROUP BY datanasc
ORDER BY datanasc;
--c)Listar a sigla de cada faculdade em que há alunos que fazem iniciação científicajuntamente
--com o maior CRA desses alunos;

SELECT f.sigla AS sigla_faculdade, max_cra.max_cra AS maior_cra
FROM universidade.faculdade f
JOIN (
  SELECT e.fac_est, MAX(e.cra) AS max_cra
  FROM universidade.estudante e
  WHERE e.fac_est IS NOT NULL
  GROUP BY e.fac_est
) AS max_cra
ON f.sigla = max_cra.fac_est;

--d)Listar para cada ID de turma a quantidade de professores que ministram naturma
SELECT t.id AS turma_id, COUNT(e.id_prof) AS quantidade_professores
FROM universidade.turma t
LEFT JOIN universidade.ensina e ON t.id = e.id_turma
GROUP BY t.id;

--e)Lista a capacidade total de cada prédio;
SELECT s.predio AS prédio, SUM(s.capacidade) AS capacidade_total
FROM universidade.sala s
GROUP BY s.predio
ORDER BY s.predio;

--f)Listar para cada dia da semana e horário a quantidade de turmas alocadas. 
--Nasaída mostrar o Id_sem, Id_hora e quantidade;

SELECT ha.id_sem AS Id_sem, ha.id_hora AS Id_hora, COUNT(ha.id_turma) AS quantidade
FROM universidade.horario_aula ha
GROUP BY ha.id_sem, ha.id_hora
ORDER BY ha.id_sem, ha.id_hora;

--g)Mostrar a quantidade de disciplinas em cada faixa de carga horária. 

SELECT
  CASE
    WHEN ch <= 30 THEN '0-30'
    WHEN ch <= 60 THEN '31-60'
    WHEN ch <= 90 THEN '61-90'
    ELSE '91+'
  END AS carga_horaria,
  COUNT(*) AS quantidade_disciplinas
FROM universidade.disciplina
GROUP BY carga_horaria
ORDER BY carga_horaria;

--4)CONSULTAS COM AGRUPAMENTOS, JUNÇÕES/IN E FUNÇÕES AGREGADAS.

--a)Listar a quantidade de turmas de cada disciplina da FEMEC (mostrar o códigoda disciplina e a quantidade);
SELECT d.codigo AS codigo_disciplina, COUNT(t.id) AS quantidade
FROM universidade.disciplina d
JOIN universidade.turma t ON d.codigo = t.cod_disc
WHERE d.fac_disc = 'FEMEC'
GROUP BY d.codigo
ORDER BY d.codigo;

--b)Listar para cada faculdade com orçamento inferior a R$50.000 a quantidade deprofessores   
--que   forma   contratados   depois   de   2010   (mostrar   o   código   dafaculdade e a quantidade);
SELECT f.sigla AS codigo_faculdade, COUNT(p.id) AS quantidade
FROM universidade.faculdade f
LEFT JOIN universidade.professor p ON f.sigla = p.fac_prof
WHERE f.orcamento < 50000 AND p.admissao > '2010-01-01'
GROUP BY f.sigla
ORDER BY f.sigla;


--c)Mostrar a nota média e desvio padrão de cada disciplina da FEMEV. Mostrar ocódigo da disciplina,
--a média e o desvio;
SELECT
  d.codigo AS codigo_disciplina,
  AVG(f.nota) AS media,
  STDDEV(f.nota) AS desvio
FROM universidade.disciplina d
JOIN universidade.turma t ON d.codigo = t.cod_disc
LEFT JOIN universidade.frequenta f ON t.id = f.id_turma
WHERE d.fac_disc = 'FEMEV'
GROUP BY d.codigo
ORDER BY d.codigo;

--d)Mostrar a quantidade de disciplinas ministradas pelos professores. 
--Mostrar o iddo   professor   e   a   quantidade.   Incluir   na   resposta   os   professores   
--que   nãoministram disciplinas. Nesse caso, deve-se mostrar 0 na quantidade. 
--Se nãohouver casos cadastrados no banco, fazer inserções para que estes apareçam;

SELECT p.id AS id_professor, COUNT(e.id_turma) AS quantidade
FROM universidade.professor p
LEFT JOIN universidade.ensina e ON p.id = e.id_prof
GROUP BY p.id
ORDER BY p.id;


--e)Mostrar a quantidade de disciplinas ministradas pelos professores que trabalhamem faculdades 
--com orçamento superior a R$10.000. Incluir na resposta osprofessores que não ministram disciplinas.
--Nesse caso, deve-se mostrar 0 naquantidade. Se não houver casos cadastrados no banco, 
--fazer inserções para queestes apareçam;

SELECT p.id AS id_professor, COUNT(e.id_turma) AS quantidade
FROM universidade.professor p
LEFT JOIN universidade.faculdade f ON p.fac_prof = f.sigla
LEFT JOIN universidade.ensina e ON p.id = e.id_prof
WHERE f.orcamento > 10000 OR f.orcamento IS NULL
GROUP BY p.id
ORDER BY p.id;



--f)Mostrar para cada faculdade a quantidade de estudantes que não frequentamnenhuma disciplina.
SELECT f.sigla AS codigo_faculdade, COUNT(e.id) AS quantidade
FROM universidade.faculdade f
LEFT JOIN universidade.estudante e ON f.sigla = e.fac_est
LEFT JOIN universidade.frequenta fr ON e.id = fr.id_est
WHERE fr.id_est IS NULL
GROUP BY f.sigla
ORDER BY f.sigla;






-- 5)CONSULTAS COM AGRUPAMENTOS E QUE LISTAM ATRIBUTOS NÃO AGRUPADOS.


--a)Listar a quantidade de turmas de cada disciplina (mostrar o *nome* da disciplina e a quantidade). Mostrar a saída ordenada pela quantidade;
SELECT d.nome AS nome_disciplina, COUNT(t.id) AS quant_turmas
FROM disciplina d
LEFT JOIN turma t
ON d.codigo = t.cod_disc
GROUP BY d.nome
ORDER BY quantidade_de_turmas DESC;




--b)Mostrar,   para   cada   turma   de   2022-1,   a   quantidade   de   alunos   que   foramaprovados. Mostrar o *nome* da disciplina, 
--a turma, o ano, e a quantidade.Mostrar a saída ordenada pelo nome da disciplina;
SELECT d.nome AS nome_disciplina, t.turma, t.ano,
COUNT(CASE WHEN f.nota >= 60 THEN 1 END) AS quantidade_aprovados
FROM disciplina d
JOIN turma t ON d.codigo = t.cod_disc
LEFT JOIN estudante e ON (t.cod_disc = d.codigo AND d.fac_disc = e.fac_est)
JOIN frequenta f ON (e.id = f.id_est AND t.id = f.id_turma)
WHERE t.ano = 2022 AND t.semestre = 1
GROUP BY d.nome, t.turma, t.ano
ORDER BY d.nome;





--c)Liste a quantidade de aulas que são ministradas em cada dia da semana (mostrar o dia da semana e a quantidade);
select s.descricao as dia, count(case when t.id = h.id_turma then 1 END) as quantidade
from semana s
join horario_aula h on s.id_sem = h.id_sem
join turma t on t.id = h.id_turma
GROUP BY s.descricao;





--d)Mostrar para cada disciplina que é pré-requisito o seu nome e a quantidade de disciplinas que dela dependem. 
--Incluir na consulta disciplinas que não são pré-requisito, colocando 0 na quantidade;
SELECT d.nome AS disciplina, COUNT(p.cod_disc) AS quant_dependencias
FROM disciplina d
LEFT JOIN pre_requisito p ON d.codigo = p.cod_pre
GROUP BY d.nome
ORDER BY quant_dependencias;





--e)Listar para todas as faculdades o seu nome e o número de professores. Mesmo as faculdades 
--que não possuem professor devem aparecer no resultado;
SELECT f.nome AS faculdade, COUNT(p.id) AS professores
FROM faculdade f
JOIN professor p ON f.sigla = p.fac_prof
GROUP BY f.nome
ORDER BY f.nome;

--de fato tem 5 professores por faculdade
SELECT f.nome AS faculdade, p.nome AS professores
FROM faculdade f
JOIN professor p ON f.sigla = p.fac_prof
GROUP BY p.nome, f.nome
ORDER BY f.nome;

-- 5 alunos por faculdade
SELECT f.nome AS faculdade, e.nome AS professores
FROM faculdade f
JOIN estudante e ON f.sigla = e.fac_est
GROUP BY e.nome, f.nome
ORDER BY f.nome;




--Listar para todas as faculdades o seu nome, e a soma do número de professores e número de alunos.
SELECT f.nome AS nome_faculdade, 
       COALESCE(pf.n_professores, 0) AS n_professores, 
       COALESCE(ea.n_alunos, 0) AS n_alunos,
	   pf.n_professores + ea.n_alunos as total
FROM faculdade f
LEFT JOIN (
    SELECT fac_prof, COUNT(id) AS n_professores
    FROM professor
    GROUP BY fac_prof
) pf ON f.sigla = pf.fac_prof
LEFT JOIN (
    SELECT fac_est, COUNT(id) AS n_alunos
    FROM estudante
    GROUP BY fac_est
) ea ON f.sigla = ea.fac_est
ORDER BY f.nome;



SELECT f.nome AS nome_faculdade, count(p.id) AS n_professores, count(e.id) AS n_alunos, count(p.id) + count(e.id) as total
FROM faculdade f
JOIN professor p ON f.sigla = p.fac_prof
JOIN estudante e ON f.sigla = e.fac_est
GROUP BY f.nome



--6)CONSULTAS COM CONDICIONAIS NOS GRUPOS e condições de seleção.
--a)Listar as turmas que possuem mais de 7 alunos. Mostrar o código da disciplina,a turma, o ano, o semestre e 
--quantidade de alunos;
SELECT
    t.cod_disc AS "Código da Disciplina",
    t.turma AS "Turma",
    t.ano AS "Ano",
    t.semestre AS "Semestre",
    COUNT(f.id_est) AS "Quantidade de Alunos"
FROM turma t
INNER JOIN frequenta f ON t.id = f.id_turma
GROUP BY t.cod_disc, t.turma, t.ano, t.semestre
HAVING COUNT(f.id_est) > 7;


--b)Listar as turmas de 2022-1 que possuem média de notas inferior a 60;

SELECT
    t.turma AS "Turma",
    t.ano AS "Ano",
    t.semestre AS "Semestre",
    d.codigo AS "Código da Disciplina",
    AVG(f.nota) AS "Média de Notas"
FROM turma t
INNER JOIN disciplina d ON t.cod_disc = d.codigo
INNER JOIN frequenta f ON t.id = f.id_turma
WHERE t.ano = 2022 AND t.semestre = 1
GROUP BY t.turma, t.ano, t.semestre, d.codigo
HAVING AVG(f.nota) < 60;


--c)Listar os nomes dos estudantes com mais de 6 disciplinas neste semestre(mostrar o nome do estudante e a quantidade 
--de disciplinas);

SELECT
    e.nome AS "Nome do Estudante",
    COUNT(f.id_turma) AS "Quantidade de Disciplinas"
FROM estudante e
INNER JOIN frequenta f ON e.id = f.id_est
INNER JOIN turma t ON f.id_turma = t.id
WHERE 2023 = t.ano AND t.semestre = 1
GROUP BY e.nome
HAVING COUNT(f.id_turma) > 6;

--d)Mostrar as faculdades com menos de 3 disciplinas (mostrar a sigla da faculdadee a quantidade de disciplinas);
SELECT
    f.sigla AS "Sigla da Faculdade",
    COUNT(d.codigo) AS "Quantidade de Disciplinas"
FROM faculdade f
LEFT JOIN disciplina d ON f.sigla = d.fac_disc
GROUP BY f.sigla
HAVING COUNT(d.codigo) < 3;


--e)Listar os nomes dos estudantes com (CRA > 60) e com mais de 6 disciplinasneste semestre (mostrar o nome do 
--estudante e a quantidade de disciplinas);

SELECT
    e.nome AS "Nome do Estudante",
    COUNT(f.id_turma) AS "Quantidade de Disciplinas"
FROM estudante e
INNER JOIN frequenta f ON e.id = f.id_est
INNER JOIN turma t ON f.id_turma = t.id
WHERE t.semestre = 1 AND e.CRA > 60 
GROUP BY e.nome
HAVING COUNT(f.id_turma) > 6;

--f)Mostrar as turmas de disciplinas de 4 créditos que possuem mais de 5 alunosmatriculados. 
--(mostrar o código da disciplina, a turma, semestre, ano e aquantidade de alunos matriculados).
SELECT
    d.codigo AS "Código da Disciplina",
    t.turma AS "Turma",
    t.semestre AS "Semestre",
    t.ano AS "Ano",
    COUNT(f.id_est) AS "Quantidade de Alunos Matriculados"
FROM turma t
INNER JOIN disciplina d ON t.cod_disc = d.codigo
INNER JOIN frequenta f ON t.id = f.id_turma
WHERE d.ch = 4
GROUP BY d.codigo, t.turma, t.semestre, t.ano
HAVING COUNT(f.id_est) > 0;


