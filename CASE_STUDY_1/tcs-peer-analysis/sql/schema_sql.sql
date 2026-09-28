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
