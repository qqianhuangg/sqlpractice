DROP TABLE student;

CREATE TABLE student(
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20),
    major VARCHAR(20) DEFAULT 'UNKNOWN' 
);

INSERT INTO student(name, major) VALUES('JACK','biology');
INSERT INTO student(name, major) VALUES('kate','sociology');
INSERT INTO student(name, major) VALUES('Jim','cs');
INSERT INTO student(name, major) VALUES('Jane','art');
INSERT INTO student(name, major) VALUES('joe','history');


SELECT*
FROM student;

SELECT*
FROM student
WHERE major IN('biology', 'cs') AND student_id > 1;


UPDATE student 
SET major = 'unknown';

--delete all values in the table---
DELETE FROM student;

----------------------------------------------------
DROP TABLE works_with;
DROP TABLE client;
DROP TABLE branch_supplier;
DROP TABLE branch;
DROP TABLE employee;


CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

SELECT * FROM employee;
DELETE FROM employee;
DELETE FROM branch;

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

SELECT * FROM branch;

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

SELECT*
FROM employee;


CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

SELECT * FROM client;


CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

SELECT * FROM works_with;


CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

SELECT * FROM branch_supplier;
-- -----------------------------------------------------------------------------

-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);
SELECT * FROM employee;

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');
SELECT  * FROM branch;

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

UPDATE employee
SET sex = 'F'
WHERE emp_id = 107;

SELECT * FROM employee;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

SELECT * FROM employee;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

SELECT * FROM employee;


-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Labels', 'Custom Forms');

SELECT * FROM branch_supplier;
-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

SELECT * FROM client;

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

SELECT * FROM works_with;

-- find all employees ordered by salary--
SELECT * FROM employee ORDER BY salary DESC;
 
--find all employees ordered by sex then name--
SELECT * FROM employee ORDER BY sex, first_name, last_name LIMIT 5;

--first 5 employees in the table
SELECT * FROM employee LIMIT 5;

--find the first and last names of all employees--
SELECT first_name, last_name FROM employee;

--find the forename and surnames of all employees--
SELECT first_name as forename, last_name as surname 
FROM employee;

--find all the different genders--
SELECT DISTINCT branch_id FROM employee;


---SQL functions---
--1. find the number of employees--
SELECT COUNT (emp_id) 
FROM employee;

--2.how many PEOPLE HAVE supervisors--
SELECT COUNT(super_id)
FROM employee;

--how many unique supervisors---
SELECT COUNT(DISTINCT super_id) AS 'supervisor id'
FROM employee;

--3.female employees born after 1970
SELECT emp_id, first_name, last_name
FROM employee
WHERE sex = 'F' AND birth_day > '1970-01-01';

--4.average of all employees' salaries
SELECT AVG(salary) AS 'Average Salary'
FROM employee;

--average salary of employee born after 1970
SELECT AVG(salary)
FROM employee
WHERE birth_day > '1970-01-01';

--select salary of all female employees who were born after 1970
SELECT salary, first_name, last_name, birth_day
FROM employee
WHERE birth_day > '1970-01-01' AND sex = 'F';

--5.average salary of all males
SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

--6. sum of all salaries
SELECT SUM(salary)
FROM employee;

--sum of salaries of male employees who were born after 1970--
SELECT SUM(salary) AS 'young male salary sum'
FROM employee
WHERE sex = 'M' AND birth_day > '1970-01-01';


--aggregation by salaries--
SELECT AVG(salary), sex
FROM employee
GROUP BY sex;

--7.aggregation: how many males and how many females--
SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

--how many males and females born after 1970
SELECT COUNT(sex), sex
FROM employee
WHERE birth_day > '1970-01-01'
GROUP BY sex;

--how many males and females who born before 1970 with salary beyond 70000--
SELECT AVG(salary), sex, COUNT(sex)
FROM employee
WHERE birth_day < '1970-01-01' AND salary > 70000
GROUP BY sex;

SELECT super_id
FROM employee;

--ALL clause exludes the NULL values of this column--
SELECT COUNT(ALL super_id)
FROM employee;

SELECT * FROM works_with;

--how many unique employees in the work with table--
SELECT COUNT( DISTINCT emp_id)
FROM works_with;


