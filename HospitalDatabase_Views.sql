-- Ivan Barnash 101484997
-- create view to show patient's details
CREATE VIEW PatientDetailsWithAge AS
SELECT 
    PatientID,
    FirstName,
    LastName,
    YEAR(CURDATE()) - YEAR(DOB) AS Age,
    Gender,
    PhoneNumber,
    Address
FROM Patients;

-- view to show all appointments details with patients and doctors
CREATE VIEW AppointmentDetails AS
SELECT 
    a.AppointmentID,
    p.FirstName AS PatientFirstName,
    p.LastName AS PatientLastName,
    d.FirstName AS DoctorFirstName,
    d.LastName AS DoctorLastName,
    a.AppointmentDateTime,
    a.Notes
FROM 
    Appointments a
JOIN 
    Patients p ON a.PatientID = p.PatientID
JOIN 
    Doctors d ON a.DoctorID = d.DoctorID;

-- view to show total billing
CREATE VIEW TotalBillingPerPatient AS
SELECT 
    p.PatientID,
    p.FirstName,
    p.LastName,
    SUM(b.Amount) AS TotalBilled
FROM 
    Patients p
LEFT JOIN 
    Billing b ON p.PatientID = b.PatientID
GROUP BY 
    p.PatientID, p.FirstName, p.LastName;

-- a view to see staff count in department
CREATE VIEW DepartmentStaffCount AS
SELECT 
    d.DepartmentName,
    COUNT(s.StaffID) AS NumberOfStaff
FROM 
    Departments d
LEFT JOIN 
    Staff s ON d.DepartmentID = s.DepartmentID
GROUP BY 
    d.DepartmentName;

-- view to show medical history)
CREATE VIEW MedicalHistory AS
SELECT 
    p.FirstName AS PatientFirstName,
    p.LastName AS PatientLastName,
    m.Diagnosis,
    m.Treatment,
    m.RecordDate
FROM 
    MedicalRecords m
JOIN 
    Patients p ON m.PatientID = p.PatientID;

