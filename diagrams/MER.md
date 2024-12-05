#### **MER (SUPERMERKATE\_DATABASE)**

---

#### **Fornecedor**

* **Atributos:**  
  * **`id` (PK)**  
  * **`Nome`**  
  * **`Cnpj`**  
  * **`Descrição`**

    

---

#### **Nota Fiscal**

* **Atributos:**  
  * **`id` (PK)**  
  * **`Data de emissão`**  
  * **`Valor total`**  
  * **`Data de pagamento`**  
  * **`Tipo de pagamento`**

---

#### **Produto**

* **Atributos:**  
  * **`id` (PK)**  
  * **`Nome`**  
  * **`Código de barra`**  
  * **`Descrição`**  
  * **`Quantidade`**  
  * **`Preço`**

---

#### **Histórico de Preço**

* **Atributos:**  
  * **`id` (PK)**  
  * **`Preço`**  
  * **`Data inicial`**  
  * **`Data final`**  
  * **`Descrição`**

---

####  **Categoria do Produto**

* **Atributos:**  
  * **`id` (PK)**  
  * **`Nome`**  
  * **`Descrição`**

---

#### **Pedido**

* **Atributos:**  
  * **`id` (PK)**  
  * **`Data do pedido`**  
  * **`Status`**  
  * **`Valor total`**  
  * **`Data de pagamento`**  
  * **`Tipo de pagamento`**

---

#### **Caixa**

* **Atributos:**  
  * **`id` (PK)**  
  * **`Número`**  
  * **`Status`**  
  * **`Data de abertura`**  
  * **`Data de fechamento`**

---

#### **Funcionário**

* **Atributos:**  
  * **`id` (PK)**  
  * **`Nome`**  
  * **`Cpf`**  
  * **`Salário`**  
  * **`Email`**  
  * **`Rua`**  
  * **`Número`**  
  * **`Bairro`**   
  * **`Cidade`**

---

#### **Telefone do Funcionário**

* **Atributos:**  
  * **`id` (PK)**  
  * **`DDD`**  
  * **`Número`**

---

#### **Cliente**

* **Atributos:**  
  * **`id` (PK)**  
  * **`Nome`**  
  * **`Cpf`**  
  * **`Email`**  
  * **`Rua`**  
  * **`Número`**  
  * **`Bairro`**  
  * **`Cidade`**

---

#### **Telefone do Cliente**

* **Atributos:**  
  * **`id` (PK)**  
  * **`DDD`**  
  * **`Número`**

---

### **Relacionamentos**


1. **A entidade Fornecedor se relaciona com a entidade Nota Fiscal.**

2. **A entidade Nota Fiscal se relaciona com a entidade Produto.**

3. **A entidade Produto se relaciona com a entidade Histórico de Preço.**

4. **A entidade Produto se relaciona com a entidade Categoria de Produto.**

5. **A entidade Produto se relaciona com a entidade Pedido.**

6. **A entidade Pedido se relaciona com a entidade Caixa.**

7. **A entidade Pedido se relaciona com a entidade Cliente.**

8. **A entidade Caixa se relaciona com a entidade Histórico de Funcionario.**

9. **A entidade Funcionario se relaciona com a entidade Histórico de Telefone do funcionario.**

10. **A entidade Cliente se relaciona com a entidade Telefone do Cliente.**

