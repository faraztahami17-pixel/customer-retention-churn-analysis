# Business Problem — Customer Retention and Subscription Churn

A telecom subscription company loses customers every month. Churn reduces recurring revenue and raises acquisition cost (replacing a subscriber typically costs more than retaining one).

## Mandate (Customer Success & Retention team)
1. Measure the current churn problem.
2. Identify segments most likely to leave.
3. Find drivers: contract, tenure, payment method, services, support, monthly charges, demographics.
4. Estimate revenue at risk.
5. Build a dashboard to prioritize retention actions.
6. Optionally add a churn-risk prediction model.

## Business questions answered
1. Overall churn rate? -> 26.54% (1869 / 7043)
2. Churned vs stayed? -> 1869 churned, 5174 stayed
3. Monthly recurring revenue at risk? -> $139,130.85 (MonthlyCharges proxy)
4. Highest-churn contract? -> Month-to-month 42.71% vs One year 11.27% vs Two year 2.83%
5. New vs long-tenure? -> 0-6 months 52.94%, 49-72 months 9.51%
6. Payment method? -> Electronic check 45.29% highest
7. Fiber optic? -> Fiber 41.89% vs DSL 18.96% vs No internet 7.41%
8. Security/Support effect? -> Without Tech Support 31.19% vs with 15.17%; without OnlineSecurity 31.33% vs with 14.61%
9. Priority profile? -> New (<=12m) month-to-month fiber + electronic check (+ high charges) — 631 meet strict High-Risk rule
10. Actions? -> see key_insights.md + README recommendations

## Limitation (state in README/interviews)
Fictional, cross-sectional data. No true month-by-month history, campaigns, complaints, or offer outcomes. Revenue-at-risk uses current monthly charges as proxy. Associations only — not causation.
