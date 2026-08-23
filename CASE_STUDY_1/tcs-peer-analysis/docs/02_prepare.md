# Prepare

## Data Sources
| Source | Company | What it provides | License / Access | Link type |
|---|---|---|---|---|
| Quarterly Investor Fact Sheets | TCS | Revenue, headcount, attrition, EBIT margin | Public, company-published | tcs.com/investors |
| Quarterly Investor Fact Sheets | Infosys | Same as above | Public, company-published | infosys.com/investors |
| Quarterly Investor Fact Sheets | Wipro | Same as above | Public, company-published | wipro.com/investors |
| Quarterly Investor Fact Sheets | HCLTech | Same as above | Public, company-published | hcltech.com/investors |
| NASSCOM Strategic Review | Sector-wide | Industry-level revenue/employment growth (context, not per-company data) | Public report | nasscom.in |



## Time Window & Period Definition
- **Full range:** FY2022–FY2026 (April 2021 – March 2026), 20 fiscal quarters, all four companies
- **Fiscal year convention used throughout:** FY22 = Apr 2021–Mar 2022, etc. — matches how each company labels its own filings, avoiding calendar-year ambiguity
- Two comparison periods will be used **only at the visualization/analysis layer** (Tableau calculated field / filter), not stored as a column in the raw or processed data:
  - Period A (baseline): FY22–FY24
  - Period B (AI-productivity window): FY25–FY26
- Rationale for keeping this out of the schema: the period boundary is an analytical framing choice, not a fact about the data. Deriving it downstream (via a `CASE WHEN fiscal_year <= 'FY24' THEN 'Period A' ELSE 'Period B' END` style calculated field) keeps the stored data reusable and keeps the interpretation clearly separated from the raw facts.

## How is the Data Organized?
Each company publishes its own quarterly fact sheet as a PDF/press release, not a shared standardized table across companies — so structuring this into one consistent schema (`company, fiscal_year, fiscal_quarter, revenue_cr, headcount, attrition_pct, ebit_margin_pct`) is itself one of the core data-prep tasks for this project, not just a formality.

## ROCCC Check
- **Reliable:** High — figures come directly from SEBI-mandated quarterly disclosures, not third-party aggregation.
- **Original:** High — sourced directly from each company's investor relations page, not a secondary compiler.
- **Comprehensive:** Moderate — covers financial/workforce metrics well, but says nothing about employee sentiment, skill mix, or deal pipeline (explicitly out of scope, see `01_ask.md`).
- **Current:** High — through FY26 filings.
- **Cited:** High — every figure traceable to a specific quarterly report.

## Known Limitations
1. **Baseline-period confound:** FY22–FY23 was itself a post-COVID hiring surge followed by a correction, not a "quiet" baseline. Any AI-productivity effect observed in Period B should be read against this — the analysis can show a *temporal association* between periods, not establish that AI *caused* the shift.
2. **Manual data entry risk:** since there's no unified API across all four companies' fact sheets, all figures are hand-extracted from PDFs — cross-checking against a second source (e.g. screener.in) is planned as a validation step in `03_process.md`.
3. **Attrition and margin definitions vary slightly** across companies (e.g. LTM attrition vs. quarterly annualized attrition) — this will be standardized during processing, and the standardization method will be documented in `03_process.md`.

## How This Helps Answer the Business Question
Structuring 20 quarters × 4 companies × 5 metrics into one consistent table makes it possible to directly compare revenue-per-employee trajectories, test whether TCS's headcount reduction is sector-wide or company-specific, and quantify — rather than just describe — the shift referenced in the business task.