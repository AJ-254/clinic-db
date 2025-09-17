# 🏥 Clinic Booking System Database

## 📌 Project Overview
This project is a **relational database management system** built with **MySQL** to manage a clinic or small hospital.  
It covers essential operations such as **patient management, doctor scheduling, specialties, medical records, prescriptions, billing, and inventory tracking**.

The project was developed as a **Database Final Project**.

---

## 🎯 Objectives
- Design a real-world relational database schema.
- Implement proper **relationships**: one-to-one, one-to-many, and many-to-many.
- Enforce constraints: **PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL**.
- Demonstrate practical database design for healthcare systems.

---

## 🗂️ Database Schema

The database contains the following tables:

1. **patients** – Stores patient personal details.  
2. **doctors** – Stores doctor information.  
3. **specialties** – Stores different medical specialties.  
4. **doctor_specialties** – Junction table for many-to-many relationship between doctors and specialties.  
5. **appointments** – Manages patient-doctor appointments.  
6. **medical_records** – Stores diagnoses, treatments, and links to appointments.  
7. **medicines** – Catalog of available medicines.  
8. **prescriptions** – Links medical records to prescribed medicines.  
9. **billing** – Tracks patient payments, bills, and statuses (linked one-to-one with appointments).  
10. **inventory** – Tracks medicine stock levels and restocking alerts.  

---

## 🔑 Relationships
- One **patient** can have many **appointments** (one-to-many).  
- One **doctor** can have many **appointments** (one-to-many).  
- One **doctor** can belong to many **specialties**, and each **specialty** can apply to many **doctors** (many-to-many via `doctor_specialties`).  
- One **appointment** can have one **medical record** (one-to-one).  
- One **medical record** can generate many **prescriptions** (one-to-many).  
- One **prescription** links to one **medicine** (one-to-one).  
- One **medicine** can appear in both **inventory** and **prescriptions**.  
- One **appointment** can have one **bill** (one-to-one).  
- One **patient** can have many **bills** (one-to-many).  

---

## ⚙️ How to Run the Project

1. **Clone this repository:**
   ```bash
   git clone https://github.com/AJ-254/clinic-db.git

2. **Open MySQL and run the schema file:**
   sql
   SOURCE clinic_db.sql;

3. The database will be created as clinic_db.

---

### 🏆 Deliverables

* clinic_db.sql → Full database schema with tables, constraints, and relationships.
* README.md → Project documentation (this file).

---

### ✍️ Author
Juliet Asiedu