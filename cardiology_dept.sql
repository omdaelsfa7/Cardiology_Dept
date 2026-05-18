DROP DATABASE IF EXISTS HospitalInformationSystem;
CREATE DATABASE HospitalInformationSystem;
USE HospitalInformationSystem;

CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    JobTitle VARCHAR(50),
    Salary DECIMAL(10, 2),
    PhoneNumber VARCHAR(20),
    HomeAddress TEXT,
    JoiningDate DATE
);

CREATE TABLE Departments
(
    DepartmentID INT PRIMARY KEY,
    DepartmentCode VARCHAR(20) UNIQUE NOT NULL,
    DepartmentName VARCHAR(50) UNIQUE NOT NULL,
    ChairmanID INT,
    SupervisionStartDate DATE
);

CREATE TABLE DepartmentLocations
(
    DepartmentID INT,
    LocationName VARCHAR(100),
    PRIMARY KEY (DepartmentID, LocationName),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE CASCADE
);

CREATE TABLE Doctors
(
    EmployeeID INT PRIMARY KEY,
    Specialty VARCHAR(50),
    AcademicDegree VARCHAR(50),
    ScientificArea VARCHAR(100),
    LicenseNumber VARCHAR(50) UNIQUE,
    DepartmentID INT,
    LocationName VARCHAR(100),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE,
    FOREIGN KEY (DepartmentID, LocationName) REFERENCES DepartmentLocations(DepartmentID, LocationName)
);

CREATE TABLE Nurses
(
    EmployeeID INT PRIMARY KEY,
    ShiftType VARCHAR(20),
    DepartmentID INT,
    LocationName VARCHAR(100),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE,
    FOREIGN KEY (DepartmentID, LocationName) REFERENCES DepartmentLocations(DepartmentID, LocationName)
);

CREATE TABLE GeneralStaff
(
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    LocationName VARCHAR(100),
    WorkArea VARCHAR(100),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE,
    FOREIGN KEY (DepartmentID, LocationName) REFERENCES DepartmentLocations(DepartmentID, LocationName)
);

ALTER TABLE Departments ADD FOREIGN KEY (ChairmanID) REFERENCES Doctors(EmployeeID);

CREATE TABLE Rooms
(
    RoomNumber INT PRIMARY KEY,
    RoomType VARCHAR(50),
    DepartmentID INT,
    LocationName VARCHAR(100),
    FOREIGN KEY (DepartmentID, LocationName) REFERENCES DepartmentLocations(DepartmentID, LocationName)
);

CREATE TABLE Patients
(
    PatientID INT PRIMARY KEY,
    NationalID VARCHAR(20) UNIQUE NOT NULL,
    FullName VARCHAR(100) NOT NULL,
    DateOfBirth DATE,
    Gender CHAR(1),
    PhoneNumber VARCHAR(20),
    HomeAddress TEXT,
    MedicalHistory TEXT,
    AdmissionDate DATE
);

CREATE TABLE PatientInvestigations
(
    DoctorID INT,
    PatientID INT,
    WeeklyConsultationHours INT DEFAULT 0,
    InvestigationDate DATE,
    PRIMARY KEY (DoctorID, PatientID, InvestigationDate),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(EmployeeID),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE Appointments
(
    AppointmentID INT PRIMARY KEY,
    ScheduledDate DATE NOT NULL,
    ScheduledTime TIME NOT NULL,
    AppointmentStatus VARCHAR(20),
    PaymentStatus VARCHAR(20),
    PatientID INT,
    DoctorID INT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(EmployeeID)
);

CREATE TABLE Prescriptions
(
    PrescriptionID INT PRIMARY KEY,
    MedicationName VARCHAR(100),
    Dosage VARCHAR(50),
    AdministrationInstructions TEXT,
    StartDate DATE,
    EndDate DATE,
    PatientID INT,
    DoctorID INT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(EmployeeID)
);

CREATE TABLE MedicalScans
(
    ScanID INT PRIMARY KEY,
    ScanType VARCHAR(50),
    ScanResult TEXT,
    ScanDate DATE,
    PatientID INT,
    DoctorID INT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(EmployeeID)
);

CREATE TABLE VitalSignsLogs
(
    LogID INT PRIMARY KEY,
    BloodPressure VARCHAR(20),
    HeartRate INT,
    BodyTemperature DECIMAL(4, 2),
    LogTimestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    PatientID INT,
    NurseID INT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (NurseID) REFERENCES Nurses(EmployeeID)
);

CREATE TABLE RoomAllocations
(
    AllocationID INT PRIMARY KEY,
    AdmissionTimestamp DATETIME,
    DischargeTimestamp DATETIME,
    RoomNumber INT,
    PatientID INT,
    DoctorID INT,
    FOREIGN KEY (RoomNumber) REFERENCES Rooms(RoomNumber),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(EmployeeID)
);