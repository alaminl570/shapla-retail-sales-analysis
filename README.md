# Shapla Retail Ltd – Sales & Profit Analysis (SQL Server + Tableau)

## 📊 Project Overview
This project analyses the sales and profitability performance of Shapla Retail Ltd., a Bangladesh-based FMCG & Electronics distributor operating across Dhaka, Chattogram, Khulna, and Rajshahi.

The goal of this analysis is to support management decision-making through:
- Revenue performance tracking
- Profitability analysis
- Customer segmentation insights
- Regional performance evaluation
- Executive dashboard visualisation

## 🎯 Business Problem
Shapla Retail Ltd. wants to answer:
- Which region generates the highest revenue?
- Which product categories are most profitable?
- Who are the top revenue-generating customers?
- What is the monthly sales trend?
- Which customer segment (Retail vs Corporate) produces higher profit?
- Which products have low profit margins and require pricing review?

### Business Problem Solution
**SQL Implementation**
- [`business_problem_queries.sql`](scripts/business_problem_queries.sql)

<p align="center">
  <img src="docs/business_problem_queries.png" width="720">
</p>

## 🗂 Database Design
The database was designed in Microsoft SQL Server using a normalised relational schema.
### Tables:
 - customers
 - products
 - orders
 - order_details

### Relationships:
 - customers → orders (1:M)
 - orders → order_details (1:M)
 - products → order_details (1:M)

<p align="center">
  <img src="docs/table_relationships.png" width="720">
</p>

## ⚙️ Technologies Used
- Microsoft SQL Server (SSMS)
- Advanced SQL (JOINs, CTEs, Window Functions, Indexing)
- Tableau Public (Executive Dashboard)
- GitHub (Project Documentation)

## 📈 Key SQL Analysis Performed
#### Revenue Analysis
- Revenue by Region
- Revenue by Product Category
- Top Revenue Customers

#### Profitability Analysis
- Profit by Customer Segment
- Profit Margin Calculation
- Low Margin Product Identification

#### Trend Analysis
- Monthly Revenue Trend (Using CTE & LAG)
- Average Order Value (AOV)

#### Performance Optimisation
- Index creation on foreign keys
- Composite index for customer-date analysis

**SQL Implementation**
- [`kpi_dashboard_queries.sql`](scripts/kpi_dashboard_queries.sql)

<p align="center">
  <img src="docs/kpi_dashboard_queries.png" width="720">
</p>

## 📊 Tableau Executive Dashboard
An interactive executive dashboard was created using Tableau Public to visualise key sales and customer insights.

### Dashboard Includes
#### Sales Performance Dashboard
- Total Revenue KPI
- Total Profit KPI
- Average Order Value
- Revenue Trend Over Time
- Profit Trend Analysis
- Revenue & Profit by Region
- Revenue & Profit by Product Category
<p align="center">
  <img src="docs/sales_dashboard.png" width="1200" hight="800">
</p>

#### Customer Analytics Dashboard
- Total Customers KPI
- Total Orders KPI
- Customer Growth Trend
- Order Trend Over Time
- Customer Distribution by Number of Orders
- Top 10 Customers by Profit
<p align="center">
  <img src="docs/sales_dashboard.png" width="1200" hight="800">
</p>

### Live Interactive Dashboard
View the full interactive dashboard here 👉 https://public.tableau.com/app/profile/md.alamin.mia/viz/Tableau_17732526338650/SalesPerformanceDashboard2024

## 📌 Key Business Insights
- Dhaka region generates the highest revenue among all regions.
- Corporate customers contribute higher overall profit compared to retail customers.
- Electronics category delivers the strongest profit performance.
- Several products operate below 30% profit margin, indicating a need for pricing review.
- Sales show consistent growth toward the later months of the year.

## 🚀 Business Recommendations
Based on the analysis:
- Increase marketing focus in high-performing regions such as Dhaka.
- Reprice or renegotiate supplier cost for low-margin products.
- Develop retention programs for high-value corporate customers.
- Improve inventory planning based on sales trend patterns.

## 👤 Author
MD ALAMIN MIA
Aspiring Data Analyst

#### Skills:
- Excell
- SQL
- Data Visualisation
- Business Intelligence
- Tableau
- Data Analysis

If you found this project useful, please ⭐ the repository.


