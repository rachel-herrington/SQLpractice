CREATE TABLE CRIMINALS
(                         
                        CRIMINAL_ID           NUMBER(6),           
                        LAST                  VARCHAR2(15),
                        FIRST                 VARCHAR2(10),
                        STREET                VARCHAR2(30),
                        CITY                  VARCHAR2(20),
                        STATE                 CHAR(2),
                        ZIP                   CHAR(5),
                        PHONE                 CHAR(10),
                        V_STATUS              CHAR(1)             DEFAULT 'N',    -- (Y) Yes or (N) No
                        P_STATUS              CHAR(1)             DEFAULT 'N' 
);

CREATE TABLE CRIMES
(                         
                        CRIME_ID              NUMBER(9),           
                        CRIMINAL_ID           NUMBER(6),
                        CLASSIFICATION        CHAR(1),                            -- (F) Felony, (M) Misdemeanor, (O) Other, (U) Undefined
                        DATE_CHARGED          DATE,
                        STATUS                CHAR(2),                            -- (CL) Closed, (CA) Can Appeal, (IA) In Appeal
                        HEARING_DATE          DATE,
                        APPEAL_CUT_DATE       DATE
);

CREATE TABLE ALIASES
(                         
                        ALIAS_ID              NUMBER(6),          
                        CRIMINAL_ID           NUMBER(6),
                        ALIAS                 VARCHAR2(10)      
);

CREATE TABLE SENTENCES
(                         
                        SENTENCE_ID           NUMBER(6),           
                        CRIMINAL_ID           NUMBER(6),
                        TYPE                  CHAR(1),                            -- (J) Jail Period, (H) House Arrest, (P) Probation
                        PROB_ID               NUMBER(5),
                        START_DATE            DATE,
                        END_DATE              DATE,
                        VIOLATIONS            NUMBER(3)
);

CREATE TABLE PROB_OFFICERS
(                         
                        PROB_ID               NUMBER(5),          
                        LAST                  VARCHAR2(15),
                        FIRST                 VARCHAR2(10),
                        STREET                VARCHAR2(30),
                        CITY                  VARCHAR2(20),
                        STATE                 CHAR(2),
                        ZIP                   CHAR(5),
                        PHONE                 CHAR(10),
                        EMAIL                 VARCHAR2(30),
                        STATUS                CHAR(1)             DEFAULT 'A'     -- (A) Active or (I) Inactive
);

CREATE TABLE CRIME_CHARGES
(                         
                        CHARGE_ID             NUMBER(10),         
                        CRIME_ID              NUMBER(9),
                        CRIME_CODE            NUMBER(3),
                        CHARGE_STATUS         CHAR(2),                            -- (PD) Pending, (GL) Guilty, (NG) Not Guilty
                        FINE_AMOUNT           NUMBER(7),
                        COURT_FEE             NUMBER(7),
                        AMOUNT_PAID           NUMBER(7),
                        PAY_DUE_DATE          DATE
);

CREATE TABLE CRIME_OFFICERS
(                         
                        CRIME_ID              NUMBER(9),
                        OFFICER_ID            NUMBER(8),
);

CREATE TABLE OFFICERS
(
                        OFFICER_ID            NUMBER(8),
                        LAST                  VARCHAR2(15),
                        FIRST                 VARCHAR2(10),
                        PRECINCT              CHAR(4),
                        BADGE                 VARCHAR2(14),
                        PHONE                 CHAR(10),
                        STATUS                CHAR(1)             DEFAULT 'A'     -- (A) Active or (I) Inactive
);

CREATE TABLE APPEALS
(
                        APPEAL_ID              NUMBER(5),
                        CRIME_ID               NUMBER(9),
                        FILING_DATE            DATE,
                        HEARING_DATE           DATE,
                        STATUS                 CHAR(1)            DEFAULT 'P'     -- (P) Pending, (A) Approved, (D) Disapproved
);

CREATE TABLE CRIME_CODES
(
                        CRIME_CODE             NUMBER(3),
                        CODE_DESCRIPTION       VARCHAR2(30)
);

-- CHAPTER 3 --
   /* Add a defualt value of U for the Classification column of the Crimes table.
    * Add a column named Date_Recorded to the Crimes table.  This column needs to hold date values and 
      should be set to the current date by default.
    * Change the Alias column in the Aliases table to accommodate up to 20 characters
    * Add a column to the PROB_OFFICERS table that contains the pager number for each officer.  
      The column needs to accommodate a phone number, icluding area code.  Name the column Pager #. */

