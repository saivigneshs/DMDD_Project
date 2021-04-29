---- Total Catches by Each Fisherman
CREATE or replace VIEW vw_catch_qty
AS
SELECT A.FIRST_NAME||' '||A.lAST_NAME AS FISHERMAN_NAME,sum(d.catch_qty) as Total_Catches
FROM fisherman A
INNER JOIN bookings B ON A.FM_ID=B.FM_ID
INNER JOIN checkin_log C ON b.booking_id=c.booking_id
INNER JOIN checkout_log D ON d.checkin_id=c.checkin_id
group by a.fm_id,a.first_name, a.last_name, b.booking_id, c.checkin_id
order by a.fm_id;

select * from vw_catch_qty;

----- Total Catches by Location
CREATE or replace VIEW vw_CatchBYLocation
AS
(SELECT f.loc_name,sum(a.catch_qty)as Total_Catches
FROM checkout_log A
INNER JOIN checkin_log B ON a.checkin_id=b.checkin_id
INNER JOIN bookings C ON b.booking_id=c.booking_id
INNER JOIN slots D ON c.slot_id=d.slot_id
INNER JOIN sub_location E ON d.subloc_id=e.subloc_id
INNER JOIN location F ON e.loc_id=f.loc_id
group by f.loc_name);

SELECT
    *
FROM vw_CatchBYLocation;

--- Last feed date by Each Fish Species
CREATE or REPLACE VIEW vw_lastfeeddatebyspeciesname
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
FROM vw_lastfeeddatebyspeciesname;



------ Most Caught Fish
CREATE OR REPLACE VIEW vw_mostcaught_fish
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
FROM vw_mostcaught_fish;

----------- Busiest to Dullest Day

CREATE OR REPLACE VIEW vw_BusyToDull
AS

SELECT  count(*) as Total_booking, b.day_of_week
FROM bookings A INNER JOIN slots B ON a.slot_id = b.slot_id
GROUP BY b.day_of_week
ORDER BY Total_booking desc
;

SELECT
    *
FROM vw_BusyToDull;