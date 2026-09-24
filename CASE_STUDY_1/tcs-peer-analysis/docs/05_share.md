# Share

## Purpose

The purpose of the Share phase is to communicate the analytical findings in a
clear, concise, and business-oriented format.

The project is shared through:

- Tableau Public dashboard
- GitHub repository
- README.md
- Supporting project documentation
- Dashboard screenshots

The objective is to allow a recruiter, hiring manager, analyst, or business
stakeholder to understand:

1. What business question was investigated
2. What data was used
3. What was measured
4. What the analysis found
5. What the findings mean
6. What the analysis does and does not prove

---

# README.md — Key Findings

## Key Findings

### 1. TCS's revenue growth became more decoupled from headcount growth, but it was not the largest peer improvement

TCS's average decoupling gap increased from:

- **Period A:** 1.21 pp
- **Period B:** 2.01 pp
- **Change:** +0.80 pp

However, the increase was larger for HCLTech and Infosys:

| Company | Period A | Period B | Change |
|---|---:|---:|---:|
| HCLTech | 0.93 pp | 2.36 pp | +1.43 pp |
| Infosys | 1.28 pp | 2.34 pp | +1.06 pp |
| TCS | 1.21 pp | 2.01 pp | +0.80 pp |
| Wipro | 0.95 pp | 0.68 pp | -0.27 pp |

This indicates that TCS participated in a broader change in the
revenue-headcount relationship, but the magnitude of its change was smaller
than the changes observed for HCLTech and Infosys.

Wipro moved in the opposite direction.

---

### 2. Revenue-headcount decoupling and profitability are not the same story

TCS maintained a relatively stable EBIT margin of approximately **24.6%**
across the two periods.

At the same time:

- Infosys EBIT margin decreased from approximately **21.6% to 20.8%**
- HCLTech EBIT margin decreased from approximately **18.4% to 17.7%**
- Wipro EBIT margin increased from approximately **16.5% to 17.1%**

This shows that a wider decoupling gap does not automatically result in higher
EBIT margins.

The revenue-headcount relationship and profitability therefore need to be
considered as separate analytical dimensions.

---

### 3. Attrition declined across all four companies

Average attrition decreased from Period A to Period B across the entire peer
group:

| Company | Period A | Period B |
|---|---:|---:|
| TCS | 16.19% | 13.18% |
| Infosys | 20.40% | 13.33% |
| HCLTech | 17.81% | 12.77% |
| Wipro | 19.20% | 14.53% |

The common direction of movement indicates that the reduction in attrition was
not unique to TCS.

The dataset cannot determine whether this was caused by changes in hiring,
employee demand, labor-market conditions, compensation, or other factors.

---

### 4. The relationship between margin change and headcount growth differs by company

The exploratory correlation between EBIT margin change and headcount growth
was:

| Company | Correlation |
|---|---:|
| TCS | -0.35 |
| Infosys | -0.43 |
| Wipro | -0.57 |
| HCLTech | -0.06 |

TCS, Infosys, and Wipro show negative correlations in this sample, while
HCLTech shows a near-zero relationship.

HCLTech also shows a stronger positive correlation between EBIT margin change
and revenue growth (**0.67**).

These results are directional rather than causal.

The correlations are based on approximately 20 usable quarter-to-quarter
observations per company and should therefore not be interpreted as
statistically robust evidence of causation.

---

### 5. TCS improved revenue per employee

TCS's average revenue per employee increased from approximately:

**₹0.93 million → ₹1.10 million**

between Period A and Period B.

This indicates that the amount of reported revenue associated with each
employee increased during the later period.

However, revenue per employee is an efficiency proxy rather than a direct
measure of individual employee productivity.

It can also be influenced by:

- Pricing
- Utilization
- Revenue mix
- Employee mix
- Currency movements
- Subcontracting
- Acquisitions
- Business composition

---

# What the Dashboard Shows

The Tableau dashboard is designed to answer five connected questions:

### 1. Is revenue growth increasingly outpacing headcount growth?

**Decoupling Gap Trend**

Shows the quarterly decoupling gap for each company.

---

### 2. Did the revenue-headcount relationship change between the two periods?

**Period Comparison**

Compares the average decoupling gap between:

- Period A: FY22–FY24
- Period B: FY25–Q1 FY27

---

### 3. How are revenue growth and headcount growth moving together?

**Revenue Growth vs Headcount Growth**

A scatterplot showing quarterly revenue growth against quarterly headcount
growth.

The zero reference lines divide periods of positive and negative growth.

---

### 4. Is revenue per employee increasing?

**Revenue Per Employee Trend**

Shows the quarterly revenue-per-employee trajectory for the four companies.

---

### 5. Is workforce growth associated with changes in EBIT margin?

**EBIT Margin Change vs Headcount Growth**

Shows the relationship between quarterly headcount growth and quarterly
changes in EBIT margin.

A trend line is used for directional analysis only.

---

# Dashboard

The final dashboard is published on Tableau Public.

**Tableau Public:**  
https://public.tableau.com/shared/SC4DT9NSM?:display_count=n&:origin=viz_share_link

The dashboard contains:

- Company filter
- KPI cards
- Decoupling Gap Trend
- Period Comparison
- Revenue Growth vs Headcount Growth
- Revenue Per Employee Trend
- EBIT Margin Change vs Headcount Growth
- Methodology note
- Analytical callout

---

# Visualizations

## 1. Decoupling Gap Trend

**Purpose:**  
Track how the relationship between revenue growth and headcount growth changes
quarter by quarter.

**Metric:**

```text
Decoupling Gap
=
Revenue QoQ Growth %
-
Headcount QoQ Growth %