#!/bin/bash
# TCS Peer Comparison Case Study — Project Scaffold
# Run this once inside the folder where you want the project to live:
#   bash setup_project.sh

PROJECT="tcs-peer-analysis"

mkdir -p "$PROJECT"/{docs,data/raw,data/processed,data/external,sql/queries,notebooks,scripts,dashboards/tableau,reports/images}

cd "$PROJECT" || exit

# Placeholder files so empty folders still get tracked by git
touch data/raw/.gitkeep data/processed/.gitkeep data/external/.gitkeep
touch dashboards/tableau/.gitkeep reports/images/.gitkeep

# Doc stubs aligned to the Ask-Prepare-Process-Analyze-Share-Act framework
cat > docs/01_ask.md << 'EOF'
# Ask

## Business Task


## Key Stakeholders


## Guiding Questions
- How do TCS's revenue, headcount, attrition, and margin trends compare to Infosys, Wipro, and HCLTech over the last 5 years?
- Has TCS decoupled revenue growth from headcount growth faster or slower than its peers?
EOF

cat > docs/02_prepare.md << 'EOF'
# Prepare

## Data Sources
(List each source, link, license/usage terms, and date accessed)

## ROCCC Check
- Reliable:
- Original:
- Comprehensive:
- Current:
- Cited:

## Known Limitations
EOF

cat > docs/03_process.md << 'EOF'
# Process

## Tools Used and Why


## Cleaning Steps
(Document every transformation — this is a required deliverable)

## Data Integrity Checks
EOF

cat > docs/04_analyze.md << 'EOF'
# Analyze

## Summary of Analysis


## Trends and Relationships Found


## Surprises
EOF

cat > docs/05_share.md << 'EOF'
# Share

## Key Findings


## Visualizations
(Link to dashboard, embed chart images from reports/images/)
EOF

cat > docs/06_act.md << 'EOF'
# Act

## Top Recommendations

1.
2.
3.

## Business Impact of Each Recommendation
EOF

cat > docs/data_dictionary.md << 'EOF'
# Data Dictionary

| Column | Table | Description | Type | Source |
|---|---|---|---|---|
|  |  |  |  |  |
EOF

# README
cat > README.md << 'EOF'
# TCS vs. Peer IT Majors — Revenue, Headcount & Margin Trend Analysis

A data analytics case study examining whether TCS's 2025-26 workforce reduction reflects
a structural shift in the IT services business model, benchmarked against Infosys, Wipro,
and HCLTech.

## Business Question
Is TCS decoupling revenue growth from headcount growth faster than its industry peers,
and what does that mean for the traditional IT-services hiring pyramid?

## Tools
SQL · Python (pandas, yfinance) · Tableau

## Project Structure
- `docs/` — Ask, Prepare, Process, Analyze, Share, Act documentation
- `data/` — raw and processed datasets
- `sql/` — schema and analysis queries
- `notebooks/` — data collection, cleaning, and analysis notebooks
- `dashboards/` — final Tableau workbook
- `reports/` — exported visuals

## Key Findings
_(fill in once analysis is complete)_

## Dashboard
_(link to published Tableau Public dashboard)_

## Author
Krishna Jagtap
EOF

# requirements.txt
cat > requirements.txt << 'EOF'
pandas
numpy
sqlalchemy
yfinance
matplotlib
seaborn
scipy
jupyter
python-dotenv
EOF

# .gitignore
cat > .gitignore << 'EOF'
# Environments
.venv/
venv/
env/
__pycache__/
*.pyc

# Jupyter
.ipynb_checkpoints/

# OS
.DS_Store
Thumbs.db

# Large/raw data you may not want in git (uncomment if needed)
# data/raw/*
# !data/raw/.gitkeep

# Secrets
.env
EOF

# SQL schema stub
cat > sql/schema.sql << 'EOF'
-- Core fact table for the peer comparison analysis
CREATE TABLE company_financials (
    company        TEXT NOT NULL,
    quarter        TEXT NOT NULL,   -- e.g. 'FY26Q1'
    revenue_cr     NUMERIC,
    headcount      INTEGER,
    net_profit_cr  NUMERIC,
    ebit_margin_pct NUMERIC,
    attrition_pct  NUMERIC,
    PRIMARY KEY (company, quarter)
);
EOF

echo "Project scaffold created in ./$PROJECT"
echo "Next steps:"
echo "  cd $PROJECT"
echo "  git init"
echo "  git add ."
echo "  git commit -m 'Initial project scaffold'"
