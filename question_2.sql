WITH
prumerne_mzdy AS
(
	SELECT rok, AVG(prumerna_mzda) AS prumerna_mzda
	FROM t_ondrej_petru_project_sql_primary_final
	WHERE
		odvetvi IS NOT NULL AND
		(
			rok = (SELECT MIN(rok) FROM t_ondrej_petru_project_sql_primary_final WHERE potravina IS NOT NULL) OR
			rok = (SELECT MAX(rok) FROM t_ondrej_petru_project_sql_primary_final WHERE potravina IS NOT NULL)
		)
	GROUP BY rok
),
prumerne_ceny_mleka AS(
	SELECT rok, prumerna_cena AS prumerna_cena
	FROM t_ondrej_petru_project_sql_primary_final
	WHERE potravina = 'Mléko polotučné pasterované'
),
prumerne_ceny_chleba AS(
	SELECT rok, prumerna_cena AS prumerna_cena
	FROM t_ondrej_petru_project_sql_primary_final
	WHERE potravina = 'Chléb konzumní kmínový'
)
SELECT
	pm.rok,
	pm.prumerna_mzda,
	(pm.prumerna_mzda / pcm.prumerna_cena) AS pocet_l_mleka,
	(pm.prumerna_mzda / pcc.prumerna_cena) AS pocet_ks_chleba
FROM prumerne_mzdy AS pm
JOIN prumerne_ceny_mleka AS pcm
	ON pm.rok = pcm.rok
JOIN prumerne_ceny_chleba AS pcc
	ON pm.rok = pcc.rok
ORDER BY 	
	rok;
