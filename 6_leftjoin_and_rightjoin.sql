
USE Salesdb database
--------------------------------------------------------------------------------------------------------------------------
MySQL root@(none):SalesDB> \dt
+-------------------+
| Tables_in_SalesDB |
+-------------------+
| Customers         |
| Orders            |
| Products          |
+-------------------+


MySQL root@(none):SalesDB> SELECT * FROM `Customers`;
+------------+----------------+----------+---------+
| CustomerID | CustomerName   | City     | Country |
+------------+----------------+----------+---------+
| 1          | John Smith     | New York | USA     |
| 2          | Jane Doe       | London   | UK      |
| 3          | Robert Johnson | Paris    | France  |
| 4          | Maria Garcia   | Madrid   | Spain   |
+------------+----------------+----------+---------+


MySQL root@(none):SalesDB> SELECT * FROM `Orders`;
+---------+------------+------------+-------------+-----------+
| OrderID | CustomerID | OrderDate  | TotalAmount | ProductID |
+---------+------------+------------+-------------+-----------+
| 1001    | 1          | 2023-06-01 | 150.00      | 1         |
| 1002    | 2          | 2023-06-02 | 200.00      | 2         |
| 1003    | 1          | 2023-06-03 | 75.50       | 3         |
| 1004    | 3          | 2023-06-04 | 500.00      | 4         |
| 1005    | 4          | 2023-06-05 | 120.00      | 0         |
+---------+------------+------------+-------------+-----------+


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



--------------------------------------------------------------------------------------------------------------------------------------

1) Retrieve all customers and their corresponding orders (if any):

MySQL root@(none):SalesDB> 
	SELECT Customers.CustomerID, Customers.CustomerName, Orders.OrderID, Orders.OrderDate
	FROM Customers
	LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
	+------------+----------------+---------+------------+
	| CustomerID | CustomerName   | OrderID | OrderDate  |
	+------------+----------------+---------+------------+
	| 1          | John Smith     | 1001    | 2023-06-01 |
	| 1          | John Smith     | 1003    | 2023-06-03 |
	| 2          | Jane Doe       | 1002    | 2023-06-02 |
	| 3          | Robert Johnson | 1004    | 2023-06-04 |
	| 4          | Maria Garcia   | 1005    | 2023-06-05 |
	+------------+----------------+---------+------------+
	
	EXPLAINATION:
	This query will return all customers from the Customers table, along with any matching orders from the Orders table. 
	If a customer has no orders, NULL values will be shown for the order-related columns.

--------------------------------------------------------------------------------------------------------------------------------------

2) Get a list of all products and their associated orders (if any):

MySQL root@(none):SalesDB> 
	SELECT P.ProductID , P.ProductName, O.OrderID, O.OrderDate
	FROM Products P
	LEFT JOIN Orders O ON P.ProductID = O.ProductID; 
	+-----------+-------------+---------+------------+
	| ProductID | ProductName | OrderID | OrderDate  |
	+-----------+-------------+---------+------------+
	| 1         | Widget A    | 1001    | 2023-06-01 |
	| 2         | Widget B    | 1002    | 2023-06-02 |
	| 3         | Widget C    | 1003    | 2023-06-03 |
	| 4         | Widget D    | 1004    | 2023-06-04 |
	| 5         | Widget E    | <null>  | <null>     |
	+-----------+-------------+---------+------------+




--------------------------------------------------------------------------------------------------------------------------------------

3) List all orders and the corresponding customer information (if available):

MySQL root@(none):SalesDB> 
	SELECT O.OrderID, O.OrderDate, Customers.CustomerID, Customers.CustomerName
	FROM Orders O
	LEFT JOIN Customers ON O.CustomerID = Customers.CustomerID;
	+---------+------------+------------+----------------+
	| OrderID | OrderDate  | CustomerID | CustomerName   |
	+---------+------------+------------+----------------+
	| 1001    | 2023-06-01 | 1          | John Smith     |
	| 1002    | 2023-06-02 | 2          | Jane Doe       |
	| 1003    | 2023-06-03 | 1          | John Smith     |
	| 1004    | 2023-06-04 | 3          | Robert Johnson |
	| 1005    | 2023-06-05 | 4          | Maria Garcia   |
	+---------+------------+------------+----------------+




--------------------------------------------------------------------------------------------------------------------------------------

4) Retrieve all customers, their orders, and the associated product details (if any):

MySQL root@(none):SalesDB> 
	SELECT Customers.CustomerID, Customers.CustomerName, Orders.OrderID, Orders.OrderDate, Products.ProductID, Products.ProductName
	FROM Customers
	LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
	LEFT JOIN Products ON Orders.ProductID = Products.ProductID;
	+------------+----------------+---------+------------+-----------+-------------+
	| CustomerID | CustomerName   | OrderID | OrderDate  | ProductID | ProductName |
	+------------+----------------+---------+------------+-----------+-------------+
	| 1          | John Smith     | 1001    | 2023-06-01 | 1         | Widget A    |
	| 1          | John Smith     | 1003    | 2023-06-03 | <null>    | <null>      |
	| 2          | Jane Doe       | 1002    | 2023-06-02 | 2         | Widget B    |
	| 3          | Robert Johnson | 1004    | 2023-06-04 | 4         | Widget D    |
	| 4          | Maria Garcia   | 1005    | 2023-06-05 | <null>    | <null>      |
	+------------+----------------+---------+------------+-----------+-------------+
	
	EXPLAINATION:
	This query combines all three tables using two left joins. 
	It fetches all customers and their orders, along with the associated product details. 
	If there are no matching orders or products, NULL values will be shown for the respective columns.


--------------------------------------------------------------------------------------------------------------------------------------

5) Get a list of all customers and the number of orders they have placed:

MySQL root@(none):SalesDB> 
	SELECT Customers.CustomerID, Customers.CustomerName, COUNT(Orders.OrderID) AS OrderCount
	FROM Customers
	LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
	GROUP BY Customers.CustomerID, Customers.CustomerName;
	+------------+----------------+------------+
	| CustomerID | CustomerName   | OrderCount |
	+------------+----------------+------------+
	| 1          | John Smith     | 2          |
	| 2          | Jane Doe       | 1          |
	| 3          | Robert Johnson | 1          |
	| 4          | Maria Garcia   | 1          |
	+------------+----------------+------------+
	
	EXPLAINATION:
	This query uses a left join to retrieve all customers from the Customers table and counts the number of orders they have placed by joining with the Orders table. 
	It utilizes the GROUP BY clause to group the results by customer and display the order count. 
	If a customer has no orders, the OrderCount will be displayed as 0.	



--------------------------------------------------------------------------------------------------------------------------------------


Right Join is similar to Left Join ......Slight Changes ........Here Dominant Table is Right Table ....

