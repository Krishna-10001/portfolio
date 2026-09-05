-- qoq_growth_rates.sql
-- This gives us quarter-over-quarter growth qoq % growth for revenue and headcount. 
-- we'll use CTE and window function toghether for optimal query solution

-- CTE query

WITH quarterly_data AS (

SELECT 
	company,
	fiscal_year,
	quarter_num,
	revenue_cr,
-- Window function
	LAG(revenue_cr) OVER(
		PARTITION BY company 
		ORDER BY fiscal_year , quarter_num) AS prev_quarter_revenue,
	headcount,

	LAG(headcount) OVER (
		PARTITION BY company 
		ORDER BY fiscal_year , quarter_num ) AS prev_quarter_headcount
FROM company_financials
	
)

-- Main Query

SELECT 
	company,
	fiscal_year,
	quarter_num,
	revenue_cr,
	headcount,
	prev_quarter_revenue,
	ROUND(
		((revenue_cr - prev_quarter_revenue)/NULLIF(prev_quarter_revenue,0)) * 100 , 2
	) AS revenue_qoq_growth_pct ,
	prev_quarter_headcount , 
	ROUND(
		((headcount - prev_quarter_headcount):: NUMERIC/NULLIF(prev_quarter_headcount , 0)) * 100 , 2
	) AS headcount_qoq_growth_pct 

FROM quarterly_data 

ORDER BY company ,fiscal_year , quarter_num







	