 USE depar;
 
 -- 1.Write a query to display the first day of the month (in datetime format) three months before the  current month.
 SELECT DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 3 MONTH),'%Y-%m-01 00:00:00') 
 AS first_day;

 -- 2.Write a query to display the last day of the month (in datetime format) three months before the current month.
 SELECT LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 3 MONTH)) 
 AS last_day;

 -- 3.Write a query to get the distinct Mondays from hire_date in employees tables.
SELECT DISTINCT hire_date
FROM employees
WHERE DAYNAME(hire_date) = 'Monday';

-- 4.Write a query to get the first day of the current year.
SELECT MAKEDATE(YEAR(CURDATE()), 1) AS first_day_of_year;

-- 5. Write a query to get the last day of the current year.
SELECT LAST_DAY(
    CONCAT(YEAR(CURDATE()), '-12-01')
) AS last_day_of_year;

-- 6. Write a query to calculate the age in year.
SELECT first_name,
       TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS years_worked
FROM employees;

-- 8. Write a query to extract the year from the current date.
SELECT YEAR(CURDATE()) AS current_year;

-- 9.Write a query to get the DATE value from a given day (number in N). 
-- Sample days: 730677
-- Output : 2000-07-11

-- 10. Write a query to get the firstname, lastname who joined in the month of June.
SELECT first_name, last_name
FROM employees
WHERE MONTH(hire_date) = 6;

-- 11. Write a query to get the years in which more than 10 employees joined
SELECT YEAR(hire_date) AS hire_year,
       COUNT(*) AS employee_count
FROM employees
GROUP BY YEAR(hire_date)
HAVING COUNT(*) > 10;
