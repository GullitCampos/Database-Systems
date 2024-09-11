SET search_path TO UBERLAND;
INSERT INTO motorista (ID, Atividade, Datanac, Nome, Ncorridas, Avaliação, CNH, CPF, Numero, Rua, Bairro, Cidade, Estado, Pais, Sexo)
VALUES 
    ('MOT001', TRUE, '1990-01-15', 'João Silva', 100, 4.5, '12345678901', '98765432109', 123, 'Rua Alamenda', 'Centro', 'São João do miriti', 'Paraiba', 'Brasil', 'Masculino'),
    ('MOT002', TRUE, '1985-05-22', 'Maria Oliveira', 150, 4.8, '98765432101', '12345678909', 456, 'Rua Beraldo', 'Bairro Brasil', 'Berlandia', 'Estado de calamidade', 'Brasil', 'Feminino'),
    ('MOT003', TRUE, '2001-05-22', 'Carlos', 15, 10, '124575755', '1111111', 456, 'Rua carlos', 'Bairro dinamite', 'Cidade escola', 'Faria', 'Brasil', 'Masculino'),
	('MOT004', TRUE, '1989-06-22', 'Rodrigo Oliveira', 85, 4.5, '54321012345', '98765432101', 808, 'Avenida Paulista', 'Jardins', 'São Paulo', 'São Paulo', 'Brasil', 'Masculino'),
    ('MOT005', FALSE, '1994-03-10', 'Juliana Lima', 55, 4.2, '98765432123', '32109876501', 909, 'Rua Copacabana', 'Copacabana', 'Rio de Janeiro', 'Rio de Janeiro', 'Brasil', 'Feminino'),
    ('MOT006', TRUE, '1990-11-18', 'Carlos Silva', 125, 4.9, '87654321098', '54321098701', 1010, 'Avenida Boa Viagem', 'Boa Viagem', 'Recife', 'Pernambuco', 'Brasil', 'Masculino'),
    ('MOT007', TRUE, '1985-02-27', 'Amanda Santos', 100, 4.4, '76543210987', '10987654321', 1111, 'Rua 25 de Março', 'Centro', 'São Paulo', 'São Paulo', 'Brasil', 'Feminino'),
    ('MOT008', FALSE, '1993-09-14', 'Roberto Oliveira', 75, 4.7, '65432109876', '21098765432', 1212, 'Avenida Atlântica', 'Copacabana', 'Rio de Janeiro', 'Rio de Janeiro', 'Brasil', 'Masculino');
	
INSERT INTO Cliente (CPF, Media, Sexo, Ncorridas, Email, Nome, Datanac)
VALUES 
    ('45678901234', 3.2, 'Feminino', 5, 'AnaPereira@example.com', 'Ana Pereira', '1993-07-10'),
    ('56789012345', 4.8, 'Masculino', 20, 'CarlosOliveira@example.com', 'Carlos Oliveira', '1980-03-28'),
    ('67890123456', 3.5, 'Feminino', 12, 'LuizaMendes@example.com', 'Luiza Mendes', '1995-11-18'),
    ('78901234567', 4.0, 'Masculino', 18, 'GabrielSilva@example.com', 'Gabriel Silva', '1987-12-03'),
    ('89012345678', 4.7, 'Feminino', 25, 'RafaelaSantos@example.com', 'Rafaela Santos', '1982-06-14');	
	
INSERT INTO Financeiro (ID, Histransação , Supagamentos , Orçamento , Compreço , Relatório , Tributo , Alerta )
VALUES
('ABC123456789', 'Compra', 'Cartão de crédito', 1000.00, 950.00, 'Relatório A', 50.00, TRUE),
('DEF987654321', 'Pagamento', 'Transferência', 2000.00, 1980.00, 'Relatório B', 20.00, FALSE),
('GHI567890123', 'Recebimento', 'Boleto', 1500.00, 1520.00, 'Relatório C', 0.00, FALSE),
('JKL234567890', 'Pagamento', 'Débito', 500.00, 510.00, 'Relatório D', 10.00, TRUE),
('MNO890123456', 'Transferência', 'Transferência', 800.00, 800.00, 'Relatório E', 0.00, FALSE);

