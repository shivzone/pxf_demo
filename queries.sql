-- Top 10 products of a specific country (Belgium)

SELECT count(*) AS number_of_purchases, products."product:name" 
FROM products, customers, transactions 
WHERE products.recordkey = transactions.product_id 
AND   customers.customer_id = transactions.customer_id
AND   customers.country = 'Belgium'
GROUP BY products."product:name"
ORDER BY number_of_purchases DESC
LIMIT 10;



-- Most popular category by country


SELECT category, country, b.max_cat_per_country FROM
(
selECT
max(count_cate_per_country) over(partition by country) as max_cat_per_country,
a.count_cate_per_country,
 category, country FROM (

SELECT count() OVER (PARTITION BY products."category:name", customers.country) AS count_cate_per_country,
row_number() over(partition by products."category:name", customers.country) as rnum_cate_per_country,
customers.country AS country, products."category:name" AS category 
FROM products, customers, transactions
WHERE products.recordkey = transactions.product_id 
AND   customers.customer_id = transactions.customer_id

) a
WHERE a.count_cate_per_country = a.rnum_cate_per_country
) b

WHERE b.max_cat_per_country = b.count_cate_per_country;


-- Top 10 Customers by revenue, who bought items below 50$ 
SELECT customers.first_name|| ' ' || customers.last_name as customer_name, SUM(products."product:price") as revenue
FROM products, customers, transactions
WHERE products.recordkey = transactions.product_id
AND   customers.customer_id = transactions.customer_id
AND   products."product:price" < 50
GROUP BY customers.customer_id, customers.first_name, customers.last_name
ORDER BY revenue DESC 
LIMIT 10;
