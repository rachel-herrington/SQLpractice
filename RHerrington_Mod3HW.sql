-- R.HERRINGTON MODULE 3 -- 

-- CHAPTER 5 --
INSERT INTO CRIMINALS 
			(CRIMINAL_ID, LAST, FIRST, STREET, CITY, STATE, ZIP, PHONE, V_STATUS, P_STATUS)
	VALUES 	(:CRIMINAL_ID, :LAST, :FIRST, :STREET, :CITY, :STATE, :ZIP, :PHONE, :V_STATUS,:P_STATUS);


INSERT INTO CRIMINALS 
			(CRIMINAL_ID, LAST, FIRST, CITY, STATE, ZIP)
	VALUES 	(1015,'Fenter', 'Jim', 'Chesapeake', 'VA', 23320);


INSERT INTO CRIMINALS  
			(CRIMINAL_ID, LAST, FIRST, STREET, CITY, STATE, ZIP, PHONE)
	VALUES 	(1016,'Saunder', 'Bill', '11 Apple Rd', 'Virginia Beach', 'VA',23455,7678217443);


INSERT INTO CRIMINALS  
			(CRIMINAL_ID, LAST, FIRST, STREET, CITY, STATE, ZIP, PHONE)
	VALUES 	(1017,'Painter', 'Troy', '77 Ship Lane', 'Norfolk', 'VA', 22093,7677655454);


ALTER TABLE CRIMINALS
	ADD (MAIL_FLAG CHAR(1));


UPDATE CRIMINALS
	SET MAIL_FLAG = 'Y';


UPDATE CRIMINALS
	SET MAIL_FLAG = 'N'
	WHERE STREET IS NULL;


UPDATE CRIMINALS
	SET PHONE = '7225659032'
	WHERE CRIMINAL_ID = 1016;


DELETE FROM CRIMINALS
	WHERE CRIMINAL_ID = 1017;
COMMIT;

INSERT INTO CRIMES 
			(CRIME_ID, CRIMINAL_ID, CLASSIFICATION, DATE_CHARGED, STATUS)
	VALUES	(100, 1010, 'M', '15-JUL-09', 'PD');


INSERT INTO CRIMES 
			(CRIME_ID, CRIMINAL_ID, CLASSIFICATION, DATE_CHARGED, STATUS)
	VALUES	(130, 1016, 'M', '15-JUL-09', 'PD');


INSERT INTO CRIMES 
			(CRIME_ID, CRIMINAL_ID, CLASSIFICATION, DATE_CHARGED, STATUS)
	VALUES	(130, 1016 , 'P', '15-JUL-09', 'CL');


-- CHAPTER 6 --
CREATE SEQUENCE CRIMINAL_ID_SEQ
	INCREMENT BY 1
	START WITH 1017
	NOCACHE
	NOCYCLE;

CREATE SEQUENCE CRIME_ID_SEQ
	INCREMENT BY 1
	START WITH 1
	NOCACHE
	NOCYCLE;

INSERT INTO CRIMINALS 
			(CRIMINAL_ID, FIRST, LAST, CITY, STATE, ZIP)
	VALUES 	(CRIMINAL_ID_SEQ.NEXTVAl, 'Johnny', 'Capps', 'Worcester', 'MA', 01603);


INSERT INTO CRIMES 
			(CRIME_ID, CRIMINAL_ID)
	VALUES	(CRIME_ID_SEQ.NEXTVAl, CRIMINAL_ID_SEQ.CURRVAl);


CREATE INDEX CRIMINAL_NAME_IDX
	ON CRIMINALS (LAST);


CREATE INDEX CRIMINAL_STREET_IDX
	ON CRIMINALS (STREET);


CREATE INDEX CRIMINAL_PHONE_IDX
	ON CRIMINALS (PHONE);
