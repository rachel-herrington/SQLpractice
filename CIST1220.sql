--------------------------------------------------------
--  File created - Thursday-January-11-2018   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table CONTACTS
--------------------------------------------------------

  CREATE TABLE "CONTACTS" 
  ( 	                       "CON_PK"              NUMBER, 
	                           "CON_NAME"            VARCHAR2(300 BYTE), 
	                           "CON_PHONE"           VARCHAR2(20 BYTE), 
	                           "CON_EMAIL"           VARCHAR2(150 BYTE), 
	                           "CON_CREATE_DATE"     DATE, 
	                           "CON_LAST_UPDATE"     DATE, 
	                           "CON_STATE"           VARCHAR2(2 BYTE)
   ) 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE
  (     INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
        PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  );

REM INSERTING into CONTACTS
SET DEFINE OFF;
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (1,'Alexander Gipp','555-555-5555','agipp@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'GA');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (2,'Andrew Singley','555-555-5555','asing@gmail.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'SC');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (3,'Alyssa Tarmey','555-555-5555','atarmey@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'AL');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (4,'Arthur Wilson','555-555-5555','awilson@gmail.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'AK');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (5,'Austin Fowler','555-555-5555','afowler@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'AK');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (6,'Anna Lane','555-555-5555','alane@gmail.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'GA');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (7,'Abby Renee','555-555-5555','arenee@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'KY');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (8,'Adam Drury','555-555-5555','adrury@gamil.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'LA');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (9,'Aldren Daniels','555-555-5555','adaniels@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'MS');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (10,'Amanda Bohrer','555-555-5555','abohrer@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'MI');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (11,'Becca Gallagher','555-555-5555','bgallagher@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'NE');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (12,'Becca Heath','555-555-5555','bheath@gmail.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'SD');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (13,'Bradley Peterson','555-555-5555','bpetey@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'TX');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (14,'Brian Rachel','555-555-5555','brachell@gmail.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'WA');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (15,'Brianna Crosby','555-555-5555','bCrosby@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'NE');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (16,'Brooke Crosby','555-555-5555','bcrosb@gmail.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'WY');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (17,'Bill Christensen','555-555-5555','bcchrist@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'FL');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (18,'Been Cooper','555-555-5555','bcoop@gamil.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'AR');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (19,'Billy Madison','555-555-5555','bmadison@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'CA');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (20,'Benny Wright','555-555-5555','beniWri@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'CA');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (21,'Caitlyn Lower','555-555-5555','clower@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'WY');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (22,'Caitlyn Smith','555-555-5555','csmith@gmail.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'ID');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (23,'Carl Benton','555-555-5555','cbjr@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'IL');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (24,'Carlin Morrison','555-555-5555','cmorris@gmail.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'MD');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (25,'Carrington Ware','555-555-5555','cware@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'NY');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (26,'Casey Alarcon','555-555-5555','calarcon@gmail.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'OH');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (27,'Cindy Purvis','555-555-5555','cPurvis@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'OK');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (28,'Cheyenne Little','555-555-5555','clittle@gamil.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'NJ');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (29,'Chris Perez','555-555-5555','cperez@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'NY');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (30,'Chungfar Ha','555-555-5555','cfarHa@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'NC');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (31,'Jackie Veuleman','555-555-5555','jveul@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'NC');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (32,'Jacob Vurnakes','555-555-5555','jvurn@gmail.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'UT');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (33,'Jaima Griffith','555-555-5555','jgriffy@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'VT');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (34,'Jamal Register','555-555-5555','jregister@gmail.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'KY');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (35,'Jared Mendelsohn','555-555-5555','jmedl@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'OR');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (36,'Jason Willis','111-111-1111','jwilli@gmail.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'MD');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (37,'Jayce Russel','555-555-5555','russelJ@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'GA');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (38,'Jeff Tarm','555-555-5555','jtarmey@gamil.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'IA');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (39,'Jerry Thoms','555-555-5555','jthoms@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'KS');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (40,'Jessica Billingsley','555-555-5555','jbilli@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'DE');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (41,'Kati Smith','555-555-5555','katsmith@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'DE');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (42,'KD Gipp','555-555-5555','kgipper@gmail.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'GA');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (43,'Katie Florine','555-555-5555','kflorine@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'CA');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (44,'Keith Long','555-555-5555','klongy@gmail.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'FL');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (45,'Kemper Bartley','555-555-5555','kbar@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'FL');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (46,'Ken Theis','555-555-5555','kthe@gmail.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'GA');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (47,'Kristen Dees','555-555-5555','kdeez@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'GA');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (48,'Kristi Ferguson','555-555-5555','kferg@gamil.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'GA');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (49,'Kyle Wigger','555-555-5555','kwigger@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'GA');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (50,'Kylie Kreusch','555-555-5555','kkrew@yahoo.com',to_date('07-MAR-17','DD-MON-RR'),to_date('07-MAR-17','DD-MON-RR'),'HI');
Insert into CONTACTS (CON_PK,CON_NAME,CON_PHONE,CON_EMAIL,CON_CREATE_DATE,CON_LAST_UPDATE,CON_STATE) values (200,'Chelsey','9125558941','chey@gmail.com',to_date('13-APR-17','DD-MON-RR'),to_date('13-APR-17','DD-MON-RR'),'CA');
--------------------------------------------------------
--  DDL for Index SYS_C0030960
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C0030960" ON "CONTACTS" ("CON_PK") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE
  (       INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
          PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  );
--------------------------------------------------------
--  Constraints for Table CONTACTS
--------------------------------------------------------

  ALTER TABLE "CONTACTS" MODIFY ("CON_NAME" NOT NULL ENABLE);
 
  ALTER TABLE "CONTACTS" MODIFY ("CON_PHONE" NOT NULL ENABLE);
 
  ALTER TABLE "CONTACTS" MODIFY ("CON_EMAIL" NOT NULL ENABLE);
 
  ALTER TABLE "CONTACTS" MODIFY ("CON_CREATE_DATE" NOT NULL ENABLE);
 
  ALTER TABLE "CONTACTS" MODIFY ("CON_LAST_UPDATE" NOT NULL ENABLE);
 
  ALTER TABLE "CONTACTS" ADD PRIMARY KEY ("CON_PK")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE
  (       INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
          PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  ) ENABLE;
