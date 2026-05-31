
--============================================================
-- Description:
-- This script analyses monthly and quarterly revenue trends
-- over the entire sales period (2011-2013).
--
-- Approach:
-- - Truncates order_date to month level using DATETRUNC
-- - Calculates monthly total sales using SUM aggregation
-- - Derives quarterly totals using SUM window function
--   partitioned by year and quarter
-- - Filters out null monthly orders
--
-- Output columns:
-- monthly_order    : Year-Month label (yyyy-MM)
-- quarter          : Quarter number (1-4)
-- monthly_sales    : Total revenue for that month
-- quarterly_sales  : Total revenue for that quarter
--============================================================

SELECT 
    FORMAT(monthly_order, 'yyyy-MM') monthly_order,
    DATEPART(QUARTER, monthly_order) quarter,
    monthly_sales,
    SUM(monthly_sales) OVER(
        PARTITION BY YEAR(monthly_order), DATEPART(QUARTER, monthly_order)
    ) AS quarterly_sales
FROM (
    SELECT 
        DATETRUNC(MONTH, order_date) monthly_order,
        SUM(sales) monthly_sales
    FROM gold.fact_sales
    GROUP BY DATETRUNC(MONTH, order_date)
) t
WHERE monthly_order IS NOT NULL
ORDER BY monthly_order
