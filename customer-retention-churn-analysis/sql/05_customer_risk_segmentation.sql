USE TelcoChurnDB;
GO

WITH CustomerRisk AS (
    SELECT customerID, gender, SeniorCitizen, Partner, Dependents, tenure, TenureGroup,
        Contract, InternetService, PaymentMethod, MonthlyCharges, TotalChargesClean,
        HasTechSupport, HasOnlineSecurity, Churn, RiskSegment,
        CASE
            WHEN RiskSegment = 'High Risk' AND MonthlyCharges >= 70 THEN 'Priority 1 - Retention Call + Contract Discount'
            WHEN RiskSegment = 'High Risk' THEN 'Priority 2 - Retention Offer'
            WHEN RiskSegment = 'Medium Risk' THEN 'Priority 3 - Digital Engagement Campaign'
            ELSE 'Monitor'
        END AS RecommendedAction
    FROM dbo.telco_customer_churn_cleaned
)
SELECT * FROM CustomerRisk
ORDER BY CASE RiskSegment WHEN 'High Risk' THEN 1 WHEN 'Medium Risk' THEN 2 ELSE 3 END, MonthlyCharges DESC;