--find total sales of each salesperson
SELECT SUM(total_sales),emp_id
FROM works_with
GROUP BY emp_id;

--average sales of each salesperson--
SELECT AVG(total_sales), emp_id
FROM works_with
GROUP BY emp_id;

--find how much money each client spent with branch
SELECT SUM(total_sales), client_id
FROM works_with
GROUP BY client_id;

--find how much money each employee made
SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;


SELECT SUM(total_sales), client_id
FROM works_with
WHERE works_with.emp_id > 105
GROUP BY client_id;

SELECT*FROM works_with;
--any # cahracters, _= one character
--find any clients who are LLC--
SELECT *
FROM client
WHERE client_name LIKE '%LLC';

SELECT * FROM branch_supplier;
--ANY BRANCH SUPPLIERS WHO ARE IN LABEL BUSINESS--
SELECT * 
FROM branch_supplier
WHERE supplier_name LIKE '% Label%';

--find any clients who are schools--
SELECT *
FROM client
WHERE client_name LIKE '%school%';

SELECT* FROM employee;

SELECT AVG(salary),branch_id
FROM employee
GROUP BY branch_id;

SELECT emp_id, first_name, birth_day
FROM employee
Where sex = 'M'
ORDER BY birth_day DESC;

--find a list of employees and branch names-
--UNION connects all values together in one column--
SELECT first_name AS Name
FROM employee
UNION
SELECT branch_name
FROM branch
UNION
SELECT client_name
FROM client;

SELECT * FROM  client;
SELECT * FROM branch_supplier;

--a list of all clients and branch suppliers
SELECT client_name, client.branch_id 
FROM client
WHERE branch_id = 2
UNION
SELECT supplier_name, branch_supplier.branch_id
FROM branch_supplier
WHERE branch_id = 2;

SELECT * FROM employee;
SELECT * FROM works_with;
--find a list of all money spent or earned by the company--
SELECT salary 
FROM employee
UNION
SELECT total_sales
FROM works_with;

---sum of money earned per client---
SELECT SUM(total_sales) AS 'Total Sales', client_id AS 'Client ID'
FROM works_with
GROUP BY client_id;

--average money earned per client--
SELECT AVG(total_sales), client_id
FROM works_with
GROUP BY client_id;

--join----
INSERT INTO branch VALUES (4, 'Buffalo', NULL, NULL);
SELECT * FROM branch;
SELECT * FROM works_with;

--find all branches and their coorespondent branch managers--(general join by a shared column between two tables)
--only shared values between two tables will be returned. other unique values of each table would be dropped.
SELECT employee.emp_id, employee.first_name, employee.last_name, employee.salary, branch.branch_name
FROM employee
JOIN branch
ON employee.emp_id =  branch.mgr_id;

--join between employee and work with--
SELECT employee.emp_id, employee.first_name, employee.last_name, works_with.client_id, works_with.total_sales
FROM employee
JOIN works_with
ON employee.emp_id = works_with.emp_id;

SELECT * FROM works_with;

--left join: returns both common and unique values (both managers and non-managers are returned)--
--THE LEFT TABLE IS THE EMPLOYEE TABLE. ELEMENTS IN THE LEFT TABLE WILL ALL BE INCLUDED.
SELECT employee.emp_id, employee.first_name, employee.last_name, employee.salary, branch.branch_name
FROM employee
LEFT JOIN branch
ON employee.emp_id =  branch.mgr_id;

--left join from work with to employee. Keeps all values including the duplicates--
SELECT employee.emp_id, employee.first_name, employee.last_name, works_with.client_id, works_with.total_sales
FROM employee
LEFT JOIN works_with
ON employee.emp_id = works_with.emp_id;



--right join:--
--ALL ELEMENTS IN THE RIGHT TABLE (HERE IT IS BRANCH TABLE)
SELECT employee.emp_id, employee.first_name, employee.last_name, branch.branch_name
FROM employee
RIGHT JOIN branch
ON employee.emp_id =  branch.mgr_id;

--right join practice-- from employee to works with--
SELECT employee.emp_id, employee.first_name, employee.last_name, employee.birth_day, works_with.total_sales
FROM employee
RIGHT JOIN works_with
ON employee.emp_id = works_with.emp_id
WHERE employee.birth_day > '1970-01-01';


