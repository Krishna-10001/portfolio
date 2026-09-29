from pathlib import Path
import pandas as pd


# ---------------------------------------------------------
# 1. Locate the project and data file
# ---------------------------------------------------------

# Project root = tcs-peer-analysis/
PROJECT_ROOT = Path(__file__).resolve().parents[1]

# CSV file location
DATA_FILE = PROJECT_ROOT / "data" / "raw" / "company_financials.csv"


# ---------------------------------------------------------
# 2. Check that the data file exists
# ---------------------------------------------------------

if not DATA_FILE.exists():
    print(f"FAIL: Data file not found: {DATA_FILE}")
    raise SystemExit(1)


# ---------------------------------------------------------
# 3. Load the data
# ---------------------------------------------------------

df = pd.read_csv(DATA_FILE)

print("Validation started...")
print("Data file:", DATA_FILE)
print("Rows:", len(df))


# ---------------------------------------------------------
# 4. Check required columns
# ---------------------------------------------------------

required_columns = {
    "company",
    "fiscal_year",
    "quarter_num",
    "revenue_cr",
    "headcount",
    "net_profit_cr",
    "ebit_margin_pct",
    "attrition_pct",
    "source_doc"
}

missing_columns = required_columns - set(df.columns)

if missing_columns:
    print(f"FAIL: Missing columns: {sorted(missing_columns)}")
else:
    print("PASS: All required columns are present")


# Stop if required columns are missing because
# the remaining checks depend on them.
if missing_columns:
    raise SystemExit(1)


# ---------------------------------------------------------
# 5. Check expected row count
# ---------------------------------------------------------

expected_rows = 84

if len(df) == expected_rows:
    print(f"PASS: Row count is {expected_rows}")
else:
    print(
        f"WARNING: Expected {expected_rows} rows, "
        f"but found {len(df)}"
    )


# ---------------------------------------------------------
# 6. Check missing values
# ---------------------------------------------------------

if df.isnull().sum().sum() > 0:

    print("FAIL: Missing values found")

    missing_values = df.isnull().sum()

    print("\nMissing values by column:")
    print(missing_values[missing_values > 0])

else:
    print("PASS: No missing values")


# ---------------------------------------------------------
# 7. Check duplicate company-quarter combinations
# ---------------------------------------------------------

duplicate_rows = df.duplicated(
    subset=["company", "fiscal_year", "quarter_num"]
)

if duplicate_rows.any():

    print("FAIL: Duplicate company-quarter found")

    print(
        df.loc[
            duplicate_rows,
            ["company", "fiscal_year", "quarter_num"]
        ]
    )

else:
    print("PASS: No duplicate company-quarter combinations")


# ---------------------------------------------------------
# 8. Check company names
# ---------------------------------------------------------

expected_companies = {
    "TCS",
    "Infosys",
    "Wipro",
    "HCLTech"
}

actual_companies = set(df["company"].dropna())

if actual_companies == expected_companies:
    print("PASS: All company names are correct")

else:
    print("FAIL: Company names are incorrect")
    print("Found:", sorted(actual_companies))
    print("Expected:", sorted(expected_companies))


# ---------------------------------------------------------
# 9. Check number of quarters per company
# ---------------------------------------------------------

company_counts = df.groupby("company").size()

if (company_counts == 21).all():

    print("PASS: Each company has 21 quarterly observations")

else:

    print("FAIL: Quarter count is incorrect")

    print("\nRows per company:")
    print(company_counts)


# ---------------------------------------------------------
# 10. Check quarter numbers
# ---------------------------------------------------------

valid_quarters = df["quarter_num"].between(1, 4)

if valid_quarters.all():

    print("PASS: Quarter numbers are valid")

else:

    print("FAIL: Invalid quarter number found")

    print(
        df.loc[
            ~valid_quarters,
            ["company", "fiscal_year", "quarter_num"]
        ]
    )


# ---------------------------------------------------------
# 11. Check revenue and headcount values
# ---------------------------------------------------------

if (df["revenue_cr"] > 0).all():

    print("PASS: Revenue values are positive")

else:

    print("FAIL: Zero or negative revenue found")


if (df["headcount"] > 0).all():

    print("PASS: Headcount values are positive")

else:

    print("FAIL: Zero or negative headcount found")


# ---------------------------------------------------------
# 12. Check source document traceability
# ---------------------------------------------------------

if df["source_doc"].astype(str).str.strip().eq("").any():

    print("FAIL: Blank source_doc found")

else:

    print("PASS: All rows have a source document")


# ---------------------------------------------------------
# 13. Check reasonable percentage ranges
# ---------------------------------------------------------

if df["attrition_pct"].between(0, 100).all():

    print("PASS: Attrition percentages are within 0–100")

else:

    print("WARNING: Attrition percentage outside 0–100 found")


if df["ebit_margin_pct"].between(-100, 100).all():

    print("PASS: EBIT margins are within a reasonable range")

else:

    print("WARNING: EBIT margin outside expected range found")


# ---------------------------------------------------------
# 14. Check fiscal year and quarter combinations
# ---------------------------------------------------------

if df["fiscal_year"].between(2022, 2027).all():

    print("PASS: Fiscal years are within expected range")

else:

    print("WARNING: Unexpected fiscal year found")


# ---------------------------------------------------------
# 15. Summary
# ---------------------------------------------------------

print("\n----------------------------------------")
print("Validation complete.")
print("----------------------------------------")