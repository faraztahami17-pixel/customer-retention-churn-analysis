    # Presentation Summary (1-page talk track)

**Title:** Customer Retention and Subscription Churn Analysis — Telco (IBM sample, 7043 customers)

1. Problem: 26.54% churn (1869 customers), $139K monthly revenue at risk.
2. Where: month-to-month (42.7%), tenure 0-6m (52.9%), electronic check (45.3%), fiber (41.9%), no support/security (~31%), high charges (35.4%), seniors (41.7%).
3. Best: two-year + no-internet 0.78%; long tenure 49-72m 9.5%.
4. Action list: 631 strict high-risk (new MTM fiber e-check); Priority 1 = high-risk + charges>=70 -> retention call + contract discount; Priority 3 = medium-risk -> digital onboarding.
5. Dashboard: p1 executive KPIs, p2 drivers, p3 action center (see powerbi/README + DAX below).
6. Model (optional): logistic regression baseline, focus recall/ROC-AUC, no leakage (exclude EstimatedRevenueAtRisk/Churn).
7. Caveat: fictional cross-sectional; MRR is proxy; association not causation. Next: track 30/60/90-day retention after offers.

**60-second interview answer:** I built an end-to-end retention analysis on the IBM Telco churn sample. I used SQL Server to clean TotalCharges blanks, build tenure/billing/risk segments, and compute churn rate and revenue at risk. Python validated EDA and an optional leakage-free logistic model. A 3-page Power BI dashboard covers executive KPIs, drivers, and a prioritized action list — targeting new month-to-month fiber e-check customers and high-value at-risk subscribers with onboarding and contract incentives.
