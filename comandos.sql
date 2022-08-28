-- create a table
CREATE TABLE students (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  gender TEXT NOT NULL
);

CREATE TABLE subjects(
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE inscriptions(
    id_student INTEGER NOT NULL,
    id_subject INTEGER NOT NULL,
    FOREIGN KEY (id_student) REFERENCES students(id),
    FOREIGN KEY (id_subject) REFERENCES subjects(id)
);

-- insert some values
INSERT INTO students VALUES (1, 'Ryan', 'M');
INSERT INTO students VALUES (2, 'Joanna', 'F');
INSERT INTO students VALUES (3, 'Kevin', 'M');
INSERT INTO students VALUES (4, 'Jenn', 'F');
INSERT INTO students VALUES (5, 'Monica', 'F');

INSERT INTO subjects VALUES (1, 'Mathematics');
INSERT INTO subjects VALUES (2, 'History');
INSERT INTO subjects VALUES (3, 'Geography');
INSERT INTO subjects VALUES (4, 'Arts');
INSERT INTO subjects VALUES (5, 'Science');
INSERT INTO subjects VALUES (6, 'Language arts');

INSERT INTO inscriptions VALUES (1, 1);
INSERT INTO inscriptions VALUES (1, 2);
INSERT INTO inscriptions VALUES (1, 3);
INSERT INTO inscriptions VALUES (1, 4);
INSERT INTO inscriptions VALUES (1, 5);
INSERT INTO inscriptions VALUES (1, 6);

INSERT INTO inscriptions VALUES (2, 1);
INSERT INTO inscriptions VALUES (2, 2);

-- fetch some values
-- SELECT * FROM students ORDER BY id;
-- SELECT * FROM subjects ORDER BY name;

-- Selecciona las materias que ha inscrito x alumno
SELECT inscriptions.id_student, students.name, subjects.name 
FROM inscriptions
INNER JOIN students 
ON students.id = inscriptions.id_student 
INNER JOIN subjects
ON subjects.id = inscriptions.id_subject
WHERE students.id=2;