--nested queries--
 --finds names of all employees who have sold over 30,000 to a single client

SELECT employee.first_name, employee.last_name, salary
FROM employee 
WHERE employee.emp_id IN(
SELECT works_with.emp_id
FROM works_with
WHERE works_with.total_sales > 30000
);
--------

--find salaries of all female employees who have sold less than 50000 to one client--
SELECT employee.emp_id, employee.first_name, employee.salary
FROM employee 
WHERE employee.sex = 'F'
AND emp_id IN(
SELECT works_with.emp_id
FROM works_with
WHERE works_with.total_sales < 50000
);




SELECT * FROM works_with;
SELECT * FROM employee;


--PRACTICE: find names of all employees who were born after 1970 and have sold less than 50000 in total--


--solution 2. start from "born after 1970"--
SELECT employee.emp_id, employee.first_name, employee.last_name, employee.birth_day, SUM(works_with.total_sales) AS 'sum per salesperson'
FROM employee
RIGHT JOIN works_with
ON employee.emp_id = works_with.emp_id
WHERE employee.birth_day > '1970-01-01'
GROUP BY emp_id;



--find names and salary, birthday, of all female employees who made less than 50000 sales in total--
SELECT employee.emp_id, employee.first_name, employee.sex, SUM(works_with.total_sales) AS 'total sales', employee.salary, employee.birth_day
FROM employee
RIGHT JOIN works_with
ON employee.emp_id = works_with.emp_id
WHERE employee.sex = 'F'
GROUP BY emp_id;


--find names of all male employees who made less than 50000--
SELECT employee.emp_id, employee.first_name, employee.birth_day, employee.salary, SUM(works_with.total_sales) AS 'total sales made'
FROM employee
RIGHT JOIN works_with
ON employee.emp_id = works_with.emp_id
WHERE employee.sex = 'M'
GROUP BY emp_id;


SELECT*FROM client;
SELECT*FROM branch;

--find all clients who are handled by the branch managed by Michael scott; assume you know micheal's id

SELECT client.client_name, client_id

FROM client
WHERE client.branch_id = (
SELECT branch.branch_id
FROM branch
WHERE branch.mgr_id = 102
LIMIT 1
);

--join two tables together--
SELECT client.client_id, client.client_name, client.branch_id
FROM client
LEFT JOIN branch
ON client.branch_id = branch.branch_id;



--DELETE FOREIGN KEYS in multiple tables--
DELETE FROM employee
WHERE emp_id = 102;

SELECT *
FROM branch;

SELECT *
FROM employee;

--delete cascade: delete 'branch 2' and all associated values; use when foreign keys are primary keys--

DELETE FROM branch
WHERE branch_id = 2;

SELECT *
FROM branch_supplier;

--triggers--
CREATE TABLE trigger_test (
message VARCHAR (100)
);
--BELOW ARE EXECUTED IN TERMINAL--
DELIMITER $$
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES ('add new employee');
    END$$
DELIMITER ;
--ABOVE ARE EXECUTED IN TERMINAL

INSERT INTO employee
VALUES (109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3);

SELECT *
FROM trigger_test;

---practice: FETCH function

SELECT*FROM employee;

SELECT emp_id, first_name, sex, salary
FROM employee
ORDER BY salary DESC
LIMIT 5 OFFSET 2;

--distinct function--
SELECT DISTINCT salary, emp_id, first_name
FROM employee;

SELECT DISTINCT salary, emp_id, first_name
FROM employee
WHERE sex = 'F'
ORDER BY salary DESC
LIMIT 3 OFFSET 1;


--add new first name--

DELIMITER $$
CREATE
    TRIGGER my_trigger1 BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES (NEW.first_name);
    END$$
DELIMITER ;

INSERT INTO employee
VALUES (110, 'Kevin', 'Malone', '1978-02-19', 'M', 69000, 106, 3);

SELECT *
FROM trigger_test;


--logic operators---

--AND---
SELECT emp_id, first_name, salary, sex
FROM employee
WHERE salary >= 60000 AND sex = 'F'
ORDER BY salary DESC;

--OR---
SELECT emp_id, first_name, salary, sex = 'F' AS 'Female or not'
FROM employee
WHERE salary > 100000 OR salary < 40000 
ORDER BY salary DESC;

