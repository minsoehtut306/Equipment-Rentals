# INTRO_USERS – Windows Forms Database Application

A simple **C# Windows Forms** project with a **SQL Server** backend.  
It demonstrates user login, registration, and browsing of session data linked to social media platforms.

---

## Features

- **Login**: authenticate against the `Users` table.  
- **Register**: add new users to the database.  
- **Browse**: search user sessions by username and social media.  
- **Database**: includes `Users`, `SocialMedia`, and `UserSession` tables with sample data.

---

## Language Used

- C# (.NET WinForms)  
- SQL Server (T-SQL schema + data in `INTRO_USERS.sql`)  
- ADO.NET (System.Data.SqlClient)

---

## How to Run

1. Create the database in SQL Server using the script in `INTRO_USERS.sql`.  
2. Open `INTRO_USERS.sln` in Visual Studio.  
3. Update the connection string in `SQL.cs` if needed.  
4. Build and run the project.

---

## Notes

- Passwords stored in plain text (demo only).  
- Queries use string concatenation → vulnerable to SQL injection.  

This project was completed as part of the Bachelor of Computer Science degree at the University of Waikato.  
It is published here solely for educational and portfolio purposes, to showcase my skills in software development.  

All code presented is my own work. Course-specific materials such as assignment descriptions or test data are not included to respect university policies.  


