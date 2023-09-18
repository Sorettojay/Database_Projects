  /*Creating the Database*/
 CREATE DATABASE Hospital_Database;

/*Create stored procedues for database and table creation*/

/*Adding the tables*/
CREATE TABLE physician
(
employee_id INT NOT NULL UNIQUE PRIMARY KEY,
first_name CHAR(100) NOT NULL,
last_name CHAR(100),
position TEXT NOT NULL,
ssn VARCHAR(11) NOT NULL
);

CREATE TABLE department
(
department_id INT NOT NULL PRIMARY KEY,
name TEXT,
head INT,
FOREIGN KEY (head) REFERENCES physician(employee_id)
);

CREATE TABLE affiliated_with
(
physician INT,
department INT,
primaryaffiliation BOOL
);

CREATE TABLE _procedure_
(
code INT PRIMARY KEY,
name char(30),
cost REAL
);

CREATE TABLE trained_in
(
FOREIGN KEY (physician) REFERENCES physician(employee_id),
FOREIGN KEY (treatment) REFERENCES _procedure_(_code),
certification_date DATE,
certification_expires DATE
);

CREATE TABLE patient
(
ssn VARCHAR(11) NOT NULL UNIQUE PRIMARY KEY,
name CHAR(30),
address VARCHAR(100),
phone VARCHAR(12),
insurance_id INT UNIQUE,
FOREIGN KEY (pcp) REFERENCES physician(employee_id)
);

CREATE TABLE nurse
(
employee_id INT NOT NULL UNIQUE PRIMARY KEY,
name CHAR(30),
position CHAR(30),
registered BIT(1),
ssn VARCHAR(11)
);

CREATE TABLE appointment
(
appointment_id INT NOT NULL UNIQUE PRIMARY KEY,
FOREIGN KEY (patient) REFERENCES patient.ssn,
FOREIGN KEY (prepnurse) REFERENCES nurse.employee_id,
FOREIGN KEY (physician) REFERENCES physician.employee_id,
start_dt_time DATETIME,
end_dt_time DATETIME,
examination_room TEXT
);

CREATE TABLE medication
(
code INT NOT NULL UNIQUE,
name TEXT,
brand TEXT,
description TEXT
);

CREATE TABLE prescribes
(
FOREIGN KEY (physician) REFERENCES physician.employee_id,
FOREIGN KEY (patient) REFERENCES patient.ssn,
FOREIGN KEY (medication) REFERENCES medication.code,
date DATETIME,
FOREIGN KEY (appointment) REFERENCES appointment.appointment_id,
dose TEXT
);

CREATE TABLE block
(
block_floor INT NOT NULL UNIQUE,
block_code INT NOT NULL UNIQUE
);

CREATE TABLE room
(
room_number INT NOT NULL UNIQUE,
room_type TEXT,
block_floor INT NOT NULL UNIQUE,
block_code INT NOT NULL UNIQUE,
unavailable BIT(1)
);

CREATE TABLE on_call
(
FOREIGN KEY (nurse) REFERENCES nurse.employee_id,
block_floor INT NOT NULL UNIQUE,
block_code INT NOT NULL UNIQUE,
on_call_start DATETIME,
on_call_end DATETIME
);

CREATE TABLE stay
(
stayid INT NOT NULL UNIQUE,
FOREIGN KEY (patient) REFERENCES patient.ssn,
FOREIGN KEY (room) REFERENCES room.room_number,
start_time TIME,
end_time TIME
);

CREATE TABLE undergoes
(
FOREIGN KEY (patient) REFERENCES patient.ssn,
FOREIGN KEY (_procedure_) REFERENCES _procedure_.code,
FOREIGN KEY (stay) REFERENCES stay.stayid,
date DATE,
FOREIGN KEY (patient) REFERENCES physician.employeeid,
FOREIGN KEY (assisting_nurse) REFERENCES nurse.employee_id
);
