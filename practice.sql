CREATE DATABASE XYZ;
USE XYZ;

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT
);

INSERT INTO employees (id, name, salary) VALUES (1, "Adam", 25000);
INSERT INTO employees (id, name, salary) VALUES (2, "Bob", 30000);
INSERT INTO employees (id, name, salary) VALUES (3, "Casey", 40000);

SELECT * FROM employees;