--between---
SELECT emp_id, first_name, salary, sex
FROM employee
WHERE salary BETWEEN 50000 AND 90000
ORDER BY salary DESC;

--IN--
SELECT AVG(salary), COUNT(sex), branch_id, sex
FROM employee
WHERE branch_id IN (1,2)
GROUP BY branch_id, sex
ORDER BY branch_id DESC;

--% and _ ---
SELECT emp_id, first_name, salary, sex
FROM employee
WHERE first_name LIKE '_o'
ORDER BY salary DESC;

--comparison_operator ALL (subquery);--

SELECT emp_id, first_name, salary, sex, branch_id
FROM employee
WHERE salary >= ALL (
   SELECT salary 
    FROM employee 
    WHERE branch_id = 2)
AND sex = 'M'
ORDER BY salary DESC;

SELECT * FROM employee;


--comparison_operator ANY(subquery)--
SELECT emp_id, first_name, salary,branch_id
FROM employee
WHERE salary > ANY(
SELECT AVG(salary)
FROM employee
GROUP BY sex)
ORDER BY salary DESC;

--subquery in this query
SELECT AVG(salary)
FROM employee
GROUP BY sex;

--EXISTS---
SELECT first_name, sex, birth_day
FROM employee
WHERE EXISTS(
SELECT 1 
FROM branch
WHERE branch.branch_id = employee.branch_id
);

SELECT*FROM branch;


--exist example 2--
SELECT first_name, last_name
FROM employee
WHERE EXISTS
(SELECT branch_id
FROM branch
WHERE mgr_start_date < '2000-01-01' 
)
ORDER BY last_name, first_name DESC;



--subquery in EXISTS query--
SELECT 1 
FROM branch
WHERE branch.branch_id = employee.branch_id;









------PRACTICE-----

--step 1: create student table with id, name, birthday, and sex---
DROP TABLE student;

CREATE TABLE student(
 student_id INT PRIMARY KEY AUTO_INCREMENT,
 student_name VARCHAR(20),
 student_age DATE,
 student_sex NVARCHAR(10)
);


SELECT*
FROM student;

INSERT INTO student (student_name, student_age, student_sex) VALUES ( 'Jack' , '1990-01-01' , 'M');
INSERT INTO student (student_name, student_age, student_sex) VALUES ( 'Joe' , '1990-12-21' , 'M');
INSERT INTO student (student_name, student_age, student_sex) VALUES ( 'John' , '1990-05-20' , 'M');
INSERT INTO student (student_name, student_age, student_sex) VALUES ( 'Jason' , '1990-08-06' , 'M');
INSERT INTO student (student_name, student_age, student_sex) VALUES ( 'Jane' , '1991-12-01' , 'F');
INSERT INTO student (student_name, student_age, student_sex) VALUES ( 'Jill' , '1992-03-01' , 'F');
INSERT INTO student (student_name, student_age, student_sex) VALUES ( 'Joy' , '1989-07-01' , 'F');
INSERT INTO student (student_name, student_age, student_sex) VALUES ( 'Jesse' , '1990-01-20' , 'F');


--step2: create course table with course id, course name, and teacher id--
DROP TABLE course;


CREATE TABLE course(
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(10),
    teacher_id INT
);

SELECT*
FROM course;


INSERT INTO course (course_name, teacher_id) VALUES('English' , 02);
INSERT INTO course (course_name, teacher_id) VALUES( 'Math' , 01);
INSERT INTO course (course_name, teacher_id) VALUES('PE' , 03);



--step3: create teacher table with teacher name and teacher id
CREATE TABLE teacher(
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(10)
);


DROP TABLE teacher;

SELECT*
FROM teacher;

INSERT INTO teacher VALUE (01, 'Abby');
INSERT INTO teacher VALUE (02, 'Andrew');
INSERT INTO teacher VALUE (03, 'Ann');


--associate teacher table and course table together--
ALTER TABLE course
ADD FOREIGN KEY(teacher_id)
REFERENCES teacher(teacher_id)
ON DELETE SET NULL;


--step4: create transcript with student id, course id, student grade--

---example of foreign key---
-- ALTER TABLE employee
-- ADD FOREIGN KEY(branch_id)
-- REFERENCES branch(branch_id)
-- ON DELETE SET NULL;

DROP TABLE scores;

