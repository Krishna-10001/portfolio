# Ask

## Business Task

Analyze how TCS's revenue, headcount, attrition, and profitability trends compare to its closest industry peers — Infosys, Wipro, and HCLTech — from FY2022 through Q1 FY2027.

The analysis focuses on whether revenue growth is becoming less dependent on proportional headcount growth and whether TCS is experiencing this change at a different pace from its selected Indian IT-services peers.

The project uses publicly reported quarterly financial and workforce data to examine the relationship between:

- Revenue growth
- Headcount growth
- Revenue per employee
- Attrition
- EBIT margin
- Net profit and net profit margin

The analysis is designed to test whether the traditional linear relationship of "more headcount = more revenue" appears to be changing in the selected peer group.

The objective is not to assume that AI, layoffs, demand weakness, or cost discipline caused the observed changes. Instead, the project identifies measurable patterns in the available data and evaluates possible explanations separately.

---

## Business Context

Through FY26, TCS reduced its workforce while continuing to report revenue growth. This created broader discussion around whether the traditional IT-services workforce model is changing.

Several possible explanations can be considered:

- AI and automation may allow some work to be delivered with fewer incremental employees.
- Demand conditions may have reduced the need for aggressive hiring.
- Companies may have increased utilization or changed workforce mix.
- Cost discipline may have influenced workforce decisions.
- Changes in service mix, pricing, acquisitions, or subcontracting may affect revenue without proportional changes in employee count.

These explanations are not treated as established causes in this project.

Instead, the analysis asks whether the underlying financial and workforce data show a measurable change in the relationship between revenue and headcount.

To avoid analyzing TCS in isolation, the project compares TCS with Infosys, Wipro, and HCLTech over the same broad period.

This allows the analysis to distinguish between:

1. A pattern that appears primarily company-specific.
2. A pattern shared by several companies in the selected peer group.
3. A pattern that is inconsistent across companies.

The project therefore treats the discussion around changing IT-services hiring models as a testable business question rather than as a predetermined conclusion.

---

## Key Stakeholders

### IT-Services Industry Analysts and Investors

Analysts can use the comparison to understand how revenue growth, workforce size, profitability, and efficiency have changed across major Indian IT-services companies.

### HR and Workforce-Planning Teams

Workforce-planning teams can use the analysis to evaluate whether changes in revenue are being accompanied by proportional changes in employee count.

### Business and Operations Leaders

Business leaders can use the analysis to identify whether workforce efficiency, profitability, and revenue growth are moving together or becoming less tightly coupled.

### Job Seekers and Current Employees

Employees and job seekers can use the analysis as a data-based view of changing workforce trends in the selected IT-services companies.

The analysis does not attempt to predict individual employment outcomes or future hiring decisions.

---

## Primary Business Question

**Is TCS's revenue growth becoming less dependent on proportional headcount growth, and how does the magnitude of this change compare with Infosys, Wipro, and HCLTech?**

The analysis uses quarterly revenue and headcount growth to quantify this relationship.

---

## Guiding Questions

### Question 1 — Revenue, Workforce, Attrition and Profitability

How do TCS's revenue, headcount, attrition rate, and EBIT margin trend quarter over quarter compared with Infosys, Wipro, and HCLTech from FY22 through Q1 FY27?

This establishes the overall operating context before focusing specifically on decoupling.

---

### Question 2 — Decoupling Improvement

Which company showed the **largest improvement in decoupling** between Period A and Period B?

Decoupling is measured using:

`Decoupling Gap = Revenue QoQ Growth % − Headcount QoQ Growth %`

A positive gap means revenue growth exceeded headcount growth during that quarter.

The comparison focuses on the change in the average decoupling gap between the two defined periods rather than simply comparing one quarter.

---

### Question 3 — TCS Versus the Selected Peer Group

Is TCS behaving differently from the selected peer group, or are multiple companies showing a similar change in the relationship between revenue and headcount?

