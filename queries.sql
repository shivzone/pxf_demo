-- Top 5 products of a specific country (Belgium)

SELECT count(*) AS number_of_purchases, products."product:name" 
FROM products, customers, transactions 
WHERE products.recordkey = transactions.product_id 
AND   customers.customer_id = transactions.customer_id
AND   customers.country = 'Belgium'
GROUP BY products."product:name"
ORDER BY number_of_purchases DESC
LIMIT 5;


-- Top 5 Customers by revenue, who bought items below 50$ 
SELECT customers.first_name|| ' ' || customers.last_name as customer_name, SUM(products."product:price") as revenue
FROM products, customers, transactions
WHERE products.recordkey = transactions.product_id
AND   customers.customer_id = transactions.customer_id
AND   products."product:price" < 50 AND products."product:price" > 30
GROUP BY customers.customer_id, customers.first_name, customers.last_name
ORDER BY revenue DESC 
LIMIT 5;
