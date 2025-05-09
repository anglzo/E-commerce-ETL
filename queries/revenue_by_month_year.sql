
WITH aux as
(SELECT oo.order_id AS orderid,
STRFTIME('%m', oo.order_delivered_customer_date) AS month_no,
STRFTIME('%Y', oo.order_delivered_customer_date) AS year,
MIN(oop.payment_value) as minpayment
FROM olist_orders oo
JOIN olist_order_payments oop ON oo.order_id = oop.order_id
WHERE oo.order_status == 'delivered' AND oo.order_delivered_customer_date IS NOT NULL
GROUP BY orderid 
)
SELECT a.month_no,
CASE a.month_no
	   WHEN '01' THEN 'JAN' WHEN '02' THEN 'FEB' WHEN '03' THEN 'MAR' 
	   WHEN '04' THEN 'APR' WHEN '05' THEN 'MAY' WHEN '06' THEN 'JUN'
	   WHEN '07' THEN 'JUL' WHEN '08' THEN 'AUG' WHEN '09' THEN 'SEP'
	   WHEN '10' THEN 'OCT' WHEN '11' THEN 'NOV' WHEN '12' THEN 'DEC' END AS month,
	   IFNULL(SUM(CASE WHEN a.year = '2016' THEN a.minpayment END), '0.0' ) as Year2016,
	   IFNULL(SUM(CASE WHEN a.year = '2017' THEN a.minpayment  END), '0.0' ) as Year2017,
	   IFNULL(SUM(CASE WHEN a.year = '2018' THEN a.minpayment  END), '0.0' ) as Year2018
FROM aux a
GROUP by a.month_no;