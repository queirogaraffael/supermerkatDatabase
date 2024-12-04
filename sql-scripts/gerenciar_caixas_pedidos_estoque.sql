-- Dia da Inauguração
-- Ao iniciar o dia, foram abertos 5 caixas na mercado, 
-- um dos caixa apresentou problemas antes da inauguração e por isso foi colocado em manutenção.
INSERT INTO fluxo_caixa.caixa (funcionario_id, numero, status, data_abertura)
VALUES
((SELECT id FROM fluxo_caixa.funcionario WHERE cpf = '12345678901'), 101, 'ABERTO', '2024-11-23 07:00:00'),
((SELECT id FROM fluxo_caixa.funcionario WHERE cpf = '23456789012'), 102, 'ABERTO', '2024-11-23 07:00:00'),
(null, 103, 'EM_MANUTENCAO', null), -- Um caixa está com problemas e por isso está em manutenção.
((SELECT id FROM fluxo_caixa.funcionario WHERE cpf = '34567890123'), 104, 'ABERTO', '2024-11-23 07:00:00'),
((SELECT id FROM fluxo_caixa.funcionario WHERE cpf = '45678901234'), 105, 'ABERTO', '2024-11-23 07:00:00'),
((SELECT id FROM fluxo_caixa.funcionario WHERE cpf = '01234567890'), 106, 'ABERTO', '2024-11-23 07:00:00');

-- Visualização dos caixas abertos do dia
SELECT * 
FROM fluxo_caixa.caixa
WHERE status = 'ABERTO'
  AND DATE(data_abertura) = '2024-11-23';

-- -----------------------------------------------------------------------------------------------------------

-- Função para atualizar o estoque do mercado após a finalização de um pedido.
CREATE OR REPLACE FUNCTION atualizar_estoque_pedido()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'CONCLUIDO' THEN
        UPDATE controle_estoque.produto
        SET quantidade_atual = quantidade_atual - ip.quantidade
        FROM fluxo_caixa.item_pedido ip
        WHERE ip.pedido_id = NEW.id
          AND controle_estoque.produto.id = ip.produto_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para modificar estoque quando um pedido é finalizado
CREATE TRIGGER trigger_atualizar_estoque
AFTER UPDATE ON fluxo_caixa.pedido
FOR EACH ROW
WHEN (OLD.status IS DISTINCT FROM NEW.status)
EXECUTE FUNCTION atualizar_estoque_pedido();

-- -----------------------------------------------------------------------------------------------------------

-- Pedido Cliente 1
INSERT INTO fluxo_caixa.cliente (nome, cpf) 
VALUES -- Passo 1: Ao chegar no caixa, o cliente fornece alguns dados para o pedido ser aberto.
('Raffael Queiroga', '12345678901');

-- Passo 1.1: Cliente forneceu, além do seu nome e CPF, seu telefone.
INSERT INTO fluxo_caixa.telefone_cliente (cliente_id, ddd, numero)
VALUES
((SELECT id FROM fluxo_caixa.cliente WHERE cpf = '12345678901'), '83', '12345678901');

-- Passo 2: Caixa cria pedido para cliente
INSERT INTO fluxo_caixa.pedido (cliente_id, caixa_id, data_pedido, status)
VALUES
((SELECT id FROM fluxo_caixa.cliente WHERE cpf = '12345678901'), (SELECT id FROM fluxo_caixa.caixa WHERE numero = 101), '2024-11-23 07:30:00','CRIADO');

WITH PedidoID_1 AS ( -- OBS: Algumas consultas precisam rodar em conjunto com PedidoID_1
    SELECT 
        pedido.id AS pedido_id
    FROM 
        fluxo_caixa.pedido
    JOIN 
        fluxo_caixa.cliente
    ON 
        pedido.cliente_id = cliente.id
    WHERE 
        cliente.cpf = '12345678901'
        AND pedido.data_pedido = '2024-11-23 07:30:00'
	LIMIT 1
)

