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

---Saivignesh Start--
--PROC for booking a slot --

Create or replace procedure Book_slot (pi_fm_id int, pi_slot_id int, po_booking_id out int)
as 
slot_ct int := 0;
BEGIN
select slot_count into slot_ct from "SLOTS" where slot_id = pi_slot_id;
if slot_ct <= 0
then
dbms_output.Put_line('This Slot is currently full. Please try a different slot.');
return;
elsif slot_ct between 1 and 8
then
dbms_output.Put_line('Very few slots are available, Hurry up!');
return;
else
SELECT MAX(booking_id)+1 into po_booking_id FROM "BOOKINGS";
insert into bookings(booking_id, fm_id, slot_id, booking_time, book_status) values(po_booking_id,pi_fm_id,pi_slot_id,sysdate,'SUCCESS');
dbms_output.Put_line('Booked Slot ' || pi_slot_id || ' Successfully! '|| po_booking_id); 
update slots set slot_count = slot_ct - 1 where slot_id = pi_slot_id; 
dbms_output.Put_line('Updated Slots Table for ' || pi_slot_id || ' Successfully! '); 
end if;
END;

select * from fisherman where fm_id = '2';
--2	Dean	Bradley	46	M	3	(774) 350-3917	erat.Vivamus@ac.net
select * from slots where slot_id = '101';
--101	Tuesday	01-APR-21 06.00.00.000000000 AM	12	
select * from bookings where booking_id= '301';	
declare po_book_id INT := 0;
BEGIN
BOOK_SLOT (2,101,po_book_id);
END;
--- saivignesh ends


---vishal

CREATE ROLE FisheriesAdmin;

CREATE ROLE Management;

DROP ROLE Fisherman;--resolving git conflict

DROP ROLE Prem_Biologist; --resolving git conflict

CREATE ROLE Fisherman;

CREATE ROLE Prem_Biologist;

---Vishal END

---Vishal Start
grant create session, select any table, select any dictionary to FisheriesAdmin;
grant update any table to FisheriesAdmin;
grant insert any table to FisheriesAdmin;

---Vishal Ends
--vishal start
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA.SLOTS  TO Management;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA.LOCATION  TO Management;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA.SUB_LOCATION  TO Management;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA.BOOKINGS  TO Management;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA.FISHERMAN  TO Management;
GRANT SELECT ON SCHEMA.FISHERMAN_DETAILS  TO Management;
GRANT SELECT ON SCHEMA.FISH_SPECIES  TO Management;
GRANT SELECT ON SCHEMA.LOC_STATS  TO Management;
GRANT SELECT ON SCHEMA.CHECKIN_LOG  TO Management;
GRANT SELECT ON SCHEMA.CHECKOUT_LOG  TO Management;
GRANT SELECT ON SCHEMA.FISH_STATS  TO Management;

--Vishal End
--vishal start

GRANT SELECT ON SCHEMA.FISHERMAN_DETAILS  TO Fisherman;
GRANT SELECT ON SCHEMA.LOCATION  TO Fisherman;
GRANT SELECT ON SCHEMA.FISH_STATS  TO Fisherman;
--Vishal End

--vishal start
GRANT SELECT ON SCHEMA.LOCATION  TO Prem_Biologist;
GRANT SELECT ON SCHEMA.FISH_STATS  TO Prem_Biologist;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA.FISH_SPECIES  TO Prem_Biologist;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA.FISH_STATS  TO Prem_Biologist;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA.LOC_STATS  TO Prem_Biologist;
--vishal END

---vishal start
CREATE or replace VIEW CATCHQTY
AS
SELECT A.FM_ID,A.FIRST_NAME||''||A.lAST_NAME AS FISHERMAN_NAME,b.booking_id,c.checkin_id,sum(d.catch_qty) as Total_Catches
FROM fisherman A
INNER JOIN bookings B ON A.FM_ID=B.FM_ID
INNER JOIN checkin_log C ON b.booking_id=c.booking_id
INNER JOIN checkout_log D ON d.checkin_id=c.checkin_id
group by a.fm_id,a.first_name, a.last_name, b.booking_id, c.checkin_id
order by a.fm_id;

------------
CREATE or replace VIEW CatchBYLocation
AS
(SELECT f.loc_name,sum(a.catch_qty)as Total_Catches ---,B.checkin_id,c.booking_id,d.slot_id,e.subloc_id,A.checkin_id
FROM checkout_log A
INNER JOIN checkin_log B ON a.checkin_id=b.checkin_id
INNER JOIN bookings C ON b.booking_id=c.booking_id
INNER JOIN slots D ON c.slot_id=d.slot_id
INNER JOIN sub_location E ON d.subloc_id=e.subloc_id
INNER JOIN location F ON e.loc_id=f.loc_id
group by f.loc_name);

SELECT
    *
FROM CatchBYLocation;

CREATE or REPLACE VIEW lastfeeddatebyspeciesname
AS
SELECT a.species_name,i.last_feed_date
FROM fish_species A
INNER JOIN fish_stats B ON a.fish_id=b.fish_id
INNER JOIN checkout_log C ON b.fish_inv_id=c.fish_inv_id
INNER JOIN checkin_log D ON c.checkin_id=d.checkin_id
INNER JOIN bookings E ON d.booking_id=e.booking_id
INNER JOIN slots F ON f.slot_id=e.slot_id
INNER JOIN sub_location G ON f.subloc_id=g.subloc_id
INNER JOIN location H ON g.loc_id=h.loc_id
INNER JOIN loc_stats I ON h.loc_id=i.loc_id
group by a.species_name,i.last_feed_date
order by i.last_feed_date
;

SELECT
    *
FROM lastfeeddatebyspeciesname;



-------------
CREATE OR REPLACE VIEW popular_fish
AS
SELECT a.species_name,sum(c.catch_qty)as Total_Catches
FROM fish_species A
INNER JOIN fish_stats B ON a.fish_id=b.fish_id
INNER JOIN checkout_log C ON b.fish_inv_id=C.fish_inv_id
GROUP BY a.species_name
ORDER BY Total_Catches desc
;

SELECT
*
FROM popular_fish;

---------------------------
CREATE OR REPLACE VIEW BusyToDull
AS

SELECT  count(*) as Total_booking, b.day_of_week
FROM bookings A INNER JOIN slots B ON a.slot_id = b.slot_id
GROUP BY b.day_of_week
ORDER BY Total_booking desc
;

SELECT
    *
FROM BusyToDull;