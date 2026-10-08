-- Day 6 Assignment: School Database
-- Tables: students, courses, enrolments

-- Clean up if rerunning
DROP TABLE IF EXISTS enrolments;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS courses;

-- 1. CREATE TABLES
CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);

CREATE TABLE courses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    code TEXT NOT NULL UNIQUE
);

CREATE TABLE enrolments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    grade TEXT,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    UNIQUE (student_id, course_id) -- prevents same student enrolling twice on same course
);

-- 2. INSERT SAMPLE DATA (at least 3 students, 3 courses, 5 enrolments)
INSERT INTO students (name, email) VALUES 
('Thando Nkosi', 'thando.nkosi@example.com'),
('Amahle Dlamini', 'amahle.dlamini@example.com'),
('James Smith', 'james.smith@example.com'),
('Lerato Molefe', 'lerato.molefe@example.com');

INSERT INTO courses (name, code) VALUES
('Web Foundations', 'WEB101'),
('Database Systems', 'DB202'),
('Python Programming', 'PYT303');

INSERT INTO enrolments (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(1, 2, 'B+'),
(2, 1, 'A-'),
(2, 3, 'B'),
(3, 2, 'C'),
(3, 3, 'B+');

-- 3. FIVE REQUIRED QUERIES

-- Query 1: all courses for one student (by name)
SELECT c.name AS course_name, c.code, e.grade
FROM students s
JOIN enrolments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id
WHERE s.name = 'Thando Nkosi';

-- Query 2: all students on one course
SELECT s.name AS student_name, s.email, e.grade
FROM courses c
JOIN enrolments e ON c.id = e.course_id
JOIN students s ON e.student_id = s.id
WHERE c.name = 'Web Foundations';

-- Query 3: the number of students per course
SELECT c.name AS course_name, COUNT(e.student_id) AS number_of_students
FROM courses c
LEFT JOIN enrolments e ON c.id = e.course_id
GROUP BY c.id, c.name;

-- Query 4: students who have no enrolments
SELECT s.name, s.email
FROM students s
LEFT JOIN enrolments e ON s.id = e.student_id
WHERE e.student_id IS NULL;

-- Query 5: update of one enrolment's grade
UPDATE enrolments SET grade = 'A+' WHERE student_id = 1 AND course_id = 1;
-- To verify the update:
SELECT * FROM enrolments WHERE student_id = 1 AND course_id = 1;
