USE university DATABASE;

-------------------------------------------------------------------------------------------------------------------------
MySQL root@(none):learning_groupby> -- Create University Database
CREATE DATABASE University;
USE University;

-- Create departments table
CREATE TABLE departments (
  id INT PRIMARY KEY,
  department_name VARCHAR(100),
  location VARCHAR(100)
);


-- Create students table
CREATE TABLE students (
  id INT PRIMARY KEY,
  student_name VARCHAR(100),
  department_id INT,
  FOREIGN KEY (department_id) REFERENCES departments(id)
);


-- Create courses table
CREATE TABLE courses (
  id INT PRIMARY KEY,
  course_name VARCHAR(100),
  department_id INT,
  FOREIGN KEY (department_id) REFERENCES departments(id)
);


-- Create enrollments table
CREATE TABLE enrollments (
  id INT PRIMARY KEY,
  student_id INT,
  course_id INT,
  FOREIGN KEY (student_id) REFERENCES students(id),
  FOREIGN KEY (course_id) REFERENCES courses(id)
);


---------------------------------------------------------------------------------------------------------------


MySQL root@(none):University> 
-- Insert data into departments table
INSERT INTO departments (id, department_name, location)
VALUES
  (1, 'Computer Science', 'Building A'),
  (2, 'Mathematics', 'Building B'),
  (3, 'Physics', 'Building C');


-- Insert data into students table
INSERT INTO students (id, student_name, department_id)
VALUES
  (1, 'John Smith', 1),
  (2, 'Emma Johnson', 2),
  (3, 'Michael Davis', 1),
  (4, 'Sophia Lee', 3),
  (5, 'Daniel Brown', 2);


-- Insert data into courses table
INSERT INTO courses (id, course_name, department_id)
VALUES
  (1, 'Introduction to Programming', 1),
  (2, 'Calculus I', 2),
  (3, 'Quantum Mechanics', 3),
  (4, 'Data Structures', 1),
  (5, 'Linear Algebra', 2);


-- Insert data into enrollments table
INSERT INTO enrollments (id, student_id, course_id)
VALUES
  (1, 1, 1),
  (2, 1, 4),
  (3, 2, 2),
  (4, 3, 1),
  (5, 4, 3),
  (6, 5, 2);
  
  
---------------------------------------DATABASE PROVIDED--------------------------------------------------------------  

MySQL root@(none):University> SELECT *FROM courses;
+----+-----------------------------+---------------+
| id | course_name                 | department_id |
+----+-----------------------------+---------------+
| 1  | Introduction to Programming | 1             |
| 2  | Calculus I                  | 2             |
| 3  | Quantum Mechanics           | 3             |
| 4  | Data Structures             | 1             |
| 5  | Linear Algebra              | 2             |
+----+-----------------------------+---------------+


MySQL root@(none):University> SELECT *FROM departments;
+----+------------------+------------+
| id | department_name  | location   |
+----+------------------+------------+
| 1  | Computer Science | Building A |
| 2  | Mathematics      | Building B |
| 3  | Physics          | Building C |
+----+------------------+------------+


MySQL root@(none):University> SELECT *FROM enrollments;
+----+------------+-----------+
| id | student_id | course_id |
+----+------------+-----------+
| 1  | 1          | 1         |
| 2  | 1          | 4         |
| 3  | 2          | 2         |
| 4  | 3          | 1         |
| 5  | 4          | 3         |
| 6  | 5          | 2         |
+----+------------+-----------+


MySQL root@(none):University> SELECT *FROM students;
+----+---------------+---------------+
| id | student_name  | department_id |
+----+---------------+---------------+
| 1  | John Smith    | 1             |
| 2  | Emma Johnson  | 2             |
| 3  | Michael Davis | 1             |
| 4  | Sophia Lee    | 3             |
| 5  | Daniel Brown  | 2             |
+----+---------------+---------------+