INSERT INTO Veiculo (MID, Placa, Nome, Atividade, Sedan, Npassageiros, Status, Chassi, Marca, Ano)
VALUES 
('MOT002', 'ABC1235', 'Toyota Camry', TRUE, TRUE, 5, 'Disponível', 'CHASSI123', 'Toyota', 2020),
('MOT003', 'DEF5678', 'Honda Accord', TRUE, TRUE, 5, 'Insponível', 'CHASSI456', 'Honda', 2019),
('MOT004', 'GHI9012', 'Ford Escape', TRUE, FALSE, 7, 'Disponível', 'CHASSI789', 'Ford', 2021),
('MOT005', 'JKL3456', 'Chevrolet Silverado', TRUE, FALSE, 3, 'Em Reparo', 'CHASSI101', 'Chevrolet', 2018),
('MOT006', 'MNO7890', 'Nissan Rogue', TRUE, FALSE, 5, 'Disponível', 'CHASSI112', 'Nissan', 2022);

INSERT INTO Veiculo_Acessorios (VMID, VPLACA, VACESSORIOS)
VALUES ('MOT002', 'ABC1235', 'Airbags');

INSERT INTO Veiculo_Acessorios (VMID, VPLACA, VACESSORIOS)
VALUES ('MOT003', 'DEF5678', 'GPS Navigation System');

INSERT INTO Veiculo_Acessorios (VMID, VPLACA, VACESSORIOS)
VALUES ('MOT004', 'JKL3456', 'Leather Seats');

INSERT INTO Veiculo_Acessorios (VMID, VPLACA, VACESSORIOS)
VALUES ('MOT005', 'MNO7890', 'Sunroof');

INSERT INTO Veiculo_Acessorios (VMID, VPLACA, VACESSORIOS)
VALUES ('MOT006', 'GHI9012', 'Bluetooth Connectivity');

INSERT INTO Cliente_Celular (CPF, Celular) VALUES 
    ('45678901234', '9999999999'),
    ('56789012345', '8888888888'),
    ('67890123456', '7777777777'),
    ('78901234567', '6666666666'),
    ('89012345678', '5555555555');
	
INSERT INTO Cliente (CPF, Media, Sexo, Ncorridas, Email, Nome, Datanac)	
VALUES 
    ('12345678911', 4.5, 'Masculino', 15, 'MariaSouza@example.com', 'Maria Souza', '1988-09-22'),
    ('23456789022', 3.8, 'Feminino', 8, 'AndersonLima@example.com', 'Anderson Lima', '1990-05-15'),
    ('34567890133', 4.2, 'Masculino', 10, 'JulianaCosta@example.com', 'Juliana Costa', '1985-12-07'),
    ('45678901244', 4.1, 'Feminino', 14, 'RobertoAlmeida@example.com', 'Roberto Almeida', '1992-04-30'),
    ('56789012355', 3.9, 'Masculino', 22, 'CarolinaRocha@example.com', 'Carolina Rocha', '1983-11-12'),
    ('67890123466', 4.4, 'Feminino', 18, 'RicardoMachado@example.com', 'Ricardo Machado', '1997-08-25'),
    ('78901234577', 3.7, 'Masculino', 12, 'LarissaFerreira@example.com', 'Larissa Ferreira', '1989-02-14'),
    ('89012345688', 4.6, 'Feminino', 25, 'JoaoSantana@example.com', 'Joao Santana', '1986-06-08'),
    ('90123456799', 3.3, 'Masculino', 7, 'FernandaOliveira@example.com', 'Fernanda Oliveira', '1994-03-19'),
    ('01234567855', 4.8, 'Feminino', 30, 'LucasSilveira@example.com', 'Lucas Silveira', '1981-10-03');
	