CREATE TABLE scores (
    student_id INT,
    course_id  INT,
    score DECIMAL (18, 1)
    );

SELECT*
FROM scores;

--associate score table with course table and student table--

ALTER TABLE scores
ADD FOREIGN KEY(course_id)
REFERENCES course(course_id)
ON DELETE SET NULL;

ALTER TABLE scores
ADD FOREIGN KEY(student_id)
REFERENCES student(student_id)
ON DELETE SET NULL;

SELECT * FROM scores;


INSERT INTO scores VALUES (01, 01, 10);
insert into scores values(01 , 02 , 90);
insert into scores values(01 , 03 , 99);
insert into scores values(02 , 01 , 70);
insert into scores values(02 , 02 , 60);
insert into scores values(02 , 03 , 80);
insert into scores values(03 , 01 , 80);
insert into scores values(03 , 02 , 80);
insert into scores values(03 , 03 , 80);
insert into scores values(04 , 01 , 50);
insert into scores values(04 , 02 , 30);
insert into scores values(04 , 03 , 20);
insert into scores values(05 , 01 , 76);
insert into scores values(05 , 02 , 87);
insert into scores values(06 , 01 , 31);
insert into scores values(06 , 03 , 34);
insert into scores values(07 , 02 , 89);
insert into scores values(07 , 03 , 98);


--task 1: add names into the scores table

SELECT student.student_id, student.student_name, scores.score, scores.course_id
FROM student
LEFT JOIN scores
ON student.student_id = scores.student_id;

--option 2:

SELECT scores.student_id, scores.score, scores.course_id,
(SELECT student.student_name 
FROM student
WHERE scores.student_id = student.student_id) AS 'student name'
FROM scores;    

SELECT * FROM student;
SELECT* FROM course;
SELECT * FROM teacher;
SELECT * FROM scores;

--task 2: check all student ID, name, course, and total grade
--option 1; join before group by
SELECT student.student_id, student.student_name, COUNT(scores.course_id) AS 'number of courses', SUM(scores.score) AS 'total score'
FROM student
LEFT JOIN scores
ON student.student_id = scores.student_id
GROUP by student.student_id, student.student_name;


--option 2: group by then join
-- SELECT student.student_id, student.student_name, scores.course_id, scores.score
-- FROM student LEFT JOIN 
-- (SELECT scores.student_id, COUNT(scores.course_id) AS 'number of courses', SUM(scores.score) AS 'total score'
-- FROM scores GROUP BY scores.student_id)
-- ON student.student_id = scores.student_id;


---option 3 sub-query
SELECT student.student_id, student.student_name,
    (SELECT COUNT(course_id) FROM scores WHERE student.student_id = scores.student_id) AS 'number of course',
    (SELECT SUM(score) FROM scores WHERE student.student_id =  scores.student_id) AS 'total score'
FROM student;

SELECT SUM(scores.score)
FROM scores;


--task 3 check the highest and lowest grade of each course
SELECT MAX(scores.score) AS 'MAX', MIN(scores.score) AS 'MIN', course_id
FROM scores
GROUP BY scores.course_id;

SELECT*FROM teacher;
SELECT * FROM scores;
SELECT*FROM course;


---task 4 check the highest and lowest grade of each teacher
SELECT teacher.teacher_id,teacher.teacher_name,
MAX(scores.score) AS 'MAX',
MIN(scores.score) AS 'min'

FROM teacher

LEFT JOIN course ON teacher.teacher_id = course.teacher_id
LEFT JOIN scores ON course.course_id = scores.course_id
GROUP BY teacher.teacher_id;

--adding rank and dense rank columns into scores table--
--option1---

SELECT student_id, course_id, score,
RANK() OVER (ORDER BY score desc) RANKING,
DENSE_RANK() OVER (ORDER BY score desc) RANKING_DENSE
FROM scores;

--option 2 using self join
-- SELECT scores.student_id, scores.course_id, scores.score,
-- COUNT (scores.score +1 ) AS DENSE_RANKING
-- FROM scores 
-- LEFT JOIN scores ON scores.score < scores.score
-- GROUP BY scores.student_id, scores.course_id, scores.score
-- ORDER BY RANKING;

