-- qoq_growth_rates.sql
-- This gives us quarter-over-quarter growth qoq % growth for revenue and headcount
-- Then we will use them to calculate Decoupling gap 
-- Decoupling gap = revenue qoq growth 	% - headcount qoq growth %  
-- we'll use CTE and window function toghether for optimal query solution
-- LAG() retrive previous quarter for the same company
-- NULLIF() prevents divission by zero error




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
	
),

growth_rates AS (


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

)

-- Main query

SELECT 
	company,
	fiscal_year,
	quarter_num,
	revenue_cr,
	headcount,

	prev_quarter_revenue,
	revenue_qoq_growth_pct,

	prev_quarter_headcount,
	headcount_qoq_growth_pct,

	ROUND(
		(revenue_qoq_growth_pct - headcount_qoq_growth_pct), 2
	) AS decoupling_gap_pp

FROM growth_rates

ORDER BY company , fiscal_year , quarter_num;











	







	