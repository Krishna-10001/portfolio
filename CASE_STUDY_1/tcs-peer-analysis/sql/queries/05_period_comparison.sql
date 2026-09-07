-- period_comparison.sql
-- To compare company performance between :
-- Period A : FY22 - FY24
-- Period B : FY25 - FY27
-- The query calculates QoQ revenue and headcount growth and the decoupling gap before aggregating them by company and period

-- Note : FY22 has no previos quarter in dataset so they are excluded from AVG() calculations


WITH quarterly_data AS (
SELECT 
	company,
	fiscal_year,
	quarter_num,
	revenue_cr,
	headcount,
	net_profit_cr,
	ebit_margin_pct,
	attrition_pct,

	LAG(revenue_cr) OVER(PARTITION BY company ORDER BY fiscal_year , quarter_num ) AS prev_quarter_revenue ,

	LAG(headcount) OVER(PARTITION BY company ORDER BY fiscal_year , quarter_num ) AS prev_quarter_headcount 

FROM company_financials
) ,


analysis_data AS (
SELECT
	company,
	fiscal_year,
	quarter_num,
	revenue_cr,
	headcount,
	net_profit_cr,
	ebit_margin_pct,
	attrition_pct,

	ROUND(
    	(net_profit_cr / NULLIF(revenue_cr, 0)) * 100 , 2
    	
	) AS net_profit_margin_pct ,

	ROUND(
		(revenue_cr - prev_quarter_revenue) / NULLIF(prev_quarter_revenue , 0) * 100 , 2
	) AS revenue_qoq_growth_pct ,

	ROUND(
		(headcount - prev_quarter_headcount) :: NUMERIC / NULLIF(prev_quarter_headcount , 0) * 100 , 2
	) AS headcount_qoq_growth_pct ,

	CASE 
		WHEN fiscal_year BETWEEN 2022 AND 2024
			THEN 'Period A (FY22 TO FY24)'
		ELSE 'Period B (FY25 TO FY27 Q1)'
	END AS period 

FROM quarterly_data	
)

-- Aggregate by company and period 


SELECT 
	company,
	period ,
	
	COUNT(*) AS quarters_included,
	
	COUNT(revenue_qoq_growth_pct) AS growth_quarters_used ,

	ROUND(AVG(revenue_cr) , 0) AS avg_revenue_cr ,

	ROUND(AVG(headcount) , 0) AS avg_headcount ,

	ROUND(AVG(net_profit_cr) ,0) AS avg_net_profit_cr,

	ROUND(AVG(net_profit_margin_pct) , 2) AS avg_net_profit_margin_pct,

	ROUND(
		AVG((revenue_cr * 10000000) / NULLIF(headcount , 0) ),0
	) AS avg_revenue_per_employee_inr , 

	ROUND(AVG(revenue_qoq_growth_pct) , 2) AS avg_revenue_qoq_growth_pct ,

	ROUND(AVG(headcount_qoq_growth_pct) , 2) AS avg_headcount_qoq_growth_pct ,

	ROUND(AVG(revenue_qoq_growth_pct - headcount_qoq_growth_pct) , 2) AS avg_decoupling_gap_pp ,

	ROUND(AVG(ebit_margin_pct) , 2) AS avg_ebit_margin_pct ,

	ROUND(AVG(attrition_pct) , 2) AS avg_attrition_pct 

FROM analysis_data

GROUP BY company , period 

ORDER BY company , period


	
	
	






















