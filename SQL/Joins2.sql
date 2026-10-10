use depar;

-- salesman Table
/* 
salesman_id	 salesman_name	city	commission
	1			John	  New York	    0.15
	2			Alice	  London	  	0.12
	3			Bob	   	  Paris		    0.10
	4			David	  Berlin		0.08
*/
CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    salesman_name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(4,2)
);
INSERT INTO salesman (salesman_id, salesman_name, city, commission)
VALUES (1, 'John', 'New York', 0.15), (2, 'Alice', 'London', 0.12), (3, 'Bob', 'Paris', 0.10), (4, 'David', 'Berlin', 0.08);
select * from salesman;
			
-- customer Table
/*
customer_id	 customer_name	  city	   grade   salesman_id
	101			Sam			New York	2			1
	102			Eva			London		1			2
	103			Charlie		Paris		3			3
	104			Daniel		Berlin		2			4
	105			Steve		New York	1			1
*/
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT
);
INSERT INTO customer
(customer_id, customer_name, city, grade, salesman_id)
VALUES (101, 'Sam', 'New York', 2, 1), (102, 'Eva', 'London', 1, 2), (103, 'Charlie', 'Paris', 3, 3), (104, 'Daniel', 'Berlin', 2, 4), (105, 'Steve', 'New York', 1, 1);
select * from customer;


-- orders Table
/*
order_id	order_date	amount	customer_id	salesman_id
5001		2024-01-15	1000.00		101			1
5002		2024-02-20	1500.00		102			2
5003		2024-03-10	2000.00		103			3
5004		2024-04-05	1200.00		104			4
5005		2024-05-15	2500.00		101			1
*/
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(10,2),
    customer_id INT,
    salesman_id INT
);
INSERT INTO orders
(order_id, order_date, amount, customer_id, salesman_id)
VALUES (5001, '2024-01-15', 1000.00, 101, 1),(5002, '2024-02-20', 1500.00, 102, 2),(5003, '2024-03-10', 2000.00, 103, 3),(5004, '2024-04-05', 1200.00, 104, 4),(5005, '2024-05-15', 2500.00, 101, 1);
select * from orders;

-- 1.	Retrieve all orders with customer names and salesman names.
SELECT o.order_id,o.order_date,o.amount,c.customer_name,s.salesman_name FROM orders o
JOIN customer c
    ON o.customer_id = c.customer_id
JOIN salesman s
    ON o.salesman_id = s.salesman_id;
    
-- 2.	Find all customers along with their salesmen details.
SELECT c.customer_id,c.customer_name,c.city,c.grade,s.salesman_id,s.salesman_name,s.city AS salesman_city,s.commission
FROM customer c
JOIN salesman s
    ON c.salesman_id = s.salesman_id;
    
-- 3.	List all orders and include customers who haven’t placed any orders.
SELECT c.customer_id,c.customer_name,o.order_id,o.order_date,o.amount
FROM customer c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id;
    
-- 4.	List all salesmen and the customers they handle (including salesmen with no customers).
SELECT s.salesman_id,s.salesman_name,s.city,c.customer_id,c.customer_name
FROM salesman s
LEFT JOIN customer c
    ON s.salesman_id = c.salesman_id;
    
-- 5.	Find customers who have placed orders worth more than $2000.
SELECT DISTINCT c.customer_id,c.customer_name
FROM customer c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.amount > 2000;

-- 6.	Find the total sales made by each salesman.
SELECT s.salesman_id,s.salesman_name, SUM(o.amount) AS total_sales
FROM salesman s
JOIN orders o
    ON s.salesman_id = o.salesman_id
GROUP BY s.salesman_id, s.salesman_name;

-- 7.	Find the highest order placed by each customer.
SELECT c.customer_id,c.customer_name, MAX(o.amount) AS highest_order
FROM customer c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 8.	Retrieve all customers who haven’t placed any orders.
SELECT c.customer_id,
       c.customer_name,
       c.city
FROM customer c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 9.	Find the total number of orders placed by each customer.
SELECT c.customer_id,c.customer_name, COUNT(o.order_id) AS total_orders
FROM customer c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 10.	Retrieve the commission earned by each salesman based on their orders.
SELECT s.salesman_id, s.salesman_name, SUM(o.amount) AS total_sales, s.commission, SUM(o.amount) * s.commission AS commission_earned
FROM salesman s JOIN orders o ON s.salesman_id = o.salesman_id
GROUP BY s.salesman_id, s.salesman_name, s.commission;
