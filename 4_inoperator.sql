CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(50)
);


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

------------------------------Given Table-----------------------------------------------------------------------------------


MySQL root@(none):db_IN_SUBQUERY_JOIN> 
SELECT * FROM Customers ;
+-------------+-----------------+----------------------------+
| customer_id | customer_name   | email                      |
+-------------+-----------------+----------------------------+
| 1           | John Doe        | johndoe@example.com        |
| 2           | Jane Smith      | janesmith@example.com      |
| 3           | Michael Johnson | michaeljohnson@example.com |
+-------------+-----------------+----------------------------+



MySQL root@(none):db_IN_SUBQUERY_JOIN> 
SELECT * FROM `Orders`;
+----------+-------------+------------+--------------+
| order_id | customer_id | order_date | total_amount |
+----------+-------------+------------+--------------+
| 1        | 1           | 2023-06-15 | 50.00        |
| 2        | 1           | 2023-06-30 | 100.00       |
| 3        | 2           | 2023-07-01 | 75.50        |
+----------+-------------+------------+--------------+



MySQL root@(none):db_IN_SUBQUERY_JOIN> 
SELECT * FROM `Products`;
+------------+--------------+-------+
| product_id | product_name | price |
+------------+--------------+-------+
| 1          | T-Shirt      | 20.00 |
| 2          | Jeans        | 50.00 |
| 3          | Shoes        | 80.00 |
+------------+--------------+-------+



--------------------------------------Basics-------------------------------------------------------------------------------

MySQL root@(none):db_IN_SUBQUERY_JOIN> 
	SELECT * FROM Customers 
	WHERE customer_id
	IN (1,2);
	
	+-------------+---------------+-----------------------+
	| customer_id | customer_name | email                 |
	+-------------+---------------+-----------------------+
	| 1           | John Doe      | johndoe@example.com   |
	| 2           | Jane Smith    | janesmith@example.com |
	+-------------+---------------+-----------------------+




MySQL root@(none):db_IN_SUBQUERY_JOIN> 
	SELECT *
	FROM Customers
	WHERE customer_name LIKE '%John%';
	+-------------+-----------------+----------------------------+
	| customer_id | customer_name   | email                      |
	+-------------+-----------------+----------------------------+
	| 1           | John Doe        | johndoe@example.com        |
	| 3           | Michael Johnson | michaeljohnson@example.com |
	+-------------+-----------------+----------------------------+




MySQL root@(none):db_IN_SUBQUERY_JOIN> 
	SELECT *FROM Orders
	WHERE customer_id In 
	(1,3);
	+----------+-------------+------------+--------------+
	| order_id | customer_id | order_date | total_amount |
	+----------+-------------+------------+--------------+
	| 1        | 1           | 2023-06-15 | 50.00        |
	| 2        | 1           | 2023-06-30 | 100.00       |
	+----------+-------------+------------+--------------+






MySQL root@(none):db_IN_SUBQUERY_JOIN> 
	SELECT *FROM Orders
	WHERE customer_id In 
	(SELECT customer_id FROM `Customers`
	WHERE customer_name like '%John%');
	+----------+-------------+------------+--------------+
	| order_id | customer_id | order_date | total_amount |
	+----------+-------------+------------+--------------+
	| 1        | 1           | 2023-06-15 | 50.00        |
	| 2        | 1           | 2023-06-30 | 100.00       |
	+----------+-------------+------------+--------------+




MySQL root@(none):db_IN_SUBQUERY_JOIN> 
	SELECT customer_id FROM `Customers`
	WHERE customer_name like '%John%';
	+-------------+
	| customer_id |
	+-------------+
	| 1           |
	| 3           |
	+-------------+




MySQL root@(none):db_IN_SUBQUERY_JOIN> 
	SELECT COUNT(*) AS CNT FROM `Orders`;
	+-----+
	| CNT |
	+-----+
	| 3   |
	+-----+




MySQL root@(none):db_IN_SUBQUERY_JOIN> 
	SELECT customer_name , 
	(SELECT COUNT(*) 
	FROM Orders WHERE 
	Orders.customer_id = Customers.customer_id)
	AS order_count
	FROM `Customers`; 
	+-----------------+-------------+
	| customer_name   | order_count |
	+-----------------+-------------+
	| John Doe        | 2           |
	| Jane Smith      | 1           |
	| Michael Johnson | 0           |
	+-----------------+-------------+


------------------------------------------------------------------------------------
