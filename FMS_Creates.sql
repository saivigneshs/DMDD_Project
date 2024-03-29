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

CREATE ROLE FisheriesAdmin;

CREATE ROLE Management;

DROP ROLE Fisherman;

DROP ROLE Prem_Biologist;

CREATE ROLE Fisherman;

CREATE ROLE Prem_Biologist;

grant create session, select any table, select any dictionary to FisheriesAdmin;
grant update any table to FisheriesAdmin;
grant insert any table to FisheriesAdmin;

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

GRANT SELECT ON SCHEMA.FISHERMAN_DETAILS  TO Fisherman;
GRANT SELECT ON SCHEMA.LOCATION  TO Fisherman;
GRANT SELECT ON SCHEMA.FISH_STATS  TO Fisherman;

GRANT SELECT ON SCHEMA.LOCATION  TO Prem_Biologist;
GRANT SELECT ON SCHEMA.FISH_STATS  TO Prem_Biologist;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA.FISH_SPECIES  TO Prem_Biologist;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA.FISH_STATS  TO Prem_Biologist;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA.LOC_STATS  TO Prem_Biologist;