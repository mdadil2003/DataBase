use cdac;

CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(4,2)
);
DESC salesman;
INSERT INTO salesman
    (salesman_id, name, city, commission)
VALUES
    (5001, 'James Hoog', 'New York', 0.15),
    (5002, 'Nail Knite', 'Paris', 0.13),
    (5005, 'Pit Alex', 'London', 0.11),
    (5006, 'Mc Lyon', 'Paris', 0.14),
    (5003, 'LausonHen', 'San Jose', 0.12),
    (5007, 'Paul Adam', 'Rome', 0.13);
select * from salesman;

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT,
    FOREIGN KEY (salesman_id)
        REFERENCES salesman(salesman_id)
);
DESC salesman;

INSERT INTO customer
    (customer_id, cust_name, city, grade, salesman_id)
VALUES
    (3002, 'Nick Rimando', 'New York', 100, 5001),
    (3005, 'Graham Zusi', 'California', 200, 5002),
    (3001, 'Brad Guzan', 'London', 100, 5005),
    (3004, 'Fabian Johns', 'Paris', 300, 5006),
    (3007, 'Brad Davis', 'New York', 200, 5001),
    (3009, 'Geoff Camero', 'Berlin', 100, 5003),
    (3008, 'Julian Green', 'London', 300, 5002),
    (3003, 'Jozy Altidor', 'Moncow', 200, 5007);
select * from customer;

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT,
    FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),
    FOREIGN KEY (salesman_id)
        REFERENCES salesman(salesman_id)
);
desc orders;

INSERT INTO orders
    (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
    (70001, 150.50, '2012-10-05', 3005, 5002),
    (70009, 270.65, '2012-09-10', 3001, 5005),
    (70002, 65.26, '2012-10-05', 3002, 5001),
    (70004, 110.50, '2012-08-17', 3009, 5003),
    (70007, 948.50, '2012-09-10', 3005, 5002),
    (70005, 2400.60, '2012-07-27', 3007, 5001),
    (70008, 5760.00, '2012-09-10', 3002, 5001),
    (70010, 1983.43, '2012-10-10', 3004, 5006),
    (70003, 2480.40, '2012-10-10', 3009, 5003),
    (70012, 250.45, '2012-06-27', 3008, 5002),
    (70011, 75.29, '2012-08-17', 3003, 5007),
    (70013, 3045.60, '2012-04-25', 3002, 5001);
select * from orders;

use depar;

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);
desc student;

CREATE TABLE Employeess (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);
desc Employeess;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) UNIQUE
);
desc users;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2),
    status VARCHAR(20) DEFAULT 'Available'
);

INSERT INTO products (product_id, product_name, price)
VALUES (101, 'Laptop', 55000.00);
SELECT * FROM products;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE
);
desc students;

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL
);
desc courses;

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE DEFAULT (CURRENT_DATE),

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
);
desc enrollments;

INSERT INTO students (student_id, name, email)
VALUES (101, 'Adil', 'adil@example.com');
SELECT * FROM students;

INSERT INTO courses (course_id, course_name)
VALUES (201, 'Database Management');
SELECT * FROM courses;

INSERT INTO enrollments (student_id, course_id)
VALUES (101, 201);
SELECT * FROM enrollments;
