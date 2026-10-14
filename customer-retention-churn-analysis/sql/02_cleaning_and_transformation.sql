USE TelcoChurnDB;
GO

DROP TABLE IF EXISTS dbo.telco_customer_churn_cleaned;
GO

SELECT
    customerID,
    gender,
    CASE WHEN SeniorCitizen = 1 THEN 'Yes' ELSE 'No' END AS SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,
    TRY_CAST(NULLIF(LTRIM(RTRIM(TotalCharges)), '') AS DECIMAL(12,2)) AS TotalChargesClean,
    Churn,
    CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END AS ChurnFlag,
    CASE
        WHEN tenure BETWEEN 0 AND 6 THEN '0-6 Months'
        WHEN tenure BETWEEN 7 AND 12 THEN '7-12 Months'
        WHEN tenure BETWEEN 13 AND 24 THEN '13-24 Months'
        WHEN tenure BETWEEN 25 AND 48 THEN '25-48 Months'
        WHEN tenure BETWEEN 49 AND 72 THEN '49-72 Months'
        ELSE 'Unknown'
    END AS TenureGroup,
    CASE
        WHEN MonthlyCharges < 35 THEN 'Low'
        WHEN MonthlyCharges >= 35 AND MonthlyCharges < 70 THEN 'Medium'
        WHEN MonthlyCharges >= 70 THEN 'High'
        ELSE 'Unknown'
    END AS MonthlyChargeBand,
    CASE WHEN TechSupport = 'Yes' THEN 'Yes' ELSE 'No' END AS HasTechSupport,
    CASE WHEN OnlineSecurity = 'Yes' THEN 'Yes' ELSE 'No' END AS HasOnlineSecurity,
    CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END AS EstimatedRevenueAtRisk,
    CASE
        WHEN Contract = 'Month-to-month' AND tenure <= 12 AND PaymentMethod = 'Electronic check' AND InternetService = 'Fiber optic' THEN 'High Risk'
        WHEN Contract = 'Month-to-month' AND tenure <= 24 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS RiskSegment
INTO dbo.telco_customer_churn_cleaned
FROM dbo.telco_customer_churn_raw;
GO

SELECT COUNT(*) AS cleaned_rows FROM dbo.telco_customer_churn_cleaned;
