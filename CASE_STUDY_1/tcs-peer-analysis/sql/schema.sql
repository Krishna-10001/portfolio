CREATE TABLE company_financials (
    company TEXT NOT NULL,
    fiscal_year INTEGER NOT NULL,
    quarter_num INTEGER NOT NULL CHECK (quarter_num BETWEEN 1 AND 4),
    revenue_cr NUMERIC,
    headcount INTEGER,
    net_profit_cr NUMERIC,
    ebit_margin_pct NUMERIC,
    attrition_pct NUMERIC,
    source_doc TEXT,
    PRIMARY KEY (company, fiscal_year, quarter_num)
);