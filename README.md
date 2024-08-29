# Projeto de Análise de Vendas da Olist

## Descrição
Este projeto utiliza o dataset da Olist para responder a várias questões de negócio usando consultas SQL no SQLite. Todas as operações foram realizadas utilizando o DBeaver, uma ferramenta gráfica para gestão de bancos de dados.

## Estrutura do Projeto
- `data/`: Os arquivos CSV do dataset da Olist estão disponíveis na pasta data.
- `queries/`: Contém o arquivo com todas as consultas SQL.
- `README.md`: Documentação do projeto.

## Configuração

### 1. Preparação do Ambiente
1. **Instale o DBeaver**: Você pode baixar o DBeaver [aqui](https://dbeaver.io/download/).
2. **Instale o SQLite**: Para gerenciar o banco de dados SQLite.

### 2. Carregar os Dados no SQLite
1. **Crie um novo banco de dados SQLite no DBeaver**.
2. **Importe os arquivos CSV para o banco de dados**:
    - Vá em `Database > Import Data`.
    - Selecione o arquivo CSV correspondente e siga as instruções para criar uma nova tabela.

### Estrutura das Tabelas

- `customers`
- `geolocation`
- `order_items`
- `order_payments`
- `order_reviews_backup`
- `order_reviews_shorts`
- `order_reviews`
- `orders`
- `product_category_name`
- `products`
- `sellers`

### 3. Consultas SQL
Todas as consultas SQL estão localizadas no arquivo [`olist_sql_queries/queries.sql`]((https://github.com/ramosvinicius/olist_sql_project/blob/main/queries.sql)).

### 4. Relatório Power BI
O arquivo do relatório em Power BI se encontra em  [`olist_sql_queries/relatorio.pbix`]. Aqui você encontra tudo o que eu fiz para essa base de dados.

**Agradeço pela visita, e que você fique a vontade para entrar em contato comigo em minhas redes.**

**Muito obrigado!** 
