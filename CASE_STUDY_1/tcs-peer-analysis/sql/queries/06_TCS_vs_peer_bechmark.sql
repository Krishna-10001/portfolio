-- TCS vs peer benchmark.sql
--
-- Compare TCS with the peer average (Infosys , Wipro , HCLTech) on 
-- 1. Revenue per employee 
-- 2. Decoupling Gap
-- Query is split into two parts

-- ====================================================================
-- Part 1 : TCS vs peer average revenue per employee
-- ====================================================================



WITH revenue_per_employee AS(

SELECT 
	company,
	fiscal_year,
	quarter_num,
	
	(revenue_cr * 10000000) / NULLIF(headcount , 0) AS revenue_per_employee_inr 

FROM company_financials
) ,

peer_average AS (

SELECT 
	
	fiscal_year,
	quarter_num,

	AVG(revenue_per_employee_inr) AS peer_avg_revenue_per_employee_inr

FROM revenue_per_employee

WHERE company <> 'TCS'

GROUP BY fiscal_year , quarter_num 

)

SELECT 

	t.fiscal_year,
	t.quarter_num,

	ROUND(t.revenue_per_employee_inr , 0) AS tcs_revenue_per_employee_inr ,

	ROUND(p.peer_avg_revenue_per_employee_inr , 0) AS peer_avg_revenue_per_employee_inr ,

	ROUND(t.revenue_per_employee_inr - p.peer_avg_revenue_per_employee_inr , 0) AS tcs_minus_peer_avg_inr

FROM revenue_per_employee t 

JOIN peer_average p 
	ON t.fiscal_year = p.fiscal_year 
	AND t.quarter_num = p.quarter_num

WHERE t.company = 'TCS'

ORDER BY 
	t.fiscal_year ,
	t.quarter_num ;


-- ===========================================================
-- Part 2 : TCS vs peer Average Decoupling Gap 
-- ===========================================================

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

	LAG(headcount) OVER(PARTITION BY company ORDER BY fiscal_year , quarter_num ) AS prev_quarter_headcount 

FROM company_financials
) ,

growth_rates AS (
SELECT
	company,
	fiscal_year,
	quarter_num,
	

	(
		(revenue_cr - prev_quarter_revenue) / NULLIF(prev_quarter_revenue , 0) * 100 
	) AS revenue_qoq_growth_pct ,

	(
		(headcount - prev_quarter_headcount) :: NUMERIC / NULLIF(prev_quarter_headcount , 0) * 100 
	) AS headcount_qoq_growth_pct 

FROM quarterly_data
) , 

decoupling AS (
SELECT 
	company,
	fiscal_year,
	quarter_num,

	revenue_qoq_growth_pct,
	headcount_qoq_growth_pct,

	revenue_qoq_growth_pct - headcount_qoq_growth_pct AS decoupling_gap_pp
FROM growth_rates

),

peer_average AS(

SELECT 
	fiscal_year,
	quarter_num,
	
	AVG(decoupling_gap_pp) AS peer_avg_decoupling_gap_pp ,
	COUNT(decoupling_gap_pp) AS peers_included 

FROM decoupling
WHERE company <> 'TCS'
GROUP BY 
	fiscal_year,
	quarter_num
)

SELECT
	t.fiscal_year,
	t.quarter_num,
	p.peers_included,

	ROUND(t.decoupling_gap_pp , 2) AS tcs_decoupling_gap_pp ,

	ROUND(p.peer_avg_decoupling_gap_pp , 2) AS peer_avg_decoupling_gap_pp ,

	ROUND(t.decoupling_gap_pp - p.peer_avg_decoupling_gap_pp , 2) AS tcs_relative_decoupling_gap_pp 
	
FROM decoupling t
JOIN peer_average p 
	ON t.fiscal_year = p.fiscal_year
	AND t.quarter_num = p.quarter_num

WHERE t.company = 'TCS'

ORDER BY 
	t.fiscal_year,
	t.quarter_num ;

	




 













