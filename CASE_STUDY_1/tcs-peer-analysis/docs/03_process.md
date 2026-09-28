# Process

## Purpose

This document explains how the project transformed publicly reported financial

and workforce information from TCS, Infosys, Wipro, and HCLTech into a

validated analytical dataset and an interactive Tableau dashboard.

The process was designed to maintain a clear separation between:

1. **Source data collection**
2. **Data preparation and standardization**
3. **Data quality validation**
4. **Database storage**
5. **SQL transformation and analysis**
6. **Visualization**
7. **Dashboard publication**

The workflow was intentionally structured so that every major analytical result

could be traced back to the underlying company-quarter observation and its

original source document.

---

## End-to-End Workflow

```text
Official Company Disclosures
          ↓
Source Data Extraction
          ↓
Excel Data Collection & Standardization
          ↓
CSV Master Dataset
          ↓
Python / Pandas Validation
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
Tableau Public