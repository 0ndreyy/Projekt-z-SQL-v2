WITH prumerne_mzdy AS (
	SELECT rok,
		AVG(prumerna_mzda) AS prumerna_mzda
	FROM t_ondrej_petru_project_sql_primary_final
	WHERE odvetvi IS NOT NULL
		AND (
			rok = (
				SELECT MIN(rok)
				FROM t_ondrej_petru_project_sql_primary_final
				WHERE potravina IS NOT NULL
			)
			OR rok = (
				SELECT MAX(rok)
				FROM t_ondrej_petru_project_sql_primary_final
				WHERE potravina IS NOT NULL
			)
		)
	GROUP BY rok
),
prumerne_ceny_mleka AS(
	SELECT rok,
		prumerna_cena AS prumerna_cena
	FROM t_ondrej_petru_project_sql_primary_final
	WHERE potravina = 'Mléko polotučné pasterované'
),
prumerne_ceny_chleba AS(
	SELECT rok,
		prumerna_cena AS prumerna_cena
	FROM t_ondrej_petru_project_sql_primary_final
	WHERE potravina = 'Chléb konzumní kmínový'
)
SELECT prumerne_mzdy.rok,
	ROUND(prumerne_mzdy.prumerna_mzda, 2) AS prumerna_mzda,
	ROUND(
		prumerne_mzdy.prumerna_mzda / prumerne_ceny_mleka.prumerna_cena,
		2
	) AS pocet_l_mleka,
	ROUND(
		prumerne_mzdy.prumerna_mzda / prumerne_ceny_chleba.prumerna_cena,
		2
	) AS pocet_kg_chleba
FROM prumerne_mzdy
	JOIN prumerne_ceny_mleka ON prumerne_mzdy.rok = prumerne_ceny_mleka.rok
	JOIN prumerne_ceny_chleba ON prumerne_mzdy.rok = prumerne_ceny_chleba.rok
ORDER BY rok;