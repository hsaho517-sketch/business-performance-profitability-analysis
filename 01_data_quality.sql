-- ============================================================
-- BUSINESS PERFORMANCE & PROFITABILITY ANALYSIS
-- 01 - DATA QUALITY
-- ============================================================

-- ------------------------------------------------------------
-- 1. ROW COUNTS
-- ------------------------------------------------------------

SELECT COUNT(*) AS customer_rows
FROM customers;

SELECT COUNT(*) AS product_rows
FROM products;

SELECT COUNT(*) AS order_rows
FROM orders;

SELECT COUNT(*) AS order_item_rows
FROM order_items;

SELECT COUNT(*) AS target_rows
FROM targets;


-- ------------------------------------------------------------
-- 2. CUSTOMER DATA QUALITY
-- ------------------------------------------------------------

-- Missing customer segments
SELECT COUNT(*) AS missing_customer_segments
FROM customers
WHERE segment IS NULL;

-- Missing customer regions
SELECT COUNT(*) AS missing_customer_regions
FROM customers
WHERE region IS NULL;


-- ------------------------------------------------------------
-- 3. ORDER ITEM DUPLICATES
-- ------------------------------------------------------------

-- Identify duplicated order_item IDs
SELECT
    order_item_id,
    COUNT(*) AS occurrences
FROM order_items
GROUP BY order_item_id
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;

-- Number of duplicated rows beyond the first occurrence
SELECT
    COUNT(*) - COUNT(DISTINCT order_item_id) AS duplicate_order_items
FROM order_items;


-- ------------------------------------------------------------
-- 4. DATE COVERAGE
-- ------------------------------------------------------------

SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM orders;


-- ------------------------------------------------------------
-- 5. TARGET DATA QUALITY
-- ------------------------------------------------------------

-- Check that each month-region combination appears only once
SELECT
    month,
    region,
    COUNT(*) AS occurrences
FROM targets
GROUP BY
    month,
    region
HAVING COUNT(*) > 1
ORDER BY
    month,
    region;

-- Compare total rows with unique month-region combinations
SELECT
    COUNT(*) AS target_rows,
    COUNT(DISTINCT (month, region)) AS unique_month_region_combinations
FROM targets;