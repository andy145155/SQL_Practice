CREATE TABLE student ( 
    student_id INT AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    major VARCHAR(20) DEFAULT 'undecided',
    -- major VARCHAR(20) UNIQUE,
    PRIMARY KEY(student_id)
);

DESCRIBE student;

DROP TABLE student;

ALTER TABLE student ADD gpa DECIMAL(3,2);

ALTER TABLE student DROP COLUMN gpa;

SELECT * FROM student;

-- Insert data
INSERT INTO student(name, major) VALUES('Jack', 'Biology');

INSERT INTO student(name, major) VALUES('Kate', 'Sociology');

INSERT INTO student(name, major) VALUES('Claire', 'Chemistry');

INSERT INTO student(name, major) VALUES('Jack', 'Biology');

INSERT INTO student(name, major) VALUES('Mike', 'Computer Science');

-- Update & Delete
UPDATE student 
SET major = 'Bio'
WHERE major = 'Biology';

UPDATE student 
SET name = 'Tom', major = 'undecided'
WHERE student_id = 1;

DELETE FROM student
WHERE student_id = 6;

-- Basic Query 
SELECT *
FROM student
-- ORDER BY student_id ASC/DESC
ORDER BY major ASC, student_id DESC
LIMIT 2;

SELECT *
FROM student
WHERE major <> 'Chemistry';
-- <, >, <=, >=, =<, <>, AND, OR 

SELECT *
FROM student
WHERE name IN('Claire', 'Kate', 'Mike') AND student_id > 2;



