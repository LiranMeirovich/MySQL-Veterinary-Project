use veterinary_clinic;

#1 shows what was sold more: accessories or food
DELIMITER &&  
CREATE PROCEDURE get_best_selling_category ()
BEGIN  
    DECLARE foodCount int;
    DECLARE accessoriesCount int;
    
    SELECT SUM(amount) INTO foodCount
    FROM order_food as or_f INNER JOIN orders as o1 ON or_f.orders_num = o1.orders_num;
    SELECT SUM(amount) INTO accessoriesCount
    FROM order_Accessories as or_a INNER JOIN orders as o2 ON or_a.orders_num = o2.orders_num;
    
    IF foodCount > accessoriesCount THEN
        SELECT 'Food' AS best_selling_category;
    ELSEIF accessoriesCount > foodCount THEN
        SELECT 'Accessories' AS best_selling_category;
    ELSE
        SELECT 'Food and Accessories sold in equal quantity' AS best_selling_category;
    END IF;
END &&  
DELIMITER ;  

CALL get_best_selling_category ();


#2 	Get pet by name
DELIMITER &&  
CREATE PROCEDURE get_pet_by_chip_num (IN var1 int,out var2 varchar(25))  
BEGIN  
    SELECT pet.name INTO var2 FROM pet WHERE pet.chip_num = var1;   
END &&  
DELIMITER ;  

 SET @M = 7; 
 CALL get_pet_by_chip_num(@M,@N);  
 SELECT @N;  

 
#3 clients that have a dog and ordered accessories "Collar"
DELIMITER &&
CREATE PROCEDURE Get_Clients_With_Dog_And_Collar()
BEGIN
    SELECT distinct C.Client_ID, c.f_NAME, c.l_NAME
    FROM Client c
    INNER JOIN pet p ON c.Client_ID = p.Client_ID
    INNER JOIN dog d ON p.chip_num = d.chip_num
    INNER JOIN Orders o ON c.Client_ID = o.Client_ID
    INNER JOIN order_Accessories oa ON o.Orders_num = oa.Orders_num
    INNER JOIN Accessories a ON oa.barcode = a.barcode
    WHERE a.NAME like 'Collar';
END &&

DELIMITER ;

CALL Get_Clients_With_Dog_And_Collar(); 

 
 #4 chip_num of the cat with the least lives
DELIMITER //
CREATE PROCEDURE Print_Cat_With_Least_Lives()
BEGIN
    DECLARE minLives INT;
    
    SELECT MIN(num_of_lives) INTO minLives
    FROM cat;
    
    SELECT chip_num
    FROM cat
    WHERE num_of_lives = minLives
    LIMIT 1;
END //

DELIMITER ;

CALL Print_Cat_With_Least_Lives();

#5 count of clients with more than X pets
 DELIMITER &&  
CREATE PROCEDURE get_count_clients_with_num_pets (IN var1 INT)  
BEGIN
	SELECT  count(client.client_id) as total_client  
    from client where amount_of_pets > var1;
END &&  
DELIMITER ;  
CALL get_count_clients_with_num_pets(1); 

#6 sum points of vip clients
   DELIMITER &&  
CREATE PROCEDURE get_sum_vip_clients_points (OUT var1 INT)  
BEGIN  
	SELECT sum(Client_vip.points) into var1 from Client_vip; 
END &&  
DELIMITER ;  
CALL get_sum_vip_clients_points(@M); 
SELECT @M; 

#7  get all rodents weight which are below var1
   DELIMITER &&  
CREATE PROCEDURE get_rodent_weight (in var1 float)  
BEGIN  
	SELECT p.*, C.f_name, C.l_name from pet as P 
INNER JOIN rodent as R ON R.chip_num = P.chip_num
INNER JOIN client as C ON C.Client_ID = P.Client_ID where R.weight < var1; 
END &&  
DELIMITER ;  
SET @M = 0.7; 
CALL get_rodent_weight(@M); 
 
#8 num of different pets that were in session with doctor ap their first and last name in the last 30 days
   DELIMITER &&  
CREATE PROCEDURE get_num_of_pet_for_doctor (IN doctor_fname varchar(50), IN doctor_lname varchar(50))  
BEGIN  
	SELECT count(distinct chip_num) as num_of_pets from sessions as s 
INNER JOIN workers as w ON s.doctor_id = w.worker_id where w.name like doctor_fname 
and w.last_name like doctor_lname and DATEDIFF(CURDATE(), s.date_of_session) <= 30;
END &&  
DELIMITER ;  

SET @M = 'Alice'; 
SET @N = 'Johnson'; 
CALL get_num_of_pet_for_doctor(@M, @N); 


#9  Print message depending on deaths in clinic
   DELIMITER &&  
CREATE PROCEDURE get_msg_from_percentage(OUT var1 VARCHAR(50))  
BEGIN  
	DECLARE percentage float;
    SET percentage = (SELECT (SELECT COUNT(pet.status) FROM pet WHERE pet.status = 0)/ COUNT(pet.chip_num)*100 FROM pet);
    
    CASE
		WHEN percentage < 15 THEN SELECT 'Healthy clinic' INTO var1;
        WHEN percentage < 30 THEN SELECT 'Below average clinic' INTO var1;
        WHEN percentage < 50 THEN SELECT 'Bad' INTO var1;
        WHEN percentage >= 50 THEN SELECT 'DONT GO HERE' INTO var1;
    #SELECT percentage INTO var1;
    END CASE;
END &&  
DELIMITER ;  

CALL get_msg_from_percentage(@M); 
SELECT @M; 



#10 update all expired vaccines if 1 year has passed and show the list of pets that need to be called to retake them
DELIMITER &&  
CREATE PROCEDURE update_vaccine_status()  
BEGIN  
	UPDATE recieve_vaccine, vaccine, pet
    SET recieve_vaccine.status = 'EXPIRED'
    WHERE DATEDIFF(CURDATE(), recieve_vaccine.date) >= 365 
    AND recieve_vaccine.Vaccine_ID = Vaccine.ID AND recieve_vaccine.chip_num = pet.chip_num;
    
    SELECT pet.*
    FROM pet, recieve_vaccine
    WHERE pet.chip_num = recieve_vaccine.chip_num AND recieve_vaccine.status LIKE 'EXPIRED';
END &&  
DELIMITER ;  

CALL update_vaccine_status(); 



