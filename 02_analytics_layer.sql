-- ============================================================
-- BUSINESS PERFORMANCE & PROFITABILITY ANALYSIS
-- 02 - ANALYTICS LAYER
-- ============================================================

CREATE SCHEMA IF NOT EXISTS analytics;


-- ------------------------------------------------------------
-- 1. CLEAN CUSTOMERS
-- Replace missing customer segments with 'Unknown'
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW analytics.customers_clean AS
SELECT
    customer_id,
    customer_name,
    COALESCE(segment, 'Unknown') AS segment,
    region,
    signup_date
FROM customers;


-- ------------------------------------------------------------
-- 2. CLEAN ORDER ITEMS
-- Remove duplicated order_item IDs
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW analytics.order_items_clean AS
SELECT
    order_item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    discount_pct,
    unit_cost
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY order_item_id
            ORDER BY order_item_id
        ) AS rn
    FROM order_items
) x
WHERE rn = 1;


-- ------------------------------------------------------------
-- 3. SALES ANALYTICS LAYER
-- Combine transactional and dimensional data
-- and calculate core profitability metrics
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW analytics.sales_detail AS
SELECT
    oi.order_item_id,
    o.order_id,
    o.order_date,
    DATE_TRUNC('month', o.order_date)::date AS month,
    EXTRACT(YEAR FROM o.order_date)::int AS year,

    o.customer_id,
    c.customer_name,
    c.segment,

    o.region,
    o.sales_channel,

    oi.product_id,
    p.product_name,
    p.category,
    p.subcategory,

    oi.quantity,
    oi.unit_price,
    oi.discount_pct,
    oi.unit_cost,

    oi.quantity * oi.unit_price
        * (1 - oi.discount_pct) AS revenue,

    oi.quantity * oi.unit_cost AS cogs,

    (
        oi.quantity * oi.unit_price
        * (1 - oi.discount_pct)
    ) - (
        oi.quantity * oi.unit_cost
    ) AS gross_profit

FROM analytics.order_items_clean oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN analytics.customers_clean c
    ON o.customer_id = c.customer_id
JOIN products p
    ON oi.product_id = p.product_id;