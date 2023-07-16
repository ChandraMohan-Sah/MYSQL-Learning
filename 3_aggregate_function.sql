MySQL root@(none):learning_groupby> SELECT *FROM employees;
+-------------+--------------+------------+---------+------------+
| employee_id | name         | department | salary  | hire_date  |
+-------------+--------------+------------+---------+------------+
| 1           | john doe     | sales      | 5000.00 | 2021-01-15 |
| 2           | jane smith   | HR         | 6000.00 | 2021-02-01 |
| 3           | Mike Johnson | Sales      | 4500.00 | 2021-03-10 |
| 4           | Emily Brown  | IT         | 7000.00 | 2021-04-05 |
| 5           | Sarah Davis  | HR         | 5500.00 | 2021-05-20 |
+-------------+--------------+------------+---------+------------+

--Basics


1) COUNT: Counts the number of rows or non-null values in a column.
   --Example: Count the total number of employees in the employees table.
-------------------------------------------------------------------------------------------------------------   
MySQL root@(none):learning_groupby> 

	SELECT COUNT(*) AS total_employess
	FROM employees;
	+-----------------+
	| total_employess |
	+-----------------+
	| 5               |
	+-----------------+
	
	
MySQL root@(none):learning_groupby> 
	SELECT department, COUNT(*) AS total_employess 
	FROM employees;
	-- throws error
	--"In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'learning_groupby.employees.department'; this is incompatible 
	-- with sql_mode=only_full_group_by"


MySQL root@(none):learning_groupby> 

	SELECT department, COUNT(*) AS total_employess 
	FROM employees --table name
	GROUP BY department;
	+------------+-----------------+
	| department | total_employess |
	+------------+-----------------+
	| sales      | 2               |
	| HR         | 2               |
	| IT         | 1               |
	+------------+-----------------+	


------------------------------------------------------------------------------------------------------------------------

2) SUM: Calculates the sum of values in a column.
--Example: Calculate the total salary expense for all employees.

MySQL root@(none):learning_groupby> 
	SELECT SUM(salary) AS total_salary_expense
	FROM employees;
	+----------------------+
	| total_salary_expense |
	+----------------------+
	| 28000.00             |
	+----------------------+



MySQL root@(none):learning_groupby> 
	SELECT SUM(salary) AS total_salary
	FROM employees
	GROUP BY department;
	+--------------+
	| total_salary |
	+--------------+
	| 9500.00      |
	| 11500.00     |
	| 7000.00      |
	+--------------+
	

MySQL root@(none):learning_groupby> 
	SELECT department, SUM(salary) AS total_salary
	FROM employees
	GROUP BY department;
	+------------+--------------+
	| department | total_salary |
	+------------+--------------+
	| sales      | 9500.00      |
	| HR         | 11500.00     |
	| IT         | 7000.00      |
	+------------+--------------+
		
	

------------------------------------------------------------------------------------------------------------------------

3) AVG: Calculates the average of values in a column.
--Example: Calculate the average salary of all employees.

MySQL root@(none):learning_groupby> 

	SELECT AVG(salary) AS average_salary
	FROM employees;
	+----------------+
	| average_salary |
	+----------------+
	| 5600.000000    |
	+----------------+



MySQL root@(none):learning_groupby>

	SELECT AVG(salary) as avg_salary
	FROM employees
	GROUP BY department;
	+-------------+
	| avg_salary  |
	+-------------+
	| 4750.000000 |
	| 5750.000000 |
	| 7000.000000 |
	+-------------+                                                                				

MySQL root@(none):learning_groupby> 

	SELECT department, AVG(salary) as avg_salary
	FROM employees
	GROUP BY department;
	+------------+-------------+
	| department | avg_salary  |
	+------------+-------------+
	| sales      | 4750.000000 |
	| HR         | 5750.000000 |
	| IT         | 7000.000000 |
	+------------+-------------+


------------------------------------------------------------------------------------------------------------------------


4) MAX: Finds the maximum value in a column.
--Example: Find the highest salary among all employees.

MySQL root@(none):learning_groupby> 
	SELECT MAX(salary) as highest_salary
	FROM employees;
	+----------------+
	| highest_salary |
	+----------------+
	| 7000.00        |
	+----------------+


------------------------------------------------------------------------------------------------------------------------



5) MIN: Finds the minimum value in a column.
--Example: Find the lowest salary among all employees.

MySQL root@(none):learning_groupby> 
	SELECT MIN(salary) as lowest_salary
	FROM employees;
	+---------------+
	| lowest_salary |
	+---------------+
	| 4500.00       |
	+---------------+


