# SQL Scripts - Postgres

## Descrição
Este repositório contém uma coleção de scripts SQL desenvolvidos para o banco de dados PostgreSQL. Cada script tem uma função específica e deve ser executado em uma ordem predeterminada para garantir que as dependências sejam satisfeitas.

## Estrutura
Abaixo está descrita a ordem de execução e a função de cada script:

1. **`create_supermarket_schemas_and_tables.sql`**
   - Cria os esquemas e tabelas necessárias para o sistema de supermercado.

2. **`inserir_fornecedores_e_produtos.sql`**
   - Insere dados iniciais relacionados a fornecedores e produtos.

3. **`processar_notas_recebimento_produtos.sql`**
   - Processa as notas de recebimento de produtos e atualiza as tabelas relacionadas.

4. **`carga_inicial_fluxo_caixa.sql`**
   - Realiza a carga inicial dos dados de fluxo de caixa.

5. **`gerenciar_caixas_pedidos_estoque.sql`**
   - Gerencia fluxos relacionados a caixas, pedidos de clientes e atualização de estoque.

6. **`dashboards.sql`**
   - Cria as consultas e visões necessárias para gerar dashboards.

## Requisitos
Certifique-se de que os seguintes itens estão configurados no seu ambiente antes de executar os scripts:

- PostgreSQL instalado (versão 12 ou superior recomendada).
- Uma ferramenta de gerenciamento de banco de dados, como pgAdmin ou a CLI do PostgreSQL.
- Acesso ao banco de dados onde os scripts serão executados.

## Como Executar
1. Clone este repositório e navegue até a pasta `sql-scripts`.
2. Conecte-se ao seu banco de dados PostgreSQL.
3. Execute os scripts na ordem descrita:
   1. create_supermarket_schemas_and_tables.sql
   2. inserir_fornecedores_e_produtos.sql
   3. processar_notas_recebimento_produtos.sql
   4. carga_inicial_fluxo_caixa.sql
   5. gerenciar_caixas_pedidos_estoque.sql
   6. dashboards.sql


4. Verifique se cada script foi executado com sucesso antes de prosseguir para o próximo.

## Observações
- Certifique-se de que o banco de dados está vazio ou em um estado esperado antes de executar os scripts.
- O projeto foi projetado para ser executados por passos.
- Algumas consultas precisam ser executadas com o WITH. 
- Para customizações, ajuste os scripts conforme a necessidade antes de executá-los.
- Em caso de erros, consulte a documentação do PostgreSQL ou revise o script correspondente.
