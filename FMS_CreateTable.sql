SET SERVEROUTPUT ON;

DECLARE
    row_ct NUMBER(10);
-- FISHERMAN TABLE CREATION
BEGIN
    SELECT
        COUNT(*)
    INTO row_ct
    FROM
        user_tables
    WHERE
        table_name = 'FISHERMAN';

    IF ( row_ct > 0 ) THEN
        dbms_output.put_line('TABLE FISHERMAN ALREADY EXISTS');
    ELSE
        EXECUTE IMMEDIATE 'CREATE TABLE FISHERMAN
     (	"FM_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"FIRST_NAME" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"LAST_NAME" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"AGE" NUMBER(*,0) NOT NULL ENABLE, 
	"GENDER" VARCHAR2(1 BYTE) NOT NULL ENABLE, 
	"EXPERIENCE" FLOAT(126) NOT NULL ENABLE, 
	"MOBILE_NO" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	"EMAIL" VARCHAR2(100 BYTE) NOT NULL ENABLE,
    CONSTRAINT MOBILE_NO_VALIDATION CHECK(REGEXP_LIKE(MOBILE_NO, ''^[0-9]{10}$'')),
    CONSTRAINT "FISHERMAN_PK" PRIMARY KEY ("FM_ID")
    )
    ';
        dbms_output.put_line('TABLE FISHERMAN CREATED SUCCESSFULLY');
    END IF;

END;
/
-- FISHERMAN_DETAILS TABLE CREATION
BEGIN
    SELECT
        COUNT(*)
    INTO row_ct
    FROM
        user_tables
    WHERE
        table_name = 'FISHERMAN_DETAILS';

    IF ( row_ct > 0 ) THEN
        dbms_output.put_line('TABLE FISHERMAN_DETAILS ALREADY EXISTS');
    ELSE
        EXECUTE IMMEDIATE 'CREATE TABLE FISHERMAN_DETAILS
      (	"FM_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"ADDRESS_1" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"ADDRESS_2" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"CITY" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"STATE" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"ZIPCODE" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	 CONSTRAINT "FM_DETAIL_FK" FOREIGN KEY ("FM_ID")
     REFERENCES FISHERMAN ("FM_ID") ENABLE
   )
    ';
        dbms_output.put_line('TABLE FISHERMAN_DETAILS CREATED SUCCESSFULLY');
    END IF;

END;
/
-- SLOTS TABLE CREATION 
BEGIN
    SELECT
        COUNT(*)
    INTO row_ct
    FROM
        user_tables
    WHERE
        table_name = 'SLOTS';

    IF ( row_ct > 0 ) THEN
        dbms_output.put_line('TABLE SLOTS ALREADY EXISTS');
    ELSE
        EXECUTE IMMEDIATE 'CREATE TABLE SLOTS
      (	"SLOT_ID" NUMBER, 
	"DAY_OF_WEEK" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"SLOT_TIME" TIMESTAMP (6) NOT NULL ENABLE, 
	"SLOT_COUNT" NUMBER NOT NULL ENABLE, 
	"SUBLOC_ID" NUMBER(*,0) NOT NULL ENABLE, 
	 PRIMARY KEY ("SLOT_ID"),
     CONSTRAINT "SUBLOC_ID_FK" FOREIGN KEY ("SUBLOC_ID")
     REFERENCES SUB_LOCATION ("SUBLOC_ID") ENABLE
   )
    ';
        dbms_output.put_line('TABLE SLOTS CREATED SUCCESSFULLY');
    END IF;

END;
/
-- SUB_LOCATION TABLE CREATION 
BEGIN
    SELECT
        COUNT(*)
    INTO row_ct
    FROM
        user_tables
    WHERE
        table_name = 'SUB_LOCATION';

    IF ( row_ct > 0 ) THEN
        dbms_output.put_line('TABLE SUB_LOCATION ALREADY EXISTS');
    ELSE
        EXECUTE IMMEDIATE 'CREATE TABLE SUB_LOCATION
(	"SUBLOC_ID" NUMBER, 
	"SUBLOC_NAME" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	"LOC_ID" NUMBER NOT NULL ENABLE, 
	 PRIMARY KEY ("SUBLOC_ID"),
     CONSTRAINT "LOC_ID_FK" FOREIGN KEY ("LOC_ID")
     REFERENCES LOCATION ("LOC_ID") ENABLE
   )
    ';
        dbms_output.put_line('TABLE SUB_LOCATION CREATED SUCCESSFULLY');
    END IF;

