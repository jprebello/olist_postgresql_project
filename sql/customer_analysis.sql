-- Quais estados possuem o maior volume de compras no e-commerce?
WITH orders_delivered AS (
    SELECT t2.customer_id
    FROM order_items t1
    LEFT JOIN orders t2
        ON t1.order_id = t2.order_id
    WHERE t2.order_status = 'delivered'
)

SELECT t2.customer_state AS state, COUNT(*) AS total_items_purchased 
FROM orders_delivered t1
LEFT JOIN customers t2
    ON t1.customer_id = t2.customer_id
GROUP BY t2.customer_state
ORDER BY total_items_purchased DESC;

-- A receita do e-commerce está concentrada em poucos clientes?
WITH customer_revenue AS (
	SELECT t2.customer_id, SUM(t1.price) AS revenue 
	FROM order_items t1
	LEFT JOIN orders t2
	    ON t1.order_id = t2.order_id
	WHERE t2.order_status = 'delivered'
	GROUP BY t2.customer_id
	ORDER BY revenue DESC
), rel_freq AS (
    SELECT customer_id, revenue, revenue * 100.0 / SUM(revenue) OVER () AS freq
    FROM customer_revenue
)

SELECT *, SUM(freq) OVER (ORDER BY freq DESC) AS cum_freq
FROM rel_freq;
