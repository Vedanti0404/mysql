CREATE DATABASE student;
DROP DATABASE IF EXISTS student;
USE student;

CREATE TABLE stud(
Roll_number INT PRIMARY KEY,
Student_name VARCHAR(50) NOT NULL,
Age INT NOT NULL,
Gender VARCHAR(50) NOT NULL,
Marks INT NOT NULL,
City VARCHAR(50) NOT NULL,
Mentor_name VARCHAR(50),
Mentor_id INT
);
DROP TABLE stud;
/*-----------------------------------------------------------------REVISITING FOREIGN KEY----------------------------------------------------------------------------*/

CREATE TABLE dept(
id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL
);
INSERT INTO dept
VALUES
(101,"English"),
(102,"Hindi");
SELECT*FROM dept;

UPDATE dept
SET id = 103
WHERE id=102;
/*-----------------------------------------------------------------CASCADING for FOREIGN KEY----------------------------------------------------------------------------*/
/*ON DELETE CASCADE
When we create a foreign key using this option, it deletes the referencing rows in the child table when the referenced row is deleted
in the parent table which has a primary key.*/
 
 /*ON UPDATE CASCADE
When we create a foreign key using UPDATE CASCADE the referencing rows are updated in the child table when the referenced row is updated 
in the parent table which has a primary key.*/

CREATE TABLE teacher(
id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES dept(id)
ON UPDATE CASCADE
ON DELETE CASCADE
);
DROP TABLE teacher;
INSERT INTO teacher
VALUES
(101,"Adam", 101),
(102,"Adam", 102);
SELECT*FROM teacher;

INSERT INTO stud (Roll_number, Student_name, Age, Gender, Marks, City, Mentor_name, Mentor_id)
VALUES
(1, 'Aarav', 20, 'M', 85, 'Mumbai', NULL, NULL),
(2, 'Isha', 21, 'F', 90, 'Delhi', 'Bob', 101),
(3, 'Raj', 22, 'M', 75, 'Ahmedabad', 'Jack', 102),
(4, 'Nidhi', 23, 'F', 88, 'Delhi', 'Donald', 103),
(5, 'Vikram', 21, 'M', 92, 'Delhi', 'Bob',101),
(6, 'Abhi', 19, 'M', 80, 'Pune', 'John', 104);

/*-----------------------------------------------------------------------------------------------------------------------------*/
SELECT * FROM stud;
SELECT Age,Student_name FROM stud;
/*-----------------------------------------------DISTINCT------------------------------------------------------------------------------*/
SELECT DISTINCT city, gender FROM stud;
/*-------------------------------------------------WHERE----------------------------------------------------------------------------*/
SELECT * FROM stud WHERE marks >80;
SELECT * FROM stud WHERE marks >70 AND Age=21;
SELECT * FROM stud WHERE marks >70 AND gender='M';
/*-------------------------------------------------BETWEEN----------------------------------------------------------------------------*/
SELECT * FROM stud WHERE gender BETWEEN 'E' AND 'G';
SELECT * FROM stud WHERE city BETWEEN 'A' AND 'I';
SELECT * FROM stud WHERE marks BETWEEN '53' AND '88';
/*-------------------------------------------------IN and NOT IN----------------------------------------------------------------------------*/
SELECT * FROM stud WHERE gender IN ('M');
SELECT * FROM stud WHERE gender NOT IN ('M');
SELECT * FROM stud WHERE city IN ('Bangalore');
SELECT * FROM stud WHERE city NOT IN ('Bangalore');
/*-------------------------------------------------LIMIT----------------------------------------------------------------------------*/
SELECT * FROM stud LIMIT 2;
SELECT * FROM stud WHERE gender IN ("M") LIMIT 2;
SELECT * FROM stud WHERE marks > 70 LIMIT 4;
/*-------------------------------------------------ORDER BY----------------------------------------------------------------------------*/
SELECT * FROM stud ORDER BY student_name ASC;
SELECT * FROM stud ORDER BY student_name DESC;
SELECT * FROM stud ORDER BY marks ASC;
SELECT * FROM stud ORDER BY marks DESC;
SELECT * FROM stud ORDER BY city DESC;
/*-------------------------------------------------AGGREGATE----------------------------------------------------------------------------*/
SELECT MIN(Marks) FROM stud;
SELECT Max(Marks) FROM stud;
SELECT AVG(Marks) FROM stud;
SELECT SUM(Marks) FROM stud;
SELECT COUNT(Marks) FROM stud;
/*-------------------------------------------------GROUP BY----------------------------------------------------------------------------*/
SELECT Gender, COUNT(*) 
FROM stud 
GROUP BY Gender;
/*-------------------------------------------------GROUP BY----------------------------------------------------------------------------*/
SELECT Gender, COUNT(*)
FROM stud
WHERE Marks > 70
GROUP BY Gender
HAVING COUNT(*) > 2
ORDER BY Gender DESC;
/*-----------------------------------------------------------------UPDATE----------------------------------------------------------------------------*/
SET SQL_SAFE_UPDATES=0; -- This query is for changing safe mode. '0' means off

