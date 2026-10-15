use depar;

/*
Q1. Write a stored procedure check_number(IN num INT) that:
•	Prints 'Positive' if num > 0
•	'Negative' if num < 0
•	'Zero' otherwise
*/

DELIMITER //

CREATE PROCEDURE check_number(IN num INT)
BEGIN
    IF num > 0 THEN
        SELECT 'Positive' AS Result;
    ELSEIF num < 0 THEN
        SELECT 'Negative' AS Result;
    ELSE
        SELECT 'Zero' AS Result;
    END IF;
END //
CALL check_number(10);
CALL check_number(-5);
CALL check_number(0);

SHOW PROCEDURE STATUS
WHERE Db = 'depar'
AND Name = 'check_number';

/*
Q2. Create a stored procedure that accepts a score and returns:
•	'Excellent' if score ≥ 90
•	'Good' if score ≥ 75
•	'Average' if score ≥ 50
•	'Fail' otherwise
*/
DELIMITER $$

CREATE PROCEDURE check_score(IN score INT)
BEGIN
    IF score >= 90 THEN
        SELECT 'Excellent' AS Result;
    ELSEIF score >= 75 THEN
        SELECT 'Good' AS Result;
    ELSEIF score >= 50 THEN
        SELECT 'Average' AS Result;
    ELSE
        SELECT 'Fail' AS Result;
    END IF;
END $$

CALL check_score(95);	
CALL check_score(80);
CALL check_score(60);
CALL check_score(35);

/*
Q3. Create a procedure  based on the orders table. 
If the order amount is over 10000, set status to 'VIP', else 'Normal'.
Assume table structure:
orders(id, customer_name, amount, status)
*/
CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    amount DECIMAL(10,2),
    status VARCHAR(20)
);
DELIMITER //

CREATE PROCEDURE check_order_status(IN order_id INT)
BEGIN
    UPDATE orders
    SET status = IF(amount > 10000, 'VIP', 'Normal')
    WHERE id = order_id;
END //

DELIMITER ;
INSERT INTO orders (id, customer_name, amount, status)
VALUES
(1, 'Amit', 15000, NULL),
(2, 'Neha', 8000, NULL),
(3, 'Raj', 10000, NULL);
CALL check_order_status(1);
CALL check_order_status(2);
CALL check_order_status(3);
SELECT * FROM orders;

-- Q4. Write a procedure to input a year and check whether it's a leap year or not.
DELIMITER //

CREATE PROCEDURE check_leap_year(IN yr INT)
BEGIN
    IF (yr % 400 = 0) OR (yr % 4 = 0 AND yr % 100 <> 0) THEN
        SELECT 'Leap Year' AS Result;
    ELSE
        SELECT 'Not a Leap Year' AS Result;
    END IF;
END //
CALL check_leap_year(2024);
CALL check_leap_year(2023);
CALL check_leap_year(2000);
-- Q5. . Write a procedure to accept a character from the user and check if it is a vowel or consonant.
DELIMITER //

CREATE PROCEDURE check_character(IN ch CHAR(1))
BEGIN
    IF LOWER(ch) IN ('a', 'e', 'i', 'o', 'u') THEN
        SELECT 'Vowel' AS Result;
    ELSE
        SELECT 'Consonant' AS Result;
    END IF;
END //

DELIMITER ;
CALL check_character('a');
CALL check_character('E');
CALL check_character('b');