------------------------------------BASICS OF WHERE CLAUSE-----------------------------------------------------------------------------
--Basic Comparison Operators:
You can use comparison operators such as
 "=" (equal to), "<>" (not equal to), "<" (less than), ">" (greater than), "<=" (less than or equal to), ">=" (greater than or equal to) to compare values.

For example:

1) Retrieve students with the name "John Smith":
MySQL root@(none):University> 
	SELECT * FROM students WHERE student_name = 'John Smith';
	+----+--------------+---------------+
	| id | student_name | department_id |
	+----+--------------+---------------+
	| 1  | John Smith   | 1             |
	+----+--------------+---------------+



2) Retrieve courses with an id greater than 2:

MySQL root@(none):University> 
	SELECT * FROM courses WHERE id > 2;
	+----+-------------------+---------------+
	| id | course_name       | department_id |
	+----+-------------------+---------------+
	| 3  | Quantum Mechanics | 3             |
	| 4  | Data Structures   | 1             |
	| 5  | Linear Algebra    | 2             |
	+----+-------------------+---------------+



-------------------------------------------------------------------------------------------------------------------------

--Logical Operators:
You can use logical operators such as "AND", "OR", and "NOT" to combine multiple conditions. For example:

1) Retrieve students enrolled in the 'Computer Science' department:

MySQL root@(none):University> 
	SELECT * FROM students 
	WHERE department_id = 1 AND student_name LIKE '%Smith';
	+----+--------------+---------------+
	| id | student_name | department_id |
	+----+--------------+---------------+
	| 1  | John Smith   | 1             |
	+----+--------------+---------------+


2) Retrieve courses in the 'Mathematics' department or 'Physics' department:

MySQL root@(none):University> 
	SELECT * FROM courses WHERE department_id = 2 OR department_id = 3;
	+----+-------------------+---------------+
	| id | course_name       | department_id |
	+----+-------------------+---------------+
	| 2  | Calculus I        | 2             |
	| 5  | Linear Algebra    | 2             |
	| 3  | Quantum Mechanics | 3             |
	+----+-------------------+---------------+


-------------------------------------------------------------------------------------------------------------------------

--Pattern Matching:
You can use pattern matching operators like "LIKE" and "NOT LIKE" along with wildcard characters ("%") to match patterns within strings. 
For example:

1) Retrieve students whose names start with "M":

MySQL root@(none):University> 
	SELECT *FROM students WHERE student_name LIKE 'M%';
	+----+---------------+---------------+
	| id | student_name  | department_id |
	+----+---------------+---------------+
	| 3  | Michael Davis | 1             |
	+----+---------------+---------------+


2) Retrieve courses with names containing the word "Programming":

MySQL root@(none):University> 
	SELECT * FROM courses WHERE course_name LIKE '%Programming%';
	+----+-----------------------------+---------------+
	| id | course_name                 | department_id |
	+----+-----------------------------+---------------+
	| 1  | Introduction to Programming | 1             |
	+----+-----------------------------+---------------+


-------------------------------------------------------------------------------------------------------------------------

--NULL Values:
You can use the "IS NULL" or "IS NOT NULL" operators to filter rows based on the presence or absence of NULL values. 
For example:

1) Retrieve students without a department assigned:

MySQL root@(none):University> 
	SELECT * FROM students WHERE department_id IS NULL;

	+----+--------------+---------------+
	| id | student_name | department_id |
	+----+--------------+---------------+
	+----+--------------+---------------+



2) Retrieve courses with a department assigned:

MySQL root@(none):University> 
	SELECT * FROM courses WHERE department_id IS NOT NULL;

	+----+-----------------------------+---------------+
	| id | course_name                 | department_id |
	+----+-----------------------------+---------------+
	| 1  | Introduction to Programming | 1             |
	| 4  | Data Structures             | 1             |
	| 2  | Calculus I                  | 2             |
	| 5  | Linear Algebra              | 2             |
	| 3  | Quantum Mechanics           | 3             |
	+----+-----------------------------+---------------+


