# TCS vs. Peer IT Majors — Revenue, Headcount & Margin Trend Analysis

A data analytics case study examining whether TCS's 2025-26 workforce reduction reflects
a structural shift in the IT services business model, benchmarked against Infosys, Wipro,
and HCLTech.

## Business Question
Is TCS decoupling revenue growth from headcount growth faster than its industry peers,
and what does that mean for the traditional IT-services hiring pyramid?

## Tools
SQL (PostgreSQL) · Python (pandas, for data validation) · Tableau

## Project Structure
- `docs/` — Ask, Prepare, Process, Analyze, Share, Act documentation
- `data/` — raw and processed datasets
- `sql/` — schema and analysis queries
- `scripts/` — data validation script
- `dashboards/` — final Tableau workbook
- `reports/` — exported visuals

## Key Findings
- **TCS is not the strongest "decoupler" among its peers.** Its average
  decoupling gap (revenue QoQ growth % minus headcount QoQ growth %) rose from
  1.21pp in Period A (FY22 TO FY24) to 2.01pp in Period B (FY25 TO FY27 Q1) —
  a real increase, but smaller than HCLTech's (+1.43pp) and Infosys's
  (+1.06pp). Wipro's gap actually narrowed (0.95pp → 0.68pp). The popular
  narrative that TCS is leading an AI-driven productivity shift is only
  partially supported once benchmarked against peers — the shift looks more
  sector-wide than TCS-specific, and where it's happening, TCS isn't the
  front-runner.
- **Margin trends don't track decoupling in a simple way.** TCS held the
  highest EBIT margin of all four companies in both periods (~24.6%,
  essentially flat), while Infosys and HCLTech saw margins decline slightly
  (21.6%→20.8%, 18.4%→17.7%) even as their decoupling gaps widened. Wipro's
  margin improved (16.5%→17.1%) despite the weakest decoupling trend of the four.
- **Attrition fell across all four companies, not just TCS** — TCS
  (16.2%→13.2%), Infosys (20.4%→13.3%), HCLTech (17.8%→12.8%), and Wipro
  (19.2%→14.5%) all show the same cooling pattern, consistent with an
  industry-wide hiring slowdown rather than a company-specific one.
- **Correlation results are mixed and company-specific.** Margin change
  correlates negatively with headcount growth at TCS (-0.35), Infosys (-0.43),
  and Wipro (-0.57). HCLTech is the exception (-0.06) but shows the strongest
  positive correlation between margin and revenue growth (0.67) — its margin
  story looks more top-line-driven than cost-driven. (Based on 20 quarters
  per company — directional, not statistically robust.)

## Dashboard
_(add your Tableau Public link once published)_

## Author
Krishna Jagtap