END;
/
-- BOOKINGS TABLE CREATION 
BEGIN
    SELECT
        COUNT(*)
    INTO row_ct
    FROM
        user_tables
    WHERE
        table_name = 'BOOKINGS';

    IF ( row_ct > 0 ) THEN
        dbms_output.put_line('TABLE BOOKINGS ALREADY EXISTS');
    ELSE
        EXECUTE IMMEDIATE 'CREATE TABLE BOOKINGS
   (	"BOOKING_ID" NUMBER, 
	"FM_ID" NUMBER NOT NULL ENABLE, 
	"SLOT_ID" NUMBER NOT NULL ENABLE, 
	"BOOKING_TIME" TIMESTAMP (6) NOT NULL ENABLE, 
	"BOOK_STATUS" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	 CONSTRAINT BOOK_STATUS_CHECK CHECK (BOOK_STATUS IN (''SUCCESS'',''FAILURE'',''PENDING'')),
     PRIMARY KEY ("BOOKING_ID"),
     CONSTRAINT "FM_ID_FK" FOREIGN KEY ("FM_ID")
	 REFERENCES FISHERMAN ("FM_ID") ENABLE, 
	 CONSTRAINT "SLOT_ID_FK" FOREIGN KEY ("SLOT_ID")
	 REFERENCES SLOTS ("SLOT_ID") ENABLE
   ) 
    ';
        dbms_output.put_line('TABLE BOOKINGS CREATED SUCCESSFULLY');
    END IF;

END;
/
-- FISH_SPECIES TABLE CREATION 
BEGIN
    SELECT
        COUNT(*)
    INTO row_ct
    FROM
        user_tables
    WHERE
        table_name = 'FISH_SPECIES';

    IF ( row_ct > 0 ) THEN
        dbms_output.put_line('TABLE FISH_SPECIES ALREADY EXISTS');
    ELSE
        EXECUTE IMMEDIATE 'CREATE TABLE FISH_SPECIES
   ("FISH_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"SPECIES_NAME" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	"AVG_LENGTH" FLOAT(126) NOT NULL ENABLE, 
	"ABG_WEIGHTD" FLOAT(126) NOT NULL ENABLE, 
	 CONSTRAINT "FISH_SPECIES_PK" PRIMARY KEY ("FISH_ID"))
   ) 
    ';
        dbms_output.put_line('TABLE FISH_SPECIES CREATED SUCCESSFULLY');
    END IF;

END;
/
-- FISH_STATS TABLE CREATION 
BEGIN
    SELECT
        COUNT(*)
    INTO row_ct
    FROM
        user_tables
    WHERE
        table_name = 'FISH_STATS';

    IF ( row_ct > 0 ) THEN
        dbms_output.put_line('TABLE FISH_STATS ALREADY EXISTS');
    ELSE
        EXECUTE IMMEDIATE 'CREATE TABLE FISH_STATS
   (	"FISH_INV_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"FISH_ID" NUMBER(*,0) NOT NULL ENABLE, 
	"TOT_FISH_QTY" NUMBER(*,0) NOT NULL ENABLE, 
	"CURRENT_DATE" TIMESTAMP (6) NOT NULL ENABLE, 
	"SUBLOC_ID" NUMBER(*,0) NOT NULL ENABLE, 
	 CONSTRAINT "FISH_STATS_PK" PRIMARY KEY ("FISH_INV_ID")
     CONSTRAINT "FISH_STATS_FK1" FOREIGN KEY ("FISH_ID")
     REFERENCES FISH_SPECIES ("FISH_ID") ENABLE, 
	 CONSTRAINT "FISH_STATS_FK" FOREIGN KEY ("SUBLOC_ID")
	 REFERENCES SUB_LOCATION ("SUBLOC_ID") ENABLE
   ) 
    ';
        dbms_output.put_line('TABLE FISH_STATS CREATED SUCCESSFULLY');
    END IF;

END;
/
-- LOCATION TABLE CREATION 
BEGIN
    SELECT
        COUNT(*)
    INTO row_ct
    FROM
        user_tables
    WHERE
        table_name = 'LOCATION';

    IF ( row_ct > 0 ) THEN
        dbms_output.put_line('TABLE LOCATION ALREADY EXISTS');
    ELSE
        EXECUTE IMMEDIATE 'CREATE TABLE LOCATION
   ("LOC_ID" NUMBER, 
	"LOC_NAME" VARCHAR2(20 BYTE), 
	 PRIMARY KEY ("LOC_ID")
   ) 
    ';
        dbms_output.put_line('TABLE LOCATION CREATED SUCCESSFULLY');
    END IF;