-------------------------------------------------------------------------Complex Questions ----------------------------------------------------
 
---------------------------------------DATABASE PROVIDED--------------------------------------------------------------  

MySQL root@(none):University> SELECT *FROM courses;
+----+-----------------------------+---------------+
| id | course_name                 | department_id |
+----+-----------------------------+---------------+
| 1  | Introduction to Programming | 1             |
| 2  | Calculus I                  | 2             |
| 3  | Quantum Mechanics           | 3             |
| 4  | Data Structures             | 1             |
| 5  | Linear Algebra              | 2             |
+----+-----------------------------+---------------+


MySQL root@(none):University> SELECT *FROM departments;
+----+------------------+------------+
| id | department_name  | location   |
+----+------------------+------------+
| 1  | Computer Science | Building A |
| 2  | Mathematics      | Building B |
| 3  | Physics          | Building C |
+----+------------------+------------+


MySQL root@(none):University> SELECT *FROM enrollments;
+----+------------+-----------+
| id | student_id | course_id |
+----+------------+-----------+
| 1  | 1          | 1         |
| 2  | 1          | 4         |
| 3  | 2          | 2         |
| 4  | 3          | 1         |
| 5  | 4          | 3         |
| 6  | 5          | 2         |
+----+------------+-----------+


MySQL root@(none):University> SELECT *FROM students;
+----+---------------+---------------+
| id | student_name  | department_id |
+----+---------------+---------------+
| 1  | John Smith    | 1             |
| 2  | Emma Johnson  | 2             |
| 3  | Michael Davis | 1             |
| 4  | Sophia Lee    | 3             |
| 5  | Daniel Brown  | 2             |
+----+---------------+---------------+


--------------------------------------------------------------------------------------------------------------------------------------

1) Using IN with a subquery:
Retrieve students enrolled in courses offered by the 'Computer Science' department:

MySQL root@(none):University> 
	SELECT * FROM students
	WHERE department_id IN (
	SELECT id FROM departments
	WHERE department_name = 'Computer Science');
	+----+---------------+---------------+
	| id | student_name  | department_id |
	+----+---------------+---------------+
	| 1  | John Smith    | 1             |
	| 3  | Michael Davis | 1             |
	+----+---------------+---------------+



-------------------------------------------------------------------------------------------------------------------------

2)Using a subquery with EXISTS:
Retrieve students who are enrolled in at least one course:

MySQL root@(none):University> 
	SELECT * FROM students 
	WHERE EXISTS (
	SELECT * FROM enrollments 
	WHERE enrollments.student_id = students.id);
	+----+---------------+---------------+
	| id | student_name  | department_id |
	+----+---------------+---------------+
	| 1  | John Smith    | 1             |
	| 2  | Emma Johnson  | 2             |
	| 3  | Michael Davis | 1             |
	| 4  | Sophia Lee    | 3             |
	| 5  | Daniel Brown  | 2             |
	+----+---------------+---------------+


-------------------------------------------------------------------------------------------------------------------------

3)Using a subquery with comparison operators:
Retrieve courses with more than 3 enrollments:

MySQL root@(none):University> 
	SELECT * FROM courses 
	WHERE id IN (
	SELECT course_id FROM enrollments 
	GROUP BY course_id HAVING COUNT(*) > 3);
	+----+-------------+---------------+
	| id | course_name | department_id |
	+----+-------------+---------------+
	+----+-------------+---------------+


-------------------------------------------------------------------------------------------------------------------------

4)Using a subquery with the MAX function:
Retrieve students who have the highest student_id:

MySQL root@(none):University> 
	SELECT * FROM students 
	WHERE id = (SELECT MAX(id) FROM students);
	+----+--------------+---------------+
	| id | student_name | department_id |
	+----+--------------+---------------+
	| 5  | Daniel Brown | 2             |
	+----+--------------+---------------+