------------------------------------------------------------------------------------------------------------------------



6) Understanding GROUP BY

MySQL root@(none):learning_groupby> 
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


------------------------------------------------------------------------------------------------------------------------



7) Understanding GROUP BY , Aggregate Function

MySQL root@(none):learning_groupby> 

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


------------------------------------------------------------------------------------------------------------------------


8)Use of two aggregate function

MySQL root@(none):learning_groupby> 

	SELECT COUNT(*) AS total_employees, AVG(salary) AS average_salary
	FROM employees
	GROUP BY department;
	+-----------------+----------------+
	| total_employees | average_salary |
	+-----------------+----------------+
	| 2               | 4750.000000    |
	| 2               | 5750.000000    |
	| 1               | 7000.000000    |
	+-----------------+----------------+

MySQL root@(none):learning_groupby> 

	SELECT department, COUNT(*) AS total_employees, AVG(salary) AS average_salary
	FROM employees
	GROUP BY department;
	+------------+-----------------+----------------+
	| department | total_employees | average_salary |
	+------------+-----------------+----------------+
	| sales      | 2               | 4750.000000    |
	| HR         | 2               | 5750.000000    |
	| IT         | 1               | 7000.000000    |
	+------------+-----------------+----------------+



---------------------------------------Few Comlplex Examples -------------------------------------------------------------------

MySQL root@(none):learning_groupby> SELECT *FROM employees;
+-------------+--------------+------------+---------+------------+
| employee_id | name         | department | salary  | hire_date  |
+-------------+--------------+------------+---------+------------+
| 1           | john doe     | sales      | 5000.00 | 2021-01-15 |
| 2           | jane smith   | HR         | 6000.00 | 2021-02-01 |
| 3           | Mike Johnson | Sales      | 4500.00 | 2021-03-10 |
| 4           | Emily Brown  | IT         | 7000.00 | 2021-04-05 |
| 5           | Sarah Davis  | HR         | 5500.00 | 2021-05-20 |
+-------------+--------------+------------+---------+------------+

--Note 
--Every derived table must have its own alias.



1) Find the department(s) with the highest average salary and the corresponding number of employees in that department(s)
---------------------------------------------------------------------------------------------------------------------------------------
MySQL root@(none):learning_groupby> 

	SELECT department, AVG(salary) AS average_salary, COUNT(*) AS total_employees
	FROM employees
	GROUP BY department
	HAVING AVG(salary) = (
	    SELECT MAX(avg_salary)
	    FROM (
		SELECT AVG(salary) AS avg_salary
		FROM employees
		GROUP BY department
	    ) AS subquery
	);
	
	+------------+----------------+-----------------+
	| department | average_salary | total_employees |
	+------------+----------------+-----------------+
	| IT         | 7000.000000    | 1               |
	+------------+----------------+-----------------+

Explanation:(BreakDown OF Code )
	1. The innermost subquery calculates the average salary for each department and assigns it to the alias avg_salary.
			SELECT AVG(salary) AS avg_salary
			FROM employees
			GROUP BY department
			
			+-------------+
			| avg_salary  |
			+-------------+
			| 4750.000000 |
			| 5750.000000 |
			| 7000.000000 |
			+-------------+

			
	2. The subquery in the HAVING clause finds the maximum average salary among all departments.	
	            SELECT MAX(avg_salary)
		    FROM (
			SELECT AVG(salary) AS avg_salary
			FROM employees
			GROUP BY department
		    ) AS subquery
		    
		        +-----------------+
			| MAX(avg_salary) |
			+-----------------+
			| 7000.000000     |
			+-----------------+
		    
		
	3. The main query groups the employees by department, calculates the average salary using the AVG function, and counts the number of employees using the COUNT 
	   Func.
	        --Final Output
	  	+------------+----------------+-----------------+
		| department | average_salary | total_employees |
		+------------+----------------+-----------------+
		| IT         | 7000.000000    | 1               |
		+------------+----------------+-----------------+
	        The HAVING clause filters the groups to only include those with an average salary equal to the maximum average salary found in the subquery.
	        
	This query will return the department(s) with the highest average salary and the corresponding number of employees in that department(s).




----------------------------------------------------------------------------------------------------------------------------------------------------------
2)Find the department(s) with the highest : total salary expense and the average salary in each of those departments.

