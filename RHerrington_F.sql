CREATE TABLE FINAL_PERSON
(
    CUSTOMER_ID       	NUMBER            	PRIMARY KEY,
    FNAME         		VARCHAR2(150)     	NOT NULL,
    LNAME          		VARCHAR2(150)		NOT NULL,
    ADDRESS          	VARCHAR2(150),     
    CITY          		VARCHAR2(150),     
    STATE 				CHAR(2),
    ZIP 				NUMBER
);
/

INSERT INTO FINAL_PERSON C 															-- Get data from JLB_Customers with a subquery
FROM JLB_CUSTOMERS J
WHERE J.CUSTOMER_ID = C.CUSTOMER_ID;

ALTER TABLE FINAL_PERSON
ADD(BDAY(DATE));																	-- Add column BDAY							
	
UPDATE FINAL_PERSON 																-- Using update statements, update birthdays for each person
SET BDAY = "&DATE";


CREATE TABLE FINAL_GIFTS
(
    GIFT_ID       		NUMBER            	PRIMARY KEY,
    GIFT_DESCRIPTION    VARCHAR2(150)     	NOT NULL,
);
/

INSERT INTO FINAL_GIFTS 															-- Fill table with 5-10 gifts, EX: GIFT_ID = 10112, GIFT_DESCRIPTION = Pool Table;
    (GIFT_ID, GIFT_DESCRIPTION)
VALUES
    (10112, "Pool Table";)

INSERT INTO FINAL_GIFTS 												
    (GIFT_ID, GIFT_DESCRIPTION)
VALUES
    (101206, "Dart Board";)

INSERT INTO FINAL_GIFTS 												
    (GIFT_ID, GIFT_DESCRIPTION)
VALUES
    (10507, "Shuffle Board";)

INSERT INTO FINAL_GIFTS 												
    (GIFT_ID, GIFT_DESCRIPTION)
VALUES
    (10391, "Basketball Hoop";)

INSERT INTO FINAL_GIFTS 												
    (GIFT_ID, GIFT_DESCRIPTION)
VALUES
    (10456, "Hockey Table";)

CREATE TABLE FINAL_BDAY
(
    CUSTOMER_ID_FK      NUMBER            	FOREIGN KEY,
    GIFT_ID_FK      	NUMBER            	FOREIGN KEY,
    NUM_GIFTS	       	NUMBER
);
/

ALTER TABLE FINAL_BDAY
ADD CONSTRAINT GIFTS_ID_FK FOREIGN KEY(GIFT_ID)
REFERENCES FINAL_GIFTS(GIFT_ID);	

ALTER TABLE FINAL_BDAY
ADD CONSTRAINT CUSTOMER_ID_FK FOREIGN KEY(CUSTOMER_ID)
REFERENCES FINAL_PERSON(CUSTOMER_ID);





-- Get data from FINAL_PERSON using a subquery

ALTER TABLE FINAL_PERSON									-- Add the following columns, GIFT_ID
ADD CONSTRAINT PERSON_GIFTS_ID_FK FOREIGN KEY(GIFT_ID)
REFERENCES FINAL_GIFTS(GIFT_ID);	

		-- Use UPDATE statements -> 
			-- No person can have duplicate gifts

UPDATE 	FINAL_BDAY					-- Enter 1 gift per person
SET 	NUM_GIFTS = 1
WHERE 	CUSTOMER_ID_FK = (SELECT 	CUSTOMER_ID
						  FROM 		FINAL_PERSON);

UPDATE 	FINAL_BDAY					-- Bonita Morales gets 2 gifts
SET 	NUM_GIFTS = 2
WHERE 	CUSTOMER_ID_FK = (SELECT 	CUSTOMER_ID
						  FROM 		FINAL_PERSON
						  WHERE 	FNAME = "Bonita"
						  AND 		LNAME = "Morales");

UPDATE 	FINAL_BDAY					-- Thompson Ryan gets 2 gifts
SET 	NUM_GIFTS = 2
WHERE 	CUSTOMER_ID_FK = (SELECT 	CUSTOMER_ID
						  FROM 		FINAL_PERSON
						  WHERE 	FNAME = "Thompson"
						  AND 		LNAME = "Ryan");

UPDATE 	FINAL_BDAY					-- Meshia Cruz gets 4 gifts
SET 	NUM_GIFTS = 4
WHERE 	CUSTOMER_ID_FK = (SELECT 	CUSTOMER_ID
						  FROM 		FINAL_PERSON
						  WHERE 	FNAME = "Meshia"
						  AND 		LNAME = "Cruz");



SELECT  C.FNAME,					-- Display each person and their gift descriptions
		C.LNAME,
		G.GIFT_DESCRIPTION
JOIN 	FINAL_GIFTS G
USING	C.CUSTOMER_ID
FROM    FINAL_PERSON C
WHERE 	G.GIFT_ID = (SELECT GIFTS_ID_FK
					 FROM FINAL_BDAY)
GROUP BY C.FNAME, 
		 C.LNAME, 
		 G.GIFT_DESCRIPTION;

SELECT  C.FNAME,					-- Display each person’s name and how many gifts they received
		C.LNAME,
		B.NUM_GIFTS
JOIN 	FINAL_BDAY B
ON 		C.CUSTOMER_ID
FROM    FINAL_PERSON C
WHERE 	C.CUSTOMER_ID = B.CUSTOMER_ID_FK
GROUP BY C.FNAME, 
		 C.LNAME, 
		 B.NUM_GIFTS;

SELECT  FNAME,						-- Display the name of the person who received the most gifts
		LNAME
FROM    FINAL_PERSON 
WHERE 	CUSTOMER_ID = ( SELECT CUSTOMER_ID_FK
						FROM FINAL_BDAY
						WHERE MAX(NUM_GIFTS));

SELECT 	COUNT(CUSTOMER_ID_FK)		-- Display the number of people who got less than the average number of gifts
FROM 	FINAL_BDAY
WHERE 	AVG(NUM_GIFTS) < 
				ALL (SELECT AVG((NUM_GIFTS));


SELECT 	FNAME,						-- Display the people who receive more than the average but less than the maximum number of gifts
		LNAME
FROM 	FINAL_PERSON
WHERE 	CUSTOMER_ID = ( SELECT CUSTOMER_ID_FK
						FROM FINAL_BDAY
						WHERE AVG(NUM_GIFTS)) >
								ALL (SELECT AVG(NUM_GIFTS))
						AND MAX(NUM_GIFTS) <
								(SELECT MAX(NUM_GIFTS))
GROUP BY FNAME,
		 LNAME;

















