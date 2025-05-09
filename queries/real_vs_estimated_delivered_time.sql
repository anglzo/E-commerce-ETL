
WITH AX AS(
	SELECT order_id,
		   STRFTIME('%m', order_purchase_timestamp) as  month_no,
		   STRFTIME('%Y', order_purchase_timestamp) as  year,
		   JULIANDAY(order_delivered_customer_date  ) - JULIANDAY(order_purchase_timestamp) as real_time, 
		   JULIANDAY(order_estimated_delivery_date  ) - JULIANDAY(order_purchase_timestamp) as estimated_time
		   FROM olist_orders
		   WHERE order_status == 'delivered' AND order_delivered_customer_date IS NOT NULL)
SELECT month_no,
	   CASE month_no
	   WHEN '01' THEN 'JAN' WHEN '02' THEN 'FEB' WHEN '03' THEN 'MAR' 
	   WHEN '04' THEN 'APR' WHEN '05' THEN 'MAY' WHEN '06' THEN 'JUN'
	   WHEN '07' THEN 'JUL' WHEN '08' THEN 'AUG' WHEN '09' THEN 'SEP'
	   WHEN '10' THEN 'OCT' WHEN '11' THEN 'NOV' WHEN '12' THEN 'DEC' END AS month,
	   AVG(CASE WHEN year = '2016' THEN real_time END)as Year2016_real_time, 
	   AVG(CASE WHEN year = '2017' THEN real_time END)as Year2017_real_time,
	   AVG(CASE WHEN year = '2018' THEN real_time END)as Year2018_real_time,
	   AVG(CASE WHEN year = '2016' THEN estimated_time END)as Year2016_estimated_time,
	   AVG(CASE WHEN year = '2017' THEN estimated_time END)as Year2017_estimated_time,
	   AVG(CASE WHEN year = '2018' THEN estimated_time END)as Year2018_estimated_time
	   FROM AX
	   GROUP BY month_no 
	   ORDER BY month_no;