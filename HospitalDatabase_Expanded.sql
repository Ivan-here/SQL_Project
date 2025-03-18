-- Ivan Barnash 101484997
CREATE DATABASE HospitalDB;

USE HospitalDB;

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DOB DATE,
    Gender VARCHAR(10),
    PhoneNumber VARCHAR(15),
    Address VARCHAR(100)
);

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialty VARCHAR(50),
    PhoneNumber VARCHAR(15)
);

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    AppointmentDateTime DATETIME,
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    Diagnosis VARCHAR(100),
    Treatment TEXT,
    RecordDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE Billing (
    BillID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    PaymentMethod VARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(50),
    HeadDoctorID INT,
    FOREIGN KEY (HeadDoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Position VARCHAR(50),
    Salary DECIMAL(10,2),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO Patients (FirstName, LastName, DOB, Gender, PhoneNumber, Address)
VALUES 
('Mark', 'Grayson', '1991-10-14', 'Male', '123-456-7890', '123 Main St'),
('Eve', 'Atom', '1985-08-22', 'Female', '098-765-4321', '456 Rep St');

INSERT INTO Doctors (FirstName, LastName, Specialty, PhoneNumber)
VALUES 
('Dr. John', 'Dido', 'Cardiology', '333-222-5555'),
('Dr. Jane', 'Doe', 'Neurology', '414-525-1010');

INSERT INTO Appointments (PatientID, DoctorID, AppointmentDateTime, Notes)
VALUES 
(1, 1, '2021-04-01 10:00:00', 'Routine check-up'),
(2, 2, '2021-04-02 11:00:00', 'Follow-up on test results');

INSERT INTO MedicalRecords (PatientID, Diagnosis, Treatment, RecordDate)
VALUES 
(1, 'Tensiom', 'Prescribed medication', '2021-04-03'),
(2, 'Migraine', 'Painkillers', '2021-04-05');

INSERT INTO Billing (PatientID, Amount, PaymentDate, PaymentMethod)
VALUES 
(1, 150.00, '2021-04-04', 'Credit Card'),
(2, 100.00, '2021-04-06', 'Cash');

INSERT INTO Departments (DepartmentName, HeadDoctorID)
VALUES 
('Cardiology', 1),
('Neurology', 2);

INSERT INTO Staff (FirstName, LastName, Position, Salary, DepartmentID)
VALUES 
('Alice', 'Smith', 'Nurse', 50000, 1),
('Bobby', 'Rogers', 'Admin', 45000, 2);

-- sample queries
SELECT FirstName, LastName, YEAR(CURDATE()) - YEAR(DOB) AS Age FROM Patients;

SELECT * FROM Appointments WHERE DoctorID = 1;

SELECT * FROM Billing WHERE PatientID = 1;

SELECT * FROM Doctors WHERE Specialty = 'Cardiology';

SELECT * FROM MedicalRecords WHERE PatientID = 1;

SELECT SUM(Amount) AS TotalRevenue FROM Billing;

SELECT * FROM Staff WHERE DepartmentID = 1;

SELECT DoctorID, COUNT(*) AS NumberOfAppointments FROM Appointments GROUP BY DoctorID;

SELECT p.*, b.Amount FROM Patients p JOIN Billing b ON p.PatientID = b.PatientID WHERE b.Amount > 100;

SELECT d.DepartmentName, doc.FirstName, doc.LastName
FROM Departments d
JOIN Doctors doc ON d.HeadDoctorID = doc.DoctorID;
