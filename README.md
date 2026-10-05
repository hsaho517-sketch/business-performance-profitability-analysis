# Business Performance & Profitability Analysis

## Executive Summary

Revenue growth is not translating into profitable growth.

From **Jan–Aug 2025 to Jan–Aug 2026**, revenue increased **13.66%**, while gross profit declined **4.51%** and gross margin fell from **31.32% to 26.32%**.

The analysis identified two main areas of concern:

- **Technology** shows broader cost and margin pressure across the business.
- **East** experienced the strongest profitability deterioration, particularly within the **Partner** channel, where average discounts increased from approximately **6.4% to 16.7%** and gross margin fell to **17.8%**.

The business achieved **104.27% of its revenue target**, but only **86.00% of its gross profit target**, showing that revenue growth is masking weaker profitability.

---

## Business Problem

Management is seeing continued revenue growth but is concerned that profitability is not improving at the same pace.

The objective of the analysis is to answer:

> **Is the business growing profitably, and which products, customers, and regions are driving or weakening performance against targets?**

---

## Analysis Period

**January 2024 – August 2026**

Because 2026 contains only eight months of data, YoY comparisons use **Jan–Aug periods** to ensure comparable analysis.

---

## Dataset

The dataset contains five main tables:

- `customers`
- `products`
- `orders`
- `order_items`
- `targets`

The data covers customer segments, products, transactions, sales channels, discounts, product costs and monthly regional targets.

---

## Methodology

### Data Quality & Preparation

PostgreSQL was used to validate:

- Row counts
- Missing values
- Duplicate records
- Date coverage
- Target uniqueness

The audit identified **12 missing customer segments** and **50 duplicated order-item records**.

Missing segments were classified as `Unknown`, and duplicate order items were removed before analysis.

### Analytics Layer

A reusable SQL analytics layer combined orders, customers, products and order items.

Core business metrics were calculated:

- Revenue
- COGS
- Gross Profit
- Gross Margin

### Business Analysis

The investigation followed the profitability problem from overall business performance into:

**Company → Region → Category → Sales Channel → Customer**

Actual performance was then compared with regional revenue and gross profit targets.

Excel and Power Query were used for independent validation before the final reporting layer was built in Power BI.

---

## Key Findings

### 1. Revenue growth is not translating into profit growth

Jan–Aug 2025 vs Jan–Aug 2026:

- **Revenue:** +13.66%
- **Gross Profit:** -4.51%
- **Gross Margin:** 31.32% → 26.32%

The business is generating more revenue while retaining less gross profit per unit of revenue.

### 2. Technology shows broad profitability pressure

Technology recorded a **24.19% gross margin** in Jan–Aug 2026, the lowest among the major product categories.

The analysis also identified increasing product costs, suggesting that part of the margin deterioration extends beyond a single region.

### 3. East shows the strongest regional deterioration

East revenue increased approximately **17.4% YoY**, while gross profit declined approximately **14.6%**.

Gross margin fell from:

**31.25% → 22.71%**

This was the largest regional profitability decline.

### 4. East Partner growth is associated with significantly weaker margins

Within East, the Partner channel expanded rapidly.

- **Average Discount:** ~6.4% → 16.7%
- **2026 Gross Margin:** ~17.8%
- **Partner Orders:** more than doubled

The channel is generating substantial revenue growth, but under significantly weaker unit economics.

### 5. Partner growth is broad rather than concentrated

East Partner active customers increased:

**316 → 427**

At the same time, the Top 10 customers' share of Partner revenue decreased:

**11.59% → 7.61%**

This suggests that the change is not being driven by a small number of unusually large customers, but reflects broader Partner channel expansion.

### 6. Revenue targets are being achieved while profit targets are being missed

Jan–Aug 2026:

- **Revenue Target Attainment:** 104.27%
- **Gross Profit Target Attainment:** 86.00%
- **Revenue Variance:** +637.40K
- **Gross Profit Variance:** -666.67K

Three of four regions exceeded their revenue targets, while **all four regions missed gross profit targets**.

East showed the largest mismatch:

- **Revenue Target Attainment:** 107.74%
- **Gross Profit Target Attainment:** 74.98%

---

## Business Recommendations

- **Review East Partner discount governance** and determine whether current discount levels are economically justified.
- **Evaluate revenue and profitability together** when assessing regional and channel performance.
- **Investigate Technology cost increases** and their impact on product-level margins.
- **Introduce profitability guardrails** alongside revenue targets to prevent low-margin growth from appearing successful.
- **Continue monitoring Partner economics** as the channel expands, particularly discount levels and gross margin.

---

## Limitations

- The dataset is simulated for portfolio purposes.
- The analysis identifies associations but does not establish causality.
- Gross profit does not include operating expenses, marketing costs or other costs required to calculate net profitability.
- Customer contracts, competitive pricing and price elasticity are not available.
- 2026 is a partial year, so YoY comparisons use comparable Jan–Aug periods.

---

## Next Steps

Further analysis could include:

- Customer-level profitability
- Product-level cost variance
- Discount elasticity
- Contribution margin
- Year-end target forecasting
- Discount and cost scenario analysis

---

## Excel Validation

Excel and Power Query were used to prepare and independently validate the analytical dataset.

SQL results were cross-checked using PivotTables and comparable Jan–Aug periods before building the Power BI report.

---

## Dashboard

### Executive Performance

![Executive Performance](executive_performance.png)

Overview of revenue, gross profit, margin and YoY performance across the business.

### Profitability Drivers

![Profitability Drivers](profitability_drivers.png)

Analysis of category profitability and the regional/channel drivers behind margin deterioration.

### Target & Profitability

![Target & Profitability](target_profitability.png)

Comparison of actual revenue and gross profit against management targets by region.

---

## Tools & Skills

**PostgreSQL**
- Data quality validation
- Joins and CTEs
- Window functions
- Analytical views
- Aggregation and segmentation
- Variance analysis

**Excel / Power Query**
- Data preparation
- Data transformation
- PivotTables
- KPI validation
- Cross-tool validation

**Power BI / DAX**
- Data modeling
- DAX measures
- YoY analysis
- Target attainment
- Variance analysis
- KPI reporting
- Dashboard design

---

## Repository Files

| File | Description |
|---|---|
| `01_data_quality.sql` | Data quality and integrity checks |
| `02_analytics_layer.sql` | Clean analytical layer and business metrics |
| `03_business_performance_analysis.sql` | Profitability, driver and target analysis |
| `Business_Performance_Profitability_Analysis.xlsx` | Excel and Power Query validation |
| `Business_Performance_Profitability_Analysis.pbix` | Power BI report |
| `executive_performance.png` | Executive performance dashboard |
| `profitability_drivers.png` | Profitability drivers dashboard |
| `target_profitability.png` | Target and profitability dashboard |
