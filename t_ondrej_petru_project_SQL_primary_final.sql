CREATE TABLE t_ondrej_petru_project_SQL_primary_final AS
WITH
prumerne_mzdy AS (
	SELECT 
		cp.payroll_year AS rok,
		cp.industry_branch_code AS kod_odvetvi,
		cpib.name AS odvetvi,		
		ROUND(AVG(cp.value::numeric), 2) AS prumerna_mzda
	FROM czechia_payroll AS cp
	LEFT JOIN czechia_payroll_industry_branch AS cpib
		ON cp.industry_branch_code = cpib.code
	WHERE
		cp.industry_branch_code IS NOT NULL
		AND cp.value_type_code = 5958
	GROUP BY
		odvetvi,
		kod_odvetvi,
		rok
),
prumerne_ceny_potravin AS (
	SELECT 
		EXTRACT(YEAR FROM cp.date_from) AS rok,
		cp.category_code AS kod_potraviny,
		cpc.name AS potravina,
		ROUND(AVG(cp.value::numeric), 2) AS prumerna_cena
	FROM czechia_price AS cp
	LEFT JOIN czechia_price_category AS cpc
		ON cp.category_code = cpc.code
	WHERE
		cp.category_code IS NOT NULL
	GROUP BY
		potravina,
		kod_potraviny,
		rok
)
SELECT
	pm.rok AS rok,
	pm.odvetvi AS odvetvi,
	pm.prumerna_mzda AS prumerna_mzda,
	NULL AS potravina,
	NULL AS prumerna_cena
FROM prumerne_mzdy AS pm
JOIN prumerne_ceny_potravin AS pcp
	ON pm.rok = pcp.rok
UNION
SELECT
	pcp.rok as rok,
	NULL AS odvetvi,
	NULL AS prumerna_mzda,
	pcp.potravina,
	pcp.prumerna_cena
FROM prumerne_ceny_potravin AS pcp
JOIN prumerne_mzdy as pm
	ON pcp.rok = pm.rok;
