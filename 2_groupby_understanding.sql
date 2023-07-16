--UNDERSTANDING GROUP BY IN DETAIL
--The GROUP BY clause is used in SQL to group rows based on one or more columns or expressions. 
--It is typically used in conjunction with aggregate functions to perform calculations and summarizations on each group. 
--Here is the syntax of the GROUP BY clause:

SELECT column1, column2, ..., aggregate_function(column), ...
FROM table
GROUP BY column1, column2, ...
----------------------------------------------------------------------------------------------------------------

--We have following table 'employees'
MySQL root@(none):learning_groupby> select *FROM employees;
+-------------+--------------+------------+---------+------------+
| employee_id | name         | department | salary  | hire_date  |
+-------------+--------------+------------+---------+------------+
| 1           | john doe     | sales      | 5000.00 | 2021-01-15 |
| 2           | jane smith   | HR         | 6000.00 | 2021-02-01 |
| 3           | Mike Johnson | Sales      | 4500.00 | 2021-03-10 |
| 4           | Emily Brown  | IT         | 7000.00 | 2021-04-05 |
| 5           | Sarah Davis  | HR         | 5500.00 | 2021-05-20 |
+-------------+--------------+------------+---------+------------+



------------------Basics---------------------------------------------------------------------------------------
'
1)Grouping By department

SELECT department
FROM employees
GROUP BY department;
+------------+
| department |
+------------+
| sales      |
| HR         |
| IT         |
+------------+


2)Grouping By department, salary

SELECT department, salary
FROM employees
GROUP BY department, salary;
+------------+---------+
| department | salary  |
+------------+---------+
| sales      | 5000.00 |
| HR         | 6000.00 |
| Sales      | 4500.00 |
| IT         | 7000.00 |
| HR         | 5500.00 |
+------------+---------+


3)Grouping BY department, salary, hire_date

SELECT department, salary, hire_date
FROM employees
GROUP BY department, salary, hire_date;
+------------+---------+------------+
| department | salary  | hire_date  |
+------------+---------+------------+
| sales      | 5000.00 | 2021-01-15 |
| HR         | 6000.00 | 2021-02-01 |
| Sales      | 4500.00 | 2021-03-10 |
| IT         | 7000.00 | 2021-04-05 |
| HR         | 5500.00 | 2021-05-20 |
+------------+---------+------------+


4) Know the difference between example 3 and 4

SELECT department
FROM employees
GROUP BY department, salary, hire_date;
+------------+
| department |
+------------+
| sales      |
| HR         |
| Sales      |
| IT         |
| HR         |
+------------+

5) Using Aggregate Function and Group BY together

SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department;

+------------+----------------+
| department | average_salary |
+------------+----------------+
| sales      | 4750.000000    |
| HR         | 5750.000000    |
| IT         | 7000.000000    |
+------------+----------------+

'
-----------------------------------------------------------------------------------------------------------------



--Questions

MySQL root@(none):learning_groupby> select *FROM employees;
+-------------+--------------+------------+---------+------------+
| employee_id | name         | department | salary  | hire_date  |
+-------------+--------------+------------+---------+------------+
| 1           | john doe     | sales      | 5000.00 | 2021-01-15 |
| 2           | jane smith   | HR         | 6000.00 | 2021-02-01 |
| 3           | Mike Johnson | Sales      | 4500.00 | 2021-03-10 |
| 4           | Emily Brown  | IT         | 7000.00 | 2021-04-05 |
| 5           | Sarah Davis  | HR         | 5500.00 | 2021-05-20 |
+-------------+--------------+------------+---------+------------+



1) Grouping the employees by their departments and calculates the average salary for each department.
-----------------------------------------------------------------------------------------------------------------
MySQL root@(none):learning_groupby> 

SELECT department , AVG(salary) AS avg_salary
FROM employees GROUP BY department;
+------------+-------------+
| department | avg_salary  |
+------------+-------------+
| sales      | 4750.000000 |
| HR         | 5750.000000 |
| IT         | 7000.000000 |
+------------+-------------+



2) Grouping by Department and Counting Employees:
-----------------------------------------------------------------------------------------------------------------
MySQL root@(none):learning_groupby> 

SELECT department , COUNT(*) AS total_employees
FROM employees
GROUP BY department;
+------------+-----------------+
| department | total_employees |
+------------+-----------------+
| sales      | 2               |
| HR         | 2               |
| IT         | 1               |
+------------+-----------------+



3) Grouping by Department and Calculating Maximum Salary:
-----------------------------------------------------------------------------------------------------------------
MySQL root@(none):learning_groupby> 

SELECT department, MAX(salary) AS max_salary 
FROM employees GROUP BY department;
+------------+------------+
| department | max_salary |
+------------+------------+
| sales      | 5000.00    |
| HR         | 6000.00    |
| IT         | 7000.00    |
+------------+------------+



4) Grouping by Department and Finding the Most Recent Hire Date:
-----------------------------------------------------------------------------------------------------------------
MySQL root@(none):learning_groupby> 

SELECT department, MAX(hire_date) AS most_recent_hire_date
FROM employees
GROUP BY department;
+------------+-----------------------+
| department | most_recent_hire_date |
+------------+-----------------------+
| sales      | 2021-03-10            |
| HR         | 2021-05-20            |
| IT         | 2021-04-05            |
+------------+-----------------------+


5) Grouping by Department and Calculating Total Salary Expense:
-----------------------------------------------------------------------------------------------------------------

MySQL root@(none):learning_groupby> 
SELECT department, SUM(salary) as total_salary_expense
FROM employees
GROUP BY department;
+------------+----------------------+
| department | total_salary_expense |
+------------+----------------------+
| sales      | 9500.00              |
| HR         | 11500.00             |
| IT         | 7000.00              |
+------------+----------------------+



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



6) Grouping by Year of Hire:
-----------------------------------------------------------------------------------------------------------------
MySQL root@(none):learning_groupby> 

SELECT YEAR(hire_date) AS hire_year, COUNT(*) as total_employees
FROM employees
GROUP BY hire_year;
+-----------+-----------------+
| hire_year | total_employees |
+-----------+-----------------+
| 2021      | 5               |
+-----------+-----------------+



7) Grouping by Month of Hire:
-----------------------------------------------------------------------------------------------------------------
MySQL root@(none):learning_groupby> 

SELECT MONTH(hire_date) AS hire_month, COUNT(*) AS total_employees
FROM employees
GROUP BY hire_month;
+------------+-----------------+
| hire_month | total_employees |
+------------+-----------------+
| 1          | 1               |
| 2          | 1               |
| 3          | 1               |
| 4          | 1               |
| 5          | 1               |
+------------+-----------------+


8) Grouping by First Letter of Name:
-----------------------------------------------------------------------------------------------------------------
MySQL root@(none):learning_groupby> 

SELECT LEFT(name, 1) AS first_letter, COUNT(*) AS total_employees
FROM employees
GROUP BY first_letter;
+--------------+-----------------+
| first_letter | total_employees |
+--------------+-----------------+
| j            | 2               |
| M            | 1               |
| E            | 1               |
| S            | 1               |
+--------------+-----------------+
