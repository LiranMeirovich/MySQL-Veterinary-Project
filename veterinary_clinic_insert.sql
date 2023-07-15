
INSERT INTO Workers (worker_id, name, last_name, date_of_birth, start_date)
VALUES
(1, 'John', 'Doe', '1980-01-01', '2020-01-01'),
(2, 'Jane', 'Doe', '1985-05-05', '2021-03-01'),
(3, 'Bob', 'Smith', '1990-07-12', '2018-09-01'),
(4, 'Alice', 'Johnson', '1995-12-25', '2022-01-01'),
(5, 'David', 'Brown', '1988-08-08', '2015-07-01'),
(6, 'Liran', 'Cohen', '1985-11-25', '2022-11-06'),
(7, 'Yaffa', 'Levi', '1938-08-10', '2023-05-01'),
(8, 'Nir', 'Sagi', '1995-02-15', '2021-11-03'),
(9, 'Tal', 'Khs', '1993-01-22', '2012-01-11'),
(10, 'Yosi', 'Shalom', '1978-04-04', '2010-03-01'),
(11, 'Obama', 'Michelle', '1961-08-04', '2015-02-06');

INSERT INTO Doctors (worker_id, experience, num_of_diplomas)
VALUES
(1, 5, 3),
(2, 10, 5),
(3, 3, 2),
(4, 1, 1),
(5, 8, 4),
(11,15,3);

INSERT INTO Assistants (worker_id, doctor_id)
VALUES
(6, 1),
(7, 2),
(8, 3),
(9, 4),
(10, 5);

INSERT INTO Client (Client_ID, f_NAME, l_NAME, phone_num, DOB)
VALUES
(1, 'Mary', 'Smith', '123-456-7890', '1982-03-15'),
(2, 'Mike', 'Johnson', '555-555-5555', '1990-10-10'),
(3, 'Karen', 'Williams', '999-999-9999', '1975-07-22'),
(4, 'Tom', 'Brown', '888-888-8888', '1988-12-31'),
(5, 'Jennifer', 'Lee', '777-777-7777', '1995-05-20'),
(6, 'Liran', 'Meirovich', '069-4200240', '1990-03-25');

INSERT INTO Client_vip (Client_ID, POINTS)
VALUES
#(1, 100),
(2, 200),
(3, 300),
(4, 400),
(5, 500);

INSERT INTO pet (chip_num, NAME, DOB, Client_ID)
VALUES
(1, 'Fluffy', '2018-01-01', 1),
(2, 'Max', '2016-05-05', 2),
(3, 'Buddy', '2019-07-12', 3),
(4, 'Luna', '2020-12-25', 4),
(5, 'Rocky', '2015-08-08', 5),
(6, 'Lolo', '2010-10-21', 4),
(7, 'Piter', '2014-09-04', 5),
(8, 'Chupchik', '2014-09-04', 6);

INSERT INTO Diagnosis (dia_name) VALUES 
('Healthy'),
('Heartworm Disease'),
('Parvovirus Infection'),
('Gastric Dilatation and Volvulus'),
('Urinary Tract Infection'),
('Feline Lower Urinary Tract Disease'),
('Chronic Renal Failure'),
('Canine Influenza Virus'),
('Lyme Disease'),
('Rabies'),
('Feline Immunodeficiency Virus'),
('Broken leg'),
('Pneumonia'),
('Heart disease'),
('Ear infection'),
('Skin rash');

INSERT INTO Procedore (procedure_type,follow_up_days) VALUES
('None', 0),
('Vaccination', 0),
('Surgery', 30),
('Radiography', 60),
('Ultrasound', 0),
('Dental cleaning', 0),
('Endoscopy', 5),
('Physical therapy', 0),
('Chemotherapy', 14),
('Blood test', 180),
('Echocardiogram', 0),
('Antibiotics', 7),
('Steroids', 0);


INSERT INTO Sessions (session_id, doctor_id, chip_num, dia_name, procedure_type, prescription_id, date_of_session, type_of_session) VALUES
(1, 1, 1, 'Heartworm Disease', 'Vaccination', 1, '2023-05-15', 'checkup'),
(2, 2, 2, 'Parvovirus Infection', 'Surgery', 2, '2023-05-15', 'treatment'),
(3, 3, 3, 'Gastric Dilatation and Volvulus', 'Radiography', 2, '2023-05-16', 'checkup'),
(4, 4, 4, 'Urinary Tract Infection', 'Ultrasound', 3, '2023-05-16', 'treatment'),
(5, 5, 5, 'Feline Lower Urinary Tract Disease', 'Dental cleaning', 4, '2023-05-17', 'checkup'),
(6, 1, 1, 'Chronic Renal Failure', 'Endoscopy', 1, '2023-05-17', 'treatment'),
(7, 2, 6, 'Canine Influenza Virus', 'Surgery', 5, '2023-05-18', 'checkup'),
(8, 3, 7, 'Lyme Disease', 'Chemotherapy', 5, '2023-05-18', 'treatment'),
(15, 3, 4, 'Lyme Disease', 'Chemotherapy', 8, '2023-03-18', 'treatment'),
(9, 4, 3, 'Rabies', 'Surgery', 5, '2023-05-19', 'checkup'),
(10, 5, 1, 'Feline Immunodeficiency Virus', 'Antibiotics', 7, '2023-05-19', 'treatment'),
(11, 11, 3, 'Ear infection', 'Antibiotics', 7, '2023-05-19', 'checkup'),
(12, 4, 8, 'Canine Influenza Virus', 'Physical therapy', 6, '2023-04-17', 'treatment'),
(13, 1, 1, 'Healthy', 'None', 0, '2023-05-19', 'checkup');


