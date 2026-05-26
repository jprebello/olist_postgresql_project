-- Qual o tempo médio de entrega dos pedidos aos clientes?
SELECT ROUND(AVG(order_delivered_customer_date - order_approved_at), 2) AS days
FROM orders
WHERE order_status = 'delivered';

-- Qual o percentual de pedidos entregues dentro do prazo estimado?
SELECT ROUND((SUM(CASE WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 1 ELSE 0 END) * 100.0/ COUNT(*)), 2) AS delivered_on_time_percentage
FROM orders
WHERE order_status = 'delivered';
