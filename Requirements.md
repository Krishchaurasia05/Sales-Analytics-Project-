# Project Requirements

This project is built on top of the **SQL Data Warehouse Project**.
The Gold layer views listed below must exist in your SQL Server database before running any scripts in this project.

| View | Description |
|---|---|
| `gold.fact_sales` | Core sales transactions — orders, revenue, quantities |
| `gold.dim_customers` | Customer dimension — keys, names, demographics |
| `gold.dim_products` | Product dimension — names, categories, subcategories |

> If you have not set up the data warehouse yet, visit the
> [SQL Data Warehouse Project](https://github.com/Krishchaurasia05/SQL-Data-Warehouse-Project)
> and complete that setup first before proceeding.

---

## SQL Scripts Requirements

| Script | Dependencies |
|---|---|
| `T01_revenue_trend.sql` | `gold.fact_sales` |
| `T02_top_products.sql` | `gold.fact_sales`, `gold.dim_products` |
| `T03_customer_segments.sql` | `gold.fact_sales`, `gold.dim_customers` |

---

## Power BI Requirements

| Requirement | Detail |
|---|---|
| Data source | SQL Server with Gold layer views loaded |
| Connection type | Import mode (recommended) |
| DAX | Used for measures and calculated columns |
| Visuals used | Card, Line chart, Clustered bar chart, Donut chart, Slicer |

---

## DAX Measures Used

| Measure | Formula |
|---|---|
| Total Revenue | `SUM('gold fact_sales'[sales])` |
| Total Orders | `DISTINCTCOUNT('gold fact_sales'[order_number])` |
| Avg Order Value | `DIVIDE([Total Revenue], [Total Orders])` |

---

## Calculated Column Used

**Customer Segment** — added to `gold fact_sales` table in Power BI:

```dax
Customer Segment =
VAR CustomerRevenue =
    CALCULATE(
        SUM('gold fact_sales'[sales]),
        ALLEXCEPT('gold fact_sales', 'gold fact_sales'[customer_key])
    )
RETURN
    SWITCH(
        TRUE(),
        CustomerRevenue >= 5000, "High",
        CustomerRevenue >= 2000, "Medium",
        "Low"
    )
```

---

## System Requirements

| Component | Requirement |
|---|---|
| OS | Windows 10 / 11 |
| RAM | Minimum 4GB (8GB recommended) |
| Storage | Minimum 1GB free space |

---

## Software Requirements

| Software | Version | Purpose | Download |
|---|---|---|---|
| SQL Server | 2019 or later | Database engine to host the data warehouse | [Download](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) |
| SQL Server Management Studio (SSMS) | 19.0 or later | Run and manage SQL scripts | [Download](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms) |
| Power BI Desktop | Latest | Build and view the dashboard | [Download](https://powerbi.microsoft.com/en-us/desktop/) |

---

## How to Set Up

1. Complete the [SQL Data Warehouse Project](https://github.com/Krishchaurasia05/SQL-Data-Warehouse-Project) setup
2. Open SSMS and connect to your SQL Server instance
3. Run scripts in this order:
   - `T01_revenue_trend.sql`
   - `T02_top_products.sql`
   - `T03_customer_segments.sql`
4. Open Power BI Desktop
5. Get Data → SQL Server → enter your server and database name
6. Load `gold.fact_sales`, `gold.dim_customers`, `gold.dim_products`
7. Add the DAX measures and calculated column listed above
8. Open `Dashboard.pbix` or rebuild visuals using the loaded tables
