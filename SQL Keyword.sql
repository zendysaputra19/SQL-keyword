-- buat database northwind
SELECT
	*
FROM orders order by CustomerID desc;
DESCRIBE northwind;
SHOW TABLES;

-- 1. UNION ALL: gabungan city customer dengan supplier
SELECT City FROM customers
UNION ALL
SELECT City FROM suppliers;

-- 2. UNION DISTINCT: gabungan city customer dengan supplier
SELECT City FROM customers
UNION DISTINCT
SELECT City FROM suppliers;

-- 3. kategori customer berdasarkan jumlah transaksi yang mereka lakukan. Jika lebih dari sekali: "1", jika tidak: "0"
SELECT CustomerName, COUNT(*) AS transaction_count,
		CASE WHEN COUNT(*) > 1 THEN 1
        ELSE 0
        END is_returning
 FROM customers c
 JOIN orders o ON c.CustomerID = o.CustomerID
 GROUP BY CustomerName;
 
 -- 4. ada berapa customer yang melakukan transaksi berulang?
 WITH returning_customer AS (
	 SELECT CustomerName, COUNT(*) AS transaction_count,
			CASE WHEN COUNT(*) > 1 THEN 1
			ELSE 0
			END is_returning
	 FROM customers c
	 JOIN orders o ON c.CustomerID = o.CustomerID
	 GROUP BY CustomerName)
 
 SELECT COUNT(*) FROM returning_customer
 WHERE is_returning = 1;