# E-Commerce Operations Analysis — SQL

## Project Overview
Comprehensive SQL analysis of 100,000+ orders from Olist, a Brazilian 
e-commerce marketplace, to uncover revenue trends, category performance, 
delivery efficiency, seller quality, and payment behaviour patterns 
across the platform's full growth journey (2016–2018).

## Tools & Technologies
- **Database:** MySQL 8.0
- **Query Tool:** MySQL Workbench
- **Dataset:** Brazilian E-Commerce (Olist) — Kaggle
- **Data Cleaning:** Python (resolved CSV encoding issues before import)

## Database Schema — 8 Tables

| Table | Rows |
|---|---|
| orders | 99,441 |
| customers | 99,441 |
| order_items | 112,650 |
| order_payments | 103,886 |
| order_reviews | 99,172 |
| products | 32,340 |
| sellers | 289 |
| category_translation | 71 |

---

## Analysis 1 — Monthly Revenue Trend

**Business Question:** How did revenue grow over time and are there 
seasonal patterns?

**Key Findings:**
- Revenue grew nearly **9x in 15 months** — from R$127,482 (Jan 2017) 
  to R$1,132,878 (Apr 2018)
- **November 2017 peaked at R$1,153,364** — a 53% spike vs October, 
  clearly driven by Black Friday
- Average order value stayed stable at R$128–R$152 throughout the 
  entire period — growth was driven purely by **customer volume, 
  not price increases**
- From Jan–Aug 2018, revenue consistently exceeded R$966,000 per month, 
  indicating the platform reached sustainable maturity

![Monthly Revenue Trend](file:///Users/khooshimangal/Desktop/ecommerce-SQL-Project/01_monthly_revenue.png)

---

## Analysis 2 — Top Product Categories by Revenue

**Business Question:** Which categories drive the most revenue and 
how do their strategies differ?

**Key Findings:**
- **Health & Beauty** is the #1 category at R$1,258,681 (9.39% 
  revenue share)
- Top 3 categories account for **26.1% of total revenue** across 
  70+ categories
- Watches & Gifts achieves similar revenue to Bed Bath & Table with 
  40% fewer orders — a clear **premium pricing vs volume** contrast
- cool_stuff ranks only 7th in revenue but has the 2nd highest avg 
  item price (R$167.36) — an underexploited high-margin category

![Category Performance](file:///Users/khooshimangal/Desktop/ecommerce-SQL-Project/02_category_performance.png)

---

## Analysis 3 — Delivery Performance by State

**Business Question:** Which states have the best and worst delivery 
performance, and what drives the difference?

**Key Findings:**
- São Paulo (SP) ranks #1 fastest at **8.7 days average** and handles 
  40,501 orders — **42% of all platform deliveries**
- Roraima (RR) averages **29.3 days** — a **3.4x delivery gap** 
  between the fastest and slowest states
- Clear North-South divide: all top 10 fastest states are in 
  South/Southeast Brazil; all bottom 5 are in North/Northeast
- Rio de Janeiro shows a 0-day minimum delivery — a data anomaly 
  worth investigating for data quality review

![Delivery Performance](file:///Users/khooshimangal/Desktop/ecommerce-SQL-Project/03_delivery_performance.png)

---

## Analysis 4 — Seller Performance Ranking

**Business Question:** Who are the top-performing sellers and does 
customer rating correlate with revenue?

**Key Findings:**
- Every seller with 50+ orders achieved a "Top Seller" rating above 
  4.5 — indicating strong platform quality standards
- The #1 rated seller (4.82) generated only R$6,911 vs the #8 rated 
  seller's R$51,720 — **rating and revenue are not correlated**
- Revenue among equally-rated Top Sellers ranges from R$1,425 to 
  R$51,720 — a **36x difference** — volume strategy matters far 
  more than rating for revenue generation

![Seller Ranking](file:///Users/khooshimangal/Desktop/ecommerce-SQL-Project/04_seller_ranking.png)

---

## Analysis 5 — Payment Method Analysis

**Business Question:** How do customers prefer to pay and what does 
each method reveal about buyer behaviour?

**Key Findings:**
- Credit card dominates with **73.92% of transactions** and **78.34% 
  of total value** — R$12,542,084 of total platform revenue
- Credit card's value share (78.34%) exceeds its transaction share 
  (73.92%) — credit card users spend **disproportionately more** 
  per order (R$163.32 avg)
- Voucher users average only R$65.70 per order — less than half 
  the credit card average — indicating discount-driven, low-value 
  purchasing behaviour
- Debit card accounts for just 1.47% of transactions — significantly 
  underutilised compared to credit card
- 3 transactions flagged as "not_defined" with R$0 value — minor 
  data quality issue documented

![Payment Analysis](file:///Users/khooshimangal/Desktop/ecommerce-SQL-Project/05_payment_analysis.png)

---

## SQL Techniques Used

| Technique | Where Applied |
|---|---|
| INNER JOIN (multi-table) | Queries 1, 2, 3, 4 |
| Aggregation (SUM, COUNT, AVG, MIN, MAX) | All queries |
| Window Functions — RANK() OVER | Queries 3, 4 |
| Window Functions — SUM() OVER for % | Queries 2, 5 |
| CASE statement (tiering/classification) | Query 4 |
| DATE_FORMAT | Query 1 |
| DATEDIFF | Query 3 |
| HAVING clause | Query 4 |

## Files
```
ecommerce-sql-analysis/
├── README.md
├── queries/
│   ├── 01_monthly_revenue_trend.sql
│   ├── 02_category_performance.sql
│   ├── 03_delivery_performance.sql
│   ├── 04_seller_ranking.sql
│   └── 05_payment_analysis.sql
└── screenshots/
    ├── 01_monthly_revenue.png
    ├── 02_category_performance.png
    ├── 03_delivery_performance.png
    ├── 04_seller_ranking.png
    └── 05_payment_analysis.png
```
