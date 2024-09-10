DROP SCHEMA IF EXISTS UBERLAND CASCADE;
CREATE SCHEMA UBERLAND;
SET search_path TO UBERLAND;

CREATE TABLE motorista(
ID CHAR(6) NOT NULL, --  Identificador único para cada motorista.
Atividade Boolean, -- Booleano indicando se o motorista está atualmente trabalhando (1) ou não (0).
Datanac DATE NOT NULL, -- Data de nascimento do motorista.
Nome CHAR(30) NOT NULL, -- Nome do motorista.
Ncorridas INT,--  Número de corridas que o motorista já realizou.
Avaliação Float, -- Avaliação media do motorista. 
CNH CHAR(11) NOT NULL UNIQUE, -- Número da Carteira Nacional de Habilitação (CNH) do motorista (único).
CPF CHAR(11) NOT NULL UNIQUE, -- Número do Cadastro de Pessoas Físicas (CPF) do motorista (único).
Numero int NOT NULL, -- Número da residência do motorista.
rua char(50) NOT NULL, --  Nome da rua do endereço do motorista.
bairro char(30) NOT NULL, -- Bairro do endereço do motorista
cidade char(45) NOT NULL, -- Cidade do endereço do motorista.
estado char(40) NOT NULL, -- Estado do endereço do motorista.
pais char(35) NOT NULL, -- País do endereço do motorista.
Sexo CHAR(10), -- Sexo do motorista.
-- restrições
CONSTRAINT pk_Motoristas PRIMARY KEY (ID)
);

CREATE TABLE Cliente(
CPF CHAR(11) NOT NULL, -- Número do Cadastro de Pessoas Físicas (CPF) do cliente (único).
Media Float, -- Avaliação média do cliente.
Sexo CHAR(10), -- Sexo do cliente.
Ncorridas INT, -- Número de corridas que o cliente realizou.
Email CHAR(35), -- Endereço de e-mail do cliente.
Nome CHAR(30) NOT NULL, -- Nome do cliente.
Datanac	DATE NOT NULL, -- Data de nascimento do cliente.
-- restrições	
CONSTRAINT pk_Cliente PRIMARY KEY (CPF)
);

CREATE TABLE Financeiro(
ID CHAR(12) PRIMARY KEY, -- Identificador único para transações financeiras.
Histransação CHAR(20), -- Histórico de transações.
Supagamentos CHAR(20), -- Suporte de pagamentos.
Orçamento FLOAT, -- Valor do orçamento.
Compreço FLOAT, --  Valor da comparação de preços.
Relatório CHAR(20), -- Relatório financeiro.
Tributo FLOAT, -- Valor do tributo.
Alerta BOOL -- Booleano indicando se há um alerta.
);

