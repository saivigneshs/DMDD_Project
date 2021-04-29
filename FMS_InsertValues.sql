set serveroutput on;
CREATE OR REPLACE PACKAGE INSERT
    AS
        PROCEDURE INSERT.add_location(pi_loc_id NUMBER, pi_loc_name VARCHAR2);
        PROCEDURE INSERT.add_fisherman(pi_fm_id NUMBER, pi_fname VARCHAR2 , pi_lname VARCHAR2, pi_age NUMBER, pi_gender VARCHAR2, pi_exp NUMBER, pi_mob VARCHAR2, pi_email VARCHAR2);
        PROCEDURE INSERT.add_fisherman_DETAILS(pi_fm_id NUMBER, pi_addr1 VARCHAR2 , pi_addr2 VARCHAR2, pi_city VARCHAR2, pi_state VARCHAR2, pi_zip VARCHAR2);
        PROCEDURE INSERT.add_fish_species(pi_FISH_ID NUMBER, pi_SPECIES_NAME VARCHAR2, pi_AVG_LENGTH FLOAT, pi_AVG_WEIGHTD FLOAT );
        PROCEDURE INSERT.add_bookings(pi_BOOKING_ID NUMBER, pi_FM_ID NUMBER, pi_SLOT_ID NUMBER, pi_BOOKING_TIME TIMESTAMP, pi_BOOK_STATUS VARCHAR2);
        PROCEDURE INSERT.add_slots(pi_SLOT_ID NUMBER, pi_DAY_OF_WEEK VARCHAR2, pi_SLOT_TIME TIMESTAMP, pi_SLOT_COUNT NUMBER, pi_SUBLOC_ID NUMBER);
        PROCEDURE INSERT.add_sub_location(pi_SUBLOC_ID NUMBER, pi_SUBLOC_NAME VARCHAR2, pi_LOC_ID NUMBER);
        PROCEDURE INSERT.add_location_STATS(pi_loc_id NUMBER, pi_cur_date DATE, pi_is_insect_seined VARCHAR2, pi_water_temp NUMBER, pi_last_decon_time TIMESTAMP, pi_o2_conc_level NUMBER, pi_nh4_conc_level NUMBER, pi_last_feed_date TIMESTAMP);
        PROCEDURE INSERT.add_fish_stats(pi_fish_inv_id NUMBER, pi_fish_id NUMBER, pi_tot_fish_qty NUMBER, pi_cur_date DATE, pi_subLoc_id NUMBER);
        PROCEDURE INSERT.add_checkin_log(pi_booking_id NUMBER, pi_checkin_id NUMBER, pi_entry_time TIMESTAMP, pi_covid_result VARCHAR2, pi_ppe_available VARCHAR2, pi_fm_id NUMBER);
        PROCEDURE INSERT.add_checkout_log(pi_checkin_id NUMBER, pi_fish_inv_id NUMBER, pi_catch_qty NUMBER, pi_checkout_time TIMESTAMP);
        
    END INSERT;
/

CREATE OR REPLACE PACKAGE BODY INSERT
AS
    PROCEDURE INSERT.add_location(pi_loc_id NUMBER, pi_loc_name VARCHAR2)
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
        
    END INSERT.add_location;


    PROCEDURE INSERT.add_fisherman(pi_fm_id NUMBER, pi_fname VARCHAR2 , pi_lname VARCHAR2, pi_age NUMBER, pi_gender VARCHAR2, pi_exp NUMBER, pi_mob VARCHAR2, pi_email VARCHAR2)
    AS
    ROW_CT NUMBER;
    BEGIN  
    select count(*) into ROW_CT from FISHERMAN where fm_id = pi_fm_id and mobile_no = pi_mob;
    if(ROW_CT>0) then
        dbms_output.put_line('RECORD '|| pi_fm_id ||' ALREADY EXISTS');
    else    
    INSERT INTO FISHERMAN (FM_ID,FIRST_NAME,LAST_NAME,AGE,GENDER,EXPERIENCE,MOBILE_NO,EMAIL) values (pi_fm_id, pi_fname, pi_lname, pi_age, pi_gender, pi_exp, pi_mob, pi_email);
    dbms_output.put_line('RECORD '|| pi_fm_id || ' INSERTED SUCCESSFULLY');
    end if;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('A Different value already exists with this ID.');
    WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM); 
        
    END INSERT.add_fisherman;

    PROCEDURE INSERT.add_fisherman_DETAILS(pi_fm_id NUMBER, pi_addr1 VARCHAR2 , pi_addr2 VARCHAR2, pi_city VARCHAR2, pi_state VARCHAR2, pi_zip VARCHAR2)
    AS
    ROW_CT NUMBER;
    BEGIN  
    select count(*) into ROW_CT from FISHERMAN_DETAILS where fm_id = pi_fm_id and zipcode = pi_zip;
    if(ROW_CT>0) then
        dbms_output.put_line('RECORD '|| pi_fm_id ||' ALREADY EXISTS');
    else    
    INSERT INTO FISHERMAN_DETAILS (FM_ID,ADDRESS_1,ADDRESS_2,CITY,STATE,ZIPCODE) values (pi_fm_id, pi_addr1, pi_addr2, pi_city, pi_state, pi_zip);
    dbms_output.put_line('RECORD '|| pi_fm_id || ' INSERTED SUCCESSFULLY');
    end if;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('A Different value already exists with this ID.');
    WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);       
    END INSERT.add_fisherman_DETAILS;


    PROCEDURE INSERT.add_fish_species(pi_FISH_ID NUMBER, pi_SPECIES_NAME VARCHAR2, pi_AVG_LENGTH FLOAT, pi_AVG_WEIGHTD FLOAT )
    AS
    ROW_CT NUMBER;
    BEGIN  
    select count(*) into ROW_CT from FISH_SPECIES where FISH_ID = pi_FISH_ID;
    if(ROW_CT>0) then
        dbms_output.put_line('RECORD '|| pi_FISH_ID ||' ALREADY EXISTS');
    else    
    INSERT INTO FISH_SPECIES (FISH_ID,SPECIES_NAME,AVG_LENGTH,ABG_WEIGHTD) values (pi_FISH_ID, pi_SPECIES_NAME,pi_AVG_LENGTH, pi_AVG_WEIGHTD );
    dbms_output.put_line('RECORD '|| pi_FISH_ID || ' INSERTED SUCCESSFULLY'); 
    end if;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('OH DEAR. I THINK IT IS TIME TO PANIC!');
    WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM); 
        
    END INSERT.add_fish_species;


    PROCEDURE INSERT.add_bookings(pi_BOOKING_ID NUMBER, pi_FM_ID NUMBER, pi_SLOT_ID NUMBER, pi_BOOKING_TIME TIMESTAMP, pi_BOOK_STATUS VARCHAR2)
    AS
    ROW_CT NUMBER;
    BEGIN  
    select count(*) into ROW_CT from BOOKINGS where FM_ID = pi_FM_ID;
    if(ROW_CT>0) then
        dbms_output.put_line('RECORD '|| pi_FM_ID ||' ALREADY EXISTS');
    else    
    INSERT INTO BOOKINGS (BOOKING_ID,FM_ID,SLOT_ID,BOOKING_TIME,BOOK_STATUS) values (pi_BOOKING_ID, pi_FM_ID,pi_SLOT_ID, pi_BOOKING_TIME,pi_BOOK_STATUS );
    dbms_output.put_line('RECORD '|| pi_FM_ID || ' INSERTED SUCCESSFULLY'); 
    end if;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('OH DEAR. I THINK IT IS TIME TO PANIC!');
    WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM); 
        
    END INSERT.add_bookings;

    PROCEDURE INSERT.add_slots(pi_SLOT_ID NUMBER, pi_DAY_OF_WEEK VARCHAR2, pi_SLOT_TIME TIMESTAMP, pi_SLOT_COUNT NUMBER, pi_SUBLOC_ID NUMBER)
    AS
    ROW_CT NUMBER;
    BEGIN  
    select count(*) into ROW_CT from slots where SLOT_ID = pi_SLOT_ID;
    if(ROW_CT>0) then
        dbms_output.put_line('RECORD '|| pi_SLOT_ID ||' ALREADY EXISTS');
    else    
    INSERT INTO slots (SLOT_ID,DAY_OF_WEEK,SLOT_TIME,SLOT_COUNT,SUBLOC_ID) values (pi_SLOT_ID, pi_DAY_OF_WEEK,pi_SLOT_TIME, pi_SLOT_COUNT,pi_SUBLOC_ID );
    dbms_output.put_line('RECORD '|| pi_SLOT_ID || ' INSERTED SUCCESSFULLY'); 
    end if;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('OH DEAR. I THINK IT IS TIME TO PANIC!');
    WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM); 
        
    END INSERT.add_slots;

    PROCEDURE INSERT.add_sub_location(pi_SUBLOC_ID NUMBER, pi_SUBLOC_NAME VARCHAR2, pi_LOC_ID NUMBER)
    AS
    ROW_CT NUMBER;
    BEGIN  
    select count(*) into ROW_CT from SUB_LOCATION where SUBLOC_ID = pi_SUBLOC_ID;
    if(ROW_CT>0) then
        dbms_output.put_line('RECORD '|| pi_SUBLOC_ID ||' ALREADY EXISTS');
    else    
    INSERT INTO SUB_LOCATION (SUBLOC_ID,SUBLOC_NAME,LOC_ID) values (pi_SUBLOC_ID, pi_SUBLOC_NAME,pi_LOC_ID);
    dbms_output.put_line('RECORD '|| pi_SUBLOC_ID || ' INSERTED SUCCESSFULLY'); 
    end if;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('OH DEAR. I THINK IT IS TIME TO PANIC!');
    WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM); 
        
    END INSERT.add_sub_location;


    PROCEDURE INSERT.add_location_STATS(pi_loc_id NUMBER, pi_cur_date DATE, pi_is_insect_seined VARCHAR2, pi_water_temp NUMBER, pi_last_decon_time TIMESTAMP, pi_o2_conc_level NUMBER, pi_nh4_conc_level NUMBER, pi_last_feed_date TIMESTAMP)
    AS
    ROW_CT NUMBER;
    BEGIN
    select count(*) into ROW_CT from LOC_STATS where loc_id = pi_loc_id and cur_date = pi_cur_date;
    if(ROW_CT>0) then
        dbms_output.put_line('RECORD '|| pi_loc_id ||' ALREADY EXISTS');
    else   
    INSERT INTO loc_stats (LOC_ID,cur_date,IS_INSECT_SEINED,WATER_TEMP,LAST_DECON_TIME,O2_CONC_LEVEL,NH4_CONC_LEVEL,LAST_FEED_DATE) values (pi_loc_id, pi_cur_date, pi_is_insect_seined , pi_water_temp , pi_last_decon_time , pi_o2_conc_level, pi_nh4_conc_level, pi_last_feed_date);
    dbms_output.put_line('RECORD '|| pi_loc_id || ' INSERTED SUCCESSFULLY');
    end if;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
       
    END INSERT.add_location_STATS;

    PROCEDURE INSERT.add_fish_stats(pi_fish_inv_id NUMBER, pi_fish_id NUMBER, pi_tot_fish_qty NUMBER, pi_cur_date DATE, pi_subLoc_id NUMBER)
    AS
    ROW_CT NUMBER;
    BEGIN  
    select count(*) into ROW_CT from FISH_STATS where fish_inv_id = pi_fish_inv_id;
    if(ROW_CT>0) then
        dbms_output.put_line('RECORD '|| pi_fish_inv_id ||' ALREADY EXISTS');
    else    
    INSERT INTO fish_stats (FISH_INV_ID,FISH_ID,TOT_FISH_QTY,CUR_DATE,SUBLOC_ID) values (pi_fish_inv_id , pi_fish_id , pi_tot_fish_qty , pi_cur_date , pi_subLoc_id);
    dbms_output.put_line('RECORD '|| pi_fish_inv_id || ' INSERTED SUCCESSFULLY');
    end if;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM); 
        
    END INSERT.add_fish_stats;

    PROCEDURE INSERT.add_checkin_log(pi_booking_id NUMBER, pi_checkin_id NUMBER, pi_entry_time TIMESTAMP, pi_covid_result VARCHAR2, pi_ppe_available VARCHAR2, pi_fm_id NUMBER)
    AS
    ROW_CT NUMBER;
    BEGIN  
    select count(*) into ROW_CT from CHECKIN_LOG where booking_id = pi_booking_id and checkin_id = pi_checkin_id;
    if(ROW_CT>0) then
        dbms_output.put_line('RECORD '|| pi_checkin_id ||' ALREADY EXISTS');
    else    
    INSERT INTO checkin_log (BOOKING_ID,CHECKIN_ID,ENTRY_TIME,COVID_RESULT,IS_PPE_AVAILABLE,FM_ID) values (pi_booking_id , pi_checkin_id , pi_entry_time , pi_covid_result , pi_ppe_available, pi_fm_id);
    dbms_output.put_line('RECORD '|| pi_checkin_id || ' INSERTED SUCCESSFULLY');
    end if;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM); 
        
    END INSERT.add_checkin_log;


    PROCEDURE INSERT.add_checkout_log(pi_checkin_id NUMBER, pi_fish_inv_id NUMBER, pi_catch_qty NUMBER, pi_checkout_time TIMESTAMP)
    AS
    ROW_CT NUMBER;
    BEGIN  
    select count(*) into ROW_CT from CHECKOUT_LOG where fish_inv_id = pi_fish_inv_id and checkin_id = pi_checkin_id;
    if(ROW_CT>0) then
        dbms_output.put_line('RECORD '|| pi_checkin_id ||' ALREADY EXISTS');
    else    
    INSERT INTO checkout_log (CHECKIN_ID,FISH_INV_ID,CATCH_QTY,CHECKOUT_TIME) values (pi_checkin_id , pi_fish_inv_id , pi_catch_qty , pi_checkout_time);
    dbms_output.put_line('RECORD '|| pi_checkin_id || ' INSERTED SUCCESSFULLY');
    end if;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM); 
        
    END INSERT.add_checkout_log;
END INSERT;    
/

-------------------------- INSERT VALUES ----------------------------

