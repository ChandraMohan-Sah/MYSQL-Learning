-------------------------------------------Provided Table-----------------------------------------------------------------


MySQL root@(none):learning_groupby> SELECT * FROM employees;
+-------------+--------------+------------+---------+------------+
| employee_id | name         | department | salary  | hire_date  |
+-------------+--------------+------------+---------+------------+
| 1           | john doe     | sales      | 5000.00 | 2021-01-15 |
| 2           | jane smith   | HR         | 6000.00 | 2021-02-01 |
| 3           | Mike Johnson | Sales      | 4500.00 | 2021-03-10 |
| 4           | Emily Brown  | IT         | 7000.00 | 2021-04-05 |
| 5           | Sarah Davis  | HR         | 5500.00 | 2021-05-20 |
+-------------+--------------+------------+---------+------------+




-------------------------------------------THINK WHAT MAY BE THE QUESTION------------------------------------------------------
Select employees with a salary greater than 5500.00:

MySQL root@(none):learning_groupby> 
	SELECT *FROM employees WHERE 
	salary > 5500.00;
	+-------------+-------------+------------+---------+------------+
	| employee_id | name        | department | salary  | hire_date  |
	+-------------+-------------+------------+---------+------------+
	| 2           | jane smith  | HR         | 6000.00 | 2021-02-01 |
	| 4           | Emily Brown | IT         | 7000.00 | 2021-04-05 |
	+-------------+-------------+------------+---------+------------+



--------------------------------------------------------------------------------------------------------------------------

--Understanding Group BY

MySQL root@(none):learning_groupby> 
	SELECT *FROM employees WHERE 
	salary > 5500.00
	GROUP BY department;
	--throws error ..See Next example

MySQL root@(none):learning_groupby> 
	SELECT department FROM  employees WHERE 
	salary > 5500.00
	GROUP BY department;
	+------------+
	| department |
	+------------+
	| HR         |
	| IT         |
	+------------+

--------------------------------------------------------------------------------------------------------------------------



MySQL root@(none):learning_groupby> 
	SELECT department, salary  FROM  employees WHERE 
	salary > 5500.00
	GROUP BY department, salary;
	+------------+---------+
	| department | salary  |
	+------------+---------+
	| HR         | 6000.00 |
	| IT         | 7000.00 |
	+------------+---------+


--------------------------------------------------------------------------------------------------------------------------

Select employees in the HR department:

MySQL root@(none):learning_groupby> 
	SELECT * FROM employees WHERE department = 'HR';
	+-------------+-------------+------------+---------+------------+
	| employee_id | name        | department | salary  | hire_date  |
	+-------------+-------------+------------+---------+------------+
	| 2           | jane smith  | HR         | 6000.00 | 2021-02-01 |
	| 5           | Sarah Davis | HR         | 5500.00 | 2021-05-20 |
	+-------------+-------------+------------+---------+------------+


--------------------------------------------------------------------------------------------------------------------------
Select employees hired after February 1, 2021:

MySQL root@(none):learning_groupby> 
	SELECT *FROM employees WHERE  
	hire_date > '2021-02-01';
	+-------------+--------------+------------+---------+------------+
	| employee_id | name         | department | salary  | hire_date  |
	+-------------+--------------+------------+---------+------------+
	| 3           | Mike Johnson | Sales      | 4500.00 | 2021-03-10 |
	| 4           | Emily Brown  | IT         | 7000.00 | 2021-04-05 |
	| 5           | Sarah Davis  | HR         | 5500.00 | 2021-05-20 |
	+-------------+--------------+------------+---------+------------+

--------------------------------------------------------------------------------------------------------------------------

Select employees with a salary between 4000.00 and 6000.00:

MySQL root@(none):learning_groupby> 
	SELECT * FROM employees WHERE salary 
	BETWEEN 4000 AND 6000;
	+-------------+--------------+------------+---------+------------+
	| employee_id | name         | department | salary  | hire_date  |
	+-------------+--------------+------------+---------+------------+
	| 1           | john doe     | sales      | 5000.00 | 2021-01-15 |
	| 2           | jane smith   | HR         | 6000.00 | 2021-02-01 |
	| 3           | Mike Johnson | Sales      | 4500.00 | 2021-03-10 |
	| 5           | Sarah Davis  | HR         | 5500.00 | 2021-05-20 |
	+-------------+--------------+------------+---------+------------+

--------------------------------------------------------------------------------------------------------------------------

Select employees with a name containing the word "john":

MySQL root@(none):learning_groupby> 
	SELECT * FROM employees WHERE name LIKE '%john%';
	+-------------+--------------+------------+---------+------------+
	| employee_id | name         | department | salary  | hire_date  |
	+-------------+--------------+------------+---------+------------+
	| 1           | john doe     | sales      | 5000.00 | 2021-01-15 |
	| 3           | Mike Johnson | Sales      | 4500.00 | 2021-03-10 |
	+-------------+--------------+------------+---------+------------+

--------------------------------------------------------------------------------------------------------------------------

This query will return the employees whose salary is higher than the average salary in their respective departments.


MySQL root@(none):learning_groupby> 
	SELECT *
	FROM employees
	WHERE salary > (
	SELECT AVG(salary) 
	FROM employees AS subquery
	WHERE subquery.department = employees.department);
	+-------------+------------+------------+---------+------------+
	| employee_id | name       | department | salary  | hire_date  |
	+-------------+------------+------------+---------+------------+
	| 1           | john doe   | sales      | 5000.00 | 2021-01-15 |
	| 2           | jane smith | HR         | 6000.00 | 2021-02-01 |
	+-------------+------------+------------+---------+------------+

--------------------------------------------------------------------------------------------------------------------------

This query retrieves all employees whose salary is higher than the average salary of all employees in the employees table.



MySQL root@(none):learning_groupby> 
	SELECT *
	FROM employees
	WHERE salary > (
	    SELECT AVG(salary)
	    FROM employees
	);
	+-------------+-------------+------------+---------+------------+
	| employee_id | name        | department | salary  | hire_date  |
	+-------------+-------------+------------+---------+------------+
	| 2           | jane smith  | HR         | 6000.00 | 2021-02-01 |
	| 4           | Emily Brown | IT         | 7000.00 | 2021-04-05 |
	+-------------+-------------+------------+---------+------------+
	
	
--------------------------------------------------------------------------------------------------------------------------

This query retrieves all employees whose hire date is later than the earliest hire date in the HR department.



MySQL root@(none):learning_groupby> 
	SELECT *
	FROM employees
	WHERE hire_date > (
	    SELECT MIN(hire_date)
	    FROM employees
	    WHERE department = 'HR'
	);
	+-------------+--------------+------------+---------+------------+
	| employee_id | name         | department | salary  | hire_date  |
	+-------------+--------------+------------+---------+------------+
	| 3           | Mike Johnson | Sales      | 4500.00 | 2021-03-10 |
	| 4           | Emily Brown  | IT         | 7000.00 | 2021-04-05 |
	| 5           | Sarah Davis  | HR         | 5500.00 | 2021-05-20 |
	+-------------+--------------+------------+---------+------------+


--------------------------------------------------------------------------------------------------------------------------
