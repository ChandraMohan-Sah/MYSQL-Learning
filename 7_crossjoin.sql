-----------------------------------------------------------------------------------------------------------------------------
MySQL root@(none):SalesDB> SELECT * FROM `Customers`;
+------------+----------------+----------+---------+
| CustomerID | CustomerName   | City     | Country |
+------------+----------------+----------+---------+
| 1          | John Smith     | New York | USA     |
| 2          | Jane Doe       | London   | UK      |
| 3          | Robert Johnson | Paris    | France  |
| 4          | Maria Garcia   | Madrid   | Spain   |
+------------+----------------+----------+---------+

MySQL root@(none):SalesDB> SELECT * FROM `Products`;
+-----------+-------------+-----------+
| ProductID | ProductName | UnitPrice |
+-----------+-------------+-----------+
| 1         | Widget A    | 10.00     |
| 2         | Widget B    | 15.00     |
| 3         | Widget C    | 20.00     |
| 4         | Widget D    | 25.00     |
| 5         | Widget E    | 30.00     |
+-----------+-------------+-----------+



-----------------------------------------------------------------------------------------------------------------------------
1)Get the Cartesian product of all customers and products:

MySQL root@(none):SalesDB> 
	SELECT Customers.CustomerID, Customers.CustomerName, Products.ProductID, Products.ProductName
	FROM Customers
	CROSS JOIN Products;
	+------------+----------------+-----------+-------------+
	| CustomerID | CustomerName   | ProductID | ProductName |
	+------------+----------------+-----------+-------------+
	| 4          | Maria Garcia   | 1         | Widget A    |
	| 3          | Robert Johnson | 1         | Widget A    |
	| 2          | Jane Doe       | 1         | Widget A    |
	| 1          | John Smith     | 1         | Widget A    |
	| 4          | Maria Garcia   | 2         | Widget B    |
	| 3          | Robert Johnson | 2         | Widget B    |
	| 2          | Jane Doe       | 2         | Widget B    |
	| 1          | John Smith     | 2         | Widget B    |
	| 4          | Maria Garcia   | 3         | Widget C    |
	| 3          | Robert Johnson | 3         | Widget C    |
	| 2          | Jane Doe       | 3         | Widget C    |
	| 1          | John Smith     | 3         | Widget C    |
	| 4          | Maria Garcia   | 4         | Widget D    |
	| 3          | Robert Johnson | 4         | Widget D    |
	| 2          | Jane Doe       | 4         | Widget D    |
	| 1          | John Smith     | 4         | Widget D    |
	| 4          | Maria Garcia   | 5         | Widget E    |
	| 3          | Robert Johnson | 5         | Widget E    |
	| 2          | Jane Doe       | 5         | Widget E    |
	| 1          | John Smith     | 5         | Widget E    |
	+------------+----------------+-----------+-------------+
	
	EXPLAINATION:
	This query will retrieve all combinations of customers and products by performing a cross join between the Customers table and the Products table. 
	It generates a result set where each customer is paired with every product.
	

-----------------------------------------------------------------------------------------------------------------------------
2)List all customers and show the total number of products available:

MySQL root@(none):SalesDB> 
	SELECT Customers.CustomerID, Customers.CustomerName, COUNT(Products.ProductID) AS TotalProducts
	FROM Customers
	CROSS JOIN Products
	GROUP BY Customers.CustomerID, Customers.CustomerName;
	+------------+----------------+---------------+
	| CustomerID | CustomerName   | TotalProducts |
	+------------+----------------+---------------+
	| 4          | Maria Garcia   | 5             |
	| 3          | Robert Johnson | 5             |
	| 2          | Jane Doe       | 5             |
	| 1          | John Smith     | 5             |
	+------------+----------------+---------------+


	--slight changes using Order BY
	MySQL root@(none):SalesDB> 
		SELECT Customers.CustomerID, Customers.CustomerName, COUNT(Products.ProductID) AS TotalProducts
		FROM Customers
		CROSS JOIN Products
		GROUP BY Customers.CustomerID, Customers.CustomerName
		ORDER BY `CustomerID` asc;
	+------------+----------------+---------------+
	| CustomerID | CustomerName   | TotalProducts |
	+------------+----------------+---------------+
	| 1          | John Smith     | 5             |
	| 2          | Jane Doe       | 5             |
	| 3          | Robert Johnson | 5             |
	| 4          | Maria Garcia   | 5             |
	+------------+----------------+---------------+

	EXPLAINATION:
	This query calculates the total number of products available to each customer by performing a cross join between the Customers table and the Products table. 
	It uses the COUNT() function to count the number of product IDs and assigns it the alias "TotalProducts".


