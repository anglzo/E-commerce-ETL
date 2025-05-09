
SELECT oo.order_status AS order_status, COUNT(*)  as Ammount
FROM olist_orders oo  
GROUP BY oo.order_status
ORDER BY order_status ;