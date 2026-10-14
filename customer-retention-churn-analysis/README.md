# Customer Retention and Subscription Churn Analysis

## Overview
Telecom subscription churn analysis on the IBM Telco Customer Churn sample (7043 customers, 21 cols). Goal: measure churn, find drivers, quantify revenue at risk, prioritize retention actions.

**Results (computed):** 1869 churned / 5174 retained = **26.54%** churn. Avg charge $64.76. Total MRR proxy $456,116.60. **Revenue at risk $139,130.85.**

> Fictional, cross-sectional data. Revenue-at-risk uses MonthlyCharges as proxy. Associations only, not causation.

## Objectives
- Measure churn + revenue exposure
- Segments: contract, tenure, payment, services, support, charges, demographics
- Power BI decision dashboard + optional churn-risk model

## Tools
SQL Server (clean + KPIs) | Python Pandas/Seaborn/Sklearn (EDA + model) | Power BI (3-page dashboard) | GitHub

## Business questions -> answers
1. Churn rate 26.54%. 2. 1869 vs 5174. 3. $139,130.85 at risk. 4. Month-to-month 42.71% > One year 11.27% > Two year 2.83%. 5. 0-6m 52.94% vs 49-72m 9.51%. 6. Electronic check 45.29% highest. 7. Fiber 41.89% > DSL 18.96% > No internet 7.41%. 8. No TechSupport 31.19% vs Yes 15.17%; No Security 31.33% vs Yes 14.61%. 9. Priority: new MTM fiber + e-check, high charges (631 strict high-risk). 10. See Recommendations.

## Workflow
Excel check -> SQL clean/analysis -> Power BI dashboard -> Python validation/model -> GitHub

## Repo structure
data/raw, data/processed, sql/01-06, notebooks/01-02, powerbi/, dashboard_screenshots/, docs/

## How to run
1. CSV already in data/raw/. 2. Run sql/01..06 in order (SSMS). 3. Open powerbi guide + connect to vw_powerbi_customer_churn or cleaned CSV. 4. pip install -r requirements.txt, run notebooks.

## Key insights
See docs/key_insights.md. Worst cell: MTM+Fiber 54.61%. Best: Two-year+No internet 0.78%. High charge band 35.36%. Seniors 41.68%.

## Recommendations
- 0-6m onboarding 30/60/90 journey; measure 30/60/90-day retention.
- MTM -> annual upgrade with transparent discount/credits.
- E-check -> autopay/card incentive.
- Fiber high-charge -> plan optimization / loyalty add-ons.
- No support -> free trial + proactive check.
- Priority 1 (high-risk + >=$70) -> retention call + manager escalation.

## Author
Faraz Tahami | Add LinkedIn link
