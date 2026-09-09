# Process

## Tools Used and Why
- **PostgreSQL** — stores the cleaned dataset and runs all analytical queries
  (window functions for QoQ growth, CTEs for the decoupling gap, `CORR()` for
  margin correlation). Chosen to demonstrate real SQL skill rather than doing
  all transformation in pandas.
- **Excel** — used for manual data entry from PDFs and initial validation
  (dropdowns for `company`/`quarter_num`, visual sanity checks) before export
  to CSV. Not used for analysis or final deliverables.
- **pgAdmin** — used to run schema creation, CSV import (Import/Export tool),
  and all analysis queries.
- **Python (pandas)** — used only for the standalone `validate_data.py` script,
  not for transformation or analysis.
- **Tableau** — the sole visualization/dashboard tool for this project.

## Data Integrity Checks
A validation pass (`scripts/validate_data.py`) was run against the raw CSV
before loading into Postgres, checking:
- No duplicate `(company, fiscal_year, quarter_num)` rows
- All 4 companies present, each with all 21 expected quarters (FY22 Q1–FY27 Q1)
- No unexpected NULLs in required columns
- `ebit_margin_pct` within 0–40%, `attrition_pct` within 0–100%, `revenue_cr`
  and `headcount` both > 0
- Every row has a non-blank `source_doc`
- Quarter-over-quarter swings flagged as warnings (not hard failures) for
  manual review

Result: the dataset passed with zero blocking errors. One large QoQ swing was
investigated and led to a real data-entry correction (below); two others were
investigated and confirmed as genuine business events, not errors.

## Cleaning Steps
1. **Company name standardization** — an initial inconsistency (`HCL Tech`
   with a space) was caught during validation and corrected to `HCLTech`,
   matching `TCS`, `Infosys`, and `Wipro` casing. Inconsistent naming would
   silently break `GROUP BY`/`JOIN` operations downstream.
2. **TCS Q4 FY26-27 revenue correction** — the QoQ outlier check flagged a
   60% single-quarter revenue drop followed by a 170% "recovery" the next
   quarter, with an implausible 51% implied net margin on the flagged row.
   Re-checked against the source PDF and corrected to the true reported figure.
3. **Wipro source substitution** — revenue, headcount, net profit, and EBIT
   margin for Wipro were sourced from quarterly results press releases instead
   of fact sheets, since Wipro's fact sheets don't disclose these figures in
   the same format as the other three companies. See `02_prepare.md` for
   details. This was a deliberate substitution, not a data quality compromise
   — both document types are Wipro's own official disclosures.
4. **Period label standardization** — settled on `Period A (FY22 TO FY24)` /
   `Period B (FY25 TO FY27 Q1)` as the exact label format, applied consistently
   across all SQL queries, documentation, and the Tableau dashboard.
5. **Column typing** — `fiscal_year` and `quarter_num` stored as separate
   integer columns (not a combined text field like `'FY22Q1'`) to support
   clean `ORDER BY`/window-function behavior in SQL.

## Verifying the Data Is Clean and Ready to Analyze
- Re-ran `validate_data.py` after all corrections — zero blocking errors, one
  expected informational warning (a small margin-gap flag on an already-explained
  Infosys one-off item).
- Cross-checked implied net margin (`net_profit_cr / revenue_cr`) against
  reported `ebit_margin_pct` as an independent sanity check across all 84 rows.
- Row count confirmed at 84 (4 companies × 21 quarters) after loading into
  Postgres, via `SELECT COUNT(*) FROM company_financials;`.