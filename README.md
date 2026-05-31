# Sales Analytics Project 📊

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black)
![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=flat&logo=microsoftsqlserver&logoColor=white)
![T-SQL](https://img.shields.io/badge/T--SQL-4479A1?style=flat&logo=microsoftsqlserver&logoColor=white)

## Overview

This project extends my [SQL Data Warehouse Project](https://github.com/Krishchaurasia05/SQL-Data-Warehouse-Project) into a full **Exploratory Data Analysis (EDA)** and business intelligence solution. Using the Gold layer views built in the warehouse, I performed business-focused analysis and visualized the results in an interactive Power BI dashboard.

> The data spans 2011–2013 across a Sales & CRM domain covering products, customers, and orders.

---

## Tech Stack

| Tool | Purpose |
|---|---|
| SQL Server | Data source (Gold layer views) |
| T-SQL | EDA queries, window functions, CTEs |
| Power BI Desktop | Dashboard & visualization |
| DAX | Calculated measures and columns |

---

## Project Architecture

This project consumes the **Gold layer** from my data warehouse — no raw data is touched here.

```
SQL Data Warehouse (previous project)
        │
        └── Gold Layer (Views)
                ├── gold.fact_sales
                ├── gold.dim_customers
                └── gold.dim_products
                        │
                        ▼
            Sales Analytics Project
                ├── EDA SQL Scripts
                └── Power BI Dashboard
```

---

## Business Questions Answered

### Q-01 — Monthly & Quarterly Revenue Trend
How has total revenue trended month-over-month and quarter-over-quarter?

**Key findings:**
- Revenue peaked in **June 2011** — the strongest single month in the dataset
- From 2012 onwards, **December consistently became the peak month**, suggesting a seasonal shift driven by year-end demand
- Overall revenue showed a growing trend from 2011 to 2013

### Q-02 — Top Products by Revenue
Which products generate the most revenue each year?

**Key findings:**
- **2011:** Road-150 Red, Size 48 was the top performing product
- **2012:** Mountain-200 Black, Size 46 took the lead
- **2013:** Mountain-200 Black, Size 42 was the top performer
- The **Bikes category** dominates revenue across all years — contributing the majority of total sales

### Q-03 — Customer Segmentation by Lifetime Value
Who are the high, medium, and low value customers?

**Key findings:**
- **High value customers (≥ $5,000 lifetime spend):** 47.59% of total revenue
- **Medium value customers ($2,000–$5,000):** 38.33% of total revenue
- **Low value customers (< $2,000):** 14.08% of total revenue
- A relatively small group of high-value customers drives nearly half of all revenue

---

## Dashboard Preview

> *Power BI Dashboard — Sales & CRM Analytics*

![Dashboard](dashboard/Dashboard.pdf)

**Dashboard contains:**
- 3 KPI cards — Total Revenue (29M), Total Orders (28K), Avg Order Value (1.06K)
- Line chart — Monthly Revenue Trend (2011–2013)
- Bar chart — Top 10 Products by Revenue
- Donut chart — Customer Segmentation (High / Medium / Low)
- Year slicer for interactive filtering

---

## SQL Scripts

| Script | Description |
|---|---|
| `Q01_revenue_trend.sql` | Monthly & quarterly revenue using window functions |
| `Q02_top_products.sql` | Top products ranked by revenue per category |
| `Q03_customer_segments.sql` | Customer segmentation by lifetime spend |

---

## How to Run

1. Clone this repository
2. Ensure you have the Gold layer views set up from the [SQL Data Warehouse Project](https://github.com/Krishchaurasia05/SQL-Data-Warehouse-Project)
3. Run the SQL scripts in `/sql_scripts` against your SQL Server database
4. Open `Dashboard.pbix` in Power BI Desktop and refresh the data connection

---

## Connect With Me

- **GitHub:** [Krishchaurasia05](https://github.com/Krishchaurasia05)
- **LinkedIn:** [krishchaurasia](https://www.linkedin.com/in/krishchaurasia)
