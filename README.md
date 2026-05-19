# Content Management System

## Project Description
This is a mini Content Management System (CMS) project developed using Java JSP, MySQL, HTML, and CSS.  
The project allows an admin to manage website content through a simple dashboard.

---

## Technologies Used
- Java
- JSP
- MySQL
- HTML
- CSS
- Apache Tomcat

---

## Features
- Admin Login
- Dashboard Page
- Add New Content
- Store Data in MySQL Database
- Simple Responsive UI

---

## Project Structure
ContentManagementSystem/
│
├── index.jsp
├── login.jsp
├── dashboard.jsp
├── addpost.jsp
├── db.jsp
├── style.css
└── README.md

---

## Database Setup

Run these SQL commands in MySQL Workbench:

```sql
CREATE DATABASE cms_db;

USE cms_db;

CREATE TABLE posts(
 id INT PRIMARY KEY AUTO_INCREMENT,
 title VARCHAR(100),
 content TEXT
);

How to Run the Project
Install Java JDK
Install MySQL
Install Apache Tomcat
Copy project folder into Tomcat webapps folder
Start Tomcat server
Open browser:
http://localhost:8080/ContentManagementSystem

Output
Homepage
Login Page
Admin Dashboard
Add Content Page
Data Stored in MySQL
