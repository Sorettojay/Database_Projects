
 /*Creating the Database*/
DELIMITER //
CREATE PROCEDURE Hospital_Database_Creation()
BEGIN
CREATE DATABASE Hospital_Database;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE Hospital_Database_Tables_Creation()
BEGIN
	CREATE TABLE Physician(employee_id INT NOT NULL UNIQUE PRIMARY KEY, name CHAR(100), position TEXT NOT NULL, ssn VARCHAR(9) NOT NULL);
    CREATE TABLE Department(department_id INT NOT NULL PRIMARY KEY, name TEXT, head INT, FOREIGN KEY (head) REFERENCES Physician(employee_id));
	CREATE TABLE Affiliated_with(physician INT, department INT, primaryaffiliation BOOL);
	CREATE TABLE _Procedure_(code INT PRIMARY KEY, name char(30), cost REAL);
	CREATE TABLE Trained_in(physician INT, treatment INT, FOREIGN KEY (physician) REFERENCES Physician(employee_id), FOREIGN KEY (treatment) REFERENCES _Procedure_(code), certification_date DATE, certification_expires DATE);
	CREATE TABLE Patient(ssn VARCHAR(11) NOT NULL UNIQUE PRIMARY KEY, name CHAR(30), address VARCHAR(100), phone VARCHAR(12), insurance_id INT UNIQUE, pcp INT, FOREIGN KEY (pcp) REFERENCES Physician(employee_id));
	CREATE TABLE Nurse(employee_id INT NOT NULL UNIQUE PRIMARY KEY, name CHAR(30), position CHAR(30), registered BIT(1), ssn VARCHAR(11));
	CREATE TABLE Appointment(appointment_id INT NOT NULL UNIQUE PRIMARY KEY, patient VARCHAR(11), prep_nurse INT, physician INT, FOREIGN KEY (patient) REFERENCES Patient(ssn), FOREIGN KEY (prep_nurse) REFERENCES Nurse(employee_id), FOREIGN KEY (physician) REFERENCES Physician(employee_id), start_dt_time DATETIME, end_dt_time DATETIME, examination_room TEXT);
	CREATE TABLE Medication(code INT NOT NULL UNIQUE, name TEXT, brand TEXT, description TEXT);
	CREATE TABLE Prescribes(physician INT, patient VARCHAR(11), medication INT, appointment INT, FOREIGN KEY (physician) REFERENCES Physician(employee_id), FOREIGN KEY (patient) REFERENCES Patient(ssn), FOREIGN KEY (medication) REFERENCES Medication(code), FOREIGN KEY (appointment) REFERENCES Appointment(appointment_id), date DATETIME, dose TEXT);
	CREATE TABLE Block(block_floor INT NOT NULL UNIQUE, block_code INT NOT NULL UNIQUE);
	CREATE TABLE Room(room_number INT NOT NULL UNIQUE, room_type TEXT, block_floor INT NOT NULL UNIQUE, block_code INT NOT NULL UNIQUE, unavailable BIT(1));
	CREATE TABLE On_call(nurse INT NOT NULL UNIQUE PRIMARY KEY, FOREIGN KEY (nurse) REFERENCES Nurse(employee_id), block_floor INT NOT NULL UNIQUE, block_code INT NOT NULL UNIQUE,on_call_start DATETIME, on_call_end DATETIME);
	CREATE TABLE Stay(stayid INT NOT NULL UNIQUE, patient VARCHAR(11), room INT, FOREIGN KEY (patient) REFERENCES Patient(ssn), FOREIGN KEY (room) REFERENCES Room(room_number), start_time TIME, end_time TIME);
	CREATE TABLE Undergoes(ssn VARCHAR(11), patient INT, _procedure_ INT, stay INT, physician INT, assisting_nurse INT, FOREIGN KEY (ssn) REFERENCES Patient(ssn), FOREIGN KEY (_procedure_) REFERENCES _Procedure_(code), FOREIGN KEY (stay) REFERENCES Stay(stayid), date DATE, FOREIGN KEY (patient) REFERENCES Physician(employee_id), FOREIGN KEY (assisting_nurse) REFERENCES Nurse(employee_id));
END //
DELIMITER ;

