--Gullit Damião Teixeira de Campos - 12011BCC034
--Yuri Pio Macedo - 12021BCC025

SET search_path TO universidade;

--1)
SELECT * FROM estudante;
-- Retorna a tabela estudante com todas as informações
SELECT * FROM professor;
-- Retorna a tabela professor com todas as informações

--2)
SELECT 2+2;
-- Retorna uma coluna desconhecida do tipo inteiro com o valor 4
SELECT 'A';
-- Retorna uma coluna desconhecida do tipo text com o valor A
SELECT 50>3;
-- Retorna uma coluna desconhecida do tipo boolean com valor true 
SELECT '11/10/2020';
-- Retorna uma coluna desconhecida do tipo text com o valor da data
SELECT '11/10/2020'-'11/10/2030'
-- Não é possivel

--3)
SELECT 2+2 AS soma;
-- Retorna a coluna soma com o valor 4
SELECT 'A' AS letra;
-- Retorna uma coluna letra com o valor A
SELECT 50 > 3 AS resultado;
-- Retorna uma coluna resultado com valor true
SELECT '11/10/2020' AS dia;
-- Retorna o tipo text

--4)
--a)Listar todos os alunos da universidade;
SELECT * FROM faculdade;
--b)Listar todos as salas cadastradas;
SELECT * FROM sala;
--c)Listar todas as disciplinas.
SELECT * FROM disciplina;

--5)
--a)Listar o nome e a data de nascimento de todos os alunos;
SELECT nome, datanasc FROM estudante;
--b)Listar o nome de todas as faculdades;
SELECT nome FROM faculdade;
--c)Listar todas os horários iniciais disponíveis.
SELECT hora_inicio FROM horario;

--6)
--a)Listar todos os nomes das disciplinas e seus créditos, trocando, no resultado, ocrédito por ‘carga’;
SELECT nome, ch AS carga FROM disciplina;
--b)Supondo que 1 crédito de aula corresponda a 15 horas de aula, listar todos osnomes das disciplinas e seus créditos, trocando, no resultado, o crédito por‘carga_horaria’ e faça a conversão em horas dos valores;
SELECT ch/15 AS crédito FROM disciplina; -- o valor na tabela já está como carga horário, por isso para se fazer uma modificação do exercício, foi mostrado ele com o valor dos créditos;
--c)Listar todas as faculdades, renomeando as colunas de saída como faculdade(cod,nome_faculdade,local,orcamento);
SELECT sigla AS cod, nome AS nome_faculdade,predio AS local, orcamento AS orcamento FROM faculdade;
--d)Listar o nome e a idade em anos de todos os estudantes cadastradas no banco.
SELECT nome, (2023-EXTRACT(YEAR FROM datanasc)) AS idade FROM estudante;

