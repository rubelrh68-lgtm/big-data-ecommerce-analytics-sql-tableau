# Big Data Analytics for E-Commerce Retail Performance

## Project Overview

This project applies big data analytics techniques to an e-commerce retail dataset from Bangladesh. The aim is to transform multi-table retail data into meaningful business insights using SQL Server for data preparation and Tableau for dashboard-based visual analytics.

The analysis focuses on sales performance, customer behaviour, product demand, payment preferences, geographic sales distribution, dashboard development, and forecasting. The project demonstrates how structured retail data can support operational decision-making, marketing strategy, inventory planning, and customer analysis.

## Business Problem

E-commerce retailers generate large volumes of customer, product, store, transaction, and time-based data. Without proper cleaning, transformation, and visualisation, this data cannot fully support strategic decision-making.

This project answers key business questions such as:

- Which products generate the highest sales?
- Which customer groups are most represented by mobile operator?
- Which locations generate the highest revenue?
- Which payment methods are most commonly used?
- How do sales change over time?
- What does the short-term sales forecast suggest?

## Dataset

The project uses a public e-commerce dataset from Kaggle.

The dataset includes multiple relational tables:

- `customer_dim`
- `item_dim`
- `store_dim`
- `trans_dim`
- `time_dim`
- `fact_table`

For privacy-conscious portfolio presentation, raw customer-level records are not displayed in this repository. The analysis focuses on aggregated business insights such as sales performance, customer distribution, product demand, payment behaviour, and forecasting.

## Tools Used

- Microsoft SQL Server Management Studio
- SQL
- Tableau
- Microsoft Excel
- Kaggle dataset

## Methodology

### 1. Data Loading

The original CSV files were imported into Microsoft SQL Server and structured into relational tables.

### 2. Data Cleaning

SQL was used to inspect and improve data quality. The cleaning process included:

- Checking missing values
- Replacing missing customer names with `Unknown`
- Identifying duplicate customer records
- Checking key fields
- Preparing the dataset for Tableau visualisation

### 3. Data Transformation

Several transformations were applied to improve analytical quality:

- Adding a country field for geographic mapping
- Standardising division and location names
- Preparing location hierarchy for Tableau
- Creating customer grouping logic based on mobile operator codes

### 4. SQL-Based Analysis

SQL queries were used to prepare the data and extract insights related to:

- Product sales
- Customer groups
- Payment methods
- Sales by location
- Sales trends over time

### 5. Tableau Dashboard Development

Tableau was used to create dashboards and visualisations covering:

- Top-selling products
- Customer distribution by telecom operator
- Sales by location
- Payment method analysis
- Sales trend over time
- Forecasting analysis

## Key Insights

### Product Performance

The analysis identified the highest-selling products by revenue. These products should receive priority in stock availability, promotions, and supply chain planning.

### Customer Analysis

Customer distribution by telecom operator showed opportunities for targeted marketing campaigns and operator-based promotional offers.

### Geographic Sales

Dhaka generated the highest sales, suggesting strong urban demand and the need for continued inventory and logistics focus in high-performing locations.

### Payment Method Preference

Card payments were the dominant payment method, followed by mobile banking and cash. This indicates opportunities to promote digital payment incentives such as cashback or loyalty points.

### Sales Trend and Forecasting

Sales showed fluctuations over time, highlighting the need for improved demand forecasting, dynamic pricing, marketing campaigns, and product bundling strategies.

## Business Recommendations

- Maintain stock availability for top-selling products.
- Bundle poor-performing products with high-selling products.
- Use telecom-operator-based marketing campaigns.
- Strengthen digital payment promotions.
- Improve inventory planning for high-performing locations.
- Apply dynamic pricing and loyalty programmes.
- Use forecasting dashboards for strategic planning.
- Improve customer experience through better website usability.

## Files in This Repository

- [ecommerce_big_data_analytics_portfolio_report.pdf](./ecommerce_big_data_analytics_portfolio_report.pdf)  
  Cleaned portfolio report containing methodology, dashboard insights, forecasting analysis, and business recommendations.

- [ecommerce_data_cleaning_queries.sql](./ecommerce_data_cleaning_queries.sql)  
  SQL queries used for data inspection, cleaning, transformation, and business analysis.

## Skills Demonstrated

- SQL data cleaning
- Relational database analysis
- Data transformation
- Tableau dashboard design
- Business intelligence reporting
- Retail analytics
- Forecasting interpretation
- Data-driven recommendation writing
- Portfolio-style project documentation

## How to Use This Repository

1. Read the PDF report for the full project explanation.
2. Open the SQL file to review the cleaning and analysis queries.
3. Use the methodology and findings as an example of SQL and Tableau-based business intelligence workflow.

## Disclaimer

This repository contains a cleaned and anonymised portfolio version of an academic analytics project. It does not include the original assignment brief, marking criteria, grades, student number, lecturer details, or private university submission information.

This project is shared for educational and portfolio purposes only.
