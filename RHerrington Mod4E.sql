
SELECT 		SUM(RETAIL),
			TITLE
FROM 		BOOKS 
GROUP BY 	TITLE;


SELECT 		AVG(RETAIL),
			TITLE
FROM 		BOOKS 
GROUP BY 	TITLE;


SELECT                                      
    (   SELECT  AUTHOR_ID,
    			FNAME,
    			LNAME
        FROM    AUTHORS A
        WHERE   FNAME = 'Lisa' AND LNAME = 'White'
    )
    (   SELECT  MAX(RETAIL),
    			TITLE,
        FROM    BOOKS B
        WHERE   M.AUTHOR_ID = A.AUTHOR_ID
    )
FROM    BOOKS M;



SELECT                                      
    (   SELECT  PUBLISHER_ID,
    			FNAME,
    			LNAME,
    			PHONE
        FROM    PUBLISHERS P
        WHERE   B.PUBLISHER_ID = P.PUBLISHER_ID
    )
FROM    BOOKS B;



SELECT      TITLE,
            A.LNAME
FROM        BOOKS
JOIN        AUTHORS A 
WHERE       A.LNAME = 'Adams';



SELECT      CUSTOMER_ID,
			FNAME,
			LNAME,
            STATE
FROM        CUSTOMERS C
JOIN        BOOKS B 
WHERE       B.TOPIC = 'COMPUTERS' AND C.STATE = 'FL';

