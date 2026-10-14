<p align="center">
  <img src="https://img.shields.io/badge/Power%20BI-3--Page%20Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black" />
  <br/>
  <h1 align="center">📊 Power BI Dashboard — Step-by-Step Build Guide</h1>
  <p align="center"><b>Customer Retention & Churn Analysis</b> • <code>vw_powerbi_customer_churn</code> → <code>.pbix</code> → <code>.png</code></p>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Power%20BI%20Desktop-%E2%89%A5%20Oct%202023-F2C811?style=flat-square&logo=powerbi&logoColor=black" />
  <img src="https://img.shields.io/badge/Source-SQL%20View%20%7C%20CSV-CC2927?style=flat-square&logo=microsoftsqlserver&logoColor=white" />
  <img src="https://img.shields.io/badge/Rows-7,043-00C853?style=flat-square" />
  <img src="https://img.shields.io/badge/Pages-3-critical?style=flat-square" />
</p>

> **Outcome:** A 3-page decision dashboard that answers *"Where is churn, why, and who to call tomorrow?"* — fully synced to your SQL cleaned table.

---

### 📚 Table of Contents
1. [What You Will Build](#-what-you-will-build)
2. [Prerequisites](#-prerequisites)
3. [Prepare the Data Source](#1️⃣-prepare-the-data-source-sql--csv)
4. [Connect Power BI](#2️⃣-connect-power-bi-desktop)
5. [Power Query & Model](#3️⃣-power-query--data-model)
6. [DAX Measures](#4️⃣-create-dax-measures-the-brain)
7. [Theme & Layout](#5️⃣-theme--page-setup)
8. [Page 1 — Executive Overview](#6️⃣-page-1--executive-overview)
9. [Page 2 — Churn Drivers](#7️⃣-page-2--churn-drivers)
10. [Page 3 — Retention Action List](#8️⃣-page-3--retention-action-list)
11. [Interactions & QA](#9️⃣-interactions-slicers--qa)
12. [Export & Publish](#-export--publish)
13. [Troubleshooting](#troubleshooting)

---

### 🎯 What You Will Build

| Page | Purpose | Key Visuals | Screenshot |
| :--- | :--- | :--- | :--- |
| **P1 — Executive Overview** | *How big is the fire?* | 5 KPI cards, Donut, Column by Contract, Bar by Internet, Bar by Tenure | `dashboard_screenshots/01_executive_overview.png` |
| **P2 — Churn Drivers** | *Why they churn* | 4 bars + Matrix (Contract x Internet) + Decomposition Tree + Scatter | `dashboard_screenshots/02_churn_drivers.png` |
| **P3 — Retention Action List** | *Who to call tomorrow* | 2 KPI cards, Sorted Table (631 P1), Bar by Risk, Slicers | `dashboard_screenshots/03_retention_action_list.png` |

> Replace the 3 PNG placeholders after you build — capture at **View → Actual Size (100%)**.

---

### ✅ Prerequisites

| Need | Details |
| :--- | :--- |
| **Power BI Desktop** | ≥ Oct 2023 (free) — [download](https://powerbi.microsoft.com/desktop/) |
| **SQL Server** | `TelcoChurnDB` via `sql/01..06` **OR** use CSV fallback |
| **CSV fallback** | `data/processed/telco_customer_churn_cleaned.csv` (7043 rows) |
| **Time** | ~45-60 min first build |

---

### 1️⃣ Prepare the Data Source (SQL + CSV)

You have **two options** — SQL is preferred (live), CSV is zero-setup.

#### Option A — SQL View (recommended)
```sql
-- In SSMS, run in order:
-- sql/01_create_database_and_table.sql      -- creates TelcoChurnDB + raw table & imports CSV
-- sql/02_cleaning_and_transformation.sql    -- builds dbo.telco_customer_churn_cleaned (7043 rows)
-- sql/06_create_powerbi_view.sql            -- creates dbo.vw_powerbi_customer_churn
-- Verify:
SELECT COUNT(*) FROM dbo.vw_powerbi_customer_churn; -- expect 7043
SELECT * FROM dbo.vw_powerbi_customer_churn WHERE Churn='Yes'; -- expect 1869
```
View exposes: `customerID, gender, SeniorCitizen, Partner, Dependents, tenure, TenureGroup, PhoneService, MultipleLines, InternetService, HasOnlineSecurity, HasTechSupport, Contract, PaperlessBilling, PaymentMethod, MonthlyCharges, TotalChargesClean, MonthlyChargeBand, Churn, ChurnFlag, EstimatedRevenueAtRisk, RiskSegment`

#### Option B — CSV (no SQL)
File: `data/processed/telco_customer_churn_cleaned.csv` — already cleaned with all derived columns.

---

### 2️⃣ Connect Power BI Desktop

**A. SQL:**
1. Open Power BI → `Home → Get Data → SQL Server`
2. Server: `localhost` or `localhost\SQLEXPRESS` | Database: `TelcoChurnDB` → `OK`
3. Navigator → check `dbo.vw_powerbi_customer_churn` → `Load` (Import mode)
4. `File → Save As → powerbi/Customer_Retention_Churn_Analysis.pbix`

**B. CSV:**
1. `Home → Get Data → Text/CSV` → select `data/processed/telco_customer_churn_cleaned.csv`
2. Delimiter `,` → `Load` → Save as above.

> Use **Import** mode — 7043 rows is instant and enables all DAX.

---

### 3️⃣ Power Query & Data Model

**Power Query (Transform Data)** — 5 clicks for safety:
1. `Home → Transform Data` → select `vw_powerbi_customer_churn`
2. `TotalChargesClean` → `Transform → Data Type → Decimal Number` (11 nulls are expected: tenure=0 rows)
3. `MonthlyCharges` → Decimal, `tenure` → Whole Number, `ChurnFlag` → Whole Number
4. `Home → Close & Apply`

**Single-table model** — no relationships needed.

**Create Sort Columns (critical for correct bar order):**
- `TenureGroupOrder = SWITCH([TenureGroup],"0-6 Months",1,"7-12 Months",2,"13-24 Months",3,"25-48 Months",4,"49-72 Months",5)` → Select `TenureGroup` → `Sort by Column → TenureGroupOrder` → Hide `TenureGroupOrder`
- `ChargeBandOrder = SWITCH([MonthlyChargeBand],"Low",1,"Medium",2,"High",3)` → Sort `MonthlyChargeBand` by it → Hide

**Formatting:** `MonthlyCharges`, `TotalChargesClean`, `EstimatedRevenueAtRisk` → Currency `$` 2 decimals.


### 4️⃣ Create DAX Measures (The Brain)

> `Modeling → New Measure` — Tip: `Home → Enter Data → 1 column "_Measures" → Load` then create all measures in that table to keep them tidy. Or create directly on `vw_powerbi_customer_churn`.

Create **all 13 measures** — copy-paste exactly:

```DAX
-- ── Core KPIs ──
Total Customers = COUNTROWS('vw_powerbi_customer_churn')

Churned Customers = CALCULATE(COUNTROWS('vw_powerbi_customer_churn'), 'vw_powerbi_customer_churn'[Churn] = "Yes")

Retained Customers = [Total Customers] - [Churned Customers]

Churn Rate = DIVIDE([Churned Customers], [Total Customers], 0)  // Format as % 2 decimals

-- ── Revenue (MonthlyCharges = MRR proxy — fictional, cross-sectional) ──
Total Monthly Revenue = SUM('vw_powerbi_customer_churn'[MonthlyCharges])

Monthly Revenue at Risk = CALCULATE(SUM('vw_powerbi_customer_churn'[MonthlyCharges]), 'vw_powerbi_customer_churn'[Churn] = "Yes")

Average Monthly Charge = AVERAGE('vw_powerbi_customer_churn'[MonthlyCharges])

-- ── Risk Segments (logic from sql/02) ──
High-Risk Customers = CALCULATE(COUNTROWS('vw_powerbi_customer_churn'), 'vw_powerbi_customer_churn'[RiskSegment] = "High Risk")

High-Risk Revenue Exposure = CALCULATE(SUM('vw_powerbi_customer_churn'[MonthlyCharges]), 'vw_powerbi_customer_churn'[RiskSegment] = "High Risk")

Medium-Risk Customers = CALCULATE(COUNTROWS('vw_powerbi_customer_churn'), 'vw_powerbi_customer_churn'[RiskSegment] = "Medium Risk")

Low-Risk Customers = CALCULATE(COUNTROWS('vw_powerbi_customer_churn'), 'vw_powerbi_customer_churn'[RiskSegment] = "Low Risk")

Priority 1 Customers = CALCULATE(COUNTROWS('vw_powerbi_customer_churn'), 'vw_powerbi_customer_churn'[RiskSegment] = "High Risk", 'vw_powerbi_customer_churn'[MonthlyCharges] >= 70) // 631 strict
```

**Formatting checklist:**
- `Churn Rate` → `Measure Tools → Format → Percentage → 2 decimals`
- All Revenue/Charge measures → `$ English (US) → 2 decimals`
- Validate: `Total 7043 | Churned 1869 | Retained 5174 | 26.54% | Avg $64.76 | At-Risk $139,130.85 | MRR $456,116.60` must match `sql/03_kpi_analysis.sql`.

**Optional Calculated Column for P3 table:**
```DAX
RecommendedAction = SWITCH(TRUE(),
  'vw_powerbi_customer_churn'[RiskSegment]="High Risk" && 'vw_powerbi_customer_churn'[MonthlyCharges] >= 70, "Priority 1 - Retention Call + Discount",
  'vw_powerbi_customer_churn'[RiskSegment]="High Risk", "Priority 2 - Retention Offer",
  'vw_powerbi_customer_churn'[RiskSegment]="Medium Risk", "Priority 3 - Digital Campaign",
  "Monitor"
)
```

---

### 5️⃣ Theme & Page Setup

1. `View → Themes → Browse for themes` — use this minimal JSON or set manually:
```json
{ "name":"Retention", "dataColors":["#FF0040","#0F62FE","#00C853","#FF8A00","#8A3FFC","#009D9A"] }
```
2. `View → Page Size → 16:9` → `Background → #F8F9FA` light grey, add white card containers with `Shadow On` + `Rounded corners`.
3. Create **3 pages** → Rename: `01 Executive Overview` • `02 Churn Drivers` • `03 Retention Action List`
4. Header: `Insert → Text Box` → Page title + subtitle *"IBM Telco Sample • 7043 customers • MonthlyCharges = MRR proxy (fictional)"* + small disclaimer.

---

### 6️⃣ Page 1 — Executive Overview

**Goal:** 30-second exec readout. Layout: top row KPIs → middle Donut + Column → bottom Bars + Slicers.

**A. KPI Cards (top row — 5 cards)**
| # | Visual: Card | Measure | Note |
| :--- | :--- | :--- | :--- |
| 1 | Card | `[Total Customers]` | Value 28pt Bold |
| 2 | Card | `[Churned Customers]` | Accent red `#FF0040` |
| 3 | Card | `[Churn Rate]` | **Hero** — red if >25% |
| 4 | Card | `[Monthly Revenue at Risk]` | Subtitle: "per month (MRR proxy)" |
| 5 | Card | `[Average Monthly Charge]` | Subtitle: "ARPU proxy" |
Set `Background White` + `Border #E0E0E0` + `Category Label On`.

**B. Donut — Churn vs Retained**
Donut • Legend: `Churn` • Values: `[Total Customers]` • Colors: Yes `#FF0040`, No `#00C853` • Labels % • Title: `Retention vs Churn (26.54%)` → 73.46% / 26.54%.

**C. Column — Churn Rate by Contract**
Clustered Column • X: `Contract` • Y: `[Churn Rate]` • Sort Desc • Labels % • Title: `Contract is #1 lever — MTM 42.71% >> Two-year 2.83%`

**D. Bar — InternetService**
Y: `InternetService` • X: `[Churn Rate]` • Fiber red, DSL amber, No-Internet green • Title: `Fiber 41.89% vs No Internet 7.41%`

**E. Bar — TenureGroup (sorted!)**
Y: `TenureGroup` (sort by TenureGroupOrder) • X: `[Churn Rate]` • Title: `Onboarding cliff — 0-6M 52.94% → 49-72M 9.51%`

**F. Slicers (right rail)**
4 slicers → `View → Sync slicers → Sync across all pages`: `Contract`, `InternetService`, `PaymentMethod`, `SeniorCitizen`

> Screenshot at 100% → `dashboard_screenshots/01_executive_overview.png`

---

### 7️⃣ Page 2 — Churn Drivers

| # | Visual | Fields | Insight |
| :--- | :--- | :--- | :--- |
| 1 | Bar — PaymentMethod | Y=`PaymentMethod`, X=`[Churn Rate]` desc | `E-Check 45.29%` highest |
| 2 | Clustered Bar — Support | Y=`HasTechSupport` + `HasOnlineSecurity`, X=`[Churn Rate]` | `No Support 31.19% vs Yes 15.17%` — 2x |
| 3 | Column — MonthlyChargeBand | X=`MonthlyChargeBand` Low→High, Y=`[Churn Rate]` | `High 35.36%` |
| 4 | **Matrix — Contract x Internet ★** | Rows=`Contract`, Cols=`InternetService`, Values=`[Churn Rate]` + `[Total Customers]` | `MTM+Fiber 54.61%` worst, `Two-year+No Internet 0.78%` best |
| 5 | Decomposition Tree (AI) | Analyze=`[Churn Rate]`, Explain by=`Contract → InternetService → PaymentMethod → TenureGroup → HasTechSupport` | Drill MTM → Fiber → E-Check |
| 6 | Scatter — Tenure vs Charges | X=`tenure`, Y=`MonthlyCharges`, Legend=`Churn`, Size=`TotalChargesClean` | Churn clusters top-left |

Matrix → Conditional formatting → Background Red-Yellow-Green on `[Churn Rate]` (0% green → 55% red). All rates → `%`.

---

### 8️⃣ Page 3 — Retention Action List (Who to Save Tomorrow)

**A. Hero KPIs (top)**
| Card | Measure | Note |
| :--- | :--- | :--- |
| High-Risk Customers | `[High-Risk Customers]` | 631 — strict rule |
| High-Risk Revenue Exposure | `[High-Risk Revenue Exposure]` | $ exposure |
| Priority 1 Customers | `[Priority 1 Customers]` | High Risk + ≥$70 |

**B. Table — Action List (center — most important!)**
Visual: Table • Columns: `customerID | tenure | TenureGroup | Contract | InternetService | PaymentMethod | MonthlyCharges | HasTechSupport | RiskSegment | RecommendedAction`
- Sort: `RiskSegment` asc then `MonthlyCharges` desc
- Conditional formatting: High `#FFCDD2`, Medium `#FFF9C4`, Low `#C8E6C9`; `MonthlyCharges ≥70` → red bold
- Filter: keep all or `Churn = "No"` for savable only

**C. Bars — Risk by Contract / Payment**
Two small bars: Count by `Contract` and by `PaymentMethod` split by `RiskSegment`.

**D. Slicers**
`RiskSegment` (Chiclet), `MonthlyChargeBand`, `TenureGroup`, `Churn` — P3-only (unsynced).

> Screenshot → `dashboard_screenshots/03_retention_action_list.png`

---

### 9️⃣ Interactions, Slicers & QA

**Sync Slicers:** `View → Sync slicers` → all 3 pages for Contract/Internet/Payment/Senior. Leave Risk slicer P3-only.
**Edit Interactions:** Select slicer → `Format → Edit Interactions` → set Donut/Matrix to `Filter` (not Highlight).
**QA — Must match SQL (03):**
| Check | SQL | Power BI |
| :--- | :--- | :--- |
| Total | 7043 | `[Total Customers]` |
| Churned | 1869 | `[Churned Customers]` |
| Churn Rate | 26.54% | `[Churn Rate]` |
| At-Risk | $139,130.85 | `[Monthly Revenue at Risk]` |
| Avg Charge | $64.76 | `[Average Monthly Charge]` |
| MTM Rate | 42.71% | Filter MTM → `[Churn Rate]` |
| Fiber Rate | 41.89% | Filter Fiber → `[Churn Rate]` |
If mismatch → you loaded `raw` not `cleaned` view.

---

### 🔟 Export & Publish

1. **Screenshots:** `File → Export → PDF` + `View → Actual Size → Snipping Tool` for 3 PNGs → overwrite `dashboard_screenshots/*.png`
2. **Publish:** `Home → Publish → To Power BI Service` → enable **Scheduled Refresh** via Gateway if using SQL
3. **.gitignore:** `*.pbix` is ignored (binary) → keep screenshots + guide in git. To share PBIX: `git add -f powerbi/*.pbix` or Releases link
4. **Performance:** `View → Performance Analyzer → Start Recording → Refresh` → all <300ms on 7k rows

---

### Troubleshooting

| Symptom | Fix |
| :--- | :--- |
| `Rows 7032 not 7043` | Loaded `raw` not `cleaned` view |
| `TenureGroup wrong order` | Sort by `TenureGroupOrder` |
| `Churn Rate 0.26` | Format as **%** |
| `TotalCharges blank` | Expected — 11 nulls tenure=0 keep it |
| `Cannot connect SQL` | Try `localhost\SQLEXPRESS`; check SQL running + firewall |
| `DAX errors` | Table name must be `'vw_powerbi_customer_churn'` |
| `pbix won't push` | Intentional — `git add -f` if needed |

---

### 📂 Files

```
powerbi/
├── README_powerbi.md
└── Customer_Retention_Churn_Analysis.pbix  # create locally (not in git)
dashboard_screenshots/
├── 01_executive_overview.png
├── 02_churn_drivers.png
└── 03_retention_action_list.png
sql/06_create_powerbi_view.sql
```

> **Handover promise:** Anyone with Power BI Desktop + this guide can rebuild the dashboard in <1 hour and get *exact* numbers: **26.54% churn, $139k at-risk, 631 Priority-1.**
> Next: `notebooks/01_data_cleaning_eda.ipynb` validates same KPIs in Python.

<p align="center"><i>Keep wording "associated with" not "causes" — cross-sectional + fictional data.</i></p>
