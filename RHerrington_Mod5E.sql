
/* 	Create a view that lists the name and phone number of the contact person at each publisher. 
	Don't include the publisher's in the view. Name the view CONTACT. 
	Make sure users can't accidentally perform DML operations on the view. */

CREATE VIEW CONTACT
	AS SELECT	FIRST,
				LAST,
				PHONE
	FROM 		PUBLISHERS
GROUP BY 		FIRST,
				LAST,
				PHONE
SELECT *
FROM 		CONTACT
WITH READ ONLY;


/* 	Create a view called MODULE_EXAM that includes the columns named Objective and Production from the FIRSTATTEMPT table. 
	Make sure the view is created even if the FIRSTATTEMPT table doesn't exist. */

CREATE FORCE VIEW MODULE_EXAM
	AS SELECT	OBJECTIVE,
				PRODUCTION 
	FROM 		FIRSTATTEMPT
GROUP BY 		OBJECTIVE,
				PRODUCTION
SELECT *
FROM 		MODULE_EXAM;


/* 	List the book title and retail price for all books with a retail price lower than the average retail price of all books sold by JustLee Books.  
	Determine which books cost less than the average cost of other books in the same category. */

SELECT 	 TITLE,
		 RETAIL
FROM 	 BOOKS 
WHERE 	 RETAIL < (SELECT AVG(RETAIL)
				   FROM   BOOKS
				   WHERE  CATEGORY = CATEGORY)
GROUP BY TITLE,
		 RETAIL;