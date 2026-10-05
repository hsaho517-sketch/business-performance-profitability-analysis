-- ============================================================
-- BUSINESS PERFORMANCE & PROFITABILITY ANALYSIS
-- 03 - BUSINESS PERFORMANCE ANALYSIS
-- ============================================================


-- ------------------------------------------------------------
-- 1. ANNUAL BUSINESS PERFORMANCE
-- ------------------------------------------------------------

SELECT
    year,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(cogs), 2) AS cogs,
    ROUND(SUM(gross_profit), 2) AS gross_profit,
    ROUND(
        100.0 * SUM(gross_profit) / NULLIF(SUM(revenue), 0),
        2
    ) AS gross_margin_pct
FROM analytics.sales_detail
GROUP BY year
ORDER BY year;


-- ------------------------------------------------------------
-- 2. COMPARABLE JAN-AUG PERFORMANCE
-- Avoid comparing full-year 2024/2025 with partial-year 2026
-- ------------------------------------------------------------

SELECT
    year,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(gross_profit), 2) AS gross_profit,
    ROUND(
        100.0 * SUM(gross_profit) / NULLIF(SUM(revenue), 0),
        2
    ) AS gross_margin_pct
FROM analytics.sales_detail
WHERE EXTRACT(MONTH FROM order_date) BETWEEN 1 AND 8
GROUP BY year
ORDER BY year;


-- ------------------------------------------------------------
-- 3. REGIONAL PERFORMANCE
-- Jan-Aug 2025 vs Jan-Aug 2026
-- ------------------------------------------------------------

SELECT
    year,
    region,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(gross_profit), 2) AS gross_profit,
    ROUND(
        100.0 * SUM(gross_profit) / NULLIF(SUM(revenue), 0),
        2
    ) AS gross_margin_pct
FROM analytics.sales_detail
WHERE year IN (2025, 2026)
  AND EXTRACT(MONTH FROM order_date) BETWEEN 1 AND 8
GROUP BY
    year,
    region
ORDER BY
    region,
    year;


-- ------------------------------------------------------------
-- 4. CATEGORY / REGION PROFITABILITY DRIVERS
-- Investigate discounting, product costs and margins
-- ------------------------------------------------------------

SELECT
    year,
    region,
    category,
    ROUND(100.0 * AVG(discount_pct), 2) AS avg_discount_pct,
    ROUND(AVG(unit_cost), 2) AS avg_unit_cost,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(gross_profit), 2) AS gross_profit,
    ROUND(
        100.0 * SUM(gross_profit) / NULLIF(SUM(revenue), 0),
        2
    ) AS gross_margin_pct
FROM analytics.sales_detail
WHERE year IN (2025, 2026)
  AND EXTRACT(MONTH FROM order_date) BETWEEN 1 AND 8
GROUP BY
    year,
    region,
    category
ORDER BY
    region,
    category,
    year;


-- ------------------------------------------------------------
-- 5. EAST REGION - SALES CHANNEL ANALYSIS
-- Investigate the region with the largest profitability decline
-- ------------------------------------------------------------

SELECT
    year,
    sales_channel,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(100.0 * AVG(discount_pct), 2) AS avg_discount_pct,
    ROUND(SUM(gross_profit), 2) AS gross_profit,
    ROUND(
        100.0 * SUM(gross_profit) / NULLIF(SUM(revenue), 0),
        2
    ) AS gross_margin_pct
FROM analytics.sales_detail
WHERE region = 'East'
  AND year IN (2025, 2026)
  AND EXTRACT(MONTH FROM order_date) BETWEEN 1 AND 8
GROUP BY
    year,
    sales_channel
ORDER BY
    sales_channel,
    year;


-- ------------------------------------------------------------
-- 6. 2026 ACTUAL VS TARGET
-- Jan-Aug performance by region
-- ------------------------------------------------------------

WITH actuals AS (
    SELECT
        DATE_TRUNC('month', order_date)::date AS month,
        region,
        SUM(revenue) AS actual_revenue,
        SUM(gross_profit) AS actual_gross_profit
    FROM analytics.sales_detail
    WHERE order_date >= DATE '2026-01-01'
      AND order_date < DATE '2026-09-01'
    GROUP BY
        DATE_TRUNC('month', order_date)::date,
        region
),
performance AS (
    SELECT
        a.region,
        SUM(a.actual_revenue) AS actual_revenue,
        SUM(t.revenue_target) AS revenue_target,
        SUM(a.actual_gross_profit) AS actual_gross_profit,
        SUM(t.gross_profit_target) AS gross_profit_target
    FROM actuals a
    JOIN targets t
        ON a.month = t.month
       AND a.region = t.region
    GROUP BY a.region
)
SELECT
    region,

    ROUND(actual_revenue, 2) AS actual_revenue,
    ROUND(revenue_target, 2) AS revenue_target,
    ROUND(actual_revenue - revenue_target, 2) AS revenue_variance,
    ROUND(
        100.0 * actual_revenue / NULLIF(revenue_target, 0),
        2
    ) AS revenue_target_attainment_pct,

    ROUND(actual_gross_profit, 2) AS actual_gross_profit,
    ROUND(gross_profit_target, 2) AS gross_profit_target,
    ROUND(actual_gross_profit - gross_profit_target, 2)
        AS gross_profit_variance,
    ROUND(
        100.0 * actual_gross_profit /
        NULLIF(gross_profit_target, 0),
        2
    ) AS gross_profit_target_attainment_pct

FROM performance
ORDER BY region;


-- ------------------------------------------------------------
-- 7. EAST PARTNER CUSTOMER CONCENTRATION
-- Determine whether Partner growth is driven by a few customers
-- or represents broader channel expansion
-- ------------------------------------------------------------

WITH customer_revenue AS (
    SELECT
        year,
        customer_id,
        SUM(revenue) AS customer_revenue
    FROM analytics.sales_detail
    WHERE region = 'East'
      AND sales_channel = 'Partner'
      AND year IN (2025, 2026)
      AND EXTRACT(MONTH FROM order_date) BETWEEN 1 AND 8
    GROUP BY
        year,
        customer_id
),
ranked_customers AS (
    SELECT
        year,
        customer_id,
        customer_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY year
            ORDER BY customer_revenue DESC
        ) AS customer_rank
    FROM customer_revenue
)
SELECT
    year,
    COUNT(*) AS active_customers,
    ROUND(SUM(customer_revenue), 2) AS revenue,
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN customer_rank <= 10
                THEN customer_revenue
                ELSE 0
            END
        ) / NULLIF(SUM(customer_revenue), 0),
        2
    ) AS top_10_customer_revenue_share_pct
FROM ranked_customers
GROUP BY year
ORDER BY year;