MySQL root@(none):learning_groupby> 

	SELECT department, SUM(salary) AS total_salary_expense, AVG(salary) AS average_salary
	FROM employees
	WHERE department IN (
	    SELECT department
	    FROM employees
	    GROUP BY department
	    HAVING SUM(salary) = (
		SELECT MAX(total_salary)
		FROM (
		    SELECT SUM(salary) AS total_salary
		    FROM employees
		    GROUP BY department
		) AS subquery
	    )
	)
	GROUP BY department;
	+------------+----------------------+----------------+
	| department | total_salary_expense | average_salary |
	+------------+----------------------+----------------+
	| HR         | 11500.00             | 5750.000000    |
	+------------+----------------------+----------------+

Explanation (Code BreakDown):

	1. The GROUP BY clause groups the result by department to get the total salary expense and average salary for each department.
			        SELECT SUM(salary) AS total_salary
		    		FROM employees
		    		GROUP BY department
				+--------------+
				| total_salary |
				+--------------+
				| 9500.00      |
				| 11500.00     |
				| 7000.00      |
				+--------------+
				
	2. The subquery in the HAVING clause finds the maximum total salary among all departments.	
			        SELECT MAX(total_salary)
				FROM (
				    SELECT SUM(salary) AS total_salary
				    FROM employees
				    GROUP BY department
				) AS subquery
			    
				+-------------------+
				| MAX(total_salary) |
				+-------------------+
				| 11500.00          |
				+-------------------+
	
	3. The subquery in the WHERE clause selects the department(s) with the highest total salary expense by calculating the sum of salaries for each department and 
	   finding the maximum value.	
	   				    SELECT department
					    FROM employees
					    GROUP BY department
					    HAVING SUM(salary) = (
						SELECT MAX(total_salary)
						FROM (
						    SELECT SUM(salary) AS total_salary
						    FROM employees
						    GROUP BY department
						) AS subquery
					    )
	   			
		   			    +------------+
					    | department |
					    +------------+
					    | HR         |
					    +------------+

	
	4. The main query selects the departments from the subquery result and calculates the total salary expense using the SUM function and the average salary using the 
	   AVG func.
	   --Final Output  : For HR department Only Calculate total_salary  and average_salary
	        +------------+----------------------+----------------+
		| department | total_salary_expense | average_salary |
		+------------+----------------------+----------------+
		| HR         | 11500.00             | 5750.000000    |
		+------------+----------------------+----------------+
	   
	
	This query will return the department(s) with the highest total salary expense and display the average salary in each of those departments.



---------------------------------------------------------------------------------------------------------------------------------------------------------------

MySQL root@(none):learning_groupby> 

		SELECT e.department, e.name AS employee_name, e.salary
		FROM employees e
		WHERE (e.department, e.salary) IN (
		    SELECT department, MAX(salary)
		    FROM employees
		    GROUP BY department
		)
		ORDER BY e.department;

		+------------+---------------+---------+
		| department | employee_name | salary  |
		+------------+---------------+---------+
		| HR         | jane smith    | 6000.00 |
		| IT         | Emily Brown   | 7000.00 |
		| sales      | john doe      | 5000.00 |
		+------------+---------------+---------+
		
		
		
	----------------------------BreakDown OF Above Code-----------------------------------------------
	1) Inside WHERE Clause
	
		 SELECT department, MAX(salary)
                 FROM employees
                 GROUP BY department;
		+------------+-------------+
		| department | MAX(salary) |
		+------------+-------------+
		| sales      | 5000.00     |
		| HR         | 6000.00     |
		| IT         | 7000.00     |
		+------------+-------------+
		
		
	2) Main Query	 
	
		SELECT e.department, e.name AS employee_name, e.salary
		FROM employees e
		WHERE (e.department, e.salary) IN (
			SELECT department, MAX(salary)
			FROM employees
			GROUP BY department
		);
		+------------+---------------+---------+
		| department | employee_name | salary  |
		+------------+---------------+---------+
		| sales      | john doe      | 5000.00 |
		| HR         | jane smith    | 6000.00 |
		| IT         | Emily Brown   | 7000.00 |
		+------------+---------------+---------+
		
		--EXPLANATION:
		The WHERE clause is used to filter the result based on condition.
		The condition (e.department, e.salary) IN (...) checks if the pair of (department, salary) for each employee is present in the subquery result.
		
		The subquery retrieves the maximum salary for each department using the MAX(salary) aggregation function, grouped by department using the GROUP BY clause.
		
		The result of the subquery is a list of department-salary pairs representing the maximum salary for each department.
		
		The outer query filters the employees based on the condition in the WHERE clause, matching their department and salary with the pairs obtained from the 
		subquery.
		
		Finally, the result is a list of employees who have the highest salary in their respective departments, including their department, employee name, and 
		salary.
		
	---------------------------------------------------------------------------------------------------------	

			
	
	
