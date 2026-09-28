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
in `data_dictionary.md`. Company-reported quarter labels are retained when
matching source documents.

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
11. Export the final standardized dataset to CSV.

The source document was retained for every observation to maintain
traceability.

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

### Net Profit

Net profit was also standardized to:

**INR crore**

When reported in INR million:

`Net profit in crore = Net profit in million / 10`

### Headcount

Headcount was recorded as the reported workforce count.

No conversion to thousands or millions was applied in the final dataset.

### Margins

EBIT / operating margin was recorded as a percentage.

For example:

`24.6`

represents:

`24.6%`

It is not stored as:

`0.246`

### Attrition

Attrition was recorded as a percentage.

For example:

`13.2`

represents:

`13.2%`

The reported company definition and period should be considered when interpreting
this metric because attrition reporting methodologies can differ.

---

## 6. Handling Different Company Reporting Formats

The four companies do not publish identical documents or use identical labels.

For example:

- TCS frequently reports operating margin and workforce information in
  quarterly fact sheets.
- Infosys provides quarterly fact sheets containing revenue, margin,
  workforce, and attrition information.
- Wipro provides financial results and regulatory filings containing the
  required financial metrics, with workforce and acquisition information
  sometimes requiring supporting disclosures.
- HCLTech provides quarterly financial and investor materials from which the
  required metrics are extracted.

The goal was therefore not to copy identical table names across companies.

Instead, the project mapped equivalent business concepts into the standardized
dataset schema.

---

## 7. Source Traceability

Every row contains a `source_doc` value.

This creates a direct relationship between:

`Company → Fiscal Year → Quarter → Source Document`

This is important because the dataset is manually assembled from public
company disclosures.

A source document can therefore be used to investigate an unexpected value,
large QoQ movement, or potential data-entry error.

The original source PDFs are retained in:

`data/raw/factsheets/`

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