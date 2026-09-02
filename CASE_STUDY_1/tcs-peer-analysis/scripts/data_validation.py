import pandas as pd

df = pd.read_csv(r"C:\Users\asus\Desktop\PORTFOLIO\CASE_STUDY_1\tcs-peer-analysis\data\raw\company_financials.csv")

print("Rows:", len(df))

if df.isnull().sum().sum() > 0:
    print("FAIL: Missing values found")
else:
    print("PASS: No missing values")

if df.duplicated(
    subset=["company", "fiscal_year", "quarter_num"]
).any():
    print("FAIL: Duplicate company-quarter found")
else:
    print("PASS: No duplicates")

companies = {"TCS", "Infosys", "Wipro", "HCLTech"}

if set(df["company"]) == companies:
    print("PASS: All companies are correct")
else:
    print("FAIL: Company names are incorrect")

print("Validation complete.")