BEGIN
INSERT.add_fisherman(1,'Jamal','Jordan',39,'M',0,'(876) 905-1186','sit.amet.ornare@seddictum.ca');
INSERT.add_fisherman(2,'Dean','Bradley',46,'M',3,'(774) 350-3917','erat.Vivamus@ac.net');
INSERT.add_fisherman(3,'Stewart','Jennings',22,'M',4,'(311) 842-7249','Phasellus.libero.mauris@aodiosemper.net');
INSERT.add_fisherman(4,'Colton','Harmon',47,'M',10,'(651) 432-4437','urna@mollisnoncursus.co.uk');
INSERT.add_fisherman(5,'Dustin','Gilliam',24,'M',8,'(159) 929-9461','sed.orci.lobortis@dolorelitpellentesque.co.uk');
INSERT.add_fisherman(6,'Blake','Mcmillan',44,'M',10,'(982) 985-1394','enim.diam@hendrerit.edu');
INSERT.add_fisherman(7,'William','Walls',24,'M',6,'(147) 275-1237','tellus.lorem@pede.org');
INSERT.add_fisherman(8,'Jacob','Pennington',26,'M',1,'(518) 682-2587','dictum.eleifend@quis.ca');
INSERT.add_fisherman(9,'Rahim','Giles',48,'M',4,'(950) 467-4678','ultricies.ligula@convallisante.net');
INSERT.add_fisherman(10,'Neil','Barnes',44,'M',1,'(478) 103-8074','sagittis.Nullam.vitae@imperdietullamcorper.net');
INSERT.add_fisherman(11,'Hamish','England',33,'M',1,'(167) 905-0897','lorem@Integervitae.org');
INSERT.add_fisherman(12,'Deacon','Lane',49,'M',10,'(957) 337-8342','et.rutrum@euturpisNulla.org');
INSERT.add_fisherman(13,'Berk','Hood',56,'M',3,'(104) 814-5113','sapien@mauriselit.net');
INSERT.add_fisherman(14,'Colorado','Meadows',29,'M',3,'(267) 809-2575','Maecenas@vehicularisusNulla.ca');
INSERT.add_fisherman(15,'Sebastian','Vincent',23,'M',4,'(337) 521-1958','justo.nec@nequeNullamnisl.com');
INSERT.add_fisherman(16,'Stone','Cannon',51,'M',7,'(299) 543-0417','ligula.tortor.dictum@velit.edu');
INSERT.add_fisherman(17,'Tanner','Alvarado',30,'M',0,'(550) 261-9993','imperdiet.non@Quisquepurus.com');
INSERT.add_fisherman(18,'Jacob','Harrell',31,'M',5,'(339) 542-7587','dictum.mi.ac@orci.org');
INSERT.add_fisherman(19,'Brennan','Carr',28,'M',5,'(978) 770-3559','ante.Nunc.mauris@sem.org');
INSERT.add_fisherman(20,'Owen','Kaufman',47,'M',9,'(899) 814-0914','urna.Ut@anteipsumprimis.net');
INSERT.add_fisherman(21,'Yuli','Irwin',37,'M',8,'(492) 579-0777','Donec@Morbiquisurna.net');
INSERT.add_fisherman(22,'Fritz','Bates',35,'M',3,'(298) 396-3682','pede@rhoncusidmollis.ca');
INSERT.add_fisherman(23,'Anthony','Sanders',59,'M',1,'(957) 889-2240','auctor.quis.tristique@sociis.co.uk');
INSERT.add_fisherman(24,'Jermaine','Shaw',54,'M',6,'(128) 632-8506','aliquet.vel@Lorem.org');
INSERT.add_fisherman(25,'Raja','Klein',36,'M',3,'(461) 888-6999','a.sollicitudin.orci@velit.co.uk');
INSERT.add_fisherman(26,'Damon','Ewing',21,'M',7,'(754) 360-9578','egestas.Sed@vulputatedui.org');
INSERT.add_fisherman(27,'Mason','Noble',57,'M',7,'(419) 404-3738','scelerisque@magnaa.org');
INSERT.add_fisherman(28,'Rigel','Ellison',59,'M',6,'(715) 788-3177','urna.Ut.tincidunt@sagittislobortis.org');
INSERT.add_fisherman(29,'Dexter','Carson',54,'M',0,'(534) 517-0464','tellus@diamatpretium.co.uk');
INSERT.add_fisherman(30,'Micah','Lucas',41,'M',5,'(697) 352-6422','a.malesuada.id@Cumsociis.org');
INSERT.add_fisherman(31,'Donovan','Byers',28,'M',2,'(745) 264-9564','Pellentesque.habitant@Phasellusfermentum.com');
INSERT.add_fisherman(32,'Thaddeus','Kemp',52,'M',9,'(289) 302-9778','Suspendisse@ultricies.ca');
INSERT.add_fisherman(33,'Kevin','Deleon',60,'M',9,'(703) 358-2232','nec.diam@egestasa.edu');
INSERT.add_fisherman(34,'Brian','Hewitt',33,'M',9,'(320) 146-2627','aliquet@idblanditat.edu');
INSERT.add_fisherman(35,'Chancellor','Compton',42,'M',9,'(327) 838-6973','placerat.eget@tellusfaucibusleo.edu');
INSERT.add_fisherman(36,'Basil','Davidson',35,'M',10,'(525) 925-7009','lacinia.Sed.congue@magnaDuisdignissim.net');
INSERT.add_fisherman(37,'Amos','Powell',44,'M',6,'(484) 294-7047','ut.mi@Mauris.org');
INSERT.add_fisherman(38,'Josiah','Kim',45,'M',0,'(163) 286-6101','velit@suscipit.ca');
INSERT.add_fisherman(39,'Ali','Swanson',57,'M',5,'(707) 233-5004','neque.tellus@luctusCurabituregestas.net');
INSERT.add_fisherman(40,'Jelani','Owen',44,'M',4,'(476) 141-0930','Donec.est.mauris@eratvolutpat.co.uk');
INSERT.add_fisherman(41,'Curran','Gonzales',55,'M',4,'(948) 606-1912','Vestibulum@euismod.ca');
INSERT.add_fisherman(42,'Bernard','Holcomb',33,'M',8,'(643) 417-5448','Cum.sociis.natoque@nonegestas.org');
INSERT.add_fisherman(43,'Chester','Ramsey',52,'M',8,'(755) 421-5402','erat.semper@eu.ca');
INSERT.add_fisherman(44,'Beck','Avila',29,'M',8,'(481) 733-2720','Class@enim.edu');
INSERT.add_fisherman(45,'Isaiah','Kane',24,'M',9,'(357) 245-2497','hendrerit.Donec.porttitor@seddictumeleifend.edu');
INSERT.add_fisherman(46,'Forrest','Gill',54,'M',3,'(638) 376-1407','tincidunt.Donec.vitae@temporbibendumDonec.org');
INSERT.add_fisherman(47,'Channing','Mccarthy',33,'M',0,'(185) 982-6800','iaculis@metusIn.net');
INSERT.add_fisherman(48,'Gareth','Weiss',33,'M',5,'(953) 628-8169','per@feugiatplaceratvelit.org');
INSERT.add_fisherman(49,'Alec','Martinez',33,'M',9,'(164) 845-1929','et@eutellus.net');
INSERT.add_fisherman(50,'Carlos','Cross',51,'M',4,'(686) 892-8236','lorem.luctus.ut@mattissemper.org');
INSERT.add_fisherman(51,'Preston','Puckett',38,'M',8,'(121) 510-6742','luctus.ipsum@amet.edu');
INSERT.add_fisherman(52,'Todd','Mercer',36,'M',7,'(417) 182-3434','dictum@aliquetsemut.org');
INSERT.add_fisherman(53,'Jin','Nolan',35,'M',8,'(968) 342-5144','magna.Duis@Aliquam.ca');
INSERT.add_fisherman(54,'Mannix','Mullen',33,'M',5,'(989) 458-0887','ac@diamSed.net');
INSERT.add_fisherman(55,'Orson','Anderson',56,'M',6,'(104) 923-9246','diam@rutrumurnanec.co.uk');
INSERT.add_fisherman(56,'Travis','Small',37,'M',10,'(111) 313-7503','egestas.blandit@augueporttitor.co.uk');
INSERT.add_fisherman(57,'Gareth','Wyatt',33,'M',5,'(660) 665-2500','molestie.sodales@velit.net');
INSERT.add_fisherman(58,'Amery','Landry',37,'M',4,'(693) 488-5929','bibendum@Nunc.ca');
INSERT.add_fisherman(59,'Eagan','Patel',53,'M',7,'(281) 213-2396','malesuada.vel@lacusAliquam.ca');
INSERT.add_fisherman(60,'Quinn','Sexton',41,'M',5,'(558) 354-2427','mus.Aenean@egettinciduntdui.co.uk');
INSERT.add_fisherman(61,'Oleg','Boone',57,'M',6,'(681) 898-8972','Aliquam.erat.volutpat@sed.com');
INSERT.add_fisherman(62,'Barrett','Howe',34,'M',8,'(231) 921-2885','ut.quam.vel@imperdietnonvestibulum.co.uk');
INSERT.add_fisherman(63,'Kane','Blankenship',33,'M',1,'(418) 878-1694','ante@arcu.co.uk');
INSERT.add_fisherman(64,'Brendan','Peters',53,'M',3,'(484) 883-7170','ornare@egestas.org');
INSERT.add_fisherman(65,'Elton','Henry',32,'M',9,'(519) 827-5877','cursus.et@eteros.edu');
INSERT.add_fisherman(66,'Cedric','Roy',57,'M',6,'(308) 802-9902','neque@massaIntegervitae.edu');
INSERT.add_fisherman(67,'Jelani','Christensen',52,'M',6,'(472) 577-5230','aliquet@necmauris.net');
INSERT.add_fisherman(68,'Cody','Moses',32,'M',2,'(575) 152-4071','eu.tellus@Nullamscelerisqueneque.org');
INSERT.add_fisherman(69,'Hasad','Mcdaniel',60,'M',4,'(623) 935-9359','Donec@ut.edu');
INSERT.add_fisherman(70,'Carson','Doyle',37,'M',10,'(859) 567-2170','Sed.nunc.est@euismod.co.uk');
INSERT.add_fisherman(71,'Porter','Winters',60,'M',4,'(307) 191-0943','Nulla.tempor@metus.com');
INSERT.add_fisherman(72,'Tobias','Chan',23,'M',9,'(715) 692-8942','nunc.Quisque@urna.com');
INSERT.add_fisherman(73,'Warren','Bass',53,'M',7,'(788) 740-4435','Class.aptent.taciti@enim.com');
INSERT.add_fisherman(74,'Raphael','English',59,'M',0,'(453) 569-3679','nunc.id.enim@erosProinultrices.com');
INSERT.add_fisherman(75,'Chaim','Young',35,'M',8,'(170) 796-0848','turpis.Nulla.aliquet@non.org');
INSERT.add_fisherman(76,'Dylan','Whitley',41,'M',1,'(769) 955-5229','vestibulum.massa.rutrum@Nulla.co.uk');
INSERT.add_fisherman(77,'Brett','Terry',29,'M',8,'(449) 191-8635','libero@aaliquetvel.edu');
INSERT.add_fisherman(78,'Yuli','Atkins',50,'M',10,'(918) 799-3166','pellentesque.a.facilisis@venenatisa.net');
INSERT.add_fisherman(79,'Gray','Pittman',53,'M',6,'(613) 299-2461','diam@tristiquepellentesquetellus.edu');
INSERT.add_fisherman(80,'Ahmed','Simon',45,'M',3,'(926) 616-3101','porttitor.eros@sapien.net');
INSERT.add_fisherman(81,'Declan','Snow',39,'M',4,'(981) 556-0820','sit.amet.nulla@Fusce.net');
INSERT.add_fisherman(82,'Mannix','Hobbs',52,'M',9,'(729) 866-7692','eu@Curabituregestas.com');
INSERT.add_fisherman(83,'Norman','Hicks',25,'M',2,'(412) 352-9273','elit@temporarcu.org');
INSERT.add_fisherman(84,'Gil','Brady',37,'M',2,'(206) 600-4745','iaculis.odio@rutrum.net');
INSERT.add_fisherman(85,'Harper','Mcgowan',21,'M',7,'(449) 606-8127','adipiscing@molestie.edu');
INSERT.add_fisherman(86,'Travis','Wyatt',40,'M',0,'(313) 216-3316','volutpat@magnisdis.com');
INSERT.add_fisherman(87,'Phelan','Morris',28,'M',4,'(449) 208-1310','Praesent.interdum.ligula@sagittisaugue.ca');
INSERT.add_fisherman(88,'Norman','Robertson',46,'M',9,'(783) 572-6915','mi.eleifend.egestas@egestashendrerit.org');
INSERT.add_fisherman(89,'Michael','Burgess',59,'M',4,'(921) 223-0680','penatibus@Donectemporest.com');
INSERT.add_fisherman(90,'Phelan','Spence',22,'M',1,'(566) 545-3632','fermentum.arcu@odio.ca');
INSERT.add_fisherman(91,'Alan','Peck',52,'M',7,'(651) 461-3655','eleifend.nec@Donecatarcu.edu');
INSERT.add_fisherman(92,'Kibo','Burks',21,'M',1,'(314) 918-5144','et@aptenttacitisociosqu.org');
INSERT.add_fisherman(93,'Basil','Pierce',53,'M',4,'(523) 664-3120','congue@laciniamattis.edu');
INSERT.add_fisherman(94,'Raymond','Cochran',49,'M',10,'(535) 978-8753','eget.varius.ultrices@loremlorem.com');
INSERT.add_fisherman(95,'Wang','Levine',28,'M',10,'(144) 242-4836','mi@ornareliberoat.ca');
INSERT.add_fisherman(96,'Timothy','Odom',40,'M',4,'(775) 349-2465','magna.Lorem.ipsum@dignissim.com');
INSERT.add_fisherman(97,'Grady','Harrington',22,'M',1,'(908) 141-5974','nunc@amet.net');
INSERT.add_fisherman(98,'Carter','Sargent',51,'M',8,'(607) 371-8013','metus@gravidamaurisut.com');
INSERT.add_fisherman(99,'Ian','Page',57,'M',1,'(122) 908-8307','eros.Proin@infaucibusorci.net');
INSERT.add_fisherman(100,'Mannix','Jacobson',58,'M',3,'(948) 667-7668','urna.justo@urnaVivamus.org');
INSERT.add_fisherman(101,'Yuri','Montoya',42,'F',8,'(700) 616-2489','lacus@laoreet.co.uk');
INSERT.add_fisherman(102,'Ivy','Mack',59,'F',10,'(646) 392-8214','egestas@penatibuset.ca');
INSERT.add_fisherman(103,'Indira','Hoover',45,'F',1,'(144) 126-2052','ridiculus.mus.Donec@dictum.com');
INSERT.add_fisherman(104,'Mira','Anderson',37,'F',8,'(904) 390-1849','ipsum.primis@habitant.ca');
INSERT.add_fisherman(105,'Chloe','Garrison',42,'F',6,'(781) 112-2383','Aliquam@euarcu.edu');
INSERT.add_fisherman(106,'Jana','Thompson',27,'F',2,'(919) 603-0250','Nunc.pulvinar.arcu@Nullam.edu');
INSERT.add_fisherman(107,'Chiquita','Irwin',41,'F',7,'(568) 360-5202','ac.facilisis@malesuadavel.com');
INSERT.add_fisherman(108,'Ursula','Navarro',49,'F',6,'(723) 846-1027','sociis@magnaPraesent.com');
INSERT.add_fisherman(109,'Chelsea','Norris',31,'F',0,'(725) 164-6132','hendrerit.neque@eunibh.org');
INSERT.add_fisherman(110,'Shannon','Miller',46,'F',6,'(931) 112-8307','ultrices@egetipsumSuspendisse.org');
INSERT.add_fisherman(111,'Alea','Gamble',31,'F',5,'(337) 499-3216','amet.diam.eu@sed.co.uk');
INSERT.add_fisherman(112,'Cathleen','Fuentes',49,'F',5,'(404) 523-1121','eu@aliquet.net');
INSERT.add_fisherman(113,'Ramona','Wood',40,'F',1,'(873) 296-5685','purus@Phasellus.ca');
INSERT.add_fisherman(114,'Reagan','Fischer',25,'F',7,'(831) 958-9881','Phasellus.dolor@etlibero.net');
INSERT.add_fisherman(115,'Yolanda','Stanton',31,'F',9,'(768) 645-5009','id.erat.Etiam@sitametmassa.ca');
INSERT.add_fisherman(116,'Molly','Livingston',22,'F',10,'(140) 465-9891','sed@tincidunttempusrisus.com');
INSERT.add_fisherman(117,'Joan','Melendez',21,'F',8,'(602) 288-3567','ornare.facilisis.eget@Nulla.org');
INSERT.add_fisherman(118,'Kylee','Boyle',22,'F',8,'(326) 889-2256','egestas.rhoncus.Proin@MaurismagnaDuis.edu');
INSERT.add_fisherman(119,'Kirestin','Phelps',25,'F',3,'(654) 639-1674','Proin.nisl.sem@Suspendisse.net');
INSERT.add_fisherman(120,'Adrienne','Malone',55,'F',0,'(876) 678-4987','enim@sedliberoProin.co.uk');
INSERT.add_fisherman(121,'Kirby','Joseph',37,'F',10,'(421) 110-2111','Suspendisse.eleifend@nonummyultricies.edu');
INSERT.add_fisherman(122,'Nina','Lynch',49,'F',9,'(650) 752-1330','Aliquam.ornare@sagittisNullam.co.uk');
INSERT.add_fisherman(123,'Kelsie','Ferguson',29,'F',9,'(796) 176-1785','mi@odio.edu');
INSERT.add_fisherman(124,'Stacy','Richard',52,'F',3,'(364) 110-3332','ut.dolor@sapien.org');
INSERT.add_fisherman(125,'Medge','Daugherty',30,'F',3,'(957) 404-6955','In.at@liberoest.co.uk');
INSERT.add_fisherman(126,'Emily','Avila',26,'F',6,'(925) 867-9646','nibh@nislsem.co.uk');
INSERT.add_fisherman(127,'Laura','Shaffer',39,'F',4,'(448) 376-7788','Aenean.eget.magna@Nam.com');
INSERT.add_fisherman(128,'Gwendolyn','Calhoun',59,'F',3,'(674) 231-7194','sem.Nulla.interdum@ornare.edu');
INSERT.add_fisherman(129,'Jessica','Livingston',60,'F',3,'(729) 284-9273','quis.diam.luctus@neque.ca');
INSERT.add_fisherman(130,'Grace','Rivera',54,'F',7,'(386) 353-8198','quis.massa.Mauris@Nulla.net');
INSERT.add_fisherman(131,'Ainsley','Simpson',32,'F',4,'(864) 962-6476','Suspendisse.aliquet.sem@dignissimpharetra.ca');
INSERT.add_fisherman(132,'Pandora','Valenzuela',55,'F',9,'(188) 999-4576','Pellentesque.habitant.morbi@inconsectetuer.edu');
INSERT.add_fisherman(133,'Hayley','Mcknight',58,'F',0,'(727) 255-7194','urna@aliquetmolestietellus.co.uk');
INSERT.add_fisherman(134,'Maggy','Bell',45,'F',10,'(338) 703-7264','porttitor.eros.nec@Proinnislsem.org');
INSERT.add_fisherman(135,'Michelle','Juarez',42,'F',9,'(679) 871-8737','Sed@sedpede.edu');
INSERT.add_fisherman(136,'Brianna','Patterson',35,'F',6,'(109) 990-4700','Nam@utdolor.com');
INSERT.add_fisherman(137,'Yvonne','Holland',60,'F',10,'(884) 382-0173','primis.in.faucibus@nostra.com');
INSERT.add_fisherman(138,'Jaime','Sparks',59,'F',6,'(527) 478-6822','ridiculus.mus@luctusut.net');
INSERT.add_fisherman(139,'Lunea','Small',29,'F',5,'(126) 921-0682','sagittis.felis.Donec@lobortisClass.ca');
INSERT.add_fisherman(140,'Ora','Stout',48,'F',1,'(157) 497-4270','Nam.interdum.enim@litoratorquentper.co.uk');
INSERT.add_fisherman(141,'Maisie','Trevino',24,'F',4,'(938) 833-7022','velit@perconubianostra.org');
INSERT.add_fisherman(142,'Judith','Keller',31,'F',3,'(729) 229-3378','In.condimentum@risus.co.uk');
INSERT.add_fisherman(143,'Xantha','Bentley',23,'F',9,'(888) 961-9083','dolor.nonummy@elementum.org');
INSERT.add_fisherman(144,'Ina','Bullock',34,'F',10,'(545) 877-3604','sit.amet@condimentum.co.uk');
INSERT.add_fisherman(145,'Ella','Peck',29,'F',3,'(545) 195-5054','consequat@sit.edu');
INSERT.add_fisherman(146,'Grace','Craft',46,'F',6,'(393) 166-4599','dui.Fusce@litoratorquentper.ca');
INSERT.add_fisherman(147,'Nina','Smith',48,'F',5,'(798) 986-7674','egestas@nibhAliquamornare.net');
INSERT.add_fisherman(148,'Carissa','Delgado',52,'F',2,'(497) 160-1669','pede.blandit.congue@ornare.edu');
INSERT.add_fisherman(149,'Willa','Clark',29,'F',7,'(347) 966-4106','Nunc.mauris.elit@sed.co.uk');
INSERT.add_fisherman(150,'Brenna','Dyer',52,'F',0,'(693) 158-0749','adipiscing.enim.mi@mi.co.uk');
INSERT.add_fisherman(151,'Nita','Cook',21,'F',5,'(986) 720-0765','rutrum.magna@dapibusrutrum.edu');
INSERT.add_fisherman(152,'Rowan','Walsh',26,'F',9,'(664) 780-2617','Fusce.fermentum@Duis.com');
INSERT.add_fisherman(153,'Rina','Atkinson',53,'F',9,'(391) 597-3659','enim@sociisnatoquepenatibus.com');
INSERT.add_fisherman(154,'Melodie','Warner',27,'F',4,'(420) 762-5427','Fusce.diam@aliquetsem.co.uk');
INSERT.add_fisherman(155,'Isadora','Guthrie',22,'F',1,'(404) 134-6993','Mauris.quis@ipsumportaelit.ca');
INSERT.add_fisherman(156,'Charissa','May',31,'F',1,'(199) 428-5239','Phasellus.dapibus.quam@tincidunt.ca');
INSERT.add_fisherman(157,'May','Gray',55,'F',1,'(244) 181-6897','convallis.erat.eget@lacinia.org');
INSERT.add_fisherman(158,'Remedios','Massey',42,'F',3,'(897) 598-6643','elit.erat.vitae@leoVivamusnibh.net');
INSERT.add_fisherman(159,'Zelenia','Hartman',54,'F',4,'(827) 876-4017','augue@afacilisis.com');
INSERT.add_fisherman(160,'Xaviera','Oneal',35,'F',9,'(485) 987-2385','mattis@lectusNullam.ca');
INSERT.add_fisherman(161,'Mara','Wooten',54,'F',10,'(211) 227-6989','Maecenas.malesuada@magna.net');
INSERT.add_fisherman(162,'Flavia','Kerr',22,'F',2,'(485) 972-7115','dictum@cursus.org');
INSERT.add_fisherman(163,'Ivy','George',47,'F',6,'(927) 355-6602','turpis.non.enim@mollislectus.com');
INSERT.add_fisherman(164,'Quintessa','Molina',44,'F',7,'(134) 482-2584','vel@quispede.edu');
INSERT.add_fisherman(165,'Denise','Hammond',39,'F',8,'(664) 436-7360','Cras.lorem.lorem@scelerisque.ca');
INSERT.add_fisherman(166,'Rhonda','Bush',30,'F',9,'(910) 621-2963','Ut@lacus.com');
INSERT.add_fisherman(167,'Pearl','Barnes',48,'F',0,'(764) 174-2296','faucibus.orci@etrutrumeu.org');
INSERT.add_fisherman(168,'Azalia','Todd',53,'F',6,'(978) 388-8444','ornare@sodalesnisi.net');
INSERT.add_fisherman(169,'Alexa','Mcpherson',49,'F',6,'(190) 507-0077','dui.nec.tempus@a.com');
INSERT.add_fisherman(170,'Audra','Strickland',46,'F',5,'(772) 168-0213','montes.nascetur.ridiculus@faucibus.net');
INSERT.add_fisherman(171,'Veda','Petty',22,'F',6,'(408) 661-3742','lorem@lobortisrisusIn.ca');
INSERT.add_fisherman(172,'Blythe','Collier',42,'F',3,'(489) 548-7831','lorem.ac.risus@risusMorbimetus.net');
INSERT.add_fisherman(173,'Dacey','Thomas',36,'F',6,'(366) 676-5176','a.malesuada@fermentum.ca');
INSERT.add_fisherman(174,'Tatyana','Moore',51,'F',1,'(344) 780-8014','a@sed.net');
INSERT.add_fisherman(175,'Kelsie','Harper',28,'F',10,'(315) 208-5000','quis.turpis@sit.edu');
INSERT.add_fisherman(176,'Hanae','Wright',51,'F',9,'(868) 267-5732','Nullam.nisl@mipedenonummy.org');
INSERT.add_fisherman(177,'Kellie','Kim',52,'F',8,'(222) 201-1056','interdum.feugiat@dapibus.com');
INSERT.add_fisherman(178,'Summer','Reynolds',45,'F',5,'(267) 611-9853','sagittis.Duis.gravida@nonummy.com');
INSERT.add_fisherman(179,'Ginger','Klein',52,'F',8,'(157) 155-5508','lectus@mollis.org');
INSERT.add_fisherman(180,'Tara','Harrison',55,'F',5,'(101) 547-7960','eget.tincidunt.dui@tellusSuspendissesed.com');
INSERT.add_fisherman(181,'Miriam','Reilly',34,'F',3,'(173) 862-9533','neque@tempusrisusDonec.com');
INSERT.add_fisherman(182,'Yolanda','Wooten',54,'F',2,'(830) 122-1115','lectus.justo@malesuada.edu');
INSERT.add_fisherman(183,'Hannah','Owens',32,'F',7,'(943) 601-3107','senectus.et.netus@euenimEtiam.net');
INSERT.add_fisherman(184,'Summer','Chan',60,'F',8,'(137) 926-8321','dis@Donecdignissim.org');
INSERT.add_fisherman(185,'Indigo','Acosta',41,'F',5,'(169) 215-2402','arcu.Vivamus.sit@Sed.com');
INSERT.add_fisherman(186,'Jael','Good',54,'F',3,'(392) 599-3840','accumsan.sed@temporestac.org');
INSERT.add_fisherman(187,'Cynthia','Hurst',51,'F',6,'(595) 334-2504','egestas.Aliquam@magna.ca');
INSERT.add_fisherman(188,'Irma','Haney',46,'F',2,'(250) 209-9900','fringilla.euismod.enim@ipsum.edu');
INSERT.add_fisherman(189,'Macy','Rowe',31,'F',1,'(935) 313-2206','eu@metusIn.com');
INSERT.add_fisherman(190,'Minerva','Holland',25,'F',3,'(628) 181-2190','per@ut.org');
INSERT.add_fisherman(191,'Athena','Dillon',43,'F',5,'(271) 612-4844','eu@anuncIn.com');
INSERT.add_fisherman(192,'Abra','Ryan',58,'F',7,'(834) 282-5298','ultricies@ascelerisque.net');
INSERT.add_fisherman(193,'Aphrodite','Morrison',55,'F',7,'(699) 132-3488','egestas.rhoncus.Proin@Seddiam.net');
INSERT.add_fisherman(194,'Kameko','Robbins',59,'F',8,'(208) 636-2813','ac@placeratorci.ca');
INSERT.add_fisherman(195,'Rhonda','Mejia',56,'F',4,'(406) 314-9019','et@at.edu');
INSERT.add_fisherman(196,'Danielle','Burke',58,'F',10,'(732) 365-2134','erat@gravidaAliquamtincidunt.edu');
INSERT.add_fisherman(197,'Lacey','Conrad',46,'F',10,'(570) 146-4206','porttitor.eros.nec@vitae.ca');
INSERT.add_fisherman(198,'Ainsley','Wallace',28,'F',5,'(354) 371-9649','tristique.ac@tempor.co.uk');
INSERT.add_fisherman(199,'Ursa','Sharpe',58,'F',9,'(509) 180-4669','at@ipsumac.com');
INSERT.add_fisherman(200,'Kirby','Ochoa',25,'F',5,'(414) 307-7404','est.mollis@mi.co.uk');
END;