-------------------------------------------------------------------------------------------------------------------------


5) Retrieve departments located in the same building as the 'Physics' department:

MySQL root@(none):University> 
	SELECT * FROM departments 
	WHERE location = (
	SELECT location FROM departments 
	WHERE department_name = 'Physics');
	+----+-----------------+------------+
	| id | department_name | location   |
	+----+-----------------+------------+
	| 3  | Physics         | Building C |
	+----+-----------------+------------+



-------------------------------------------------------------------------------------------------------------------------

6) Using a subquery with multiple conditions:
Retrieve students enrolled in courses offered by the 'Computer Science' department and 'Mathematics' department:

MySQL root@(none):University> 
	SELECT * FROM students 
	WHERE department_id IN (
	SELECT id FROM departments 
	WHERE department_name IN ('Computer Science', 'Mathematics'));
	+----+---------------+---------------+
	| id | student_name  | department_id |
	+----+---------------+---------------+
	| 1  | John Smith    | 1             |
	| 3  | Michael Davis | 1             |
	| 2  | Emma Johnson  | 2             |
	| 5  | Daniel Brown  | 2             |
	+----+---------------+---------------+


-------------------------------------------------------------------------------------------------------------------------

7) Using a subquery with the ANY operator:
Retrieve students with a student_id greater than any student_id in the 'Computer Science' department:

MySQL root@(none):University> 
	SELECT * FROM students 
	WHERE student_id > ANY (
	SELECT student_id FROM students WHERE department_id = 1);
	MySQL root@(none):University> SELECT * FROM students 
	WHERE id > ANY (
	SELECT id FROM students WHERE department_id = 1);
	+----+---------------+---------------+
	| id | student_name  | department_id |
	+----+---------------+---------------+
	| 2  | Emma Johnson  | 2             |
	| 3  | Michael Davis | 1             |
	| 4  | Sophia Lee    | 3             |
	| 5  | Daniel Brown  | 2             |
	+----+---------------+---------------+


-------------------------------------------------------------------------------------------------------------------------


8)Using a subquery with the ALL operator:
Retrieve courses that have enrollments from all departments:

MySQL root@(none):University>
	SELECT * FROM courses 
	WHERE id IN (
	SELECT course_id FROM enrollments 
	GROUP BY course_id 
	HAVING COUNT(DISTINCT department_id) = (SELECT COUNT(*) FROM departments));
	+----+-------------+---------------+
	| id | course_name | department_id |
	+----+-------------+---------------+
	+----+-------------+---------------+



-------------------------------------------------------------------------------------------------------------------------

9)Using a subquery in the SELECT clause:
Retrieve the names of students who are enrolled in more than one course:

MySQL root@(none):University> 
	SELECT student_name, (
	SELECT COUNT(*) FROM enrollments 
	WHERE enrollments.student_id = students.id) AS course_count 
	FROM students 
	HAVING course_count > 1;

	+--------------+--------------+
	| student_name | course_count |
	+--------------+--------------+
	| John Smith   | 2            |
	+--------------+--------------+


-------------------------------------------------------------------------------------------------------------------------

10)Using a subquery in the FROM clause:
Retrieve the average number of enrollments per student:

MySQL root@(none):University> 
	SELECT AVG(enrollment_count) 
	FROM (SELECT COUNT(*) AS enrollment_count 
	FROM enrollments 
	GROUP BY student_id) 
	AS subquery;

	+-----------------------+
	| AVG(enrollment_count) |
	+-----------------------+
	| 1.2000                |
	+-----------------------+



-------------------------------------------------------------------------------------------------------------------------
11)Using a WITH clause:
Retrieve students and their departments using a common table expression (CTE):