--7)
--a)Listar todas as faculdades localizadas no prédio ‘1F’;
SELECT * FROM faculdade WHERE predio = '1F';
--b)Listar todas os alunos com CRA superior a 60;
SELECT * FROM estudante WHERE cra > 60;
--c)Listar todas as turmas ofertadas neste semestre;
SELECT * FROM turma WHERE semestre = 1 AND ano = 2023;
--d)Mostre o aniversário (somente o dia e mês) de um dos integrantes do seu grupo(escolher um dos nomes);
SELECT EXTRACT(DAY FROM datanasc) AS dia, EXTRACT(MONTH FROM datanasc) AS mes FROM estudante WHERE nome = 'Pyke da Silva';
--e)Listar o nome de todas as disciplinas que começam com a letra “S”;
SELECT * FROM disciplina WHERE SUBSTR(nome, 1, 1) = 'S';
--f)Listar todos os estudantes que nasceram últimos 20 anos (essa consulta deve sergenérica – você não deve explicitar nenhuma data);
SELECT nome FROM estudante WHERE (2023-EXTRACT(YEAR FROM datanasc)) < 21;
--g)Listar todos os estudantes que não possuem tutores;
SELECT * FROM estudante WHERE tutor IS NULL;
--h)Listar todos os estudantes que possuem tutores;
SELECT * FROM estudante WHERE tutor IS NOT NULL;
--i)Listar as turmas ministradas de 2000 até hoje;
SELECT * FROM turma WHERE ano > 1999;
--j)Mostrar os estudantes (nome /datanasc) que nasceram entre 1985 e 1995. UtilizarBETWEEN;
SELECT nome, datanasc FROM estudante WHERE EXTRACT(YEAR FROM datanasc) BETWEEN 1985 AND 1995;
--k)Mostrar, em ordem alfabética, os nomes dos professores entre “Carlos” e “Maria”.Utilizar BETWEEN;
SELECT * FROM professor WHERE nome BETWEEN 'Carlos' AND 'Maria' ORDER BY nome;
--l)Mostrar os nomes das disciplinas das seguintes faculdades: FADIR, FAMAT, FEMEC.Não utilizar o operador OR. Utilizar somente um SELECT;
SELECT * FROM disciplina WHERE fac_disc = 'FADIR'; SELECT * FROM disciplina WHERE fac_disc = 'FAMAT';
SELECT * FROM disciplina WHERE fac_disc = 'FEMEC';
--m)Mostrar se algum registro da tabela turma possui erro no cadastro do semestre(ou seja, diferente de 1 ou 2).
SELECT * FROM turma WHERE semestre != 1 AND semestre != 2;

--8)
--a)Altere os nomes de todas as disciplinas para letras em maiúsculo;
UPDATE disciplina set nome = UPPER(nome);
--b)Aumente o CRA de todos os alunos em 10%;
UPDATE estudante set cra = cra*(1.1);
--c)Passe para o valor 100 os CRAs que ficaram acima de 100;
UPDATE estudante set cra = 100 WHERE cra > 100;
--d)Não deixe que alunos com CRA menor que 80 façam iniciação científica;
UPDATE estudante set tutor IS NULL WHERE cra < 80;
--e)Passe todos os professores e alunos da FACOM para a FAMAT.
UPDATE estudante set fac_est = 'FAMAT' WHERE fac_est = 'FACOM';
UPDATE professor set fac_prof = 'FAMAT' WHERE fac_prof = 'FACOM';

--9)
--a)Remova todas informações de pré-requisito que existem no banco;
TRUNCATE TABLE pre_requisito;
--b)Remova as salas com capacidade inferior a 90 lugares. Mostrar o comando eindicar se ele foi executado corretamente ou se ocorreu algum erro;
DELETE FROM sala WHERE capacidade < 90;
--Erro, pois as salas removidas com esse comando ainda são referenciadas em outros locais;
--c)Remova a faculdade FACOM. Se alguma informação ainda dependa da FACOM,passá-la para FAMAT antes da remoção.
DELETE FROM faculdade WHERE sigla = 'FACOM';

--10)
--Retornando ao banco inicial;

--11)
--a)Listar todas as faculdades localizadas no prédio ‘1F’ e com orçamento superior aR$5000,00;
SELECT * FROM faculdade WHERE predio = '1F' AND orcamento > 5000;
--b)Listar todos os alunos com CRA superior a 60 e que estudam na faculdade‘FACOM’;
SELECT * FROM estudante WHERE cra > 60 AND fac_est = 'FACOM';
--c)Listar   todas   as   turmas   ofertadas   neste   semestre   da   disciplina   de   código<ESCOLHER>;
SELECT * FROM turma WHERE cod_disc = 'CIV2';
--d)Listar todos os nomes e datas de nascimento dos estudantes que possuem tutorese possuem CRA maior que 80;
SELECT nome, datanasc FROM estudante WHERE tutor IS NOT NULL AND cra>80;
--e)Listar o código e nome de todas as disciplinas cujo códigos começam com ‘GBC’ epossuem 4 créditos;
SELECT codigo, nome FROM disciplina WHERE UPPER(nome) LIKE 'GBC_' AND (ch/15) > 4;
--f)Listar todos os estudantes que não possuem tutores, mas, que possuem CRAmaior ou igual a 60.
SELECT * FROM estudante WHERE tutor IS NULL AND cra > 60;