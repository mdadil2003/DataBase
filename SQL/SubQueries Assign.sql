use depar;

-- 1. Write a query to display the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 206.
SELECT first_name, last_name
FROM employees
WHERE salary > (SELECT salary FROM employees WHERE employee_id = 206);

-- 2. Write a query to display the name ( first name and last name ), salary, department id, job id for those employees who works in the same designation as the employee works whose id is 203.
SELECT first_name,last_name,salary,department_id,job_id FROM employees
WHERE job_id = (SELECT job_id FROM employees WHERE employee_id = 203);

-- 3.Write a query to display the name ( first name and last name ), salary, department id for those employees who earn such amount of salary which is the smallest salary of any of the departments.
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary IN (
    SELECT MIN(salary)
    FROM employees
    GROUP BY department_id
);

-- 4. Write a query to display the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.  
SELECT employee_id,first_name, last_name
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
-- 5. Write a query to display the employee name ( first name and last name ), employee id and salary of all employees who report to 'Pataballa'.
SELECT employee_id,first_name,last_name,salary
FROM employees
WHERE manager_id = (
    SELECT employee_id
    FROM employees
    WHERE last_name = 'Pataballa'
);

-- 6.  Write a query to display the department number, name ( first name and last name ), job and department name for all employees in the Finance department.  
SELECT e.department_id,e.first_name,e.last_name,j.job_title,d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN jobs j ON e.job_id = j.job_id
WHERE d.department_name = 'Finance';

-- 7. Write a query to display all the information of an employee whose salary and reporting person id is 3000 and 121 respectively.  
SELECT * FROM employees
WHERE salary = 3000 AND manager_id = 121;
  
-- 8. Display all the information of an employee whose id is any of the number 134, 159 and 183.
SELECT * FROM employees
WHERE employee_id IN (134, 159, 183);

-- 9.  Write a query to display all the information of the employees whose salary is within the range 1000 and 3000.
SELECT * FROM employees
WHERE salary BETWEEN 1000 AND 3000;

-- 10. Write a query to display all the information of the employees whose salary is within the range of smallest salary and 5000. 
SELECT * FROM employees
WHERE salary BETWEEN (SELECT MIN(salary)FROM employees) AND 5000;

-- 11. Write a query to display all the information of the employees who does not work in those departments where some employees works whose manager id within the range 100 and 200.
SELECT * FROM employees
WHERE department_id NOT IN (
    SELECT DISTINCT department_id
    FROM employees
    WHERE manager_id BETWEEN 100 AND 200 AND department_id IS NOT NULL);
-- 12. Write a query to display all the information for those employees whose id is any id who earn the second highest salary.
SELECT * FROM employees
WHERE salary = (SELECT MAX(salary)FROM employees WHERE salary < (SELECT MAX(salary)FROM employees));

-- 13. Write a query to display the employee name( first name and last name ) and hiredate for all employees in the same department as Neena. Exclude Neena.
SELECT first_name,last_name,hire_date FROM employees
WHERE department_id IN (SELECT department_id FROM employees WHERE first_name = 'Neena')
AND first_name <> 'Neena';

-- 14. Write a query to display the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T. 
SELECT employee_id,first_name,last_name FROM employees
WHERE department_id IN (SELECT DISTINCT department_id FROM employees WHERE CONCAT(first_name, ' ', last_name) LIKE '%T%' 
AND department_id IS NOT NULL);

-- 15. Write a query to display the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.
SELECT employee_id,first_name,last_name,salary
FROM employees WHERE salary > (SELECT AVG(salary)FROM employees)
AND department_id IN (SELECT DISTINCT department_id FROM employees WHERE CONCAT(first_name, ' ', last_name) LIKE '%J%'
      AND department_id IS NOT NULL);
      
-- 16. Display the employee name( first name and last name ), employee id, and job title for all employees whose department location is Toronto.
SELECT e.first_name,e.last_name,e.employee_id,j.job_title
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN jobs j ON e.job_id = j.job_id
WHERE l.city = 'Toronto';

-- 17. Write a query to display the employee number, name( first name and last name ) and job id for all employees whose salary is more than any average salary of any department.
SELECT employee_id,first_name,last_name,job_id FROM employees
WHERE salary > ANY (SELECT AVG(salary)FROM employees GROUP BY department_id);

-- 18.Write a query to display the employee name( first name and last name ) and department for all employees for any existence of those employees whose salary is more than 3700.  
SELECT e.first_name,e.last_name,d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE EXISTS (SELECT 1 FROM employees WHERE salary > 3700);
