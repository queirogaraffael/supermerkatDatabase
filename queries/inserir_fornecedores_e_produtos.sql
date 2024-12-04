-- Adicionar 10 fornecedores, sendo pelo menos 2 deles fornecendo produtos da mesma categoria.
-- Diversifica os fornecedores do supermercado
INSERT INTO controle_estoque.fornecedor (nome, cnpj, descricao)
VALUES 
('Supermercado ABC', '12345678000195', 'Fornecedor de produtos alimentícios e bebidas'),
('Produtos de Casa', '23456789000167', 'Fornecedor de produtos de limpeza e higiene'),
('Mercado do Povo', '34567890000138', 'Fornecedor de alimentos e itens para casa'),
('Tudo em Supermercado', '45678901234567', 'Fornecedor de alimentos, bebidas e produtos de supermercado'),
('Casa da Limpeza', '56789012345678', 'Fornecedor de produtos de limpeza e cuidados pessoais'),
('Açougue & Cia', '67890123456789', 'Fornecedor de carnes e produtos alimentícios frescos'),
('Distribuidora Sul', '78901234567890', 'Fornecedor de alimentos e itens de supermercado'),
('Supermercado Maria', '89012345678901', 'Fornecedor de alimentos e bebidas de supermercado'),
('Higiene Plus', '90123456789012', 'Fornecedor de produtos de higiene e limpeza'),
('Laticínios Sabor', '01234567890123', 'Fornecedor de laticínios e alimentos frescos');

-- Visualiza fornecedores cadastrados
SELECT * FROM controle_estoque.fornecedor

-- Adiciona categorias para produtos
INSERT INTO controle_estoque.categoria_produto (nome, descricao)
VALUES 
('Alimentos', 'Produtos alimentícios, tanto industrializados quanto frescos, incluindo carnes e laticínios.'),
('Bebidas', 'Bebidas não alcoólicas e desinfetantes.'),
('Higiene Pessoal', 'Produtos de higiene pessoal, incluindo sabonetes, shampoos, e cremes dentais.'),
('Laticínios', 'Produtos lácteos como leite, queijo, manteiga e iogurtes.'),
('Congelados', 'Produtos congelados, como carnes, vegetais e refeições prontas.');

-- Visualiza categorias de produtos
SELECT * FROM controle_estoque.categoria_produto

-- Adiciona produtos da categoria de Alimentos
INSERT INTO controle_estoque.produto (categoria_id, nome, codigo_barra, descricao, quantidade_atual, preco_atual)
VALUES
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Alimentos'), 'Arroz 5kg', '1234567890135', 'Arroz branco 5kg', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Alimentos'), 'Feijão 1kg', '1234567890136', 'Feijão carioca 1kg', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Alimentos'), 'Açúcar 1kg', '1234567890138', 'Açúcar cristal 1kg', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Alimentos'), 'Café Torrado 500g', '1234567890139', 'Café torrado e moído 500g', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Alimentos'), 'Macarrão 500g', '1234567890137', 'Macarrão parafuso 500g', 0, 0);

-- Visualiza produtos da categoria de Alimentos
SELECT 
	p.id AS id_produto,
	p.nome AS nome_produto
FROM 
    controle_estoque.produto AS p
INNER JOIN 
    controle_estoque.categoria_produto AS c
ON 
    p.categoria_id = c.id
WHERE c.nome = 'Alimentos';

-- Adiciona produtos da categoria de Bebidas
INSERT INTO controle_estoque.produto (categoria_id, nome, codigo_barra, descricao, quantidade_atual, preco_atual)
VALUES
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Bebidas'), 'Refrigerante 2L', '1234567890140', 'Refrigerante de cola 2L', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Bebidas'), 'Suco de Laranja 1L', '1234567890134', 'Suco de laranja natural 1 litro', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Bebidas'), 'Cerveja 600ml', '1234567890133', 'Cerveja artesanal 600ml', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Bebidas'), 'Água Mineral 500ml', '1234567890142', 'Água mineral 500ml', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Bebidas'), 'Vinho Tinto 750ml', '1234567890143', 'Vinho tinto seco 750ml', 0, 0);