MySQL root@(none):University> 
	WITH student_department AS (
	  SELECT students.student_name, departments.department_name
	  FROM students
	  JOIN departments ON students.department_id = departments.id
	)
	SELECT * FROM student_department;

	+---------------+------------------+
	| student_name  | department_name  |
	+---------------+------------------+
	| John Smith    | Computer Science |
	| Michael Davis | Computer Science |
	| Emma Johnson  | Mathematics      |
	| Daniel Brown  | Mathematics      |
	| Sophia Lee    | Physics          |
	+---------------+------------------+


-----------------------------------More Questions -------------------------------------------------------------------------------------

1)Query with a JOIN and aggregate function:
Retrieve the department names along with the total number of enrolled students in each department:


MySQL root@(none):University> 
	SELECT d.department_name, COUNT(s.id) AS total_students
	FROM departments d
	LEFT JOIN students s ON d.id = s.department_id
	GROUP BY d.department_name;
	+------------------+----------------+
	| department_name  | total_students |
	+------------------+----------------+
	| Computer Science | 2              |
	| Mathematics      | 2              |
	| Physics          | 1              |
	+------------------+----------------+


-------------------------------------------------------------------------------------------------------------------------
2)Query with a subquery and NOT IN:
Retrieve the course names that have no enrollments:


MySQL root@(none):University> 
	SELECT course_name
	FROM courses
	WHERE id NOT IN (SELECT course_id FROM enrollments);
	+----------------+
	| course_name    |
	+----------------+
	| Linear Algebra |
	+----------------+


-------------------------------------------------------------------------------------------------------------------------

3)Query with a subquery and ORDER BY:
Retrieve the student name and the course with the highest number of enrollments for each student:


MySQL root@(none):University> 
	SELECT student_name, (
	  SELECT course_name
	  FROM courses
	  WHERE id = (
	    SELECT course_id
	    FROM enrollments
	    WHERE student_id = s.id
	    GROUP BY course_id
	    ORDER BY COUNT(*) DESC
	    LIMIT 1
	  )
	) AS most_enrolled_course
	FROM students s;
	+---------------+-----------------------------+
	| student_name  | most_enrolled_course        |
	+---------------+-----------------------------+
	| John Smith    | Introduction to Programming |
	| Emma Johnson  | Calculus I                  |
	| Michael Davis | Introduction to Programming |
	| Sophia Lee    | Quantum Mechanics           |
	| Daniel Brown  | Calculus I                  |
	+---------------+-----------------------------+


-------------------------------------------------------------------------------------------------------------------------

4)Query with a subquery and EXISTS:
Retrieve departments that have at least one student enrolled in all courses offered by the department:

MySQL root@(none):University> 
	SELECT *
	FROM departments d
	WHERE EXISTS (
	  SELECT *
	  FROM courses c
	  WHERE c.department_id = d.id
	  AND NOT EXISTS (
	    SELECT *
	    FROM students s
	    LEFT JOIN enrollments e ON s.id = e.student_id
	    WHERE s.department_id = d.id
	    AND e.course_id = c.id
	  )
	);
	+----+-----------------+------------+
	| id | department_name | location   |
	+----+-----------------+------------+
	| 2  | Mathematics     | Building B |
	+----+-----------------+------------+


-------------------------------------------------------------------------------------------------------------------------
5)Query with a subquery and multiple conditions:
Retrieve students who are enrolled in courses offered by the 'Computer Science' department and have more than one enrollment:


MySQL root@(none):University> 
	SELECT *
	FROM students
	WHERE department_id = (
	  SELECT id
	  FROM departments
	  WHERE department_name = 'Computer Science'
	)
	AND id IN (
	  SELECT student_id
	  FROM enrollments
	  GROUP BY student_id
	  HAVING COUNT(*) > 1
	);
	+----+--------------+---------------+
	| id | student_name | department_id |
	+----+--------------+---------------+
	| 1  | John Smith   | 1             |
	+----+--------------+---------------+



-------------------------------------------------------------------------------------------------------------------------
6)Query with a subquery and JOIN:
Retrieve the course names and the names of students enrolled in each course:

