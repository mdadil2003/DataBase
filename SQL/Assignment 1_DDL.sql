create database CDAC;
use cdac;

-- Q1. Create DEPT Table
create table dept(
deptno int primary key,
deptname varchar(20),
loc int
);
DESC DEPT;

-- Q2. Create LOCATIONS Table
CREATE TABLE LOCATIONS(
    Loc INT,
    Name VARCHAR(50)
);
DESC LOCATIONS;

-- Q3. Add city column in LOCATIONS table

ALTER TABLE LOCATIONS
ADD city VARCHAR(50);

DESC LOCATIONS;

-- Q4. Modify datatype and size of salary in employees table
create table employees(
empname varchar(20),
sal int
);
desc employees;

alter table employees modify sal decimal(10,2);

-- Q5. Create SALGRADE Table
CREATE TABLE SALGRADE(
    HISAL INT,
    LOSAL INT,
    GRADE CHAR(1)
);
DESC SALGRADE;

-- Q6. Create Student Table
CREATE TABLE Student(
    student_id INT,
    student_name VARCHAR(60),
    gender CHAR(1),
    age INT,
    email VARCHAR(100),
    dept_id INT
);
DESC Student;

-- Q7. Create Course Table
CREATE TABLE Course(
    course_id INT,
    course_name VARCHAR(100),
    duration INT,
    fees DECIMAL(10,2),
    dept_id INT
);
DESC Course;

-- Q8. Add phone column to Student table
ALTER TABLE Student
ADD phone VARCHAR(15);
DESC Student;

-- Q9. Add date_of_birth column
ALTER TABLE Student
ADD date_of_birth DATE;
DESC Student;

-- Q11. Modify student_name size from VARCHAR(60) to VARCHAR(100)
ALTER TABLE Student
MODIFY student_name VARCHAR(100);
DESC Student;

-- Q12. Modify phone column to VARCHAR(20)
ALTER TABLE Student
MODIFY phone VARCHAR(20);
DESC Student;

-- Q13. Rename phone column to mobile_no
ALTER TABLE Student
RENAME COLUMN phone TO mobile_no;
DESC Student;

-- Q14. Rename Student table to Students
ALTER TABLE Student
RENAME TO Students;
SHOW TABLES;