DELIMITER // 
CREATE PROCEDURE Delete_Database_Tables()
BEGIN
	DROP TABLES appointment, affiliated_with, _procedure_, block, department, medication, nurse, on_call, patient, physician, prescribes, room, stay, trained_in, undergoes;
END //
DELIMITER ;

DELIMITER // 
CREATE PROCEDURE Delete_Procedures()
BEGIN
	DROP PROCEDURE Hospital_Database_Creation;
    DROP PROCEDURE Hospital_Database_Tables_Creation;
END //
DELIMITER ;


CALL Hospital_Database_Creation;
CALL Hospital_Database_Tables_Creation;
CALL Delete_Database_Tables;

DROP PROCEDURE Delete_Database_Tables;

/*
CREATE TABLE Affiliated_with(physician INT, department INT, primaryaffiliation BOOL);
CREATE TABLE _Procedure_(code INT PRIMARY KEY, name char(30), cost REAL);
CREATE TABLE Trained_in(physician INT, treatment INT, FOREIGN KEY (physician) REFERENCES Physician(employee_id), FOREIGN KEY (treatment) REFERENCES _Procedure_(code), certification_date DATE, certification_expires DATE);
CREATE TABLE Patient(ssn VARCHAR(11) NOT NULL UNIQUE PRIMARY KEY, name CHAR(30), address VARCHAR(100), phone VARCHAR(12), insurance_id INT UNIQUE, pcp INT, FOREIGN KEY (pcp) REFERENCES Physician(employee_id));
CREATE TABLE Nurse(employee_id INT NOT NULL UNIQUE PRIMARY KEY, name CHAR(30), position CHAR(30), registered BIT(1), ssn VARCHAR(11));
CREATE TABLE Appointment(appointment_id INT NOT NULL UNIQUE PRIMARY KEY, patient VARCHAR(11), prep_nurse INT, physician INT, FOREIGN KEY (patient) REFERENCES Patient(ssn), FOREIGN KEY (prep_nurse) REFERENCES Nurse(employee_id), FOREIGN KEY (physician) REFERENCES Physician(employee_id), start_dt_time DATETIME, end_dt_time DATETIME, examination_room TEXT);
CREATE TABLE Medication(code INT NOT NULL UNIQUE, name TEXT, brand TEXT, description TEXT);
CREATE TABLE Prescribes(physician INT, patient VARCHAR(11), medication INT, appointment INT, FOREIGN KEY (physician) REFERENCES Physician(employee_id), FOREIGN KEY (patient) REFERENCES Patient(ssn), FOREIGN KEY (medication) REFERENCES Medication(code), FOREIGN KEY (appointment) REFERENCES Appointment(appointment_id), date DATETIME, dose TEXT);
CREATE TABLE Block(block_floor INT NOT NULL UNIQUE, block_code INT NOT NULL UNIQUE);
CREATE TABLE Room(room_number INT NOT NULL UNIQUE, room_type TEXT, block_floor INT NOT NULL UNIQUE, block_code INT NOT NULL UNIQUE, unavailable BIT(1));
CREATE TABLE On_call(nurse INT NOT NULL UNIQUE PRIMARY KEY, FOREIGN KEY (nurse) REFERENCES Nurse(employee_id), block_floor INT NOT NULL UNIQUE, block_code INT NOT NULL UNIQUE,on_call_start DATETIME, on_call_end DATETIME);
CREATE TABLE Stay(stayid INT NOT NULL UNIQUE, patient VARCHAR(11), room INT, FOREIGN KEY (patient) REFERENCES Patient(ssn), FOREIGN KEY (room) REFERENCES Room(room_number), start_time TIME, end_time TIME);
CREATE TABLE Undergoes(ssn VARCHAR(11), patient INT, _procedure_ INT, stay INT, physician INT, assisting_nurse INT, FOREIGN KEY (ssn) REFERENCES Patient(ssn), FOREIGN KEY (_procedure_) REFERENCES _Procedure_(code), FOREIGN KEY (stay) REFERENCES Stay(stayid), date DATE, FOREIGN KEY (patient) REFERENCES Physician(employee_id), FOREIGN KEY (assisting_nurse) REFERENCES Nurse(employee_id));
*/
