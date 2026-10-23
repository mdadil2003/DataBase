use depar;

-- Q1. Create a function that takes a salary as input and returns the annual salary.
DELIMITER //
CREATE FUNCTION annual_salary(monthly_salary DECIMAL(10,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    RETURN monthly_salary * 12;
END //
DELIMITER ;
SELECT annual_salary(50000) AS annual_salary;

-- Q2. Write a function that accepts a number and returns its factorial.
DELIMITER //
CREATE FUNCTION factorial_num(n INT)
RETURNS BIGINT
DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE result BIGINT DEFAULT 1;
    IF n < 0 THEN
        RETURN NULL;
    END IF;
    WHILE i <= n DO
        SET result = result * i;
        SET i = i + 1;
    END WHILE;
    RETURN result;
END //
DELIMITER ;
SELECT factorial_num(5) AS factorial;

-- Q3. Write a function that returns "PASS" if marks ≥ 40, else "FAIL".
DELIMITER //
CREATE FUNCTION check_result(marks INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    IF marks >= 40 THEN
        RETURN 'PASS';
    ELSE
        RETURN 'FAIL';
    END IF;
END //
DELIMITER ;
SELECT check_result(75) AS result;
SELECT check_result(35) AS result;

-- Q4. Create a function that checks if a number is prime and returns "YES" or "NO".
DELIMITER //
CREATE FUNCTION is_prime(n INT)
RETURNS VARCHAR(3)
DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 2;
    IF n < 2 THEN
        RETURN 'NO';
    END IF;
    WHILE i <= n / i DO
        IF MOD(n, i) = 0 THEN
            RETURN 'NO';
        END IF;

        SET i = i + 1;
    END WHILE;
    RETURN 'YES';
END //
DELIMITER ;
SELECT is_prime(7) AS result;
SELECT is_prime(10) AS result;

-- Q5. Write a function that takes dept_id as input and returns "SMALL" if it has fewer than 5 employees, else "LARGE".
DROP FUNCTION IF EXISTS department_size;
DELIMITER //

CREATE FUNCTION department_size(p_dept_id INT)
RETURNS VARCHAR(10)
READS SQL DATA
BEGIN
    DECLARE emp_count INT DEFAULT 0;

    SELECT COUNT(*)
    INTO emp_count
    FROM employees
    WHERE department_id = p_dept_id;

    IF emp_count < 5 THEN
        RETURN 'SMALL';
    ELSE
        RETURN 'LARGE';
    END IF;
END //

DELIMITER ;
SELECT department_size(10) AS department_size;
SELECT department_id, COUNT(*) AS total_employees
FROM employees
GROUP BY department_id;

-- Q6.  Write a function that returns the department name for a given emp_id.
USE depar;
SHOW TABLES;
DESCRIBE employees;
DELIMITER //

CREATE FUNCTION get_department_name(p_emp_id INT)
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
    DECLARE dept_name VARCHAR(100) DEFAULT NULL;

    SELECT d.department_name
    INTO dept_name
    FROM employees e
    JOIN departments d
        ON e.department_id = d.department_id
    WHERE e.employee_id = p_emp_id
    LIMIT 1;

    RETURN dept_name;
END //

DELIMITER ;
SELECT get_department_name(101) AS department_name;
-- Q7.  Create a function that calculates the bonus as 10% of salary and returns it for a given emp_id.
DROP FUNCTION IF EXISTS employee_bonus;
DELIMITER //

CREATE FUNCTION employee_bonus(p_emp_id INT)
RETURNS DECIMAL(12,2)
READS SQL DATA
BEGIN
    DECLARE emp_salary DECIMAL(8,2) DEFAULT NULL;

    SELECT salary
    INTO emp_salary
    FROM employees
    WHERE employee_id = p_emp_id;

    IF emp_salary IS NULL THEN
        RETURN NULL;
    END IF;

    RETURN emp_salary * 0.10;
END //

DELIMITER ;
SELECT employee_bonus(101) AS bonus;
SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    employee_bonus(employee_id) AS bonus
FROM employees;
-- Q8.  Write a function that returns the total experience (in years) of an employee based on hire_date.
DROP FUNCTION IF EXISTS employee_experience;
DELIMITER //

CREATE FUNCTION employee_experience(p_emp_id INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE joining_date DATE DEFAULT NULL;

    SELECT hire_date
    INTO joining_date
    FROM employees
    WHERE employee_id = p_emp_id;

    IF joining_date IS NULL THEN
        RETURN NULL;
    END IF;

    RETURN TIMESTAMPDIFF(YEAR, joining_date, CURDATE());
END //

DELIMITER ;
SELECT employee_experience(101) AS experience_years;
SELECT
    employee_id,
    first_name,
    last_name,
    hire_date,
    employee_experience(employee_id) AS experience_years
FROM employees;
-- Q9. Create a function that returns the highest paid employee name in a given department.
DELIMITER //

CREATE FUNCTION highest_paid_employee(p_dept_id INT)
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
    DECLARE highest_name VARCHAR(100) DEFAULT NULL;

    SELECT empname
    INTO highest_name
    FROM employees
    WHERE dept_id = p_dept_id
      AND salary IS NOT NULL
    ORDER BY salary DESC, empname ASC
    LIMIT 1;

    RETURN highest_name;
END //

DELIMITER ;
SELECT highest_paid_employee(10) AS employee_name;

-- Q10. Create a function that accepts two numbers and returns the greatest common divisor (GCD).
DROP FUNCTION IF EXISTS highest_paid_employee;
DELIMITER //

CREATE FUNCTION highest_paid_employee(p_dept_id INT)
RETURNS VARCHAR(100)
READS SQL DATA
BEGIN
    DECLARE highest_name VARCHAR(100) DEFAULT NULL;

    SELECT CONCAT(first_name, ' ', last_name)
    INTO highest_name
    FROM employees
    WHERE department_id = p_dept_id
    ORDER BY salary DESC
    LIMIT 1;

    RETURN highest_name;
END //

DELIMITER ;
SELECT find_gcd(12, 18) AS gcd;
SELECT
    employee_id,
    first_name,
    last_name,
    department_id,
    salary
FROM employees
WHERE department_id = 10
ORDER BY salary DESC
LIMIT 1;
