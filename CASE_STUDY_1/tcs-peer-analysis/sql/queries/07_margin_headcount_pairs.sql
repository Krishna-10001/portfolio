-- margin_headcount_pairs.sql
-- 
-- To examine whether the quarterly EBIT margin expansion is more closely associated with change in headcount or revenue
-- Part 1 : Produces clean quarterly paired data for Tableau
-- Part 2 : Calculate Pearson correlation coefficients using postgreSQL CORR()

-- IMPORTANT : Correlation measure association not causation

-- ================================================================
-- Part 1 : Quarterly paired data for Tableau
-- ================================================================



WITH quarterly_data AS (
SELECT 
	company,
	fiscal_year,
	quarter_num,
	revenue_cr,
	headcount,
	ebit_margin_pct,
	attrition_pct,

	LAG(revenue_cr) OVER(PARTITION BY company ORDER BY fiscal_year , quarter_num ) AS prev_quarter_revenue ,

	LAG(headcount) OVER(PARTITION BY company ORDER BY fiscal_year , quarter_num ) AS prev_quarter_headcount ,

	LAG(ebit_margin_pct) OVER(PARTITION BY company ORDER BY fiscal_year , quarter_num) AS prev_quarter_ebit_margin 

FROM company_financials
) ,

changes AS (
SELECT
	company,
	fiscal_year,
	quarter_num,
	ebit_margin_pct,

	ebit_margin_pct - prev_quarter_ebit_margin AS margin_change_pp ,
	

	(
		(revenue_cr - prev_quarter_revenue) / NULLIF(prev_quarter_revenue , 0) * 100 
	) AS revenue_change_pct ,

	(
		(headcount - prev_quarter_headcount) :: NUMERIC / NULLIF(prev_quarter_headcount , 0) * 100 
	) AS headcount_change_pct 

FROM quarterly_data
)

SELECT 
	company,
	fiscal_year,
	quarter_num,

	ROUND(ebit_margin_pct , 2) AS ebit_margin_pct ,
	ROUND(margin_change_pp , 2) AS margin_change_pp ,
	ROUND(headcount_change_pct , 2) AS headcount_change_pct ,
	ROUND(revenue_change_pct , 2) AS revenue_change_pct

FROM changes

ORDER BY 
	company,
	fiscal_year,
	quarter_num;



-- ===================================================================
-- Part 2 : Correlation Analysis
-- ===================================================================

WITH quarterly_data AS (
SELECT 
	company,
	fiscal_year,
	quarter_num,
	revenue_cr,
	headcount,
	ebit_margin_pct,
	attrition_pct,

	LAG(revenue_cr) OVER(PARTITION BY company ORDER BY fiscal_year , quarter_num ) AS prev_quarter_revenue ,

	LAG(headcount) OVER(PARTITION BY company ORDER BY fiscal_year , quarter_num ) AS prev_quarter_headcount ,

	LAG(ebit_margin_pct) OVER(PARTITION BY company ORDER BY fiscal_year , quarter_num) AS prev_quarter_ebit_margin 

FROM company_financials
) ,

changes AS (
SELECT
	company,
	fiscal_year,
	quarter_num,
	ebit_margin_pct,

	ebit_margin_pct - prev_quarter_ebit_margin AS margin_change_pp ,
	

	(
		(revenue_cr - prev_quarter_revenue) / NULLIF(prev_quarter_revenue , 0) * 100 
	) AS revenue_change_pct ,

	(
		(headcount - prev_quarter_headcount) :: NUMERIC / NULLIF(prev_quarter_headcount , 0) * 100 
	) AS headcount_change_pct 

FROM quarterly_data
)


SELECT 
	company,

	COUNT(margin_change_pp) AS quarters_used  ,

	ROUND(
		(CORR(margin_change_pp , headcount_change_pct):: NUMERIC) , 3
	) AS corr_margin_vs_headcount ,

	ROUND(
		(CORR(margin_change_pp , revenue_change_pct):: NUMERIC) , 3
	) AS corr_margin_vs_revenue 

FROM changes
GROUP BY
	company
ORDER BY
	company;


	
	

























