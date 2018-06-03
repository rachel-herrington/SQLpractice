-- R.HERRINGTON MODULE 4 -- 

-- CHAPTER 9 --

SELECT 	C.CRIMINAL_ID, 
		C.LAST, 
		C.FIRST, 
		CC.CRIME_CODE, 
		CC.FINE_AMOUNT
FROM 	CRIMINALS C, CRIMES CR, CRIME_CHARGES CC
WHERE	CR.CRIME_ID = CC.CRIME_ID
AND 	C.CRIMINAL_ID = CR.CRIMINAL_ID;


SELECT 	CRIMINAL_ID, 
		LAST, 
		FIRST, 
		CRIME_CODE, 
		FINE_AMOUNT
FROM 	CRIMINALS 
NATURAL JOIN CRIMES 
NATURAL JOIN CRIME_CHARGES;


SELECT 	C.CRIMINAL_ID, 
		C.LAST, 
		C.FIRST, 
		CR.CLASSIFICATION, 
		CR.DATE_CHARGED, 
		CR.CRIME_ID, 
		A.FILING_DATE, 
		A.STATUS
FROM 	CRIMINALS C, 
		CRIMES CR, 
		APPEALS A
WHERE 	C.CRIMINAL_ID = CR.CRIMINAL_ID
AND 	CR.CRIME_ID = A.CRIME_ID(+)
ORDER BY C.LAST;

	
SELECT 	CRIMINAL_ID, 
		LAST, 
		FIRST,
		CLASSIFICATION, 
		DATE_CHARGED, 
		CRIME_ID, 
		FILING_DATE, 
		A.STATUS
FROM 	CRIMINALS 
NATURAL JOIN CRIMES 
LEFT OUTER JOIN APPEALS A
USING(CRIME_ID)
ORDER BY LAST;


SELECT 	C.CRIMINAL_ID, 
		C.LAST, 
		C.FIRST, 
		CR.CLASSIFICATION, 
		CR.DATE_CHARGED, 
		CC.CRIME_CODE, 
		CC.FINE_AMOUNT
FROM 	CRIMINALS C, 
		CRIMES CR, 
		CRIME_CHARGES CC
WHERE 	CLASSIFICATION = 'O'
AND 	CR.CRIME_ID = CC.CRIME_ID
AND 	C.CRIMINAL_ID = CR.CRIMINAL_ID
ORDER BY CRIMINAL_ID, DATE_CHARGED;


SELECT 	CRIMINAL_ID, 
		LAST, 
		FIRST, 
		CLASSIFICATION, 
		DATE_CHARGED, 
		CRIME_CODE, 
		FINE_AMOUNT
FROM 	CRIMINALS 
NATURAL JOIN CRIMES 
NATURAL JOIN CRIME_CHARGES
WHERE 	CLASSIFICATION = 'O';


SELECT 	C.CRIMINAL_ID, 
		C.LAST, 
		C.FIRST, 
		C.V_STATUS, 
		C.P_STATUS, 
		AL.ALIAS
FROM 	CRIMINALS C, 
		ALIASES AL
WHERE 	C.CRIMINAL_ID = AL.CRIMINAL_ID(+)
ORDER BY LAST;


SELECT 	CRIMINAL_ID, 
		LAST, 
		FIRST, 
		V_STATUS, 
		P_STATUS, 
		ALIAS
FROM 	CRIMINALS 
FULL OUTER JOIN ALIASES 
USING (CRIMINAL_ID)
ORDER BY LAST;


SELECT 	C.LAST, 
		C.FIRST, 
		S.START_DATE, 
		S.END_DATE, 
		PR.CON_FREQ
FROM 	CRIMINALS C, PROB_CONTACT PR, SENTENCES S
WHERE 	C.CRIMINAL_ID = S.CRIMINAL_ID
AND 	S.TYPE = 'P'
AND 	(S.END_DATE - S.START_DATE) <= PR.HIGH_AMT
AND 	(S.END_DATE - S.START_DATE) >= PR.LOW_AMT
ORDER BY C.LAST, S.START_DATE;


SELECT 	C.LAST, 
		C.FIRST, 
		S.START_DATE, 
		S.END_DATE, 
		PR.CON_FREQ
FROM 	CRIMINALS C JOIN SENTENCES S 
ON 		S.TYPE = 'P' JOIN PROB_CONTACT PR 
ON 		(S.END_DATE - S.START_DATE) <= PR.HIGH_AMT
AND 	(S.END_DATE - S.START_DATE) >= PR.LOW_AMT
ORDER BY C.LAST, S.START_DATE;