UPDATE stud
SET Marks = 95
WHERE Roll_number = 2; -- USE PRIMARY KEY ONLY
SELECT * FROM stud;

UPDATE stud
SET Marks = Marks + 1;
SELECT * FROM stud;

/*-----------------------------------------------------------------DELETE----------------------------------------------------------------------------*/
DELETE FROM stud 
WHERE Marks < 90;
SELECT * FROM stud;
/*------------------------------------------------------ALTER COMMAND---------------------------------------------------------------------*/
/*ALTER COMMAND :  It is used to change the SCHEMA (Schema means the design of the table means, which columns are there, 
what is the datatype of those columns and what constraints are there on those columns.
There are 3 operations in ALTER:
1.ADD column
2.DROP column
3.RENAME table
4.CHANGE column
5.MODIFY column*/

-- ADD
ALTER TABLE stud
ADD COLUMN grade VARCHAR(18);

ALTER TABLE stud
ADD COLUMN fees INT NOT NULL DEFAULT 50000;
SELECT * FROM stud;

-- DROP
ALTER TABLE stud
DROP COLUMN grade;

ALTER TABLE stud
DROP COLUMN ranks;

SELECT * FROM stud;

-- RENAME
ALTER TABLE stud
RENAME TO stud_table;
SELECT * FROM stud_table;
DROP TABLE stud_table;

-- CHANGE
ALTER TABLE stud
CHANGE age stud_age INT;
SELECT * FROM stud;
-- Change column name back from stud_age to age
ALTER TABLE stud
CHANGE stud_age age INT;
SELECT * FROM stud;

-- MODIFY
ALTER TABLE stud
MODIFY COLUMN stud_age VARCHAR(2);
SELECT * FROM stud;

INSERT INTO stud (Roll_number, Student_name, stud_age, Gender, Marks, City)
VALUES
(6, 'Abhi', 100, 'M', 85, 'Pune');
SELECT * FROM stud;

-- Modify column type back to INT
ALTER TABLE stud 
MODIFY COLUMN stud_age INT;
SELECT * FROM stud;

/*----------------------------------------------------------------TRUNCATE-------------------------------------------------------------------------*/
-- deletes the values not the whole table.
TRUNCATE TABLE stud;


/* RRACTICE QUESTION
In the student table :
a. Change the name of column name" to "full_name”.
b. Delete all the students who scored marks less than 80.
c. Delete the column for grades.*/

-- Change the name of column name" to "full_name”.
ALTER TABLE stud
CHANGE Student_name Full_name VARCHAR(50);
SELECT * FROM stud;

--  Delete all the students who scored marks less than 80.
DELETE FROM stud 
WHERE Marks < 80;
SELECT * FROM stud;

--  Delete the column for grades/ marks.
ALTER TABLE stud
DROP COLUMN Marks;
SELECT * FROM stud;

/*---------------------------------------------------------------------JOINS IN SQL------------------------------------------------------------------*/
-- Join is used to combine rows from two or more tables, based on a related column between them.
/*TYPES OF JOINS
1. INNER JOIN:-Returns records that have matching values in both tables
SYNTAX:SELECT column
       FROM table A
       INNER JOIN table B
       ON table A.col_name = table B.col_name;
       
2.LEFT JOIN:-Returns all records from the left table, and the matched records from the right table.
Syntax: SELECT column(s)
        FROM table A
        LEFT JOIN table B
        ON table A.col_name = table B.col_name;
        
3.RIGHT JOIN:-Returns all records from the right table, and the matched records from the left table.
Syntax: SELECT column(s)
        FROM table A
        RIGHT JOIN table B
        ON table A.col_name = table B.col_name;
        
4.FULL JOIN:- Returns all records when there is a match in either left or right table
Syntax in MySQL: SELECT * FROM student as a
                 LEFT JOIN course as b
                 ON a. id = b. id
                 UNION
				 SELECT * FROM student as a
                 RIGHT JOIN course as b
                 ON a. id = b. id;
                 LEFT JOIN
                 UNION
                 RIGHT JOIN
                 
-- LEFT, RIGHT, FULL JOIN ARE TYPES OF OUTER JOIN.*/


CREATE TABLE course(
Roll_number INT PRIMARY KEY,
course VARCHAR(50) NOT NULL
);
DROP TABLE course;
SELECT * FROM course;
INSERT INTO course (Roll_number, course)
VALUES
(1, 'English'),
(2, 'Hindi'),
(5, 'Geography');
SELECT * FROM course;

-- INNER JOIN
SELECT *
FROM stud
INNER JOIN course
ON stud.Roll_number = course.Roll_number;

/* We can also use alias . Alias means we can use short names for tables. While dealing with multiple table it becomes difficult to remember the names of table ,
 so we can use the shortforms for the tables in following way:
FROM student as s
In this way we can use the alternate short name for our tables.
*/

