USE veterinary_clinic;

#1 all pets that underwent a surgery 
SELECT pet.*
FROM pet, sessions
WHERE pet.chip_num = sessions.chip_num AND sessions.procedure_type LIKE 'surgery'
GROUP BY pet.chip_num;

#2 all doctors which name starts with O
SELECT workers.*
FROM doctors, workers
WHERE doctors.worker_id = workers.worker_id AND workers.name LIKE 'O%';

#3 pairs of pets that have been hospitalized together at least for a day 
SELECT p1.chip_num, p1.name , p2.chip_num , p2.name
FROM pet p1
JOIN hospitalization h1 ON p1.chip_num = h1.chip_num
JOIN pet p2 ON p1.chip_num < p2.chip_num
JOIN hospitalization h2 ON p2.chip_num = h2.chip_num
WHERE (h1.start_date <= h2.end_date AND h1.end_date >= h2.start_date)
   OR (h2.start_date <= h1.end_date AND h2.end_date >= h1.start_date);

#4 find the medication that was prescribed most for the diagnosis "Lyme Disease"  
SELECT m.medication_name, COUNT(*) AS prescription_count
FROM Sessions s
JOIN Diagnosis d ON s.dia_name = d.dia_name
JOIN Prescription p ON s.prescription_id = p.prescription_id
JOIN Medication_Lines ml ON p.prescription_id = ml.prescription_id
JOIN Medication m ON ml.medication_id = m.medication_id
WHERE d.dia_name = 'Lyme Disease'
GROUP BY m.medication_name
ORDER BY prescription_count DESC
LIMIT 1;

#5 all clients with more than 100 vip points
SELECT client.*
from client, client_vip
WHERE client.Client_ID = client_vip.Client_ID
AND client_vip.POINTS >= 100;

#6 all pets that had ear infection
SELECT COUNT(pet.chip_num)
FROM pet, sessions
WHERE pet.chip_num = sessions.chip_num AND sessions.dia_name LIKE 'ear infection'
GROUP BY pet.chip_num;

#7 all doctors that had a session with Liran Meirovich's rodents
SELECT COUNT(doctors.worker_id) as num_of_doctors
FROM doctors
INNER JOIN sessions as S ON doctors.worker_id = S.doctor_id
INNER JOIN pet as P ON P.chip_num = S.chip_num
INNER JOIN rodent as R ON R.chip_num = P.chip_num
INNER JOIN client as C ON C.Client_ID = P.Client_ID
WHERE C.f_name LIKE 'Liran' AND C.l_name LIKE 'Meirovich'
GROUP BY doctors.worker_id;

#8 all dogs that had vaccine number 5 in the last 6 months
SELECT pet.* 
FROM pet
INNER JOIN dog AS D ON D.chip_num = pet.chip_num
INNER JOIN recieve_vaccine AS RC ON RC.chip_num = D.chip_num
WHERE RC.Vaccine_ID = 5 AND DATEDIFF(CURDATE(), RC.date)/30 <= 6
GROUP BY D.chip_num;

#9 Find medication given to most amount of pets
SELECT medication.*
FROM medication  
INNER JOIN medication_lines as ML ON ML.medication_id = medication.medication_id
INNER JOIN prescription as P ON P.prescription_id = ML.prescription_id
INNER JOIN sessions as S ON S.prescription_id = P.prescription_id
GROUP BY medication.medication_id
ORDER BY COUNT(distinct S.chip_num) desc
LIMIT 1;

#10 least popular accessories
SELECT accessories.*, SUM(amount) AS total_num_of_items
FROM accessories
INNER JOIN order_accessories AS OS ON OS.barcode = accessories.barcode
GROUP BY accessories.barcode
ORDER BY total_num_of_items ASC
LIMIT 3;





