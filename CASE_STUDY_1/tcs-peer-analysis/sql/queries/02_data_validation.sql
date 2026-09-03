select count(*) as total_rows
from company_financials	;

SELECT DISTINCT company
FROM company_financials
ORDER BY company;

SELECT 
	company,
	COUNT(*) AS quarter_count
FROM company_financials
GROUP BY company
ORDER BY company;

SELECT
	company,
	fiscal_year,
	quarter_num,
	COUNT(*) AS duplicate_count
FROM company_financials
GROUP BY company , fiscal_year , quarter_num
HAVING COUNT(*) > 1;

SELECT *
FROM company_financials 
WHERE
	revenue_cr IS NULL
	OR headcount IS NULL
	OR net_profit_cr IS NULL
	OR ebit_margin_pct IS NULL
	OR attrition_pct IS NULL
	OR source_doc IS NULL;
	