-- Visualiza produtos da categoria de Bebidas
SELECT 
	p.id AS id_produto,
	p.nome AS nome_produto
FROM 
    controle_estoque.produto AS p
INNER JOIN 
    controle_estoque.categoria_produto AS c
ON 
    p.categoria_id = c.id
WHERE c.nome = 'Bebidas';

-- Adiciona produtos da categoria de Higiene Pessoal
INSERT INTO controle_estoque.produto (categoria_id, nome, codigo_barra, descricao, quantidade_atual, preco_atual)
VALUES
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Higiene Pessoal'), 'Shampoo', '1234567890144', 'Shampoo para limpeza dos cabelos', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Higiene Pessoal'), 'Condicionador', '1234567890145', 'Condicionador hidratante para cabelos', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Higiene Pessoal'), 'Sabonete Líquido', '1234567890146', 'Sabonete líquido para higiene corporal', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Higiene Pessoal'), 'Creme Dental', '1234567890147', 'Creme dental para limpeza dos dentes', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Higiene Pessoal'), 'Fio Dental', '1234567890148', 'Fio dental para higiene bucal', 0, 0);

-- Visualiza produtos da categoria de Higiene Pessoal
SELECT 
	p.id AS id_produto,
	p.nome AS nome_produto
FROM 
    controle_estoque.produto AS p
INNER JOIN 
    controle_estoque.categoria_produto AS c
ON 
    p.categoria_id = c.id
WHERE c.nome = 'Higiene Pessoal';

-- Adiciona produtos da categoria de Laticínios
INSERT INTO controle_estoque.produto (categoria_id, nome, codigo_barra, descricao, quantidade_atual, preco_atual)
VALUES
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Laticínios'), 'Leite Integral 1L', '1234567890154', 'Leite integral 1 litro', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Laticínios'), 'Queijo Mussarela 300g', '1234567890155', 'Queijo mussarela fatiado 300g', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Laticínios'), 'Manteiga 200g', '1234567890156', 'Manteiga com sal 200g', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Laticínios'), 'Iogurte Natural 170g', '1234567890157', 'Iogurte natural 170g', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Laticínios'), 'Requeijão Cremoso 200g', '1234567890158', 'Requeijão cremoso 200g', 0, 0);

-- Visualiza produtos da categoria de Laticínios
SELECT 
	p.id AS id_produto,
	p.nome AS nome_produto
FROM 
    controle_estoque.produto AS p
INNER JOIN 
    controle_estoque.categoria_produto AS c
ON 
    p.categoria_id = c.id
WHERE c.nome = 'Laticínios';

-- Adiciona produtos da categoria de Congelados
INSERT INTO controle_estoque.produto (categoria_id, nome, codigo_barra, descricao, quantidade_atual, preco_atual)
VALUES
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Congelados'), 'Pizza Congelada', '1234567890159', 'Pizza congelada de calabresa 500g', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Congelados'), 'Frango Congelado 1kg', '1234567890160', 'Frango congelado 1kg', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Congelados'), 'Legumes Congelados 500g', '1234567890161', 'Mistura de legumes congelados 500g', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Congelados'), 'Hamburguer Congelado 1kg', '1234567890162', 'Hamburguer congelado 1kg', 0, 0),
((SELECT id FROM controle_estoque.categoria_produto WHERE nome = 'Congelados'), 'Refeição Pronta Congelada', '1234567890163', 'Refeição pronta congelada 350g', 0, 0);

-- Visualiza produtos da categoria de Congelados
SELECT 
	p.id AS id_produto,
	p.nome AS nome_produto
FROM 
    controle_estoque.produto AS p
INNER JOIN 
    controle_estoque.categoria_produto AS c
ON 
    p.categoria_id = c.id
WHERE c.nome = 'Congelados';
