use depar;

CREATE TABLE emp ( emp_id INT PRIMARY KEY, emp_name VARCHAR(50), joining_date DATE, birth_date DATE, salary DECIMAL(10,2) );
INSERT INTO emp VALUES 
(101, 'Amit', '2020-05-15', '1995-08-20', 55000), 
(102, 'Neha', '2019-03-10', '1993-12-05', 62000), 
(103, 'Raj', '2021-11-25', '1998-06-15', 48000), 
(104, 'Priya','2018-07-01', '1992-02-28', 75000), 
(105, 'Karan','2022-01-20', '1997-10-10', 51000);

-- 1.	Display all employees along with their joining dates. 
SELECT emp_id, emp_name, joining_date
FROM emp;

-- 2.	Display the current date along with every employee's name. 
SELECT emp_name, CURDATE() AS today_date
FROM emp;

-- 3.	Display the year in which each employee joined the organization. 
SELECT emp_id, emp_name, YEAR(joining_date) AS joining_year
FROM emp;

-- 4.	Display the month number of each employee's joining date. 
SELECT emp_id, emp_name, MONTH(joining_date) AS joining_month
FROM emp;

-- 5.	Display the month name of each employee's joining date. 
SELECT emp_id, emp_name, MONTHNAME(joining_date) AS joining_month
FROM emp;

-- 6.	Display each employee's date of birth and the corresponding day of the week. 
SELECT emp_id,emp_name,birth_date, DAYNAME(birth_date) AS birth_day
FROM emp;

-- 7.	Calculate the number of days each employee has worked since joining. 
SELECT emp_id,emp_name,joining_date, DATEDIFF(CURDATE(), joining_date) AS days_worked
FROM emp;

-- 8.	Calculate the number of years each employee has worked in the organization. 
SELECT emp_id,emp_name,joining_date, TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) AS years_worked
FROM emp;

-- 9.	Display employees who joined before 2020-01-01. 
SELECT emp_id, emp_name, joining_date
FROM emp
WHERE joining_date < '2020-01-01';

-- 10.	Display employees who joined after 2020-01-01. 
SELECT emp_id, emp_name, joining_date FROM emp
WHERE joining_date > '2020-01-01';

-- 11.	Display employees who joined in the year 2021. 
SELECT emp_id, emp_name, joining_date
FROM emp
WHERE YEAR(joining_date) = 2021;
-- 12.	Display employees who joined during the month of May. 
SELECT emp_id, emp_name, joining_date
FROM emp
WHERE MONTH(joining_date) = 5;

-- 13.	Display the age of every employee in years. 
SELECT emp_id,emp_name,birth_date, TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age
FROM emp;

-- 14.	Find employees whose birthday falls in December. 
SELECT emp_id, emp_name, birth_date
FROM emp
WHERE MONTH(birth_date) = 12;

-- 15.	Display employee names and their birthdays in the following format:  
--      Amit - 20-August-1995 
SELECT CONCAT(emp_name,' - ', DATE_FORMAT(birth_date, '%d-%M-%Y')) AS employee_birthday
FROM emp;

-- 16.	Add 30 days to each employee's joining date. 
SELECT emp_id,emp_name,joining_date, DATE_ADD(joining_date, INTERVAL 30 DAY) AS new_date
FROM emp;

-- 17.	Subtract 90 days from each employee's joining date. 
SELECT emp_id,emp_name,joining_date, DATE_SUB(joining_date, INTERVAL 90 DAY) AS new_date
FROM emp;

-- 18.	Display the date on which each employee completes 5 years in the organization. 
SELECT emp_id,emp_name,joining_date, DATE_ADD(joining_date, INTERVAL 5 YEAR) AS completion_date
FROM emp;
-- 19.	Find the number of days between an employee's birth date and joining date. 
SELECT emp_id,emp_name,birth_date,joining_date, DATEDIFF(joining_date, birth_date) AS days_difference
FROM emp;

-- 20.	Display employees whose joining date is within the last 5 years. 
SELECT emp_id,emp_name,joining_date FROM emp
WHERE joining_date >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

-- 21.	Find the employee with the earliest joining date. 
SELECT emp_id, emp_name, joining_date
FROM emp
ORDER BY joining_date ASC
LIMIT 1;

-- 22.	Find the employee with the latest joining date. 
SELECT emp_id, emp_name, joining_date FROM emp ORDER BY joining_date DESC LIMIT 1;

-- 23.	Display the total number of employees who joined in each year. 
SELECT YEAR(joining_date) AS joining_year, COUNT(*) AS total_employees FROM emp
GROUP BY YEAR(joining_date)
ORDER BY joining_year;

-- 24.	Display the number of employees who joined in each month. 


-- 25.	Display the average number of years employees have worked in the organization. 
-- 26.	Display employees who have completed more than 5 years of service. 
-- 27.	Display employees whose birthday is within the next 30 days. 
-- 28.	Find the number of employees born in each year. 
-- 29.	Display the employee name, joining date, and: 
-- Year 
-- Month name 
-- Day 
-- 30.	Day of week 
-- 31.	Display employee details sorted according to joining date, from oldest to newest. 
-- 32.	Display employee details sorted according to joining date, from newest to oldest. 
-- 33.	Find the employee who has the longest service period. 
-- 34.	Find the employee who has the shortest service period. 
-- 35.	Display employees who joined on a Monday. 
-- 36.	Display employees whose joining date falls on a weekend.

