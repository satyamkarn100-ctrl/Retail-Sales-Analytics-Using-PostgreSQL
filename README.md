# Retail Sales Analytics Using PostgreSQL

## Project Overview

This project analyzes the Olist Brazilian E-Commerce dataset using PostgreSQL.

The project focuses on building a relational database, validating the imported data, performing data quality checks, exploring the dataset using SQL, and preparing cleaned tables for further analysis and visualization.

The workflow follows:

**Raw Data → PostgreSQL → Data Validation → Data Quality Checks → EDA → Data Cleaning → Power BI**

---

## Dataset

The project uses the Olist Brazilian E-Commerce Public Dataset.

The dataset contains information about:

- Customers
- Orders
- Order Items
- Products
- Sellers
- Payments
- Reviews
- Geolocation
- Product Category Translation

---

## Tools & Technologies

- PostgreSQL
- pgAdmin 4
- SQL
- Power BI *(next stage)*

---

## Project Structure

```text
Retail-Sales-Analytics-Using-PostgreSQL/
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_data_validation.sql
│   ├── 03_data_quality_checks.sql
│   ├── 04_EDA.sql
│   └── 05_data_cleaning.sql
│
└── README.md
