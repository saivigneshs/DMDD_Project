set serveroutput on;
begin
DBMS_OUTPUT.PUT_LINE('DMDD Project');
end;
--Saivignesh Start
CREATE TABLE LOCATION 
(
  LOC_ID NUMBER PRIMARY KEY
, LOC_NAME VARCHAR2(20) 
);

CREATE TABLE BOOKINGS 
(
  BOOKING_ID NUMBER PRIMARY KEY
, FM_ID NUMBER 
, SLOT_ID NUMBER 
, BOOKING_TIME TIMESTAMP 
, BOOK_STATUS VARCHAR2(30) 
);

CREATE TABLE SLOTS
(
  SLOT_ID NUMBER PRIMARY KEY
, DAY_OF_WEEK VARCHAR2(20)
, SLOT_TIME TIMESTAMP
, SLOT_COUNT NUMBER
);

CREATE TABLE LOC_STATS 
(
  LOC_ID NUMBER 
, CURRENT_DATE DATE 
, IS_INSECT_SEINED VARCHAR2(1) 
, WATER_TEMP DECIMAL 
, LAST_DECON_TIME TIMESTAMP 
, O2_CONC_LEVEL DECIMAL 
, NH4_CONC_LEVEL DECIMAL 
, LAST_FEED_DATE TIMESTAMP 
);

ALTER TABLE BOOKINGS
ADD FOREIGN KEY (fm_id) REFERENCES fisherman(fm_id);
ALTER TABLE BOOKINGS
ADD FOREIGN KEY (slot_id) REFERENCES slots(slot_id);
-- Saivignesh Ends
-- Vignesh Start
CREATE TABLE FISHERMAN 
   ("FM_ID" INT, 
	"FIRST_NAME" VARCHAR2(100 BYTE), 
	"LAST_NAME" VARCHAR2(100 BYTE), 
	"AGE" INT, 
	"GENDER" VARCHAR2(1 BYTE), 
	"EXPERIENCE" FLOAT(126), 
	"MOBILE_NO" VARCHAR2(30 BYTE), 
	"EMAIL" VARCHAR2(100 BYTE), 
	 CONSTRAINT "FISHERMAN_PK" PRIMARY KEY ("FM_ID")
   );
CREATE TABLE FISH_STATS 

   ("FISH_INV_ID" INT, 
	"FISH_ID" INT, 
	"TOT_FISH_QTY" INT, 
	"CURRENT_DATE" TIMESTAMP (6), 
	"SUBLOC_ID" INT, 
	 CONSTRAINT "FISH_STATS_PK" PRIMARY KEY ("FISH_INV_ID"), 
	 CONSTRAINT "FISH_STATS_FK1" FOREIGN KEY ("FISH_ID")
     REFERENCES FISH_SPECIES ("FISH_ID") ENABLE
 );
CREATE TABLE FISH_SPECIES
   ("FISH_ID" INT, 
	"SPECIES_NAME" VARCHAR2(30 BYTE), 
	"AVG_LENGTH" FLOAT(126), 
	"ABG_WEIGHTD" FLOAT(126), 
	 CONSTRAINT "FISH_SPECIES_PK" PRIMARY KEY ("FISH_ID")
    );
CREATE TABLE FISHERMAN_DETAILS
   ("FM_ID" INT, 
	"ADDRESS_1" VARCHAR2(100 BYTE), 
	"ADDRESS_2" VARCHAR2(100 BYTE), 
	"CITY" VARCHAR2(100 BYTE), 
	"STATE" VARCHAR2(100 BYTE), 
	"ZIPCODE" VARCHAR2(100 BYTE)
   );
--Vignesh End
----VISHAL START

CREATE TABLE CHECKIN_LOG 
(
  BOOKING_ID NUMBER 
, CHECKIN_ID NUMBER PRIMARY KEY 
, ENTRY_TIME TIMESTAMP
, COVID_RESULT VARCHAR(1)
, IS_PPE_AVAILABLE VARCHAR(1)
);

CREATE TABLE CHECKOUT_LOG 
(
  CHECKIN_ID NUMBER 
, FISH_INV_ID NUMBER
, CATCH_QTY NUMBER
, EXIT_TIME TIMESTAMP
);

CREATE TABLE SUB_LOCATION
(
  SUBLOC_ID NUMBER PRIMARY KEY
, SUBLOC_NAME VARCHAR(30)
, LOC_ID NUMBER
);
--- VISHAL END
--VISHAL START

ALTER TABLE CHECKIN_LOG
ADD FOREIGN KEY (booking_id) REFERENCES bookings(booking_id);

ALTER TABLE CHECKOUT_LOG
ADD FOREIGN KEY (checkin_id) REFERENCES checkin_log(checkin_id);

ALTER TABLE CHECKOUT_LOG
ADD FOREIGN KEY (fish_inv_id) REFERENCES fish_stats(fish_inv_id);

ALTER TABLE SUB_LOCATION
ADD FOREIGN KEY (loc_id) REFERENCES location(loc_id);
---vishal ends