-- Passo 3: Aqui simula quando o Caixa passa as compras do cliente.
INSERT INTO fluxo_caixa.item_pedido (produto_id, pedido_id, quantidade, preco) -- Adiciona os produtos do cliente ao pedido
VALUES -- Os ids dos produtos são buscados de acordo com seus codigos de barra
((SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890154'), (SELECT pedido_id FROM PedidoID_1), 10, (SELECT preco_atual FROM controle_estoque.produto WHERE codigo_barra = '1234567890154')), 
((SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890155'), (SELECT pedido_id FROM PedidoID_1), 4, (SELECT preco_atual FROM controle_estoque.produto WHERE codigo_barra = '1234567890155')), 
((SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890156'), (SELECT pedido_id FROM PedidoID_1), 5, (SELECT preco_atual FROM controle_estoque.produto WHERE codigo_barra = '1234567890156')), 
((SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890157'), (SELECT pedido_id FROM PedidoID_1), 8, (SELECT preco_atual FROM controle_estoque.produto WHERE codigo_barra = '1234567890157'));

-- Passo 4: Visualizar os itens do pedido, incluindo os nomes dos produtos
SELECT 
    p.nome AS produto_nome,
    ip.quantidade,
    ip.preco,
    (ip.quantidade * ip.preco) AS total_item
FROM 
    fluxo_caixa.item_pedido ip
JOIN 
    controle_estoque.produto p ON ip.produto_id = p.id
WHERE 
    ip.pedido_id = (
        SELECT id 
        FROM fluxo_caixa.pedido
        WHERE cliente_id = (SELECT id FROM fluxo_caixa.cliente WHERE cpf = '12345678901')
          AND data_pedido = '2024-11-23 07:30:00'
    );

-- Passo 5: Atualiza o pedido com o valor total,
-- adiciona tipo de pagamento, data de pagamento e modifica o status e com isso aciona o trigger.
WITH PedidoTotal_1 AS (
    SELECT 
        ip.pedido_id,
        SUM(ip.quantidade * ip.preco) AS total_pedido
    FROM 
        fluxo_caixa.item_pedido ip
    GROUP BY 
        ip.pedido_id
)
UPDATE fluxo_caixa.pedido 
SET -- OBS: Dever ser rodado em conjunto com o WITH PedidoTotal_1
	total_pedido = (SELECT total_pedido FROM PedidoTotal_1 WHERE PedidoTotal.pedido_id = fluxo_caixa.pedido.id)
    tipo_pagamento = 'PIX',
	data_pagamento = '2024-12-04 07:45:00',
	status = 'CONCLUIDO'
WHERE 
    cliente_id = (SELECT id FROM fluxo_caixa.cliente WHERE cpf = '12345678901')
    AND caixa_id = (SELECT id FROM fluxo_caixa.caixa WHERE numero = 101)
    AND data_pedido = '2024-11-23 07:30:00';

-- Passo 6: Visualizar pedido final
SELECT
    p.id AS pedido_id,
    c.cpf AS cliente_cpf,
    p.data_pedido,
    p.status,
    SUM(ip.quantidade * ip.preco) AS total_pedido
FROM 
    fluxo_caixa.pedido p
JOIN 
    fluxo_caixa.cliente c ON p.cliente_id = c.id
JOIN 
    fluxo_caixa.item_pedido ip ON p.id = ip.pedido_id
WHERE 
    c.cpf = '12345678901'
      AND p.data_pedido = '2024-11-23 07:30:00'
GROUP BY 
    p.id, c.cpf, p.data_pedido, p.status;

-- -----------------------------------------------------------------------------------------------------------

-- Cliente 2

-- Passo 1: Cliente forneceu apenas seu CPF ao caixa, não quis terminar o resto do cadastro.
INSERT INTO fluxo_caixa.cliente (cpf) 
VALUES 
('23456789012');

-- Passo 2: -- Caixa abriu o pedido.
INSERT INTO fluxo_caixa.pedido (cliente_id, caixa_id, data_pedido, status)
VALUES
((SELECT id FROM fluxo_caixa.cliente WHERE cpf = '23456789012'), (SELECT id FROM fluxo_caixa.caixa WHERE numero = 102), '2024-11-23 07:30:00','CRIADO');
	
WITH PedidoID_2 AS ( -- OBS: Algumas consultas precisam rodar em conjunto com PedidoID_1
    SELECT 
        pedido.id AS pedido_id
    FROM 
        fluxo_caixa.pedido
    JOIN 
        fluxo_caixa.cliente
    ON 
        pedido.cliente_id = cliente.id
    WHERE 
        cliente.cpf = '23456789012'
        AND pedido.data_pedido = '2024-11-23 07:30:00'
	LIMIT 1
)

-- Passo 3: Aqui simula quando o Caixa passa as compras do cliente.
INSERT INTO fluxo_caixa.item_pedido (produto_id, pedido_id, quantidade, preco) -- Adiciona os produtos do cliente ao pedido
VALUES -- Os ids dos produtos são buscados de acordo com seus codigos de barra
((SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890154'), (SELECT pedido_id FROM PedidoID_2), 5, (SELECT preco_atual FROM controle_estoque.produto WHERE codigo_barra = '1234567890154')), 
((SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890155'), (SELECT pedido_id FROM PedidoID_2), 2, (SELECT preco_atual FROM controle_estoque.produto WHERE codigo_barra = '1234567890155')), 
((SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890156'), (SELECT pedido_id FROM PedidoID_2), 3, (SELECT preco_atual FROM controle_estoque.produto WHERE codigo_barra = '1234567890156')), 
((SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890157'), (SELECT pedido_id FROM PedidoID_2), 1, (SELECT preco_atual FROM controle_estoque.produto WHERE codigo_barra = '1234567890157'));

-- Passo 4: Visualizar os itens do pedido, incluindo os nomes dos produtos
SELECT 
    p.nome AS produto_nome,
    ip.quantidade,
    ip.preco,
    (ip.quantidade * ip.preco) AS total_item
FROM 
    fluxo_caixa.item_pedido ip
JOIN 
    controle_estoque.produto p ON ip.produto_id = p.id
WHERE 
    ip.pedido_id = (
        SELECT id 
        FROM fluxo_caixa.pedido
        WHERE cliente_id = (SELECT id FROM fluxo_caixa.cliente WHERE cpf = '23456789012')
          AND data_pedido = '2024-11-23 07:30:00'
    );

-- Passo 5: Atualiza o pedido com o valor total,
-- adiciona tipo de pagamento, data de pagamento e modifica o status e com isso aciona o trigger.
WITH PedidoTotal_2 AS (
    SELECT 
        ip.pedido_id,
        SUM(ip.quantidade * ip.preco) AS total_pedido
    FROM 
        fluxo_caixa.item_pedido ip
    GROUP BY 
        ip.pedido_id
)
UPDATE fluxo_caixa.pedido 
SET -- OBS: Dever ser rodado em conjunto com o WITH PedidoTotal_2
	total_pedido = (SELECT total_pedido FROM PedidoTotal_2 WHERE PedidoTotal.pedido_id = fluxo_caixa.pedido.id)
    tipo_pagamento = 'CARTAO',
	data_pagamento = '2024-12-04 07:45:00',
	status = 'CONCLUIDO'
WHERE 
    cliente_id = (SELECT id FROM fluxo_caixa.cliente WHERE cpf = '23456789012')
    AND caixa_id = (SELECT id FROM fluxo_caixa.caixa WHERE numero = 102)
    AND data_pedido = '2024-11-23 07:30:00';

-- Passo 6: Visualizar pedido final
SELECT 
    p.id AS pedido_id,
    c.cpf AS cliente_cpf,
    p.data_pedido,
    p.status,
    SUM(ip.quantidade * ip.preco) AS total_pedido
FROM 
    fluxo_caixa.pedido p
JOIN 
    fluxo_caixa.cliente c ON p.cliente_id = c.id
JOIN 
    fluxo_caixa.item_pedido ip ON p.id = ip.pedido_id
WHERE 
    c.cpf = '23456789012'
      AND p.data_pedido = '2024-11-23 07:30:00'
GROUP BY 
    p.id, c.cpf, p.data_pedido, p.status;

-- -----------------------------------------------------------------------------------------------------------

-- Cliente 3

-- Passo 1: Ao chegar no caixa, o cliente fornece alguns dados para o pedido ser aberto.
INSERT INTO fluxo_caixa.cliente (nome, cpf) -- 
VALUES
('Matheus', '34567890123');

-- Passo 1.1: Cliente forneceu, além do seu nome e CPF, seu telefone.
INSERT INTO fluxo_caixa.telefone_cliente (cliente_id, ddd, numero)
VALUES
((SELECT id FROM fluxo_caixa.cliente WHERE cpf = '34567890123'), '83', '34567890123');

-- Passo 2: Caixa cria pedido para cliente
INSERT INTO fluxo_caixa.pedido (cliente_id, caixa_id, data_pedido, status)
VALUES
((SELECT id FROM fluxo_caixa.cliente WHERE cpf = '34567890123'), (SELECT id FROM fluxo_caixa.caixa WHERE numero = 104), '2024-11-22 07:30:00','CRIADO');

WITH PedidoID_3 AS ( -- OBS: Algumas consultas precisam rodar em conjunto com PedidoID_3
    SELECT 
        pedido.id AS pedido_id
    FROM 
        fluxo_caixa.pedido
    JOIN 
        fluxo_caixa.cliente
    ON 
        pedido.cliente_id = cliente.id
    WHERE 
        cliente.cpf = '34567890123'
        AND pedido.data_pedido = '2024-11-23 07:30:00'
	LIMIT 1
) 
-- Passo 3: Aqui simula quando o Caixa passa as compras do cliente.
INSERT INTO fluxo_caixa.item_pedido (produto_id, pedido_id, quantidade, preco) -- Adiciona os produtos do cliente ao pedido
VALUES -- Os ids dos produtos são buscados de acordo com seus codigos de barra
((SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890154'), (SELECT pedido_id FROM PedidoID_3), 10, (SELECT preco_atual FROM controle_estoque.produto WHERE codigo_barra = '1234567890154')), 
((SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890155'), (SELECT pedido_id FROM PedidoID_3), 10, (SELECT preco_atual FROM controle_estoque.produto WHERE codigo_barra = '1234567890155')), 
((SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890157'), (SELECT pedido_id FROM PedidoID_3), 10, (SELECT preco_atual FROM controle_estoque.produto WHERE codigo_barra = '1234567890157'));

-- Passo 4: Visualizar os itens do pedido, incluindo os nomes dos produtos
SELECT 
    p.nome AS produto_nome,
    ip.quantidade,
    ip.preco,
    (ip.quantidade * ip.preco) AS total_item
FROM 
    fluxo_caixa.item_pedido ip
JOIN 
    controle_estoque.produto p ON ip.produto_id = p.id
WHERE 
    ip.pedido_id = (
        SELECT id 
        FROM fluxo_caixa.pedido
        WHERE cliente_id = (SELECT id FROM fluxo_caixa.cliente WHERE cpf = '34567890123')
          AND data_pedido = '2024-11-23 07:30:00'
    );

-- Passo 5: Atualiza o pedido com o valor total,
-- adiciona tipo de pagamento, data de pagamento e modifica o status e com isso aciona o trigger.
WITH PedidoTotal_3 AS (
    SELECT 
        ip.pedido_id,
        SUM(ip.quantidade * ip.preco) AS total_pedido
    FROM 
        fluxo_caixa.item_pedido ip
    GROUP BY 
        ip.pedido_id
)
UPDATE fluxo_caixa.pedido 
SET -- OBS: Dever ser rodado em conjunto com o WITH PedidoTotal_3
	total_pedido = (SELECT total_pedido FROM PedidoTotal_3 WHERE PedidoTotal.pedido_id = fluxo_caixa.pedido.id)
    tipo_pagamento = 'PIX',
	data_pagamento = '2024-12-04 07:45:00',
	status = 'CONCLUIDO'
WHERE 
    cliente_id = (SELECT id FROM fluxo_caixa.cliente WHERE cpf = '12345678901')
    AND caixa_id = (SELECT id FROM fluxo_caixa.caixa WHERE numero = 103)
    AND data_pedido = '2024-11-23 07:30:00';

-- Passo 6: Visualizar pedido final
SELECT
    p.id AS pedido_id,
    c.cpf AS cliente_cpf,
    p.data_pedido,
    p.status,
    SUM(ip.quantidade * ip.preco) AS total_pedido
FROM 
    fluxo_caixa.pedido p
JOIN 
    fluxo_caixa.cliente c ON p.cliente_id = c.id
JOIN 
    fluxo_caixa.item_pedido ip ON p.id = ip.pedido_id
WHERE 
    c.cpf = '34567890123'
      AND p.data_pedido = '2024-11-23 07:30:00'
GROUP BY 
    p.id, c.cpf, p.data_pedido, p.status;

-- -------------------------------------------------------------------------------------------------------------------

--- Fechar os caixas. Encerramento do mercado é de 19h. 
UPDATE fluxo_caixa.caixa
SET data_fechamento = '2024-12-04 19:00:00'
WHERE numero IN (101, 102, 103, 104, 105, 106);