INSERT INTO motorista (ID, Atividade, Datanac, Nome, Ncorridas, Avaliação, CNH, CPF, Numero, Rua, Bairro, Cidade, Estado, Pais, Sexo)
VALUES 
    ('MOT021', TRUE, '1988-07-08', 'Fernanda Oliveira', 120, 4.6, '8765432101', '54321022', 1313, 'Rua da Paz', 'Paz', 'Porto Alegre', 'Rio Grande do Sul', 'Brasil', 'Feminino'),
    ('MOT010', TRUE, '1995-04-25', 'Ricardo Santos', 90, 4.3, '76543210901', '1098765111', 1414, 'Avenida Liberdade', 'Liberdade', 'Salvador', 'Bahia', 'Brasil', 'Masculino'),
    ('MOT011', FALSE, '1992-12-03', 'Ana Lima', 80, 4.0, '5438809876', '9876543214', 1515, 'Rua Bela Vista', 'Bela Vista', 'Curitiba', 'Paraná', 'Brasil', 'Feminino'),
    ('MOT012', TRUE, '1987-09-20', 'Lucas Silva', 110, 4.7, '3210987654', '1234509875', 1616, 'Avenida Central', 'Centro', 'Brasília', 'Distrito Federal', 'Brasil', 'Masculino'),
    ('MOT013', TRUE, '1991-02-15', 'Mariana Oliveira', 70, 4.8, '9876543219', '5432109872', 1717, 'Rua Esperança', 'Esperança', 'Fortaleza', 'Ceará', 'Brasil', 'Feminino'),
    ('MOT014', FALSE, '1986-11-18', 'Pedro Santos', 60, 3.9, '2109876543', '9876543213', 1818, 'Avenida Progresso', 'Progresso', 'Belém', 'Pará', 'Brasil', 'Masculino'),
    ('MOT015', TRUE, '1998-06-22', 'Fátima Oliveira', 95, 4.5, '5432109876', '2109876544', 1919, 'Rua da Harmonia', 'Harmonia', 'Manaus', 'Amazonas', 'Brasil', 'Feminino'),
    ('MOT016', TRUE, '1984-03-10', 'Gustavo Lima', 130, 4.9, '9876543210', '4321098764', 2020, 'Avenida Felicidade', 'Felicidade', 'Porto Velho', 'Rondônia', 'Brasil', 'Masculino'),
    ('MOT017', FALSE, '1993-08-15', 'Camila Silva', 75, 4.2, '5432122876', '98765432144', 2121, 'Rua da Liberdade', 'Liberdade', 'Florianópolis', 'Santa Catarina', 'Brasil', 'Feminino'),
    ('MOT018', TRUE, '1989-04-22', 'Marcelo Oliveira', 105, 4.6, '9876541110', '5432104476', 2222, 'Avenida da Amizade', 'Amizade', 'Natal', 'Rio Grande do Norte', 'Brasil', 'Masculino'),
    ('MOT019', TRUE, '1996-01-28', 'Isabel Santos', 85, 4.4, '5432119876', '9876543215', 2323, 'Rua da Alegria', 'Alegria', 'Maceió', 'Alagoas', 'Brasil', 'Feminino'),
    ('MOT020', FALSE, '1990-10-05', 'Rafael Lima', 50, 3.8, '2109876588', '5432109874', 2424, 'Avenida do Progresso', 'Progresso', 'Campo Grande', 'Mato Grosso do Sul', 'Brasil', 'Masculino');
	
INSERT INTO Veiculo (MID, Placa, Nome, Atividade, Sedan, Npassageiros, Status, Chassi, Marca, Ano)
VALUES
    ('MOT021', 'ABC1111', 'Toyota Corolla', TRUE, TRUE, 5, 'Ativo', 'CHASSI001', 'Toyota', 2022),
    ('MOT010', 'DEF1111', 'Honda Civic', TRUE, TRUE, 5, 'Inativo', 'CHASSI002', 'Honda', 2021),
    ('MOT011', 'GHI1111', 'Ford Mustang', FALSE, FALSE, 2, 'Ativo', 'CHASSI003', 'Ford', 2020),
    ('MOT012', 'JKL1111', 'Camaro', TRUE, FALSE, 6, 'Ativo', 'CHASSI004', 'Chevrolet', 2023),
    ('MOT013', 'MNO1111', 'BMW 3 Series', TRUE, TRUE, 4, 'Inativo', 'CHASSI005', 'BMW', 2019),
    ('MOT014', 'PQR1111', 'Nissan Altima', TRUE, TRUE, 5, 'Inativo', 'CHASSI006', 'Nissan', 2022),
    ('MOT016', 'STU1111', 'Mercedes-Benz C-Class', TRUE, TRUE, 4, 'Ativo', 'CHASSI007', 'Mercedes-Benz', 2023),
    ('MOT017', 'VWX1111', 'Jeep Wrangler', TRUE, FALSE, 4, 'Ativo', 'CHASSI008', 'Jeep', 2021),
    ('MOT018', 'YZA1111', 'Hyundai Sonata', TRUE, TRUE, 5, 'Inativo', 'CHASSI009', 'Hyundai', 2020),
    ('MOT019', 'BCD1111', 'Audi Q5', TRUE, FALSE, 5, 'Ativo', 'CHASSI010', 'Audi', 2022);
	
INSERT INTO Cliente_VIP (CPF, Porcentagem_desconto)
VALUES 
    ('12345678911', 10.0),
    ('23456789022', 15.0),
    ('34567890133', 12.5),
    ('01234567855', 8.0),
    ('90123456799', 20.0);
	