MySQL root@(none):University> 
	SELECT c.course_name, s.student_name
	FROM courses c
	JOIN enrollments e ON c.id = e.course_id
	JOIN students s ON e.student_id = s.id;
	+-----------------------------+---------------+
	| course_name                 | student_name  |
	+-----------------------------+---------------+
	| Introduction to Programming | John Smith    |
	| Introduction to Programming | Michael Davis |
	| Calculus I                  | Emma Johnson  |
	| Calculus I                  | Daniel Brown  |
	| Quantum Mechanics           | Sophia Lee    |
	| Data Structures             | John Smith    |
	+-----------------------------+---------------+



-------------------------------------------------------------------------------------------------------------------------
7)Query with a subquery and LIMIT:
Retrieve the top 5 departments with the highest number of enrolled students:

MySQL root@(none):University> 
	SELECT department_name, total_students
	FROM (
	  SELECT d.department_name, COUNT(s.id) AS total_students
	  FROM departments d
	  LEFT JOIN students s ON d.id = s.department_id
	  GROUP BY d.department_name
	  ORDER BY total_students DESC
	  LIMIT 5
	) AS top_departments;
	+------------------+----------------+
	| department_name  | total_students |
	+------------------+----------------+
	| Computer Science | 2              |
	| Mathematics      | 2              |
	| Physics          | 1              |
	+------------------+----------------+



-------------------------------------------------------------------------------------------------------------------------

8)Query with a subquery and CASE statement:
Retrieve the student name, course name, and a column indicating whether the student is enrolled in the course or not:

MySQL root@(none):University> 
	SELECT s.student_name, c.course_name,
	  CASE
	    WHEN e.student_id IS NOT NULL THEN 'Enrolled'
	    ELSE 'Not Enrolled'
	  END AS enrollment_status
	FROM students s
	CROSS JOIN courses c
	LEFT JOIN enrollments e ON s.id = e.student_id AND c.id = e.course_id;
	+---------------+-----------------------------+-------------------+
	| student_name  | course_name                 | enrollment_status |
	+---------------+-----------------------------+-------------------+
	| Daniel Brown  | Introduction to Programming | Not Enrolled      |
	| Sophia Lee    | Introduction to Programming | Not Enrolled      |
	| Michael Davis | Introduction to Programming | Enrolled          |
	| Emma Johnson  | Introduction to Programming | Not Enrolled      |
	| John Smith    | Introduction to Programming | Enrolled          |
	| Daniel Brown  | Calculus I                  | Enrolled          |
	| Sophia Lee    | Calculus I                  | Not Enrolled      |
	| Michael Davis | Calculus I                  | Not Enrolled      |
	| Emma Johnson  | Calculus I                  | Enrolled          |
	| John Smith    | Calculus I                  | Not Enrolled      |
	| Daniel Brown  | Quantum Mechanics           | Not Enrolled      |
	| Sophia Lee    | Quantum Mechanics           | Enrolled          |
	| Michael Davis | Quantum Mechanics           | Not Enrolled      |
	| Emma Johnson  | Quantum Mechanics           | Not Enrolled      |
	| John Smith    | Quantum Mechanics           | Not Enrolled      |
	| Daniel Brown  | Data Structures             | Not Enrolled      |
	| Sophia Lee    | Data Structures             | Not Enrolled      |
	| Michael Davis | Data Structures             | Not Enrolled      |
	| Emma Johnson  | Data Structures             | Not Enrolled      |
	| John Smith    | Data Structures             | Enrolled          |
	| Daniel Brown  | Linear Algebra              | Not Enrolled      |
	| Sophia Lee    | Linear Algebra              | Not Enrolled      |
	| Michael Davis | Linear Algebra              | Not Enrolled      |
	| Emma Johnson  | Linear Algebra              | Not Enrolled      |
	| John Smith    | Linear Algebra              | Not Enrolled      |
	+---------------+-----------------------------+-------------------+


-------------------------------------------------------------------------------------------------------------------------
