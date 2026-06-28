/* ============================================================
   Project: Big Data Analytics for E-Commerce Retail Performance
   File: ecommerce_data_cleaning_queries.sql
   Purpose: SQL Server queries used for data inspection, cleaning,
            transformation, and preparation for Tableau analysis.
   Tool: Microsoft SQL Server Management Studio
   ============================================================ */


/* ------------------------------------------------------------
   1. Inspect customer table
   ------------------------------------------------------------ */

SELECT TOP 10 *
FROM dbo.customer_dim;


/* ------------------------------------------------------------
   2. Check missing values in customer table
   ------------------------------------------------------------ */

SELECT *
FROM dbo.customer_dim
WHERE customer_key IS NULL
   OR name IS NULL
   OR contact_no IS NULL
   OR nid IS NULL;


/* Count missing customer names */
SELECT 
    COUNT(CASE WHEN name IS NULL THEN 1 END) AS missing_name_count
FROM dbo.customer_dim;


/* ------------------------------------------------------------
   3. Replace missing customer names
   ------------------------------------------------------------ */

UPDATE dbo.customer_dim
SET name = 'Unknown'
WHERE name IS NULL;


/* Verify missing customer names after cleaning */
SELECT 
    COUNT(CASE WHEN name IS NULL THEN 1 END) AS missing_name_count
FROM dbo.customer_dim;


/* ------------------------------------------------------------
   4. Check duplicate customer keys
   ------------------------------------------------------------ */

SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM dbo.customer_dim
GROUP BY customer_key
HAVING COUNT(*) > 1;


/* ------------------------------------------------------------
   5. Check duplicate contact numbers
   ------------------------------------------------------------ */

SELECT 
    contact_no,
    COUNT(*) AS duplicate_count
FROM dbo.customer_dim
GROUP BY contact_no
HAVING COUNT(*) > 1;


/* ------------------------------------------------------------
   6. Inspect store table
   ------------------------------------------------------------ */

SELECT TOP 10 *
FROM dbo.store_dim;


/* ------------------------------------------------------------
   7. Add country column for Tableau geographic mapping
   ------------------------------------------------------------ */

ALTER TABLE dbo.store_dim
ADD country VARCHAR(50);


/* Fill country column */
UPDATE dbo.store_dim
SET country = 'Bangladesh';


/* Verify country field */
SELECT TOP 10 *
FROM dbo.store_dim;


/* ------------------------------------------------------------
   8. Standardise division names
   ------------------------------------------------------------ */

UPDATE dbo.store_dim
SET division = 'CHATTOGRAM'
WHERE division = 'CHITTAGONG';


/* Assign newly created Mymensingh division districts */
UPDATE dbo.store_dim
SET division = 'MYMENSINGH'
WHERE district IN ('MYMENSINGH', 'NETROKONA', 'JAMALPUR', 'SHERPUR');


/* Verify updated location fields */
SELECT DISTINCT 
    division,
    district,
    country
FROM dbo.store_dim
ORDER BY division, district;


/* ------------------------------------------------------------
   9. Top-selling products by total sales
   ------------------------------------------------------------ */

SELECT 
    i.item_name,
    SUM(f.total_price) AS total_sales,
    SUM(f.quantity) AS total_quantity
FROM dbo.fact_table AS f
INNER JOIN dbo.item_dim AS i
    ON f.item_key = i.item_key
GROUP BY i.item_name
ORDER BY total_sales DESC;


/* ------------------------------------------------------------
   10. Sales by division
   ------------------------------------------------------------ */

SELECT 
    s.division,
    SUM(f.total_price) AS total_sales
FROM dbo.fact_table AS f
INNER JOIN dbo.store_dim AS s
    ON f.store_key = s.store_key
GROUP BY s.division
ORDER BY total_sales DESC;


/* ------------------------------------------------------------
   11. Sales by district
   ------------------------------------------------------------ */

SELECT 
    s.division,
    s.district,
    SUM(f.total_price) AS total_sales
FROM dbo.fact_table AS f
INNER JOIN dbo.store_dim AS s
    ON f.store_key = s.store_key
GROUP BY s.division, s.district
ORDER BY total_sales DESC;


/* ------------------------------------------------------------
   12. Payment method analysis
   ------------------------------------------------------------ */

