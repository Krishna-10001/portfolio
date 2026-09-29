# Prepare

## Purpose

The Prepare phase converts publicly reported company information into a

standardized, analysis-ready dataset.

The objective is to make quarterly data from TCS, Infosys, Wipro, and HCLTech

comparable across the FY2022–Q1 FY2027 study period while preserving source

traceability and documenting important differences between company disclosures.

The final prepared dataset is stored as:

`data/raw/company_financials.csv`

The original quarterly source documents are retained in:

`data/raw/factsheets/`

---

## 1. Data Sources

The analysis uses publicly reported company disclosures from:

- Tata Consultancy Services (TCS)

- Infosys

- Wipro

- HCLTech

The primary source materials are quarterly financial results, fact sheets,

earnings releases, investor presentations, and financial statements published

by the companies.

The project uses company-reported figures rather than third-party databases

so that each observation can be traced back to an original disclosure.

### Source hierarchy

When multiple company documents were available, the following hierarchy was

used:

1. Official quarterly fact sheet / earnings release
2. Official quarterly investor presentation
3. Official financial results / regulatory filing
4. Official financial statements where required for clarification

Third-party websites were not used as the primary source for the numerical

dataset.

The source hierarchy was used as a practical collection and verification

framework. The exact document type can differ between companies because the

companies do not publish their quarterly information in identical formats.

---

## 2. Study Population and Time Period

The dataset covers four Indian IT-services companies:

| Company | Role in analysis |
|---|---|
| TCS | Primary company of interest |
| Infosys | Peer |
| Wipro | Peer |
| HCLTech | Peer |

The analytical period is:

**FY2022 Q1 through Q1 FY2027**

This produces:

- 21 quarterly observations per company
- 4 companies
- 84 expected rows in the final dataset

The `fiscal_year` field follows the project's fiscal-year convention documented

in `data_dictionary.md`.

Under this convention:

| Dataset value | Fiscal year | Fiscal period |
|---|---|---|
| `2022` | FY22 | Apr 2021 – Mar 2022 |
| `2023` | FY23 | Apr 2022 – Mar 2023 |
| `2024` | FY24 | Apr 2023 – Mar 2024 |
| `2025` | FY25 | Apr 2024 – Mar 2025 |
| `2026` | FY26 | Apr 2025 – Mar 2026 |
| `2027` | FY27 | Apr 2026 – Mar 2027 |

Company-reported quarter labels are retained when matching source documents.

The study ends at Q1 FY2027 because this is the latest quarter included in the

prepared dataset.

---

## 3. Metrics Collected

The prepared dataset contains the following source-level metrics.

| Field | Description |
|---|---|
| `company` | Company name |
| `fiscal_year` | Fiscal-year identifier used by the project |
| `quarter_num` | Quarter number, 1–4 |
| `revenue_cr` | Quarterly revenue converted to INR crore |
| `headcount` | Reported employee / workforce count |
| `net_profit_cr` | Quarterly net profit converted to INR crore |
| `ebit_margin_pct` | Reported EBIT / operating margin |
| `attrition_pct` | Reported attrition rate |
| `source_doc` | Source document used for the observation |

Derived analytical metrics such as QoQ growth, decoupling gap, revenue per

employee, and margin change are calculated later in SQL rather than manually

entered into the raw dataset.

This separation keeps the raw dataset focused on source-reported values while

allowing analytical calculations to remain reproducible in SQL.

---

## 4. Data Collection

For each company and quarter, the relevant official disclosure was reviewed

and the required metrics were extracted.

The collection process was:

1. Locate the company's official quarterly disclosure.
2. Identify the reporting quarter.
3. Locate the revenue figure.
4. Locate the reported headcount.
5. Locate net profit.
6. Locate EBIT / operating margin.
7. Locate attrition.
8. Record the source document name.
9. Convert units where required.
10. Enter the standardized values into the master spreadsheet.
11. Review the entered values against the source document.
12. Export the final standardized dataset to CSV.

The source document was retained for every observation to maintain

traceability.

Where a required metric was not located in the primary document, supporting

company disclosures were used where available.