The purpose is to determine whether the observed pattern appears primarily TCS-specific or is also visible among Infosys, Wipro, and HCLTech.

The project does not claim that four companies represent the entire Indian IT-services industry.

---

### Question 4 — Revenue Per Employee

How has revenue per employee changed across TCS and its selected peers?

Revenue per employee is used as an efficiency proxy:

`Revenue Per Employee = Quarterly Revenue / Closing Headcount`

Because revenue is stored in ₹ crore, the SQL calculation converts the result into Indian rupees.

Revenue per employee is interpreted as an organizational efficiency measure rather than as a direct measure of individual employee productivity.

---

### Question 5 — Profitability and Workforce Change

Does EBIT margin change show a stronger relationship with headcount growth or revenue growth across the selected companies?

Correlation analysis is used as an exploratory technique.

The analysis identifies relationships in the observed quarterly data but does not establish that headcount changes or revenue growth caused margin changes.

---

## Hypothesis

### Primary Hypothesis

The project tests whether revenue growth became less tightly coupled with headcount growth during the later part of the study period.

The expected pattern would be:

- Revenue continues to grow or remain relatively resilient.
- Headcount growth slows or becomes negative.
- Revenue per employee increases.
- The revenue-over-headcount growth gap becomes wider.

This is a testable hypothesis rather than a predetermined conclusion.

---

### Possible Explanatory Factors

If the data shows a widening revenue-headcount gap, several explanations may be investigated:

- AI and automation
- Productivity improvements
- Utilization changes
- Workforce mix changes
- Cost discipline
- Demand conditions
- Pricing
- Service mix
- Acquisitions
- Subcontracting

The current dataset does not contain enough information to isolate these factors or establish causality.

Therefore, AI adoption is treated as a possible explanatory hypothesis rather than as a proven driver.

---

## Scope

### Companies

The analysis covers four large Indian IT-services companies:

- TCS
- Infosys
- Wipro
- HCLTech

These companies form the selected peer group for this case study.

---

### Time Period

The dataset covers:

**FY2022 Q1 through Q1 FY2027**

This represents **21 fiscal quarters per company**.

The fiscal-year convention used in the dataset is:

- `fiscal_year = 2022` represents FY22, covering April 2021 through March 2022.
- `fiscal_year = 2023` represents FY23, covering April 2022 through March 2023.
- This convention continues through FY2027.

Therefore, the underlying source-document naming can contain the two calendar years represented by the fiscal year. For example:

`TCS-Q1-FY21-22`

corresponds to the company's Q1 FY22 period beginning in April 2021.

---

## Period Definitions

The analysis divides the dataset into two comparison periods.

### Period A — Baseline Period

**FY22 through FY24**

This period provides the earlier-period benchmark against which the later period is compared.

Period A contains 12 fiscal quarters in the raw dataset.

However, only **11 quarters per company have usable QoQ growth values** because FY22 Q1 is the first observation in the dataset and has no previous quarter available within the study period.

---

### Period B — Later Period

**FY25 through Q1 FY27**

This period contains 9 fiscal quarters per company.

The comparison between Period A and Period B is based on the available QoQ-derived observations within each period.

---

## Key Metrics

### Revenue

Quarterly revenue reported by each company, standardized into ₹ crore.

Field:

`revenue_cr`

---

### Headcount

Closing employee headcount reported for the quarter.

Field:

`headcount`

Headcount is treated as a point-in-time workforce measure rather than average quarterly employment.

---

### Revenue QoQ Growth

Quarter-over-quarter percentage change in revenue:

`Revenue QoQ Growth % = ((Current Revenue − Previous Revenue) / Previous Revenue) × 100`

The previous quarter is obtained using SQL `LAG()` within each company.

---

### Headcount QoQ Growth

Quarter-over-quarter percentage change in headcount:

`Headcount QoQ Growth % = ((Current Headcount − Previous Headcount) / Previous Headcount) × 100`

The previous quarter is obtained using SQL `LAG()` within each company.

