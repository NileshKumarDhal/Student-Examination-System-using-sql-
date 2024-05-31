CREATE TABLE students (
    Student_ID INT PRIMARY KEY,
    First_Name VARCHAR(20),
    Last_Name VARCHAR(20),
    Email_ID VARCHAR(50),
    Phone_No INT 
);
drop table Students;
INSERT INTO students VALUES(12016202, 'Nilesh', 'Dhal', 'nilesh8@gmail.com', 9365425987);
INSERT INTO students VALUES(12054876, 'Aman', 'Khan', 'Khanaman3@gmail.com', 8526478965);
INSERT INTO students VALUES(12456254, 'Rakshit', 'Manas', 'manas87@gmail.com', 85647951455);
INSERT INTO students VALUES(12547865, 'Nardeep', 'Shikawat', 'nardeep5@gmail.com', 8756982456);
INSERT INTO students VALUES(12587862, 'Rahul', 'Dev', 'rahuldev4@gami.com', 9654128764);
INSERT INTO students VALUES(12054687, 'Prashant', 'Thakur', 'thakur4@gmail.com', 8546987125);
INSERT INTO students VALUES(12054631, 'Shivam', 'Rai', 'rai76@gamil.com', 9687436795);
INSERT INTO students VALUES(12087614, 'Shivani', 'Kumari', 'shivani8@gmail.com', 9875463245);
INSERT INTO students VALUES(12057864, 'Arti', 'Singh', 'singharti4@gmail.com', 9856412789);
INSERT INTO students VALUES(12048796, 'Gulshan', 'singh', 'singhgul3@gmail.com', 9547856324);

SELECT * FROM Students;

CREATE TABLE Subject(
    Subject_Name VARCHAR(10),
    Subject_ID INT,
    Credits INT,
    Student_ID INT PRIMARY KEY,
    FOREIGN KEY (Student_ID) REFERENCES students(Student_ID)
);
drop table Subject;
INSERT INTO Subject VALUES('Maths', 12, 8, 12016202);
INSERT INTO Subject VALUES('English', 13, 10, 12054876);
INSERT INTO Subject VALUES('Physics', 10, 9, 12456254);
INSERT INTO Subject VALUES('Chemistry', 11, 10, 12547865);
INSERT INTO Subject VALUES('Computer', 14, 8, 12587862);
INSERT INTO Subject VALUES('Hindi', 15, 8, 12054687);
INSERT INTO Subject VALUES('Chemistry', 11, 10,12054631 );
INSERT INTO Subject VALUES('Physics', 10, 9,12087614 );
INSERT INTO Subject VALUES('Maths', 12, 8,12057864 );
INSERT INTO Subject VALUES('English', 13, 10,12048796);

SELECT * FROM Subject;

CREATE TABLE Exams(
    ExamID INT,
    SubjectID INT,
    Student_ID INT PRIMARY KEY,
    ExamDate DATE,
    FOREIGN KEY (SubjectID) REFERENCES Subjects(Subject_ID),
    FOREIGN KEY (Student_ID) REFERENCES students(Student_ID)
);
drop table Exams;
INSERT INTO Exams VALUES(01, 10,12016202, TO_DATE('25-10-2023', 'DD-MM-YYYY'));
INSERT INTO Exams VALUES(02, 11,12054876, TO_DATE('28-10-2023', 'DD-MM-YYYY'));
INSERT INTO Exams VALUES(03, 12,12456254, TO_DATE('30-10-2023', 'DD-MM-YYYY'));
INSERT INTO Exams VALUES(04, 13,12547865, TO_DATE('02-11-2023', 'DD-MM-YYYY'));
INSERT INTO Exams VALUES(05, 14,12587862, TO_DATE('05-11-2023', 'DD-MM-YYYY'));
INSERT INTO Exams VALUES(06, 15,12054687, TO_DATE('08-11-2023', 'DD-MM-YYYY'));
INSERT INTO Exams VALUES(01, 10,12054631, TO_DATE('25-10-2023', 'DD-MM-YYYY'));
INSERT INTO Exams VALUES(06, 15,12087614, TO_DATE('08-11-2023', 'DD-MM-YYYY'));
INSERT INTO Exams VALUES(04, 13,12057864, TO_DATE('02-11-2023', 'DD-MM-YYYY'));
INSERT INTO Exams VALUES(03, 12,12048796, TO_DATE('30-10-2023', 'DD-MM-YYYY'));

