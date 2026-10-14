USE TelcoChurnDB;
GO

SELECT
    COUNT(*) AS TotalCustomers,
    SUM(ChurnFlag) AS ChurnedCustomers,
    COUNT(*) - SUM(ChurnFlag) AS RetainedCustomers,
    CAST(100.0 * SUM(ChurnFlag) / COUNT(*) AS DECIMAL(10,2)) AS ChurnRatePercent,
    CAST(AVG(MonthlyCharges) AS DECIMAL(10,2)) AS AvgMonthlyCharge,
    CAST(SUM(EstimatedRevenueAtRisk) AS DECIMAL(12,2)) AS MonthlyRevenueAtRisk,
    CAST(SUM(MonthlyCharges) AS DECIMAL(12,2)) AS TotalMonthlyRecurringRevenue
FROM dbo.telco_customer_churn_cleaned;
-- Expected (from raw data): 7043 total, 1869 churned, 5174 retained, 26.54%, avg 64.76, at-risk 139130.85, total MRR 456116.60
