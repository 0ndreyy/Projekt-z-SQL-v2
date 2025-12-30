WITH
prumerne_mzdy_vcetne_lonske AS (
	SELECT rok, odvetvi, prumerna_mzda, LAG (prumerna_mzda, 1, NULL) OVER (PARTITION BY odvetvi ORDER BY rok) AS prumerna_mzda_lonska
	FROM t_ondrej_petru_project_sql_primary_final
	WHERE odvetvi IS NOT NULL
)
SELECT rok, odvetvi, prumerna_mzda, prumerna_mzda_lonska, prumerna_mzda < prumerna_mzda_lonska AS klesla
FROM prumerne_mzdy_vcetne_lonske
ORDER BY odvetvi, rok;
