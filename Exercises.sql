/*A list of queries for the given exercises. Gathered from the link below*/

/*https://www.w3resource.com/sql-exercises/hospital-database-exercise/sql-exercise-on-hospital-database.php*/

/*************************************************************************************************************/

/*From the following table, 
write a SQL query to find out which nurses have not yet been registered. 
Return all the fields of nurse table*/

SELECT * FROM nurse WHERE registered = 0; 

/*write a SQL query to identify the nurses in charge of a department. 
Return nursename as “name”, Position as “Position”.*/

SELECT name, position FROM nurse WHERE position = "Head Nurse";

/*Write a SQL query to identify the physicians who are the department heads. 
Return Department name as “Department” and Physician name as “Physician”.*/

SELECT department.name, physician.name FROM physician INNER JOIN department ON department.department_id = physician.employee_id;

/*write a SQL query to count the number of patients who scheduled an appointment with at least one physician. 
Return count as "Number of patients taken at least one appointment*/

SELECT COUNT(DISTINCT patient) AS "No. of patients taken at least one appointment" FROM appointment;




