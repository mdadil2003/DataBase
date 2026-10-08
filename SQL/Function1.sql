USE depar;

-- Q1. Write a query to display employee names in uppercase.
SELECT UPPER(first_name) AS employee_name
FROM employees;

-- Q2. Write a query to get the year for each employee was hired.
SELECT first_name, YEAR(hire_date) AS hire_year
FROM employees;

-- Q3. Write a query to display salaries with a comma separator (e.g., 88,000.00 instead of 88000.00).
SELECT first_name, FORMAT(salary, 2) AS formatted_salary
FROM employees;

-- Q4. Write a query to mask employee email addresses, showing only the domain.
SELECT CONCAT('***@', SUBSTRING_INDEX(email, '@', -1)) AS masked_email
FROM employees;

-- Q5. Write a query to display only the last four digits of employees' phone numbers.
SELECT first_name, RIGHT(phone_number, 4) AS last_four_digits
FROM employees;

-- Q6. Write a query to display the length of each employee's full name.
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
       LENGTH(CONCAT(first_name, ' ', last_name)) AS name_length
FROM employees;

-- Q7. Write a query to find employees hired before the year 1989.
SELECT first_name, last_name, hire_date
FROM employees
WHERE YEAR(hire_date) < 1989;

-- Q8. Write a query to round employee salaries to the nearest thousand.
SELECT first_name, salary,
       ROUND(salary, -3) AS rounded_salary
FROM employees;

-- Q9. Write a query to display the hire date in ‘Monday, June 23, 2015’ format.
SELECT first_name, last_name,
       DATE_FORMAT(hire_date, '%W, %M %d, %Y') AS formatted_hire_date
FROM employees;

-- Q10. Write a query to update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'.
SELECT REPLACE(phone_number, '124', '999') AS phone_number
FROM employees;

-- Q11.Write a query to get the details of the employees where the length of the first name greater than or equal to 8.
SELECT * FROM employees 
WHERE length(first_name) >= 8;

-- Q12. Write a query to display leading zeros before maximum and minimum salary.
SELECT LPAD(MAX(salary), 8, '0') AS maximum_salary, LPAD(MIN(salary), 8, '0') AS minimum_salary
FROM employees;

-- Q13. Write a query to append '@example.com' to email field.
SELECT CONCAT(email, '@example.com') AS new_email
FROM employees;

-- Q14. Write a query to get the employee id, first name and hire month.
SELECT employee_id, first_name, MONTH(hire_date) AS hire_month
FROM employees;

-- Q15. Write a query to get the employee id, email id (discard the last three characters).
SELECT employee_id, LEFT(email, LENGTH(email) - 3) AS email_id
FROM employees;

-- Q16. Write a query to find all employees where first names are in upper case.
SELECT * FROM employees
WHERE first_name = UPPER(first_name);

-- Q17. Write a query to extract the last 4 character of phone numbers.
SELECT employee_id, phone_number, RIGHT(phone_number, 4) AS last_4_digits
FROM employees;

-- Q18. Write a query to get the last word of the street address.
SELECT location_id, street_address,SUBSTRING_INDEX(street_address, ' ', -1) AS last_word
FROM locations;




