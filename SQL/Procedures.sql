USE depar;

-- Q1. Write a procedure check_even_odd(IN num INT) that prints 'Even' or 'Odd'.
DELIMITER //
CREATE PROCEDURE check_even_odd(IN num INT)
BEGIN
    IF MOD(num, 2) = 0 THEN
        SELECT 'Even' AS Result;
    ELSE
        SELECT 'Odd' AS Result;
    END IF;
END //
DELIMITER ;
CALL check_even_odd(10);
CALL check_even_odd(7);

-- Q2. Create a procedure calc_factorial(IN n INT) that prints the factorial of n.
DELIMITER //
CREATE PROCEDURE calc_factorial(IN n INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE fact BIGINT DEFAULT 1;
    IF n < 0 THEN
        SELECT 'Factorial is not defined for negative numbers' AS Result;
    ELSE
        WHILE i <= n DO
            SET fact = fact * i;
            SET i = i + 1;
        END WHILE;
        SELECT fact AS Factorial;
    END IF;
END //
DELIMITER ;
call calc_factorial(7);
call calc_factorial(-2);
call calc_factorial(0);

/* Q3. Create a procedure get_grade(IN marks INT) that prints:
•	'A' if marks ≥ 90
•	'B' if marks ≥ 75
•	'C' if marks ≥ 60
•	'D' if marks ≥ 40
•	'F' otherwise */
DELIMITER //
CREATE PROCEDURE get_grade(IN marks INT)
BEGIN
    IF marks >= 90 THEN
        SELECT 'A' AS Grade;
    ELSEIF marks >= 75 THEN
        SELECT 'B' AS Grade;
    ELSEIF marks >= 60 THEN
        SELECT 'C' AS Grade;
    ELSEIF marks >= 40 THEN
        SELECT 'D' AS Grade;
    ELSE
        SELECT 'F' AS Grade;
    END IF;
END //
DELIMITER ;
call get_grade(95);
call get_grade(77);
call get_grade(65);
call get_grade(50);
call get_grade(30);

-- Q4. Create a procedure add_student(IN name VARCHAR(50), IN marks INT) that inserts the student into a table students(id, name, marks).
use cdac;

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
CALL add_student('Adil', 85);
CALL add_student('Amit', 92);
CALL add_student('Neha', 76);

-- Q5. Create a procedure multiplication_table(IN num INT) that prints the multiplication table (1 to 10) of num.
DELIMITER //
CREATE PROCEDURE multiplication_table(IN num INT)
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 10 DO
        SELECT CONCAT(num, ' x ', i, ' = ', num * i) AS Result;

        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;
CALL multiplication_table(10);
-- Q6. Create a procedure average_marks() that calculates and prints the average marks from the students table.
use depar;
DELIMITER //
CREATE PROCEDURE average_marks()
BEGIN
    SELECT AVG(marks) AS Average_Marks
    FROM students;
END //
DELIMITER ;
CALL average_marks();

-- Q7. Create a procedure swap_numbers(INOUT a INT, INOUT b INT) that swaps the values of a and b.
USE depar;

DELIMITER //
CREATE PROCEDURE swap_numbers(
    INOUT a INT,
    INOUT b INT
)
BEGIN
    DECLARE temp INT;

    SET temp = a;
    SET a = b;
    SET b = temp;
END //
DELIMITER ;
SET @a = 10;
SET @b = 20;
CALL swap_numbers(@a, @b);
SELECT @a AS a, @b AS b;

/* Q8. Create a procedure apply_discount(IN discount_percent INT, INOUT total_price DECIMAL(10,2)) that:
•	Applies discount to total_price`
•	Modifies total_price to the new value */
DELIMITER //
CREATE PROCEDURE apply_discount(
    IN discount_percent INT,
    INOUT total_price DECIMAL(10,2)
)
BEGIN
    SET total_price =
        total_price - (total_price * discount_percent / 100);
END //
DELIMITER ;

SET @price = 1000.00;
CALL apply_discount(10, @price);
SELECT @price AS Final_Price;
