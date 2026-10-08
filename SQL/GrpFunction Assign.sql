use depar;

-- 1. Write a query to list the number of jobs available in the employees table.
SELECT COUNT(DISTINCT job_id) AS number_of_jobs
FROM employees;

-- 2. Write a query to get the total salaries payable to employees.
SELECT SUM(salary) AS total_salary
FROM employees;

-- 3. Write a query to get the minimum salary from employees table.
SELECT MIN(salary) AS minimum_salary
FROM employees;

-- 4. Write a query to get the maximum salary of an employee working as a Programmer.
SELECT MAX(e.salary) AS maximum_salary
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
WHERE j.job_title = 'Programmer';

-- 5. Write a query to get the average salary and number of employees working the department 9.
SELECT AVG(salary) AS average_salary, COUNT(*) AS number_of_employees FROM employees
WHERE department_id = 9;

-- 6. Write a query to get the highest, lowest, sum, and average salary of all employees.
SELECT MAX(salary) AS highest_salary,
       MIN(salary) AS lowest_salary,
       SUM(salary) AS total_salary,
       AVG(salary) AS average_salary
FROM employees;

-- 7. Write a query to get the number of employees with the same job.
SELECT job_id, COUNT(*) AS number_of_employees FROM employees
GROUP BY job_id;

-- 8. Write a query to get the difference between the highest and lowest salaries.
SELECT MAX(salary) - MIN(salary) AS salary_difference
FROM employees;

-- 9. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager.
SELECT manager_id, MIN(salary) AS lowest_salary FROM employees WHERE manager_id IS NOT NULL
GROUP BY manager_id;

-- 10. Write a query to get the department ID and the total salary payable in each department.
SELECT department_id, SUM(salary) AS total_salary FROM employees
GROUP BY department_id;

-- 11. Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only.
SELECT job_id,
       SUM(salary) AS total_salary,
       MAX(salary) AS maximum_salary,
       MIN(salary) AS minimum_salary,
       AVG(salary) AS average_salary
FROM employees WHERE department_id = 90
GROUP BY job_id;
-- 12.Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000.
SELECT job_id, MAX(salary) AS maximum_salary FROM employees 
GROUP BY job_id
HAVING MAX(salary) >= 4000;

-- 13.Write a query to get the average salary for all departments employing more than 10 employees.
SELECT department_id, AVG(salary) AS average_salary FROM employees
GROUP BY department_id
HAVING COUNT(*) > 10;

-- 14. Retrieve the highest salary in each department.
SELECT department_id, MAX(salary) AS highest_salary
FROM employees
GROUP BY department_id;

-- 15. Retrieve the employee who has been working the longest in each department.
SELECT department_id, employee_id, first_name, last_name, hire_date
FROM employees e
WHERE hire_date = (SELECT MIN(hire_date) FROM employees WHERE department_id = e.department_id);
