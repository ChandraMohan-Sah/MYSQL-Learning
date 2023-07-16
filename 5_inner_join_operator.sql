--------------------------------------------------------------------------------------------
-- Create the SalesDB database
CREATE DATABASE SalesDB;
USE SalesDB;

-- Create the Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(100),
    Country VARCHAR(100)
);

-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    ProductID INT Default 0,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    UnitPrice DECIMAL(10, 2)
);

-- Populate the Customers table
INSERT INTO Customers (CustomerID, CustomerName, City, Country)
VALUES
    (1, 'John Smith', 'New York', 'USA'),
    (2, 'Jane Doe', 'London', 'UK'),
    (3, 'Robert Johnson', 'Paris', 'France'),
    (4, 'Maria Garcia', 'Madrid', 'Spain');

-- Populate the Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
    (1001, 1, '2023-06-01', 150.00),
    (1002, 2, '2023-06-02', 200.00),
    (1003, 1, '2023-06-03', 75.50),
    (1004, 3, '2023-06-04', 500.00),
    (1005, 4, '2023-06-05', 120.00);

-- Populate the Products table
INSERT INTO Products (ProductID, ProductName, UnitPrice)
VALUES
    (1, 'Widget A', 10.00),
    (2, 'Widget B', 15.00),
    (3, 'Widget C', 20.00),
    (4, 'Widget D', 25.00),
    (5, 'Widget E', 30.00);


-----------------------------Given Database---------------------------------------------------------------------

MySQL root@(none):SalesDB> SELECT *FROM Customers;
+------------+----------------+----------+---------+
| CustomerID | CustomerName   | City     | Country |
+------------+----------------+----------+---------+
| 1          | John Smith     | New York | USA     |
| 2          | Jane Doe       | London   | UK      |
| 3          | Robert Johnson | Paris    | France  |
| 4          | Maria Garcia   | Madrid   | Spain   |
+------------+----------------+----------+---------+


MySQL root@(none):SalesDB> SELECT * FROM Orders;
+---------+------------+------------+-------------+-----------+
| OrderID | CustomerID | OrderDate  | TotalAmount | ProductID |
+---------+------------+------------+-------------+-----------+
| 1001    | 1          | 2023-06-01 | 150.00      | 1         |
| 1002    | 2          | 2023-06-02 | 200.00      | 2         |
| 1003    | 1          | 2023-06-03 | 75.50       | 3         |
| 1004    | 3          | 2023-06-04 | 500.00      | 4         |
| 1005    | 4          | 2023-06-05 | 120.00      | 5         |
+---------+------------+------------+-------------+-----------+



MySQL root@(none):SalesDB> SELECT *FROM Products;
+-----------+-------------+-----------+
| ProductID | ProductName | UnitPrice |
+-----------+-------------+-----------+
| 1         | Widget A    | 10.00     |
| 2         | Widget B    | 15.00     |
| 3         | Widget C    | 20.00     |
| 4         | Widget D    | 25.00     |
| 5         | Widget E    | 30.00     |
+-----------+-------------+-----------+

-------------------------------INNER JOIN--------------------------------------------------------------------------------------------------

1)Retrieve customer information along with their corresponding orders:

MySQL root@(none):SalesDB>
	SELECT Customers.CustomerID , Customers.CustomerName, 
	Orders.OrderID, Orders.OrderDate, Orders.TotalAmount
	FROM Customers INNER JOIN `Orders` 
	ON Customers.CustomerID = Orders.CustomerID;
	+------------+----------------+---------+------------+-------------+
	| CustomerID | CustomerName   | OrderID | OrderDate  | TotalAmount |
	+------------+----------------+---------+------------+-------------+
	| 1          | John Smith     | 1001    | 2023-06-01 | 150.00      |
	| 1          | John Smith     | 1003    | 2023-06-03 | 75.50       |
	| 2          | Jane Doe       | 1002    | 2023-06-02 | 200.00      |
	| 3          | Robert Johnson | 1004    | 2023-06-04 | 500.00      |
	| 4          | Maria Garcia   | 1005    | 2023-06-05 | 120.00      |
	+------------+----------------+---------+------------+-------------+
	
	Explanation:
	FROM Customers ---> It tells database engine that we want to retrieve data from the Customers Table.
	INNER JOIN `Orders` ---> Table that we want to join with Customers
	ON Customers.CustomerID = Orders.CustomerID;  
	--->This part of the line specifies the joining condition.
	--- It tells the database engine how to match the rows between the Customers and Order tables. 
	--- In this case, it matches the CustomerID column in the Customers table with the CustomersID column in the Orders					
	--- table.	
	



--------------------------------------------------------------------------------------------------------------------------------------------

					     	
2)Get the product details for each order:

MySQL root@(none):SalesDB> 
	SELECT Orders.OrderID , Products.ProductID, Products.ProductName, Products.UnitPrice
	FROM Orders
	INNER JOIN Products ON Orders.ProductID = Products.ProductID;
	+---------+-----------+-------------+-----------+
	| OrderID | ProductID | ProductName | UnitPrice |
	+---------+-----------+-------------+-----------+
	| 1001    | 1         | Widget A    | 10.00     |
	| 1002    | 2         | Widget B    | 15.00     |
	| 1003    | 3         | Widget C    | 20.00     |
	| 1004    | 4         | Widget D    | 25.00     |
	| 1005    | 5         | Widget E    | 30.00     |
	+---------+-----------+-------------+-----------+



