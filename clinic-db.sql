-- ===========================================
--  Clinic Booking System Database
--  Database Final Project SQL File
-- ===========================================

-- Step 1: Create the Database
CREATE DATABASE clinic_db;
USE clinic_db;

-- ============================
-- Step 2: Patients Table
-- Stores personal details of patients.
-- Each patient has a unique ID, contact info, and demographics.
-- ============================
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,   -- Unique patient identifier
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(15) UNIQUE,                    -- Enforces unique phone number
    email VARCHAR(100) UNIQUE,                   -- Enforces unique email
    address VARCHAR(200)
) ENGINE=InnoDB;

-- ============================
-- Step 3: Doctors Table
-- Stores doctor information (basic bio and contacts).
-- ============================
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,    -- Unique doctor identifier
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
) ENGINE=InnoDB;

-- ============================
-- Step 3b: Specialties Table
-- A doctor can have multiple specialties (many-to-many relationship).
-- ============================
CREATE TABLE specialties (
    specialty_id INT AUTO_INCREMENT PRIMARY KEY,
    specialty_name VARCHAR(100) NOT NULL UNIQUE  -- Example: "Cardiology", "Pediatrics"
) ENGINE=InnoDB;

-- Junction table for doctor-specialty mapping
CREATE TABLE doctor_specialties (
    doctor_id INT NOT NULL,
    specialty_id INT NOT NULL,
    PRIMARY KEY (doctor_id, specialty_id),       -- Prevents duplicates
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (specialty_id) REFERENCES specialties(specialty_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================
-- Step 4: Appointments Table
-- Links patients to doctors with date, time, and status.
-- ============================
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    reason VARCHAR(200),                          -- Reason for the visit
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================
-- Step 5: Medical Records Table
-- Stores diagnoses, treatments, and medical notes.
-- Each appointment may have one medical record.
-- ============================
CREATE TABLE medical_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT,                                -- Doctor who authored the record
    appointment_id INT UNIQUE,                    -- One-to-one link with appointment
    diagnosis TEXT NOT NULL,
    treatment TEXT,
    record_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================
-- Step 6: Medicines Table
-- Catalog of available medicines.
-- ============================
CREATE TABLE medicines (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,           -- Medicine name
    description TEXT,
    manufacturer VARCHAR(100),
    price DECIMAL(10,2) NOT NULL                 -- Price per unit
) ENGINE=InnoDB;

-- ============================
-- Step 7: Prescriptions Table
-- Links medical records to medicines.
-- A record can have multiple prescriptions.
-- ============================
CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    record_id INT NOT NULL,
    medicine_id INT NOT NULL,
    dosage VARCHAR(50) NOT NULL,                  -- Example: "500mg"
    frequency VARCHAR(50) NOT NULL,               -- Example: "Twice a day"
    duration VARCHAR(50),                         -- Example: "7 days"
    FOREIGN KEY (record_id) REFERENCES medical_records(record_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================
-- Step 8: Billing Table
-- Tracks billing and payment for appointments.
-- ============================
CREATE TABLE billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    appointment_id INT UNIQUE,                   -- One-to-one with appointment
    total_amount DECIMAL(10,2) NOT NULL,         -- Total bill
    amount_paid DECIMAL(10,2) DEFAULT 0.00,      -- Amount already paid
    payment_status ENUM('Pending', 'Partial', 'Paid') DEFAULT 'Pending',
    payment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================
-- Step 9: Inventory Table
-- Tracks stock levels for medicines.
-- ============================
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_id INT NOT NULL,
    quantity INT NOT NULL,                        -- Current stock
    reorder_level INT DEFAULT 10,                 -- Low stock threshold
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
                 ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================
-- Step 10: Indexes for Performance
-- Helps speed up queries on frequently searched columns.
-- ============================
CREATE INDEX idx_patient ON appointments(patient_id);
CREATE INDEX idx_doctor ON appointments(doctor_id);
CREATE INDEX idx_record_patient ON medical_records(patient_id);
CREATE INDEX idx_prescription_record ON prescriptions(record_id);

-- ===========================================
-- END OF SCHEMA
-- ===========================================