CREATE TABLE Veiculo (
MID CHAR(6) NOT NULL UNIQUE, -- Identificador único para cada veículo (chave estrangeira referenciando 
Placa CHAR(7) NOT NULL UNIQUE, --  Número da placa do veículo.
Nome CHAR(30), -- Nome do veículo.
Atividade Boolean, -- Booleano indicando se o veículo está ativo.
Sedan Boolean, -- Booleano indicando se o veículo é um sedan.
Npassageiros INT, -- Número de passageiros que o veículo pode transportar.
Status CHAR(50), -- Estado atual do veículo.
Chassi CHAR(9), -- Número do chassi do veículo.
Marca CHAR(30), -- Marca do veículo.
Ano INT, --	 Ano de fabricação do veículo.	
-- restrições
CONSTRAINT pk_Veiculo PRIMARY KEY (MID, Placa),
CONSTRAINT fk_Motorista FOREIGN KEY(MID) REFERENCES motorista(ID)
);

CREATE TABLE Veiculo_Acessorios(
VMID CHAR(6), -- Identificador único do veículo 
VPLACA CHAR(7), -- Número da placa do veículo 
VACESSORIOS CHAR(30), -- Nome dos acessórios do veículo.
-- restrições
CONSTRAINT pk_Veiculo_Acessorios PRIMARY KEY (VMID, VPLACA, VACESSORIOS),
CONSTRAINT fk_Veiculo FOREIGN KEY(VMID) REFERENCES Veiculo(MID),
CONSTRAINT fk_Veiculo2 FOREIGN KEY(VPLACA) REFERENCES Veiculo(Placa)
);

CREATE TABLE Cliente_Celular(
CPF CHAR(11), -- Número do Cadastro de Pessoas Físicas (CPF) do cliente
Celular CHAR(10), -- Número de celular do cliente.
CONSTRAINT pk_Cliente_Celular PRIMARY KEY (CPF, Celular),
CONSTRAINT fk_Cliente FOREIGN KEY(CPF) REFERENCES Cliente(CPF)
);

CREATE TABLE Cliente_VIP(
CPF CHAR(11) UNIQUE, -- Número do Cadastro de Pessoas Físicas (CPF) do cliente
Porcentagem_desconto Float, --Porcentagem de desconto para o cliente VIP.
CONSTRAINT pk_Cliente_VIP PRIMARY KEY (CPF),
CONSTRAINT fk_Cliente FOREIGN KEY(CPF) REFERENCES Cliente(CPF)
);

CREATE TABLE UBER(
UBER_ID CHAR(6), --	Identificador único para cada UBER.
MID CHAR(6) UNIQUE, --  Identificador único do motorista 
Placa CHAR(7) UNIQUE, -- Número da placa do veículo 
Uber_Black BOOL, -- Booleano indicando se o UBER é do tipo Black.
CONSTRAINT pk_UBER PRIMARY KEY (UBER_ID),
CONSTRAINT fk_Motorista FOREIGN KEY(MID) REFERENCES Motorista(ID),
CONSTRAINT fk_Veiculo1 FOREIGN KEY(MID) REFERENCES Veiculo(MID),
CONSTRAINT fk_Veiculo2 FOREIGN KEY(Placa) REFERENCES Veiculo(Placa)
);

CREATE TABLE Uber_X(
UBER_ID CHAR(6), -- Identificador único para cada UBER X
Data_rev DATE, -- Data da revisão.
CONSTRAINT pk_Uber_X PRIMARY KEY (UBER_ID),
CONSTRAINT fk_Uber_X FOREIGN KEY(UBER_ID) REFERENCES Uber(UBER_ID)
);

CREATE TABLE Uber_Comfort(
UBER_ID CHAR(6), -- Identificador único para cada UBER Comfort 
Taxa_extra Float,-- Taxa extra para o UBER Comfort.
CONSTRAINT pk_Uber_Comfort PRIMARY KEY (UBER_ID),
CONSTRAINT fk_Uber_Comfort FOREIGN KEY(UBER_ID) REFERENCES Uber(UBER_ID)
);

CREATE TABLE endereços(
IDend char(6) NOT NULL, -- Identificador único para cada endereço utilizado nas viagens.
Numero int NOT NULL, -- Número do endereço.
rua char(50) NOT NULL, -- Nome da rua do endereço.
bairro char(30) NOT NULL, -- Bairro do endereço.
cidade char(45) NOT NULL, -- Cidade do endereço.
estado char(40) NOT NULL, --  Estado do endereço.
pais char(35) NOT NULL, -- País do endereço.
-- restrições	
CONSTRAINT pk_endereço PRIMARY KEY (IDend)
);



CREATE TABLE VIAGEM(
IDviagem INT NOT NULL, --Identificador único para cada viagem.
Fpagamento CHAR(20), -- Forma de pagamento da viagem.
Horigem TIME, -- Hora de origem da viagem.
Hdestino TIME, -- Hora de destino da viagem.
ValorM FLOAT, -- Valor total da viagem para o motorista.
ValorU FLOAT, -- Valor total da viagem para o Uberland.
Status CHAR(20), -- Estado atual da viagem.
Dataviagem DATE, -- Data da viagem.
Viajar_MID CHAR(6), -- Identificador único do Uber
Viajar_CPF CHAR(11), -- Número do CPF do cliente 
ENDorigem  char(6), -- Id do endereço da origem
ENDdestino  char(6), --	Id do endereço do destino
Avaliação Float, -- Avaliação da viagem
-- restrições	
CONSTRAINT pk_VIAGEM PRIMARY KEY (IDviagem),
CONSTRAINT fk_Uber1 FOREIGN KEY(Viajar_MID) REFERENCES Uber(UBER_ID),
CONSTRAINT fk_Cliente FOREIGN KEY(Viajar_CPF) REFERENCES Cliente(CPF),
CONSTRAINT fk_ENDorigem FOREIGN KEY(ENDorigem) REFERENCES endereços(IDend),
CONSTRAINT fk_ENDdestino FOREIGN KEY(ENDdestino) REFERENCES endereços(IDend)
);

CREATE TABLE Viagem_Ponto_Parada(
VID INT,
IDPP char(6) NOT NULL, -- Identificador único para cada ponto de parada.
Numero int NOT NULL, -- Número do ponto de parada.
rua char(50) NOT NULL, -- Nome da rua do ponto de parada.
bairro char(30) NOT NULL, -- Bairro do ponto de parada.
cidade char(45) NOT NULL, -- Cidade do ponto de parada.
estado char(40) NOT NULL, --  Estado do ponto de parada.
pais char(35) NOT NULL, -- País do ponto de parada.
-- restrições	
CONSTRAINT pk_Ponto_Parada PRIMARY KEY (VID, IDPP),
CONSTRAINT fk_Viagem FOREIGN KEY(VID) REFERENCES Viagem(IDviagem)
);


CREATE TABLE Pedido(
IDpedido CHAR(11) NOT NULL, -- Identificador único para cada pedido.
Horigem TIME, -- Hora de origem do pedido.
Hdestino TIME, -- Hora de destino do pedido.
Datapedido DATE, -- Data do pedido.
Frágil BOOL, -- Booleano indicando se o pedido é fragil.
Descrição CHAR(500), -- Descrição sobre o pedido
ValorM FLOAT, -- Valor total da viagem para o motorista.
ValorU FLOAT, -- Valor total da viagem para o Uberland.
Remetente CHAR(100), -- Nome da pessoa que enviou o pedido.
Fazer_MID CHAR(6), -- Identificador único do Uber
Fazer_CPF CHAR(11), -- Número do CPF do cliente 
ENDorigem  char(6), -- Id do endereço da origem
ENDdestino  char(6), --	Id do endereço do destino
Avaliação Float, -- Avaliação da viagem
-- restrições
CONSTRAINT pk_Pedido PRIMARY KEY (IDpedido),
CONSTRAINT fk_Uber1 FOREIGN KEY(Fazer_MID) REFERENCES Uber(UBER_ID),
CONSTRAINT fk_Cliente FOREIGN KEY(Fazer_CPF) REFERENCES Cliente(CPF),
CONSTRAINT fk_ENDorigem FOREIGN KEY(ENDorigem) REFERENCES endereços(IDend),
CONSTRAINT fk_ENDdestino FOREIGN KEY(ENDdestino) REFERENCES endereços(IDend)
);