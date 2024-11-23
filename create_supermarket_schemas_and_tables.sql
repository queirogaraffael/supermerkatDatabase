
COMMENT ON DATABASE postgres
    IS 'default administrative connection database';

CREATE SCHEMA IF NOT EXISTS controle_estoque
    AUTHORIZATION postgres;


CREATE SCHEMA IF NOT EXISTS fluxo_caixa
    AUTHORIZATION postgres;


DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'status_pedido_enum') THEN
        CREATE TYPE fluxo_caixa.status_pedido_enum AS ENUM ('CRIADO', 'EM PROCESSAMENTO', 'PAGO', 'CANCELADO', 'CONCLUIDO');
    END IF;
END $$;


DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'tipo_pagamento_enum') THEN
        CREATE TYPE tipo_pagamento_enum AS ENUM ('PIX', 'CARTAO', 'DINHEIRO');
    END IF;
END $$;


CREATE TABLE IF NOT EXISTS controle_estoque.categoria_produto(
	
	id SERIAL NOT NULL PRIMARY KEY,
	
	nome VARCHAR(50) NOT NULL UNIQUE,
	descricao VARCHAR(255) NOT NULL
);


CREATE TABLE IF NOT EXISTS controle_estoque.produto (
	
	id SERIAL NOT NULL PRIMARY KEY,
	
	categoria_id INT NOT NULL,
	
	nome VARCHAR(100) NOT NULL,
	codigo_barra VARCHAR(13) NOT NULL UNIQUE,
	descricao VARCHAR(255) NOT NULL,
	quantidade_atual INT NOT NULL ,
	preco_atual DECIMAL(10,2) NOT NULL,
	
	FOREIGN KEY (categoria_id) REFERENCES controle_estoque.categoria_produto(id)
);


CREATE TABLE IF NOT EXISTS controle_estoque.historico_preco (
	
	id SERIAL NOT NULL PRIMARY KEY,
	
	produto_id INT NOT NULL,
	
	preco DECIMAL(10,2) NOT NULL CHECK (preco >= 0),
	data_inicial TIMESTAMP NOT NULL,
	data_final TIMESTAMP NOT NULL CHECK (data_final > data_inicial),
	descricao VARCHAR(255) NOT NULL,
	
	FOREIGN KEY (produto_id) REFERENCES controle_estoque.produto(id) ON DELETE CASCADE
);



CREATE TABLE IF NOT EXISTS controle_estoque.fornecedor (
	
	id SERIAL NOT NULL PRIMARY KEY,
	
	nome VARCHAR(100) NOT NULL,
	cnpj CHAR(14) NOT NULL UNIQUE,
	descricao VARCHAR(255) NOT NULL
);


CREATE TABLE IF NOT EXISTS controle_estoque.nota_fiscal(
	
	id SERIAL NOT NULL PRIMARY KEY,
	
	fornecedor_id INT NOT NULL,
	
	data_nota TIMESTAMP NOT NULL,
	valor_total DECIMAL(12,2) NOT NULL CHECK (valor_total >= 0),
	data_pagamento TIMESTAMP NOT NULL CHECK (data_pagamento >= data_nota),
	tipo_pagamento tipo_pagamento_enum NOT NULL,
	
	FOREIGN KEY (fornecedor_id) REFERENCES controle_estoque.fornecedor(id)
);


CREATE TABLE IF NOT EXISTS controle_estoque.notafiscal_produto(
	
	id SERIAL NOT NULL,
	
	notafiscal_id INT NOT NULL,
	produto_id INT NOT NULL,
	
	quantidade_produto INT NOT NULL,
	valor_unitario DECIMAL(10,2) NOT NULL,

	PRIMARY KEY (notafiscal_id, produto_id),
	
	FOREIGN KEY (notafiscal_id) REFERENCES controle_estoque.nota_fiscal(id),
	FOREIGN KEY (produto_id) REFERENCES controle_estoque.produto(id)
);


CREATE TABLE IF NOT EXISTS fluxo_caixa.cliente(
	
	id SERIAL NOT NULL PRIMARY KEY,
	
	nome VARCHAR(100),
	cpf CHAR(11) NOT NULL UNIQUE,
	email VARCHAR(255) UNIQUE,
	
	rua VARCHAR(150),
	numero VARCHAR(10),
	bairro VARCHAR(100),
	cidade VARCHAR(100)
);


CREATE TABLE IF NOT EXISTS fluxo_caixa.telefone_cliente(
	
	id SERIAL NOT NULL PRIMARY KEY,
	
	cliente_id INT NOT NULL,
	ddd VARCHAR (3) NOT NULL,
	numero VARCHAR(15) NOT NULL,
	
	FOREIGN KEY (cliente_id) REFERENCES fluxo_caixa.cliente(id)
);


CREATE TABLE IF NOT EXISTS fluxo_caixa.funcionario(
	
	id SERIAL NOT NULL PRIMARY KEY,
	
	nome VARCHAR(100) NOT NULL,
	cpf CHAR(11) NOT NULL UNIQUE,
	salario DECIMAL(10,2) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE,
	
	rua VARCHAR(150) NOT NULL,
	numero VARCHAR(10) NOT NULL,
	bairro VARCHAR(100) NOT NULL,
	cidade VARCHAR(100) NOT NULL
);


CREATE TABLE IF NOT EXISTS fluxo_caixa.telefone_funcionario(
	
	id SERIAL NOT NULL PRIMARY KEY,
	
	funcionario_id INT NOT NULL,
	ddd VARCHAR (3) NOT NULL,
	numero VARCHAR(15) NOT NULL,
	
	FOREIGN KEY (funcionario_id) REFERENCES fluxo_caixa.funcionario(id)
);


CREATE TABLE IF NOT EXISTS fluxo_caixa.caixa(
	
	id SERIAL NOT NULL PRIMARY KEY,
	
	funcionario_id INT NULL,
	
	numero INT NOT NULL UNIQUE,
	data_abertura TIMESTAMP NOT NULL,
	data_fechamento TIMESTAMP NULL CHECK(data_fechamento IS NULL OR data_fechamento >= data_abertura),
	
	FOREIGN KEY (funcionario_id) REFERENCES fluxo_caixa.funcionario(id) ON DELETE SET NULL
);


CREATE TABLE IF NOT EXISTS fluxo_caixa.pedido(
	
	id SERIAL NOT NULL PRIMARY KEY,
	
	cliente_id INT NOT NULL,
	caixa_id INT NOT NULL,
	
	data_pedido TIMESTAMP NOT NULL,
	status fluxo_caixa.status_pedido_enum NOT NULL,
	total_pedido DECIMAL(10,2) NOT NULL,
	data_pagamento TIMESTAMP,
	tipo_pagamento tipo_pagamento_enum NOT NULL,
	
	FOREIGN KEY(cliente_id) REFERENCES fluxo_caixa.cliente(id),
	FOREIGN KEY (caixa_id) REFERENCES fluxo_caixa.caixa(id)
);


CREATE TABLE IF NOT EXISTS fluxo_caixa.item_pedido (
	
	produto_id INT NOT NULL,
	pedido_id INT NOT NULL,
	
	quantidade INT NOT NULL CHECK (quantidade > 0),
	preco DECIMAL(10,2) NOT NULL CHECK (preco >= 0),
	
	PRIMARY KEY (produto_id, pedido_id),
	FOREIGN KEY (produto_id) REFERENCES controle_estoque.produto(id) ON DELETE CASCADE,
	FOREIGN KEY (pedido_id) REFERENCES fluxo_caixa.pedido(id) ON DELETE CASCADE
);
