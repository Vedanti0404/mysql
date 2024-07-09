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
(4, 'Nidhi', 23, 'F', 88, 'Bangalore', 'Donald', 103),
(5, 'Vikram', 21, 'M', 92, 'Chennai', 'Bob',101),
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
SELECT Gender
FROM stud
WHERE Marks > 70
GROUP BY Gender
HAVING COUNT(*) > 0
ORDER BY Gender ASC;
/*-----------------------------------------------------------------UPDATE----------------------------------------------------------------------------*/
SET SQL_SAFE_UPDATES=0; -- This query is for changing safe mode. '0' means off

UPDATE stud
SET Marks = 95
WHERE Roll_number = 2;
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
what is the datatype of those columns and what constraints are there on thode columns.
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














