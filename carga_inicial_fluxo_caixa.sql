INSERT INTO fluxo_caixa.funcionario (nome, cpf, salario, email, rua, numero, bairro, cidade)
VALUES 
('João Silva', '12345678901', 2500.00, 'joao.silva@email.com', 'Rua das Flores', '123', 'Centro', 'Campina Grande'),
('Maria Oliveira', '23456789012', 3000.00, 'maria.oliveira@email.com', 'Avenida Paulista', '456', 'Jardins', 'Campina Grande'),
('Carlos Pereira', '34567890123', 2800.00, 'carlos.pereira@email.com', 'Rua Rio Branco', '789', 'Centro', 'Campina Grande'),
('Ana Costa', '45678901234', 3200.00, 'ana.costa@email.com', 'Rua do Catete', '101', 'Flamengo', 'Campina Grande'),
('Paulo Souza', '56789012345', 3500.00, 'paulo.souza@email.com', 'Avenida Brasil', '202', 'Bangu', 'Campina Grande'),
('Fernanda Lima', '67890123456', 2700.00, 'fernanda.lima@email.com', 'Rua dos Três Irmãos', '303', 'Centro', 'Campina Grande'),
('Ricardo Silva', '78901234567', 4000.00, 'ricardo.silva@email.com', 'Rua da Liberdade', '404', 'Liberdade', 'Campina Grande'),
('Mariana Santos', '89012345678', 3300.00, 'mariana.santos@email.com', 'Rua das Acácias', '505', 'Vila Progredior', 'Campina Grande'),
('Eduardo Almeida', '90123456789', 2600.00, 'eduardo.almeida@email.com', 'Avenida Ipiranga', '606', 'Vila Mariana', 'Campina Grande'),
('Roberta Martins', '01234567890', 3100.00, 'roberta.martins@email.com', 'Rua Sete de Setembro', '707', 'Centro', 'Campina Grande');


INSERT INTO fluxo_caixa.telefone_funcionario (funcionario_id, ddd, numero)
VALUES
(1, '83', '987654321'),
(1, '83', '998877665'),
(2, '83', '988776655'),
(2, '83', '987654321'),
(3, '83', '976543210'),
(3, '83', '975432109'),
(4, '83', '934567890'),
(4, '83', '933456789'),
(5, '83', '991234567'),
(5, '83', '990123456'),
(6, '83', '983211223'),
(6, '83', '982110234'),
(7, '83', '991234567'),
(7, '83', '998765432'),
(8, '83', '991122334'),
(8, '83', '993344556'),
(9, '83', '994455667'),
(9, '83', '993366554'),
(10, '83', '999988877'),
(10, '83', '998877665');


INSERT INTO fluxo_caixa.cliente (nome, cpf)
VALUES 
('João Silva', '12345678901'),
(null, '23456789012'),
('Maria Oliveira', '34567890123'),
(null, '45678901234'),
('Carlos Souza', '56789012345'),
(null, '67890123456'),
('Ana Costa', '78901234567'),
(null, '89012345678'),
('Pedro Lima', '90123456789'),
(null, '01234567890'); 


INSERT INTO fluxo_caixa.telefone_cliente (cliente_id, ddd, numero)
VALUES
(1, '83', '987654321'),
(3, '83', '976543210'),
(5, '83', '982110234'),
(7, '83', '993344556'),
(9, '83', '998877665');