--Updatating for clearity
MySQL root@(none):SalesDB> 
	UPDATE Orders SET ProductID = 0
	WHERE OrderID = 1005;

	MySQL root@(none):SalesDB> SELECT *FROM Orders;
	+---------+------------+------------+-------------+-----------+
	| OrderID | CustomerID | OrderDate  | TotalAmount | ProductID |
	+---------+------------+------------+-------------+-----------+
	| 1001    | 1          | 2023-06-01 | 150.00      | 1         |
	| 1002    | 2          | 2023-06-02 | 200.00      | 2         |
	| 1003    | 1          | 2023-06-03 | 75.50       | 3         |
	| 1004    | 3          | 2023-06-04 | 500.00      | 4         |
	| 1005    | 4          | 2023-06-05 | 120.00      | 0         |
	+---------+------------+------------+-------------+-----------+


MySQL root@(none):SalesDB> 
	SELECT Orders.OrderID , Products.ProductID, Products.ProductName, Products.UnitPrice
	FROM `Products`
	INNER JOIN `Orders` ON Orders.ProductID = Products.ProductID;
	+---------+-----------+-------------+-----------+
	| OrderID | ProductID | ProductName | UnitPrice |
	+---------+-----------+-------------+-----------+
	| 1001    | 1         | Widget A    | 10.00     |
	| 1002    | 2         | Widget B    | 15.00     |
	| 1003    | 3         | Widget C    | 20.00     |
	| 1004    | 4         | Widget D    | 25.00     |
	+---------+-----------+-------------+-----------+



--------------------------------------------------------------------------------------------------------------------------------------------




3) List the customers and their orders, including the product name:

MySQL root@(none):SalesDB> 
	SELECT Customers.CustomerID, Customers.CustomerName, Orders.OrderID, Orders.OrderDate, Products.ProductName
	FROM Customers
	INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
	INNER JOIN Products ON Orders.ProductID = Products.ProductID;
	+------------+----------------+---------+------------+-------------+
	| CustomerID | CustomerName   | OrderID | OrderDate  | ProductName |
	+------------+----------------+---------+------------+-------------+
	| 1          | John Smith     | 1001    | 2023-06-01 | Widget A    |
	| 1          | John Smith     | 1003    | 2023-06-03 | Widget C    |
	| 2          | Jane Doe       | 1002    | 2023-06-02 | Widget B    |
	| 3          | Robert Johnson | 1004    | 2023-06-04 | Widget D    |
	+------------+----------------+---------+------------+-------------+



--------------------------------------------------------------------------------------------------------------------------------------------



4) Retrieve all orders made by customers from a specific country:

MySQL root@(none):SalesDB> 
	SELECT C.CustomerName ,C.Country , Orders.OrderId, Orders.OrderDate, Orders.TotalAmount
	FROM Customers C
	INNER JOIN Orders ON C.CustomerID = Orders.CustomerID
	WHERE C.Country = 'USA';
	+--------------+---------+---------+------------+-------------+
	| CustomerName | Country | OrderId | OrderDate  | TotalAmount |
	+--------------+---------+---------+------------+-------------+
	| John Smith   | USA     | 1001    | 2023-06-01 | 150.00      |
	| John Smith   | USA     | 1003    | 2023-06-03 | 75.50       |
	+--------------+---------+---------+------------+-------------+



--------------------------------------------------------------------------------------------------------------------------------------------

5) Get the total sales amount for each customer:

MySQL root@(none):SalesDB> 
	SELECT Customers.CustomerID, Customers.CustomerName, SUM(Orders.TotalAmount) AS TotalSales
	FROM Customers
	INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
	GROUP BY Customers.CustomerID, Customers.CustomerName;
	+------------+----------------+------------+
	| CustomerID | CustomerName   | TotalSales |
	+------------+----------------+------------+
	| 1          | John Smith     | 225.50     |
	| 2          | Jane Doe       | 200.00     |
	| 3          | Robert Johnson | 500.00     |
	| 4          | Maria Garcia   | 120.00     |
	+------------+----------------+------------+




--------------------------------------------------------------------------------------------------------------------------------------------

6) List the customers who have made orders and the corresponding product details:

MySQL root@(none):SalesDB> 
	SELECT C.CustomerID, C.CustomerName, Orders.OrderID, Products.ProductName, Products.UnitPrice
	FROM Customers C
	INNER JOIN Orders ON C.CustomerID = Orders.CustomerID
	INNER JOIN Products ON Orders.ProductID = Products.ProductID;
	+------------+----------------+---------+-------------+-----------+
	| CustomerID | CustomerName   | OrderID | ProductName | UnitPrice |
	+------------+----------------+---------+-------------+-----------+
	| 1          | John Smith     | 1001    | Widget A    | 10.00     |
	| 1          | John Smith     | 1003    | Widget C    | 20.00     |
	| 2          | Jane Doe       | 1002    | Widget B    | 15.00     |
	| 3          | Robert Johnson | 1004    | Widget D    | 25.00     |
	+------------+----------------+---------+-------------+-----------+



In summary, this query retrieves data from the Customers, Orders, and Products tables and combines them using inner join operations. 
The first inner join combines the Customers and Orders tables based on matching CustomerID values, and then the second inner join combines the resulting data with the Products table based on matching ProductID values. 
The resulting rows will contain columns from all three tables, including CustomerID, CustomerName from the Customers table, OrderID, OrderDate from the Orders table, and ProductName from the Products table.



--------------------------------------------------------------------------------------------------------------------------------------------
