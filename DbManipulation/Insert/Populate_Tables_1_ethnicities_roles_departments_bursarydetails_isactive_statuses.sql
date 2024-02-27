INSERT INTO Ethnicities (Ethnicity)
VALUES ('Black'), ('Indian'), ('Coloured');

INSERT INTO Roles (Role)
VALUES ('BBDSuperAdmin'), ('BBDAdmin_Finance'), ('BBDAdmin_Reviewers'), ('Student'), ('HOD'), ('UniversityAdmin');


INSERT INTO Departments (DepartmentName)
VALUES ('University Administration'),
       ('Computer Science'),
       ('Information Technology'),
       ('Software Engineering'),
       ('Cybersecurity'),
       ('Data Science');


INSERT INTO BursaryDetails (Year, TotalAmount)
VALUES (2020, 2000000),
       (2021, 5000000),
       (2022, 7500000),
       (2023, 10000000),
       (2024, 15000000);

--INSERT INTO IsActive (IsActiveStatus)
--VALUES ('Yes'), ('No');


INSERT INTO Statuses (Status)
VALUES ('Submitted'), ('Under Review'), ('Accepted'), ('Rejected');
