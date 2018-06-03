-- R.HERRINGTON MOD 5 --

-- CHAPTER 12 --

-- PART 1: List the name of each officer who has reported more than the average number of crimes officers have reported 
SELECT 	OFFICER_ID
FROM  	CRIME_OFFICERS 
JOIN 	CRIME_CHARGES 
		USING(CRIME_ID)
WHERE 	CRIME_CHARGES > 
			ALL (SELECT AVG(COUNT(*))
   				 FROM CRIME_CHARGES);
                     
-- PART 2: List the criminal names for all criminals who have a less than average number of crimes and aren't listed as violent offenders 
SELECT 	C.CRIMINAL_ID, 
		C.FIRST, 
		C.LAST, 
		CR.CRIME_ID
FROM 	CRIMINALS C
JOIN 	CRIMES CR
ON 		C.CRIMINAL_ID = CR.CRIMINAL_ID
WHERE 	CRIME_ID < 
			ALL (SELECT AVG(COUNT(*))
        		 FROM CRIMES )
AND 	C.V_STATUS = 'N';

-- PART 3: List appeal information for each appeal that has less than average number of days between filing and hearing dates 
SELECT *
FROM 	APPEALS
WHERE 	AVG(FILING_DATE - HEARING_DATE) < 
			ALL (SELECT AVG((FILING_DATE - HEARING_DATE));

-- PART 4: List the names of probation officers who have had a less than average number of criminals assigned 
SELECT 	P.PROB_ID, 
		P.LAST, 
		P.FIRST 
FROM 	PROB_OFFICERS P
JOIN 	SENTENCES S
ON 		P.PROB_ID = S.PROB_ID
WHERE 	CRIME_ID < 
			ALL (SELECT AVG(COUNT(*))
        		 FROM SENTENCES);

-- PART 5: List each crime that has had the highest number of appeals recorded 
SELECT    COUNT(CRIME_ID),
          CRIME_ID
FROM      APPEALS
GROUP BY  CRIME_ID
HAVING    COUNT(CRIME_ID) = (SELECT   MAX(APPEAL_COUNT),
                                      CRIME_ID
                            FROM     (SELECT COUNT(CRIME_ID) APPEAL_COUNT,
                                      CRIME_ID
                                      FROM      APPEALS
                                      GROUP BY  CRIME_ID));

-- PART 6: List the information on crime charges for each charge that has had a fine above average and a sum paid below average.
SELECT 	CHARGE_ID, 
		FINE_AMOUNT, 
		AMOUNT_PAID, 
FROM 	CRIME_CHARGES 
WHERE 	FINE_AMOUNT > 
			ALL (SELECT AVG(COUNT(*))
        		 FROM CRIME_CHARGES)
AND 	AMOUNT_PAID <
			ALL (SELECT AVG(COUNT(*))
        		 FROM CRIME_CHARGES);

-- PART 7: List the names of all criminals who have had any of the crime code charges involved in crime ID 10089.
SELECT 	C.CRIMINAL_ID, 
		C.FIRST, 
		C.LAST, 
		CR.CRIME_ID,
		CR.CRIME_CODE
FROM 	CRIMINALS C
JOIN 	CRIME_CHARGES CR
ON 		C.CRIMINAL_ID = CR.CRIMINAL_ID
WHERE 	CRIME_ID = 10089; -- GROUP BY?


-- PART 8: Use a correlated subquiery to determine which criminals have had at least one probation period assigend.  
SELECT * 
FROM  CRIMINALS C
WHERE C.P_STATUS = 'Y'
AND   C.CRIMINAL_ID IN (SELECT    S.CRIMINAL_ID
                        FROM      SENTENCES S
                        WHERE     S.PROB_ID IS NOT NULL
                        AND       S.CRIMINAL_ID = C.CRIMINAL_ID);

-- PART 9: List the names of officers who have booked the highest number of crimes.  Note that more than one officer might be listed.
SELECT 	O.OFFICER_ID, 
		O.FIRST, 
		O.LAST, 
FROM 	OFFICERS O
JOIN 	CRIME_OFFICERS CO
ON 		O.OFFICER_ID = CO.OFFICER_ID
WHERE 	MAX(COUNT(*)) CRIME_ID
GROUP BY OFFICER_ID;

-- PART 10: Note: Use a MERGE statement for the following: 
		  /* The criminal data warehouse contains a copy of the CRIMINALS table that needs to be updated periodically from the production CRIMINALS table.  
             The data warehouse table is named CRIMINALS_DW.  Use a single SQL statement to update the data warehouse table to reflect any data changes for 
             existing criminals and to add new criminals. */
MERGE INTO CRIMINALS_DW DW
USING CRIMINALS P 
ON (DW.CRIMINAL_ID = P.CRIMINAL_ID)
WHEN MATCHED THEN
	UPDATE SET 	DW.LAST = P.LAST, 
				DW.FIRST = P.FIRST, 
				DW.LAST = P.LAST, 
				DW.STREET = P.STREET,
				DW.CITY = P.CITY, 
				DW.STATE = P.STATE,  
				DW.ZIP = P.ZIP,
				DW.PHONE = P.PHONE,
				DW.V_STATUS = P.V_STATUS,
				DW.P_STATUS = P.P_STATUS,
WHEN NOT MATCHED THEN
	INSERT (CRIMINAL_ID, LAST, FIRST, STREET, CITY, STATE, ZIP, PHONE, V_STATUS, P_STATUS)
	VALUES (P.CRIMINAL_ID, P.LAST, P.FIRST, P.STREET, P.CITY, P.STATE, P.ZIP, P.PHONE, P.V_STATUS, P.P_STATUS);

-- IN CLASS STUFF --
SELECT *
FROM  APPEALS
WHERE CRIME_ID = (SELECT CRIME_ID
                  FROM  CRIMES
                  GROUP BY CRIME_ID);

SELECT  AVG(CRIME_COUNT) 
FROM    (SELECT   COUNT(CRIME_ID) CRIME_COUNT
        FROM      CRIME_OFFICERS
        GROUP BY  OFFICER_ID);


-- CHAPTER 13 --
-- PART 1: Create a statement that always returns the names of the 3 criminals with the highest number of crimes committed.
SELECT 	 C.CRIMINAL_ID,
		 C.FIRST,
		 C.LAST
FROM 	 CRIMINALS C
JOIN	 CRIMES CR
ON 		 C.CRIMINALS = CR.CRIMES
WHERE	 MAX(COUNT(CRIME_ID)) CRIMES_COMMITTED
AND 	 ROWNUM <= 3
ORDER BY CRIMES_COMMITTED DESC;

-- PART 2: Create a view that includes details for all crimes, including criminal ID, criminal name, criminal parole status, crime ID, date of crime charge,
      	/* crime status, charge ID, crime code, charge status, pay due date, and amount due.  This view shouldn't allow performing any DML operations.  Each time
      	   the view is used in the application, the data should be queried from the database.  (For example, each use of the view should reflect the most current
      	   data in the database.) */

CREATE VIEW 	CRIME_DETAILS
	AS SELECT 		CRIMINAL_ID, 
					LAST, 
					FIRST, 
					P_STATUS, 
					CRIME_ID, 
					DATE_CHARGED, 
					STATUS, 
					CHARGE_ID, 
					CRIME_CODE, 
					CHARGE_STATUS, 
					PAY_DUE_DATE, 
					FINE_AMOUNT
	FROM 			CRIMINALS
	JOIN			CRIMES
	USING			CRIMINAL_ID
	JOIN 			CRIME_CHARGES
	USING			CRIME_ID
GROUP BY			CRIMINAL_ID, CRIME_ID;
SELECT *
FROM 				CRIME_DETAILS
WITH READ ONLY;


-- PART 3: Create a view that includes all data for officers, including the total number of crimes in which they participated in filing charges.  To speed up
      	/* the officer queries, store this view data and schedule the data to be updated every 2 wks. */

CREATE MATERIALIZED VIEW OFFICER_DATA
REFRESH COMPLETE
START WITH SYSDATE, 
NEXT SYSTDATE + 14
	AS SELECT 	OFFICER_ID, 
				LAST, 
				FIRST, 
				PRECINCT, 
				BADGE, 
				PHONE, 
				STATUS, 
				SUM(CRIME_ID) CRIME_COUNT
	FROM 		OFFICERS
	JOIN		CRIME_OFFICERS 
	USING		OFFICER_ID
GROUP BY	OFFICER_ID, 
			LAST, 
			FIRST;



