-- dashboard_dataset.sql

-- To create final quarter level dataset for Tableau
--
-- This combines the raw financial/workforce metrics with the
-- analytical metrics required for the dashboard:
--   - Revenue QoQ growth
--   - Headcount QoQ growth
--   - Decoupling gap
--   - Revenue per employee
--   - Period classification




WITH quarterly_data AS (
SELECT 
	company,
	fiscal_year,
	quarter_num,
	revenue_cr,
	net_profit_cr,
	headcount,
	ebit_margin_pct,
	attrition_pct,

	LAG(revenue_cr) OVER(PARTITION BY company ORDER BY fiscal_year , quarter_num ) AS prev_quarter_revenue ,

	LAG(headcount) OVER(PARTITION BY company ORDER BY fiscal_year , quarter_num ) AS prev_quarter_headcount 

FROM company_financials
) 

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
	

	ROUND(
		(((revenue_cr - prev_quarter_revenue) / NULLIF(prev_quarter_revenue , 0) * 100 ) -
		((headcount - prev_quarter_headcount) :: NUMERIC / NULLIF(prev_quarter_headcount , 0) * 100 )), 2
	) AS decoupling_gap_pp ,

	ROUND(
		(revenue_cr * 10000000) / NULLIF(headcount , 0) ,0
	) AS revenue_per_employee_inr ,	


	CASE 
		WHEN fiscal_year BETWEEN 2022 AND 2024
			THEN 'Period A (FY22 TO FY24)'
		ELSE 'Period B (FY25 TO FY27 Q1)'
	END AS period 

FROM quarterly_data	

ORDER BY 
	company,
	fiscal_year,
	quarter_num;