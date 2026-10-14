# Key Insights (computed from data — Python validation)

- Total customers: 7043 | Churned: 1869 | Retained: 5174 | Churn rate: 26.54%
- Avg monthly charge: $64.76 | Total MRR proxy: $456,116.60 | Monthly revenue at risk: $139,130.85
- Contract: Month-to-month 42.71% (3875 customers, 1655 churned), One year 11.27%, Two year 2.83%
- Tenure: 0-6 Months 52.94% (1481), 7-12 Months 35.89%, 13-24 Months 28.71%, 25-48 Months 20.39%, 49-72 Months 9.51%
- Payment: Electronic check 45.29%, Mailed check 19.11%, Bank transfer 16.71%, Credit card 15.24%
- Internet: Fiber optic 41.89% (3096), DSL 18.96% (2421), No internet 7.41% (1526)
- Contract x Internet (worst): Month-to-month + Fiber 54.61%; Month-to-month + DSL 32.22%; Two year + No internet 0.78% (best)
- Support: No Tech Support 31.19% vs Yes 15.17%; No OnlineSecurity 31.33% vs Yes 14.61%
- Charge band: High (>=70) 35.36% (3583), Medium 23.94%, Low 10.89%
- Senior: Yes 41.68% (1142) vs No 23.61%; Paperless Yes 33.57% vs No 16.33%
- Risk rule: High Risk (MTM + <=12m + E-check + Fiber) = 631 customers; Medium (MTM + <=24m) pool = 2731 customers
- Data quality: TotalCharges blank in 11 rows (all tenure=0); treated as NULL; customerID unique; no negative charges.

Wording rule: say "associated with", not "causes". Cross-sectional + fictional.
