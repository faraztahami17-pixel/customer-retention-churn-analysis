USE TelcoChurnDB;
GO

CREATE OR ALTER VIEW dbo.vw_powerbi_customer_churn AS
SELECT customerID, gender, SeniorCitizen, Partner, Dependents, tenure, TenureGroup,
    PhoneService, MultipleLines, InternetService, HasOnlineSecurity, HasTechSupport,
    Contract, PaperlessBilling, PaymentMethod, MonthlyCharges, TotalChargesClean,
    MonthlyChargeBand, Churn, ChurnFlag, EstimatedRevenueAtRisk, RiskSegment
FROM dbo.telco_customer_churn_cleaned;
GO
