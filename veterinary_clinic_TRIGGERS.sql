use veterinary_clinic;



#1 Increase amount of visits after session
*DELIMITER $
CREATE TRIGGER after_session_insert
AFTER INSERT ON sessions
FOR EACH ROW
BEGIN
UPDATE pet
SET pet.amount_of_visits = pet.amount_of_visits + 1
WHERE pet.chip_num = NEW.chip_num;
END$
DELIMITER ;*

#2 increase amount of pets for owner after pet insert 
*DELIMITER $
CREATE TRIGGER after_pet_insert
AFTER INSERT ON pet
FOR EACH ROW
BEGIN
UPDATE client
SET client.amount_of_pets = client.amount_of_pets + 1
WHERE client.client_id = NEW.client_id;
END$
DELIMITER ;*

 

#3 Update the amount of pets owned after pet transfer
*DELIMITER $
CREATE TRIGGER after_pet_update
AFTER UPDATE ON pet
FOR EACH ROW
BEGIN
IF(OLD.client_id <> NEW.client_id) THEN
		UPDATE client
		SET client.amount_of_pets = client.amount_of_pets + 1
		WHERE client.client_id = NEW.client_id;
		UPDATE client
		SET client.amount_of_pets = client.amount_of_pets - 1
		WHERE client.client_id = OLD.client_id;
    END IF;
END$
DELIMITER ;*


#4 Update health status on pet after session
*DELIMITER $
CREATE TRIGGER after_session_insert_state
AFTER INSERT ON sessions
FOR EACH ROW
BEGIN
IF(NEW.dia_name LIKE 'healthy') THEN
		UPDATE pet
		SET pet.state = 'Healthy'
		WHERE pet.chip_num = NEW.chip_num;
ELSE 
		UPDATE pet
		SET pet.state = 'Sick'
		WHERE pet.chip_num = NEW.chip_num;
    END IF;
END$
DELIMITER ;*

#5 Increase the amount of orders client did after he made a new order
*DELIMITER $
CREATE TRIGGER after_order_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
UPDATE client
SET client.order_amount = client.order_amount + 1
WHERE client.client_id = NEW.client_id;
END$
DELIMITER ;*

#6 Makes a client into VIP after he made 3 orders from the clinic
*DELIMITER $
CREATE TRIGGER after_order_insert_vipcheck
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
IF((SELECT client.client_id FROM client WHERE client_id = NEW.client_id AND order_amount >= 3
AND NOT EXISTS (SELECT client_vip.client_id FROM client_vip WHERE client_vip.client_id = NEW.client_id))) THEN
		INSERT INTO client_vip (client_id, points)
        VALUES (NEW.client_id, 0);
	END IF;
END$
DELIMITER ;*

#7 Decreases the amount of lives a cat has after he has been hospitilized
*DELIMITER $
CREATE TRIGGER after_insert_hospitilization
AFTER INSERT ON hospitalization
FOR EACH ROW
BEGIN
IF (EXISTS (SELECT cat.chip_num FROM cat WHERE cat.chip_num = NEW.chip_num)) THEN
		UPDATE cat
		SET cat.num_of_lives = cat.num_of_lives - 1
		WHERE cat.chip_num = NEW.chip_num;
    END IF;
END$
DELIMITER ;*

#8 Updates doctor salary after insert
*DELIMITER $
CREATE TRIGGER after_insert_doctor
AFTER INSERT ON doctors
FOR EACH ROW
BEGIN
		UPDATE workers
		SET workers.salary = workers.salary + NEW.num_of_diplomas*100 + NEW.experience*50
		WHERE workers.worker_id = NEW.worker_id;
END$
DELIMITER ;*


#9 Updates doctor salary after he had new diplomas or more experience
*DELIMITER $
CREATE TRIGGER after_update_doctor
AFTER UPDATE ON doctors
FOR EACH ROW
BEGIN
IF(OLD.num_of_diplomas < NEW.num_of_diplomas OR OLD.experience + 5 < NEW.experience) THEN
		UPDATE workers
		SET workers.salary = workers.salary + (NEW.num_of_diplomas - OLD.num_of_diplomas)*100 + (NEW.experience - OLD.experience)*50
		WHERE workers.worker_id = NEW.worker_id;
	END IF;
END$
DELIMITER ;*


#10 Before inserting a food order, check if it can be added, and if it then reduce the stock amount
*DELIMITER $
CREATE TRIGGER order_food_insert
BEFORE INSERT ON order_food
FOR EACH ROW
BEGIN
	IF((SELECT food.food_stock FROM food WHERE food.barcode = NEW.barcode) - NEW.amount > 0) THEN
		UPDATE food
		SET food.food_stock = food.food_stock - NEW.amount
		WHERE food.barcode = NEW.barcode;
         
        SET NEW.status = "SUCCESS";
	ELSE
        SET NEW.amount = 0, NEW.status = 'FAILED';
	END IF;
END$
DELIMITER ;*

#11 updates new stock amount after an accessory was ordered
*DELIMITER $
CREATE TRIGGER order_accessories_insert
BEFORE INSERT ON order_accessories
FOR EACH ROW
BEGIN
	IF((SELECT accessories.accessories_stock FROM accessories WHERE accessories.barcode = NEW.barcode) - NEW.amount > 0) THEN
		UPDATE accessories
		SET accessories.accessories_stock = accessories.accessories_stock - NEW.amount
		WHERE accessories.barcode = NEW.barcode;
        
        SET NEW.status = 'SUCCESS';
	ELSE
        SET NEW.amount = 0, NEW.status = 'FAILED';
	END IF;    
END$
DELIMITER ;*

#trigger 1 for delete
DELIMITER $

CREATE TRIGGER delete_orderfood_on_order_del
BEFORE DELETE ON orders
FOR EACH ROW
BEGIN
    UPDATE food, order_food
    SET food.food_stock = food.food_stock + order_food.amount
    WHERE food.barcode = order_food.barcode AND order_food.orders_num = OLD.orders_num;

    DELETE FROM order_food
    WHERE order_food.orders_num = OLD.orders_num;
    
END$

DELIMITER ;


#trigger 2 for delete
DELIMITER $

CREATE TRIGGER delete_orderaccessories_on_order_del
BEFORE DELETE ON orders
FOR EACH ROW
BEGIN
    UPDATE accessories, order_accessories
    SET accessories.accessories_stock = accessories.accessories_stock + order_accessories.amount
    WHERE accessories.barcode = order_accessories.barcode AND order_accessories.orders_num = OLD.orders_num;

    DELETE FROM order_accessories
    WHERE order_accessories.orders_num = OLD.orders_num;
    
END$

DELIMITER ;


