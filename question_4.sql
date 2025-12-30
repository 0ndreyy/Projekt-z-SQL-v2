WITH prumerne_mzdy AS (
	SELECT rok,
		AVG(prumerna_mzda) AS prumerna_mzda
	FROM t_ondrej_petru_project_sql_primary_final
	WHERE odvetvi IS NOT NULL
	GROUP BY rok
),
prumerne_mzdy_vcetne_lonske AS (
	SELECT rok,
		prumerna_mzda,
		LAG (prumerna_mzda, 1, NULL) OVER (
			ORDER BY rok
		) AS prumerna_mzda_lonska
	FROM prumerne_mzdy
),
prumerne_ceny AS (
	SELECT rok,
		AVG(prumerna_cena) AS prumerna_cena
	FROM t_ondrej_petru_project_sql_primary_final
	WHERE potravina IS NOT NULL
	GROUP BY rok
),
prumerne_ceny_vcetne_lonske AS (
	SELECT rok,
		prumerna_cena,
		LAG (prumerna_cena, 1, NULL) OVER (
			ORDER BY rok
		) AS prumerna_cena_lonska
	FROM prumerne_ceny
),
rusty AS (
	SELECT prumerne_mzdy.rok,
		-- procentualni mezirocni rust prumerne mzdy s presnosti na 2 desetinna mista
		ROUND(
			(
				(
					prumerne_mzdy.prumerna_mzda / prumerne_mzdy.prumerna_mzda_lonska
				) - 1
			) * 100,
			2
		) AS rust_mezd,
		-- procentualni mezirocni rust prumerne ceny s presnosti na 2 desetinna mista
		ROUND(
			(
				(
					prumerne_ceny.prumerna_cena / prumerne_ceny.prumerna_cena_lonska
				) - 1
			) * 100,
			2
		) AS rust_cen
	FROM prumerne_mzdy_vcetne_lonske AS prumerne_mzdy
		JOIN prumerne_ceny_vcetne_lonske AS prumerne_ceny ON prumerne_mzdy.rok = prumerne_ceny.rok
),
rozdil_v_rustu AS (
	SELECT rusty.*,
		(rusty.rust_cen - rusty.rust_mezd) AS rozdil_rustu_v_pb
	FROM rusty
)
SELECT *
FROM rozdil_v_rustu
WHERE rozdil_rustu_v_pb IS NOT NULL
ORDER BY rozdil_rustu_v_pb DESC;