INSERT INTO UBER (UBER_ID, MID, Placa, Uber_Black)
VALUES
    ('U12345', 'MOT021', 'ABC1111', FALSE),
    ('U23456', 'MOT010', 'DEF1111', FALSE),
    ('U34567', 'MOT011', 'GHI1111', FALSE),
    ('U45678', 'MOT012', 'JKL1111', FALSE),
    ('U56789', 'MOT013', 'MNO1111', FALSE),
    ('U67890', 'MOT014', 'PQR1111', FALSE),
    ('U78901', 'MOT016', 'STU1111', FALSE),
    ('U89012', 'MOT017', 'VWX1111', FALSE),
    ('U90123', 'MOT018', 'YZA1111', FALSE),
    ('U01234', 'MOT019', 'BCD1111', FALSE);
	
INSERT INTO Uber_X (UBER_ID, Data_rev)
VALUES
    ('U12345', '2023-01-22'),
    ('U23456', '2023-09-12'),
    ('U34567', '2023-02-04'),
    ('U45678', '2022-09-30'),
    ('U56789', '2023-07-21');
	
INSERT INTO Uber_Comfort (UBER_ID, Taxa_extra)
VALUES
    ('U01234', 2.50),
    ('U90123', 3.00),
    ('U89012', 2.75),
    ('U78901', 2.75),
    ('U67890', 2.25);
	
INSERT INTO endereços (IDend, Numero, rua, bairro, cidade, estado, pais)
VALUES
    ('A12345', 123, 'Rua Alegria', 'Centro', 'São Paulo', 'SP', 'Brazil'),
    ('B67890', 456, 'Sunset Boulevard', 'Hollywood', 'Los Angeles', 'CA', 'Brazil'),
    ('C24680', 789, 'Abbey Road', 'Camden', 'London', 'N/A', 'Brazil'),
    ('D13579', 101, 'Champs-Élysées', 'Champs-Élysées', 'Paris', 'N/A', 'Brazil'),
    ('E24681', 222, 'Gran Vía', 'Chueca', 'Madrid', 'N/A', 'Brazil'),
    ('F98765', 789, 'Shibuya Crossing', 'Shibuya', 'Tokyo', 'N/A', 'Brazil'),
    ('G54321', 456, 'Kurfürstendamm', 'Charlottenburg', 'Berlin', 'N/A', 'Brazil'),
    ('H11223', 333, 'Sukhumvit Road', 'Watthana', 'Bangkok', 'N/A', 'Brazil'),
    ('I44556', 555, 'Circular Quay', 'Sydney', 'New South Wales', 'NSW', 'Brazil'),
    ('J78901', 999, 'Av. Paulista', 'Bela Vista', 'São Paulo', 'SP', 'Brazil');
	

INSERT INTO VIAGEM (IDviagem, Fpagamento, Horigem, Hdestino, ValorM, ValorU, Status, Dataviagem, Viajar_MID, Viajar_CPF, ENDorigem, ENDdestino, Avaliação)
VALUES
    (1, 'Cartão de crédito', '12:30:00', '13:15:00', 30.50, 35.00, 'Concluída', '2023-01-22', 'U12345', '45678901234', 'A12345', 'B67890', 4.5),
    (2, 'Dinheiro', '18:45:00', '19:30:00', 25.00, 28.00, 'Cancelada', '2023-09-12', 'U23456', '56789012345', 'C24680', 'D13579', NULL),
    (3, 'Cartão de crédito', '09:00:00', '09:45:00', 20.00, 23.50, 'Concluída', '2023-02-04', 'U34567', '67890123456', 'E24681', 'F98765', 4.0),
    (4, 'Dinheiro', '15:20:00', '16:05:00', 15.50, 18.00, 'Concluída', '2022-09-30', 'U45678', '78901234567', 'G54321', 'H11223', 3.8),
    (5, 'Cartão de crédito', '14:00:00', '15:30:00', 40.00, 45.50, 'Concluída', '2023-07-21', 'U56789', '89012345678', 'I44556', 'J78901', 4.2);

INSERT INTO Viagem_Ponto_Parada (VID, IDPP, Numero, rua, bairro, cidade, estado, pais)
VALUES
    (5,'E24681', 222, 'Gran Vía', 'Chueca', 'Madrid', 'N/A', 'Brazil'),
	(1,'A12345', 123, 'Rua Alegria', 'Centro', 'São Paulo', 'SP', 'Brazil'),
    (2,'B67890', 456, 'Sunset Boulevard', 'Hollywood', 'Los Angeles', 'CA', 'Brazil'),
    (3,'C24680', 789, 'Abbey Road', 'Camden', 'London', 'N/A', 'Brazil'),
    (4,'D13579', 101, 'Champs-Élysées', 'Champs-Élysées', 'Paris', 'N/A', 'Brazil');
	
