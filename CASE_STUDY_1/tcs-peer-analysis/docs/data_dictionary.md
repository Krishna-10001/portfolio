# Data Dictionary

## 1. Overview

The `company_financials` table contains standardized quarterly financial and workforce data for four Indian IT-services companies:

- TCS
- Infosys
- Wipro
- HCLTech

The dataset covers **FY22 Q1 through Q1 FY27**, representing **21 quarters per company** and **84 company-quarter observations**.

The raw table stores only source-level metrics. Analytical metrics such as QoQ growth, decoupling gap, revenue per employee, and period classification are calculated in SQL and are not stored in the raw table.

---

# 2. Raw Table: `company_financials`

| Column | Type | Description | Notes |
|---|---|---|---|
| `company` | TEXT | Company identifier | One of `TCS`, `Infosys`, `Wipro`, `HCLTech`; part of primary key |
| `fiscal_year` | INTEGER | Fiscal year identifier | `2022` represents FY22, covering Apr 2021–Mar 2022; part of primary key |
| `quarter_num` | INTEGER | Fiscal quarter number | Values range from `1` to `4`; part of primary key |
| `revenue_cr` | NUMERIC | Quarterly revenue in ₹ crore | Standardized to a common unit across companies |
| `headcount` | INTEGER | Closing employee headcount for the quarter | Reported company-level workforce count |
| `net_profit_cr` | NUMERIC | Quarterly net profit in ₹ crore | Reported profit attributable to the relevant reporting period |
| `ebit_margin_pct` | NUMERIC | EBIT/operating margin percentage | Reported operating profitability measure; exact definition may vary slightly by company |
| `attrition_pct` | NUMERIC | Reported employee attrition rate | Definition and measurement period may vary by company |
| `source_doc` | TEXT | Source document used for the observation | Provides traceability from each row to the underlying company disclosure |

### Primary Key

The combination below uniquely identifies each company-quarter observation:

```text
(company, fiscal_year, quarter_num)
(company, fiscal_year, quarter_num)

This primary key prevents duplicate observations for the same company and
fiscal quarter.

---

# 3. Fiscal-Year and Quarter Convention

The project uses the Indian financial-year convention adopted by the source
company disclosures.

| Dataset Value | Fiscal Period | Calendar Period |
|---|---|---|
| `2022` | FY22 | Apr 2021–Mar 2022 |
| `2023` | FY23 | Apr 2022–Mar 2023 |
| `2024` | FY24 | Apr 2023–Mar 2024 |
| `2025` | FY25 | Apr 2024–Mar 2025 |
| `2026` | FY26 | Apr 2025–Mar 2026 |
| `2027` | FY27 | Apr 2026–Mar 2027 |

Quarter numbering follows the company's fiscal year:

| `quarter_num` | Fiscal Quarter |
|---|---|
| `1` | Q1 |
| `2` | Q2 |
| `3` | Q3 |
| `4` | Q4 |

Therefore:

- `fiscal_year = 2022, quarter_num = 1` represents Q1 FY22.
- `fiscal_year = 2022, quarter_num = 4` represents Q4 FY22.
- `fiscal_year = 2027, quarter_num = 1` represents Q1 FY27.

The final analytical dataset contains observations from **Q1 FY22 through
Q1 FY27**.

---

# 4. Study Population

The dataset contains four Indian IT-services companies:

| Company | Dataset Identifier |
|---|---|
| Tata Consultancy Services | `TCS` |
| Infosys Limited | `Infosys` |
| Wipro Limited | `Wipro` |
| HCLTech | `HCLTech` |

The study uses the same fiscal-quarter structure across all four companies to
enable company-level and period-level comparison.

The final dataset contains:

- 4 companies
- 21 quarters per company
- 84 company-quarter observations

This structure is used throughout the SQL analysis and Tableau dashboard.

---

# 5. Raw Metrics vs. Derived Metrics

The project separates **source-level metrics** from **analytical metrics**.

The raw PostgreSQL table stores metrics extracted or standardized from company
disclosures.

Derived analytical metrics are calculated using SQL queries rather than
being permanently stored in the raw table.

This separation keeps the raw dataset closer to the original reported data and
allows analytical calculations to be reproduced from the underlying
observations.

## Raw Metrics

The following fields are stored directly in `company_financials`:

- Company
- Fiscal year
- Quarter number
- Revenue
- Headcount
- Net profit
- EBIT margin
- Attrition
- Source document

## Derived Metrics

The following analytical measures are calculated during analysis:

- Revenue per employee
- Net profit margin
- Revenue QoQ growth
- Headcount QoQ growth
- Decoupling gap
- Period classification

---

# 6. Revenue Metric

## Definition

`revenue_cr` represents quarterly company revenue standardized to **₹ crore**.

The value is stored as a numeric amount in crore rather than in the original
reporting unit used by each company.

For example, if a company disclosure reports revenue in ₹ million, the value
is converted to ₹ crore before entering the standardized dataset.

## Standardization

The purpose of converting revenue to a common unit is to make the four
companies directly comparable.

The raw source document remains recorded in `source_doc` so that the
standardized value can be traced back to the original disclosure.

## Revenue Unit

All values in `revenue_cr` are interpreted as:

```text
₹ crore