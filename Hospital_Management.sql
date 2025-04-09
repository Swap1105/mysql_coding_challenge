CREATE DATABASE HOSPITAL_MANAGEMENT;
USE HOSPITAL_MANAGEMENT;

CREATE TABLE PATIENT (
	PATIENTID INT PRIMARY KEY,
    FIRSTNAME VARCHAR(50),
    LASTNAME VARCHAR(50),
    DATEOFBIRTH DATE,
    GENDER VARCHAR(10),
    CONTACTNUMBER VARCHAR(15),
    ADDRESS VARCHAR(50)
    );
    
CREATE TABLE DOCTOR(
	DOCTORID INT PRIMARY KEY,
    FIRSTNAME VARCHAR(50),
    LASTNAME VARCHAR(50),
    SPECIALIZATION VARCHAR(20),
    CONTACTNUMBER VARCHAR(15)
	);
    
CREATE TABLE APPOINTMENT(
	APPOINTMENTID INT PRIMARY KEY,
    PATIENTID INT,
    DOCTORID INT,
    APPOINTMENTDATE DATE,
    DESCRIPTION VARCHAR(50),
    FOREIGN KEY (PATIENTID) REFERENCES PATIENT(PATIENTID) ON DELETE CASCADE,
    FOREIGN KEY (DOCTORID) REFERENCES DOCTOR(DOCTORID) ON DELETE CASCADE
    );
    
    
INSERT INTO patient (patientId, firstName, lastName, dateOfBirth, gender, contactNumber, address) VALUES 
(1, 'John', 'Doe', '1990-01-01', 'Male', '1234567890', '123 Main St, City, Country'),
(2, 'Jane', 'Smith', '1985-02-15', 'Female', '2345678901', '456 Elm St, City, Country'),
(3, 'Alice', 'Johnson', '1992-03-20', 'Female', '3456789012', '789 Oak St, City, Country'),
(4, 'Bob', 'Brown', '1988-04-25', 'Male', '4567890123', '321 Pine St, City, Country'),
(5, 'Charlie', 'Davis', '1995-05-30', 'Male', '5678901234', '654 Maple St, City, Country'),
(6, 'Diana', 'Wilson', '1993-06-10', 'Female', '6789012345', '987 Cedar St, City, Country'),
(7, 'Ethan', 'Martinez', '1987-07-15', 'Male', '7890123456', '159 Spruce St, City, Country'),
(8, 'Fiona', 'Garcia', '1991-08-20', 'Female', '8901234567', '753 Birch St, City, Country'),
(9, 'George', 'Hernandez', '1986-09-25', 'Male', '9012345678', '852 Willow St, City, Country'),
(10, 'Hannah', 'Lopez', '1994-10-30', 'Female', '0123456789', '369 Fir St, City, Country');

INSERT INTO doctor (doctorId, firstName, lastName, specialization, contactNumber) VALUES 
(1, 'Dr. Sarah', 'Miller', 'Cardiology', '0987654321'),
(2, 'Dr. James', 'Wilson', 'Dermatology', '1234567890'),
(3, 'Dr. Emily', 'Taylor', 'Pediatrics', '2345678901'),
(4, 'Dr. Michael', 'Anderson', 'Orthopedics', '3456789012'),
(5, 'Dr. Jessica', 'Thomas', 'Neurology', '4567890123'),
(6, 'Dr. David', 'Jackson', 'General Practice', '5678901234'),
(7, 'Dr. Laura', 'White', 'Gynecology', '6789012345'),
(8, 'Dr. Robert', 'Harris', 'Oncology', '7890123456'),
(9, 'Dr. Linda', 'Martin', 'Ophthalmology', '8901234567'),
(10, 'Dr. William', 'Thompson', 'Psychiatry', '9012345678');

INSERT INTO appointment (appointmentId, patientId, doctorId, appointmentDate, description) VALUES 
(1, 1, 1, '2023-10-01', 'Routine Check'),
(2, 1, 2, '2023-10-05', 'Follow-up Check'),
(3, 2, 1, '2023-10-10', 'Consultation'),
(4, 2, 3, '2023-10-12', 'Annual Check-up'),
(5, 3, 1, '2023-10-15', 'Blood Test'),
(6, 3, 2, '2023-10-20', 'X-Ray'),
(7, 4, 1, '2023-10-22', 'MRI Scan'),
(8, 4, 3, '2023-10-25', 'Check-up'),
(9, 5, 2, '2023-10-28', 'Vaccination'),
(10, 5, 1, '2023-10-30', 'Follow-up Appointment');

SELECT * FROM PATIENT;
SELECT * FROM DOCTOR;
SELECT * FROM APPOINTMENT;