---- Časový úsek dat ----
SELECT MAX(payroll_year),
		MIN (payroll_year)
FROM czechia_payroll cp;

SELECT MAX(YEAR(date_to)),
	   MIN (YEAR(date_to))
FROM czechia_price cp; 

--- Primary table ----

--- Úprava payroll----

CREATE VIEW payroll_kg AS ( 
SELECT 
	id AS id_cpa,
	industry_branch_code,
	name,
	payroll_year,
	AVG(value) AS avg_value_income
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code = cpib.code
WHERE 1=1
AND cp.value_type_code = 5958 
AND calculation_code = 200
AND industry_branch_code IS NOT NULL 
AND payroll_year < 2019
AND payroll_year > 2005
GROUP BY industry_branch_code, payroll_year );

--- Úprava price category-----

CREATE VIEW prices_kg AS (
SELECT 
 id AS id_cpr, 
 AVG(value) AS avg_product_price,
 name AS product_name,
 YEAR(date_to) as year_product
FROM czechia_price cp 
LEFT JOIN czechia_price_category cpc 
	ON cp.category_code = cpc.code 
GROUP BY YEAR(date_to), name);

--- join ----

CREATE VIEW  t_Karolina_Gajduskova_project_SQL_primary_final AS	
SELECT * 
FROM payroll_kg
LEFT JOIN prices_kg ON payroll_kg.id_cpa = prices_kg.id_cpr
UNION
SELECT * 
FROM payroll_kg
RIGHT JOIN prices_kg ON payroll_kg.id_cpa = prices_kg.id_cpr;


