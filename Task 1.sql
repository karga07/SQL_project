--- Task 1 -----
SELECT 
	payroll_year,
	name,
	avg_value_income,
	previous_income,
	avg_value_income - previous_income AS difference
	FROM(SELECT
			payroll_year,
			name,
			avg_value_income,
			LAG (AVG(avg_value_income),1) OVER (ORDER BY industry_branch_code, payroll_year) AS previous_income
		FROM t_Karolina_Gajduskova_project_SQL_primary_final 
		WHERE 1=1
		GROUP BY payroll_year, industry_branch_code 
		ORDER BY industry_branch_code, payroll_year ) AS subquery
WHERE avg_value_income - previous_income < 0
AND payroll_year > 2006
ORDER BY name, difference;