END;
/
-- CHECKIN_LOG TABLE CREATION 
BEGIN 
    SELECT count(*) into ROW_CT FROM user_tables where table_name = 'CHECKIN_LOG';
    IF(ROW_CT > 0)
    THEN
        DBMS_OUTPUT.PUT_LINE('TABLE CHECKIN_LOG ALREADY EXISTS');
    ELSE
        EXECUTE IMMEDIATE 'CREATE TABLE CHECKIN_LOG
   ("BOOKING_ID" NUMBER NOT NULL ENABLE, 
	"CHECKIN_ID" NUMBER, 
	"ENTRY_TIME" TIMESTAMP (6) NOT NULL ENABLE, 
	"COVID_RESULT" VARCHAR2(1 BYTE) NOT NULL ENABLE, 
	"IS_PPE_AVAILABLE" VARCHAR2(1 BYTE) NOT NULL ENABLE, 
	 PRIMARY KEY ("CHECKIN_ID"),
     CONSTRAINT "CHECKIN_LOG_FK" FOREIGN KEY ("BOOKING_ID")
	  REFERENCES BOOKINGS ("BOOKING_ID") ENABLE
   ) 
    ';    
     DBMS_OUTPUT.PUT_LINE('TABLE CHECKIN_LOG CREATED SUCCESSFULLY');
     END IF;
END;
/
-- CHECKOUT_LOG TABLE CREATION 
BEGIN 
    SELECT count(*) into ROW_CT FROM user_tables where table_name = 'CHECKOUT_LOG';
    IF(ROW_CT > 0)
    THEN
        DBMS_OUTPUT.PUT_LINE('TABLE CHECKOUT_LOG ALREADY EXISTS');
    ELSE
        EXECUTE IMMEDIATE 'CREATE TABLE CHECKOUT_LOG
   ("CHECKIN_ID" NUMBER NOT NULL ENABLE, 
	"FISH_INV_ID" NUMBER NOT NULL ENABLE, 
	"CATCH_QTY" NUMBER NOT NULL ENABLE, 
	"EXIT_TIME" TIMESTAMP (6) NOT NULL ENABLE, 
	 CONSTRAINT "CHECKOUT_LOG_FK1" FOREIGN KEY ("CHECKIN_ID")
	  REFERENCES CHECKIN_LOG ("CHECKIN_ID") ENABLE, 
	 CONSTRAINT "CHECKOUT_LOG" FOREIGN KEY ("FISH_INV_ID")
	  REFERENCES FISH_STATS ("FISH_INV_ID") ENABLE
   ) 
    ';    
     DBMS_OUTPUT.PUT_LINE('TABLE CHECKOUT_LOG CREATED SUCCESSFULLY');
     END IF;
END;
/
-- LOC_STATS TABLE CREATION 
BEGIN 
    SELECT count(*) into ROW_CT FROM user_tables where table_name = 'LOC_STATS';
    IF(ROW_CT > 0)
    THEN
        DBMS_OUTPUT.PUT_LINE('TABLE LOC_STATS ALREADY EXISTS');
    ELSE
        EXECUTE IMMEDIATE 'CREATE TABLE LOC_STATS
   ( "LOC_ID" NUMBER NOT NULL ENABLE, 
	"CURRENT_DATE" DATE NOT NULL ENABLE, 
	"IS_INSECT_SEINED" VARCHAR2(1 BYTE) NOT NULL ENABLE, 
	"WATER_TEMP" NUMBER(*,0) NOT NULL ENABLE, 
	"LAST_DECON_TIME" TIMESTAMP (6) NOT NULL ENABLE,
    "O2_CONC_LEVEL" NUMBER(38,2) NOT NULL ENABLE,
    "NH4_CONC_LEVEL" NUMBER(38,2) NOT NULL ENABLE,
    "LAST_FEED_DATE" TIMESTAMP (6) NOT NULL ENABLE,
     CONSTRAINT "LOC_STATS_LOC_ID_FK" FOREIGN KEY ("LOC_ID")
     REFERENCES LOCATION ("LOC_ID") ENABLE
   ) 
    ';    
     DBMS_OUTPUT.PUT_LINE('TABLE LOC_STATS CREATED SUCCESSFULLY');
     END IF;
END;
/



