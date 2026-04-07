-- SQL RETAIL SALES ANALYSIS
-- CREATE DATABASE SQL_PROJECT_1;
-- USE SQL_PROJECT_1
-- DROP TABLE retail_sales;
-- CREATE TABLE retail_sales(
--    transactions_id INT PRIMARY KEY NOT NULL,
--    sales_date DATE ,
--    sales_time TIME ,
--    customer_id INT,
--    gender VARCHAR(50),
--    age VARCHAR(50),
--    category VARCHAR(50),
--    quantity INT , 
--    price_per_unit FLOAT , 
--    cogs FLOAT , 
--    total_sales FLOAT 


-- );
-- SELECT COUNT(*) FROM retail_sales ;
-- -- DATE CLEANING
-- SELECT * FROM retail_sales 
-- WHERE transaction_id IS NULL
-- OR 
-- sales_date IS NULL
-- OR 
-- sales_time IS NULL
-- OR
-- customer_id IS NULL 
-- OR  
-- gender IS NULL
-- OR 
-- age IS NULL 
-- OR  
-- category IS NULL
-- OR  
-- quantity IS NULL
-- OR  
-- price_per_unit IS NULL 
-- OR 
-- cogs IS NULL
-- OR 
-- total_sales IS NULL ;

-- DELETE FROM retail_sales
-- WHERE transaction_id IS NULL
-- OR 
-- sales_date IS NULL
-- OR 
-- sales_time IS NULL
-- OR
-- customer_id IS NULL 
-- OR  
-- gender IS NULL
-- OR 
-- age IS NULL 
-- OR  
-- category IS NULL
-- OR  
-- quantity IS NULL
-- OR  
-- price_per_unit IS NULL 
-- OR 
-- cogs IS NULL
-- OR 
-- total_sales IS NULL ;

-- DATE EXPLORATION
-- HOW MANY SALES WE HAVE?
-- SELECT COUNT(*) FROM retail_sales ;

-- HOW MANY UNIQUE CUSTOMER WE HAVE?
-- SELECT COUNT(DISTINCT customer_id) FROM retail_sales ;

-- HOW MANY UNQIUE CATEGORY WE HAVE?
-- SELECT DISTINCT category FROM retail_sales ;



-- DATA ANALYSIS AND BUSINESS KEY PROBLEM AND ASNWERS:
-- Q1 : WRITE SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON '2022-11-05' 
-- SELECT sales_date,
-- COUNT(sales_date) AS total_sale
-- FROM retail_sales
-- WHERE sales_date = '2022-11-05'
-- GROUP BY sales_date;

-- Q2 :WRITE A SQL QUERY TO RETRIEVE ALL TRANSACTION WHERE COMAPNY IS 'CLOTHING' AND THE QUANTITY SOLD IS LESS THEN OR EQUAL TO  4 IN MONTH OF NOV-22 
-- SELECT  *
-- FROM retail_sales
-- WHERE category = 'Clothing' AND quantity <= 4
-- AND DATE_FORMAT(sales_date, '%Y-%m') = '2022-11';


-- Q3 : WRITE THE SQL QUERY TO CALCULATE TOTAL SALES FOR EACH CATEGORY
-- SELECT category ,
-- SUM(total_sales) AS TOTAL_SALES ,
-- COUNT(*) AS TOTAL_ORDERS
-- FROM retail_sales 
-- GROUP BY category ;

-- Q4 : WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMER WHO PURCHASE ITEM FROM 'BEAUTY' CATEGORY 
-- SELECT  category,
-- ROUND(AVG(age),0) AS averag_age 
-- FROM retail_sales
-- WHERE category = 'Beauty';

-- Q5 : WRITE THE SQL QUERY TO FIND ALL TRANSACTION WHERE TOTAL SALES IS GREATER THEN 1000 
-- SELECT 
-- *
-- FROM retail_sales 
-- WHERE total_sales > 1000;

-- Q6 : WIRTE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSCTION (transactions_id) MADE BY EACH GENDER IN EACH CATEGORY
-- SELECT category , gender,
-- COUNT(transactions_id) AS total_num_transaction 
-- FROM retail_sales
-- GROUP BY category , gender ;

-- Q7 : WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE OF EACH MONTH . FIND OUT THE BEST SELLING MONTH FOR EACH YEAR
-- WITH best_selling_month AS (
-- SELECT
-- YEAR(sales_date) AS Year,
-- MONTH (sales_date) AS month,
-- ROUND( AVG(total_sales),0) AS AVG_SALE ,
-- RANK() OVER(PARTITION BY YEAR(sales_date) ORDER BY ROUND( AVG(total_sales),0) DESC ) AS RNK
-- FROM retail_sales 
-- GROUP BY YEAR(sales_date) ,
-- MONTH(sales_date)
-- ) 
-- SELECT Year , month , AVG_SALE , RNK
-- FROM best_selling_month
-- WHERE RNK = 1;

-- Q8 : WRITE A SQL QUERY TO FIND TOP 5 CUSTOMER BASED ON THE HIGHEST TOTAL SALE 
--- - SELECT customer_id ,
-- -- SUM(total_sales) AS total_sales 
-- -- FROM retail_sales 
-- -- GROUP BY customer_id 
-- -- ORDER BY total_sales DESC 
-- -- LIMIT 5; 

-- Q9 : WRITE THE SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMER WHO PURCHASE ITEM FROM EACH CATEGORY
SELECT category, 
COUNT(DISTINCT customer_id ) AS UNIQUE_CUSTOMER 
FROM retail_sales
GROUP BY category ;


-- Q10 : WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDER (EXAMPLE MORNING <= 12 AFTERNOON BETWEEN 12 & 17 EVENING > 17)
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











