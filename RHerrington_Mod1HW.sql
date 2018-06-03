DROP TABLE  CRIMINALS CASCADE CONSTRAINTS;
DROP TABLE  CRIMES CASCADE CONSTRAINTS;

CREATE TABLE CRIMINALS
(                         
                          CRIMINAL_ID                           NUMBER(6),
                          LAST                                  VARCHAR2(15),
                          FIRST                                 VARCHAR2(10),
                          STREET                                VARCHAR2(30),
                          CITY                                  VARCHAR2(20),
                          STATE                                 CHAR(2),
                          ZIP                                   CHAR(5),
                          PHONE                                 CHAR(10),
                          V_STATUS                              CHAR(1) DEFAULT 'N',
                          P_STATUS                              CHAR(1) DEFAULT 'N' 
);

CREATE TABLE CRIMES
(                         
                          CRIME_ID                              NUMBER(9),
                          CRIMINAL_ID                           NUMBER(6),
                          CLASSIFICATION                        CHAR(1),
                          DATE_CHARGED                          DATE,
                          STATUS                                CHAR(2),
                          HEARING_DATE                          DATE,
                          APPEAL_CUT_DATE                       DATE
);

ALTER TABLE CRIMES
  MODIFY (CLASSIFICATION DEFAULT 'U');

ALTER TABLE CRIMES
  ADD (DATE_RECORDED DATE DEFAULT SYSDATE);

ALTER TABLE CRIMINALS
  ADD CONSTRAINT CRIMINAL_ID_PK PRIMARY KEY (CRIMINAL_ID;

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

ALTER TABLE CRIMES
  MODIFY (CRIMINAL_ID NOT NULL);
