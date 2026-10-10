use depar;

-- 1.	Retrieve all employees with their department names.
select e.employee_id,e.first_name,e.last_name,d.department_name from employees e inner join departments d on(e.department_id=d.department_id);
-- 2.	Find the names (first_name, last_name), job, department number, and department name of the employees who work in London.
SELECT e.first_name, e.last_name,j.job_title,d.department_id,d.department_name FROM employees e
JOIN jobs j ON e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'London';

-- 3.	Find employees who work in the IT department.
SELECT e.employee_id, e.first_name, e.last_name,
       d.department_name
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
WHERE d.department_name = 'IT';
-- 4.	List all departments and their employees (including departments with no employees).
SELECT d.department_id, d.department_name,
       e.employee_id, e.first_name, e.last_name
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id;
    
-- 5.	Find employees who do not belong to any department.
SELECT employee_id, first_name, last_name, department_id
FROM employees
WHERE department_id IS NULL;

-- 6.	Retrieve the highest-paid employee in each department.
SELECT e.employee_id, e.first_name, e.last_name,
       e.department_id, e.salary
FROM employees e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);
-- 7.	List departments that have at least one employee.
SELECT DISTINCT d.department_id, d.department_name
FROM departments d
JOIN employees e
    ON d.department_id = e.department_id;
-- 8.	Find departments with no employees assigned.
SELECT d.department_id, d.department_name
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;
-- 9.	Find the average salary for each department.
SELECT department_id,
       AVG(salary) AS average_salary
FROM employees
GROUP BY department_id;
-- 10.	Retrieve the total number of employees in each department.
SELECT d.department_id, d.department_name,
       COUNT(e.employee_id) AS total_employees
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;
-- 11.	Find employees who earn more than the average salary of their department.
SELECT e.employee_id, e.first_name, e.last_name,
       e.salary, e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id);
-- 12.	Write a query to display the department ID, department name and manager first name.
SELECT d.department_id, d.department_name, e.first_name AS manager_first_name FROM departments d
LEFT JOIN employees e ON d.manager_id = e.employee_id;

-- 13.	Write a query to display the department name, manager name, and city.
SELECT d.department_name,
       CONCAT(e.first_name, ' ', e.last_name) AS manager_name, l.city
FROM departments d LEFT JOIN employees e ON d.manager_id = e.employee_id
LEFT JOIN locations l ON d.location_id = l.location_id;

-- 14.	Write a query to display department name, name (first_name, last_name), hire date, salary of the manager for all managers whose experience is more than 15 years.
SELECT d.department_name,e.first_name,e.last_name,e.hire_date,e.salary
FROM departments d
JOIN employees e ON d.manager_id = e.employee_id
WHERE TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE()) > 15;

-- 15.	Write a query to display the job title and average salary of employees.
SELECT j.job_title, AVG(e.salary) AS average_salary
FROM jobs j
JOIN employees e ON j.job_id = e.job_id
GROUP BY j.job_id, j.job_title;
