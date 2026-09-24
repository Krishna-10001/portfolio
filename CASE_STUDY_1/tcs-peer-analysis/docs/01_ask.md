# Ask

## Business Task

Analyze how revenue, headcount, attrition, and profitability have changed across TCS, Infosys, Wipro, and HCLTech from FY2022 Q1 through Q1 FY2027.

The primary objective is to determine whether revenue growth is becoming increasingly decoupled from headcount growth across the peer group, whether TCS's pattern differs from its peers, and what these trends indicate about the traditional linear "more headcount = more revenue" model in Indian IT services.

## Context

Through FY26, TCS reduced its workforce while revenue continued to grow, prompting broader discussion about whether changes in productivity, demand, cost discipline, automation, or AI adoption are altering the traditional IT-services workforce model.

Rather than assuming a particular explanation, this project treats the changing relationship between revenue and headcount as a testable analytical question.

The analysis compares TCS with Infosys, Wipro, and HCLTech using publicly reported quarterly financial and workforce data through Q1 FY2027.

AI-driven productivity is considered a possible explanatory factor, but the available dataset does not contain sufficient evidence to establish AI as the cause of observed workforce or revenue changes.

## Key Stakeholders

- IT-services industry analysts and investors monitoring revenue, workforce, and profitability trends
- Workforce-planning and strategy teams benchmarking business performance against industry peers
- Business leaders evaluating the relationship between workforce growth, revenue growth, and operating efficiency
- Job seekers and employees seeking to understand broader changes in the traditional IT-services hiring model

## Guiding Questions

### Revenue, Workforce and Profitability

1. How do revenue, headcount, attrition, and EBIT margin change quarter over quarter across TCS, Infosys, Wipro, and HCLTech from FY2022 Q1 through Q1 FY2027?

### Revenue–Headcount Decoupling

2. To what extent does revenue growth outpace headcount growth across the four companies, and how does this relationship change between the two study periods?

3. How does TCS's change in revenue–headcount decoupling compare with Infosys, Wipro, and HCLTech?

4. Is the observed change primarily a TCS-specific pattern, or is a similar pattern visible across multiple companies in the peer group?

### Efficiency and Profitability

5. How does revenue per employee change across the peer group between the two study periods?

6. What relationship, if any, exists between changes in EBIT margin and changes in headcount growth?

## Scope

### Companies

- Tata Consultancy Services (TCS)
- Infosys
- Wipro
- HCLTech

### Time Period

- FY2022 Q1 through Q1 FY2027
- 21 fiscal quarters per company
- 84 company-quarter observations

### Primary Metrics

- Revenue
- Headcount
- Revenue QoQ growth
- Headcount QoQ growth
- Decoupling gap
- Revenue per employee
- EBIT margin
- EBIT margin change
- Attrition rate

### Out of Scope

The following are outside the scope of the current analysis and may be considered for future research:

- Stock-price performance
- Employee sentiment and reviews
- Job postings and hiring-demand data
- Business-unit or geography-level analysis
- Direct measurement of AI or automation adoption
- Causal estimation of the effect of AI on employment or productivity

## Analytical Approach

### Decoupling Gap

The primary analytical metric is:

**Decoupling Gap = Revenue QoQ Growth % − Headcount QoQ Growth %**

Interpretation:

- **Positive gap:** Revenue growth outpaced headcount growth.
- **Zero gap:** Revenue and headcount changed at approximately the same rate.
- **Negative gap:** Headcount growth outpaced revenue growth.

The metric is used to compare changes in the relationship between revenue and workforce size across companies and over time.

### Period Comparison

The analysis divides the study period into two descriptive periods:

- **Period A:** FY2022–FY2024
- **Period B:** FY2025–Q1 FY2027

The period comparison is used to test whether the revenue–headcount relationship changed over time.

The periods should not be interpreted as a direct "before AI" versus "after AI" comparison. AI and automation are possible explanatory factors that require additional evidence to test.

### Revenue Per Employee

Revenue per employee is calculated as:

**Revenue Per Employee = Revenue in INR ÷ Headcount**

This metric is used as an efficiency proxy to examine how much reported revenue corresponds to each employee.

It is not treated as a complete measure of individual employee productivity because it can also be affected by pricing, utilization, service mix, geography, acquisitions, subcontracting, and other business factors.

### Profitability Analysis

EBIT margin is used as the primary operating profitability measure.

The analysis also examines the relationship between:

- EBIT margin change and headcount growth
- EBIT margin change and revenue growth

Correlation results are interpreted as directional and exploratory. They do not establish that changes in headcount or revenue caused changes in profitability.

## Expected Analytical Contribution

This project is designed to contribute to the business question by:

1. Quantifying the revenue–headcount relationship using a consistent decoupling metric.
2. Comparing TCS with three major Indian IT-services peers rather than analyzing TCS in isolation.
3. Identifying whether the relationship changed between Period A and Period B.
4. Measuring changes in revenue per employee as an efficiency indicator.
5. Examining workforce trends alongside attrition and operating profitability.
6. Highlighting company-specific differences and business-event-driven outliers.
7. Providing a framework for identifying questions that require deeper workforce, cost, automation, or AI-related data.

## Deliverables

1. A clearly defined business question and analytical framework
2. A documented quarterly dataset covering four Indian IT-services companies
3. Data validation and transformation documentation
4. SQL-based comparative analysis
5. A summary of key findings and analytical limitations
6. An interactive Tableau dashboard
7. Business implications and areas for further investigation
8. Reproducible project documentation and supporting analysis files