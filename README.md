# 🛒 E-Commerce Sales Insights with PostgreSQL

This project simulates a real-world e-commerce analytics workflow using **PostgreSQL**. It covers everything from database schema creation to advanced SQL queries and business-focused data visualizations.

---

## 📌 Project Highlights

- 🧩 Relational schema: customers, products, orders, order_items
- 🗃️ Sample data generation using SQL
- 🔍 Exploratory + analytical SQL queries
- 📊 Visualizations from pgAdmin
- 🧠 Business insights based on real KPIs

---

## 🧱 Database Structure

Tables:
- `customers` – demographics, signup info, referral source
- `products` – name, category, price
- `orders` – total amount, order date
- `order_items` – product breakdown per order

📁 View the schema in [`database_schema.sql`](./database_schema.sql)

---

## 💾 Sample Data

Data is generated using realistic mock entries for:
- 10 customers
- 5 products across 4 categories
- Dozens of orders and order items

📁 Check it out in [`sample_data.sql`](./sample_data.sql)

---

## 📊 Key Queries & Visualizations

Included in [`analysis_queries.sql`](./analysis_queries.sql) and the `/images` folder.

| Insight                              | Chart Type   |
|--------------------------------------|--------------|
| Top 5 Customers by Spending          | Bar Chart    |
| Best-Selling Products                | Bar Chart    |
| Revenue by Category                  | Grouped Bar  |
| Monthly Sales Trends                 | Line Chart   |
| Customer Frequency Distribution      | Pie Chart    |

---

## 📈 Sample Visualizations

### Total Revenue & Items Sold by Category  
![Revenue by Category](images/Total_Orders_and_Revenue_by_Product_Category.png)

### Monthly Sales Trend  
![Monthly Sales](images/Monthly_Sales_Trends.png)

### Customer Order Frequency  
![Order Frequency](images/Customer_Order_Frequency_Distribution.png)

---

## 📑 Business Insights

Real KPIs and strategies were derived from this analysis and included in  
[`business_insights.md`](./business_insights.md)

Example insights:
- Electronics lead in both sales volume and revenue
- Majority of customers are one-time buyers (📉 → opportunity)
- Top customers are responsible for 60%+ of total revenue

---

## 🚀 Getting Started

To run this project locally:
1. Clone the repo
2. Import the schema via [`postgresql_ecommerce_full_setup.sql`](./postgresql_ecommerce_full_setup.sql)
3. Use pgAdmin or `psql` to run analysis queries
4. View charts via screenshots or recreate using tools like Power BI or Python

---

## 🛠️ Tech Stack

- PostgreSQL 17
- pgAdmin 4
- SQL
- Git / GitHub
- Visual Studio Code

---

## 🤝 Connect

Feel free to share feedback or collaborate!  
🔗 [LinkedIn: Atif Elmasry](https://www.linkedin.com/in/tioatifelmasry)  
💻 [GitHub Profile](https://github.com/AtifElmasry)

---