-- O dono do mercado decidiu comprar alguns produtos para começar a operar. 
-- Para isso, escolheu dois grandes fornecedores.
INSERT INTO controle_estoque.nota_fiscal (fornecedor_id, data_nota, valor_total, data_pagamento, tipo_pagamento)
VALUES
    ((SELECT id FROM controle_estoque.fornecedor WHERE cnpj = '12345678000195'), '2024-11-20 09:30:00', 0.0, '2024-11-20 10:00:00', 'PIX'),
    ((SELECT id FROM controle_estoque.fornecedor WHERE cnpj = '01234567890123'), '2024-11-20 09:30:00', 0.0, '2024-11-20 10:00:00', 'DINHEIRO');

-- Visualizar notas fiscais criadas
SELECT * FROM controle_estoque.nota_fiscal WHERE data_nota = '2024-11-20 09:30:00';

-- -----------------------------------------------------------------------------------------------------------

-- Fornecedor 1
WITH NotaFiscalID_1 AS ( -- OBS: Algumas consultas precisam rodar em conjunto com NotaFiscalID_1
    SELECT 
        nf.id AS nota_fiscal_id
    FROM 
        controle_estoque.nota_fiscal nf
    JOIN 
        controle_estoque.fornecedor f
    ON 
        nf.fornecedor_id = f.id
    WHERE 
        f.cnpj = '12345678000195'
        AND nf.data_nota = '2024-11-20 09:30:00' 
    LIMIT 1
)
	
