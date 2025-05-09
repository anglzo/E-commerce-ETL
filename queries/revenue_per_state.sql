
WITH aux as
(SELECT oo.customer_id  as customers, SUM(oop.payment_value) as revenue_pp
FROM olist_orders oo , olist_order_payments oop
WHERE oop.order_id = oo.order_id
GROUP BY  oo.order_id 
HAVING oo.order_status == 'delivered' AND oo.order_delivered_customer_date IS NOT NULL)
SELECT oc.customer_state AS customer_state, SUM(a.revenue_pp) as Revenue
FROM olist_customers oc, aux a
WHERE  a.customers = oc.customer_id
GROUP BY oc.customer_state
ORDER BY revenue DESC
LIMIT 10;