--extra exercise---
SELECT student.student_id, student.student_name,  AVG(scores.score) AS 'average score'
FROM scores
RIGHT JOIN student
ON student.student_id = scores.student_id
GROUP BY student.student_id
ORDER BY 'average score';

----group by course id then add dense rank and rank based on score--
--partition by: divide into different parts and calculate per part--
SELECT scores.student_id, scores.course_id, AVG(scores.score),
RANK () OVER (PARTITION BY course_id ORDER BY scores.score DESC) RANKING,
DENSE_RANK() OVER (PARTITION BY course_id ORDER BY scores.score DESC) RANKING_DENSE
GROUP BY scores.
FROM scores;

SELECT scores





---practice----

SELECT COUNT(student.student_sex) AS 'headcount',student.student_sex AS 'SEX', AVG(scores.score) AS 'average score'
FROM student
LEFT JOIN scores
ON student.student_id = scores.student_id
GROUP BY student.student_sex;

---special practice for partition and over: another student table---
DROP TABLE school;

CREATE TABLE school
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    gender VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    total_score INT NOT NULL
 );

SELECT * FROM school;


--create view---
CREATE VIEW schoolss AS
SELECT * FROM school;

-- insert values into school table--
 
INSERT INTO school (name, gender, age, total_score) VALUES 
('Jolly', 'Female', 20, 500), 
('Jon', 'Male', 22, 545), 
('Sara', 'Female', 25, 600), 
('Laura', 'Female', 18, 400), 
('Alan', 'Male', 20, 500), 
('Kate', 'Female', 22, 500), 
('Joseph', 'Male', 18, 643), 
('Mice', 'Male', 23, 543), 
('Wise', 'Male', 21, 499), 
('Elis', 'Female', 27, 400);


---students scores, age, number by sex,

SELECT COUNT(gender) AS 'count', gender, AVG(age) AS 'average age', AVG(total_score) AS 'average score'
FROM school
GROUP BY gender;

-- practice: partition by---

SELECT id, name, gender, COUNT(gender) OVER (PARTITION BY gender) AS 'total no.',
AVG(age) OVER (PARTITION BY gender) AS 'average age',
SUM(total_score) OVER (PARTITION BY gender) AS 'total score'
FROM school
ORDER BY 'total score' DESC;

---EXISTS EXERCISE--

SELECT*FROM student;
SELECT*FROM course;
SELECT*FROM teacher;
SELECT*FROM scores;

SELECT student.student_name, student_age
FROM student
WHERE EXISTS(
SELECT course_name
FROM course
WHERE teacher_id = 2
)
AND student_sex = 'F'
ORDER BY student_age ASC;


SELECT*FROM student;
--HAVING CLAUSE---
SELECT COUNT(student_sex), student_sex, AVG(2021-YEAR(student_age))
FROM student
GROUP BY student_sex
HAVING student_sex = 'M';


SELECT * FROM employee;
SELECT * FROM branch;
SELECT * FROM works_with;
SELECT * FROM client;

--exercise--
SELECT COUNT(sex) salary, sex
FROM employee
WHERE branch_id IN (2,3)
GROUP BY sex
HAVING sex = 'M';

----exercis 2: cannot be complete by WHERE --
SELECT branch_id, AVG(salary)
FROM employee
GROUP BY branch_id
HAVING AVG(salary) BETWEEN 60000 AND 70000
ORDER BY AVG(salary);

---exercise 3: HAVING and INNER JOIN---
SELECT branch.branch_id, branch.branch_name, MIN(employee.salary)
FROM branch
INNER JOIN employee 
ON employee.branch_id = branch.branch_id
GROUP BY employee.branch_id
HAVING MIN(employee.salary) > 60000
ORDER BY MIN(employee.salary);


--HAVING AND AVERAGE---
SELECT works_with.client_id, client.client_name, ROUND(AVG(works_with.total_sales), 2) AS 'average sale per client'
-- client.client_id, client.client_name
FROM works_with
INNER JOIN client
ON client.client_id = works_with.client_id
GROUP BY works_with.client_id
HAVING ROUND(AVG(works_with.total_sales),2) BETWEEN 50000 AND 80000
ORDER BY AVG(works_with.total_sales);


---GROUP SETS---
CREATE VIEW view
SELECT branch_id, super_id, AVG(salary)
FROM employee
WHERE super_id IS NOT NULL
GROUP BY branch_id, super_id
ORDER BY branch_id, super_id DESC;


