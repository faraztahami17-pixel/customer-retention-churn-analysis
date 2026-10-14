# Data Dictionary — IBM Telco Customer Churn

Raw file: `data/raw/WA_Fn-UseC_-Telco-Customer-Churn.csv` (7043 rows x 21 cols).
Cleaned file: `data/processed/telco_customer_churn_cleaned.csv` (7043 rows x 30 cols).

## Raw columns
- customerID (string, unique key, not a feature)
- gender (Male/Female)
- SeniorCitizen (0/1 -> cleaned to Yes/No)
- Partner, Dependents (Yes/No)
- tenure (int months 0-72; 11 rows have tenure=0 and blank TotalCharges)
- PhoneService (Yes/No), MultipleLines (Yes/No/No phone service)
- InternetService (DSL/Fiber optic/No)
- OnlineSecurity, OnlineBackup, DeviceProtection, TechSupport, StreamingTV, StreamingMovies (Yes/No/No internet service)
- Contract (Month-to-month/One year/Two year)
- PaperlessBilling (Yes/No)
- PaymentMethod (Electronic check/Mailed check/Bank transfer (automatic)/Credit card (automatic))
- MonthlyCharges (numeric, no negatives)
- TotalCharges (string on import; 11 blanks -> NULL/NaN -> TotalChargesClean decimal)
- Churn (Yes/No, left in last month)

## Derived columns (cleaned table / Power BI view)
- ChurnFlag: 1 if Churn=Yes else 0
- SeniorCitizen (label): Yes/No
- TotalChargesClean: decimal, NULL where blank
- TenureGroup: 0-6 Months, 7-12 Months, 13-24 Months, 25-48 Months, 49-72 Months
- MonthlyChargeBand: Low (<35), Medium (35-69.99), High (>=70)
- HasTechSupport / HasOnlineSecurity: Yes if service=Yes else No
- EstimatedRevenueAtRisk: MonthlyCharges if churned else 0 (proxy for MRR, not causation)
- RiskSegment: High Risk (month-to-month AND tenure<=12 AND Electronic check AND Fiber optic); Medium Risk (month-to-month AND tenure<=24); else Low Risk
- CustomerProfile: TenureGroup | Contract | InternetService | PaymentMethod
- RecommendedAction: Priority 1 (High+charges>=70), Priority 2 (High), Priority 3 (Medium), Monitor (Low)