SELECT 	PO.LAST, 
		PO.FIRST, 
		POM.LAST AS SUPERVISOR_LAST, 
	   	POM.FIRST AS SUPERVISOR_FIRST
FROM   	PROB_OFFICERS PO, 
		PROB_OFFICERS POM
WHERE  	PO.MGR_ID = POM.PROB_ID(+)
ORDER BY PO.LAST;


SELECT 	PO.LAST, 
		PO.FIRST, 
		POM.LAST AS SUPERVISOR_LAST, 
	   	POM.FIRST AS SUPERVISOR_FIRST
FROM   	PROB_OFFICERS PO 
LEFT OUTER JOIN PROB_OFFICERS POM
ON 	   	PO.MGR_ID = POM.PROB_ID
ORDER BY PO.LAST;


-- CHAPTER 10 --

INSERT INTO APPEALS (APPEAL_ID,CRIME_ID, 
			FILING_DATE, 
			HEARING_DATE)
	VALUES (APPEALS_ID_SEQ.NEXTVAL, 
			:CRIME_ID, 
			TO_DATE (:FILING_DATE, 'MM DD YYYY'), 
			TO_DATE (:HEARING_DATE, 'MM DD YYYY'));


-- CHAPTER 11 --
SELECT 	 AVG(COUNT(CRIME_ID))
FROM 	 CRIME_OFFICERS
GROUP BY OFFICER_ID;


SELECT 	 COUNT(CRIME_ID), STATUS
FROM 	 CRIMES
GROUP BY STATUS;


SELECT 	 MAX(COUNT(CRIME_ID)) "PERSON WHO COMMITTED MOST CRIMES"
FROM 	 CRIMES
GROUP BY CRIMINAL_ID;


SELECT 	 MIN(FINE_AMOUNT) "LOWEST FINE"
FROM 	 CRIME_CHARGES;


SELECT 	 CRIMINAL_ID,
		 LAST, 
		 FIRST,
		 COUNT(SENTENCE_ID)
FROM 	 CRIMINALS JOIN SENTENCES USING(CRIMINAL_ID)
GROUP BY CRIMINAL_ID,
		 LAST, 
		 FIRST
HAVING 	 COUNT(SENTENCE_ID) > 1;


SELECT 	PRECINCT, 
		COUNT(CHARGE_STATUS)
FROM 		 CRIME_CHARGES 
NATURAL JOIN CRIME_OFFICERS 
NATURAL JOIN OFFICERS
WHERE 		 CHARGE_STATUS = 'GL'
GROUP BY 	 PRECINCT
HAVING 		 COUNT(CHARGE_STATUS) > 7;


SELECT 	CLASSIFICATION, 
	  	TO_CHAR(SUM(FINE_AMOUNT + COURT_FEE),'$9,999.99') "TOTAL COLLECTIONS", 
	   	TO_CHAR(SUM(FINE_AMOUNT + COURT_FEE - AMOUNT_PAID),'$9,999.99') "AMOUNT OWED"
FROM 	CRIMES 
NATURAL JOIN CRIME_CHARGES
GROUP BY CLASSIFICATION;


SELECT CLASSIFICATION, 
	   CHARGE_STATUS, 
	   COUNT(*)
FROM   CRIMES 
NATURAL JOIN CRIME_CHARGES
GROUP BY GROUPING SETS ((CLASSIFICATION, CHARGE_STATUS), ());


SELECT CLASSIFICATION, 
	   CHARGE_STATUS, 
	   COUNT(*)
FROM   CRIMES 
NATURAL JOIN CRIME_CHARGES
GROUP BY GROUPING SETS ((CLASSIFICATION, CHARGE_STATUS), (CLASSIFICATION),(CHARGE_STATUS),());


SELECT CLASSIFICATION, 
	   CHARGE_STATUS, 
	   COUNT(*)
FROM   CRIMES 
NATURAL JOIN CRIME_CHARGES
GROUP BY CUBE (CHARGE_STATUS, CLASSIFICATION);


SELECT CLASSIFICATION, 
	   CHARGE_STATUS, 
	   COUNT(CHARGE_ID) "NUMBER OF CHARGES"
FROM   CRIMES 
NATURAL JOIN CRIME_CHARGES
GROUP BY ROLLUP (CLASSIFICATION,CHARGE_STATUS);


SELECT CLASSIFICATION, 
	   CHARGE_STATUS, 
	   COUNT(*)
FROM   CRIMES 
NATURAL JOIN CRIME_CHARGES
GROUP BY GROUPING SETS ((CLASSIFICATION, CHARGE_STATUS), (CLASSIFICATION), ());