----finding the second highest grade in course X -----

SELECT*FROM student;
SELECT*FROM scores;
SELECT*FROM teacher;
SELECT*FROM course;
----english =1 -----

----find the second highest grade in English----

SELECT student.student_id, student.student_name, scores.score
FROM student
LEFT JOIN scores
ON student.student_id = scores.student_id
WHERE course_id = 1
ORDER BY scores.score DESC
LIMIT 1 OFFSET 1;

---Inner join----
SELECT student.student_id, student.student_name, scores.score
FROM student
INNER JOIN scores
ON student.student_id =  scores.student_id;

---LEFT JOIN---
SELECT student.student_id, student.student_name, scores.score
FROM student
LEFT JOIN scores
ON student.student_id =  scores.student_id;

---CREATE FUNCTIONS USING APPLY----
-- CREATE FUNCTION getscoresbyid(@student_id int)
-- RETURN TABLE
-- AS RETURN (
-- SELECT score FROM scores
-- WHERE student_id = @student_id
-- );

---add column to tables----
ALTER TABLE student
DROP enroll;


ALTER TABLE student
ADD enroll DATE;

SELECT*FROM student;

UPDATE student
SET enroll = '2008-09-09' WHERE student_id BETWEEN 1 AND 4;

UPDATE student
SET enroll = '2009-09-08' WHERE student_id BETWEEN 5 AND 6;

UPDATE student
SET enroll = '2007-9-10' WHERE student_id BETWEEN 7 AND 8;

----game users: create table activity-----
DROP TABLE activity;

CREATE TABLE activity (
    player_id INT NOT NULL,
    device_id INT,
    event_DATE DATE,
    games INT
);

SELECT*FROM activity;

INSERT INTO activity VALUES
(1,2,'2016-03-01',5 ),
(1,2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3,4, '2018-07-03', 5);

---1. first time every id---
SELECT player_id, device_id, event_DATE AS 'first time login'
FROM activity 
WHERE (player_id, event_DATE) IN(
SELECT player_id, MIN(event_DATE)
FROM activity
GROUP BY player_id
);


---2. How many games a person has played----
SELECT player_id, SUM(games) AS 'total games'
FROM activity
GROUP BY player_id
ORDER BY SUM(games) DESC;


---3. playes who logged in again on the second day--
-- SELECT ROUND(
--     SELECT COUNT(DISTINCT player_id) AS 'second day login'
--     FROM activity
--     LEFT JOIN (
--         SELECT player_id, MIN(event_DATE) AS 'first time'
--         FROM activity
--         GROUP BY player_id
--     )
--     ON player_id = player_id
--     WHERE DATEDIFF(event_DATE,'first time') = 1)/
--     (SELECT COUNT(DISTINCT player_id) AS 'total player'
--     FROM activity), 2
-- )AS fraction;


-----CANNOT USE DONT KNOW WHY---CREATE FUNCTION: SEARCH THE NTH HIGHEST SALARY---
-- CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
-- BEGIN
-- RETURN(
--     SELECT IF (COUNT < N, NULL, MIN)
--     FROM (
--     SELECT MIN(salary) AS minimum, COUNT(1) AS count
--     FROM
--     (SELECT DISTINT salary
--     FROM employee
--     ORDER BY salary DESC LIMIT N) AS A
--     )AS B
-- );
-- END


---count number of employee whose names start with 'j'
SELECT COUNT(emp_id) AS 'number of employee with J- name'
FROM employee
WHERE first_name LIKE 'J%';


SELECT*FROM student;
SELECT*FROM scores;
SELECT*FROM course;
---show number of students whose MATH scores higher than average---
SELECT COUNT(
SELECT student.student_id
FROM student
LEFT JOIN scores
ON student.student_id = scores.student_id
WHERE scores.score > AVG(
SELECT scores.score
FROM scores
WHERE course_id = 2
)
);

---random exercise----

SELECT AVG(score) AS 'math average'
FROM scores
WHERE course_id = 2
GROUP BY course_id;

SELECT COUNT(student_id) AS 'number of student'
FROM scores
WHERE course_id = 2
GROUP BY course_id;