-- LEFT JOIN
SELECT *
FROM stud
LEFT JOIN course
ON stud.Roll_number = course.Roll_number;

-- RIGHT JOIN
SELECT *
FROM stud
RIGHT JOIN course
ON stud.Roll_number = course.Roll_number;

-- FULL JOIN
SELECT *
FROM stud
LEFT JOIN course
ON stud.Roll_number = course.Roll_number
UNION
SELECT *
FROM stud
RIGHT JOIN course
ON stud.Roll_number = course.Roll_number;


-- LEFT EXCLUSIVE JOIN : It means the only data that is exclusively present in table A.
SELECT *
FROM stud
LEFT JOIN course
ON stud.Roll_number = course.Roll_number
WHERE course.Roll_number IS NULL;

-- RIGHT EXCLUSIVE JOIN : It means the only data that is exclusively present in table B.
SELECT *
FROM stud
RIGHT JOIN course
ON stud.Roll_number = course.Roll_number
WHERE stud.Roll_number IS NULL;

-- FULL EXCLUSIVE JOIN : It means the only data that is exclusively present in table A and table B.
SELECT *
FROM stud
LEFT JOIN course
ON stud.Roll_number = course.Roll_number
WHERE course.Roll_number IS NULL
UNION
SELECT *
FROM course
LEFT JOIN stud
ON course.Roll_number = stud.Roll_number
WHERE stud.Roll_number IS NULL;

/* SELF JOIN:-It is a regular join but the table is joined with itself.
SYNTAX:
SELECT column(s)
FROM table as a
JOIN table as b
ON a.col_name = b.col_name;
*/
SELECT *
FROM stud
JOIN course
ON stud.Roll_number = course.Roll_number;

-- ---------------------------------------------------UNION--------------------------------------------------------------
/*
It is used to combine the result-set of two or more SELECT statements.
Gives UNIQUE records.
To use it :
• every SELECT should have same no. of columns
• columns must have similar data types
• columns in every SELECT should be in same order

SYNTAX:
SELECT COLUMN(S) FROM table A
UNION
SELECT COLUMN(S) FROM table B*/

SELECT student_name FROM stud
UNION 
SELECT student_name FROM stud;

-- UNION ALL: This gives the duplicates
SELECT student_name FROM stud
UNION 
SELECT student_name FROM stud;
-- In this case we are not having any of these names in other tables so we will not get any duplicate values.

/*----------------------------------------------SQL SUBQUERIES------------------------------------------------------------*/
/*Also known as INNER query or NESTED query.
It is a query within another SQL query.It involves 2 selct statements.
SYNTAX:
SELECT COLUMNS
FROM table name
WHERE COLUMN NAME OPERATOR --(In place of operater we can use Between,In,>,<,etc)
(SUBQUERY);

There are 3 ways in which we can write the subquery;
1. within SELECT statement
2.within FROM statement
3.within WHERE clause.(mostly used)*/

SELECT AVG(marks)
FROM stud;

SELECT student_name, marks
FROM stud
WHERE marks > 85.0000;
/*this is a static way of finding student who have more marks than the average in the table.
But what if some student gets more marks and then we update thode marks in the table. It will sure change the average marks.
Hence we need a dynamic way to solve such type of problem.*/

SELECT student_name, marks
FROM stud
WHERE marks > (SELECT AVG(marks) FROM stud);
-- this is dynamic . whenever some changes are made in the table it will automatically calculate according to the changes.

-- Name and roll no of student whose roll no is even number
SELECT Roll_number, Student_name
FROM stud
WHERE Roll_number IN (
    SELECT Roll_number
    FROM stud
    WHERE Roll_number % 2 = 0
);

-- SUBQUERY using FROM

-- Finding the maximum marks from delhi city
SELECT MAX(marks)
FROM(SELECT * FROM stud WHERE city='Delhi') AS temp; 
-- whenever we write a subquery in FROM we need to write the alias.
-- We can do this same thing in simple way too but this is the demonstration of how to use a subquery in From statement.


-- SUBQUERY using SELECT( not frequently used)
SELECT(SELECT MAX(marks) FROM stud ), Student_name
FROM stud;
-- this is not used frequently as it is ineffecient than other .


/*--------------------------------------------------MySQL Views------------------------------------------------*/
/*A view is a virtual table based on the result-set of an SQL statement.
Imagine we have a big customer dataset in which we have various columns. If a company has this kind of data, then 
suppose if there is a sales team and if that team gets the data of the credit card that the customer has used to make 
the transaction then such kind of data is not necessary for the sales team or customer service team. It is important for accounts
team to have the credit card data . In such cases we create views from the table. We take the smaller verison of that tabel
and make a virtal or temporary view there is smaller data and on that view we run our queries.*/

CREATE VIEW view1 AS
SELECT Roll_number, Student_name, marks FROM stud;
SELECT * FROM view1
WHERE marks>90;
DROP VIEW view1;
-- Whatever operation we perform on table we can perform on view.Views will not affect our actual table 






