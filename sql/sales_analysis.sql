-- Quais estados geram mais vendas no e-commerce?
WITH orders_delivered AS (
    SELECT t1.seller_id
    FROM order_items t1
    LEFT JOIN orders t2
        ON t1.order_id = t2.order_id
    WHERE t2.order_status = 'delivered'
)

SELECT t2.seller_state, COUNT(*) AS total_items_sold
FROM orders_delivered t1
LEFT JOIN sellers t2
    ON t1.seller_id = t2.seller_id
GROUP BY t2.seller_state
ORDER BY total_items_sold DESC;

-- Quais categorias de produtos geram mais receita?
WITH orders_delivered AS (
    SELECT t1.product_id, t1.price
    FROM order_items t1
    LEFT JOIN orders t2
        ON t1.order_id = t2.order_id
    WHERE order_status = 'delivered'
)

SELECT t2.product_category_name AS category, SUM(t1.price) AS revenue
FROM orders_delivered t1
LEFT JOIN products t2
    ON t1.product_id = t2.product_id
GROUP BY t2.product_category_name
ORDER BY revenue DESC;

-- Como a receita evoluiu ao longo dos meses?
SELECT SUM(price) AS revenue, EXTRACT(MONTH FROM t2.order_delivered_customer_date) AS month, EXTRACT(YEAR FROM t2.order_delivered_customer_date) AS year
FROM order_items t1
LEFT JOIN orders t2
    ON t1.order_id = t2.order_id
WHERE order_status = 'delivered'
GROUP BY year, month
ORDER BY year, month ASC;