---

### Decoupling Gap

The primary analytical metric:

`Decoupling Gap = Revenue QoQ Growth % − Headcount QoQ Growth %`

Interpretation:

- **Positive gap:** revenue growth exceeded headcount growth.
- **Negative gap:** headcount growth exceeded revenue growth.
- **Larger positive gap:** a wider separation between revenue growth and workforce growth.

The metric does not by itself identify the cause of the gap.

---

### Revenue Per Employee

Revenue per employee is calculated as:

`Revenue Per Employee = (Revenue in ₹ crore × 10,000,000) / Headcount`

The result is expressed in Indian rupees.

This metric is used as an efficiency proxy.

It should not be interpreted as the amount of revenue generated individually by each employee because company revenue is affected by many organizational and market factors.

---

### EBIT Margin

EBIT margin is used as the primary operating profitability metric.

Field:

`ebit_margin_pct`

It is used to evaluate whether workforce and revenue changes occur alongside changes in operating profitability.

Reported definitions may vary slightly between companies, so the source methodology is documented during data preparation.

---

### Net Profit

Quarterly net profit is stored in ₹ crore.

Field:

`net_profit_cr`

Net profit is used as a secondary profitability measure.

---

### Net Profit Margin

Net profit margin is derived as:

`Net Profit Margin % = (Net Profit / Revenue) × 100`

This provides additional context when interpreting changes in revenue and profitability.

---

### Attrition

Quarterly reported attrition rate.

Field:

`attrition_pct`

Where companies report attrition on a trailing twelve-month basis or another disclosed basis, the reported company metric is retained rather than attempting to artificially convert it into a different definition.

---

## Data Sources

The analysis uses publicly available company disclosures.

Primary sources include quarterly financial results, investor fact sheets, investor releases, and company-reported workforce information.

The source documents cover:

- Revenue
- Headcount
- Net profit
- EBIT or operating margin
- Attrition
- Quarterly reporting period

The project maintains a `source_doc` field for each row of the raw dataset so that extracted values can be traced back to the corresponding source document.

Source documents are stored under:

`data/raw/factsheets/`

The standardized dataset is stored under:

`data/raw/company_financials.csv`

The Excel version is also retained as a preparation-stage source file.

---

## Source Data Standardization

The companies do not publish their quarterly information in exactly the same format.

Differences can include:

- Document structure
- Metric naming
- Currency presentation
- Units
- Margin terminology
- Attrition definitions
- Headcount presentation
- Source-document type

The project therefore standardizes the extracted information into a common analytical structure while preserving the original reported values and source-document traceability.

The standard raw schema contains:

- `company`
- `fiscal_year`
- `quarter_num`
- `revenue_cr`
- `headcount`
- `net_profit_cr`
- `ebit_margin_pct`
- `attrition_pct`
- `source_doc`

---

## Analytical Approach

The analysis follows an end-to-end data analytics workflow.

### 1. Ask

Define the business problem, stakeholders, questions, hypothesis, scope, and success criteria.

### 2. Prepare

Collect quarterly company disclosures and standardize the reported metrics into a common dataset.

### 3. Process

Validate the dataset using Python and PostgreSQL, check completeness and duplicates, and prepare the data for analysis.

### 4. Analyze

Use SQL transformations to calculate:

- QoQ revenue growth
- QoQ headcount growth
- Decoupling gap
- Revenue per employee
- Net profit margin
- Period-level averages
- TCS versus peer benchmarks
- Margin/headcount relationships

### 5. Share

Present the findings through an interactive Tableau dashboard and supporting visualizations.

### 6. Act

Translate the observed patterns into business recommendations while clearly separating evidence from assumptions and causal explanations.

---

## Analytical Design

The analysis uses quarterly observations rather than annual aggregates because quarterly data allows changes in revenue and headcount to be compared more closely over time.

SQL window functions are used to compare each quarter with the previous quarter for the same company.

The main transformation is:

