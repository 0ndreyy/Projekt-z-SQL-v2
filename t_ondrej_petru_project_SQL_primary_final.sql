CREATE TABLE t_ondrej_petru_project_SQL_primary_final AS WITH prumerne_mzdy AS (
	SELECT czechia_payroll.payroll_year AS rok,
		czechia_payroll.industry_branch_code AS kod_odvetvi,
		czechia_payroll_industry_branch.name AS odvetvi,
		ROUND(AVG(czechia_payroll.value)::numeric, 2) AS prumerna_mzda
	FROM czechia_payroll
		LEFT JOIN czechia_payroll_industry_branch ON czechia_payroll.industry_branch_code = czechia_payroll_industry_branch.code
	WHERE czechia_payroll.industry_branch_code IS NOT NULL
		AND czechia_payroll.value_type_code = 5958
	GROUP BY odvetvi,
		kod_odvetvi,
		rok
),
prumerne_ceny_potravin AS (
	SELECT EXTRACT(
			YEAR
			FROM czechia_price.date_from
		) AS rok,
		czechia_price.category_code AS kod_potraviny,
		czechia_price_category.name AS potravina,
		ROUND(AVG(czechia_price.value)::numeric, 2) AS prumerna_cena
	FROM czechia_price
		LEFT JOIN czechia_price_category ON czechia_price.category_code = czechia_price_category.code
	WHERE czechia_price.category_code IS NOT NULL
	GROUP BY potravina,
		kod_potraviny,
		rok
)
SELECT prumerne_mzdy.rok AS rok,
	prumerne_mzdy.odvetvi AS odvetvi,
	prumerne_mzdy.prumerna_mzda AS prumerna_mzda,
	NULL AS potravina,
	NULL AS prumerna_cena
FROM prumerne_mzdy
	JOIN prumerne_ceny_potravin ON prumerne_mzdy.rok = prumerne_ceny_potravin.rok
UNION
SELECT prumerne_ceny_potravin.rok AS rok,
	NULL AS odvetvi,
	NULL AS prumerna_mzda,
	prumerne_ceny_potravin.potravina,
	prumerne_ceny_potravin.prumerna_cena
FROM prumerne_ceny_potravin
	JOIN prumerne_mzdy ON prumerne_ceny_potravin.rok = prumerne_mzdy.rok;