INSERT INTO Pedido (IDpedido, Horigem, Hdestino, Datapedido, Frágil, Descrição, ValorM, ValorU, Remetente, Fazer_MID, Fazer_CPF, ENDorigem, ENDdestino, Avaliação)
VALUES
    ('PED001', '10:00:00', '11:00:00', '2023-01-22', FALSE, 'Documentos importantes', 20.00, 25.00, 'João Silva', 'U01234', '45678901234', 'A12345', 'B67890', 4.7),
    ('PED002', '14:30:00', '15:30:00', '2023-09-12', TRUE, 'Fragile items', 30.00, 35.50, 'Maria Oliveira', 'U90123', '56789012345', 'C24680', 'D13579', 4.2),
    ('PED003', '08:45:00', '09:30:00', '2023-02-04', FALSE, 'Boxed electronics', 25.50, 30.00, 'Carlos Lima', 'U89012', '67890123456', 'E24681', 'F98765', 3.5),
    ('PED004', '16:15:00', '17:00:00', '2022-09-30', TRUE, 'Delicate glassware', 18.00, 20.50, 'Roberto Almeida', 'U89012', '78901234567', 'G54321', 'H11223', 4.0),
    ('PED005', '12:00:00', '13:30:00', '2023-07-21', FALSE, 'Clothing items', 40.50, 45.00, 'Rafaela Santos', 'U89012', '89012345678', 'I44556', 'J78901', 4.8);


INSERT INTO VIAGEM (IDviagem, Fpagamento, Horigem, Hdestino, ValorM, ValorU, Status, Dataviagem, Viajar_MID, Viajar_CPF, ENDorigem, ENDdestino, Avaliação)
VALUES
    (6, 'Cartão de crédito', '12:30:00', '13:15:00', 30.50, 35.00, 'Concluída', '2023-11-22', 'U12345', '45678901234', 'A12345', 'B67890', 4.5),
    (7, 'Dinheiro', '18:45:00', '19:30:00', 25.00, 28.00, 'Cancelada', '2023-10-12', 'U23456', '56789012345', 'C24680', 'D13579', NULL),
    (8, 'Cartão de crédito', '09:00:00', '09:45:00', 20.00, 23.50, 'Concluída', '2023-11-21', 'U34567', '67890123456', 'E24681', 'F98765', 4.0),
    (9, 'Dinheiro', '15:20:00', '16:05:00', 15.50, 18.00, 'Concluída', '2022-11-30', 'U45678', '78901234567', 'G54321', 'H11223', 3.8),
    (10, 'Cartão de crédito', '14:00:00', '15:30:00', 40.00, 45.50, 'Concluída', '2023-11-21', 'U56789', '89012345678', 'I44556', 'J78901', 4.2);

INSERT INTO motorista (ID, Atividade, Datanac, Nome, Ncorridas, Avaliação, CNH, CPF, Numero, Rua, Bairro, Cidade, Estado, Pais, Sexo)
VALUES 
    ('MOT114', TRUE, '1999-11-15', 'João Pedro', 100, 2.5, '23456789101', '32165498714', 123, 'Rua Alamenda', 'Centro', 'São João do miriti', 'Paraiba', 'Brasil', 'Masculino');
	
INSERT INTO Veiculo (MID, Placa, Nome, Atividade, Sedan, Npassageiros, Status, Chassi, Marca, Ano)
VALUES 
('MOT114', 'ABC1001', 'Toyota Camry', TRUE, TRUE, 5, 'Disponível', 'CHASSI333', 'Toyota', 2020);

INSERT INTO UBER (UBER_ID, MID, Placa, Uber_Black)
VALUES
    ('U99999', 'MOT114', 'ABC1001', FALSE);

INSERT INTO VIAGEM (IDviagem, Fpagamento, Horigem, Hdestino, ValorM, ValorU, Status, Dataviagem, Viajar_MID, Viajar_CPF, ENDorigem, ENDdestino, Avaliação)
VALUES
    (17, 'Cartão de crédito', '12:30:00', '13:15:00', 30.50, 35.00, 'Concluída', '2023-01-22', 'U99999', '45678901234', 'A12345', 'B67890', 4.5);
	