SELECT 
    t.trans_type AS payment_method,
    COUNT(*) AS number_of_transactions,
    SUM(f.total_price) AS total_sales
FROM dbo.fact_table AS f
INNER JOIN dbo.trans_dim AS t
    ON f.payment_key = t.payment_key
GROUP BY t.trans_type
ORDER BY total_sales DESC;


/* ------------------------------------------------------------
   13. Sales trend over time
   ------------------------------------------------------------ */

SELECT 
    tm.year,
    tm.month,
    SUM(f.total_price) AS total_sales
FROM dbo.fact_table AS f
INNER JOIN dbo.time_dim AS tm
    ON f.time_key = tm.time_key
GROUP BY tm.year, tm.month
ORDER BY tm.year, tm.month;


/* ------------------------------------------------------------
   14. Customer count by mobile operator
   Note: contact_no is converted to VARCHAR to avoid numeric errors.
   ------------------------------------------------------------ */

SELECT
    CASE
        WHEN LEFT(CAST(contact_no AS VARCHAR(20)), 3) = '017' THEN 'Grameenphone'
        WHEN LEFT(CAST(contact_no AS VARCHAR(20)), 3) = '018' THEN 'Robi'
        WHEN LEFT(CAST(contact_no AS VARCHAR(20)), 3) = '019' THEN 'Banglalink'
        WHEN LEFT(CAST(contact_no AS VARCHAR(20)), 3) = '016' THEN 'Airtel'
        WHEN LEFT(CAST(contact_no AS VARCHAR(20)), 3) = '015' THEN 'Teletalk'
        ELSE 'Unknown'
    END AS mobile_operator,
    COUNT(*) AS number_of_customers
FROM dbo.customer_dim
GROUP BY 
    CASE
        WHEN LEFT(CAST(contact_no AS VARCHAR(20)), 3) = '017' THEN 'Grameenphone'
        WHEN LEFT(CAST(contact_no AS VARCHAR(20)), 3) = '018' THEN 'Robi'
        WHEN LEFT(CAST(contact_no AS VARCHAR(20)), 3) = '019' THEN 'Banglalink'
        WHEN LEFT(CAST(contact_no AS VARCHAR(20)), 3) = '016' THEN 'Airtel'
        WHEN LEFT(CAST(contact_no AS VARCHAR(20)), 3) = '015' THEN 'Teletalk'
        ELSE 'Unknown'
    END
ORDER BY number_of_customers DESC;


/* ------------------------------------------------------------
   15. Revenue by mobile operator
   ------------------------------------------------------------ */

SELECT
    CASE
        WHEN LEFT(CAST(c.contact_no AS VARCHAR(20)), 3) = '017' THEN 'Grameenphone'
        WHEN LEFT(CAST(c.contact_no AS VARCHAR(20)), 3) = '018' THEN 'Robi'
        WHEN LEFT(CAST(c.contact_no AS VARCHAR(20)), 3) = '019' THEN 'Banglalink'
        WHEN LEFT(CAST(c.contact_no AS VARCHAR(20)), 3) = '016' THEN 'Airtel'
        WHEN LEFT(CAST(c.contact_no AS VARCHAR(20)), 3) = '015' THEN 'Teletalk'
        ELSE 'Unknown'
    END AS mobile_operator,
    SUM(f.total_price) AS total_sales
FROM dbo.fact_table AS f
INNER JOIN dbo.customer_dim AS c
    ON f.customer_key = c.customer_key
GROUP BY
    CASE
        WHEN LEFT(CAST(c.contact_no AS VARCHAR(20)), 3) = '017' THEN 'Grameenphone'
        WHEN LEFT(CAST(c.contact_no AS VARCHAR(20)), 3) = '018' THEN 'Robi'
        WHEN LEFT(CAST(c.contact_no AS VARCHAR(20)), 3) = '019' THEN 'Banglalink'
        WHEN LEFT(CAST(c.contact_no AS VARCHAR(20)), 3) = '016' THEN 'Airtel'
        WHEN LEFT(CAST(c.contact_no AS VARCHAR(20)), 3) = '015' THEN 'Teletalk'
        ELSE 'Unknown'
    END
ORDER BY total_sales DESC;
