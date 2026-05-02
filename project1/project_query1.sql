-- SELECT
-- 	COUNT(*)
-- FROM public.retail_sales_table



--DELETE NULL

-- DELETE FROM public.retail_sales_table
-- WHERE sale_date IS NULL
--    OR quantity IS NULL
--    OR price_per_unit IS NULL
--    OR cogs IS NULL
--    OR total_sale IS NULL;

-- SELECT *
-- FROM public.retail_sales_table
-- WHERE sale_date IS NULL
--    OR quantity IS NULL
--    OR price_per_unit IS NULL
--    OR cogs IS NULL
--    OR total_sale IS NULL;

-- DELETE FROM public.retail_sales_table
-- WHERE sale_date IS NULL
--    OR quantity IS NULL
--    OR price_per_unit IS NULL
--    OR cogs IS NULL
--    OR total_sale IS NULL;

--HOW MANY SALES WE HAVE?
-- SELECT
-- 	COUNT(*) as total_sale
-- FROM public.retail_sales_table


--HOW MANY CUSTOMERS WE HAVE?(USE DISTINCT TO REMOVE DUPLICATES)
-- SELECT
-- 	COUNT( DISTINCT customer_id) as total_sale
-- FROM public.retail_sales_table

--HOW MANY CATEGORIES(names) WE HAVE?(USE DISTINCT TO REMOVE DUPLICATES)
-- SELECT
-- 	DISTINCT category as total_sale
-- FROM public.retail_sales_table


--BUSINESS PROBLEMS:
--1)WRITE A QUERY TO RETRIEVE ALL COLUMNS FOR SALES FOR A SPECIFIC DAY "2022-11-05"
-- SELECT *
-- FROM public.retail_sales_table
-- WHERE sale_date ='2022-11-05'

--2)WRITE A QUERY TO RETRIEVE ALL THE TRANSACTIONS WHERE THE CATEGORY IS 'CLOTHING' AND THE QUANTITY SOLD IS MORE THAN 3
--IN NOVEMBER 2022

-- SELECT 
-- *
-- FROM public.retail_sales_table
-- WHERE category='Clothing' 
-- AND TO_CHAR(sale_date,'YYYY-MM')='2022-11'
-- AND quantity>3

--3) Calculate total sales for each category.

-- SELECT category,
-- SUM(total_sale) as nett_sale,
-- COUNT(*) as total_orders
-- FROM public.retail_sales_table
-- GROUP BY 1;

--4)CALCULATE AVG AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE BEAUTY CATEGORY

-- SELECT ROUND(AVG(age),3) AS average_beauty
-- FROM public.retail_sales_table
-- WHERE category = 'Beauty'
--   AND age IS NOT NULL


--5)FIND ALL TRANSACTIONS WHERE THE total_sale is greater than 1000

-- SELECT *
-- FROM public.retail_sales_table
-- WHERE total_sale>=1000 
--   AND total_sale IS NOT NULL


-- 6) Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.  

-- SELECT category,gender,
-- COUNT(*) as total_transactions
-- FROM public.retail_sales_table
-- GROUP BY category, gender
-- ORDER BY 1


-- 7) Write a SQL query to calculate the average sale for each month. Find out the best selling month in each year.  

-- SELECT year, month, total_sale AS avg_sale
-- FROM
-- (
--     SELECT 
--         EXTRACT(YEAR FROM sale_date) AS year,
--         EXTRACT(MONTH FROM sale_date) AS month,
--         AVG(total_sale) AS total_sale,
--         RANK() OVER (
--             PARTITION BY EXTRACT(YEAR FROM sale_date)
--             ORDER BY AVG(total_sale) DESC
--         ) AS rank
--     FROM public.retail_sales_table
--     GROUP BY 1,2 
-- ) AS tab1
-- WHERE rank = 1;
--ORDER BY 1,2

-- 8) Write a SQL query to find the top 5 customers based on the highest total sales.  
-- SELECT customer_id,
-- SUM(total_sale) as total_sale
-- FROM public.retail_sales_table
-- GROUP BY 1
-- ORDER BY 2
-- LIMIT 5;

-- 9) Write a SQL query to find the number of unique customers who purchased items from each category.  

-- SELECT category,COUNT(DISTINCT customer_id) as unique_customers
-- FROM public.retail_sales_table
-- GROUP BY category

-- 10) Write a SQL query to create each shift and number of orders (Example: Morning <= 12, Afternoon Between 12 & 17, Evening > 17).
WITH hour_sale AS
(
SELECT *,
CASE 
WHEN EXTRACT(HOUR FROM sale_time)<=12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END as shift
FROM public.retail_sales_table
)
SELECT shift,COUNT(*) as total_orders FROM hour_sale
GROUP BY shift


