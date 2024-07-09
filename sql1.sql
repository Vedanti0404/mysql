-- single line comment
/*
This is how we write a 
multline comment
*/

-- /------------------------------CREATE DATABASE ------------------------------------------------/
-- we can write the commands in capital as well as small letters.
-- Create the database.
-- CREATE DATABASE temp;
-- create database temp2; 
-- CREATE DATABASE test;
create database college;
-- /---------------------------------DROP DATABASE ------------------------------------------------/
-- we can delete the data base by writing this command.
-- DROP DATABASE temp;
-- DROP DATABASE temp2;
-- DROP DATABASE test;
-- /----------------------------------USE DATABSE--------------------------------------------------/
-- USE database_name -> to perform operations on that DB.
USE college;

-- Now inside the college DB.
-- CREATE TABLE table_name(
-- column_name data_type constraint );

CREATE TABLE student(
Roll_number INT PRIMARY KEY,
Student_name VARCHAR(50) NOT NULL,
Age INT NOT NULL
);
-- /--------------------------INSERT INTO college VALUES---------------------------------------/
-- to insert the values into the table we follow this command.
INSERT INTO student VALUES(38, "Rohit Patil", 21);
INSERT INTO student VALUES(11, "Kshitij Kadam", 21);
INSERT INTO student VALUES(33, "vedanti Koyande", 21);
INSERT INTO student VALUES(48, "Amaya Singh Thakur", 21);

-- /----- -----------------------Printing the Table---------------------------------------/
SELECT * FROM student;

-- /----------------------------IF NOT EXISTS-----------------------------------------/

-- IF NOT EXISTS is then only create the DataBASE.
CREATE DATABASE IF NOT EXISTS college;
CREATE DATABASE IF NOT EXISTS college2;
DROP DATABASE college2;
/*----------------------------DROP IF EXISTS-----------------------------------------*/

CREATE DATABASE IF NOT EXISTS temp;
DROP DATABASE IF EXISTS temp; 
-- drops the database only when it is created before, else would give a warning. 

/*-------------------------------SHOW DATABASES--------------------------------------*/
-- use to display all the databases we have created.
SHOW DATABASES;

/*-------------------------------SHOW TABLES--------------------------------------*/
-- to display all the tables that we have created inside a database.alter
SHOW TABLES;

/*------------------------------- --------------------------------------*/

-- primary key is used to uniquely identify the rows in the table.
-- each row in the table has a unique key value, if that column is set to primary key
-- primary key not only esures that the values are unique for each data entry, but also ensures that the values are not NULL.
CREATE TABLE stud(
rollnumber INT PRIMARY KEY,
name VARCHAR(50) 
);

-- -----------------------------------------------------
-- INSERT INTO table_name(COL_name1, COL_name2...[all columns to be filled by default]) VALUES(val1, val2, ...valn);

/*

PRIMARY KEY:-
* primary key is used to uniquely identify the rows in the table.
* Each row in the table has a unique key value, if that column is set to primary key
* primary key not only esures that the values are unique for each data entry, but also ensures that the values are not NULL.
* It is set (or set of columns) in the table that uniquely identifies every row in the table.
* There is only one Primary key in the table, and that is Non NULL.

FOREIGN KEY:-
* A foreign key is a column (or set of columns) in the table that refers, to the primary key in other table. 
* There can be multiple Foreign keys.
* The key that is primary key of some other table and is refered in the table, that column becomes the foreign key.
*/

/*---------------------------------------------------CONSTRAINTS-------------------------------------------------------------------*/
/*
CONSTRAINTS:-
* Rules to store data in column. 
* NOT NULL - the values inside the column cannot be empty.
* UNIQUE - Values inside the columns should be unique.
* PRIMARY KEY - values are unique and not null. 
*/

-- combination should be unique, individual can be duplicate.
-- ( 2, 14, "Rohit" ); -- The Rohit is repeated but primary key is id + name so any one column duplicate is OK.
CREATE TABLE temp(
id INT,
age INT UNIQUE,
name VARCHAR(50),
PRIMARY KEY(id, name)
-- In this the id and name can be duplicated in their own columns but the combination cannot be duplicated.
);


/*-------------------------------------------------------------------------------------------------------------------*/
USE college;

DROP TABLE IF EXISTS hostel;

