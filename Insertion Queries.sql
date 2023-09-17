 
 /*Creating the Database*/
 CREATE DATABASE Hospital_Database;
 
/*Adding the tables*/

CREATE TABLE Physicians
(
employee_id INT,
first_name CHAR(100),
last_name CHAR(100),
position TEXT,
ssn VARCHAR(9)
);

CREATE TABLE Department
(
department_id INT,
name TEXT,
head INT,
FOREIGN KEY head REFERENCES(Physicians(employee_id))
);

CREATE TABLE Affiliated_with
(
physician INT,
department INT,
primaryaffiliation BOOL
);
