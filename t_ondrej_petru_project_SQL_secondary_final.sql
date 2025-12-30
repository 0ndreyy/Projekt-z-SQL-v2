CREATE TABLE t_ondrej_petru_project_SQL_secondary_final AS
SELECT
    economies.year AS rok,
    economies.country as krajina,
    economies.gdp AS hdp,
    economies.gini AS gini,
    countries.population AS populace
FROM economies
JOIN (
	SELECT DISTINCT rok
	FROM t_ondrej_petru_project_SQL_primary_final
) roky
    ON economies.year = roky.rok
LEFT JOIN countries
    ON economies.country = countries.country
WHERE countries.continent = 'Europe' AND economies.gdp IS NOT NULL;
