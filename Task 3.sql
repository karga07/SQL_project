---- Task 3 ----
----- diference in prices annualy ----
SELECT 
	product_name,
	avg_product_price,
	year_product,
	previous_price,
	(avg_product_price - previous_price)/previous_price AS difference1
	FROM( 
		SELECT *,
			LAG(AVG(avg_product_price), 1) OVER (PARTITION BY product_name ORDER BY product_name, year_product) AS previous_price
			FROM t_Karolina_Gajduskova_project_SQL_primary_final tkgpspf  
			GROUP BY product_name, year_product) AS subquery1
	WHERE (avg_product_price - previous_price)/previous_price IS NOT NULL
	ORDER BY difference1 ASC;

---- differences in price over the whole period  -----

SELECT 
	product_name,
	SUM(difference1)
FROM(
	SELECT *,
		(avg_product_price - previous_price)/previous_price AS difference1
	FROM( 
		SELECT *,
		LAG(AVG(avg_product_price), 1) OVER (ORDER BY product_name, year_product) AS previous_price
		FROM t_Karolina_Gajduskova_project_SQL_primary_final tkgpspf 
		GROUP BY product_name, year_product) AS subquery1
	WHERE year_product > 2006
	ORDER BY difference1 ASC) AS subquery2
GROUP BY product_name
ORDER BY SUM(difference1) ASC;
