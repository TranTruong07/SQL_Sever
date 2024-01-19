--- FUNCTIONS IN SQL SERVER -------------

--> INPUT ---> PROCESSING ---> OUTPUT
--- (Single Value / Single Record) -> Scalar Function
---- (set of values)  --> Aggregate function (statistic)

--- Build-IN Functions / Custom Functions

SELECT DATEPART(dw,'2023-10-15')

SELECT MONTH(OrderDate) FROM Orders
SELECT DATEPART(dy,OrderDate), OrderDate FROM Orders
SELECT DATEPART(dw,OrderDate), OrderDate FROM Orders

SELECT 
	CONCAT(LOWER(SUBSTRING(CompanyName,1,LEN(CompanyName)-1)) 
	,UPPER(SUBSTRING(CompanyName,LEN(CompanyName),1))) as [Stupid Name]
	,CompanyName
FROM Customers


SELECT CustomerID,CompanyName FROm Customers WHERE Country = 'Brazil'
UNION
SELECT CustomerID,CompanyName FROm Customers WHERE Country = 'Germany'

-- AGGREGATE FUNCTIONS
-- MIN,MAX, SUM, AVG, COUNT, 
SELECT TOP 5 * FROM Customers ORDER BY CustomerID ASC
SELECT MIN(OrderDate) FROM Orders
SELECT MAX(OrderDate) FROM Orders
SELECT AVG(UnitPrice) FROM Products
SELECT COUNT(CustomerID) FROM Customers

SELECT COUNT(Region) FROM Customers
SELECT COUNT(*) FROM Customers

-------------------------------------------------------
-- GROUP BY CLAUSE, HAVING CLAUSE
SELECT CustomerID,COUNT(OrderID) FROM Orders 
GROUP BY CustomerID ORDER BY CustomerID

SELECT * FROM
(SELECT Country,City,COUNT(OrderID) as [Total] 
FROM Customers c INNER JOIN Orders o  ON c.CustomerID = o.CustomerID
GROUP BY Country,City) tbl
WHERE [Total] > 20

SELECT Country,City,COUNT(OrderID) as [Total] 
FROM Customers c INNER JOIN Orders o  ON c.CustomerID = o.CustomerID
WHERE OrderDate >= '1997-1-1'
GROUP BY Country,City HAVING COUNT(OrderID) > 20


SELECT CompanyName, [Total] 
				, CASE WHEN [Total] >= 20 THEN 'VIP'
						WHEN [Total] >= 01 AND [Total] < 20 THEN 'Normal'
						ELSE 'ECO'
					END [Classification]
	FROM
(SELECT CompanyName, COUNT(OrderID) as [Total]
FROM Customers c LEFT JOIN Orders o  ON o.CustomerID = c.CustomerID
GROUP BY CompanyName
) tbl



|CompanyName| OrderID|
   