-- Passo 1: Insere os produtos na nota fiscal. OBS: Precisa ser rodada com o WITH NotaFiscalID_1
INSERT INTO controle_estoque.notafiscal_produto (notafiscal_id, produto_id, quantidade_produto, valor_unitario) 
VALUES
 ((SELECT nota_fiscal_id FROM NotaFiscalID_1), 
  (SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890154'), 100, 5.50), -- Leite Integral 1L

 ((SELECT nota_fiscal_id FROM NotaFiscalID_1), 
  (SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890155'), 50, 122.00),

 ((SELECT nota_fiscal_id FROM NotaFiscalID_1), 
  (SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890156'), 200, 3.50),

 ((SELECT nota_fiscal_id FROM NotaFiscalID_1), 
  (SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890157'), 200, 3.50),

 ((SELECT nota_fiscal_id FROM NotaFiscalID_1), 
  (SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890158'), 200, 5.50); 

SELECT -- Visualiza produtos 
    p.nome AS nome_produto,
    nfp.quantidade_produto,
    nfp.valor_unitario,
    (nfp.quantidade_produto * nfp.valor_unitario) AS preco_total
FROM 
    controle_estoque.notafiscal_produto nfp
JOIN 
    controle_estoque.produto p ON p.id = nfp.produto_id
WHERE 
    nfp.notafiscal_id = (SELECT nota_fiscal_id FROM NotaFiscalID_1);

UPDATE controle_estoque.nota_fiscal -- Passo 2: Atualiza o preço total da nota fiscal. OBS: Precisa ser rodada com o WITH NotaFiscalID_1
SET valor_total = (
    SELECT 
        SUM(quantidade_produto * valor_unitario)
    FROM 
        controle_estoque.notafiscal_produto
    WHERE 
        notafiscal_id = (SELECT nota_fiscal_id FROM NotaFiscalID_1)
)
WHERE id = (SELECT nota_fiscal_id FROM NotaFiscalID_1);

SELECT valor_total -- Visualiza valor total
FROM controle_estoque.nota_fiscal
WHERE id = (SELECT nota_fiscal_id FROM NotaFiscalID_1);

UPDATE controle_estoque.produto -- Passo 2: Atualiza o estoque dos produtos
SET quantidade_atual = quantidade_atual + (
    SELECT COALESCE(SUM(nfp.quantidade_produto), 0)
    FROM controle_estoque.notafiscal_produto nfp
    WHERE nfp.produto_id = controle_estoque.produto.id
      AND nfp.notafiscal_id = (SELECT nota_fiscal_id FROM NotaFiscalID_1)
)
WHERE id IN (
    SELECT nfp.produto_id
    FROM controle_estoque.notafiscal_produto nfp
    WHERE nfp.notafiscal_id = (SELECT nota_fiscal_id FROM NotaFiscalID_1)
);

SELECT * -- Passo 3 Visualiza a nota fiscal final. OBS: Precisa ser rodada com o WITH NotaFiscalID_1
FROM controle_estoque.nota_fiscal 
WHERE id = (SELECT nota_fiscal_id FROM NotaFiscalID_1);

-- -----------------------------------------------------------------------------------------------------------

-- Fornecedor 2
WITH NotaFiscalID_2 AS ( -- OBS: Algumas consultas precisam rodar em conjunto com NotaFiscalID_2
    SELECT 
        nf.id AS nota_fiscal_id
    FROM 
        controle_estoque.nota_fiscal nf
    JOIN 
        controle_estoque.fornecedor f ON nf.fornecedor_id = f.id
    WHERE 
        f.cnpj = '01234567890123'
        AND nf.data_nota = '2024-11-20 09:30:00'
    LIMIT 1
) -- Passo 1: Insere produtos na nota fiscal. OBS: Precisa ser rodada com o WITH NotaFiscalID_2
INSERT INTO controle_estoque.notafiscal_produto (notafiscal_id, produto_id, quantidade_produto, valor_unitario)
VALUES
 ((SELECT nota_fiscal_id FROM NotaFiscalID_2), -- Os ids dos produtos são buscados de acordo com seus codigos de barra
  (SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890154'), 200, 5.00), -- Leite Integral 1L
 ((SELECT nota_fiscal_id FROM NotaFiscalID_2), 
  (SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890155'), 100, 120.00), -- Queijo Mussarela 
 ((SELECT nota_fiscal_id FROM NotaFiscalID_2), 
  (SELECT id FROM controle_estoque.produto WHERE codigo_barra = '1234567890158'), 300, 5.00); -- Requeijão Cremoso

SELECT -- Passo 2: Visualiza produtos 
    p.nome AS nome_produto,
    nfp.quantidade_produto,
    nfp.valor_unitario,
    (nfp.quantidade_produto * nfp.valor_unitario) AS preco_total
FROM 
    controle_estoque.notafiscal_produto nfp
JOIN 
    controle_estoque.produto p ON p.id = nfp.produto_id
WHERE 
    nfp.notafiscal_id = (SELECT nota_fiscal_id FROM NotaFiscalID_2);

SELECT -- Passo 3: Visualiza produto. OBS: Precisa ser rodada com o WITH NotaFiscalID_2
    p.nome AS produto_nome
FROM 
    controle_estoque.notafiscal_produto nfp
JOIN 
    controle_estoque.produto p ON nfp.produto_id = p.id
WHERE 
    nfp.notafiscal_id = (SELECT nota_fiscal_id FROM NotaFiscalID_2);

UPDATE controle_estoque.nota_fiscal -- Passo 4: Atualiza o valor total da nota fiscal. OBS: Precisa ser rodada com o WITH NotaFiscalID_2
SET valor_total = (
    SELECT SUM(nfp.quantidade_produto * nfp.valor_unitario)
    FROM controle_estoque.notafiscal_produto nfp
    WHERE nfp.notafiscal_id = (SELECT nota_fiscal_id FROM NotaFiscalID_2)
)
WHERE id = (SELECT nota_fiscal_id FROM NotaFiscalID_2);

SELECT valor_total -- Passo 5: Visualiza valor total
FROM controle_estoque.nota_fiscal
WHERE id = (SELECT nota_fiscal_id FROM NotaFiscalID_2);

UPDATE controle_estoque.produto -- Passo 6: Atualiza o estoque dos produtos. OBS: Precisa ser rodada com o WITH NotaFiscalID_2
SET quantidade_atual = quantidade_atual + (
    SELECT COALESCE(SUM(nfp.quantidade_produto), 0)
    FROM controle_estoque.notafiscal_produto nfp
    WHERE nfp.produto_id = controle_estoque.produto.id
      AND nfp.notafiscal_id = (SELECT nota_fiscal_id FROM NotaFiscalID_2)
)
WHERE id IN (
    SELECT nfp.produto_id
    FROM controle_estoque.notafiscal_produto nfp
    WHERE nfp.notafiscal_id = (SELECT nota_fiscal_id FROM NotaFiscalID_2)
);


-- -----------------------------------------------------------------------------------------------------------

-- Atualiza o preço atual de cada produto no estoque. Ela calcula o preço médio dos produtos 
-- com base nos valores registrados nas notas fiscais acima e em seguida aplica um aumento de 30% sobre o valor. 
-- O preço é atualizado apenas para os produtos que já foram registrados nas notas fiscais.
UPDATE controle_estoque.produto
SET preco_atual = (
    SELECT 
        (SUM(nfp.valor_unitario * nfp.quantidade_produto) / SUM(nfp.quantidade_produto)) * 1.30
    FROM 
        controle_estoque.notafiscal_produto nfp
    WHERE 
        nfp.produto_id = controle_estoque.produto.id
)
WHERE id IN (
    SELECT DISTINCT produto_id
    FROM controle_estoque.notafiscal_produto
);

-- Salva os preços dos produtos em um historico.
INSERT INTO controle_estoque.historico_preco (produto_id, preco, data_inicial, data_final, descricao)
SELECT 
    id AS produto_id,
    preco_atual AS preco,
    CURRENT_TIMESTAMP AS data_inicial,
    CURRENT_TIMESTAMP AS data_final, 
    'Salva preços iniciais para criação de promoção de abertura' AS descricao
FROM 
    controle_estoque.produto
WHERE 
    preco_atual > 0.00;

-- Resolvendo criar uma promoção de abertura, o mercado resolveu criar um promoção
-- de 15% nos preços de todos os produtos em estoque. 
UPDATE controle_estoque.produto
SET preco_atual = preco_atual * 0.85
WHERE preco_atual > 0;
