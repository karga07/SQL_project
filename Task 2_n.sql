---- Task 2 -----
---- help table 1 -----
CREATE VIEW kg_1 AS
	SELECT 
		payroll_year,
		AVG(avg_value_income) AS avg_income
	FROM t_Karolina_Gajduskova_project_SQL_primary_final tkgpspf
	WHERE payroll_year IN (2006, 2018)
	GROUP BY payroll_year;

--- help table 2 -----

CREATE VIEW kg_2 AS 
	SELECT DISTINCT
		year_product,
		product_name,
		avg_product_price 
	FROM t_Karolina_Gajduskova_project_SQL_primary_final tkgpspf
	WHERE 1=1
	AND year_product IN (2006, 2018)
	AND product_name IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované');

----- results ----

SELECT *,
	(avg_income/avg_product_price) AS amount_of_goods
FROM (
	SELECT * 
	FROM kg_2 
	LEFT JOIN kg_1 
	ON kg_2.year_product = kg_1.payroll_year) AS sbq
ORDER BY year_product, product_name;