ALTER TABLE CRIMES
  MODIFY (CLASSIFICATION DEFAULT 'U');

ALTER TABLE CRIMES
  ADD (DATE_RECORDED DATE DEFAULT SYSDATE);

ALTER TABLE CRIMINALS
  ADD CONSTRAINT CRIMINAL_ID_PK PRIMARY KEY (CRIMINAL_ID);

ALTER TABLE CRIMINALS
  ADD CONSTRAINT CRIMINALS_V_STATUS_CK CHECK (V_STATUS IN ('Y','N'));

ALTER TABLE CRIMINALS
  ADD CONSTRAINT CRIMINALS_P_STATUS_CK CHECK (P_STATUS IN ('Y','N'));

ALTER TABLE CRIMES
  ADD CONSTRAINT CRIMINAL_ID_PK PRIMARY KEY (CRIME_ID);

ALTER TABLE CRIMES
  ADD CONSTRAINT CRIMES_CLASS_CK CHECK (CLASSIFICATION IN ('F','M','O','U'));

ALTER TABLE CRIMES
  ADD CONSTRAINT CRIMES_STATUS_CK CHECK (STATUS IN ('CL','CA','IA'));

ALTER TABLE CRIMES
  ADD CONSTRAINT CRIMES_CRIMINAL_ID_FK FOREIGN KEY (CRIMINAL_ID)
  REFERENCES CRIMINALS (CRIMINAL_ID);

ALTER TABLE SENTENCES
  ADD CONSTRAINT SENTENCES_TYPE_CK CHECK (TYPE IN ('J', 'H', 'P'));

ALTER TABLE CRIME_CHARGES
  ADD CONSTRAINT CRIME_CHARGES_STATUS_CK CHECK (CHARGE_STATUS IN ('PD', 'GL', 'NG'));

ALTER TABLE OFFICERS
  ADD CONSTRAINT OFFICERS_STATUS_CK CHECK (STATUS IN ('A','I'));

ALTER TABLE APPEALS
  ADD CONSTRAINT APPEALS_STATUS_CK CHECK (STATUS IN ('P', 'A', 'D'));

ALTER TABLE CRIMES
  MODIFY (CRIMINAL_ID NOT NULL);

ALTER TABLE ALIASES
  MODIFY (ALIAS VARCHAR2(20));

ALTER TABLE PROB_OFFICERS
  ADD (PAGER_NUMBER NUMBER(10));

ALTER TABLE PROB_OFFICERS
  ADD CONSTRAINT STATUS_CK CHECK (STATUS IN ('A','I'));

-- CHAPTER 4 --
   /* First, drop the APPEALS, CRIME_OFFICERS, and CRIME CHARGES tables constructed in Chp3.  
      These 3 tables are to be built last, using a CREATE TABLE command that includes all the 
      necessary constraints.
    * Second, use the ALTER TABLE command to add all constraints to the existing tables.
      Note that the sequence of constraint addition has an impact.  Any tables referenced by 
      FOREIGN KEYs must already have the PRIMARY KEY created.
    * Third, use the CREATE TABLE command, including all constraints, to build the three 
      tables dropped in the first step. */

DROP TABLE APPEALS;
DROP TABLE CRIME_OFFICERS;
DROP TABLE CRIME_CHARGES;

ALTER TABLE ALIASES
  ADD CONSTRAINT ALIAS_ID_PK PRIMARY KEY (ALIAS_ID);

ALTER TABLE SENTENCES
  ADD CONSTRAINT SENTENCE_ID_PK PRIMARY KEY (SENTENCE_ID);

ALTER TABLE PROB_OFFICERS
  ADD CONSTRAINT PROB_ID_PK PRIMARY KEY (PROB_ID);

ALTER TABLE OFFICERS
  ADD CONSTRAINT OFFICER_ID_PK PRIMARY KEY (OFFICER_ID);

ALTER TABLE CRIME_CODES
  ADD CONSTRAINT CRIME_CODE_PK PRIMARY KEY (CRIME_CODE);

ALTER TABLE ALIASES
  ADD CONSTRAINT ALIASES_CRIMINAL_ID_FK FOREIGN KEY (CRIMINAL_ID)
  REFERENCES CRIMINALS (CRIMINAL_ID);

