use depar;

-- Q1. Write a procedure to input a number N and print the sum of first N numbers.
DELIMITER // 
CREATE PROCEDURE SumNumbers(IN n INT) 
BEGIN 
DECLARE i INT DEFAULT 1; 
DECLARE total INT DEFAULT 0; 
WHILE i <= n DO 
SET total = total + i; 
SET i = i + 1; 
END WHILE;
SELECT total AS Sum; 
END // 
DELIMITER ; 
CALL SumNumbers(5);

-- Q2. Write a procedure to input a number and print its multiplication table (1 to 10).
DELIMITER // 
CREATE PROCEDURE MultiplicationTable(IN n INT) 
BEGIN 
DECLARE i INT DEFAULT 1; 
WHILE i <= 10 DO 
SELECT CONCAT(n, ' x ', i, ' = ', n * i) AS Result; 
SET i = i + 1; 
END WHILE; 
END // 
DELIMITER ; 
CALL MultiplicationTable(5);

-- Q3. Write a procedure to input a number and find its factorial using a loop.
DELIMITER // 
CREATE PROCEDURE FindFactorial(IN n INT) 
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
CALL FindFactorial(5); -- 120
CALL FindFactorial(4);  -- 24
CALL FindFactorial(0);  -- 1
CALL FindFactorial(-2); -- Error message as a result

-- Q4. Write a procedure to input a number and reverse its digits. Example: 123 → 321.
DELIMITER //
CREATE PROCEDURE reverse_number(IN n INT)
BEGIN
    DECLARE num INT;
    DECLARE rev BIGINT DEFAULT 0;
    DECLARE digit INT;
    SET num = n;
    IF num < 0 THEN
        SET num = -num;
    END IF;
    WHILE num > 0 DO
        SET digit = MOD(num, 10);
        SET rev = rev * 10 + digit;
        SET num = num DIV 10;
    END WHILE;

    IF n < 0 THEN
        SET rev = -rev;
    END IF;
    SELECT rev AS Reversed_Number;
END //
DELIMITER ;

CALL reverse_number(123);
CALL reverse_number(450);

-- Q5. Write a procedure to print the first n terms of the Fibonacci sequence.
DELIMITER //
CREATE PROCEDURE fibonacci(IN n INT)
BEGIN
    DECLARE a BIGINT DEFAULT 0;
    DECLARE b BIGINT DEFAULT 1;
    DECLARE temp BIGINT;
    DECLARE i INT DEFAULT 1;
    DECLARE result VARCHAR(4000) DEFAULT '';
    IF n <= 0 THEN
        SELECT 'Enter a positive number of terms' AS Result;
    ELSE
        WHILE i <= n DO
            SET result = CONCAT(result, a);
            IF i < n THEN
                SET result = CONCAT(result, ', ');
            END IF;
            SET temp = a + b;
            SET a = b;
            SET b = temp;
            SET i = i + 1;
        END WHILE;
        SELECT result AS Fibonacci_Sequence;
    END IF;
END //

DELIMITER ;
CALL fibonacci(7);

-- Q6. Write a procedure to input a number and check whether it is prime or not using a loop.
DELIMITER //
CREATE PROCEDURE check_prime(IN n INT)
BEGIN
    DECLARE i INT DEFAULT 2;
    DECLARE is_prime INT DEFAULT 1;

    IF n < 2 THEN
        SET is_prime = 0;
    ELSE
        prime_loop: WHILE i * i <= n DO

            IF MOD(n, i) = 0 THEN
                SET is_prime = 0;
                LEAVE prime_loop;
            END IF;

            SET i = i + 1;

        END WHILE prime_loop;
    END IF;
    IF is_prime = 1 THEN
        SELECT 'Prime Number' AS Result;
    ELSE
        SELECT 'Not a Prime Number' AS Result;
    END IF;
END //
DELIMITER ;

CALL check_prime(7); -- Prime Number
CALL check_prime(10); -- Not a Prime Number