SELECT *FROM Exams;

CREATE TABLE Grade(
  Student_ID INT PRIMARY KEY,
  ExamID INT,
  Marks INT,
  Grade CHAR(2), 
  FOREIGN KEY(Student_ID) REFERENCES Students(Student_ID)
);

INSERT INTO Grade VALUES(12016202,01,85,'B+');
INSERT INTO Grade VALUES(12054876,02,78,'C+');
INSERT INTO Grade VALUES(12456254,03,93,'A');
INSERT INTO Grade VALUES(12547865,04,88,'B+');
INSERT INTO Grade VALUES(12587862,05,91,'A');
INSERT INTO Grade VALUES(12054687,06,96,'A+');
INSERT INTO Grade VALUES(12054631,01,80,'B');
INSERT INTO Grade VALUES(12087614,06,82,'B');
INSERT INTO Grade VALUES(12057864,04,72,'C');
INSERT INTO Grade VALUES(12048796,03,78,'C+');

SELECT * FROM Grade;

//1 show the details of student who got marks above 90
SELECT s.Student_ID, s.First_Name, s.Last_Name, g.Marks
FROM Students s
JOIN Grade g ON s.Student_ID = g.Student_ID
WHERE g.Marks > 90;

//2 show the details of student and subject who got above B+ grade
SELECT s.Student_ID, s.First_Name, s.Last_Name, su.Subject_Name, g.Grade
FROM Students s
JOIN Grade g ON s.Student_ID = g.Student_ID
JOIN Exams e ON s.Student_ID = e.Student_ID
JOIN Subject su ON e.SubjectID = su.Subject_ID
WHERE g.Grade < 'B+';

//3 show the name of student, subject who exam is on date 2-11-2023
SELECT s.First_Name, s.Last_Name, sub.Subject_Name
FROM Students s
JOIN Exams e ON s.Student_ID = e.Student_ID
JOIN Subject sub ON e.SubjectID = sub.Subject_ID
WHERE e.ExamDate = TO_DATE('2023-11-02', 'YYYY-MM-DD');

//4 show details of subject whose credits is more than or equal to 9 
SELECT *
FROM Subject
WHERE Credits >= 9;

//5 show the details of student who have subject Maths
SELECT s.*
FROM Students s
JOIN Subject sub ON s.Student_ID = sub.Student_ID
WHERE sub.Subject_Name = 'Maths';

//6 show student detaisl with subject name who got marks above 80
SELECT s.First_Name, s.Last_Name, sub.Subject_Name, g.Marks
FROM Students s
JOIN Exams e ON s.Student_ID = e.Student_ID
JOIN Grade g ON s.Student_ID = g.Student_ID AND e.ExamID = g.ExamID
JOIN Subject sub ON e.SubjectID = sub.Subject_ID
WHERE g.Marks > 80;

//7 show details of student whose subject is Physics and got marks above 80;
SELECT distinct s.First_Name, s.Last_Name, g.Marks
FROM Students s
JOIN Exams e ON s.Student_ID = e.Student_ID
JOIN Grade g ON s.Student_ID = g.Student_ID AND e.ExamID = g.ExamID
JOIN Subject sub ON e.SubjectID = sub.Subject_ID
WHERE sub.Subject_Name = 'Physics' AND g.Marks > 80;

//8 show the student, subject and thir marks  who got highest marks
SELECT s.First_Name, s.Last_Name, sub.Subject_Name, g.Marks
FROM Students s
JOIN Exams e ON s.Student_ID = e.Student_ID
JOIN Grade g ON s.Student_ID = g.Student_ID AND e.ExamID = g.ExamID
JOIN Subject sub ON e.SubjectID = sub.Subject_ID
WHERE (g.Student_ID, g.ExamID) IN (
    SELECT Student_ID, ExamID
    FROM Grade
    WHERE Marks = (SELECT MAX(Marks) FROM Grade)
);




       