CREATE TABLE hostel(
hostel_id INT PRIMARY KEY,  -- primary key
name VARCHAR(50) NOT NULL,  -- NOT NULL
gender VARCHAR(50) NOT NULL,
age INT DEFAULT(18), -- DEFAULT
hostel VARCHAR(50) NOT NULL, 
CONSTRAINT Hchecker CHECK((gender = "F" AND hostel = "Girls Hostel") OR (gender = "M" AND hostel = "Boys Hostel")),
college_fees INT NOT NULL
);

INSERT INTO hostel(hostel_id, name, gender, hostel, college_fees)
VALUES
(1, "Mahesh", "M", "Boys Hostel", 50000),
(2, "Almas", "F", "Girls Hostel", 45000),
(3, "Sakshi", "F", "girls Hostel", 55000),
(4, "Bob", "M", "Boys Hostel", 15000),
(5, "Govardhan", "M", "Boys Hostel", 80000),
(6, "Vedanti special koyande", "F", "Girls Hostel", 10),
(7, "Rohit Papu Patil", "F", "Girls Hostel", 30000);

SELECT * FROM hostel;

SELECT age, name FROM hostel;

SELECT DISTINCT hostel, gender FROM hostel; 
-- DISTINCT keyword is used to display only the unique values from that column

-- /-------------------------------WHERE CLAUSE--------------------------------------/
-- Where Clause is used to define the conditions to display only those rows that fulfil that condition. 
SELECT * FROM hostel WHERE gender = "M";

SELECT * FROM hostel WHERE gender = "M" AND name = "Bob";

SELECT * FROM hostel WHERE gender = "F" OR hostel = "Boys Hostel";

-- /-------------------------------OPERATORS--------------------------------------/

/*
ARITHMETIC OPERATORS: + - * / %
COMPARISON OPERATORS: = != > < >= <=
LOGICAL OPERATORS: AND OR NOT IN BETWEEN ALL LIKE ANY
BITWISE OPERATORS: & |
*/

-- /------------------------------------BETWEEN OPERATOR--------------------------/
-- Gives the result in the range of the values
-- SELECT * FROM table_name WHERE column_name BETWEEN lower_limit AND upper_limit
SELECT * FROM hostel WHERE gender BETWEEN "A" AND "H";
SELECT * FROM hostel WHERE gender BETWEEN "I" AND "Z";

-- IN: used to give a list of values that matches with the columns contents and prints the rows corresponding to the matched value;
SELECT * FROM hostel WHERE gender IN ("M");

-- NOT IN : used to display the results that does not match with the values in the list.
SELECT * FROM hostel WHERE gender NOT IN ("F");

-- /-----------------------------------LIMIT CLAUSE-----------------------------------/

-- Set an upper limit to the number of results(rows) to be returned
SELECT * FROM hostel LIMIT 3;
SELECT * FROM hostel WHERE gender NOT IN ("M") LIMIT 2;

-- /-----------------------------------OREDER BY-----------------------------------/
-- ASC ascending
-- DESC descending 

SELECT * FROM hostel ORDER BY name ASC;
SELECT * FROM hostel ORDER BY gender DESC;


-- /------------------------------AGGREGATE FUNCTIONS--------------------------------/

-- Functions that summarises the data and also return single value.
-- NEW COLUMN ADDED (college_fees)

/*
Some of the AGGREGATE FUNCTIONS: 

COUNT(): count the number of occurances in that column
MAX(): maximum value in that column.
MIN(): minimum value in that column.
AVG(): average value of the column.
SUM(): Sum of all the valus in the column. 

Syntex: SELECT funtion_name(column_name) FROM table_name;
*/
SELECT MAX(college_fees) FROM hostel;
SELECT MIN(college_fees) FROM hostel;
SELECT AVG(college_fees) FROM hostel;
SELECT SUM(college_fees) FROM hostel;
SELECT COUNT(college_fees) FROM hostel;

-- /------------------------------GROUP BY--------------------------------/

-- Groups rows that have the same values into summary rows.
-- It collects the data from multiple records and groups the result by one or more column. 
-- Generally we use GROUP BY with some aggregation function.

SELECT hostel, COUNT(gender) -- on which column do we have to create group. (hostel)
FROM hostel -- from which table
GROUP BY hostel; -- create group for (hostel)

