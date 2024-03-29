-- Function to calculate remaining Fish Qty in a sub locatio.
create or replace FUNCTION fish_inv_calc (fi_fishInvID IN number, fi_catchQty IN number)
return number 
is
rem_value number(5);
Begin
    select (tot_fish_qty -fi_catchQty) into rem_value from fish_stats where fish_inv_id = fi_fishInvID;
    dbms_output.put_line('Value is '|| rem_value || ' after calculation.');
    return (rem_value);
end;
select fish_inv_calc(103,23) from dual;

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

--- ROLES ---
CREATE ROLE FisheriesAdmin;

CREATE ROLE Management;

DROP ROLE Fisherman;

DROP ROLE Prem_Biologist;

CREATE ROLE Fisherman;

CREATE ROLE Prem_Biologist;

grant create session, select any table, select any dictionary to FisheriesAdmin;
grant update any table to FisheriesAdmin;
grant insert any table to FisheriesAdmin;

GRANT SELECT, INSERT, UPDATE, DELETE ON SLOTS  TO Management;
GRANT SELECT, INSERT, UPDATE, DELETE ON LOCATION  TO Management;
GRANT SELECT, INSERT, UPDATE, DELETE ON SUB_LOCATION  TO Management;
GRANT SELECT, INSERT, UPDATE, DELETE ON BOOKINGS  TO Management;
GRANT SELECT, INSERT, UPDATE, DELETE ON FISHERMAN  TO Management;
GRANT SELECT ON FISHERMAN_DETAILS  TO Management;
GRANT SELECT ON FISH_SPECIES  TO Management;
GRANT SELECT ON LOC_STATS  TO Management;
GRANT SELECT ON CHECKIN_LOG  TO Management;
GRANT SELECT ON CHECKOUT_LOG  TO Management;
GRANT SELECT ON FISH_STATS  TO Management;

GRANT SELECT ON FISHERMAN_DETAILS  TO Fisherman;
GRANT SELECT ON LOCATION  TO Fisherman;
GRANT SELECT ON FISH_STATS  TO Fisherman;

GRANT SELECT ON LOCATION  TO Prem_Biologist;
GRANT SELECT ON FISH_STATS  TO Prem_Biologist;
GRANT SELECT, INSERT, UPDATE, DELETE ON FISH_SPECIES  TO Prem_Biologist;
GRANT SELECT, INSERT, UPDATE, DELETE ON FISH_STATS  TO Prem_Biologist;
GRANT SELECT, INSERT, UPDATE, DELETE ON LOC_STATS  TO Prem_Biologist;


------ TRIGGER

CREATE TABLE audits (
      audit_id         NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
      table_name       VARCHAR2(255),
      transaction_name VARCHAR2(10),
      by_user          VARCHAR2(30),
      transaction_date DATE
);

CREATE OR REPLACE TRIGGER Fisherman_audit_trg
    AFTER 
    UPDATE OR DELETE 
    ON fisherman
    FOR EACH ROW    
DECLARE
   l_transaction VARCHAR2(30);
BEGIN
   
   l_transaction := CASE  
         WHEN UPDATING THEN 'UPDATE'
         WHEN DELETING THEN 'DELETE'
   END;
 
   INSERT INTO audits (table_name, transaction_name, by_user, transaction_date)
   VALUES('FISHERMAN', l_transaction, USER, SYSDATE);
END;

DELETE FROM fisherman
WHERE fm_id = 111;

SELECT * FROM audits;