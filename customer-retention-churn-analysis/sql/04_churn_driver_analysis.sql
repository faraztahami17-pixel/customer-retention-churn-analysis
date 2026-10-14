USE TelcoChurnDB;
GO

-- Churn by contract type
SELECT Contract, COUNT(*) AS TotalCustomers, SUM(ChurnFlag) AS ChurnedCustomers,
    CAST(100.0*SUM(ChurnFlag)/COUNT(*) AS DECIMAL(10,2)) AS ChurnRatePercent,
    CAST(SUM(EstimatedRevenueAtRisk) AS DECIMAL(12,2)) AS RevenueAtRisk
FROM dbo.telco_customer_churn_cleaned GROUP BY Contract ORDER BY ChurnRatePercent DESC;
GO

-- Churn by tenure group
SELECT TenureGroup, COUNT(*) AS TotalCustomers, SUM(ChurnFlag) AS ChurnedCustomers,
    CAST(100.0*SUM(ChurnFlag)/COUNT(*) AS DECIMAL(10,2)) AS ChurnRatePercent
FROM dbo.telco_customer_churn_cleaned GROUP BY TenureGroup
ORDER BY CASE TenureGroup WHEN '0-6 Months' THEN 1 WHEN '7-12 Months' THEN 2 WHEN '13-24 Months' THEN 3 WHEN '25-48 Months' THEN 4 WHEN '49-72 Months' THEN 5 ELSE 6 END;
GO

-- Churn by internet service
SELECT InternetService, COUNT(*) AS TotalCustomers, SUM(ChurnFlag) AS ChurnedCustomers,
    CAST(100.0*SUM(ChurnFlag)/COUNT(*) AS DECIMAL(10,2)) AS ChurnRatePercent,
    CAST(AVG(MonthlyCharges) AS DECIMAL(10,2)) AS AvgMonthlyCharge
FROM dbo.telco_customer_churn_cleaned GROUP BY InternetService ORDER BY ChurnRatePercent DESC;
GO

-- Churn by payment method
SELECT PaymentMethod, COUNT(*) AS TotalCustomers, SUM(ChurnFlag) AS ChurnedCustomers,
    CAST(100.0*SUM(ChurnFlag)/COUNT(*) AS DECIMAL(10,2)) AS ChurnRatePercent,
    CAST(SUM(EstimatedRevenueAtRisk) AS DECIMAL(12,2)) AS RevenueAtRisk
FROM dbo.telco_customer_churn_cleaned GROUP BY PaymentMethod ORDER BY ChurnRatePercent DESC;
GO

-- Churn and support services
SELECT HasTechSupport, HasOnlineSecurity, COUNT(*) AS TotalCustomers, SUM(ChurnFlag) AS ChurnedCustomers,
    CAST(100.0*SUM(ChurnFlag)/COUNT(*) AS DECIMAL(10,2)) AS ChurnRatePercent
FROM dbo.telco_customer_churn_cleaned GROUP BY HasTechSupport, HasOnlineSecurity ORDER BY ChurnRatePercent DESC;
GO

-- Churn by monthly charge band
SELECT MonthlyChargeBand, COUNT(*) AS TotalCustomers, SUM(ChurnFlag) AS ChurnedCustomers,
    CAST(100.0*SUM(ChurnFlag)/COUNT(*) AS DECIMAL(10,2)) AS ChurnRatePercent
FROM dbo.telco_customer_churn_cleaned GROUP BY MonthlyChargeBand
ORDER BY CASE MonthlyChargeBand WHEN 'Low' THEN 1 WHEN 'Medium' THEN 2 WHEN 'High' THEN 3 ELSE 4 END;
GO

-- Churn by senior citizen status
SELECT SeniorCitizen, COUNT(*) AS TotalCustomers, SUM(ChurnFlag) AS ChurnedCustomers,
    CAST(100.0*SUM(ChurnFlag)/COUNT(*) AS DECIMAL(10,2)) AS ChurnRatePercent
FROM dbo.telco_customer_churn_cleaned GROUP BY SeniorCitizen ORDER BY ChurnRatePercent DESC;
GO

-- Contract x InternetService matrix
SELECT Contract, InternetService, COUNT(*) AS TotalCustomers, SUM(ChurnFlag) AS ChurnedCustomers,
    CAST(100.0*SUM(ChurnFlag)/COUNT(*) AS DECIMAL(10,2)) AS ChurnRatePercent
FROM dbo.telco_customer_churn_cleaned GROUP BY Contract, InternetService ORDER BY ChurnRatePercent DESC;
GO
