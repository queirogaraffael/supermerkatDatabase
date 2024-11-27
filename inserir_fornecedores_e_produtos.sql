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


INSERT INTO controle_estoque.categoria_produto (nome, descricao)
VALUES 
('Alimentos', 'Produtos alimentícios, tanto industrializados quanto frescos, incluindo carnes e laticínios.'),
('Bebidas', 'Bebidas não alcoólicas e desinfetantes.'),
('Higiene Pessoal', 'Produtos de higiene pessoal, incluindo sabonetes, shampoos, e cremes dentais.'),
('Laticínios', 'Produtos lácteos como leite, queijo, manteiga e iogurtes.'),
('Congelados', 'Produtos congelados, como carnes, vegetais e refeições prontas.');


INSERT INTO controle_estoque.produto (categoria_id, nome, codigo_barra, descricao, quantidade_atual, preco_atual)
VALUES
(6, 'Arroz 5kg', '1234567890135', 'Arroz branco 5kg', 100, 0),
(6, 'Feijão 1kg', '1234567890136', 'Feijão carioca 1kg', 80, 0),
(6, 'Açúcar 1kg', '1234567890138', 'Açúcar cristal 1kg', 120, 0),
(6, 'Café Torrado 500g', '1234567890139', 'Café torrado e moído 500g', 200, 0),
(6, 'Macarrão 500g', '1234567890137', 'Macarrão parafuso 500g', 120, 0);


INSERT INTO controle_estoque.produto (categoria_id, nome, codigo_barra, descricao, quantidade_atual, preco_atual)
VALUES
(7, 'Refrigerante 2L', '1234567890140', 'Refrigerante de cola 2L', 150, 0),
(7, 'Suco de Laranja 1L', '1234567890134', 'Suco de laranja natural 1 litro', 150, 0),
(7, 'Cerveja 600ml', '1234567890133', 'Cerveja artesanal 600ml', 200, 0),
(7, 'Água Mineral 500ml', '1234567890142', 'Água mineral 500ml', 300, 0),
(7, 'Vinho Tinto 750ml', '1234567890143', 'Vinho tinto seco 750ml', 100, 0);


INSERT INTO controle_estoque.produto (categoria_id, nome, codigo_barra, descricao, quantidade_atual, preco_atual)
VALUES
(8, 'Shampoo', '1234567890144', 'Shampoo para limpeza dos cabelos', 200, 0),
(8, 'Condicionador', '1234567890145', 'Condicionador hidratante para cabelos', 150, 0),
(8, 'Sabonete Líquido', '1234567890146', 'Sabonete líquido para higiene corporal', 180, 0),
(8, 'Creme Dental', '1234567890147', 'Creme dental para limpeza dos dentes', 250, 0),
(8, 'Fio Dental', '1234567890148', 'Fio dental para higiene bucal', 300, 0);


INSERT INTO controle_estoque.produto (categoria_id, nome, codigo_barra, descricao, quantidade_atual, preco_atual)
VALUES
(9, 'Leite Integral 1L', '1234567890154', 'Leite integral 1 litro', 300, 0),
(9, 'Queijo Mussarela 300g', '1234567890155', 'Queijo mussarela fatiado 300g', 100, 0),
(9, 'Manteiga 200g', '1234567890156', 'Manteiga com sal 200g', 150, 0),
(9, 'Iogurte Natural 170g', '1234567890157', 'Iogurte natural 170g', 250, 0),
(9, 'Requeijão Cremoso 200g', '1234567890158', 'Requeijão cremoso 200g', 200, 0);


INSERT INTO controle_estoque.produto (categoria_id, nome, codigo_barra, descricao, quantidade_atual, preco_atual)
VALUES
(10, 'Pizza Congelada', '1234567890159', 'Pizza congelada de calabresa 500g', 100, 0),
(10, 'Frango Congelado 1kg', '1234567890160', 'Frango congelado 1kg', 150, 0),
(10, 'Legumes Congelados 500g', '1234567890161', 'Mistura de legumes congelados 500g', 200, 0),
(10, 'Hamburguer Congelado 1kg', '1234567890162', 'Hamburguer congelado 1kg', 120, 0),
(10, 'Refeição Pronta Congelada', '1234567890163', 'Refeição pronta congelada 350g', 180, 0);

