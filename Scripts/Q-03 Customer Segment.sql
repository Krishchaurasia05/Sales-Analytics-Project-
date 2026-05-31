--============================================================
-- Description:
-- This script segments customers into High, Medium, and Low
-- value tiers based on their lifetime spend.
--
-- Segmentation logic:
-- High   : Lifetime spend >= $5,000
-- Medium : Lifetime spend >= $2,000 and < $5,000
-- Low    : Lifetime spend <  $2,000
--
-- Approach:
-- - Aggregates total sales per customer from fact_sales
-- - Joins with dim_customers to include customer full name
-- - Applies CASE WHEN segmentation on lifetime spend
-- - Adds revenue contribution % using SUM() OVER()
-- - Ranks customers by total revenue using RANK()
-- - Includes a segment summary with customer count,
--   revenue share, and average customer value
--
-- Output:
-- 1) Detailed view  : Every customer with segment + rank
-- 2) Summary view   : Segment level count, revenue, avg value
--============================================================

-- ── 1) Detailed customer view ────────────────────────────

WITH CustomerSpend AS (
    SELECT
        fs.customer_key,
        dc.full_name,
        SUM(fs.sales) AS total_revenue
    FROM gold.fact_sales fs
    JOIN gold.dim_customers dc
        ON fs.customer_key = dc.customer_key
    GROUP BY
        fs.customer_key,
        dc.full_name
),

CustomerSegmented AS (
    SELECT
        customer_key,
        full_name,
        total_revenue,
        CASE
            WHEN total_revenue >= 5000 THEN 'High'
            WHEN total_revenue >= 2000 THEN 'Medium'
            ELSE 'Low'
        END AS customer_segment
    FROM CustomerSpend
)

SELECT
    customer_key,
    full_name,
    total_revenue,
    customer_segment,
    ROUND(total_revenue * 100.0 / SUM(total_revenue) OVER(), 2) AS pct_of_total_revenue,
    RANK() OVER(ORDER BY total_revenue DESC) AS revenue_rank
FROM CustomerSegmented
ORDER BY total_revenue DESC;


-- ── 2) Segment summary view ───────── ─────────────────────

WITH CustomerSpend AS (
    SELECT
        fs.customer_key,
        SUM(fs.sales) AS total_revenue
    FROM gold.fact_sales fs
    GROUP BY fs.customer_key
),

CustomerSegmented AS (
    SELECT
        total_revenue,
        CASE
            WHEN total_revenue >= 5000 THEN 'High'
            WHEN total_revenue >= 2000 THEN 'Medium'
            ELSE 'Low'
        END AS customer_segment
    FROM CustomerSpend
)

SELECT
    customer_segment,
    COUNT(*)                                                              AS customer_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1)                   AS pct_of_customers,
    SUM(total_revenue)                                                    AS segment_revenue,
    ROUND(SUM(total_revenue) * 100.0 / SUM(SUM(total_revenue)) OVER(), 1) AS pct_of_revenue,
    ROUND(AVG(total_revenue), 0)                                          AS avg_customer_value
FROM CustomerSegmented
GROUP BY customer_segment
ORDER BY
    CASE customer_segment
        WHEN 'High'   THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Low'    THEN 3
    END;