INSERT INTO Prescription (prescription_id, description) VALUES
(1, 'Heartworm preventive medication'),
(2, 'Antibiotic for gastrointestinal infections'),
(3, 'Antibiotic for respiratory and urinary tract infections'),
(4, 'Renal supplement for chronic renal failure'),
(5, 'Flea and tick preventive medication'),
(6, 'Antibiotic for tick-borne diseases'),
(7, 'Treatment for feline immunodeficiency virus'),
(8, 'Flea and tick preventive medication');






INSERT INTO Medication (medication_id, medication_name, expiry_date) VALUES
(1, 'Amoxicillin', '2024-06-30'),
(2, 'Ibuprofen', '2023-12-31'),
(3, 'Fluconazole', '2022-09-30'),
(4, 'Metronidazole', '2022-10-31'),
(5, 'Diphenhydramine', '2023-06-30');


INSERT INTO Medication_Lines (prescription_id, medication_id, medication_amount) VALUES
(1, 1, 500),
(1, 2, 400),
(3, 3, 200),
(4, 4, 800),
(6, 3, 200),
(7, 1, 100),
(5, 5, 300),
(8, 5, 300),
(8, 2, 100);

INSERT INTO cat (chip_num, breed) VALUES
(2, 'Siamese'),
(3, 'Maine Coon');

INSERT INTO Hospitalization (file_num, chip_num, dia_name, procedure_type, end_date, start_date) VALUES
(1, 1, 'Broken leg', 'Surgery', '2022-05-01', '2022-04-28'),
(2, 5, 'Pneumonia', 'Antibiotics', '2022-06-15', '2022-06-10'),
(3, 2, 'Heart disease', 'Surgery', '2022-07-30', '2022-07-25'),
(4, 3, 'Ear infection', 'Antibiotics', '2023-05-19', '2023-05-20'),
(5, 4, 'Skin rash', 'Steroids', '2022-09-01', '2022-08-27'),
(6, 4, 'Skin rash', 'Steroids', '2022-05-01', '2022-04-27');


INSERT INTO Vaccine (ID, NAME, Expiry_Date) VALUES
(1, 'Rabies', '2023-06-01'),
(2, 'Distemper', '2024-01-01'),
(3, 'Parvovirus', '2024-12-31'),
(4, 'Leptospirosis', '2023-11-01'),
(5, 'Bordetella', '2023-09-15');

INSERT INTO recieve_Vaccine (Vaccine_ID, chip_num, Date) VALUES
(1, 1, '2022-04-01'),
(2, 6, '2022-06-01'),
(3, 2, '2022-07-01'),
(4, 7, '2022-08-01'),
(5, 3, '2022-09-01'),
(5, 6, '2023-04-01');

INSERT INTO rodent (chip_num, weight) VALUES
(1, 0.5),
(5, 0.75),
(7, 1.2),
(8, 0.69);


INSERT INTO dog (chip_num, breed) VALUES
(4, 'Labrador Retriever'),
(6, 'German Shepherd');

INSERT INTO Orders (Orders_num, Client_ID) VALUES
(1, 1),
(2, 5),
(3, 3),
(4, 2),
(6, 4),
(5, 4);

INSERT INTO food (barcode, NAME, food_stock) VALUES
(1, 'Cat Food', 100),
(2, 'Dog Food', 200),
(3, 'old Dog Food', 300),
(4, 'rodent Food', 400),
(5, 'Medical cat Food', 500);

INSERT INTO Accessories (barcode, NAME, accessories_stock) VALUES 
(1, 'Collar', 10),
(2, 'Cat Bed', 12),
(3, 'Toys', 13),
(4, 'Brushe', 2),
(5, 'Food bowl', 5);


INSERT INTO order_food (Orders_num, barcode, amount) VALUES
(1, 2, 2),
(3, 3, 3),
(4, 4, 7),
(5, 3, 9),
(2, 1, 3);
 
INSERT INTO order_Accessories (Orders_num, barcode, amount) VALUES 
(1, 1, 3),
(4, 4, 2),
(2, 3, 10),
(2, 1, 2),
(5, 5, 8),
(6, 1, 2);


/*
UPDATE pet
SET pet.status = 0
WHERE pet.client_id = 4; 

DELETE FROM sessions
WHERE chip_num = 1;

DELETE FROM order_food
WHERE orders_num = 1;

DELETE FROM orders
WHERE orders_num = 3;

DELETE FROM orders
WHERE orders_num = 2;

*/
