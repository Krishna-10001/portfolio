  # Prepare

## Data Sources

The dataset was constructed from official company-published quarterly disclosures. Because the four companies do not publish their information in an identical format, source documents were reviewed and the relevant metrics were standardized into a common analytical schema.

| Source | Company | Metrics Used | Document Type | Access |
|---|---|---|---|---|
| Quarterly Data Sheets | TCS | Revenue, headcount, attrition, EBIT margin, net profit | Investor fact sheet (PDF) | Public, company-published |
| Quarterly Fact Sheets | Infosys | Revenue, headcount, attrition, EBIT margin, net profit | Investor fact sheet (PDF) | Public, company-published |
| Quarterly Fact Sheets | HCLTech | Revenue, headcount, attrition, EBIT margin, net profit | Investor fact sheet (PDF) | Public, company-published |
| Quarterly Results / Financial Disclosures | Wipro | Revenue, headcount, net profit, EBIT margin, attrition | Financial results / earnings disclosure (PDF) | Public, company-published |
| NASSCOM Strategic Review | Industry context | Sector-level revenue and employment context | Industry report | Public |

### Wipro Source Note

Wipro's standard investor fact sheets did not provide revenue and net profit in the same standardized format used by TCS, Infosys, and HCLTech.

For Wipro, these figures were therefore sourced from Wipro's official quarterly financial results and related financial disclosures.

This represents a difference in document format rather than a change in source authority. The figures remain based on Wipro's own published financial information.

---

## Dataset Scope

The final dataset covers:

- **4 companies:** TCS, Infosys, Wipro, HCLTech
- **21 quarters per company**
- **84 company-quarter observations**
- **FY2022 Q1 through FY2027 Q1**
- Revenue, headcount, profitability, and attrition metrics

The raw data was standardized into the following schema:

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