SELECT MAX(scores.score) AS 'HIGHEST', MIN(scores.score) AS 'LOWEST', course.course_name AS 'course name'
FROM scores
LEFT JOIN course
ON course.course_id = scores.course_id
GROUP BY course.course_id;

SELECT COUNT(student_id),course_id
FROM scores
GROUP BY course_id;

SELECT COUNT(student.student_id), student.student_sex AS 'sex'
FROM student
LEFT JOIN scores
ON student.student_id = scores.student_id
WHERE student.student_sex = 'M'
GROUP BY scores.course_id;

----find student whose average score of three courses is highter than 60----
SELECT student.student_id, student.student_name, AVG(scores.score)
FROM student
LEFT JOIN scores
ON student.student_id = scores.student_id
GROUP BY student.student_id
HAVING AVG(scores.score) > 60;


--------find students whose average score of three courses are higher than 60---

SELECT student.student_id, student.student_name 
FROM student 
WHERE student_id IN (
SELECT scores.student_id
FROM scores
GROUP BY scores.student_id
HAVING AVG(scores.score) > 60);

-----------exercise WHERE IN-----------

SELECT*FROM employee;

CREATE VIEW branch_s AS
SELECT*FROM branch_supplier;

SELECT emp_id, first_name
FROM employee
WHERE branch_id IN (
    SELECT branch_id 
    FROM branch_supplier
    WHERE supply_type = 'Paper'
);

SELECT*FROM scores;
SELECT*FROM course;
----select students whose math scores highter than average math score--
SELECT student.student_id, student.student_name 
FROM student
WHERE student.student_id IN (
SELECT student_id
FROM scores
WHERE course_id = 2 AND score > 72.6667
);

-----average score of math course----
SELECT AVG(scores.score) AS 'average'
FROM scores
GROUP BY scores.course_id
HAVING scores.course_id = 2;

----select student id that larger than 72.6667-----
SELECT student_id
FROM scores
WHERE course_id = 2 AND score > 72.6667;


-----use EXISTS-----
SELECT*FROM branch;
SELECT*FROM works_with;

SELECT emp_id, first_name, last_name
FROM employee
WHERE EXISTS(
    SELECT emp_id
    FROM works_with
    WHERE client_id >= 405 AND total_sales > 80000
);



SELECT*FROM student;
SELECT*FROM course;
SELECT*FROM teacher;
-----INSERT INTO SELECT-----
INSERT INTO course
SELECT teacher_id, teacher_name FROM teacher
WHERE teacher_id = 1;


---------CASE THEN-------

SELECT student_id, student_name,
CASE
WHEN student_name LIKE "j%" THEN 'J'
ELSE 'OTHER'
END AS 'test'
FROM student;

SELECT*FROM employee;


SELECT emp_id, first_name, last_name,
CASE 
WHEN salary > (SELECT AVG(salary) FROM employee) THEN 'HIGH'
WHEN salary < (SELECT AVG(salary) FROM employee) THEN 'LOW'
ELSE 'NONE'
END AS 'salary cat'
FROM employee;


SELECT emp_id, salary FROM employee
WHERE salary > (
SELECT AVG(salary)
FROM employee);

SELECT emp_id, first_name, last_name, salary, birth_day
FROM employee
ORDER BY 
(CASE
WHEN salary < 70000 THEN birth_day
ELSE salary
END) ASC;



--rank all students' sum scores from the highest---
SELECT student.student_id, student.student_name, SUM(scores.score) AS 'sum'
FROM student
LEFT JOIN scores
ON student.student_id = scores.student_id
GROUP BY student.student_id
ORDER BY SUM(scores.score) DESC;

------NOT WORKING: ROLLUP------
SELECT branch_id, super_id, AVG(salary)
FROM employee
GROUP BY branch_id, ROLLUP (super_id);

SELECT*FROM employee;


-----FUNCTIONS NOT WORKING------

-------PROCEDURE (AKA FUNCTION)------
  CREATE PROCEDURE SelectGenderPay @sex NVARCHAR(10), @salary INT
  AS
  SELECT emp_id, first_name, last_name, birth_day
  WHERE sex = @sex AND salary = @salary
  GO;

  ----EXECUTE FUNCTION-----
  EXEC SelectGenderPay @sex = 'F', @salary = 50000;


  ---