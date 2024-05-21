-- Qual o produto mais vendido?

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


-- Qual a receita mensal?

SELECT 
	SUM(price) AS total_revenue,
	strftime ('%Y-%m', o.order_purchase_timestamp) AS year_month
FROM
	order_items oi INNER JOIN orders o ON oi.order_id = o.order_id
GROUP BY 
	year_month
ORDER BY 
	year_month DESC
	
	
-- Quais estados têm os clientes mais fiéis?
	
SELECT
	customer_state,
	COUNT (o.order_id) AS qty_orders
FROM
	orders o INNER JOIN customer c ON o.customer_id = c.customer_id
GROUP BY 
	customer_state
ORDER BY 
	qty_orders DESC 
	
-- Qual é o temppo médio de entrega?
	
SELECT 
    AVG(JULIANDAY(o.order_delivered_customer_date) - JULIANDAY(o.order_purchase_timestamp)) AS avg_delivery_time
FROM 
    orders o
WHERE 
    o.order_status = 'delivered';	

-- Quem são os Top 10 em vendas? 

SELECT
	oi.seller_id,
	COUNT(DISTINCT order_id) AS sales_qty
FROM  order_items oi JOIN sellers s ON oi.seller_id = s.seller_id 
GROUP BY oi.seller_id
ORDER BY sales_qty DESC 
LIMIT 10


-- Que tipo produtos eles vendem?

SELECT
	oi.seller_id,
	COUNT(DISTINCT order_id) AS sales_qty,
	p.product_category_name AS category
FROM  
	order_items oi JOIN products p  ON oi.product_id = p.product_id 
GROUP BY 
	oi.seller_id
ORDER BY 
	sales_qty DESC 
LIMIT 10


-- Qual é o impacto deles para o negócio?

WITH order_quantities AS (
    SELECT
        order_id,
        COUNT(*) AS total_items
    FROM
        order_items
    GROUP BY
        order_id
),
top_sellers AS (
    SELECT
        oi.seller_id,
        SUM(oi.price * oq.total_items) AS seller_revenue
    FROM
        order_items oi
    JOIN
        order_quantities oq ON oi.order_id = oq.order_id
    JOIN
        products p ON oi.product_id = p.product_id
    GROUP BY
        oi.seller_id
    ORDER BY
        seller_revenue DESC
    LIMIT 10
),
total_revenue AS (
    SELECT
        SUM(oi.price * oq.total_items) AS total_revenue
    FROM
        order_items oi
    JOIN
        order_quantities oq ON oi.order_id = oq.order_id
)
SELECT
    ts.seller_id,
    ts.seller_revenue,
    tr.total_revenue,
    (ts.seller_revenue / tr.total_revenue) * 100 AS revenue_percentage
FROM
    top_sellers ts,
    total_revenue tr
ORDER BY
    ts.seller_revenue DESC;

   
--------------------------------------------------------------------------

  -- Exercícios respondidos para CASE, WHEN e THEN 
   
-- CASE - WHEN - THEN
SELECT 
	oi.price,
	CASE
		WHEN oi.price <100.0 THEN 'barato'
	ELSE 
		'caro'
	END AS status
FROM
	order_items oi 
LIMIT 10

-- IIF
SELECT 
	oi.price,
	IIF (oi.price > 100.0, 'barato', 'caro') AS STATUS
FROM
	order_items oi 
LIMIT 10

-- CASE WHEN ANINHADO
SELECT 
	oi.price,
	CASE
		WHEN oi.price < 20 THEN 'super_barato'
		WHEN oi.price < 100 THEN 'barato'
		WHEN oi.price > 150 AND oi.price < 180 THEN 'normal'
	END AS status	
FROM 
	order_items oi 
	
--Crie uma consulta que exiba o código do produto e a categoria de cada produto com base no seu preço:

--Preço abaixo de 50 → Categoria A
--Preço entre 50 e 100 → Categoria B
--Preço entre 100 e 500 → Categoria C
--Preço entre 500 e 1500 → Categoria D
--Preço acima de 1500 → Categoria E
	