`LAG(revenue_cr) OVER (PARTITION BY company ORDER BY fiscal_year, quarter_num)`

and similarly for headcount.

This creates the previous-quarter values required for the QoQ calculations.

---

## First-Quarter Treatment

FY22 Q1 is the first observation for every company in the dataset.

Because the project begins at FY22 Q1, there is no FY21 Q4 observation available in the dataset to calculate a QoQ change.

Therefore:

- FY22 Q1 revenue QoQ growth = `NULL`
- FY22 Q1 headcount QoQ growth = `NULL`
- FY22 Q1 decoupling gap = `NULL`

These observations remain in the dataset for completeness but are excluded from calculations that require a prior quarter.

This is why Period A has 12 raw quarters but only 11 usable QoQ observations per company.

---

## Comparative Analysis

The analysis compares companies on both absolute levels and changes over time.

This distinction is important.

For example:

- A company may have a higher revenue per employee but a smaller improvement in revenue per employee.
- A company may have a larger decoupling gap but not the largest change between Period A and Period B.
- A company may reduce headcount while simultaneously experiencing weaker revenue growth.
- A company may improve its decoupling gap without improving EBIT margin.

Therefore, no single metric is used as a standalone measure of performance.

---

## TCS Versus Peer Analysis

TCS is compared with the average performance of Infosys, Wipro, and HCLTech where appropriate.

The peer benchmark is used to answer whether TCS's observed pattern is:

- Larger than the selected peer group,
- Similar to the selected peer group, or
- Different from the selected peer group.

The comparison is descriptive and does not imply that the peer average represents the entire Indian IT-services sector.

---

## Profitability Analysis

EBIT margin is used as the primary measure of operating profitability.

The analysis examines:

- Average EBIT margin by period
- Changes in EBIT margin between periods
- Revenue growth alongside margin changes
- Headcount growth alongside margin changes
- Correlation between margin changes and workforce/revenue changes

Net profit and net profit margin are included as additional context rather than replacing EBIT margin.

---

## Correlation Analysis

Correlation is used to examine whether quarterly changes in EBIT margin move together with:

1. Headcount QoQ growth
2. Revenue QoQ growth

The analysis uses quarterly observations for each company.

Correlation coefficients are interpreted as directional evidence only.

A correlation does not establish:

- Causation
- Direction of causality
- Statistical significance by itself
- A permanent structural relationship
- That one variable caused another to change

Additional operational and financial variables would be required for a causal analysis.

---

## Outlier and Context Treatment

Large movements are not automatically removed from the dataset.

If an unusual movement can be linked to a documented business event, it is retained and interpreted with context.

For example, Wipro's FY23 Q2 revenue movement is treated as an important contextual observation because acquisitions including Capco and Rizing affected reported revenue.

The purpose of this treatment is to avoid silently removing genuine business events simply because they create large statistical movements.

---

## What the Analysis Is Designed to Establish

The analysis is designed to establish whether the selected companies show measurable changes in the relationship between:

- Revenue growth
- Headcount growth
- Revenue per employee
- Attrition
- Operating profitability

It can identify whether the observed pattern is more pronounced for TCS or appears across multiple companies in the selected peer group.

---

## What the Analysis Is Not Designed to Establish

The analysis cannot establish that:

- AI caused headcount reductions.
- AI directly increased revenue per employee.
- Layoffs caused margin improvement.
- Headcount reduction caused revenue growth.
- The entire Indian IT-services industry is permanently moving toward lower hiring.
- Revenue per employee represents individual employee productivity.
- The four selected companies represent every company in the Indian IT-services sector.
- Correlation between two variables proves causation.

These questions require additional operational, financial, workforce, and technology-adoption data.

---

## Important Analytical Limitations

### 1. Limited Company Coverage

The study covers four large IT-services companies.

The results describe the selected peer group and should not automatically be generalized to the entire Indian IT-services industry.

### 2. Public Disclosure Differences

Companies do not always report metrics using identical definitions or formats.

