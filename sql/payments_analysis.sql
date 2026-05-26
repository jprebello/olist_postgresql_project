-- Quais métodos de pagamento são mais utilizados pelos clientes?
SELECT t2.payment_type, COUNT(DISTINCT(t2.order_id, t2.payment_type)) AS count_payment_type
FROM orders t1
LEFT JOIN order_payments t2
    ON t1.order_id = t2.order_id
WHERE t1.order_status = 'delivered'
GROUP BY t2.payment_type
ORDER BY count_payment_type DESC;
