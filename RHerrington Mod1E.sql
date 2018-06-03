-- Part 1: Display all information in the employee table
SELECT *

FROM EMPLOYEE;


-- Part 2: Display empID, position, and salary in employee table

SELECT empID, position, salary

FROM EMPLOYEE;


-- Part 3: Display accountID, clientID, accountNum, current_bal... 
-- ...in the accounts table.  Use the alias curBal to refer to current_bal

SELECT accountID, clientID, accountNum, current_bal AS "curBal"
-- SELECT accountID, clientID, accountNum, current_bal curBal
-- This also works but the alias would be in all CAPS

FROM ACCOUNTS;