-----------------------------------------------------------------------------------------------------------------------------

3) Get the Cartesian product of all orders and products:

MySQL root@(none):SalesDB> 
	SELECT Orders.OrderID, Orders.OrderDate, Products.ProductID, Products.ProductName
	FROM Orders
	CROSS JOIN Products;
	+---------+------------+-----------+-------------+
	| OrderID | OrderDate  | ProductID | ProductName |
	+---------+------------+-----------+-------------+
	| 1005    | 2023-06-05 | 1         | Widget A    |
	| 1004    | 2023-06-04 | 1         | Widget A    |
	| 1003    | 2023-06-03 | 1         | Widget A    |
	| 1002    | 2023-06-02 | 1         | Widget A    |
	| 1001    | 2023-06-01 | 1         | Widget A    |
	| 1005    | 2023-06-05 | 2         | Widget B    |
	| 1004    | 2023-06-04 | 2         | Widget B    |
	| 1003    | 2023-06-03 | 2         | Widget B    |
	| 1002    | 2023-06-02 | 2         | Widget B    |
	| 1001    | 2023-06-01 | 2         | Widget B    |
	| 1005    | 2023-06-05 | 3         | Widget C    |
	| 1004    | 2023-06-04 | 3         | Widget C    |
	| 1003    | 2023-06-03 | 3         | Widget C    |
	| 1002    | 2023-06-02 | 3         | Widget C    |
	| 1001    | 2023-06-01 | 3         | Widget C    |
	| 1005    | 2023-06-05 | 4         | Widget D    |
	| 1004    | 2023-06-04 | 4         | Widget D    |
	| 1003    | 2023-06-03 | 4         | Widget D    |
	| 1002    | 2023-06-02 | 4         | Widget D    |
	| 1001    | 2023-06-01 | 4         | Widget D    |
	| 1005    | 2023-06-05 | 5         | Widget E    |
	| 1004    | 2023-06-04 | 5         | Widget E    |
	| 1003    | 2023-06-03 | 5         | Widget E    |
	| 1002    | 2023-06-02 | 5         | Widget E    |
	| 1001    | 2023-06-01 | 5         | Widget E    |
	+---------+------------+-----------+-------------+
	
	


--------------------------------------UPADTION---------------------------------------------------------------------------------------


MySQL root@(none):SalesDB> SELECT *FROM `Orders`;
+---------+------------+------------+-------------+-----------+
| OrderID | CustomerID | OrderDate  | TotalAmount | ProductID |
+---------+------------+------------+-------------+-----------+
| 1001    | 1          | 2023-06-01 | 150.00      | 1         |
| 1002    | 2          | 2023-06-02 | 200.00      | 2         |
| 1003    | 1          | 2023-06-03 | 75.50       | 0         |
| 1004    | 3          | 2023-06-04 | 500.00      | 4         |
| 1005    | 4          | 2023-06-05 | 120.00      | 0         |
+---------+------------+------------+-------------+-----------+

MySQL root@(none):SalesDB> ALTER TABLE Orders ADD COLUMN Quantity INT;

MySQL root@(none):SalesDB> SELECT *FROM `Orders`;
+---------+------------+------------+-------------+-----------+----------+
| OrderID | CustomerID | OrderDate  | TotalAmount | ProductID | Quantity |
+---------+------------+------------+-------------+-----------+----------+
| 1001    | 1          | 2023-06-01 | 150.00      | 1         | <null>   |
| 1002    | 2          | 2023-06-02 | 200.00      | 2         | <null>   |
| 1003    | 1          | 2023-06-03 | 75.50       | 0         | <null>   |
| 1004    | 3          | 2023-06-04 | 500.00      | 4         | <null>   |
| 1005    | 4          | 2023-06-05 | 120.00      | 0         | <null>   |
+---------+------------+------------+-------------+-----------+----------+

