-- Create Employee Table 
CREATE TABLE Employee ( 
    emp_id INT,
    first_name VARCHAR(40),
    lsat_name VARCHAR(40),
    birth_date DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT,
    PRIMARY KEY(emp_id)
);

-- Create Branch Table 
CREATE TABLE Branch(
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES Employee(emp_id) ON DELETE SET NULL
);

-- Add Foreign key (super_id) from Employee Table 
ALTER TABLE Employee
ADD FOREIGN KEY(super_id)
REFERENCES Employee(emp_id)
ON DELETE SET NULL;

-- Add Foreign key (branch_id) from Employee Table
ALTER TABLE Employee
ADD FOREIGN KEY(branch_id)
REFERENCES Branch(branch_id)
ON DELETE SET NULL;

-- Create Client Table 
CREATE TABLE Client(
    client_id INT PRIMARY KEY,
    client_name VARCHAR(40),
    branch_id INT,
    FOREIGN KEY(branch_id) REFERENCES Branch(branch_id) ON DELETE SET NULL
);

-- Create Works_With Table 
CREATE TABLE Works_With(
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id,client_id),
    FOREIGN KEY(emp_id) REFERENCES Employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES Client(client_id) ON DELETE CASCADE
);

-- Create Branch Supplier Table 
CREATE TABLE Branch_Supplier(
    branch_id INT,
    supplier_name VARCHAR(40),
    supply_type VARCHAR(40),
    PRIMARY KEY(branch_id,supplier_name),
    FOREIGN KEY(branch_id) REFERENCES Branch(branch_id) ON DELETE CASCADE
);

-------INSERT DATA------------

-- Insert First Row of Employee 
-- Foreign Key has not yet been created, so set to null first
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

-- Insert First Row of Branch 
INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

-- Update First Row of Employee 
UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Insert Scranton branch and Employee
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

--Insert Stamford branch and Employee
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');
INSERT INTO branch VALUE(4, 'Buffalo', NULL, NULL);

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

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

---SELECT DATA---
SELECT * 
FROM Employee;

SELECT * 
FROM Works_With;

SELECT *
FROM Employee
ORDER BY sex, first_name, lsat_name DESC;

SELECT first_name AS forename, lsat_name AS surname
FROM Employee; 

SELECT DISTINCT branch_id
FROM Employee;


---FUNCITONS IN SQL---

-- Find the number of female employees born after 1970
SELECT COUNT(emp_id)
FROM Employee
WHERE sex = 'F' AND birth_date > '1971-01-01';

-- Find the average of all employee's salaries 
SELECT AVG(salary)
FROM Employee
WHERE sex = 'M';

-- Find the sum of all employee's salaries 
SELECT SUM(salary)
FROM Employee;

-- Find out how many males and females there are 
SELECT COUNT(sex), sex
FROM Employee
GROUP BY sex;

-- Find the total sales of each salesman
SELECT emp_id, SUM(total_sales)
FROM Works_With
GROUP BY Works_With.emp_id;

------Wildcards-----
-- % = any # characters, _ = one character 

-- Find any client's who are an LLC 
SELECT * 
FROM Client
WHERE client_name LIKE '%LLC';

-- Find any branch suppliers who are in the label business
SELECT * 
FROM Branch_Supplier
WHERE supplier_name LIKE '% Labels%';

-- Find any employee born in Feb
SELECT * 
FROM Employee
WHERE birth_date LIKE '____-02%';

-- Find any clients who are school
SELECT * 
FROM Client
WHERE client_name LIKE '%school%';


-- UNION(Remove duplicates)  UNION ALL(Keep duplicates)--
-- Find a list of employee and branch name
SELECT first_name AS name
FROM Employee
UNION
SELECT branch_name
FROM Branch;

-- Find a list of all clients & branch supplier's names
SELECT client_name, Client.branch_id
FROM Client
UNION 
SELECT supplier_name, Branch_Supplier.branch_id
FROM Branch_Supplier;

-- Find a list of all money spent or earned by the company
SELECT salary
FROM Employee
UNION 
SELECT total_sales
FROM Works_With;

-- JOIN -- 
-- Find all branches and the name of their managers 
SELECT Employee.emp_id, Employee.first_name, Branch.branch_name
FROM Employee
JOIN Branch
ON Employee.emp_id = Branch.mgr_id;

SELECT Employee.emp_id, Employee.first_name, Branch.branch_name
FROM Employee
RIGHT JOIN Branch
ON Employee.emp_id = Branch.mgr_id;

-- Nested Queries ---

-- Find names of all employees who have 
-- sold over 30,000 to a single client
SELECT Employee.first_name, Employee.lsat_namXWe
FROM Employee
WHERE Employee.emp_id IN (
    SELECT Works_With.emp_id 
    FROM Works_With
    WHERE Works_With.total_sales > 30000
);

-- Find all clients who are handled by the branch
-- that Michael Scott manages 
-- Assume you know Michael's ID 
SELECT *
FROM Client
WHERE CLIENT.branch_id IN (
    SELECT Branch.branch_id
    FROM Branch
    WHERE Branch.mgr_id = 102
);