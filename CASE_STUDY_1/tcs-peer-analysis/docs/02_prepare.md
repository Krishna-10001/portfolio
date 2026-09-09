# Prepare

## Data Sources
| Source | Company | What it provides | Document type | License / Access |
|---|---|---|---|---|
| Quarterly Data Sheets | TCS | Revenue, headcount, attrition, EBIT margin | Investor fact sheet (PDF) | Public, company-published |
| Quarterly Fact Sheets | Infosys | Same as above | Investor fact sheet (PDF) | Public, company-published |
| Quarterly Fact Sheets | HCLTech | Same as above | Investor fact sheet (PDF) | Public, company-published |
| Quarterly Results Press Releases | Wipro | Revenue, headcount, net profit, EBIT margin | Financial statements / earnings press release (PDF) | Public, company-published |
| NASSCOM Strategic Review | Sector-wide | Industry-level revenue/employment growth (context, not per-company data) | Public report | nasscom.in |

**Note on Wipro's source difference:** Wipro's standard investor fact sheets did
not disclose revenue and net profit in the same standardized format used by TCS,
Infosys, and HCLTech. Wipro's financial figures (revenue, headcount, net profit,
EBIT margin) were instead sourced from Wipro's quarterly "Results for the Quarter"
press releases, which report the same figures under IFRS. This is a difference in
*document format*, not in *data quality or source authority* — both are Wipro's
own official published financial disclosures.

## Time Window & Period Definition
- **Full range:** FY2022 Q1 – FY2027 Q1 (April 2021 – June 2026), 21 fiscal
  quarters, all four companies
- **Fiscal year convention used throughout:** FY22 = Apr 2021–Mar 2022, etc. —
  matches how each company labels its own filings, avoiding calendar-year ambiguity
- **FY27 Q1 note:** included as the most recent available quarter at time of
  analysis, extending one quarter beyond the original 20-quarter (FY22–FY26)
  scope, to capture the latest signal in the AI-productivity period
- Two comparison periods, applied only at the query/visualization layer — never
  stored as a column in the raw or processed data:
  - **Period A (FY22 TO FY24)** — baseline, 12 quarters
  - **Period B (FY25 TO FY27 Q1)** — AI-productivity window, 9 quarters
- Rationale for keeping this out of the schema: the period boundary is an
  analytical framing choice, not a fact about the data. Deriving it downstream
  (via a `CASE WHEN fiscal_year BETWEEN 2022 AND 2024 THEN 'Period A (FY22 TO
  FY24)' ELSE 'Period B (FY25 TO FY27 Q1)' END` calculated field) keeps the
  stored data reusable and keeps interpretation clearly separated from raw facts.

## How is the Data Organized?
Each company publishes its own quarterly disclosure as a PDF (fact sheet or press
release), not a shared standardized table across companies — so structuring this
into one consistent schema (`company, fiscal_year, quarter_num, revenue_cr,
headcount, net_profit_cr, ebit_margin_pct, attrition_pct, source_doc`) is itself
one of the core data-prep tasks for this project, not just a formality.

## ROCCC Check
- **Reliable:** High — figures come directly from SEBI-mandated quarterly
  disclosures, not third-party aggregation.
- **Original:** High — sourced directly from each company's investor relations
  page, not a secondary compiler.
- **Comprehensive:** Moderate — covers financial/workforce metrics well, but
  says nothing about employee sentiment, skill mix, or deal pipeline (explicitly
  out of scope, see `01_ask.md`).
- **Current:** High — through Q1 FY27 filings.
- **Cited:** High — every figure traceable to a specific quarterly report via
  `source_doc`.

## Known Limitations
1. **Baseline-period confound:** FY22–FY23 was itself a post-COVID hiring surge
   followed by a correction, not a "quiet" baseline. Any AI-productivity effect
   observed in Period B should be read against this — the analysis can show a
   *temporal association* between periods, not establish that AI *caused* the shift.
2. **Manual data entry risk:** since there's no unified API across all four
   companies' disclosures, all figures were hand-extracted from PDFs. A
   validation pass (duplicate check, range check, completeness check, QoQ
   outlier check) was run before loading; one entry error (TCS Q4 FY26-27
   revenue) was caught this way and corrected against the source PDF.
3. **Attrition and margin definitions vary slightly** across companies (e.g.
   LTM attrition vs. quarterly annualized attrition) — standardization approach
   documented in `03_process.md`.
4. **Source document type varies for Wipro** (press release vs. fact sheet used
   by the other three companies) — see Data Sources note above.
5. **Two legitimate outliers, not errors:** Wipro's FY23 Q2 revenue jump reflects
   the Capco/Rizing acquisitions (inorganic growth), and Infosys's FY24 Q4
   profit jump reflects a one-off item — both flagged here so they aren't
   mistaken for cleaning errors later.
6. **Correlation sample size:** margin/headcount/revenue correlation coefficients
   are based on 20 quarters per company (21 quarters minus 1 for the QoQ lag) —
   read as directional evidence, not statistically robust proof.

## How This Helps Answer the Business Question
Structuring 21 quarters × 4 companies × metrics into one consistent table makes
it possible to directly compare revenue-per-employee and decoupling-gap
trajectories, test whether TCS's headcount reduction is sector-wide or
company-specific, and quantify — rather than just describe — the shift
referenced in the business task.