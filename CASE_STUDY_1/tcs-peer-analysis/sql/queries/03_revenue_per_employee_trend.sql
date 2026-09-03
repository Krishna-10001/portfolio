-- revenue_per_employee_trend.sql
-- Answers guiding question 1 : How do revenue , headcount , attrition and margin trend quarter over quarter, per company?
--
-- revenue_per_employee tells us efficiency .
--
-- Note : revenue_cr is in crores so dividing by headcount gives crores per employee , so we multiply that no by 10000000
-- and round up to get plain number 

SELECT 
	company,
 	fiscal_year,
 	quarter_num,
 	revenue_cr,
 	headcount,
 	ROUND(revenue_cr * 10000000 / headcount , 0) AS revenue_per_employee_inr,
 	net_profit_cr,
 	ebit_margin_pct,
 	attrition_pct
FROM company_financials
ORDER BY company , fiscal_year , quarter_num