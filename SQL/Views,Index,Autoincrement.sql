-- Views

use depar;

-- 1. Create a view containing employee ID, employee name and hire date.
CREATE VIEW emp_basic AS
SELECT employee_id, CONCAT(first_name, ' ', last_name) AS employee_name, hire_date FROM employees;
desc emp_basic;
SELECT * FROM emp_basic;

-- 2. Create a view for employees whose salary is greater than ₹60,000.
CREATE VIEW high_salary_emp AS
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary > 60000;
desc high_salary_emp;
select * from high_salary_emp;

-- 3. Create a view showing employee names and their department names.
CREATE VIEW emp_department AS
SELECT e.employee_id,
       CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
       d.department_name
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id;
desc emp_department;
select * from emp_department;

-- 4. Create a view containing employees hired after 1 January 2000.
use cdac;
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    marks INT
);
DELIMITER //
CREATE PROCEDURE add_student(
    IN p_name VARCHAR(50),
    IN p_marks INT
)
BEGIN
    INSERT INTO students (name, marks)
    VALUES (p_name, p_marks);
END //
DELIMITER ;
DROP PROCEDURE IF EXISTS add_student;

-- 5. Create a view showing the maximum salary in each department.
CREATE VIEW dept_max_salary AS
SELECT department_id, MAX(salary) AS maximum_salary
FROM employees
GROUP BY department_id;
select * from dept_max_salary;

-- 6. Create a view displaying only HR department employees.
CREATE VIEW hr_employees AS
SELECT e.employee_id, e.first_name, e.last_name, e.salary,
       d.department_name
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
WHERE d.department_name = 'HR';
select * from hr_employees;

-- 7. Create a view showing the total number of employees in each department.
CREATE VIEW dept_employee_count AS
SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS total_employees
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;
select * from dept_employee_count;

-- 8. Create a view showing employees whose names start with 'S'.
CREATE VIEW employees_s AS
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE first_name LIKE 'S%';
select * from employees_s;

-- 9. Use a view to display employees in descending order of salary.
CREATE VIEW employee_salary_view AS
SELECT employee_id, first_name, last_name, salary
FROM employees;
SELECT * FROM employee_salary_view
ORDER BY salary DESC;

-- 10. Modify a view to include the employee's department location
CREATE OR REPLACE VIEW emp_department AS
SELECT e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,d.department_name, l.city AS department_location
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
JOIN locations l
    ON d.location_id = l.location_id;
SELECT * FROM emp_department;

-- 11. Drop a view and verify that the Employees table still exists.
DROP VIEW IF EXISTS employees_s;
SHOW FULL TABLES
WHERE Table_type = 'VIEW';
SHOW TABLES LIKE 'employees';
DESCRIBE employees;

-- Autoincrement
use cdac;
-- 1. Create a Student table with an AUTO_INCREMENT primary key.
CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(50),
    age INT,
    course VARCHAR(50)
);
desc Student;

-- 2. Insert five students without specifying their IDs.
INSERT INTO Student (student_name, age, course)
VALUES
('Amit', 20, 'Java'),
('Neha', 21, 'Python'),
('Rahul', 22, 'SQL'),
('Priya', 20, 'Web Development'),
('Karan', 23, 'Java');
SELECT * FROM Student;
-- 3. Insert one student with an explicitly specified ID of 50.
INSERT INTO Student
    (student_id, student_name, age, course)
VALUES
    (50, 'Adil', 22, 'Advanced Computing');
    SELECT * FROM Student;
-- 4. Insert a student using NULL for the ID.
INSERT INTO Student
    (student_id, student_name, age, course)
VALUES
    (NULL, 'Sara', 21, 'Database');
    SELECT * FROM Student;
    
-- 5. Find the next AUTO_INCREMENT value for the Student table.
SHOW TABLE STATUS LIKE 'Student';
SELECT AUTO_INCREMENT
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'Student';
  
-- 6. Change the next AUTO_INCREMENT value to 200.
ALTER TABLE Student AUTO_INCREMENT = 200;
SHOW TABLE STATUS LIKE 'Student';
-- 7. Create an Orders table with AUTO_INCREMENT starting at 1000.x`
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_name VARCHAR(100),
    amount DECIMAL(10,2)
) AUTO_INCREMENT = 1000;

INSERT INTO Orders (order_name, amount)
VALUES('Laptop', 45000.00), ('Keyboard', 1200.00), ('Mouse', 600.00);
SELECT * FROM Orders;

-- 8. Delete the record with ID 3 and insert a new record. Observe the generated ID.
DELETE FROM Student
WHERE student_id = 3;
INSERT INTO Student (student_name, age, course)
VALUES ('Rohan', 22, 'JavaScript');
SELECT * FROM Student ORDER BY student_id;

-- 9. Write a query to retrieve the last generated ID.
SELECT LAST_INSERT_ID() AS last_generated_id;

-- Indexes
use cdac;
DESCRIBE employees;
-- 1. Create an index on the city column of Employee.
ALTER TABLE employees
ADD COLUMN city VARCHAR(50);

CREATE INDEX idx_employees_city
ON Employees(city);

-- 2. Create a unique index on the email column.
ALTER TABLE employees
ADD COLUMN email VARCHAR(100);

CREATE UNIQUE INDEX idx_employee_email
ON Employees(email);
SHOW INDEX FROM Employees;
-- 3. Create an index on the salary column and retrieve employees earning more than 60000.
DESCRIBE employees;
ALTER TABLE employees
ADD COLUMN salary DECIMAL(10,2);
CREATE INDEX idx_employee_salary
ON employees(salary);
SELECT * FROM employees LIMIT 5;

-- 4. Create a composite index on department and city.
CREATE INDEX idx_employee_department_city
ON employees(department, city);
SHOW INDEX FROM employees;
-- 5. Write a query to display employees in the HR department using EXPLAIN.
EXPLAIN
SELECT *
FROM employees
WHERE city = 'Delhi';

-- 6. Display all indexes defined on the Employee table.
SHOW INDEX FROM employees;
-- 7. Drop the index created on city.
DROP INDEX idx_employees_city
ON employees;
SHOW INDEX FROM employees;

-- 8. Create an index on the hire_date column after adding that column to Employee.
ALTER TABLE employees
ADD COLUMN hire_date DATE;
CREATE INDEX idx_employee_hire_date
ON employees(hire_date);
SHOW INDEX FROM employees;