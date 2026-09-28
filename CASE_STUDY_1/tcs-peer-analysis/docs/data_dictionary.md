# Data Dictionary

## Table: `company_financials`

| Column | Type | Description | Notes |
|---|---|---|---|
| `company` | TEXT | One of: `TCS`, `Infosys`, `Wipro`, `HCLTech` | Part of primary key |
| `fiscal_year` | INTEGER | Fiscal year, e.g. `2022` = FY22 (Apr 2021–Mar 2022) | Part of primary key |
| `quarter_num` | INTEGER | Fiscal quarter, 1–4 | Part of primary key |
| `revenue_cr` | NUMERIC | Quarterly revenue in ₹ crore | |
| `headcount` | INTEGER | Closing employee headcount for the quarter | |
| `net_profit_cr` | NUMERIC | Quarterly net profit in ₹ crore | |
| `ebit_margin_pct` | NUMERIC | EBIT/operating margin, % | Definition may vary slightly by company — see `02_prepare.md` |
| `attrition_pct` | NUMERIC | Reported attrition rate, % | Definition (LTM vs. quarterly annualized) may vary by company |
| `source_doc` | TEXT | Filename of the source PDF this row was extracted from. Format: `{COMPANY}-Q{n}-FY{yy}-{yy+1}.pdf`. For TCS/Infosys/HCLTech this is a quarterly investor fact sheet; for Wipro this is a quarterly results press release — see `02_prepare.md` | |

## Derived / Analytical Columns (generated in SQL, not stored in the raw table)

| Column | Formula | Produced by |
|---|---|---|
| `revenue_per_employee_inr` | `(revenue_cr * 10,000,000) / headcount` | `01`, `04`, `06` |
| `net_profit_margin_pct` | `(net_profit_cr / revenue_cr) * 100` | `03`, `06` |
| `revenue_qoq_growth_pct` | `(revenue_cr − prev_quarter_revenue) / prev_quarter_revenue * 100` | `02`, `03`, `04`, `05`, `06` |
| `headcount_qoq_growth_pct` | `(headcount − prev_quarter_headcount) / prev_quarter_headcount * 100` | `02`, `03`, `04`, `05`, `06` |
| `decoupling_gap_pp` | `revenue_qoq_growth_pct − headcount_qoq_growth_pct` | `02`, `03`, `04`, `06` |
| `period` | `CASE WHEN fiscal_year BETWEEN 2022 AND 2024 THEN 'Period A (FY22 TO FY24)' ELSE 'Period B (FY25 TO FY27 Q1)' END` | `03`, `06` |