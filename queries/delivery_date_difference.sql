SELECT oc.customer_state AS State,
CAST(AVG(
    	JULIANDAY(STRFTIME('%Y-%m-%d',order_estimated_delivery_date)) - 
   		JULIANDAY(STRFTIME('%Y-%m-%d',order_delivered_customer_date))) AS INTEGER) AS  Delivery_Difference
FROM olist_customers oc
JOIN olist_orders oo ON oc.customer_id = oo.customer_id
WHERE oo.order_status = 'delivered'
  AND oo.order_delivered_customer_date IS NOT NULL
GROUP BY oc.customer_state
ORDER BY Delivery_Difference;