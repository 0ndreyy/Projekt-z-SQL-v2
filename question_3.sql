WITH prumerne_ceny_vcetne_lonske AS (
	SELECT rok,
		potravina,
		prumerna_cena,
		LAG (prumerna_cena, 1, NULL) OVER (
			PARTITION BY potravina
			ORDER BY rok
		) AS prumerna_cena_lonska
	FROM t_ondrej_petru_project_sql_primary_final
	WHERE potravina IS NOT NULL
)
SELECT potravina,
	ROUND(
		(AVG(prumerna_cena / prumerna_cena_lonska) - 1) * 100,
		2
	) AS prumerna_mezirocni_procentualni_zmena
FROM prumerne_ceny_vcetne_lonske
GROUP BY potravina
ORDER BY prumerna_mezirocni_procentualni_zmena
LIMIT 1;