BEGIN
INSERT.add_location(1,'Charles River');
INSERT.add_location(2,'Quabbin Lake');
INSERT.add_location(3,'LLMC Fish Pier');
END;    

BEGIN
INSERT.add_fisherman_details(1,'P.O. Box 205, 7251 Ut Av.','P.O. Box 629, 3397 Ut Rd.','Tucson','Arizona','4893');
INSERT.add_fisherman_details(2,'P.O. Box 273, 5302 Tincidunt Ave','P.O. Box 977, 1410 Lectus Rd.','Bellary','Karnataka','10748');
INSERT.add_fisherman_details(3,'239 Adipiscing St.','Ap #910-3187 Semper Rd.','Las Palmas','CN','12284');
INSERT.add_fisherman_details(4,'Ap #762-7967 Sem Avenue','Ap #289-5902 Mauris Road','Malambo','ATL','19900-657');
INSERT.add_fisherman_details(5,'P.O. Box 141, 9409 Metus. Av.','6420 Quis St.','Tranent','EL','56543');
INSERT.add_fisherman_details(6,'688-9213 Accumsan Rd.','141-6067 Aliquam Rd.','Palma de Mallorca','BA','008094');
INSERT.add_fisherman_details(7,'Ap #295-3515 Odio Ave','7795 Quisque Street','Pasuruan','East Java','85224-461');
INSERT.add_fisherman_details(8,'P.O. Box 128, 2477 Risus. Street','P.O. Box 531, 4897 Tristique St.','Calle Blancos','SJ','Z7 1BJ');
INSERT.add_fisherman_details(9,'P.O. Box 328, 6680 Ultricies Street','4666 Sed St.','Rea','Lombardia','36403-001');
INSERT.add_fisherman_details(10,'Ap #433-1305 Tempus, St.','Ap #505-994 In Rd.','Carson City','Nevada','70400');
INSERT.add_fisherman_details(11,'568-5400 Sed Ave','497-5903 Tellus Av.','Bremerhaven','HB','60443');
INSERT.add_fisherman_details(12,'P.O. Box 538, 4845 Senectus Road','6875 Orci. Rd.','Saint-L?onard','Quebec','VV23 2RJ');
INSERT.add_fisherman_details(13,'Ap #220-4655 Est Street','Ap #294-1868 Quis Rd.','Galway','C','Z1195');
INSERT.add_fisherman_details(14,'497-8046 Dolor Road','P.O. Box 140, 5144 Sed Rd.','Berlin','BE','7811');
INSERT.add_fisherman_details(15,'Ap #340-8734 Dolor, Av.','Ap #677-9590 Risus. Rd.','Yaroslavl','Yaroslavl Oblast','89043');
INSERT.add_fisherman_details(16,'Ap #179-2673 Montes, Road','467-2162 Sit Street','Vienna','Vienna','4288');
INSERT.add_fisherman_details(17,'P.O. Box 640, 5554 Turpis Ave','122-8075 Cursus St.','Bayswater','Western Australia','519824');
INSERT.add_fisherman_details(18,'9311 Et Ave','4087 Est Ave','Huesca','AR','641519');
INSERT.add_fisherman_details(19,'Ap #919-3616 Hendrerit Ave','P.O. Box 400, 9156 Placerat Av.','Orvault','Pays de la Loire','4692');
INSERT.add_fisherman_details(20,'P.O. Box 406, 2450 Aliquet Road','695-9173 Mattis. Street','Piura','Piura','931332');
INSERT.add_fisherman_details(21,'P.O. Box 495, 8183 Nec Avenue','719-4397 Euismod Ave','Mulhouse','AL','45951');
INSERT.add_fisherman_details(22,'Ap #740-1065 Arcu Rd.','P.O. Box 551, 3094 Imperdiet, Road','North Las Vegas','Nevada','15743-309');
INSERT.add_fisherman_details(23,'3256 A Road','Ap #815-9463 Eu Rd.','Berlin','Berlin','55524');
INSERT.add_fisherman_details(24,'2787 Phasellus Road','1663 Libero. Street','Chelsea','QC','10708');
INSERT.add_fisherman_details(25,'Ap #696-9235 Porttitor Ave','P.O. Box 203, 1348 Suscipit St.','Khanewal','Sindh','5688');
INSERT.add_fisherman_details(26,'Ap #562-5693 Congue Av.','P.O. Box 122, 9715 Ipsum. Street','Dublin','Leinster','31110');
INSERT.add_fisherman_details(27,'609-5061 In Street','584-9850 Augue Street','Barbania','Piemonte','60603');
INSERT.add_fisherman_details(28,'789-6840 Sem Road','Ap #952-2209 Porttitor Rd.','Bida','NI','11211');
INSERT.add_fisherman_details(29,'Ap #225-3938 Fermentum Avenue','3981 Nunc, Street','Savannah','GA','86973');
INSERT.add_fisherman_details(30,'Ap #963-3388 Proin St.','9218 Ac, Rd.','Magangu�','Bol�var','4009');
INSERT.add_fisherman_details(31,'P.O. Box 373, 4572 Dis St.','596-6431 Inceptos Rd.','Milwaukee','Wisconsin','33055-579');
INSERT.add_fisherman_details(32,'Ap #236-1760 Justo Av.','Ap #277-2795 Massa. Rd.','Galway','C','3739');
INSERT.add_fisherman_details(33,'P.O. Box 759, 8648 Lectus St.','1829 Phasellus Avenue','Beauvais','PI','21916');
INSERT.add_fisherman_details(34,'Ap #692-9160 Varius St.','Ap #141-9999 Lorem Rd.','Le�n','Gto','05599');
INSERT.add_fisherman_details(35,'Ap #896-9047 Diam Street','P.O. Box 543, 7493 Mauris Rd.','Columbia','MO','5372');
INSERT.add_fisherman_details(36,'Ap #364-1316 Duis St.','P.O. Box 228, 3469 Luctus St.','Huancayo','JUN','73656-06238');
INSERT.add_fisherman_details(37,'6287 Accumsan St.','4305 Sed Ave','Stamford','CT','Z8133');
INSERT.add_fisherman_details(38,'P.O. Box 989, 6662 Vel, Av.','P.O. Box 364, 5948 Fusce St.','Glenrothes','Fife','L1P 7J5');
INSERT.add_fisherman_details(39,'3042 Lacus. Road','208-435 Tellus Ave','Vladimir','VLA','6916');
INSERT.add_fisherman_details(40,'P.O. Box 985, 2485 Ultrices Avenue','Ap #356-9094 Sem St.','Berlin','BE','54-159');
INSERT.add_fisherman_details(41,'1811 Ut Av.','1142 Rutrum, St.','Milwaukee','Wisconsin','45656-57931');
INSERT.add_fisherman_details(42,'Ap #570-8280 Eu Rd.','858 Suscipit, Street','Bremerhaven','HB','878151');
INSERT.add_fisherman_details(43,'P.O. Box 877, 8612 A, Av.','Ap #144-4567 Praesent Avenue','Carmen','Cartago','6195 FT');
INSERT.add_fisherman_details(44,'940-4457 Cras Street','Ap #557-7910 Eros Avenue','Grand Island','NE','839492');
INSERT.add_fisherman_details(45,'672-5600 Risus. Av.','P.O. Box 158, 6585 Tristique Rd.','Berlin','BE','6387');
INSERT.add_fisherman_details(46,'P.O. Box 738, 7239 Non Ave','389-1255 Cum Av.','Yurimaguas','Loreto','94513-682');
INSERT.add_fisherman_details(47,'960-8498 Quam Rd.','Ap #646-9152 A Avenue','Montb�liard','FC','6706 MQ');
INSERT.add_fisherman_details(48,'Ap #742-6695 Aenean Rd.','P.O. Box 426, 5615 Ligula Rd.','Barranca','Puntarenas','10258');
INSERT.add_fisherman_details(49,'367-9546 Justo. Avenue','P.O. Box 400, 2389 Maecenas St.','Pyeongtaek','Gye','E03 0YY');
INSERT.add_fisherman_details(50,'Ap #797-110 Rutrum, St.','P.O. Box 104, 7172 Ligula Rd.','Waiuku','NI','94618');
INSERT.add_fisherman_details(51,'Ap #354-6105 Eu Road','Ap #928-7426 Condimentum. Rd.','Owerri','Imo','64990');
INSERT.add_fisherman_details(52,'P.O. Box 391, 7394 Egestas Street','P.O. Box 389, 8876 Nisi Avenue','Tokoroa','NI','21309');
INSERT.add_fisherman_details(53,'541-9495 Tristique St.','Ap #667-7196 Aliquam Av.','Las Condes','RM','760316');
INSERT.add_fisherman_details(54,'Ap #145-4313 Donec Rd.','P.O. Box 967, 4159 Nisi. Rd.','Belfast','Ulster','00182-007');
INSERT.add_fisherman_details(55,'P.O. Box 578, 7557 Justo Street','598-7433 Vitae Ave','Veere','Zeeland','19210-775');
INSERT.add_fisherman_details(56,'Ap #547-4924 Mi Ave','6431 Tortor St.','Eigenbrakel','WB','1073');
INSERT.add_fisherman_details(57,'1589 Sodales. Av.','Ap #280-6195 Diam Rd.','Itag��','Antioquia','Z4556');
INSERT.add_fisherman_details(58,'6095 Etiam St.','4811 Mauris Rd.','Trevignano Romano','LAZ','0757 GF');
INSERT.add_fisherman_details(59,'P.O. Box 950, 6856 Cras Street','3894 Mollis Rd.','Sparwood','BC','98944');
INSERT.add_fisherman_details(60,'788-8274 Amet Rd.','868-3613 Gravida Avenue','Vienna','Wie','10383');
INSERT.add_fisherman_details(61,'6113 Accumsan Avenue','P.O. Box 245, 7498 Enim. Avenue','Berlin','Berlin','67931');
INSERT.add_fisherman_details(62,'Ap #985-4439 Semper Av.','3587 Sapien Ave','Zierikzee','Zl','5278 QJ');
INSERT.add_fisherman_details(63,'413-3782 Nec, Road','P.O. Box 449, 6879 Dolor, Av.','Graneros','VI','61740');
INSERT.add_fisherman_details(64,'1579 Nec, St.','569-5275 Diam St.','Tczew','Pomorskie','28913');
INSERT.add_fisherman_details(65,'P.O. Box 844, 5767 Nulla. Ave','P.O. Box 516, 9658 Egestas. Av.','San Carlos','Biob�o','04215');
INSERT.add_fisherman_details(66,'1238 Semper Road','776-580 Convallis Road','Pointe-au-Pic','QC','0272');
INSERT.add_fisherman_details(67,'P.O. Box 674, 3616 Aenean Av.','465-5551 Magnis Rd.','Chiclayo','LAM','A9V 0N8');
INSERT.add_fisherman_details(68,'P.O. Box 870, 9676 In Av.','3457 Iaculis St.','Detroit','MI','79958');
INSERT.add_fisherman_details(69,'Ap #127-1633 Felis Street','Ap #918-3610 Ac St.','Tiltil','Metropolitana de Santiago','618014');
INSERT.add_fisherman_details(70,'P.O. Box 882, 5186 Eu Rd.','815-230 Ultrices St.','Voronezh','Voronezh Oblast','10705');
INSERT.add_fisherman_details(71,'Ap #629-8185 Nec Rd.','P.O. Box 137, 5594 Suspendisse Street','Bolln�s','G�vleborgs l�n','17581');
INSERT.add_fisherman_details(72,'8344 Nisl St.','913-8236 Pellentesque St.','Calle Blancos','San Jos�','7503');
INSERT.add_fisherman_details(73,'4293 Maecenas Rd.','984-9034 Aliquam Av.','Gwadar','Balochistan','8773');
INSERT.add_fisherman_details(74,'P.O. Box 346, 8751 Nascetur Rd.','Ap #349-4087 Urna Av.','Vlissegem','West-Vlaanderen','7606');
INSERT.add_fisherman_details(75,'4580 Sed Street','8613 Eu Road','Ip�s','SJ','52988-98120');
INSERT.add_fisherman_details(76,'Ap #589-1125 Dictum Rd.','449-5049 Ut Avenue','Galway','Connacht','67-468');
INSERT.add_fisherman_details(77,'638-9273 Suspendisse Ave','Ap #430-1816 Posuere Rd.','Oaxaca','Oax','810124');
INSERT.add_fisherman_details(78,'339-9030 Vitae St.','Ap #188-1626 Lorem, Ave','Santander','CA','9560');
INSERT.add_fisherman_details(79,'Ap #141-6021 Litora Avenue','Ap #105-5035 Consequat Rd.','Cartagena','BOL','232619');
INSERT.add_fisherman_details(80,'444-1993 Eu, Street','Ap #960-7759 Natoque Road','Cork','M','5474');
INSERT.add_fisherman_details(81,'535-7048 Orci Street','Ap #906-3184 Arcu. Street','Chitral','Khyber Pakhtoonkhwa','16940');
INSERT.add_fisherman_details(82,'Ap #445-9114 Eu, Ave','580-1284 Nec Avenue','San Pietro al Tanagro','CAM','01831');
INSERT.add_fisherman_details(83,'P.O. Box 844, 9088 Ac Rd.','401-8195 Volutpat Road','Minna','NI','8346');
INSERT.add_fisherman_details(84,'P.O. Box 811, 1480 Nunc Avenue','P.O. Box 114, 5220 Tellus Av.','�demi?','?zm','12765-69343');
INSERT.add_fisherman_details(85,'325-5969 Ut Avenue','1268 Lorem St.','Jundia�','SP','19427');
INSERT.add_fisherman_details(86,'5388 Nibh Rd.','2125 Fermentum St.','Bhopal','MP','24348');
INSERT.add_fisherman_details(87,'Ap #849-7297 Auctor St.','Ap #983-4672 Fermentum St.','Karacabey','Bur','Z7411');
INSERT.add_fisherman_details(88,'918-4720 Eu Av.','9910 Turpis. Ave','Melton','VIC','08937');
INSERT.add_fisherman_details(89,'P.O. Box 411, 9478 Fermentum St.','359-553 Ut, St.','Voronezh','Voronezh Oblast','548836');
INSERT.add_fisherman_details(90,'593-7644 A Rd.','892-7391 Eget Ave','Dokkum','Friesland','WU62 7VY');
INSERT.add_fisherman_details(91,'Ap #252-596 Ultricies Rd.','Ap #897-9653 Nunc Street','Nashville','TN','14636');
INSERT.add_fisherman_details(92,'3862 Vitae, Street','2345 Ut, Rd.','Carcassonne','LA','035093');
INSERT.add_fisherman_details(93,'P.O. Box 891, 7033 Sit Street','7295 Commodo Av.','Little Rock','AK','9187');
INSERT.add_fisherman_details(94,'616-7618 Ac, Ave','Ap #764-671 Tincidunt Rd.','Haveli','Azad Kashmir','23985');
INSERT.add_fisherman_details(95,'P.O. Box 598, 6944 Interdum Ave','P.O. Box 292, 9573 Porttitor St.','Erci?','Van','56368');
INSERT.add_fisherman_details(96,'593-9433 Fusce St.','Ap #700-9759 Nunc St.','Idaho Falls','Idaho','18623');
INSERT.add_fisherman_details(97,'Ap #491-5104 Sapien. Ave','P.O. Box 703, 3243 Aliquam Road','Lauder','Berwickshire','899519');
INSERT.add_fisherman_details(98,'544 Adipiscing Rd.','954-8946 Auctor Street','Berlin','BE','51195');
INSERT.add_fisherman_details(99,'227-9647 Nulla. St.','807-8966 Sed Avenue','Lanark County','Ontario','47273');
INSERT.add_fisherman_details(100,'194-7172 Neque. Rd.','870-9371 Ullamcorper St.','Alness','RO','67883-53949');
INSERT.add_fisherman_details(101,'P.O. Box 230, 4460 Ultrices St.','5815 Arcu Rd.','Terneuzen','Zeeland','88498');
INSERT.add_fisherman_details(102,'4478 Sed Av.','970-2691 Est Ave','Lagos','LA','247531');
INSERT.add_fisherman_details(103,'Ap #213-7326 Nisl Rd.','2696 Mauris, Avenue','Bia?a Podlaska','LU','52963');
INSERT.add_fisherman_details(104,'4739 Donec Av.','P.O. Box 867, 4174 Mauris Ave','Columbus','OH','57646');
INSERT.add_fisherman_details(105,'Ap #967-7250 Elit, St.','Ap #410-7768 Vehicula St.','Cheyenne','Wyoming','50155');
INSERT.add_fisherman_details(106,'Ap #312-1695 Orci, Ave','231-2189 Mauris St.','Apartad�','Antioquia','25605');
INSERT.add_fisherman_details(107,'827-7329 Dis Rd.','1474 Litora Ave','Rixensart','WB','9712');
INSERT.add_fisherman_details(108,'945-5340 Dolor St.','P.O. Box 883, 8547 Nisl. St.','Yeongcheon','Gye','36232');
INSERT.add_fisherman_details(109,'105-3430 Vehicula. Av.','Ap #583-9027 Sem Av.','Barranca','LIM','3247');
INSERT.add_fisherman_details(110,'4739 Non, Rd.','945-5532 Enim. Av.','Katsina','Katsina','S1C 4K5');
INSERT.add_fisherman_details(111,'2809 Ut, Rd.','500-8118 Ut St.','The Hague','Z.','29999');
INSERT.add_fisherman_details(112,'Ap #513-8658 Sem Rd.','185-2895 Aliquam, Rd.','Bida','NI','28845');
INSERT.add_fisherman_details(113,'P.O. Box 199, 2678 Donec Rd.','Ap #155-2369 Tellus, Avenue','Port Moody','BC','995218');
INSERT.add_fisherman_details(114,'527 Per Av.','193-4564 Vehicula Street','Mayerthorpe','Alberta','851484');
INSERT.add_fisherman_details(115,'2638 Amet Road','Ap #216-1745 Lectus Av.','Murray Bridge','South Australia','58888');
INSERT.add_fisherman_details(116,'4170 Ligula. St.','641-1809 Eleifend Road','Sapele','Delta','31735');
INSERT.add_fisherman_details(117,'1924 Eget St.','336-4094 Sem. Av.','Kano','KN','04952');
INSERT.add_fisherman_details(118,'631-8950 Euismod Rd.','999-3626 Ut Road','Dublin','Leinster','951186');
INSERT.add_fisherman_details(119,'8790 Nunc Street','3466 Ipsum. St.','Belfast','U','4891');
INSERT.add_fisherman_details(120,'9762 Fames Rd.','411-5062 Ornare, St.','Upplands V�sby','Stockholms l�n','409729');
INSERT.add_fisherman_details(121,'9115 Orci Road','7256 Morbi Road','Bello','ANT','11510');
INSERT.add_fisherman_details(122,'441-218 Amet, Rd.','Ap #988-2583 Morbi Avenue','Gold Coast','QLD','484536');
INSERT.add_fisherman_details(123,'Ap #184-8213 Justo Avenue','401-2318 Nisi Av.','Nasirabad','Balochistan','61294');
INSERT.add_fisherman_details(124,'8937 Cubilia Av.','7569 Mollis Ave','Monclova','Coahuila','51704');
INSERT.add_fisherman_details(125,'480 Ut Avenue','Ap #284-9007 Metus. St.','Vienna','Wie','67268');
INSERT.add_fisherman_details(126,'Ap #535-7916 Eu Ave','226-6898 Donec St.','Buner','Khyber Pakhtoonkhwa','7791');
INSERT.add_fisherman_details(127,'6482 Sed Ave','471-1124 Gravida. Rd.','Istanbul','Istanbul','29-998');
INSERT.add_fisherman_details(128,'322-3095 Ullamcorper Street','225-4078 Euismod Av.','Saint-Dizier','Champagne-Ardenne','88821');
INSERT.add_fisherman_details(129,'P.O. Box 691, 7044 Ac Rd.','596-3175 Mauris Road','Daejeon','Chu','235508');
INSERT.add_fisherman_details(130,'626 Fusce St.','562-9492 Cursus Avenue','Stalowa Wola','PK','71052');
INSERT.add_fisherman_details(131,'695-5273 Pede Av.','1852 Ligula. Rd.','Tire','?zm','78775');
INSERT.add_fisherman_details(132,'8966 Vel Av.','2443 Laoreet Av.','Edmundston','NB','70263');
INSERT.add_fisherman_details(133,'Ap #247-7667 Sem, Ave','Ap #926-5289 Tellus. St.','Southaven','Mississippi','938031');
INSERT.add_fisherman_details(134,'4805 Congue, Street','7775 Arcu Avenue','Aubagne','Provence-Alpes-C�te d''Azur','294428');
INSERT.add_fisherman_details(135,'820-8309 Ornare, Ave','6339 Nulla St.','Norfolk County','Ontario','9854');
INSERT.add_fisherman_details(136,'757-3338 Eu Ave','Ap #975-2901 Orci. Rd.','Magangu�','BOL','17645');
INSERT.add_fisherman_details(137,'P.O. Box 232, 8706 Eros Rd.','1782 Molestie Rd.','Makassar','South Sulawesi','L1H 8J7');
INSERT.add_fisherman_details(138,'Ap #227-4211 Dis Rd.','P.O. Box 606, 7246 Eget Street','Savannah','GA','60304');
INSERT.add_fisherman_details(139,'Ap #820-1785 Adipiscing Ave','3429 Lorem St.','Cocham�','X','78940');
INSERT.add_fisherman_details(140,'Ap #451-8657 Vulputate Ave','P.O. Box 206, 8073 Lobortis Rd.','Hartford','CT','Z5235');
INSERT.add_fisherman_details(141,'Ap #402-7743 Et Avenue','807-2094 Molestie St.','Vienna','Wie','2424 HX');
INSERT.add_fisherman_details(142,'383-8490 Dolor. Av.','480 Sollicitudin Av.','Hudiksvall','G�vleborgs l�n','7817');
INSERT.add_fisherman_details(143,'4035 Nulla St.','Ap #818-5519 Ac, Rd.','Wroc?aw','Dolno?l?skie','P3R 6E1');
INSERT.add_fisherman_details(144,'887-9028 Cras Road','8636 Placerat, Ave','Pocheon','Gye','10913');
INSERT.add_fisherman_details(145,'Ap #793-2284 Arcu. Road','Ap #916-8919 Vitae Avenue','S�o Jos�','Santa Catarina','343825');
INSERT.add_fisherman_details(146,'8124 Aenean Rd.','1825 Nibh Rd.','Worksop','NT','09043');
INSERT.add_fisherman_details(147,'P.O. Box 322, 7789 Libero. Rd.','3192 Adipiscing Street','Tokoroa','North Island','17815');
INSERT.add_fisherman_details(148,'4232 At Road','Ap #278-4813 Praesent Rd.','Bastia','CO','94212');
INSERT.add_fisherman_details(149,'Ap #185-1627 Penatibus Road','Ap #800-8114 Egestas Avenue','Uyo','AK','976893');
INSERT.add_fisherman_details(150,'521-5409 Egestas. Road','587-9599 Nunc Avenue','San Rafael','Alajuela','80297');
INSERT.add_fisherman_details(151,'761-2629 Tellus. Avenue','6035 Suspendisse St.','Quesada','A','157481');
INSERT.add_fisherman_details(152,'P.O. Box 946, 4625 Eleifend Rd.','302-5145 Nibh. Street','Habra','West Bengal','50450');
INSERT.add_fisherman_details(153,'6210 Duis Ave','897-9942 Quisque Street','Honolulu','HI','10621');
INSERT.add_fisherman_details(154,'P.O. Box 350, 5399 Fringilla Av.','2181 Parturient St.','Termini Imerese','Sicilia','105961');
INSERT.add_fisherman_details(155,'Ap #201-7983 Pellentesque Ave','Ap #982-9683 Morbi Road','Racine','WI','50-378');
INSERT.add_fisherman_details(156,'P.O. Box 478, 1456 Ut, Rd.','361-1649 Augue Avenue','Gavorrano','Toscana','33569');
INSERT.add_fisherman_details(157,'234-458 Cursus. Road','P.O. Box 318, 2985 Nunc Ave','Ranchi','JH','451657');
INSERT.add_fisherman_details(158,'Ap #289-1993 Mauris St.','Ap #841-6395 Ipsum Rd.','Surendranagar','Gujarat','784654');
INSERT.add_fisherman_details(159,'173-1837 Fringilla, Av.','2466 Fringilla. Street','Sokoto','SO','10081');
INSERT.add_fisherman_details(160,'8748 Phasellus Av.','8941 Fusce St.','Warrnambool','VIC','Z5517');
INSERT.add_fisherman_details(161,'5497 Phasellus Ave','Ap #257-2944 Duis Avenue','Maiduguri','Borno','122215');
INSERT.add_fisherman_details(162,'Ap #528-6851 Integer Rd.','448-2224 Erat St.','General Lagos','Arica y Parinacota','202061');
INSERT.add_fisherman_details(163,'P.O. Box 645, 5549 Amet Street','Ap #795-8167 Libero St.','Piagge','MAR','764788');
INSERT.add_fisherman_details(164,'763-2208 Id, St.','863-9983 Laoreet Rd.','Tewkesbury','GL','P0V 4H1');
INSERT.add_fisherman_details(165,'800-1884 Adipiscing, Ave','6173 Ipsum. Ave','Launceston','Tasmania','12706');
INSERT.add_fisherman_details(166,'229-7555 Ut Road','7583 Cras Av.','Itag��','ANT','76862');
INSERT.add_fisherman_details(167,'P.O. Box 606, 5016 Imperdiet Rd.','P.O. Box 925, 8528 Quisque St.','Cinco Esquinas','SJ','55-263');
INSERT.add_fisherman_details(168,'Ap #110-6091 Aliquam Ave','6062 Vel Street','Tillicoultry','Clackmannanshire','99202');
INSERT.add_fisherman_details(169,'136-3289 At Av.','Ap #793-8973 Donec Av.','Irkutsk','IRK','CY95 2CQ');
INSERT.add_fisherman_details(170,'7802 Nunc Av.','452-4170 Imperdiet Ave','Saskatoon','Saskatchewan','3175');
INSERT.add_fisherman_details(171,'Ap #210-4461 Aliquet, St.','Ap #471-1230 Eros St.','Radicofani','Toscana','99583');
INSERT.add_fisherman_details(172,'8859 Accumsan St.','6700 Facilisis Street','General Escobedo','Nuevo Le�n','33205');
INSERT.add_fisherman_details(173,'362-6951 Mauris Rd.','Ap #568-6214 Etiam Rd.','Dutse','JI','0742 QK');
INSERT.add_fisherman_details(174,'Ap #194-1439 Montes, Rd.','Ap #817-3886 Feugiat St.','Wetaskiwin','AB','16-897');
INSERT.add_fisherman_details(175,'P.O. Box 519, 3286 Quis, Ave','488-3196 Fringilla Road','Semarang','Central Java','23184');
INSERT.add_fisherman_details(176,'Ap #758-7107 Eros. Road','P.O. Box 786, 5637 Cum Avenue','Belfast','U','659436');
INSERT.add_fisherman_details(177,'Ap #213-1942 Eu, Rd.','Ap #751-575 Venenatis Rd.','Wageningen','Gl','875692');
INSERT.add_fisherman_details(178,'P.O. Box 584, 3527 Iaculis Avenue','Ap #983-8208 Et Ave','Orangeville','ON','86629');
INSERT.add_fisherman_details(179,'Ap #215-3306 Vehicula Road','964-6614 Ipsum St.','Berlin','BE','946524');
INSERT.add_fisherman_details(180,'559-2051 Vivamus Ave','694-3165 Interdum. St.','Haldia','West Bengal','1072');
INSERT.add_fisherman_details(181,'Ap #121-6966 Felis Av.','P.O. Box 916, 5794 Magna. Street','Kediri','JI','28877');
INSERT.add_fisherman_details(182,'4281 Non Avenue','791-9725 Sed Rd.','Strausberg','Brandenburg','15-630');
INSERT.add_fisherman_details(183,'928-1687 Tellus Rd.','Ap #587-9921 Lobortis. St.','Sokoto','Sokoto','Y1 7HJ');
INSERT.add_fisherman_details(184,'6317 Nulla Ave','5121 Nunc St.','Smithers','British Columbia','1785');
INSERT.add_fisherman_details(185,'258-9568 Cursus Ave','Ap #969-2146 Vestibulum Street','Vienna','Vienna','K5V 4Y2');
INSERT.add_fisherman_details(186,'894-4773 Nulla Avenue','323-9390 Posuere, St.','Berwick-upon-Tweed','NB','12267');
INSERT.add_fisherman_details(187,'P.O. Box 859, 5111 A, St.','Ap #288-3073 Leo Road','Geelong','VIC','J2E 7QX');
INSERT.add_fisherman_details(188,'P.O. Box 152, 7952 Nulla. St.','P.O. Box 498, 7314 Nascetur Avenue','Bihar Sharif','Bihar','753985');
INSERT.add_fisherman_details(189,'Ap #761-8833 Elementum Rd.','3002 Amet St.','Cras-Avernas','Luik','511411');
INSERT.add_fisherman_details(190,'1119 Nulla Av.','P.O. Box 924, 7184 Sed Street','Houston','BC','V9C 3R6');
INSERT.add_fisherman_details(191,'Ap #358-9722 Elit Road','Ap #687-7140 Neque. St.','Provo','Utah','904425');
INSERT.add_fisherman_details(192,'6430 Non Road','1112 Amet, Avenue','Juliaca','PUN','26528');
INSERT.add_fisherman_details(193,'P.O. Box 292, 2781 Sit Road','Ap #962-7719 A, Ave','Paita','PIU','88-240');
INSERT.add_fisherman_details(194,'P.O. Box 568, 2167 Nonummy Road','Ap #826-8080 Augue Avenue','Kano','KN','36835-728');
INSERT.add_fisherman_details(195,'Ap #383-8955 Neque Rd.','888-8960 Imperdiet Street','Marneffe','Luik','130068');
INSERT.add_fisherman_details(196,'8578 Quis Ave','Ap #511-6811 Fusce Av.','Casnate con Bernate','LOM','46156');
INSERT.add_fisherman_details(197,'Ap #634-4470 Mauris, Rd.','P.O. Box 805, 5776 Pellentesque Ave','Kenosha','WI','X2C 5T5');
INSERT.add_fisherman_details(198,'661-5192 Nibh. St.','9843 Tristique Avenue','Bhakkar','Punjab','65839');
INSERT.add_fisherman_details(199,'397-4275 At Street','P.O. Box 112, 4571 Dui, Rd.','Fortaleza','CE','607439');
INSERT.add_fisherman_details(200,'P.O. Box 269, 2813 Nec Av.','4694 Aliquam Avenue','Moignelee','NA','8421 IO');
END;