MySQL root@(none):SalesDB> UPDATE Orders SET Quantity = 5
WHERE OrderID = 1001;
MySQL root@(none):SalesDB> UPDATE Orders SET Quantity = 3
WHERE OrderID = 1002;
MySQL root@(none):SalesDB> UPDATE Orders SET Quantity = 2
WHERE OrderID = 1003;
MySQL root@(none):SalesDB> UPDATE Orders SET Quantity = 2
WHERE OrderID = 1004;
MySQL root@(none):SalesDB> UPDATE Orders SET Quantity = 6
WHERE OrderID = 1005;
MySQL root@(none):SalesDB> SELECT *FROM `Orders`;
+---------+------------+------------+-------------+-----------+----------+
| OrderID | CustomerID | OrderDate  | TotalAmount | ProductID | Quantity |
+---------+------------+------------+-------------+-----------+----------+
| 1001    | 1          | 2023-06-01 | 150.00      | 1         | 5        |
| 1002    | 2          | 2023-06-02 | 200.00      | 2         | 3        |
| 1003    | 1          | 2023-06-03 | 75.50       | 0         | 2        |
| 1004    | 3          | 2023-06-04 | 500.00      | 4         | 2        |
| 1005    | 4          | 2023-06-05 | 120.00      | 0         | 6        |
+---------+------------+------------+-------------+-----------+----------+


-----------------------------------------------------------------------------------------------------------------------------

MySQL root@(none):SalesDB> SELECT * FROM `Products`;
+-----------+-------------+-----------+
| ProductID | ProductName | UnitPrice |
+-----------+-------------+-----------+
| 1         | Widget A    | 10.00     |
| 2         | Widget B    | 15.00     |
| 3         | Widget C    | 20.00     |
| 4         | Widget D    | 25.00     |
| 5         | Widget E    | 30.00     |
+-----------+-------------+-----------+


MySQL root@(none):SalesDB> SELECT * FROM `Orders`;
+---------+------------+------------+-------------+-----------+----------+
| OrderID | CustomerID | OrderDate  | TotalAmount | ProductID | Quantity |
+---------+------------+------------+-------------+-----------+----------+
| 1001    | 1          | 2023-06-01 | 150.00      | 1         | 5        |
| 1002    | 2          | 2023-06-02 | 200.00      | 2         | 3        |
| 1003    | 1          | 2023-06-03 | 75.50       | 0         | 2        |
| 1004    | 3          | 2023-06-04 | 500.00      | 4         | 2        |
| 1005    | 4          | 2023-06-05 | 120.00      | 0         | 6        |
+---------+------------+------------+-------------+-----------+----------+


MySQL root@(none):SalesDB> SELECT * FROM `Customers`;
+------------+----------------+----------+---------+
| CustomerID | CustomerName   | City     | Country |
+------------+----------------+----------+---------+
| 1          | John Smith     | New York | USA     |
| 2          | Jane Doe       | London   | UK      |
| 3          | Robert Johnson | Paris    | France  |
| 4          | Maria Garcia   | Madrid   | Spain   |
+------------+----------------+----------+---------+



4) Retrieve all orders and calculate the total cost for each product:

