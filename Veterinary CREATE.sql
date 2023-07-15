drop schema if exists veterinary_clinic;
create schema veterinary_clinic;
use veterinary_clinic;
CREATE TABLE Workers
(
    worker_id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    date_of_birth  DATE NOT NULL,
    start_date  DATE NOT NULL,
    salary INT DEFAULT(5500)
)ENGINE = InnoDB;

CREATE TABLE Doctors
(
	worker_id INT NOT NULL,
    experience INT DEFAULT(0), #need to think about this
    num_of_diplomas INT DEFAULT(0),
    PRIMARY KEY (worker_id),
    FOREIGN KEY (worker_id) REFERENCES Workers(worker_id) ON DELETE CASCADE
)ENGINE = InnoDB;

CREATE TABLE Assistants
(
	worker_id INT NOT NULL,
    doctor_id INT NOT NULL, #maybe can be null if there is one assistant that helps in general
    PRIMARY KEY (worker_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(worker_id),
    FOREIGN KEY (worker_id) REFERENCES Workers(worker_id)
)ENGINE = InnoDB;


CREATE TABLE Client
(Client_ID		int NOT NULL,
f_NAME			varchar(255),
l_NAME			varchar(255),
phone_num			varchar(255),
DOB		 		date,
amount_of_pets		int DEFAULT(0),
order_amount 		INT DEFAULT(0),
PRIMARY KEY (Client_ID)
)ENGINE = InnoDB;


CREATE TABLE Client_vip
(Client_ID		int NOT NULL,
POINTS			int,
PRIMARY KEY		(Client_ID),
CONSTRAINT fk_cln
FOREIGN KEY (Client_ID) REFERENCES Client(Client_ID)
)ENGINE = InnoDB;

CREATE TABLE pet
(chip_num			int NOT NULL,
NAME				varchar(255),
DOB		 			date,
Client_ID			int NOT NULL,
amount_of_visits 	int DEFAULT(0),
state 				VARCHAR(35) DEFAULT('Healthy'),
status				INT DEFAULT(1),
PRIMARY KEY	(chip_num),
CONSTRAINT 	fk_pet
FOREIGN KEY (Client_ID) REFERENCES Client(Client_ID)
)ENGINE = InnoDB;

CREATE TABLE Diagnosis
(
	dia_name VARCHAR(50) PRIMARY KEY
)ENGINE = InnoDB;


CREATE TABLE Sessions
(
	session_id INT PRIMARY KEY,
    doctor_id INT NOT NULL,
    chip_num INT NOT NULL,
	dia_name VARCHAR(50) NOT NULL,
    procedure_type VARCHAR(50),#foreign key?
    prescription_id INT,
    date_of_session DATE NOT NULL,
    type_of_session VARCHAR(50) NOT NULL,
    
    FOREIGN KEY (doctor_id) REFERENCES Doctors(worker_id),
    FOREIGN KEY (chip_num) REFERENCES pet(chip_num),
    FOREIGN KEY (dia_name) REFERENCES Diagnosis(dia_name)#need to decide if there is 1 diagnosis per session or multiple
    
    
)ENGINE = InnoDB;

CREATE TABLE Prescription
(
    prescription_id INT PRIMARY KEY,
    description VARCHAR(100)
    
)ENGINE = InnoDB;


CREATE TABLE Medication
(
    medication_id INT PRIMARY KEY,
    medication_name VARCHAR(50),
    expiry_date DATE
    
)ENGINE = InnoDB;



CREATE TABLE Medication_Lines
(
    prescription_id INT NOT NULL,
    medication_id INT NOT NULL,
    medication_amount INT NOT NULL,
    
    FOREIGN KEY (prescription_id) REFERENCES Prescription(prescription_id),
    FOREIGN KEY (medication_id) REFERENCES Medication(medication_id)
    
)ENGINE = InnoDB;

CREATE TABLE Procedore 
(
    procedure_type 	VARCHAR(50) PRIMARY KEY,
    follow_up_days	INT DEFAULT(0)
)ENGINE = InnoDB;




CREATE TABLE Hospitalization
(
	file_num INT PRIMARY KEY,
    chip_num INT,
    dia_name VARCHAR(50) NOT NULL,
    procedure_type VARCHAR(50),
    end_date DATE,
    start_date DATE,
    
    FOREIGN KEY (chip_num) REFERENCES pet(chip_num),
    FOREIGN KEY (dia_name) REFERENCES Diagnosis(dia_name),
    FOREIGN KEY (procedure_type) REFERENCES Procedore(procedure_type)    
)ENGINE = InnoDB;




CREATE TABLE Vaccine
(ID		int NOT NULL,
NAME			varchar(255),
Expiry_Date		 		date,
PRIMARY KEY		(ID)
)ENGINE = InnoDB;

CREATE TABLE recieve_Vaccine
(Vaccine_ID				int NOT NULL,
chip_num				int NOT NULL,
date 					date,
status 					VARCHAR(20) DEFAULT("RECIEVED"),
CONSTRAINT fk_pets
FOREIGN KEY (chip_num) REFERENCES pet(chip_num),
CONSTRAINT fk_vac
FOREIGN KEY (Vaccine_ID) REFERENCES Vaccine(ID)
)ENGINE = InnoDB;

CREATE TABLE rodent
(chip_num		int NOT NULL,
weight			float,
PRIMARY KEY		(chip_num),
CONSTRAINT fk_rod
FOREIGN KEY (chip_num) REFERENCES pet(chip_num) ON DELETE CASCADE
)ENGINE = InnoDB;

CREATE TABLE cat
(chip_num		int NOT NULL,
breed			varchar(25),
num_of_lives		INT DEFAULT(9),
PRIMARY KEY		(chip_num),
CONSTRAINT fk_cat
FOREIGN KEY (chip_num) REFERENCES pet(chip_num) ON DELETE CASCADE
)ENGINE = InnoDB;

CREATE TABLE dog
(chip_num		int NOT NULL,
breed			varchar(25),
PRIMARY KEY		(chip_num),
CONSTRAINT fk_dog
FOREIGN KEY (chip_num) REFERENCES pet(chip_num) ON DELETE CASCADE
)ENGINE = InnoDB;


CREATE TABLE Orders
(Orders_num		int NOT NULL,
Client_ID		int NOT NULL,
PRIMARY KEY		(Orders_num),
CONSTRAINT fk_ord
FOREIGN KEY (Client_ID) REFERENCES Client(Client_ID) ON DELETE CASCADE
)ENGINE = InnoDB;

CREATE TABLE food
(barcode		int NOT NULL,
NAME			varchar(25),
food_stock INT DEFAULT(0),
PRIMARY KEY		(barcode)
)ENGINE = InnoDB;

CREATE TABLE Accessories
(barcode			int NOT NULL,
NAME				varchar(25),
accessories_stock 	INT DEFAULT(0),
PRIMARY KEY		(barcode)
)ENGINE = InnoDB;

CREATE TABLE order_food
(Orders_num		int NOT NULL,
barcode			int NOT NULL,
amount 			int NOT NULL,
status 			VARCHAR(20),
CONSTRAINT fk_ord_food
FOREIGN KEY (Orders_num) REFERENCES Orders(Orders_num) ON DELETE CASCADE,
CONSTRAINT fk_ord_food2
FOREIGN KEY (barcode) REFERENCES food(barcode)
)ENGINE = InnoDB;

CREATE TABLE order_Accessories
(Orders_num		int NOT NULL,
barcode		int NOT NULL,
amount 		int NOT NULL,
status 			VARCHAR(20),
CONSTRAINT fk_ord_acc	
FOREIGN KEY (Orders_num) REFERENCES Orders(Orders_num),
CONSTRAINT fk_ord_acs
FOREIGN KEY (barcode) REFERENCES Accessories(barcode)
)ENGINE = InnoDB;