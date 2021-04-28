CREATE OR REPLACE PROCEDURE ADD_LOCATION(pi_loc_id NUMBER, pi_loc_name VARCHAR2)
    AS
    ROW_CT NUMBER;
    BEGIN  
    select count(*) into ROW_CT from LOCATION where loc_name = pi_loc_name and loc_id = pi_loc_id;
    if(ROW_CT>0) then
        dbms_output.put_line('RECORD '|| pi_loc_id ||' ALREADY EXISTS');
    else    
    INSERT INTO location (LOC_ID,LOC_NAME) values (pi_loc_id, pi_loc_name);
    dbms_output.put_line('RECORD '|| pi_loc_id || ' INSERTED SUCCESSFULLY');
    end if;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('OH DEAR. I THINK IT IS TIME TO PANIC!');
    WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM); 
        
END ADD_LOCATION;
/

set serveroutput on;
BEGIN
add_location(1,'Charles River');
add_location(2,'Quabbin Lake');
add_location(3,'LLMC Fish Pier');
END;    

select * from location;

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