ALTER TABLE SENTENCES
  ADD CONSTRAINT SENTENCES_CRIMINAL_ID_FK FOREIGN KEY (CRIMINAL_ID)
  REFERENCES CRIMINALS (CRIMINAL_ID);

CREATE TABLE APPEALS
(
                        APPEAL_ID              NUMBER(5),
                        CRIME_ID               NUMBER(9),
                        FILING_DATE            DATE,
                        HEARING_DATE           DATE,
                        STATUS                 CHAR(1)            DEFAULT 'P',

                        CONSTRAINT APPEAL_ID_PK PRIMARY KEY (APPEAL_ID)
);

CREATE TABLE CRIME_OFFICERS
  AS  (  SELECT CRIME_ID, OFFICER_ID
         FROM CRIMES, OFFICERS  );

ALTER TABLE CRIME_OFFICERS
  ADD CONSTRAINT CRIME_ID_FK    FOREIGN KEY (CRIME_ID)
  REFERENCES CRIMES (CRIME_ID);

ALTER TABLE CRIME_OFFICERS
  ADD CONSTRAINT OFFICER_ID_FK  FOREIGN KEY (OFFICER_ID)
  REFERENCES OFFICERS (OFFICER_ID);

CREATE TABLE CRIME_CHARGES
(                         
                        CHARGE_ID             NUMBER(10),         
                        CRIME_ID              NUMBER(9),
                        CRIME_CODE            NUMBER(3),
                        CHARGE_STATUS         CHAR(2),                            
                        FINE_AMOUNT           NUMBER(7),
                        COURT_FEE             NUMBER(7),
                        AMOUNT_PAID           NUMBER(7),
                        PAY_DUE_DATE          DATE

                        CONSTRAINT CHARGE_ID_PK             PRIMARY KEY (CHARGE_ID),

                        CONSTRAINT CHARGES_CRIME_ID_FK      FOREIGN KEY (CRIME_ID)
                        REFERENCES CRIMES (CRIME_ID),

                        CONSTRAINT CRIME_CODE_FK            FOREIGN KEY (CRIME_CODE)
                        REFERENCES CRIME_CODES (CRIME_CODE)
);

  

-- [MOD 3] CHAPTER 5 --
   /* Execute the CityJail_5.sql script to rebuild the CRIMINALS and CRIMES tables of the City Jail database.
      The statements at the beginning of this script drop existing tables in your schema with the same table names.
    * Create and execute statements to perform the following DML activities.  Save the changes permanently to the database

        1. Create a script that allows a user to add new criminals (providing prompts to the user) to the CRIMINALS table.
        2. Add the following criminals, using the script created in the previous step.  No value needs to be entered at 
           the prompt if it should be set to the DEFAULT column value.  Query the CRIMINALS table to confirm that new rows have been added.

              A. CRIMINAL_ID 1015, LAST Fenter, FIRST Jim, STREET (None), CITY Chesapeake, STATE VA, ZIP 23320, 
                 PHONE (None), V_STATUS N, P_STATUS N
              B. CRIMINAL_ID 1016, LAST Saunder, FIRST Bill, STREET 11 Apple Rd, CITY Virginia Beach, STATE VA, 
                 ZIP 23455, PHONE 7678217443, V_STATUS N, P_STATUS N
              C. CRIMINAL_ID 1017, LAST Painter, FIRST Troy, STREET 77 Ship Lane, CITY Norfolk, STATE VA, 
                 PHONE 7677655454, V_STATUS N, P_STATUS N

    * Add a column named MAIL_FLAG to the CRIMINALS table.  The column should be assigned a datatype of CHAR(1).
    * Set the MAIL_FLAG column to a value of 'Y' for all criminals.
    * Set the MAIL_FLAG column to 'N' for all criminals who don't have a street address recorded in the database.
    * Change the phone number for criminal 1016 to 7225659032.
    * Remove criminal 1017 from the database.
    * Execute a DML statement to accomplish each of the following actions.  Each statement produces a constraint error.  
      Document the error number and message, and briefly explain the cause of the error.  If your DML statement generates
      a syntax error rather than a constraint violation error, revise your statement to correct any syntax errors.
      You can review CityJail_5.sql to identify table constraints.  Add crime records using the following data:

            1. CRIME_ID 100, CRIMINAL_ID 1010, CLASSIFICATION M, DATE_CHARGED July 15 2009, STATUS PD
            2. CRIME_ID 130, CRIMINAL_ID 1016, CLASSIFICATION M, DATE_CHARGED July 15 2009, STATUS PD
            3. CRIME_ID 130, CRIMINAL_ID 1016, CLASSIFICATION P, DATE_CHARGED July 15 2009, STATUS CL
    */

