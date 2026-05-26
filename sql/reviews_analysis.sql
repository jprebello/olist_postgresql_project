-- Qual a média de review_score dos pedidos?
SELECT ROUND(AVG(review_score), 2) AS avg_review_score
FROM order_reviews;

-- Quais categorias estão entre os pedidos que possuem melhores avaliações?
WITH category_item AS (
    SELECT t1.order_id, t2.product_category_name
    FROM order_items t1
    LEFT JOIN products t2
        ON t1.product_id = t2.product_id
)

SELECT t1.product_category_name, ROUND(AVG(review_score), 2) AS avg_review_score
FROM category_item t1
LEFT JOIN order_reviews t2
    ON t1.order_id = t2.order_id
GROUP BY t1.product_category_name
ORDER BY avg_review_score DESC;
