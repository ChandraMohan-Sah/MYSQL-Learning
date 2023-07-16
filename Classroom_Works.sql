CREATE DATABASE db_CLASSWORK;

---------------------------------------------CREATING TABLE WITH PRIMARY AND FOREIGN KEY ------------------------------->
CREATE TABLE tbl_STUDENT(
	Name varchar(255),
	Address varchar(255),
	Age INT NOT NULL,
	RollNum INT NOT NULL,
	Faculty varchar(20),
	PRIMARY KEY (RollNum)
);

CREATE TABLE tbl_SUBJECT(
	SubjectName varchar(50) NOT NULL,
	SubjectId INT NOT NULL,
	PRIMARY KEY (SubjectId),
);

CREATE TABLE tbl_MARKS(
	StuId INT ,
	SubId INT,
	Marks INT NOT NULL,
	FOREIGN KEY (StuId) REFERENCES tbl_STUDENT(RollNum),
	FOREIGN KEY (SubId) REFERENCES tbl_SUBJECT(SubjectId)
);

-------------------------- INSERTING ATTRIBUTES VALUES FOR ABOVE TABLES --------------------------------------------->

-- insert record into table with no foreign key first
INSERT INTO tbl_STUDENT
VALUES
( 'Hari Joshi', 'Akantakuna', 19, 01, 'BEI' ),
( 'Kalyan Shrestha', 'Koteshwor', 20, 02, 'BEI' ),
( 'Mohit Bhusal', 'Koteshwor', 22, 03, 'BEI' ),
( 'Kiran Chand', 'Gwarko', 19, 04, 'BEI' ),
( 'Arnab Manandhar', 'PutaliSadak', 19, 05, 'BEI' ),
( 'ChandraMohan sah', 'Koteshwor', 21, 06, 'BEI' )

-- insert record into table with no foreign key first
INSERT INTO tbl_SUBJECT
VALUES
('DBMS', 203),
('Computer Network', 204),
('Operating System', 205),
('Computer Organization', 206),
('Filter Design', 207),
('Engineering Economics', 208)

-- insert record into table with a foreign key
-- insertion error Occurs  if U try to insert with RollNum and SubjId  that does not exist
INSERT INTO tbl_MARKS
VALUES
(1, 203, 60),
(1, 204, 34),
(1, 205, 55),
(1, 206, 26),
(1, 207, 32),
(1, 208, 72),

(2, 203, 55),
(2, 204, 42),
(2, 205, 32),
(2, 206, 70),
(2, 207, 32),
(2, 208, 21),

(3, 203, 21),
(3, 204, 45),
(3, 205, 67),
(3, 206, 29),
(3, 207, 50),
(3, 208, 68),

(4, 203, 69),
(4, 204, 34),
(4, 205, 55),
(4, 206, 59),
(4, 207, 63),
(4, 208, 62),

(5, 203, 32),
(5, 204, 56),
(5, 205, 55),
(5, 206, 59),
(5, 207, 61),
(5, 208, 62)


----------------------------------------------Displaying and Deletion Action------------------------------------------------------------->


-------------------------------------------------------------------------------------------------------------------------------------------
--In summary, DDL focuses on defining and modifying the structure of the database objects, while DML deals with manipulating the data within 
--those objects. DDL statements are concerned with schema-related operations, while DML statements are used for data-related operations.

-------------------------------------------- DML (Data Manipulation Language) ------------------------------>
--
SELECT *from tbl_STUDENT;			--SELECT
SELECT *from tbl_SUBJECT;
SELECT *from tbl_MARKS;


UPDATE  tbl_STUDENT			       --UPDATE
SET name = 'ChandraMohan Sah'
where RollNum = 1

--Already Done See Above		     --INSERT:	Used to insert new data into a table.


DELETE from tbl_STUDENT			    --DELETE:	Used to delete specific data from a table.
where RollNum = 6

Delete from tbl_MARKS
where StuId = 1						


---------------------------------------------------------- Operators  --------------------------------------------------

SELECT * FROM tbl_STUDENT					---- BETWEEN Operator
WHERE Age BETWEEN 10 AND 20;

SELECT * FROM tbl_STUDENT					---- AND OPerator
WHERE Age=19 AND RollNum=1;

SELECT * FROM tbl_STUDENT					---- OR Operator
WHERE Age=19 OR Age BETWEEN 10 AND 20;

SELECT * FROM tbl_STUDENT					---- NOT Operator
WHERE NOT Age=19;


SELECT * FROM tbl_STUDENT		----like Operator starts with
WHERE name LIKE 'K%';


SELECT * FROM tbl_STUDENT		----like Operator  ends with
WHERE name LIKE '%l';

SELECT * FROM tbl_STUDENT		----like Operator  2nd Position ma 
WHERE name LIKE '_a%';


SELECT *FROM tbl_STUDENT	   -----Ascending Order
ORDER BY RollNum ASC

SELECT *FROM tbl_STUDENT	   -----Ascending Order --String- lexogarphically
ORDER BY Name ASC

SELECT *FROM tbl_STUDENT	   -----Descending Order
ORDER BY RollNum DESC

--------------------------------------------------------------------------------------------------------------------------------------

SELECT Name FROM tbl_STUDENT
WHERE RollNum IN (SELECT StuId FROM tbl_MARKS WHERE Marks > 40);  -- sub query executes first 

SELECT Name FROM tbl_STUDENT
WHERE RollNum IN (SELECT Marks FROM tbl_MARKS WHERE Marks > 40); -- Error ??