DROP TABLE  CRIMINALS CASCADE CONSTRAINTS;
DROP TABLE  CRIMES CASCADE CONSTRAINTS;

INSERT INTO CRIMINALS
SET 
    CRIMINAL_ID = '&CRIMINAL_ID',
    LAST = '&LAST',
    FIRST = '&FIRST',
    STREET = '&STREET',
    CITY = '&CITY',
    STATE = '&STATE',
    ZIP = '&ZIP',
    PHONE = '&PHONE',
    V_STATUS = DEFAULT,
    P_STATUS = P_STATUS
WHERE 


INSERT INTO CRIMINALS
  (CRIMINAL_ID, LAST, FIRST, STREET, CITY, STATE, ZIP, PHONE, V_STATUS, P_STATUS)
VALUES 
  (1015, 'Fenter', 'Jim', NULL, 'Chesapeake', 'VA', '23320', NULL, DEFAULT, DEFAULT),
  (1016, 'Saunder', 'Bill', '11 Apple Rd', 'Virginia Beach', 'VA', '23455', '7678217443', DEFAULT, DEFAULT),
  (1017, 'Painter', 'Troy', '77 Ship Lane', 'Norfolk', 'VA', NULL, '7677655454', DEFAULT, DEFAULT)

ALTER TABLE CRIMINALS
  ADD MAIL_FLAG CHAR(1) DEFAULT 'Y';

UPDATE  CRIMINALS
SET     MAIL_FLAG = 'N'
WHERE   STREET = NULL;




-- [MOD 3] CHAPTER 6 --
   /* Create a sequence for the primary key columns of the CRIMINALS and CRIMES tables.
    * Add a new criminal named Johnny Capps using the correct sequence.  Use any values you wish for the remainder of his columns.
    * Add a crime for Johnny Capps; add a row to the CRIMES table, referencing the sequence value already generated for his CRIMINAL_ID
      and use the correct sequence to generate the CRIME_ID value.  Use any values you wish for the remainder of his columns.
    * Last name, street, and phone of the CRIMINALS table are used often in WHERE clauses.  
      Create objects that improve data retrieval for these queries.
    * Would a bitmap index be appropriate for any columns in the City Jail database (assuming the columns are used 
      in search and/or sort operations)?  If so, identify the columns and explain why a bitmap index is appropriate for them.
    * Would using the City Jail database be any easier with the creation of synonyms? Explain.
    */


-- [MOD 4] CHAPTER 9 --
  /* Note: Use the City Jail database created with the CityJail_8.swl script from Chp8
   * Write SQL statements that satisfy the following requests: for each request include one solution using the traditional method and one using an ANSI JOIN statement.
        *  List all criminals along with the crime charges filed.  Include criminal ID, name, crime code, and fine amount.
        *  List all criminals along with crime status and appeal status(if applicable).  The reports need to include the criminal ID, name, crime classification, 
           date charged, appeal filing date, and appeal status.  Show all criminals, regardless of whether they have filed an appeal.
        *  List all criminals along with crime information.  The report needs to include the criminal ID, name, crime classification, date charged, crime code, and
           fine amount.  Include only crimes classified as "Other".  Sort thel ist by criminal ID and date charged.
        *  Create an alphabetical list of all criminals, including criminal ID, name, violent offender status, parole status, and any known aliases.
        *  A table named Prob_Contact contains the required frequency of contact with a probation officer, based on the length of the probation period (the # of days
           assigned to probation).  Review the data in this table, which indicates ranges for the number of days and applicable contact frequencies.  Create a list containing
           the name of each criminal who has been assigned a probation period, which is indicated by the sentence type.  The list should contain the criminal name, probation
           start date, probation end date, and required frequency of contact.  Sort the list by criminal name and probation start date.
        *  A column named Mgr_ID has been added to the Prob_Officers table and contains the ID number of the probation supervisor for each officer.  Produce a list showing 
           each probation officer's name and his/her supervisor's name.  Sort alphabetically by probation officer's name.
  */