Attrition and margin definitions can differ, so comparisons should be interpreted with the disclosed methodology in mind.

### 3. Limited Time Period

The study covers FY22 Q1 through Q1 FY27.

This is sufficient for a comparative quarterly analysis but may not be sufficient to establish a permanent structural change in the industry.

### 4. Revenue Per Employee Is a Proxy

Revenue per employee is an organizational efficiency indicator.

It does not measure individual employee productivity because revenue is affected by pricing, service mix, utilization, subcontracting, acquisitions, geography, and other factors.

### 5. Correlation Is Not Causation

The correlation analysis identifies directional relationships in the observed quarterly data.

It does not establish causal relationships.

### 6. AI Cannot Be Tested Directly With the Current Dataset

The dataset does not contain a standardized measure of:

- AI adoption
- Automation intensity
- AI-related revenue
- AI-related workforce savings
- Productivity per AI-enabled employee

Therefore, AI remains a possible explanatory hypothesis rather than a conclusion supported directly by the dataset.

### 7. Acquisition Effects

Acquisitions can affect revenue and headcount independently of organic operating performance.

Documented acquisition-related movements are therefore retained and interpreted as contextual events.

---

## Expected Business Value

The analysis provides a structured way to evaluate whether revenue growth and workforce growth are moving together across major Indian IT-services companies.

Instead of using headcount alone as a proxy for business expansion, stakeholders can evaluate:

- Revenue growth
- Workforce growth
- Decoupling gap
- Revenue per employee
- Attrition
- EBIT margin

Together, these metrics provide a broader view of workforce efficiency and operating performance.

The analysis can also identify areas where additional data would be required before making workforce or strategic decisions.

---

## Key Deliverables

The project produces the following outputs:

1. A documented business problem and analytical scope.
2. A standardized quarterly company dataset.
3. Source-document traceability for extracted data.
4. Python-based data validation.
5. A PostgreSQL analytical database.
6. Reproducible SQL analysis queries.
7. A final analytical dataset for visualization.
8. Comparative analysis of TCS, Infosys, Wipro, and HCLTech.
9. An interactive Tableau dashboard.
10. Supporting Tableau visualizations.
11. Analytical findings and limitations.
12. Business recommendations based on the observed evidence.

---

## Tableau Dashboard

The final dashboard presents the analysis through multiple views, including:

### 1. Decoupling Gap Trend

Shows how the revenue-versus-headcount growth gap changes quarter over quarter for each company.

### 2. Period Comparison

Compares the average decoupling gap between Period A and Period B.

### 3. Revenue Growth vs Headcount Growth

Shows the relationship between quarterly revenue growth and quarterly headcount growth.

The bottom-right quadrant represents quarters where revenue growth was positive while headcount growth was negative.

### 4. Revenue Per Employee Trend

Shows changes in revenue per employee across the selected companies.

### 5. EBIT Margin Change vs Headcount Growth

Explores the relationship between workforce growth and changes in operating margin.

Supporting analysis also includes attrition trends and correlation analysis.

---

## Success Criteria

The project is considered successful if it can answer the following questions using reproducible data and documented calculations:

- How did revenue and headcount growth change across the selected companies?
- Did the decoupling gap widen or narrow between Period A and Period B?
- Which company showed the largest improvement in decoupling?
- Did TCS behave differently from the selected peer group?
- How did revenue per employee change?
- How did attrition change?
- How did EBIT margin change?
- What relationships exist between workforce growth, revenue growth, and profitability?
- What can and cannot be concluded from the available data?

---

## End-to-End Workflow

```text
Public Company Disclosures
        ↓
Quarterly Financial & Workforce Data
        ↓
Excel / CSV Data Preparation
        ↓
Python Data Validation
        ↓
PostgreSQL Database
        ↓
SQL Transformation & Analysis
        ↓
Final Analytical Dataset
        ↓
Tableau Visualizations
        ↓
Interactive Dashboard
        ↓
Business Findings & Recommendations