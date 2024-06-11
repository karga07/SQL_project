----- Secondary table -----

CREATE VIEW t_Karolina_Gajduskova_project_SQL_secondary_final AS 
	SELECT 
		country,
		year,
		GDP,
		population,
		gini
	FROM economies 
	WHERE country IN(
		SELECT country
		FROM countries 
		WHERE region_in_world LIKE '%Europe%')
	AND year BETWEEN 2006 AND 2018;
	