-- [MOD 4] CHAPTER 10 --
  /* An INSERT statement is needed to support users adding a new appeal.  Create an INSERT statement using substitution variables.  Note that users will be entering dates
     in the format MM DD YYYY.  In addition, a sequence named APPEALS_ID_SEQ exists to supply values for the Appeal_ID column, and the default setting for the Status
     column should take effect (that is, the DEFAULT option on the column should be used).  Test the statement by adding the following appeal: crime_ID = 25344031, filing
     date = 02 13 2009, and hearing date = 02 27 2009.
  */

-- [MOD 4] CHAPTER 11 --
  /*  Show the average number of crimes reported by an officer.
   *  Show to total number of crimes by status.
   *  List the highest number of crimes committed by a person.
   *  Display the lowest fine amount assigned to a crime charge.
   *  List criminals (ID and name) who have multiple sentences assigned.
   *  List the total number of crime charges successfullly defended (guilty status assigned) by precinct.  Include only precincts with at least 7 guilty charges.
   *  List the total aount of collections (fine and fees) and the total amount owed by crime classification.
   *  Use single queries to address the following requests:
        *  List the total # of charges by crime classification and charge status.  Include a grand total in the results.
        *  Create 3 different queries the same as above; in the 1st add a subtotal for each crime classification, in the 2nd add a subtotal for each charge status,
           3rd add a subtotal by each crime classification.
  */ 

-- [MOD 5] CHAPTER 12 --
  /*  List the name of each officer who has reported more than the average number of crimes officers have reported.
   *  List the names of all criminals who have committed less than average number of crimes and aren't listed as violent offenders.
   *  List appeal information for each appeal that has a less than average number of days between the filing and hearing dates.
   *  List the names of probation officers who have had a less than average number of criminals assigned.
   *  List each crime that has had the highest number of appeals recorded.
   *  List the information on crime charges for each charge that has had a fine above average and a sum paid below average.
   *  List the names of all criminals who have had any of the crime code charges involved in crime ID 10089.
   *  Use a correlated subquiery to determine which criminals have had at least one probation period assigend.  
   *  List the names of officers who have booked the highest number of crimes.  Note that more than one officer might be listed.
   *  Note: Use a MERGE statement for the following:
        *  The criminal data warehouse contains a copy of the CRIMINALS table that needs to be updated periodically from the production CRIMINALS table.  
           The data warehouse table is named CRIMINALS_DW.  Use a single SQL statement to update the data warehouse table to reflect any data changes for 
           existing criminals and to add new criminals.
  */ 
  
SELECT * 
FROM  CRIMINALS C
WHERE C.P_STATUS = 'Y'
AND   C.CRIMINAL_ID in (SELECT    S.CRIMINAL_ID
                        FROM      SENTENCES S
                        WHERE     S.PROB_ID IS NOT NULL
                        AND       S.CRIMINAL_ID = C.CRIMINAL_ID);
SELECT *
FROM  APPEALS
WHERE CRIME_ID = (SELECT CRIME_ID
                  FROM  CRIMES
                  GROUP BY CRIME_ID);

SELECT    COUNT(CRIME_ID),
          CRIME_ID
FROM      APPEALS
GROUP BY  CRIME_ID
HAVING    COUNT(CRIME_ID) = (SELECT   MAX(APPEAL_COUNT),
                                      CRIME_ID
                            FROM     (SELECT COUNT(CRIME_ID) APPEAL_COUNT,
                                      CRIME_ID
                                      FROM      APPEALS
                                      GROUP BY CRIME_ID));

SELECT  AVG(CRIME_COUNT)  --Will need this query for parts 1-3
FROM    (SELECT   COUNT(CRIME_ID) CRIME_COUNT
        FROM      CRIME_OFFICERS
        GROUP BY  OFFICER_ID)


-- [MOD 5] CHAPTER 13 --
  /*  Create a statement that always returns the names of the 3 criminals with the highest number of crimes committed.
   *  Create a view that includes details for all crimes, including criminal ID, criminal name, criminal parole status, crime ID, date of crime charge,
      crime status, charge ID, crime code, charge status, pay due date, and amount due.  This view shouldn't allow performing any DML operations.  Each time
      the view is used in the application, the data should be queried from the database.  (For example, each use of the view should reflect the most current
      data in the database.)
   *  Create a view that includes all data for officers, including the total number of crimes in which they participated in filing charges.  To speed up
      the officer queries, store this view data and schedule the data to be updated every 2 wks.
  */






          




















