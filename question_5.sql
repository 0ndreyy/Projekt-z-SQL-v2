WITH
prumerne_mzdy AS (
	SELECT rok, AVG(prumerna_mzda) AS prumerna_mzda
	FROM t_ondrej_petru_project_sql_primary_final
	WHERE odvetvi IS NOT NULL
	GROUP BY rok
),
prumerne_ceny AS (
	SELECT rok, AVG(prumerna_cena) AS prumerna_cena
	FROM t_ondrej_petru_project_sql_primary_final
	WHERE potravina IS NOT NULL
	GROUP BY rok
),
hdp_czechia AS (
	SELECT rok, hdp
	FROM t_ondrej_petru_project_sql_secondary_final
	WHERE krajina = 'Czech Republic'
),
rusty AS (
	SELECT
		hdp_czechia.rok AS rok,
		-- procentualni mezirocni rust HDP 
		ROUND(((hdp_czechia.hdp / LAG(hdp_czechia.hdp, 1, NULL) OVER (ORDER BY hdp_czechia.rok) - 1) * 100)::numeric, 2) AS rust_hdp,
		-- procentualni mezirocni rust prumerne mzdy
		ROUND((prumerne_mzdy.prumerna_mzda / LAG(prumerne_mzdy.prumerna_mzda, 1, NULL) OVER (ORDER BY prumerne_mzdy.rok) - 1) * 100, 2) AS rust_mezd,
		-- procentualni mezirocni rust prumerne ceny
		ROUND((prumerne_ceny.prumerna_cena / LAG(prumerne_ceny.prumerna_cena, 1, NULL) OVER (ORDER BY prumerne_ceny.rok) - 1) * 100, 2) AS rust_cen,
		-- procentualni mezirocni rust prumerne mzdy nasledujici rok
		ROUND((LEAD(prumerne_mzdy.prumerna_mzda) OVER (ORDER BY prumerne_mzdy.rok) / prumerne_mzdy.prumerna_mzda - 1) * 100, 2) AS rust_mezd_nasledujici_rok,
		-- procentualni mezirocni rust prumerne ceny nasledujici rok
		ROUND((LEAD(prumerne_ceny.prumerna_cena) OVER (ORDER BY prumerne_ceny.rok) / prumerne_ceny.prumerna_cena - 1) * 100, 2) AS rust_cen_nasledujici_rok
	FROM hdp_czechia
	JOIN prumerne_mzdy
		ON hdp_czechia.rok = prumerne_mzdy.rok
	JOIN prumerne_ceny
		ON hdp_czechia.rok = prumerne_ceny.rok
)
SELECT *
FROM rusty;
