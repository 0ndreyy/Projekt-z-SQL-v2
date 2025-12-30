# Projekt z SQL
## Úvod
Tento dokument shrnuje výsledky z výzkumu dostupnosti základních potravin široké veřejnosti. Konkrétně obsahuje odpovědi na pět předem definovaných výzkumných otázek. Odpovědi na otázky jsou založeny na analýze datových podkladů o vývoji mezd a cen potravin v České republice a na datových podkladech o vývoji ekonomických a demografických ukazatelů v evropských zemích.

Údaje o mzdách a cenách potravin byly agregované do tabulky `t_ondrej_petru_project_SQL_primary_final` a údaje o ekonomických a demografických ukazatelích v evropských zemích do tabulky `t_ondrej_petru_project_SQL_secondary_final`.

## Výzkumné otázky a odpovědi
### 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
Z dostupných dat vyplývá, že jen v několika odvětvích došlo každý rok ke zvýšení, či stagnaci mezd. Tato odvětví jsou:
- Doprava a skladování
- Ostatní činnosti
- Zdravotní a sociální péče
- Zpracovatelský průmysl

V ostatních odvětvích byly roky, kdy meziročně průměrná mzda klesla. Konkrétně to bylo:
- Administrativní a podpůrné činnosti - 2013
- Informační a komunikační činnosti - 2013
- Kulturní, zábavní a rekreační činnosti - 2011 a 2013
- Peněžnictví a pojišťovnictví - 2013
- Profesní, vědecké a technické činnosti - 2010 a 2013
- Stavebnictví - 2013
- Těžba a dobývání - 2009, 2013, 2014 a 2016
- Ubytování a stravování - 2009 a 2011
- Velkoobchod a maloobchod; opravy a údržby motorových vozidel - 2013
- Veřejná správa a obrana; povinné sociální zabezpečení - 2010 a 2011
- Vzdělávání - 2010
- Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu - 2013 a 2015
- Zemědělství, lesnictví, rybářství - 2009
- Zásobování vodou; činnosti související s odpady a sanacemi - 2013
- Činnosti v oblasti nemovitostí - 2013

Rok 2013 byl rokem, kdy mzdy klesly ve většině sledovaných odvětví.

### 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
V roce 2006 byla průměrná mzda 20 753,78 Kč. Za ni bylo možné koupit:
- 1 437,46 l mléka
- 1 287,16 kg chleba

V roce 2018 byla průměrná mzda 32 535,86 Kč. Za ni bylo možné koupit:
- 1 641,77 l mléka
- 1 342,32 kg chleba

Ceny potravin za dřívější nebo pozdější období nejsou dostupné.

### 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší procentuální meziroční nárůst)? 
Na základě dostupných dat je viditelná deflace u potraviny cukr krystalový, který meziročně zlevňuje průměrně o 1,92 %.

### 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
V analyzovaném období takový rok neexistuje. Největší rozdíl v meziročním růstu potravin a mezd byl v roce 2013 a činil 6,66 procentního bodu. V daném roce mzdy meziročně klesly o 1,56 % a ceny potravin meziročně vzrostly o 5,10 %.
Naopak, nejnižší rozdíl byl v roce 2009, když mzdy vzrostly o 3,16 %, ceny klesly o 6,41 % a rozdíl činil -9,57 procentního bodu.

### 5. Má výše HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
Na základě dostupných dat není možné tuto závislost jednoznačně potvrdit.

Nejednoznačnost této závislosti je možné demonstrovat na dvou rocích s největším meziročním růstem HDP - rok 2007 s růstem 5,57 % a rok 2015 s růstem 5,39 %.
Meziroční růst mezd v daných rocích byl 6,84 % a 2,51 %, meziroční růst mezd o rok později byl 7,87 % a 3,65 %.
Meziroční růst cen potravin v daných rocích byl 6,76 % a -0,55 %, meziroční růst cen o rok později byl 6,19 % a -1,19 %.
Takže zatímco růst HDP byl v daných rocích podobný, růsty mezd i cen se výrazně lišily.

Stejně tak je možné najít roky, kdy byl meziroční růst HDP výrazně menší než v rocích z předchozího příkladu (2,69 % v roce 2008 a 3,20 % v roce 2018), ale meziroční růst mezd v daných letech byl vyšší (7,87 %, resp. 7,62 %).

## Závěr
Vstupní data obsahovaly údaje o mzdách za období roku 2000 až 2021 a údaje o cenách za období roku 2006 až 2018. Odpovědi na otázky proto byly postavené na údajích za společné roky - 2006 až 2018. Údaje za tyto roky obsahovaly všechny informace potřebné na zodpovězení výzkumných otázek.

V tabulce s dodatečnými informacemi o evropských zemích chybí pro některé státy a roky hodnota koeficientu GINI. Tyto údaje ve vstupních datech nebyly dostupné.
