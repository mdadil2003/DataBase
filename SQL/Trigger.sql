USE depar;

-- Q1. Create a trigger that automatically sets the hire_date of an employee to current date when a new row is inserted into the employees table (if not provided).
DELIMITER //
CREATE TRIGGER before_employee_insert_date
BEFORE INSERT ON employees FOR EACH ROW
BEGIN IF NEW.hire_date IS NULL THEN
        SET NEW.hire_date = CURDATE();
    END IF;
END //
DELIMITER ;

INSERT INTO employees
    (first_name, last_name, email, hire_date, job_id, salary, department_id)
VALUES
    ('Test', 'Adil', 'test.adil@example.com', NULL, 1, 6000, 1);

SELECT employee_id, first_name, hire_date
FROM employees
WHERE email = 'test.adil@example.com';

-- Q2. Write a trigger that prevents deletion of rows from the departments table.
DELIMITER //
CREATE TRIGGER before_department_delete
BEFORE DELETE ON departments
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Deletion from departments is not allowed';
END //
DELIMITER ;
DELETE FROM departments
WHERE department_id = 1;

SELECT * FROM departments
WHERE department_id = 1;

-- Q3.Create a trigger that automatically updates a column last_updated whenever a row in the employees table is updated.
ALTER TABLE employees
ADD COLUMN last_updated TIMESTAMP
DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE employees
ADD COLUMN last_updated DATETIME;

DELIMITER //
CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employees FOR EACH ROW
BEGIN
    SET NEW.last_updated = CURRENT_TIMESTAMP;
END //
DELIMITER ;
SELECT employee_id, first_name, salary, last_updated
FROM employees
LIMIT 5;

UPDATE employees
SET salary = salary + 100
WHERE employee_id = 101;

SELECT employee_id, salary, last_updated
FROM employees
WHERE employee_id = 101;
-- Q4. Write a trigger that prevents insertion of an employee with a salary less than 5000.
DELIMITER //
CREATE TRIGGER before_employee_salary_insert
BEFORE INSERT ON employees FOR EACH ROW
BEGIN
    IF NEW.salary < 5000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary must be at least 5000';
    END IF;
END //
DELIMITER ; 
INSERT INTO employees
    (first_name, last_name, email, hire_date, job_id, salary, department_id)
VALUES
    ('Low', 'Salary', 'low.salary@example.com',
     CURDATE(), 1, 4000, 1);
     SELECT * FROM employees
WHERE email = 'low.salary@example.com';
-- Q5. Create a trigger that ensures employees cannot be inserted into a department that does not exist in the departments table.
DELIMITER //
CREATE TRIGGER before_employee_department_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.department_id IS NOT NULL
       AND NOT EXISTS (
           SELECT 1
           FROM departments
           WHERE department_id = NEW.department_id
       )
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Department does not exist';
    END IF;
END //
DELIMITER ;
INSERT INTO employees
    (first_name, last_name, email, hire_date, job_id, salary, department_id)
VALUES
    ('Invalid', 'Department', 'invalid.dept@example.com',
     CURDATE(), 1, 6000, 999999);
-- Q6. Write a trigger that ensures end_date of a project is always greater than start_date.
DELIMITER //
CREATE TRIGGER before_project_insert
BEFORE INSERT ON projects
FOR EACH ROW
BEGIN
    IF NEW.end_date IS NOT NULL
       AND NEW.start_date IS NOT NULL
       AND NEW.end_date <= NEW.start_date
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'End date must be greater than start date';
    END IF;
END //
DELIMITER ;
INSERT INTO projects (start_date, end_date)
VALUES ('2026-10-20', '2026-10-15');
SELECT * FROM projects;
SHOW TRIGGERS;