
## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project_1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_project_1;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY NOT NULL,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT sales_date,
COUNT(sales_date) AS total_sale
FROM retail_sales
WHERE sales_date = '2022-11-05'
GROUP BY sales_date;
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT  *
FROM retail_sales
WHERE category = 'Clothing' AND quantity <= 4
AND DATE_FORMAT(sales_date, '%Y-%m') = '2022-11';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT category ,
SUM(total_sales) AS TOTAL_SALES ,
COUNT(*) AS TOTAL_ORDERS
FROM retail_sales 
GROUP BY category ;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT  category,
ROUND(AVG(age),0) AS averag_age 
FROM retail_sales
WHERE category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT 
*
FROM retail_sales 
WHERE total_sales > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT category , gender,
COUNT(transactions_id) AS total_num_transaction 
FROM retail_sales
GROUP BY category , gender ;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
WITH best_selling_month AS (
SELECT
YEAR(sales_date) AS Year,
MONTH (sales_date) AS month,
ROUND( AVG(total_sales),0) AS AVG_SALE ,
RANK() OVER(PARTITION BY YEAR(sales_date) ORDER BY ROUND( AVG(total_sales),0) DESC ) AS RNK
FROM retail_sales 
GROUP BY YEAR(sales_date) ,
MONTH(sales_date)
) 
SELECT Year , month , AVG_SALE , RNK
FROM best_selling_month
WHERE RNK = 1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT customer_id ,
SUM(total_sales) AS total_sales 
FROM retail_sales 
GROUP BY customer_id 
ORDER BY total_sales DESC 
LIMIT 5; 

```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT category, 
COUNT(DISTINCT customer_id ) AS UNIQUE_CUSTOMER 
FROM retail_sales
GROUP BY category 
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH hourly_time AS (
SELECT * ,  
CASE WHEN HOUR(sales_time) <= 12 THEN 'Morning'
WHEN HOUR(sales_time) BETWEEN 12 AND 17 THEN 'Afternoon'
WHEN HOUR(sales_time) > 17 THEN 'Evening'
END AS shift 
 FROM retail_sales )
SELECT 
COUNT(*) AS total_order ,
shift
FROM hourly_time 
GROUP BY shift
```

## Reports

Retail Sales Analysis – Final Report
🔹 Executive Summary
This project analyzes retail sales data to uncover key business insights related to customer behavior, product performance, and sales trends. Using SQL, the dataset was cleaned, explored, and transformed into meaningful information that can support data-driven decision-making.

🔹 Key Insights
1. 🛍️ Category Performance
Certain categories like Clothing and Beauty contribute significantly to overall sales.
High order volume categories do not always generate the highest revenue → indicates pricing differences.

3. 👥 Customer Behavior
A small group of customers contributes to a large portion of total revenue (Top 5 customers).
Customer distribution varies across categories, showing different buying preferences.

5. 💰 Revenue Analysis
High-value transactions (>1000) indicate premium product demand.
Average monthly sales highlight fluctuations in spending patterns.

7. 📅 Time-Based Trends
Monthly analysis reveals seasonal sales peaks.
Certain months consistently perform better → potential for targeted marketing campaigns.

9. ⏰ Shift-Based Analysis
Orders are distributed across:
Morning
Afternoon
Evening
Peak order times help in:
Staff planning
Inventory management
Marketing timing

11. 📊 Demographic Insights
Average age analysis shows target customer segments.


## Conclusion
This project successfully demonstrates how SQL can be used to transform raw retail data into actionable insights. By performing data cleaning, exploratory analysis, and business-driven querying, we identified key trends in customer behavior, sales performance, and operational efficiency.

The analysis highlights the importance of:

Understanding customer purchasing patterns
Identifying high-performing products and time periods
Leveraging data for strategic decision-making

Overall, this project builds a strong foundation in SQL and showcases essential analytical skills required for real-world data analyst roles. It also provides valuable insights that can help businesses improve sales strategies, enhance customer experience, and optimize operations.



