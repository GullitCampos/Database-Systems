SET search_path TO UBERLAND;

-- Os padrões de valores se encontram propocionalmente mais baixos para corresponderem ao número de inserções realizadas, porém conforme o banco de dados fosse crescendo esse valor pode aumentar e se tornar mais realista

--Pesquisa para encontrar no banco de dados mortoristas do Uberland que trabalham no aplicativo desde jovens, usando-se como base menores de 23 anos.

SELECT nome
FROM motorista
WHERE age(current_date, Datanac) < interval '23 years';



--Pesquisa para poder encontrar a quantidade de viagens que cada tipo de serviço do Uberland possuí, assim sabendo-se por qual tipo os usuários costumam optar para fazer suas corridas.

SELECT
    COUNT(*) AS Numero_de_Viagens,
    CASE
        WHEN EXISTS (SELECT 1 FROM Uber_X WHERE Uber_X.UBER_ID = Uber.UBER_ID) THEN 'Uber X'
        WHEN EXISTS (SELECT 1 FROM Uber_Comfort WHERE Uber_Comfort.UBER_ID = Uber.UBER_ID) THEN 'Uber Comfort'
        ELSE 'Uber Black'
    END AS Tipo_de_Servico
FROM
    Uber
GROUP BY
    Tipo_de_Servico;


--Listar todos os motoristas da Uberland que realizaram um grande número de corridas, padrão dessa busca considerando-se maior que 1, para com isso pensar em possíveis benefícios para eles uma vez que contribuem com o aplicativo. No aumento do banco de dados pode-se aumentar o aumentar o número das corridas


SELECT motorista.nome, COUNT(Viagem.IDviagem) AS NumeroDeViagens
FROM motorista
JOIN UBER ON motorista.ID = UBER.MID
JOIN Viagem ON UBER.UBER_ID = Viagem.Viajar_MID
GROUP BY motorista.nome
HAVING COUNT(Viagem.IDviagem) > 1;


--Encontrar o número médio de passageiros que cada tipo de veículo costuma levar nas suas viagens.

SELECT
    Sedan,
    ROUND(AVG(Npassageiros), 2) AS Media_Passageiros
FROM
    Veiculo
GROUP BY
    Sedan;



--listar o id da viagem, o nome do motorista e o nome do passageiro de viagens com uma marca de veículo específico, nesse caso usando-se Honda, a fim de se saber se certo tipos de usuários tem tendência a utilizar mais veículos de determinada marca.

select Viagem.IDviagem, motorista.nome, cliente.nome from viagem, UBER, motorista , veiculo , cliente 
where marca = 'Honda' and Viagem.Viajar_MID = UBER.MID and UBER.MID = motorista.ID 
and Viagem.Viajar_CPF = Cliente.CPF and UBER.MID = Veiculo.MID
 

--Encontra o número de viagens total de cada dia da semana, o objetivo é saber em quais dias tem uma tendência de as pessoas consumirem mais os serviços do aplicativo e em quais dias esse consumo é menor.

SELECT
    EXTRACT(DOW FROM Dataviagem) AS Dia_Semana,
    COUNT(*) AS Numero_Total_Viagens
FROM
    VIAGEM
GROUP BY
    Dia_Semana
ORDER BY
    Dia_Semana;



--Encontrar a recita total de cada tipo de serviço ofertado pelo Uberland, com a finalidade de se descobrir qual é o tipo de serviço mais rentável para o aplicativo e assim poder se investir mais nele.

SELECT
    CASE
        WHEN UX.Uber_ID IS NOT NULL THEN 'Uber_X'
        WHEN UC.Uber_ID IS NOT NULL THEN 'Uber_Comfort'
		ELSE 'Uber Black'
    END AS Tipo_Servico,
    SUM(V.ValorM) AS Receita_Total_Motorista,
    SUM(V.ValorU) AS Receita_Total_Cliente
FROM
    UBER U
LEFT JOIN
    Uber_X UX ON U.Uber_ID = UX.Uber_ID
LEFT JOIN
    Uber_Comfort UC ON U.Uber_ID = UC.Uber_ID
JOIN
    VIAGEM V ON U.Uber_ID = V.Viajar_MID
GROUP BY
    Tipo_Servico
ORDER BY
    Tipo_Servico;



--Listar os clientes que fizeram corridas no mês, usando o mes 09, mostrando os clientes ativos mais recentemente pois isso demostra um grande consumo do aplicativo e pode se considerar em promover eles para cliente VIP. No aumento do banco de dados pode-se aumentar o aumentar o número das corridas


SELECT
    C.CPF,
    C.Nome AS Nome_Cliente,
    COUNT(V.IDviagem) AS Quantidade_Corridas
FROM
    Cliente C
JOIN
    VIAGEM V ON C.CPF = V.Viajar_CPF
WHERE
    EXTRACT(MONTH FROM V.Dataviagem) = 09  
GROUP BY
    C.CPF, C.Nome
HAVING
    COUNT(V.IDviagem) > 0
ORDER BY
    Quantidade_Corridas DESC;
	


--Encontrar os cinco dias do mês atual que mais tiveram corridas, a fim de se tentar encontrar algum possível padrão de consumo e se preparar melhor para os próximos meses.

SELECT
    EXTRACT(DAY FROM Dataviagem) AS Dia,
    COUNT(*) AS TotalViagens
FROM
    Viagem
WHERE
    EXTRACT(MONTH FROM Dataviagem) = EXTRACT(MONTH FROM CURRENT_DATE)
GROUP BY
    Dia
ORDER BY
    TotalViagens DESC
LIMIT 5;



--Mostrar os meses que mais tiveram viagem, que assim como na pesquisa anterior desse tipo para a semana, agora procura-se encontrar os meses mais movimentados do aplicativo e os meses onde o rendimento pode cair um pouco

SELECT
    EXTRACT(MONTH FROM Dataviagem) AS Mes,
    COUNT(*) AS TotalViagens
FROM
    Viagem
GROUP BY
    Mes
ORDER BY
    TotalViagens DESC;



--Mostra os motoristas do Uberland do padrão Uber-X q n fizeram revisão de carro nos últimos 6 meses, com a finalidade de caso apresentar algum usuário, emitir uma adventência a ele pois pode estar colocando a situação dele e dos passageiros em risco.

SELECT
    M.nome
FROM
    motorista M, Uber_X U
WHERE
    M.ID = U.UBER_ID AND U.UBER_ID IS NULL OR U.Data_rev < CURRENT_DATE - INTERVAL '6 months';