BEGIN
INSERT.add_fish_species(500,'Perch',144,10);
INSERT.add_fish_species(501,'Smelt',139,4);
INSERT.add_fish_species(502,'Sturgeon',136,2);
INSERT.add_fish_species(503,'Burbot',26,10);
INSERT.add_fish_species(504,'Mackarel',49,1);
INSERT.add_fish_species(505,'Winter Flounder',144,1);
INSERT.add_fish_species(506,'Scup',53,1);
INSERT.add_fish_species(507,'Black Sea Bass',59,13);
INSERT.add_fish_species(508,'Brown Trout',106,15);
INSERT.add_fish_species(509,'Largemouth Bass',134,14);
INSERT.add_fish_species(510,'Bluegill',108,17);
INSERT.add_fish_species(511,'Striped Bass',92,20);
INSERT.add_fish_species(512,'Carp',135,20);
INSERT.add_fish_species(513,'White Catfish',92,15);
INSERT.add_fish_species(514,'Yellow Perch',112,20);
END;


BEGIN
INSERT.add_bookings(100,64,117,to_timestamp('23-FEB-21 05.02.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(101,21,212,to_timestamp('21-APR-20 05.52.29.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(102,56,219,to_timestamp('29-APR-21 07.36.13.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(103,194,105,to_timestamp('23-JUL-20 11.08.12.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(104,66,177,to_timestamp('03-MAY-20 06.38.38.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(105,181,198,to_timestamp('10-FEB-21 04.15.15.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(106,190,219,to_timestamp('21-MAR-20 06.54.08.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(107,70,197,to_timestamp('21-SEP-20 07.22.44.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(108,102,160,to_timestamp('18-OCT-20 11.25.29.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(109,135,147,to_timestamp('09-APR-21 02.02.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(110,22,200,to_timestamp('28-DEC-20 10.45.16.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(111,149,161,to_timestamp('23-MAR-20 11.04.54.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(112,113,142,to_timestamp('01-SEP-20 06.56.29.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(113,147,184,to_timestamp('01-JAN-21 03.20.33.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(114,86,225,to_timestamp('16-MAY-20 08.02.08.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(115,88,144,to_timestamp('09-MAY-20 06.52.56.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(116,119,144,to_timestamp('06-APR-20 09.57.15.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(117,65,153,to_timestamp('31-AUG-20 04.22.53.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(118,54,174,to_timestamp('28-NOV-20 02.45.01.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(119,100,168,to_timestamp('25-JAN-21 12.27.14.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(120,83,196,to_timestamp('12-APR-21 01.37.01.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(121,8,129,to_timestamp('16-FEB-21 02.19.36.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(122,9,115,to_timestamp('10-MAY-20 07.48.05.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(123,142,111,to_timestamp('30-JAN-21 01.56.27.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(124,99,194,to_timestamp('19-NOV-20 01.02.12.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(125,60,208,to_timestamp('14-JUN-20 10.12.33.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(126,163,222,to_timestamp('20-APR-21 09.02.13.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(127,183,102,to_timestamp('17-APR-20 08.23.18.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(128,174,116,to_timestamp('23-JUL-20 04.13.58.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(129,173,207,to_timestamp('30-JUN-20 05.04.02.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(130,47,224,to_timestamp('01-SEP-20 07.21.31.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(131,177,118,to_timestamp('28-MAY-20 08.21.52.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(132,82,145,to_timestamp('21-MAR-21 11.16.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(133,193,210,to_timestamp('12-NOV-20 03.55.59.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(134,110,206,to_timestamp('07-APR-21 08.34.11.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(135,91,205,to_timestamp('31-OCT-20 02.41.48.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(136,167,148,to_timestamp('24-APR-21 11.32.33.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(137,89,201,to_timestamp('24-APR-20 07.24.35.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(138,43,193,to_timestamp('03-JUN-20 03.27.40.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(139,118,223,to_timestamp('27-SEP-20 08.26.39.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(140,200,221,to_timestamp('06-MAY-20 07.22.03.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(141,169,154,to_timestamp('13-AUG-20 03.36.29.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(142,32,137,to_timestamp('27-MAR-20 06.33.25.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(143,58,173,to_timestamp('29-SEP-20 09.33.08.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(144,87,111,to_timestamp('09-JUL-20 12.30.29.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(145,160,194,to_timestamp('12-DEC-20 07.56.45.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(146,150,116,to_timestamp('06-OCT-20 10.32.28.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(147,33,201,to_timestamp('21-MAY-20 12.56.57.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(148,152,115,to_timestamp('24-FEB-21 06.01.13.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(149,73,154,to_timestamp('16-APR-20 12.54.58.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(150,136,107,to_timestamp('07-NOV-20 09.18.10.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(151,81,117,to_timestamp('11-AUG-20 09.36.42.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(152,182,163,to_timestamp('14-JAN-21 02.35.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(153,5,198,to_timestamp('12-NOV-20 04.54.44.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(154,191,188,to_timestamp('05-AUG-20 09.25.06.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(155,41,169,to_timestamp('12-MAR-21 04.33.08.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(156,198,206,to_timestamp('21-MAY-20 09.37.55.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(157,145,144,to_timestamp('23-DEC-20 11.34.58.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(158,170,166,to_timestamp('04-AUG-20 02.21.49.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(159,10,110,to_timestamp('30-JAN-21 02.42.57.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(160,189,101,to_timestamp('18-DEC-20 07.24.06.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(161,39,107,to_timestamp('04-OCT-20 12.52.28.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(162,178,139,to_timestamp('29-OCT-20 11.49.18.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(163,134,126,to_timestamp('10-JAN-21 08.14.28.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(164,117,144,to_timestamp('15-APR-21 08.27.43.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(165,141,102,to_timestamp('19-JUL-20 12.49.08.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(166,187,192,to_timestamp('28-DEC-20 01.54.10.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(167,127,103,to_timestamp('26-MAR-21 06.18.10.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(168,162,172,to_timestamp('07-AUG-20 10.56.05.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(169,27,143,to_timestamp('26-MAR-20 05.20.57.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(170,13,212,to_timestamp('25-JUN-20 06.19.28.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(171,101,192,to_timestamp('06-JUL-20 12.00.23.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(172,115,110,to_timestamp('25-FEB-21 05.35.32.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(173,156,196,to_timestamp('05-APR-21 07.48.39.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(174,133,180,to_timestamp('29-MAY-20 05.16.24.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(175,151,185,to_timestamp('11-JUL-20 02.52.21.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(176,175,208,to_timestamp('14-MAY-20 07.01.04.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(177,107,205,to_timestamp('21-OCT-20 11.09.35.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(178,122,115,to_timestamp('16-FEB-21 07.32.21.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(179,104,129,to_timestamp('21-OCT-20 10.51.05.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(180,48,139,to_timestamp('26-OCT-20 12.30.45.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(181,172,169,to_timestamp('22-JUN-20 12.55.37.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(182,188,160,to_timestamp('09-MAR-21 06.00.04.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(183,171,143,to_timestamp('24-NOV-20 01.39.38.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(184,12,180,to_timestamp('15-MAR-21 11.34.15.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(185,164,106,to_timestamp('16-APR-20 09.31.22.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(186,109,152,to_timestamp('05-SEP-20 06.43.08.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(187,103,210,to_timestamp('16-DEC-20 03.22.26.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(188,57,216,to_timestamp('12-APR-21 10.52.53.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(189,114,115,to_timestamp('18-JAN-21 07.33.58.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(190,34,105,to_timestamp('19-JUL-20 03.44.34.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(191,112,223,to_timestamp('23-MAY-20 04.05.02.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(192,37,181,to_timestamp('29-MAR-20 11.28.38.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(193,23,153,to_timestamp('19-DEC-20 06.14.09.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(194,153,190,to_timestamp('12-DEC-20 09.49.26.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(195,90,127,to_timestamp('28-MAR-21 03.16.59.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(196,179,181,to_timestamp('13-AUG-20 12.51.37.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(197,106,139,to_timestamp('03-MAY-20 10.52.25.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(198,4,179,to_timestamp('25-MAY-20 12.23.14.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(199,16,144,to_timestamp('28-NOV-20 10.44.41.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(200,55,171,to_timestamp('06-SEP-20 07.54.59.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(201,6,124,to_timestamp('21-APR-21 10.33.21.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(202,68,101,to_timestamp('11-JUL-20 03.02.51.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(203,85,185,to_timestamp('16-APR-21 04.06.37.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(204,20,223,to_timestamp('03-AUG-20 04.30.24.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(205,78,159,to_timestamp('29-MAR-20 09.45.41.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(206,139,216,to_timestamp('24-MAR-21 08.59.31.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(207,50,203,to_timestamp('04-SEP-20 07.56.19.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(208,124,170,to_timestamp('19-JUN-20 01.08.21.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(209,46,161,to_timestamp('20-APR-20 11.00.42.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(210,132,118,to_timestamp('02-APR-20 06.36.43.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(211,11,117,to_timestamp('13-JUL-20 01.00.39.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(212,42,105,to_timestamp('11-OCT-20 01.02.42.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(213,94,119,to_timestamp('22-JUL-20 06.51.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(214,80,105,to_timestamp('10-APR-21 11.02.54.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(215,195,130,to_timestamp('04-JUN-20 08.38.04.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(216,148,184,to_timestamp('02-SEP-20 09.14.09.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(217,18,166,to_timestamp('06-MAR-21 12.26.07.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(218,93,159,to_timestamp('12-JUN-20 04.39.17.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(219,72,220,to_timestamp('26-MAR-21 04.48.20.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(220,196,199,to_timestamp('03-OCT-20 03.35.20.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(221,44,129,to_timestamp('20-JUL-20 10.07.44.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(222,69,180,to_timestamp('10-JUL-20 05.41.13.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(223,95,122,to_timestamp('04-MAY-20 12.58.35.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(224,197,225,to_timestamp('15-MAR-20 10.37.49.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(225,40,113,to_timestamp('20-SEP-20 06.15.18.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(226,116,183,to_timestamp('03-DEC-20 07.56.37.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(227,45,119,to_timestamp('27-OCT-20 01.30.15.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(228,192,118,to_timestamp('25-NOV-20 12.19.37.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(229,121,150,to_timestamp('26-NOV-20 07.54.27.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(230,186,113,to_timestamp('08-JUL-20 12.54.34.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(231,51,155,to_timestamp('29-MAR-20 02.49.08.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(232,184,101,to_timestamp('29-JUN-20 02.52.20.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(233,15,191,to_timestamp('31-MAR-21 03.25.59.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(234,176,172,to_timestamp('05-MAY-20 06.32.58.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(235,130,167,to_timestamp('23-SEP-20 06.39.35.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(236,79,204,to_timestamp('16-AUG-20 08.30.43.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(237,36,179,to_timestamp('10-MAR-20 07.00.45.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(238,84,189,to_timestamp('05-JAN-21 09.01.42.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(239,126,206,to_timestamp('06-AUG-20 03.12.53.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(240,125,192,to_timestamp('29-SEP-20 03.16.23.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(241,14,195,to_timestamp('31-JUL-20 04.09.38.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(242,129,148,to_timestamp('21-OCT-20 03.48.18.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(243,75,102,to_timestamp('30-APR-20 12.47.15.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(244,140,156,to_timestamp('06-JUN-20 05.50.01.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(245,146,182,to_timestamp('11-NOV-20 08.50.05.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(246,155,161,to_timestamp('28-MAR-21 05.40.16.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(247,76,153,to_timestamp('01-JUL-20 03.14.05.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(248,105,182,to_timestamp('21-AUG-20 01.05.45.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(249,52,135,to_timestamp('10-APR-21 12.20.18.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(250,92,141,to_timestamp('16-MAR-20 05.13.26.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(251,138,137,to_timestamp('20-JAN-21 06.08.40.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(252,61,184,to_timestamp('23-JUN-20 12.07.12.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(253,29,223,to_timestamp('15-JAN-21 08.22.33.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(254,168,131,to_timestamp('24-MAR-21 01.11.11.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(255,120,128,to_timestamp('19-JUN-20 05.31.33.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(256,158,112,to_timestamp('05-NOV-20 08.29.21.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(257,3,150,to_timestamp('10-MAY-20 12.17.57.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(258,67,211,to_timestamp('06-FEB-21 05.20.20.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(259,185,151,to_timestamp('27-JUL-20 03.54.34.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(260,137,211,to_timestamp('23-OCT-20 09.38.08.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(261,17,104,to_timestamp('21-AUG-20 12.07.42.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(262,161,159,to_timestamp('06-JUN-20 12.54.13.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(263,157,195,to_timestamp('06-FEB-21 06.25.32.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(264,59,213,to_timestamp('26-DEC-20 03.41.49.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(265,35,151,to_timestamp('09-OCT-20 02.31.05.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(266,166,199,to_timestamp('19-MAR-21 01.50.58.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(267,97,150,to_timestamp('04-FEB-21 07.25.50.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(268,26,153,to_timestamp('25-JAN-21 04.39.39.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
INSERT.add_bookings(269,144,183,to_timestamp('15-JAN-21 09.17.30.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(270,63,132,to_timestamp('16-MAR-20 08.50.58.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(271,7,140,to_timestamp('04-APR-21 01.26.52.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(272,31,109,to_timestamp('06-OCT-20 09.22.45.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(273,53,130,to_timestamp('12-APR-20 01.27.50.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(274,143,221,to_timestamp('23-FEB-21 09.35.01.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(275,98,146,to_timestamp('03-JAN-21 03.25.46.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(276,165,168,to_timestamp('13-MAY-20 09.15.45.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(277,71,178,to_timestamp('27-MAR-21 10.51.05.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(278,199,138,to_timestamp('27-MAR-21 08.37.35.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(279,74,167,to_timestamp('09-NOV-20 03.31.48.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(280,19,186,to_timestamp('18-JUL-20 10.44.34.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(281,1,111,to_timestamp('16-DEC-20 09.18.41.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(282,96,196,to_timestamp('13-OCT-20 08.42.02.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(283,62,120,to_timestamp('15-MAY-20 12.30.29.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(284,154,218,to_timestamp('11-JUN-20 10.40.52.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(285,180,129,to_timestamp('06-NOV-20 02.04.58.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(286,38,180,to_timestamp('05-OCT-20 07.16.34.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(287,2,195,to_timestamp('16-JUN-20 03.02.46.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(288,128,106,to_timestamp('11-AUG-20 12.58.53.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(289,77,201,to_timestamp('25-JAN-21 05.17.07.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
INSERT.add_bookings(290,25,128,to_timestamp('04-APR-20 09.25.17.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
INSERT.add_bookings(291,111,156,to_timestamp('15-MAR-21 07.14.17.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
INSERT.add_bookings(292,24,206,to_timestamp('26-APR-20 02.45.38.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
INSERT.add_bookings(293,131,113,to_timestamp('19-SEP-20 06.15.35.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
INSERT.add_bookings(294,159,197,to_timestamp('16-NOV-20 01.29.20.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
INSERT.add_bookings(295,30,182,to_timestamp('14-DEC-20 04.35.47.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
INSERT.add_bookings(296,49,112,to_timestamp('22-MAY-20 08.20.12.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
INSERT.add_bookings(297,123,107,to_timestamp('25-SEP-20 04.50.09.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
INSERT.add_bookings(298,108,218,to_timestamp('23-MAR-21 08.55.55.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
INSERT.add_bookings(299,28,126,to_timestamp('02-JUN-20 12.05.51.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
END;

BEGIN
INSERT.add_slots(100,'Monday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),11,10);
INSERT.add_slots(101,'Tuesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),11,10);
INSERT.add_slots(102,'Wednesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),19,10);
INSERT.add_slots(103,'Thursday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),1,10);
INSERT.add_slots(104,'Friday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),9,10);
INSERT.add_slots(105,'Saturday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),16,10);
INSERT.add_slots(106,'Sunday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),0,10);
INSERT.add_slots(107,'Monday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),14,10);
INSERT.add_slots(108,'Tuesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),16,10);
INSERT.add_slots(109,'Wednesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),15,10);
INSERT.add_slots(110,'Thursday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),17,10);
INSERT.add_slots(111,'Friday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),9,10);
INSERT.add_slots(112,'Saturday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),14,10);
INSERT.add_slots(113,'Sunday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),11,10);
INSERT.add_slots(114,'Monday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),0,11);
INSERT.add_slots(115,'Tuesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),6,11);
INSERT.add_slots(116,'Wednesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),18,11);
INSERT.add_slots(117,'Thursday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),16,11);
INSERT.add_slots(118,'Friday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),3,11);
INSERT.add_slots(119,'Saturday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),5,11);
INSERT.add_slots(120,'Sunday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),14,11);
INSERT.add_slots(121,'Monday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),13,11);
INSERT.add_slots(122,'Tuesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),12,11);
INSERT.add_slots(123,'Wednesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),11,11);
INSERT.add_slots(124,'Thursday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),3,11);
INSERT.add_slots(125,'Friday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),20,11);
INSERT.add_slots(126,'Saturday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),12,11);
INSERT.add_slots(127,'Sunday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),2,11);
INSERT.add_slots(128,'Monday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),18,12);
INSERT.add_slots(129,'Tuesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),4,12);
INSERT.add_slots(130,'Wednesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),10,12);
INSERT.add_slots(131,'Thursday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),14,12);
INSERT.add_slots(132,'Friday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),18,12);
INSERT.add_slots(133,'Saturday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),10,12);
INSERT.add_slots(134,'Sunday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),20,12);
INSERT.add_slots(135,'Monday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),12,12);
INSERT.add_slots(136,'Tuesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),16,12);
INSERT.add_slots(137,'Wednesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),10,12);
INSERT.add_slots(138,'Thursday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),20,12);
INSERT.add_slots(139,'Friday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),18,12);
INSERT.add_slots(140,'Saturday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),17,12);
INSERT.add_slots(141,'Sunday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),3,12);
INSERT.add_slots(142,'Monday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),5,13);
INSERT.add_slots(143,'Tuesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),19,13);
INSERT.add_slots(144,'Wednesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),13,13);
INSERT.add_slots(145,'Thursday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),8,13);
INSERT.add_slots(146,'Friday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),3,13);
INSERT.add_slots(147,'Saturday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),10,13);
INSERT.add_slots(148,'Sunday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),11,13);
INSERT.add_slots(149,'Monday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),14,13);
INSERT.add_slots(150,'Tuesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),5,13);
INSERT.add_slots(151,'Wednesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),0,13);
INSERT.add_slots(152,'Thursday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),8,13);
INSERT.add_slots(153,'Friday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),20,13);
INSERT.add_slots(154,'Saturday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),12,13);
INSERT.add_slots(155,'Sunday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),7,13);
INSERT.add_slots(156,'Monday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),20,14);
INSERT.add_slots(157,'Tuesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),4,14);
INSERT.add_slots(158,'Wednesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),2,14);
INSERT.add_slots(159,'Thursday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),8,14);
INSERT.add_slots(160,'Friday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),13,14);
INSERT.add_slots(161,'Saturday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),20,14);
INSERT.add_slots(162,'Sunday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),15,14);
INSERT.add_slots(163,'Monday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),6,14);
INSERT.add_slots(164,'Tuesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),12,14);
INSERT.add_slots(165,'Wednesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),2,14);
INSERT.add_slots(166,'Thursday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),3,14);
INSERT.add_slots(167,'Friday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),7,14);
INSERT.add_slots(168,'Saturday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),10,14);
INSERT.add_slots(169,'Sunday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),1,14);
INSERT.add_slots(170,'Monday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),17,15);
INSERT.add_slots(171,'Tuesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),19,15);
INSERT.add_slots(172,'Wednesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),1,15);
INSERT.add_slots(173,'Thursday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),3,15);
INSERT.add_slots(174,'Friday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),14,15);
INSERT.add_slots(175,'Saturday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),15,15);
INSERT.add_slots(176,'Sunday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),9,15);
INSERT.add_slots(177,'Monday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),10,15);
INSERT.add_slots(178,'Tuesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),7,15);
INSERT.add_slots(179,'Wednesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),7,15);
INSERT.add_slots(180,'Thursday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),16,15);
INSERT.add_slots(181,'Friday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),10,15);
INSERT.add_slots(182,'Saturday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),4,15);
INSERT.add_slots(183,'Sunday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),7,15);
INSERT.add_slots(184,'Monday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),10,16);
INSERT.add_slots(185,'Tuesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),7,16);
INSERT.add_slots(186,'Wednesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),9,16);
INSERT.add_slots(187,'Thursday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),1,16);
INSERT.add_slots(188,'Friday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),16,16);
INSERT.add_slots(189,'Saturday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),5,16);
INSERT.add_slots(190,'Sunday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),13,16);
INSERT.add_slots(191,'Monday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),14,16);
INSERT.add_slots(192,'Tuesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),9,16);
INSERT.add_slots(193,'Wednesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),4,16);
INSERT.add_slots(194,'Thursday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),15,16);
INSERT.add_slots(195,'Friday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),11,16);
INSERT.add_slots(196,'Saturday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),15,16);
INSERT.add_slots(197,'Sunday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),15,16);
INSERT.add_slots(198,'Monday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),3,17);
INSERT.add_slots(199,'Tuesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),1,17);
INSERT.add_slots(200,'Wednesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),10,17);
INSERT.add_slots(201,'Thursday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),4,17);
INSERT.add_slots(202,'Friday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),14,17);
INSERT.add_slots(203,'Saturday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),4,17);
INSERT.add_slots(204,'Sunday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),15,17);
INSERT.add_slots(205,'Monday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),14,17);
INSERT.add_slots(206,'Tuesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),11,17);
INSERT.add_slots(207,'Wednesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),11,17);
INSERT.add_slots(208,'Thursday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),18,17);
INSERT.add_slots(209,'Friday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),5,17);
INSERT.add_slots(210,'Saturday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),1,17);
INSERT.add_slots(211,'Sunday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),12,17);
INSERT.add_slots(212,'Monday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),1,18);
INSERT.add_slots(213,'Tuesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),19,18);
INSERT.add_slots(214,'Wednesday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),12,18);
INSERT.add_slots(215,'Thursday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),10,18);
INSERT.add_slots(216,'Friday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),3,18);
INSERT.add_slots(217,'Saturday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),1,18);
INSERT.add_slots(218,'Sunday',to_timestamp('01-APR-21 06.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),2,18);
INSERT.add_slots(219,'Monday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),16,18);
INSERT.add_slots(220,'Tuesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),10,18);
INSERT.add_slots(221,'Wednesday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),5,18);
INSERT.add_slots(222,'Thursday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),8,18);
INSERT.add_slots(223,'Friday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),10,18);
INSERT.add_slots(224,'Saturday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),5,18);
INSERT.add_slots(225,'Sunday',to_timestamp('01-APR-21 02.00.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),0,18);
END;    


BEGIN
INSERT.add_sub_location (10,'A',1);
INSERT.add_sub_location (11,'B',1);
INSERT.add_sub_location (12,'C',1);
INSERT.add_sub_location (13,'A',2);
INSERT.add_sub_location (14,'B',2);
INSERT.add_sub_location (15,'C',2);
INSERT.add_sub_location (16,'A',3);
INSERT.add_sub_location (17,'B',3);
INSERT.add_sub_location (18,'C',3);
END;

BEGIN
INSERT.add_location_stats(1,to_date('25-04-21','DD-MM-RR'),'Y',68,to_timestamp('10-03-21 06:15:35.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'),9,0.02,to_timestamp('10-03-21 02:12:56.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_location_stats(2,to_date('25-04-21','DD-MM-RR'),'N',70,to_timestamp('10-03-21 06:15:35.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'),10,0.03,to_timestamp('10-03-21 02:12:56.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_location_stats(3,to_date('25-04-21','DD-MM-RR'),'Y',78,to_timestamp('10-03-21 06:15:35.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'),9,0.02,to_timestamp('10-03-21 02:12:56.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
END;  

BEGIN
INSERT.add_fish_stats(100,500,257,to_date('25-04-21','DD-MM-RR'),13);
INSERT.add_fish_stats(101,501,163,to_date('25-04-21','DD-MM-RR'),14);
INSERT.add_fish_stats(102,502,201,to_date('25-04-21','DD-MM-RR'),15);

INSERT.add_fish_stats(103,503,119,to_date('25-04-21','DD-MM-RR'),14);
INSERT.add_fish_stats(104,504,115,to_date('25-04-21','DD-MM-RR'),16);
INSERT.add_fish_stats(105,505,114,to_date('25-04-21','DD-MM-RR'),17);

INSERT.add_fish_stats(106,506,152,to_date('25-04-21','DD-MM-RR'),17);
INSERT.add_fish_stats(107,507,82,to_date('25-04-21','DD-MM-RR'),18);
INSERT.add_fish_stats(108,508,233,to_date('25-04-21','DD-MM-RR'),17);

INSERT.add_fish_stats(109,509,68,to_date('25-04-21','DD-MM-RR'),11);
INSERT.add_fish_stats(110,510,82,to_date('25-04-21','DD-MM-RR'),11);
INSERT.add_fish_stats(111,511,106,to_date('25-04-21','DD-MM-RR'),11);

INSERT.add_fish_stats(112,512,204,to_date('25-04-21','DD-MM-RR'),12);
INSERT.add_fish_stats(113,513,150,to_date('25-04-21','DD-MM-RR'),10);
INSERT.add_fish_stats(114,514,123,to_date('25-04-21','DD-MM-RR'),10);
END;

BEGIN
INSERT.add_checkin_log(100,1000,to_timestamp('06-DEC-20 05.22.38.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',91);
INSERT.add_checkin_log(101,1001,to_timestamp('25-MAR-20 01.52.51.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',109);
INSERT.add_checkin_log(102,1002,to_timestamp('19-NOV-20 06.47.21.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',31);
INSERT.add_checkin_log(103,1003,to_timestamp('30-MAR-20 01.26.47.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',184);
INSERT.add_checkin_log(104,1004,to_timestamp('18-FEB-21 01.35.14.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',48);
INSERT.add_checkin_log(105,1005,to_timestamp('06-MAY-20 02.54.07.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',135);
INSERT.add_checkin_log(106,1006,to_timestamp('19-APR-21 12.59.22.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',98);
INSERT.add_checkin_log(107,1007,to_timestamp('03-AUG-20 01.49.33.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',80);
INSERT.add_checkin_log(108,1008,to_timestamp('11-JAN-21 08.05.37.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',32);
INSERT.add_checkin_log(109,1009,to_timestamp('10-NOV-20 09.56.01.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',33);
INSERT.add_checkin_log(110,1010,to_timestamp('18-APR-20 02.33.26.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',168);
INSERT.add_checkin_log(111,1011,to_timestamp('12-MAR-20 02.37.06.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',146);
INSERT.add_checkin_log(112,1012,to_timestamp('31-JUL-20 06.46.07.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',102);
INSERT.add_checkin_log(113,1013,to_timestamp('16-MAR-20 03.34.47.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',174);
INSERT.add_checkin_log(114,1014,to_timestamp('11-MAR-21 02.28.31.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',26);
INSERT.add_checkin_log(115,1015,to_timestamp('25-DEC-20 03.02.53.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',71);
INSERT.add_checkin_log(116,1016,to_timestamp('01-AUG-20 09.01.36.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',11);
INSERT.add_checkin_log(117,1017,to_timestamp('25-APR-21 10.53.04.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',38);
INSERT.add_checkin_log(118,1018,to_timestamp('06-APR-21 06.24.27.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',104);
INSERT.add_checkin_log(119,1019,to_timestamp('03-APR-21 02.37.23.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',45);
INSERT.add_checkin_log(120,1020,to_timestamp('14-MAR-20 01.26.12.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',169);
INSERT.add_checkin_log(121,1021,to_timestamp('24-AUG-20 06.06.16.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',180);
INSERT.add_checkin_log(122,1022,to_timestamp('01-JUN-20 10.05.13.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',150);
INSERT.add_checkin_log(123,1023,to_timestamp('17-OCT-20 09.06.49.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',124);
INSERT.add_checkin_log(124,1024,to_timestamp('11-MAR-20 02.59.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',200);
INSERT.add_checkin_log(125,1025,to_timestamp('24-DEC-20 06.13.44.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',161);
INSERT.add_checkin_log(126,1026,to_timestamp('23-AUG-20 01.15.54.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',34);
INSERT.add_checkin_log(127,1027,to_timestamp('29-NOV-20 12.41.31.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',109);
INSERT.add_checkin_log(128,1028,to_timestamp('24-FEB-21 02.31.21.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',130);
INSERT.add_checkin_log(129,1029,to_timestamp('06-MAR-21 08.20.05.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',184);
INSERT.add_checkin_log(130,1030,to_timestamp('25-JUL-20 06.13.07.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',150);
INSERT.add_checkin_log(131,1031,to_timestamp('22-OCT-20 02.52.39.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',42);
INSERT.add_checkin_log(132,1032,to_timestamp('15-APR-20 09.27.07.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',144);
INSERT.add_checkin_log(133,1033,to_timestamp('04-JUN-20 03.59.25.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',56);
INSERT.add_checkin_log(134,1034,to_timestamp('01-SEP-20 03.16.20.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',149);
INSERT.add_checkin_log(135,1035,to_timestamp('04-SEP-20 04.03.03.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',97);
INSERT.add_checkin_log(136,1036,to_timestamp('09-MAY-20 07.05.04.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',8);
INSERT.add_checkin_log(137,1037,to_timestamp('13-JUL-20 03.17.40.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',198);
INSERT.add_checkin_log(138,1038,to_timestamp('26-JUN-20 01.19.34.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',30);
INSERT.add_checkin_log(139,1039,to_timestamp('30-JUL-20 01.11.32.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',130);
INSERT.add_checkin_log(140,1040,to_timestamp('10-FEB-21 11.42.29.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',88);
INSERT.add_checkin_log(141,1041,to_timestamp('27-AUG-20 04.14.22.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',167);
INSERT.add_checkin_log(142,1042,to_timestamp('10-AUG-20 10.53.19.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',9);
INSERT.add_checkin_log(143,1043,to_timestamp('28-JAN-21 08.13.15.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',31);
INSERT.add_checkin_log(144,1044,to_timestamp('30-APR-21 04.52.39.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',129);
INSERT.add_checkin_log(145,1045,to_timestamp('23-SEP-20 10.23.16.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',30);
INSERT.add_checkin_log(146,1046,to_timestamp('02-APR-20 03.26.31.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',186);
INSERT.add_checkin_log(147,1047,to_timestamp('25-SEP-20 05.45.39.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',132);
INSERT.add_checkin_log(148,1048,to_timestamp('04-JUL-20 07.30.28.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',135);
INSERT.add_checkin_log(149,1049,to_timestamp('21-JUN-20 03.56.02.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',86);
INSERT.add_checkin_log(150,1050,to_timestamp('21-SEP-20 05.19.43.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',142);
INSERT.add_checkin_log(151,1051,to_timestamp('08-APR-21 06.30.58.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',19);
INSERT.add_checkin_log(152,1052,to_timestamp('20-MAR-21 07.06.29.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',36);
INSERT.add_checkin_log(153,1053,to_timestamp('26-JUL-20 05.43.36.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',141);
INSERT.add_checkin_log(154,1054,to_timestamp('22-AUG-20 08.38.21.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',94);
INSERT.add_checkin_log(155,1055,to_timestamp('22-AUG-20 09.09.55.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',199);
INSERT.add_checkin_log(156,1056,to_timestamp('26-JUL-20 10.52.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',89);
INSERT.add_checkin_log(157,1057,to_timestamp('02-MAR-21 04.37.04.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',99);
INSERT.add_checkin_log(158,1058,to_timestamp('07-FEB-21 03.09.01.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',74);
INSERT.add_checkin_log(159,1059,to_timestamp('04-NOV-20 12.11.57.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',192);
INSERT.add_checkin_log(160,1060,to_timestamp('11-MAR-21 10.57.18.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',47);
INSERT.add_checkin_log(161,1061,to_timestamp('24-JUN-20 04.18.25.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',144);
INSERT.add_checkin_log(162,1062,to_timestamp('21-MAR-21 10.18.39.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',17);
INSERT.add_checkin_log(163,1063,to_timestamp('24-NOV-20 09.39.32.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',145);
INSERT.add_checkin_log(164,1064,to_timestamp('19-OCT-20 01.50.36.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',101);
INSERT.add_checkin_log(165,1065,to_timestamp('01-JAN-21 04.22.11.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',164);
INSERT.add_checkin_log(166,1066,to_timestamp('29-APR-21 03.28.02.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',169);
INSERT.add_checkin_log(167,1067,to_timestamp('25-JUL-20 06.07.25.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',181);
INSERT.add_checkin_log(168,1068,to_timestamp('31-MAY-20 12.15.32.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',174);
INSERT.add_checkin_log(169,1069,to_timestamp('06-FEB-21 03.32.46.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',16);
INSERT.add_checkin_log(170,1070,to_timestamp('11-JUN-20 02.23.47.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',165);
INSERT.add_checkin_log(171,1071,to_timestamp('31-OCT-20 06.05.36.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',32);
INSERT.add_checkin_log(172,1072,to_timestamp('09-MAR-21 12.08.20.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',63);
INSERT.add_checkin_log(173,1073,to_timestamp('04-SEP-20 12.19.18.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',180);
INSERT.add_checkin_log(174,1074,to_timestamp('18-APR-20 02.12.27.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',186);
INSERT.add_checkin_log(175,1075,to_timestamp('07-NOV-20 10.27.48.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',53);
INSERT.add_checkin_log(176,1076,to_timestamp('29-DEC-20 02.15.47.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',192);
INSERT.add_checkin_log(177,1077,to_timestamp('11-SEP-20 09.50.45.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',130);
INSERT.add_checkin_log(178,1078,to_timestamp('15-SEP-20 11.38.48.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',17);
INSERT.add_checkin_log(179,1079,to_timestamp('20-APR-20 09.46.11.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',41);
INSERT.add_checkin_log(180,1080,to_timestamp('16-MAR-21 11.01.47.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',164);
INSERT.add_checkin_log(181,1081,to_timestamp('17-AUG-20 07.36.19.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',125);
INSERT.add_checkin_log(182,1082,to_timestamp('07-JUN-20 07.51.18.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',46);
INSERT.add_checkin_log(183,1083,to_timestamp('26-SEP-20 05.48.55.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',54);
INSERT.add_checkin_log(184,1084,to_timestamp('06-FEB-21 11.45.35.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',99);
INSERT.add_checkin_log(185,1085,to_timestamp('23-NOV-20 03.57.10.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',80);
INSERT.add_checkin_log(186,1086,to_timestamp('03-SEP-20 06.46.42.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',130);
INSERT.add_checkin_log(187,1087,to_timestamp('20-JUN-20 12.23.22.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',179);
INSERT.add_checkin_log(188,1088,to_timestamp('19-NOV-20 07.21.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',65);
INSERT.add_checkin_log(189,1089,to_timestamp('01-JUN-20 02.52.19.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',16);
INSERT.add_checkin_log(190,1090,to_timestamp('11-MAR-21 11.26.57.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',193);
INSERT.add_checkin_log(191,1091,to_timestamp('15-OCT-20 06.47.26.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',146);
INSERT.add_checkin_log(192,1092,to_timestamp('03-DEC-20 05.02.56.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',30);
INSERT.add_checkin_log(193,1093,to_timestamp('15-SEP-20 03.47.12.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',98);
INSERT.add_checkin_log(194,1094,to_timestamp('06-APR-21 04.44.06.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',52);
INSERT.add_checkin_log(195,1095,to_timestamp('17-APR-20 08.04.50.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',75);
INSERT.add_checkin_log(196,1096,to_timestamp('23-FEB-21 10.36.55.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',192);
INSERT.add_checkin_log(197,1097,to_timestamp('23-JAN-21 08.37.01.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',158);
INSERT.add_checkin_log(198,1098,to_timestamp('17-FEB-21 07.09.52.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',162);
INSERT.add_checkin_log(199,1099,to_timestamp('22-NOV-20 02.27.46.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',14);
INSERT.add_checkin_log(200,1100,to_timestamp('11-DEC-20 08.19.17.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',174);
INSERT.add_checkin_log(201,1101,to_timestamp('09-APR-20 12.54.41.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',140);
INSERT.add_checkin_log(202,1102,to_timestamp('13-MAY-20 03.44.26.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',167);
INSERT.add_checkin_log(203,1103,to_timestamp('21-APR-21 01.27.31.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',107);
INSERT.add_checkin_log(204,1104,to_timestamp('30-MAY-20 09.53.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',119);
INSERT.add_checkin_log(205,1105,to_timestamp('19-APR-21 12.29.26.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',142);
INSERT.add_checkin_log(206,1106,to_timestamp('17-SEP-20 04.22.33.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',23);
INSERT.add_checkin_log(207,1107,to_timestamp('16-APR-21 01.35.04.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',15);
INSERT.add_checkin_log(208,1108,to_timestamp('29-OCT-20 08.59.55.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',66);
INSERT.add_checkin_log(209,1109,to_timestamp('17-JUL-20 08.53.48.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',148);
INSERT.add_checkin_log(210,1110,to_timestamp('25-APR-20 07.30.23.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',169);
INSERT.add_checkin_log(211,1111,to_timestamp('03-JAN-21 02.23.53.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',20);
INSERT.add_checkin_log(212,1112,to_timestamp('13-APR-20 01.48.58.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',31);
INSERT.add_checkin_log(213,1113,to_timestamp('14-JUN-20 12.41.52.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',157);
INSERT.add_checkin_log(214,1114,to_timestamp('26-SEP-20 03.30.25.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',28);
INSERT.add_checkin_log(215,1115,to_timestamp('22-JUN-20 03.23.44.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',42);
INSERT.add_checkin_log(216,1116,to_timestamp('07-JUL-20 05.48.51.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',94);
INSERT.add_checkin_log(217,1117,to_timestamp('10-APR-21 06.30.50.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',52);
INSERT.add_checkin_log(218,1118,to_timestamp('20-NOV-20 08.12.48.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',120);
INSERT.add_checkin_log(219,1119,to_timestamp('17-APR-20 11.50.17.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',188);
INSERT.add_checkin_log(220,1120,to_timestamp('04-OCT-20 01.44.57.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',141);
INSERT.add_checkin_log(221,1121,to_timestamp('04-JAN-21 02.56.33.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',188);
INSERT.add_checkin_log(222,1122,to_timestamp('26-JAN-21 04.43.59.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',21);
INSERT.add_checkin_log(223,1123,to_timestamp('19-MAR-21 09.50.47.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',97);
INSERT.add_checkin_log(224,1124,to_timestamp('20-JAN-21 02.58.08.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',96);
INSERT.add_checkin_log(225,1125,to_timestamp('25-OCT-20 04.15.51.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',121);
INSERT.add_checkin_log(226,1126,to_timestamp('21-MAR-20 07.51.07.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',72);
INSERT.add_checkin_log(227,1127,to_timestamp('28-JUL-20 08.12.42.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',149);
INSERT.add_checkin_log(228,1128,to_timestamp('29-NOV-20 04.44.28.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',149);
INSERT.add_checkin_log(229,1129,to_timestamp('09-MAY-20 12.10.59.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',142);
INSERT.add_checkin_log(230,1130,to_timestamp('01-JAN-21 01.55.16.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',39);
INSERT.add_checkin_log(231,1131,to_timestamp('03-AUG-20 11.47.04.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',16);
INSERT.add_checkin_log(232,1132,to_timestamp('25-SEP-20 10.01.07.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',176);
INSERT.add_checkin_log(233,1133,to_timestamp('25-APR-21 03.04.51.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',139);
INSERT.add_checkin_log(234,1134,to_timestamp('02-SEP-20 05.15.42.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',106);
INSERT.add_checkin_log(235,1135,to_timestamp('13-AUG-20 12.22.04.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',107);
INSERT.add_checkin_log(236,1136,to_timestamp('14-MAR-21 07.47.42.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',120);
INSERT.add_checkin_log(237,1137,to_timestamp('05-MAY-20 08.11.25.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',189);
INSERT.add_checkin_log(238,1138,to_timestamp('13-JUL-20 01.05.13.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',164);
INSERT.add_checkin_log(239,1139,to_timestamp('27-MAR-20 04.46.19.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',58);
INSERT.add_checkin_log(240,1140,to_timestamp('24-NOV-20 10.06.58.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',138);
INSERT.add_checkin_log(241,1141,to_timestamp('17-JUN-20 08.07.27.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',101);
INSERT.add_checkin_log(242,1142,to_timestamp('20-APR-20 12.53.54.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',86);
INSERT.add_checkin_log(243,1143,to_timestamp('14-JAN-21 07.21.25.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',91);
INSERT.add_checkin_log(244,1144,to_timestamp('18-APR-21 06.09.20.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',172);
INSERT.add_checkin_log(245,1145,to_timestamp('18-FEB-21 10.53.25.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',67);
INSERT.add_checkin_log(246,1146,to_timestamp('19-JUL-20 06.21.26.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',156);
INSERT.add_checkin_log(247,1147,to_timestamp('10-MAR-20 04.55.36.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',100);
INSERT.add_checkin_log(248,1148,to_timestamp('16-JUN-20 11.04.24.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',152);
INSERT.add_checkin_log(249,1149,to_timestamp('27-JUL-20 02.30.33.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',9);
INSERT.add_checkin_log(250,1150,to_timestamp('10-JAN-21 08.11.19.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',59);
INSERT.add_checkin_log(251,1151,to_timestamp('10-MAR-20 04.40.36.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',190);
INSERT.add_checkin_log(252,1152,to_timestamp('19-APR-20 09.30.57.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',41);
INSERT.add_checkin_log(253,1153,to_timestamp('24-MAR-21 10.39.36.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',119);
INSERT.add_checkin_log(254,1154,to_timestamp('30-SEP-20 04.19.50.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',29);
INSERT.add_checkin_log(255,1155,to_timestamp('24-JAN-21 06.34.17.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',54);
INSERT.add_checkin_log(256,1156,to_timestamp('08-FEB-21 09.02.30.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',139);
INSERT.add_checkin_log(257,1157,to_timestamp('14-MAR-21 11.57.07.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',174);
INSERT.add_checkin_log(258,1158,to_timestamp('26-AUG-20 09.54.42.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',112);
INSERT.add_checkin_log(259,1159,to_timestamp('18-APR-21 03.24.21.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',53);
INSERT.add_checkin_log(260,1160,to_timestamp('25-JAN-21 02.50.05.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',24);
INSERT.add_checkin_log(261,1161,to_timestamp('24-FEB-21 09.04.21.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',117);
INSERT.add_checkin_log(262,1162,to_timestamp('17-MAY-20 08.12.12.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',193);
INSERT.add_checkin_log(263,1163,to_timestamp('22-FEB-21 02.06.25.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',127);
INSERT.add_checkin_log(264,1164,to_timestamp('30-MAY-20 03.39.12.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',11);
INSERT.add_checkin_log(265,1165,to_timestamp('16-AUG-20 05.58.27.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',81);
INSERT.add_checkin_log(266,1166,to_timestamp('22-JAN-21 08.52.32.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',117);
INSERT.add_checkin_log(267,1167,to_timestamp('18-MAR-21 05.04.38.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',151);
INSERT.add_checkin_log(268,1168,to_timestamp('08-NOV-20 05.22.59.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',64);
INSERT.add_checkin_log(269,1169,to_timestamp('04-APR-21 04.41.36.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',160);
INSERT.add_checkin_log(270,1170,to_timestamp('28-JAN-21 02.06.37.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',30);
INSERT.add_checkin_log(271,1171,to_timestamp('25-JUL-20 11.08.41.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',60);
INSERT.add_checkin_log(272,1172,to_timestamp('15-DEC-20 06.40.37.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',150);
INSERT.add_checkin_log(273,1173,to_timestamp('04-FEB-21 06.50.55.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',146);
INSERT.add_checkin_log(274,1174,to_timestamp('01-SEP-20 04.33.30.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',67);
INSERT.add_checkin_log(275,1175,to_timestamp('03-DEC-20 04.11.54.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',119);
INSERT.add_checkin_log(276,1176,to_timestamp('10-JAN-21 11.28.18.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',170);
INSERT.add_checkin_log(277,1177,to_timestamp('02-NOV-20 06.21.55.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',172);
INSERT.add_checkin_log(278,1178,to_timestamp('05-APR-20 08.04.18.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',23);
INSERT.add_checkin_log(279,1179,to_timestamp('29-MAR-20 12.04.13.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',72);
INSERT.add_checkin_log(280,1180,to_timestamp('08-FEB-21 02.47.47.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',147);
INSERT.add_checkin_log(281,1181,to_timestamp('04-JUL-20 03.38.12.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',116);
INSERT.add_checkin_log(282,1182,to_timestamp('07-APR-21 12.41.53.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',145);
INSERT.add_checkin_log(283,1183,to_timestamp('20-MAR-21 02.02.16.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',156);
INSERT.add_checkin_log(284,1184,to_timestamp('10-FEB-21 12.32.25.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',53);
INSERT.add_checkin_log(285,1185,to_timestamp('22-OCT-20 01.05.15.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',3);
INSERT.add_checkin_log(286,1186,to_timestamp('26-JUL-20 06.04.16.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',14);
INSERT.add_checkin_log(287,1187,to_timestamp('20-JUN-20 06.44.05.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',123);
INSERT.add_checkin_log(288,1188,to_timestamp('05-JUL-20 12.14.03.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',92);
INSERT.add_checkin_log(289,1189,to_timestamp('24-APR-20 09.31.51.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',120);
INSERT.add_checkin_log(290,1190,to_timestamp('24-MAR-21 11.34.20.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',115);
INSERT.add_checkin_log(291,1191,to_timestamp('25-APR-20 11.39.03.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',109);
INSERT.add_checkin_log(292,1192,to_timestamp('13-JAN-21 08.05.12.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',56);
INSERT.add_checkin_log(293,1193,to_timestamp('14-JAN-21 02.40.44.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',165);
INSERT.add_checkin_log(294,1194,to_timestamp('07-JUN-20 09.24.49.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',197);
INSERT.add_checkin_log(295,1195,to_timestamp('18-JUN-20 05.55.58.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',132);
INSERT.add_checkin_log(296,1196,to_timestamp('23-SEP-20 12.47.48.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','Y',147);
INSERT.add_checkin_log(297,1197,to_timestamp('10-MAY-20 03.15.27.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',61);
INSERT.add_checkin_log(298,1198,to_timestamp('29-APR-21 10.28.25.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',95);
INSERT.add_checkin_log(299,1199,to_timestamp('10-APR-20 04.55.28.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'N','N',111);
END;

BEGIN
INSERT.add_checkout_log(1188,100,35,to_timestamp('14-11-20 06:11:24.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1056,102,7,to_timestamp('14-03-21 12:22:08.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1117,100,43,to_timestamp('25-05-20 07:16:25.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1142,106,39,to_timestamp('07-03-21 12:12:22.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1082,111,30,to_timestamp('25-09-20 03:04:39.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1124,102,9,to_timestamp('10-03-21 08:57:06.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1015,109,10,to_timestamp('31-03-21 10:29:20.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1109,111,14,to_timestamp('19-08-20 05:33:08.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1094,106,15,to_timestamp('11-01-21 08:51:09.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1177,106,50,to_timestamp('07-08-20 02:25:29.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1062,114,7,to_timestamp('19-10-20 05:49:43.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1198,104,25,to_timestamp('18-01-21 02:11:50.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1045,103,34,to_timestamp('25-01-21 03:51:27.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1173,112,23,to_timestamp('07-03-21 08:06:40.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1077,101,21,to_timestamp('24-02-21 10:51:01.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1004,111,19,to_timestamp('31-01-21 09:18:46.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1072,101,32,to_timestamp('11-04-21 12:12:11.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1001,114,41,to_timestamp('06-02-21 05:08:25.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1131,104,10,to_timestamp('12-10-20 02:27:58.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1038,114,20,to_timestamp('20-04-21 10:22:03.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1103,106,23,to_timestamp('25-09-20 05:56:22.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1133,106,31,to_timestamp('26-03-20 10:00:25.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1005,105,19,to_timestamp('27-04-20 11:47:39.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1187,100,31,to_timestamp('18-07-20 10:49:58.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1013,107,8,to_timestamp('21-12-20 08:11:51.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1180,114,9,to_timestamp('17-02-21 07:12:52.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1170,102,14,to_timestamp('23-05-20 12:51:22.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1170,111,7,to_timestamp('16-02-21 12:41:57.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1153,100,27,to_timestamp('24-04-20 03:02:18.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1156,112,31,to_timestamp('05-12-20 03:20:50.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1195,113,46,to_timestamp('19-08-20 07:54:43.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1007,112,42,to_timestamp('22-04-20 08:01:46.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1179,114,40,to_timestamp('07-08-20 09:45:44.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1073,109,13,to_timestamp('05-04-20 02:50:42.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1149,102,48,to_timestamp('13-11-20 11:17:00.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1174,112,42,to_timestamp('08-01-21 08:07:56.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1173,101,9,to_timestamp('22-04-21 03:15:46.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1181,103,17,to_timestamp('11-12-20 04:18:57.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1190,111,35,to_timestamp('10-06-20 02:38:10.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1167,101,27,to_timestamp('09-02-21 12:50:44.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1076,100,28,to_timestamp('09-04-21 05:59:44.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1195,114,46,to_timestamp('27-03-20 05:10:38.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1012,106,40,to_timestamp('12-09-20 07:03:04.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1028,105,27,to_timestamp('20-07-20 06:12:11.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1114,109,30,to_timestamp('29-06-20 02:05:16.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1085,112,31,to_timestamp('03-01-21 03:52:25.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1047,114,7,to_timestamp('27-04-20 07:12:12.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1075,112,25,to_timestamp('07-09-20 08:29:31.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1168,106,14,to_timestamp('05-12-20 07:49:41.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1106,100,38,to_timestamp('30-03-21 08:36:55.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1183,102,27,to_timestamp('28-11-20 12:33:54.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1091,105,24,to_timestamp('16-11-20 05:32:38.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1048,107,37,to_timestamp('20-08-20 02:58:07.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1128,102,6,to_timestamp('19-01-21 03:00:08.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1007,100,39,to_timestamp('06-11-20 12:48:41.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1093,103,29,to_timestamp('14-07-20 05:49:03.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1109,109,41,to_timestamp('22-06-20 11:26:03.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1036,102,19,to_timestamp('28-11-20 07:50:50.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1022,114,19,to_timestamp('22-12-20 03:55:17.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1056,114,33,to_timestamp('11-12-20 04:53:03.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1108,106,32,to_timestamp('07-08-20 02:31:08.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1183,106,6,to_timestamp('26-02-21 06:38:40.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1159,104,35,to_timestamp('31-03-21 07:29:57.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1007,107,22,to_timestamp('28-12-20 10:17:22.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1000,109,17,to_timestamp('11-07-20 10:53:58.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1143,105,47,to_timestamp('18-09-20 01:28:03.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1127,102,13,to_timestamp('19-01-21 06:28:00.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1160,103,45,to_timestamp('19-11-20 01:27:21.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1096,101,30,to_timestamp('03-01-21 06:49:31.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1057,110,7,to_timestamp('09-04-20 02:37:28.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1014,112,48,to_timestamp('09-05-20 12:51:09.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1013,102,31,to_timestamp('29-07-20 08:35:44.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1175,101,46,to_timestamp('02-04-21 06:31:37.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1121,101,26,to_timestamp('04-01-21 04:55:01.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1198,109,35,to_timestamp('03-12-20 08:24:24.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1167,100,40,to_timestamp('30-07-20 12:19:14.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1066,110,13,to_timestamp('19-04-21 07:31:27.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1000,108,20,to_timestamp('21-07-20 07:18:44.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1070,106,12,to_timestamp('24-01-21 07:46:01.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1108,113,14,to_timestamp('11-06-20 11:52:21.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1009,105,31,to_timestamp('27-12-20 09:38:15.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1033,114,32,to_timestamp('07-01-21 03:28:16.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1136,104,33,to_timestamp('12-04-20 05:51:13.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1198,103,24,to_timestamp('28-10-20 10:57:50.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1188,109,48,to_timestamp('11-03-20 04:11:32.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1096,105,9,to_timestamp('02-02-21 05:22:00.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1086,107,36,to_timestamp('30-04-20 04:46:05.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1004,108,42,to_timestamp('04-10-20 10:39:03.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1061,108,35,to_timestamp('26-01-21 02:05:06.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1093,111,12,to_timestamp('05-04-20 12:24:29.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1110,112,38,to_timestamp('04-04-21 01:06:25.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1142,103,40,to_timestamp('11-12-20 06:03:05.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1182,101,46,to_timestamp('06-08-20 12:03:58.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1053,105,47,to_timestamp('10-07-20 09:30:37.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1151,105,14,to_timestamp('06-07-20 03:27:13.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1044,114,34,to_timestamp('11-03-20 08:29:52.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1028,103,22,to_timestamp('09-05-20 12:03:04.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1082,108,13,to_timestamp('25-12-20 02:41:34.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1059,107,45,to_timestamp('24-09-20 08:13:04.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1119,103,10,to_timestamp('13-07-20 07:04:25.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1032,107,50,to_timestamp('24-12-20 03:14:26.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1090,107,46,to_timestamp('19-02-21 08:59:16.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1073,108,24,to_timestamp('25-02-21 08:59:35.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1196,112,37,to_timestamp('31-12-20 12:58:32.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1055,107,27,to_timestamp('22-09-20 01:37:25.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1145,105,26,to_timestamp('08-03-21 03:37:23.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1041,113,20,to_timestamp('15-08-20 06:47:49.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1040,107,10,to_timestamp('11-04-20 02:36:37.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1038,113,29,to_timestamp('08-10-20 01:31:33.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1086,112,18,to_timestamp('22-04-21 07:21:13.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1101,100,30,to_timestamp('07-05-20 01:54:17.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1099,109,11,to_timestamp('04-10-20 11:20:35.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1155,108,42,to_timestamp('07-04-21 08:29:54.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1032,113,13,to_timestamp('22-07-20 09:03:10.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1110,114,45,to_timestamp('15-12-20 08:33:40.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1137,102,6,to_timestamp('30-06-20 11:10:19.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1073,112,11,to_timestamp('18-09-20 08:54:38.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1039,109,42,to_timestamp('22-01-21 03:19:08.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1115,100,21,to_timestamp('13-08-20 09:01:28.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1177,107,9,to_timestamp('10-05-20 01:31:37.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1066,100,49,to_timestamp('07-12-20 03:38:33.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1041,103,37,to_timestamp('28-06-20 02:24:55.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1128,100,26,to_timestamp('20-11-20 02:19:41.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1172,107,23,to_timestamp('04-06-20 03:28:59.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1161,110,37,to_timestamp('19-11-20 02:53:36.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1093,112,19,to_timestamp('15-10-20 01:40:33.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1161,108,48,to_timestamp('15-05-20 01:53:36.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1108,106,28,to_timestamp('01-07-20 12:02:41.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1114,113,12,to_timestamp('19-01-21 10:58:47.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1145,111,24,to_timestamp('21-04-21 08:34:42.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1048,103,17,to_timestamp('22-04-21 07:21:11.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1078,113,16,to_timestamp('13-10-20 03:56:32.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1158,100,9,to_timestamp('15-05-20 03:13:08.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1080,107,15,to_timestamp('06-11-20 09:51:34.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1039,107,16,to_timestamp('23-04-20 04:35:10.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1198,105,38,to_timestamp('28-05-20 05:14:58.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1001,107,31,to_timestamp('18-03-21 07:09:48.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1183,106,6,to_timestamp('16-11-20 08:59:26.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1117,112,37,to_timestamp('03-01-21 07:56:39.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1187,106,18,to_timestamp('29-04-20 10:28:30.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1050,111,34,to_timestamp('10-01-21 10:17:19.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1121,114,23,to_timestamp('04-01-21 10:18:16.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1122,107,50,to_timestamp('16-06-20 09:42:54.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1196,104,38,to_timestamp('30-08-20 02:36:57.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1058,114,43,to_timestamp('07-05-20 03:21:31.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1164,114,19,to_timestamp('18-02-21 10:27:11.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1079,103,50,to_timestamp('03-07-20 01:43:28.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1027,109,13,to_timestamp('07-04-20 04:50:49.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1192,114,21,to_timestamp('20-03-20 08:44:36.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1121,112,22,to_timestamp('18-05-20 05:57:41.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1152,101,33,to_timestamp('23-11-20 07:01:59.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1068,106,20,to_timestamp('24-10-20 10:11:18.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1099,111,39,to_timestamp('19-04-20 12:05:37.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1102,113,25,to_timestamp('24-11-20 07:05:43.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1074,105,9,to_timestamp('21-10-20 12:29:30.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1035,103,14,to_timestamp('13-03-20 03:21:22.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1008,111,23,to_timestamp('17-12-20 08:12:07.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1183,112,24,to_timestamp('21-07-20 07:29:20.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1051,104,40,to_timestamp('27-03-21 08:27:38.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1188,100,46,to_timestamp('15-09-20 10:07:14.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1025,108,48,to_timestamp('06-02-21 02:07:33.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1101,102,31,to_timestamp('28-07-20 03:34:30.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1075,103,41,to_timestamp('03-12-20 12:40:29.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1109,105,24,to_timestamp('29-04-21 09:55:43.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1155,107,44,to_timestamp('06-04-21 06:37:50.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1089,104,49,to_timestamp('08-06-20 03:11:37.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1027,102,19,to_timestamp('13-12-20 09:16:02.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1081,101,40,to_timestamp('06-02-21 12:03:52.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1198,101,41,to_timestamp('06-12-20 03:13:29.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1015,101,23,to_timestamp('11-03-21 09:23:18.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1011,104,34,to_timestamp('15-03-21 05:57:25.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1145,112,12,to_timestamp('09-03-20 02:29:56.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1171,102,10,to_timestamp('11-08-20 03:43:17.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1189,101,43,to_timestamp('30-05-20 02:12:10.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1141,103,36,to_timestamp('06-04-20 06:05:46.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1099,110,11,to_timestamp('20-06-20 10:36:32.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1032,102,8,to_timestamp('26-04-20 02:43:20.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1071,102,50,to_timestamp('12-06-20 12:57:20.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1123,103,44,to_timestamp('28-07-20 07:47:57.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1142,103,32,to_timestamp('08-05-20 12:58:04.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1087,108,13,to_timestamp('15-02-21 06:55:10.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1116,101,11,to_timestamp('11-10-20 08:43:53.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1118,112,41,to_timestamp('09-03-21 04:11:06.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1037,101,20,to_timestamp('26-04-21 10:09:06.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1112,114,29,to_timestamp('19-12-20 04:06:57.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1093,113,15,to_timestamp('03-02-21 12:19:48.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1186,113,44,to_timestamp('11-03-20 05:16:59.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1161,112,49,to_timestamp('02-10-20 10:26:46.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1137,106,10,to_timestamp('10-06-20 09:20:01.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1199,110,35,to_timestamp('17-12-20 05:08:16.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1048,103,44,to_timestamp('25-04-21 04:19:12.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1185,103,27,to_timestamp('07-12-20 06:50:58.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1194,110,32,to_timestamp('06-04-21 10:10:15.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1031,108,26,to_timestamp('01-12-20 03:15:52.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1065,105,6,to_timestamp('24-01-21 10:09:14.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1000,105,41,to_timestamp('17-06-20 01:24:36.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1158,104,27,to_timestamp('11-02-21 12:19:51.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1076,108,32,to_timestamp('11-04-21 12:31:19.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1067,112,50,to_timestamp('12-12-20 12:34:59.000000000 PM','DD-MM-RR HH12:MI:SSXFF AM'));
INSERT.add_checkout_log(1133,104,15,to_timestamp('06-02-21 02:45:38.000000000 AM','DD-MM-RR HH12:MI:SSXFF AM'));
END;
/
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


-------View Creation------

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


CREATE or replace VIEW CATCHQTY
AS
SELECT A.FM_ID,A.FIRST_NAME||''||A.lAST_NAME AS FISHERMAN_NAME,b.booking_id,c.checkin_id,sum(d.catch_qty) as Total_Catches
FROM fisherman A
INNER JOIN bookings B ON A.FM_ID=B.FM_ID
INNER JOIN checkin_log C ON b.booking_id=c.booking_id
INNER JOIN checkout_log D ON d.checkin_id=c.checkin_id
group by a.fm_id,a.first_name, a.last_name, b.booking_id, c.checkin_id
order by a.fm_id;


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
order by i.last_feed_date;

CREATE OR REPLACE VIEW populor_fish
AS
SELECT a.species_name,sum(c.catch_qty)as Total_Catches
FROM fish_species A
INNER JOIN fish_stats B ON a.fish_id=b.fish_id
INNER JOIN checkout_log C ON b.fish_inv_id=C.fish_inv_id
GROUP BY a.species_name
ORDER BY Total_Catches desc
;