SELECT 
	oi.price,
	CASE
		WHEN oi.price < 50 THEN 'Categoria A'
		WHEN oi.price < 50 AND oi.price > 100 THEN 'Categoria B'
		WHEN oi.price < 100 AND oi.price > 500 THEN 'Categoria C'
		WHEN oi.price < 500 AND oi.price > 1500 THEN 'Categoria D'
		WHEN oi.price < 1500 THEN 'Categoria E'
	END AS status	
FROM 
	order_items oi 
	
	
-- Calcule a quantidade de produtos para cada uma das categorias criadas no
-- exercícios anterior.
	
SELECT
    Categorias,
    COUNT(*) AS quantidade_produtos
FROM (
    SELECT 
        oi.price,
        CASE
            WHEN oi.price < 50 THEN 'Categoria A'
            WHEN oi.price >= 50 AND oi.price < 100 THEN 'Categoria B'
            WHEN oi.price >= 100 AND oi.price < 500 THEN 'Categoria C'
            WHEN oi.price >= 500 AND oi.price < 1500 THEN 'Categoria D'
            WHEN oi.price >= 1500 THEN 'Categoria E'
        END AS Categorias 	
    FROM 
        order_items oi  
) AS Categorias
GROUP BY
    Categorias;
  
-- Selecione os seguintes categorias de produtos: livros técnicos, pet shop, pc gamer, tablets, impressão imagem, 
-- fashion esports, perfumaria, telefonia, beleza saude, ferramentas jardim.
   
-- Crie uma primeira coluna mostrando o novo preço da categoria, segundo os valores abaixo:
-- Livros técnicos - 10% de desconto
-- Pet shop - 20% de desconto
-- PC gamer - 50% de aumento
-- Tablets - 10% de aumento
-- Fashion Esports - 5% de aumento
   
-- Crie uma segunda coluna mostrando se a categoria sofreu ou não alteração de preço

 SELECT 
    product_category_name,
    CASE 
        WHEN novo_preco <> price THEN 'Alterado' 
        ELSE 'Não alterado' 
    END AS alteracao_preco,
    novo_preco
FROM (
    SELECT 
        product_category_name,
        price,
        CASE 
        WHEN product_category_name IN ('livros_tecnicos') THEN price * 0.9 -- Desconto de 10%
        WHEN product_category_name IN ('pet_shop') THEN price * 0.8 -- Desconto de 20%
        WHEN product_category_name IN ('pc_gamer') THEN price * 1.5 -- Aumento de 50%
        WHEN product_category_name IN ('tablets_impressao_imagem') THEN price * 1.1 -- Aumento de 10%
        WHEN product_category_name IN ('fashion_esporte') THEN price * 1.05 -- Aumento de 10%
        ELSE price -- Não alterar para outras categorias
    END AS novo_preco
    FROM (
        SELECT DISTINCT p.product_category_name, oi.price
        FROM products p 
        INNER JOIN order_items oi ON p.product_id = oi.product_id
        WHERE p.product_category_name IN 
            ('livros_tecnicos', 'pet_shop', 'pc_gamer', 'tablets', 'impressao_imagem', 'fashion_esporte', 'perfumaria',
             'telefonia', 'beleza_saude', 'ferramentas_jardim')
    ) AS categorias_filtradas
) AS precos_alterados;


-- Crie uma coluna que mostra o status de entrega do pedido. Se a coluna estiver vazia, o status é de pendente.
-- “order_delivered_customer_date” - pendente
-- “order_delivered_customer_date” menor que o dia 01 de Junho de 2017 - entregue
-- “order_delivered_customer_date” maior que o dia 01 de Junho de 2017 - programado
SELECT 
	DATE(o.order_delivered_customer_date) AS Data_Entrega,
	status
FROM
	orders o,
	(
	SELECT
	DATE(o.order_delivered_customer_date) AS data_entrega,
	CASE 
		WHEN o.order_delivered_customer_date < '2017-06-01' THEN 'Entregue' 
		WHEN o.order_delivered_customer_date > '2017-06-01' THEN 'Programado'
		ELSE 'Pendente'
	END AS Status
FROM orders o)
WHERE status = 'Pendente'