MySQL root@(none):SalesDB> 
	SELECT O.OrderID, P.`ProductName` , O.`Quantity`, P.`UnitPrice`,  (O.Quantity * P.UnitPrice) AS TotalCost
	FROM Orders O
	CROSS JOIN Products P;
	+---------+-------------+----------+-----------+-----------+
	| OrderID | ProductName | Quantity | UnitPrice | TotalCost |
	+---------+-------------+----------+-----------+-----------+
	| 1005    | Widget A    | 6        | 10.00     | 60.00     |
	| 1004    | Widget A    | 2        | 10.00     | 20.00     |
	| 1003    | Widget A    | 2        | 10.00     | 20.00     |
	| 1002    | Widget A    | 3        | 10.00     | 30.00     |
	| 1001    | Widget A    | 5        | 10.00     | 50.00     |
	| 1005    | Widget B    | 6        | 15.00     | 90.00     |
	| 1004    | Widget B    | 2        | 15.00     | 30.00     |
	| 1003    | Widget B    | 2        | 15.00     | 30.00     |
	| 1002    | Widget B    | 3        | 15.00     | 45.00     |
	| 1001    | Widget B    | 5        | 15.00     | 75.00     |
	| 1005    | Widget C    | 6        | 20.00     | 120.00    |
	| 1004    | Widget C    | 2        | 20.00     | 40.00     |
	| 1003    | Widget C    | 2        | 20.00     | 40.00     |
	| 1002    | Widget C    | 3        | 20.00     | 60.00     |
	| 1001    | Widget C    | 5        | 20.00     | 100.00    |
	| 1005    | Widget D    | 6        | 25.00     | 150.00    |
	| 1004    | Widget D    | 2        | 25.00     | 50.00     |
	| 1003    | Widget D    | 2        | 25.00     | 50.00     |
	| 1002    | Widget D    | 3        | 25.00     | 75.00     |
	| 1001    | Widget D    | 5        | 25.00     | 125.00    |
	| 1005    | Widget E    | 6        | 30.00     | 180.00    |
	| 1004    | Widget E    | 2        | 30.00     | 60.00     |
	| 1003    | Widget E    | 2        | 30.00     | 60.00     |
	| 1002    | Widget E    | 3        | 30.00     | 90.00     |
	| 1001    | Widget E    | 5        | 30.00     | 150.00    |
	+---------+-------------+----------+-----------+-----------+
	
	EXPLAINATION:
	This query calculates the total cost for each product in every order by performing a cross join between the Orders table and the Products table. 
	It multiplies the quantity of each order with the unit price of the product to calculate the total cost.


-----------------------------------------------------------------------------------------------------------------------------

5) List all customers and products with a flag indicating whether they have a matching order:

MySQL root@(none):SalesDB> 
	SELECT Customers.CustomerID, Customers.CustomerName, Products.ProductName, Orders.OrderID,
	CASE WHEN Orders.OrderID IS NOT NULL THEN 'Yes' ELSE 'No' END AS HasOrder
	FROM Customers
	CROSS JOIN Products
	LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID AND Products.ProductID = Orders.ProductID
	ORDER BY `CustomerID`ASC;

	+------------+----------------+-------------+---------+----------+
	| CustomerID | CustomerName   | ProductName | OrderID | HasOrder |
	+------------+----------------+-------------+---------+----------+
	| 1          | John Smith     | Widget E    | <null>  | No       |
	| 1          | John Smith     | Widget A    | 1001    | Yes      |
	| 1          | John Smith     | Widget D    | <null>  | No       |
	| 1          | John Smith     | Widget C    | <null>  | No       |
	| 1          | John Smith     | Widget B    | <null>  | No       |
	| 2          | Jane Doe       | Widget C    | <null>  | No       |
	| 2          | Jane Doe       | Widget E    | <null>  | No       |
	| 2          | Jane Doe       | Widget D    | <null>  | No       |
	| 2          | Jane Doe       | Widget B    | 1002    | Yes      |
	| 2          | Jane Doe       | Widget A    | <null>  | No       |
	| 3          | Robert Johnson | Widget C    | <null>  | No       |
	| 3          | Robert Johnson | Widget D    | 1004    | Yes      |
	| 3          | Robert Johnson | Widget B    | <null>  | No       |
	| 3          | Robert Johnson | Widget E    | <null>  | No       |
	| 3          | Robert Johnson | Widget A    | <null>  | No       |
	| 4          | Maria Garcia   | Widget C    | <null>  | No       |
	| 4          | Maria Garcia   | Widget A    | <null>  | No       |
	| 4          | Maria Garcia   | Widget D    | <null>  | No       |
	| 4          | Maria Garcia   | Widget B    | <null>  | No       |
	| 4          | Maria Garcia   | Widget E    | <null>  | No       |
	+------------+----------------+-------------+---------+----------+

	
	EXPLAINATION:
	This query performs a cross join between the Customers table and the Products table. 
	It then uses a left join with the Orders table to determine whether each customer-product combination has a matching order. 
	The CASE statement is used to display 'Yes' if there is a matching order and 'No' otherwise.


-----------------------------------------------------------------------------------------------------------------------------


