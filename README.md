# Projeto de Análise de Vendas da Olist

## Descrição
Este projeto utiliza o dataset da Olist para responder a várias questões de negócio usando consultas SQL no SQLite. Todas as operações foram realizadas utilizando o DBeaver, uma ferramenta gráfica para gestão de bancos de dados.

## Estrutura do Projeto
- `data/`: Contém os arquivos CSV do dataset da Olist.
- `database/`: Contém o banco de dados SQLite após os dados serem carregados.
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
Todas as consultas SQL estão localizadas no arquivo [`olist_sql_queries/queries.sql`(olist_sql_queries/queries.sql). Abaixo estão algumas das principais consultas realizadas:

### Qual o produto mais vendido?

SELECT 
    p.product_id,
    p.product_category_name,
    COUNT(oi.product_id) AS total_sold
FROM 
    order_items oi
JOIN 
    products p ON oi.product_id = p.product_id
GROUP BY 
    p.product_id, p.product_category_name
ORDER BY 
    total_sold DESC
LIMIT 1;

SELECT *
FROM order_items oi RIGHT JOIN products p ON (oi.order_id = p.product_id)  


### Qual a receita mensal?

SELECT 
	SUM(price) AS total_revenue,
	strftime ('%Y-%m', o.order_purchase_timestamp) AS year_month
FROM
	order_items oi INNER JOIN orders o ON oi.order_id = o.order_id
GROUP BY 
	year_month
ORDER BY 
	year_month DESC
	
	
### Quais estados têm os clientes mais fiéis?
	
SELECT
	customer_state,
	COUNT (o.order_id) AS qty_orders
FROM
	orders o INNER JOIN customer c ON o.customer_id = c.customer_id
GROUP BY 
	customer_state
ORDER BY 
	qty_orders DESC 
   
