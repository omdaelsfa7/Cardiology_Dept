# Hospital Information System - Relational Mapping Schema

## 1. Logical Mapping (Relational Schema)
*Primary Keys are **bold**, Foreign Keys are italics.*

* **Employees** (**EmployeeID**, FullName, JobTitle, Salary, PhoneNumber, HomeAddress, JoiningDate)
* **Departments** (**DepartmentID**, DepartmentCode, DepartmentName, *ChairmanID*, SupervisionStartDate)
* **DepartmentLocations** (**DepartmentID**, **LocationName**)
* **Doctors** (**EmployeeID**, Specialty, AcademicDegree, ScientificArea, LicenseNumber, *DepartmentID, LocationName*)
* **Nurses** (**EmployeeID**, ShiftType, *DepartmentID, LocationName*)
* **GeneralStaff** (**EmployeeID**, *DepartmentID, LocationName*, WorkArea)
* **Rooms** (**RoomNumber**, RoomType, *DepartmentID, LocationName*)
* **Patients** (**PatientID**, NationalID, FullName, DateOfBirth, Gender, PhoneNumber, HomeAddress, MedicalHistory, AdmissionDate)
* **PatientInvestigations** (**DoctorID, PatientID, InvestigationDate**, WeeklyConsultationHours)
* **Appointments** (**AppointmentID**, ScheduledDate, ScheduledTime, AppointmentStatus, PaymentStatus, *PatientID, DoctorID*)
* **Prescriptions** (**PrescriptionID**, MedicationName, Dosage, AdministrationInstructions, StartDate, EndDate, *PatientID, DoctorID*)
* **MedicalScans** (**ScanID**, ScanType, ScanResult, ScanDate, *PatientID, DoctorID*)
* **VitalSignsLogs** (**LogID**, BloodPressure, HeartRate, BodyTemperature, LogTimestamp, *PatientID, NurseID*)
* **RoomAllocations** (**AllocationID**, AdmissionTimestamp, DischargeTimestamp, *RoomNumber, PatientID, DoctorID*)

---

## 2. Visual Relationship Map (Mermaid)
> **Note:** To view this in VS Code, click the "Open Preview to the Side" button in the top right.

```mermaid
erDiagram
    EMPLOYEES ||--o| DOCTORS : "specializes as"
    EMPLOYEES ||--o| NURSES : "specializes as"
    EMPLOYEES ||--o| GENERAL_STAFF : "works as"
    
    DEPARTMENTS ||--o{ DEPT_LOCATIONS : "operates in"
    DEPARTMENTS ||--|| DOCTORS : "is managed by"
    
    DOCTORS }|--|| DEPT_LOCATIONS : "assigned to"
    NURSES }|--|| DEPT_LOCATIONS : "assigned to"
    GENERAL_STAFF }|--|| DEPT_LOCATIONS : "assigned to"
    
    DEPT_LOCATIONS ||--o{ ROOMS : "houses"
    
    PATIENTS ||--o{ INVESTIGATIONS : "receives"
    DOCTORS ||--o{ INVESTIGATIONS : "conducts"
    
    PATIENTS ||--o{ APPOINTMENTS : "books"
    DOCTORS ||--o{ APPOINTMENTS : "attends"
    
    PATIENTS ||--o{ PRESCRIPTIONS : "prescribed"
    DOCTORS ||--o{ PRESCRIPTIONS : "authorizes"
    
    PATIENTS ||--o{ SCANS : "undergoes"
    DOCTORS ||--o{ SCANS : "reviews"
    
    PATIENTS ||--o{ VITALS : "provides"
    NURSES ||--o{ VITALS : "records"
    
    PATIENTS ||--o{ ALLOCATIONS : "occupies"
    ROOMS ||--o{ ALLOCATIONS : "provides"
    DOCTORS ||--o{ ALLOCATIONS : "monitors"
