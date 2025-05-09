
SELECT  
    PCNT.product_category_name_english AS Category, 
    COUNT(DISTINCT(oo.order_id)) AS Num_order, 
    SUM(OOP.payment_value) AS Revenue
FROM 
    product_category_name_translation PCNT
JOIN olist_products OP ON PCNT.product_category_name = OP.product_category_name
JOIN olist_order_items OOI ON OP.product_id = OOI.product_id
JOIN olist_order_payments OOP ON OOI.order_id = OOP.order_id
JOIN olist_orders oo ON OOI.order_id = oo.order_id
WHERE oo.order_status = 'delivered'  AND oo.order_delivered_customer_date IS NOT NULL
GROUP BY  Category
ORDER BY Revenue ASC
LIMIT 10;