
-- Cliente que mais comprou
SELECT 
    c.id AS id_cliente,
    c.nome AS nome_cliente,
    SUM(p.total_pedido) AS total_comprado
FROM 
    fluxo_caixa.cliente AS c
INNER JOIN 
    fluxo_caixa.pedido AS p ON c.id = p.cliente_id
GROUP BY 
    c.id, c.nome
ORDER BY 
    total_comprado DESC
LIMIT 1;

-- Caixa que mais vendeu
SELECT 
    cx.id AS id_caixa,
    SUM(p.total_pedido) AS total_vendido
FROM 
    fluxo_caixa.caixa AS cx
INNER JOIN 
    fluxo_caixa.pedido AS p ON cx.id = p.caixa_id
GROUP BY 
    cx.id
ORDER BY 
    total_vendido DESC
LIMIT 1;

-- Categoria que mais vendeu
SELECT 
    cp.nome AS categoria,
    SUM(ip.quantidade * ip.preco) AS total_vendido
FROM 
    fluxo_caixa.item_pedido ip
JOIN 
    controle_estoque.produto p ON ip.produto_id = p.id
JOIN 
    controle_estoque.categoria_produto cp ON p.categoria_id = cp.id
GROUP BY 
    cp.nome
ORDER BY 
    total_vendido DESC
LIMIT 1;


-- Qual levou mais produtos
SELECT 
    c.nome AS cliente,
    c.cpf,
    SUM(ip.quantidade) AS quantidade_total
FROM 
    fluxo_caixa.item_pedido ip
JOIN 
    fluxo_caixa.pedido p ON ip.pedido_id = p.id
JOIN 
    fluxo_caixa.cliente c ON p.cliente_id = c.id
GROUP BY 
    c.id, c.nome, c.cpf
ORDER BY 
    quantidade_total DESC
LIMIT 1;


-- Produtos mais vendidos
SELECT 
    p.id AS produto_id,
    p.nome AS produto_nome,
    SUM(ip.quantidade) AS total_vendido
FROM 
    fluxo_caixa.item_pedido ip
JOIN 
    controle_estoque.produto p ON ip.produto_id = p.id
GROUP BY 
    p.id, p.nome
ORDER BY 
    total_vendido DESC
LIMIT 3;

-- Contagem dos caixas que estão em aberto e em manutenção
SELECT 
	status,
	COUNT(*) as total
from 
	fluxo_caixa.caixa
group by status;

-- Fornecedor que mais vendeu
select
	f.nome as fornecedor_nome,
	f.id as fornecedor_id,
	SUM(nf.valor_total) as total_vendas
from 
	controle_estoque.fornecedor as f
inner join 
	controle_estoque.nota_fiscal as nf on  f.id = nf.fornecedor_id
group by 
	f.id,f.nome
order by
	total_vendas DESC
LIMIT 1;


-- Tipos de pagamentos mais utilizados
SELECT 
	tipo_pagamento,
	COUNT(*) as total
from 
	fluxo_caixa.pedido
group by
	tipo_pagamento;
