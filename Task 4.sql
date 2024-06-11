--- Task 4 -----
----- help table 3 -------------

CREATE VIEW kg_3 AS
WITH subquery AS (
    SELECT 
        payroll_year,
        AVG(avg_value_income) AS avg_value_income,
        LAG(AVG(avg_value_income), 1) OVER (ORDER BY payroll_year) AS previous_income
    FROM t_Karolina_Gajduskova_project_SQL_primary_final
    GROUP BY payroll_year
)
SELECT 
    payroll_year,
    avg_value_income,
    previous_income,
    ((avg_value_income - previous_income)/previous_income)*100 as difference_income_perc
FROM subquery
WHERE payroll_year > 2006;

----- help table 4 --------------

CREATE VIEW kg_4 AS
WITH subquery AS (
    SELECT 
        year_product,
        SUM(avg_product_price) AS avg_product_price,
        LAG(SUM(avg_product_price), 1) OVER (ORDER BY year_product) AS previous_price
    FROM t_Karolina_Gajduskova_project_SQL_primary_final
    GROUP BY year_product
)
SELECT 
    year_product,
    avg_product_price,
    previous_price,
    ((avg_product_price - previous_price)/previous_price)*100 as difference_price_perc
FROM subquery
WHERE year_product > 2006;

--------- differences income and prices  -------

SELECT 
	payroll_year,
	difference_price_perc,
	difference_income_perc,
	(difference_price_perc - difference_income_perc) AS difference
FROM (
	SELECT 
		payroll_year,
		difference_income_perc,
		difference_price_perc
	FROM kg_3
	LEFT JOIN kg_4 ON kg_3.payroll_year = kg_4.year_product) AS subquery1
ORDER BY difference DESC;