The objective was to capture the closest company-reported equivalent of each

required metric rather than substitute a third-party estimate.

---

## 5. Metric Standardization

The companies do not always report their financial information using the same

units or terminology.

Before combining the data, values were standardized into a common schema.

### Revenue

Revenue was converted to:

**INR crore**

For example, when a source reported revenue in INR million:

`Revenue in crore = Revenue in million / 10`

The same standardized unit is used for all four companies.

This conversion allows revenue to be compared directly across companies and

quarters.

### Net Profit

Net profit was also standardized to:

**INR crore**

When reported in INR million:

`Net profit in crore = Net profit in million / 10`

Net profit is retained as a source-level metric even though the primary

business question focuses on revenue, headcount, and workforce efficiency.

It provides additional profitability context for the analysis.

### Headcount

Headcount was recorded as the reported workforce count.

No conversion to thousands or millions was applied in the final dataset.

The value represents the reported employee/workforce count for the relevant

quarter.

### Margins

EBIT / operating margin was recorded as a percentage.

For example:

`24.6`

represents:

`24.6%`

It is not stored as:

`0.246`

The same percentage-point convention is used when comparing margins across

companies and periods.

### Attrition

Attrition was recorded as a percentage.

For example:

`13.2`

represents:

`13.2%`

The reported company definition and period should be considered when

interpreting this metric because attrition reporting methodologies can differ.

Attrition is therefore used primarily for comparative trend analysis rather

than assuming that every company's reported percentage is calculated using an

identical methodology.

---

## 6. Handling Different Company Reporting Formats

The four companies do not publish identical documents or use identical labels.

For example:

- TCS frequently reports operating margin and workforce information in
  quarterly fact sheets.

- Infosys provides quarterly fact sheets containing revenue, margin,
  workforce, and attrition information.

- Wipro provides quarterly financial and investor disclosures containing the
  required financial metrics, with workforce and other operating information
  sometimes requiring supporting disclosures.

- HCLTech provides quarterly financial and investor materials from which the
  required metrics are extracted.

The exact source document therefore varies according to the company's

reporting format and the availability of the required metric.

The goal was not to copy identical table names across companies.

Instead, the project mapped equivalent business concepts into the standardized

dataset schema.

For example, different companies may use terms such as:

- Revenue
- Revenue from operations
- Operating revenue
- EBIT margin
- Operating margin
- Employees
- Headcount
- Total workforce

The relevant company-reported measure was mapped to the project's common

field only after reviewing the surrounding disclosure and reporting context.

---

## 7. Source Traceability

Every row contains a `source_doc` value.

This creates a direct relationship between:

`Company → Fiscal Year → Quarter → Source Document`

This is important because the dataset is manually assembled from public

company disclosures.

A source document can therefore be used to investigate:

- an unexpected value
- a large QoQ movement
- a potential data-entry error
- a unit-conversion issue
- a change in reporting terminology
- a difference between two company disclosures

The original source PDFs are retained in:

`data/raw/factsheets/`

The source filename recorded in `source_doc` should correspond to the actual

document used to extract the row.

This distinction is important because filenames are metadata for traceability;

they are not themselves the financial source.

---

## 8. Excel Master Dataset

The master data was initially maintained in:

`data/raw/company_financials.xlsx`

The spreadsheet was used as the working data-entry and review layer.

The final machine-readable dataset was exported as:

`data/raw/company_financials.csv`

CSV was selected as the main raw-data format because it is:

- lightweight
- portable
- easy to inspect
- compatible with Python
- compatible with PostgreSQL
- easy to version-control
- suitable for reproducible analysis

The Excel workbook remains useful as a human-readable review and data-entry

artifact, while the CSV provides a consistent machine-readable input for the

validation and database workflow.

The project therefore maintains a distinction between:

`Excel → working/master data-entry layer`

and

`CSV → standardized machine-readable dataset`

---

## 9. Standardized Dataset Structure

The final CSV follows this structure:

```text
company
fiscal_year
quarter_num
revenue_cr
headcount
net_profit_cr
ebit_margin_pct
attrition_pct
source_doc