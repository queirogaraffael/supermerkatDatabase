####  **Categoria\_Produto**

* **Atributos:**  
  * **`id` (PK)**  
  * **`nome`**  
  * **`descricao`**  
    ---

    #### **Produto**

* **Atributos:**  
  * **`id` (PK)**  
  * **`categoria_id` (FK)**  
  * **`nome`**  
  * **`codigo_barra`**  
  * **`descricao`**  
  * **`quantidade_atual`**  
  * **`preco_atual`**  
    ---

    #### **Histórico\_Preço**

* **Atributos:**  
  * **`id` (PK)**  
  * **`produto_id` (FK)**  
  * **`preco`**  
  * **`data_inicial`**  
  * **`data_final`**  
  * **`descricao`**  
    ---

    #### **Fornecedor**

* **Atributos:**  
  * **`id` (PK)**  
  * **`nome`**  
  * **`cnpj`**  
  * **`descricao`**  
    ---

    #### **Nota\_Fiscal**

* **Atributos:**  
  * **`id` (PK)**  
  * **`fornecedor_id` (FK)**  
  * **`data_nota`**  
  * **`valor_total`**  
  * **`data_pagamento`**  
  * **`tipo_pagamento`**  
    ---

    #### **NotaFiscal\_Produto**

* **Atributos:**  
  * **`id` (PK)**  
  * **`notafiscal_id` (FK)**  
  * **`produto_id` (FK)**  
  * **`quantidade_produto`**  
  * **`valor_unitario`**  
    ---

    #### **Cliente**

* **Atributos:**  
  * **`id` (PK)**  
  * **`nome`**  
  * **`cpf`**  
  * **`email`**  
  * **`rua`**  
  * **`numero`**  
  * **`bairro`**  
  * **`cidade`**  
    ---

    #### **Telefone\_Cliente**

* **Atributos:**  
  * **`id` (PK)**  
  * **`cliente_id(FK)`**  
  * **`ddd`**  
  * **`numero`**  
    ---

    #### **Funcionário**

* **Atributos:**  
  * **`id` (PK)**  
  * **`nome`**  
  * **`cpf`**  
  * **`salario`**  
  * **`email`**  
  * **`rua`**  
  * **`numero`**  
  * **`bairro`**   
  * **`cidade`**  
    ---

    #### **Telefone\_Funcionário**

* **Atributos:**  
  * **`id` (PK)**  
  * **`funcionario_id` (FK)**  
  * **`ddd`**  
  * **`numero`**  
    ---

    #### **Caixa**

* **Atributos:**  
  * **`id` (PK)**  
  * **`funcionario_id` (FK)**  
  * **`numero`**  
  * **`status`**  
  * **`data_abertura`**  
  * **`data_fechamento`**  
    ---

    #### **Pedido**

* **Atributos:**  
  * **`id` (PK)**  
  * **`cliente_id(FK)`**  
  * **`caixa_id(FK)`**  
  * **`data_pedido`**  
  * **`status`**  
  * **`total_pedido`**  
  * **`data_pagamento`**  
  * **`tipo_pagamento`**  
    ---

    #### **Item\_Pedido**

* **Atributos:**  
  * **`produto_id` (FK)**  
  * **`pedido_id(FK)`**  
  * **`quantidade`**  
  * **`preco`**  
    ---

    ### **Relacionamentos**

  **Produto ↔ Categoria\_Produto (1:N)**  
  * **Um produto pertence a uma categoria.**  
    

  **Histórico\_Preço ↔ Produto (N:1)**  
  * **Um registro de histórico de preços pertence a um único produto.**  
    

  **Nota\_Fiscal ↔ Fornecedor (N:1)**  
  * **Uma nota fiscal pertence a um único fornecedor.**  
    

  **NotaFiscal\_Produto ↔ Nota\_Fiscal (N:1)**  
  * **Um registro em NotaFiscal\_Produto pertence a uma única nota fiscal.**  
    

  **NotaFiscal\_Produto ↔ Produto (N:1)**  
  * **Um registro em NotaFiscal\_Produto pertence a um único produto.**  
    

  **Cliente ↔ Telefone\_Cliente (1:N)**  
  * **Um cliente pode ter vários telefones.**  
    

  **Funcionário ↔ Telefone\_Funcionário (1:N)**  
  * **Um funcionário pode ter vários telefones.**  
    

  **Pedido ↔ Cliente (N:1)**  
  * **Um pedido pertence a um único cliente.**  
    

  **Pedido ↔ Caixa (N:1)**  
  * **Um pedido está associado a um único caixa.**  
    

  **Item\_Pedido ↔ Pedido (N:1)**  
  * **Um item de pedido pertence a um único pedido.**  
    

  **Item\_Pedido ↔ Produto (N:1)**  
  * **Um item de pedido está associado a um único produto.**

