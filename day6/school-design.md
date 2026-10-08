# School Database Design

## Tables Explanation

### students
Stores student information.
- id: Primary Key, unique identifier for each student
- name: Student full name, NOT NULL because every student must have a name
- email: UNIQUE and NOT NULL, used to prevent duplicate accounts and to contact students

### courses
Stores course information.
- id: Primary Key, unique identifier for each course
- name: Course name like 'Web Foundations', NOT NULL
- code: UNIQUE course code like 'WEB101', prevents duplicate courses

### enrolments
This is the join table that links students and courses and holds the grade.
- id: Primary Key
- student_id: Foreign Key -> students(id), NOT NULL
- course_id: Foreign Key -> courses(id), NOT NULL
- grade: Grade achieved (A, B, etc.), can be NULL if not graded yet
- UNIQUE(student_id, course_id): Prevents a student from enrolling on the same course twice

## Relationships

- **students to enrolments: One-to-Many** - One student can have many enrolments, but each enrolment belongs to one student.
- **courses to enrolments: One-to-Many** - One course can have many enrolments, but each enrolment belongs to one course.
- **students to courses: Many-to-Many** - One student can take many courses, and one course can have many students. That is why we need a join table (enrolments). Without it we cannot represent this relationship properly in SQL.

## Index I Would Add

I would add an index on `enrolments(student_id)` and `enrolments(course_id)`.

Example:
`CREATE INDEX idx_enrolments_student ON enrolments(student_id);`

Reason: The most common queries are JOINs to find all courses for a student and all students for a course. Indexing the foreign keys makes those JOINs and WHERE filters much faster, especially when the database grows.

## SQL vs NoSQL for This System

I would choose **SQL** for this system because the data is highly structured and relational. Students, courses and enrolments have clear relationships with constraints like UNIQUE email and preventing duplicate enrolments. SQL gives us foreign keys, JOINs, and ACID transactions which guarantee data integrity. NoSQL would be better for unstructured data like social media posts, but for a school system where accuracy and relationships are critical, SQL (SQLite) is the right choice.