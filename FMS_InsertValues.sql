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

CREATE OR REPLACE PROCEDURE ADD_FISHERMAN(pi_fm_id NUMBER, pi_fname VARCHAR2 , pi_lname VARCHAR2, pi_age NUMBER, pi_gender VARCHAR2, pi_exp NUMBER, pi_mob VARCHAR2, pi_email VARCHAR2)
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
        
END ADD_FISHERMAN;
/
CREATE OR REPLACE PROCEDURE ADD_FISHERMAN_DETAILS(pi_fm_id NUMBER, pi_addr1 VARCHAR2 , pi_addr2 VARCHAR2, pi_city VARCHAR2, pi_state VARCHAR2, pi_zip VARCHAR2)
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
END ADD_FISHERMAN_DETAILS;
/

CREATE OR REPLACE PROCEDURE ADD_FISH_SPECIES(pi_FISH_ID NUMBER, pi_SPECIES_NAME VARCHAR2, pi_AVG_LENGTH FLOAT, pi_AVG_WEIGHTD FLOAT )
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
        
END ADD_FISH_SPECIES;
/

CREATE OR REPLACE PROCEDURE ADD_BOOKINGS(pi_BOOKING_ID NUMBER, pi_FM_ID NUMBER, pi_SLOT_ID NUMBER, pi_BOOKING_TIME TIMESTAMP, pi_BOOK_STATUS VARCHAR2)
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
        
END ADD_BOOKINGS;
/
CREATE OR REPLACE PROCEDURE ADD_slots(pi_SLOT_ID NUMBER, pi_DAY_OF_WEEK VARCHAR2, pi_SLOT_TIME TIMESTAMP, pi_SLOT_COUNT NUMBER, pi_SUBLOC_ID NUMBER)
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
        
END ADD_slots;
/
CREATE OR REPLACE PROCEDURE ADD_SUB_LOCATION(pi_SUBLOC_ID NUMBER, pi_SUBLOC_NAME VARCHAR2, pi_LOC_ID NUMBER)
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
        
END ADD_SUB_LOCATION;

-------------------------- INSERT VALUES ----------------------------
set serveroutput on;
BEGIN
add_fisherman(1,'Jamal','Jordan',39,'M',0,'(876) 905-1186','sit.amet.ornare@seddictum.ca');
add_fisherman(2,'Dean','Bradley',46,'M',3,'(774) 350-3917','erat.Vivamus@ac.net');
add_fisherman(3,'Stewart','Jennings',22,'M',4,'(311) 842-7249','Phasellus.libero.mauris@aodiosemper.net');
add_fisherman(4,'Colton','Harmon',47,'M',10,'(651) 432-4437','urna@mollisnoncursus.co.uk');
add_fisherman(5,'Dustin','Gilliam',24,'M',8,'(159) 929-9461','sed.orci.lobortis@dolorelitpellentesque.co.uk');
add_fisherman(6,'Blake','Mcmillan',44,'M',10,'(982) 985-1394','enim.diam@hendrerit.edu');
add_fisherman(7,'William','Walls',24,'M',6,'(147) 275-1237','tellus.lorem@pede.org');
add_fisherman(8,'Jacob','Pennington',26,'M',1,'(518) 682-2587','dictum.eleifend@quis.ca');
add_fisherman(9,'Rahim','Giles',48,'M',4,'(950) 467-4678','ultricies.ligula@convallisante.net');
add_fisherman(10,'Neil','Barnes',44,'M',1,'(478) 103-8074','sagittis.Nullam.vitae@imperdietullamcorper.net');
add_fisherman(11,'Hamish','England',33,'M',1,'(167) 905-0897','lorem@Integervitae.org');
add_fisherman(12,'Deacon','Lane',49,'M',10,'(957) 337-8342','et.rutrum@euturpisNulla.org');
add_fisherman(13,'Berk','Hood',56,'M',3,'(104) 814-5113','sapien@mauriselit.net');
add_fisherman(14,'Colorado','Meadows',29,'M',3,'(267) 809-2575','Maecenas@vehicularisusNulla.ca');
add_fisherman(15,'Sebastian','Vincent',23,'M',4,'(337) 521-1958','justo.nec@nequeNullamnisl.com');
add_fisherman(16,'Stone','Cannon',51,'M',7,'(299) 543-0417','ligula.tortor.dictum@velit.edu');
add_fisherman(17,'Tanner','Alvarado',30,'M',0,'(550) 261-9993','imperdiet.non@Quisquepurus.com');
add_fisherman(18,'Jacob','Harrell',31,'M',5,'(339) 542-7587','dictum.mi.ac@orci.org');
add_fisherman(19,'Brennan','Carr',28,'M',5,'(978) 770-3559','ante.Nunc.mauris@sem.org');
add_fisherman(20,'Owen','Kaufman',47,'M',9,'(899) 814-0914','urna.Ut@anteipsumprimis.net');
add_fisherman(21,'Yuli','Irwin',37,'M',8,'(492) 579-0777','Donec@Morbiquisurna.net');
add_fisherman(22,'Fritz','Bates',35,'M',3,'(298) 396-3682','pede@rhoncusidmollis.ca');
add_fisherman(23,'Anthony','Sanders',59,'M',1,'(957) 889-2240','auctor.quis.tristique@sociis.co.uk');
add_fisherman(24,'Jermaine','Shaw',54,'M',6,'(128) 632-8506','aliquet.vel@Lorem.org');
add_fisherman(25,'Raja','Klein',36,'M',3,'(461) 888-6999','a.sollicitudin.orci@velit.co.uk');
add_fisherman(26,'Damon','Ewing',21,'M',7,'(754) 360-9578','egestas.Sed@vulputatedui.org');
add_fisherman(27,'Mason','Noble',57,'M',7,'(419) 404-3738','scelerisque@magnaa.org');
add_fisherman(28,'Rigel','Ellison',59,'M',6,'(715) 788-3177','urna.Ut.tincidunt@sagittislobortis.org');
add_fisherman(29,'Dexter','Carson',54,'M',0,'(534) 517-0464','tellus@diamatpretium.co.uk');
add_fisherman(30,'Micah','Lucas',41,'M',5,'(697) 352-6422','a.malesuada.id@Cumsociis.org');
add_fisherman(31,'Donovan','Byers',28,'M',2,'(745) 264-9564','Pellentesque.habitant@Phasellusfermentum.com');
add_fisherman(32,'Thaddeus','Kemp',52,'M',9,'(289) 302-9778','Suspendisse@ultricies.ca');
add_fisherman(33,'Kevin','Deleon',60,'M',9,'(703) 358-2232','nec.diam@egestasa.edu');
add_fisherman(34,'Brian','Hewitt',33,'M',9,'(320) 146-2627','aliquet@idblanditat.edu');
add_fisherman(35,'Chancellor','Compton',42,'M',9,'(327) 838-6973','placerat.eget@tellusfaucibusleo.edu');
add_fisherman(36,'Basil','Davidson',35,'M',10,'(525) 925-7009','lacinia.Sed.congue@magnaDuisdignissim.net');
add_fisherman(37,'Amos','Powell',44,'M',6,'(484) 294-7047','ut.mi@Mauris.org');
add_fisherman(38,'Josiah','Kim',45,'M',0,'(163) 286-6101','velit@suscipit.ca');
add_fisherman(39,'Ali','Swanson',57,'M',5,'(707) 233-5004','neque.tellus@luctusCurabituregestas.net');
add_fisherman(40,'Jelani','Owen',44,'M',4,'(476) 141-0930','Donec.est.mauris@eratvolutpat.co.uk');
add_fisherman(41,'Curran','Gonzales',55,'M',4,'(948) 606-1912','Vestibulum@euismod.ca');
add_fisherman(42,'Bernard','Holcomb',33,'M',8,'(643) 417-5448','Cum.sociis.natoque@nonegestas.org');
add_fisherman(43,'Chester','Ramsey',52,'M',8,'(755) 421-5402','erat.semper@eu.ca');
add_fisherman(44,'Beck','Avila',29,'M',8,'(481) 733-2720','Class@enim.edu');
add_fisherman(45,'Isaiah','Kane',24,'M',9,'(357) 245-2497','hendrerit.Donec.porttitor@seddictumeleifend.edu');
add_fisherman(46,'Forrest','Gill',54,'M',3,'(638) 376-1407','tincidunt.Donec.vitae@temporbibendumDonec.org');
add_fisherman(47,'Channing','Mccarthy',33,'M',0,'(185) 982-6800','iaculis@metusIn.net');
add_fisherman(48,'Gareth','Weiss',33,'M',5,'(953) 628-8169','per@feugiatplaceratvelit.org');
add_fisherman(49,'Alec','Martinez',33,'M',9,'(164) 845-1929','et@eutellus.net');
add_fisherman(50,'Carlos','Cross',51,'M',4,'(686) 892-8236','lorem.luctus.ut@mattissemper.org');
add_fisherman(51,'Preston','Puckett',38,'M',8,'(121) 510-6742','luctus.ipsum@amet.edu');
add_fisherman(52,'Todd','Mercer',36,'M',7,'(417) 182-3434','dictum@aliquetsemut.org');
add_fisherman(53,'Jin','Nolan',35,'M',8,'(968) 342-5144','magna.Duis@Aliquam.ca');
add_fisherman(54,'Mannix','Mullen',33,'M',5,'(989) 458-0887','ac@diamSed.net');
add_fisherman(55,'Orson','Anderson',56,'M',6,'(104) 923-9246','diam@rutrumurnanec.co.uk');
add_fisherman(56,'Travis','Small',37,'M',10,'(111) 313-7503','egestas.blandit@augueporttitor.co.uk');
add_fisherman(57,'Gareth','Wyatt',33,'M',5,'(660) 665-2500','molestie.sodales@velit.net');
add_fisherman(58,'Amery','Landry',37,'M',4,'(693) 488-5929','bibendum@Nunc.ca');
add_fisherman(59,'Eagan','Patel',53,'M',7,'(281) 213-2396','malesuada.vel@lacusAliquam.ca');
add_fisherman(60,'Quinn','Sexton',41,'M',5,'(558) 354-2427','mus.Aenean@egettinciduntdui.co.uk');
add_fisherman(61,'Oleg','Boone',57,'M',6,'(681) 898-8972','Aliquam.erat.volutpat@sed.com');
add_fisherman(62,'Barrett','Howe',34,'M',8,'(231) 921-2885','ut.quam.vel@imperdietnonvestibulum.co.uk');
add_fisherman(63,'Kane','Blankenship',33,'M',1,'(418) 878-1694','ante@arcu.co.uk');
add_fisherman(64,'Brendan','Peters',53,'M',3,'(484) 883-7170','ornare@egestas.org');
add_fisherman(65,'Elton','Henry',32,'M',9,'(519) 827-5877','cursus.et@eteros.edu');
add_fisherman(66,'Cedric','Roy',57,'M',6,'(308) 802-9902','neque@massaIntegervitae.edu');
add_fisherman(67,'Jelani','Christensen',52,'M',6,'(472) 577-5230','aliquet@necmauris.net');
add_fisherman(68,'Cody','Moses',32,'M',2,'(575) 152-4071','eu.tellus@Nullamscelerisqueneque.org');
add_fisherman(69,'Hasad','Mcdaniel',60,'M',4,'(623) 935-9359','Donec@ut.edu');
add_fisherman(70,'Carson','Doyle',37,'M',10,'(859) 567-2170','Sed.nunc.est@euismod.co.uk');
add_fisherman(71,'Porter','Winters',60,'M',4,'(307) 191-0943','Nulla.tempor@metus.com');
add_fisherman(72,'Tobias','Chan',23,'M',9,'(715) 692-8942','nunc.Quisque@urna.com');
add_fisherman(73,'Warren','Bass',53,'M',7,'(788) 740-4435','Class.aptent.taciti@enim.com');
add_fisherman(74,'Raphael','English',59,'M',0,'(453) 569-3679','nunc.id.enim@erosProinultrices.com');
add_fisherman(75,'Chaim','Young',35,'M',8,'(170) 796-0848','turpis.Nulla.aliquet@non.org');
add_fisherman(76,'Dylan','Whitley',41,'M',1,'(769) 955-5229','vestibulum.massa.rutrum@Nulla.co.uk');
add_fisherman(77,'Brett','Terry',29,'M',8,'(449) 191-8635','libero@aaliquetvel.edu');
add_fisherman(78,'Yuli','Atkins',50,'M',10,'(918) 799-3166','pellentesque.a.facilisis@venenatisa.net');
add_fisherman(79,'Gray','Pittman',53,'M',6,'(613) 299-2461','diam@tristiquepellentesquetellus.edu');
add_fisherman(80,'Ahmed','Simon',45,'M',3,'(926) 616-3101','porttitor.eros@sapien.net');
add_fisherman(81,'Declan','Snow',39,'M',4,'(981) 556-0820','sit.amet.nulla@Fusce.net');
add_fisherman(82,'Mannix','Hobbs',52,'M',9,'(729) 866-7692','eu@Curabituregestas.com');
add_fisherman(83,'Norman','Hicks',25,'M',2,'(412) 352-9273','elit@temporarcu.org');
add_fisherman(84,'Gil','Brady',37,'M',2,'(206) 600-4745','iaculis.odio@rutrum.net');
add_fisherman(85,'Harper','Mcgowan',21,'M',7,'(449) 606-8127','adipiscing@molestie.edu');
add_fisherman(86,'Travis','Wyatt',40,'M',0,'(313) 216-3316','volutpat@magnisdis.com');
add_fisherman(87,'Phelan','Morris',28,'M',4,'(449) 208-1310','Praesent.interdum.ligula@sagittisaugue.ca');
add_fisherman(88,'Norman','Robertson',46,'M',9,'(783) 572-6915','mi.eleifend.egestas@egestashendrerit.org');
add_fisherman(89,'Michael','Burgess',59,'M',4,'(921) 223-0680','penatibus@Donectemporest.com');
add_fisherman(90,'Phelan','Spence',22,'M',1,'(566) 545-3632','fermentum.arcu@odio.ca');
add_fisherman(91,'Alan','Peck',52,'M',7,'(651) 461-3655','eleifend.nec@Donecatarcu.edu');
add_fisherman(92,'Kibo','Burks',21,'M',1,'(314) 918-5144','et@aptenttacitisociosqu.org');
add_fisherman(93,'Basil','Pierce',53,'M',4,'(523) 664-3120','congue@laciniamattis.edu');
add_fisherman(94,'Raymond','Cochran',49,'M',10,'(535) 978-8753','eget.varius.ultrices@loremlorem.com');
add_fisherman(95,'Wang','Levine',28,'M',10,'(144) 242-4836','mi@ornareliberoat.ca');
add_fisherman(96,'Timothy','Odom',40,'M',4,'(775) 349-2465','magna.Lorem.ipsum@dignissim.com');
add_fisherman(97,'Grady','Harrington',22,'M',1,'(908) 141-5974','nunc@amet.net');
add_fisherman(98,'Carter','Sargent',51,'M',8,'(607) 371-8013','metus@gravidamaurisut.com');
add_fisherman(99,'Ian','Page',57,'M',1,'(122) 908-8307','eros.Proin@infaucibusorci.net');
add_fisherman(100,'Mannix','Jacobson',58,'M',3,'(948) 667-7668','urna.justo@urnaVivamus.org');
add_fisherman(101,'Yuri','Montoya',42,'F',8,'(700) 616-2489','lacus@laoreet.co.uk');
add_fisherman(102,'Ivy','Mack',59,'F',10,'(646) 392-8214','egestas@penatibuset.ca');
add_fisherman(103,'Indira','Hoover',45,'F',1,'(144) 126-2052','ridiculus.mus.Donec@dictum.com');
add_fisherman(104,'Mira','Anderson',37,'F',8,'(904) 390-1849','ipsum.primis@habitant.ca');
add_fisherman(105,'Chloe','Garrison',42,'F',6,'(781) 112-2383','Aliquam@euarcu.edu');
add_fisherman(106,'Jana','Thompson',27,'F',2,'(919) 603-0250','Nunc.pulvinar.arcu@Nullam.edu');
add_fisherman(107,'Chiquita','Irwin',41,'F',7,'(568) 360-5202','ac.facilisis@malesuadavel.com');
add_fisherman(108,'Ursula','Navarro',49,'F',6,'(723) 846-1027','sociis@magnaPraesent.com');
add_fisherman(109,'Chelsea','Norris',31,'F',0,'(725) 164-6132','hendrerit.neque@eunibh.org');
add_fisherman(110,'Shannon','Miller',46,'F',6,'(931) 112-8307','ultrices@egetipsumSuspendisse.org');
add_fisherman(111,'Alea','Gamble',31,'F',5,'(337) 499-3216','amet.diam.eu@sed.co.uk');
add_fisherman(112,'Cathleen','Fuentes',49,'F',5,'(404) 523-1121','eu@aliquet.net');
add_fisherman(113,'Ramona','Wood',40,'F',1,'(873) 296-5685','purus@Phasellus.ca');
add_fisherman(114,'Reagan','Fischer',25,'F',7,'(831) 958-9881','Phasellus.dolor@etlibero.net');
add_fisherman(115,'Yolanda','Stanton',31,'F',9,'(768) 645-5009','id.erat.Etiam@sitametmassa.ca');
add_fisherman(116,'Molly','Livingston',22,'F',10,'(140) 465-9891','sed@tincidunttempusrisus.com');
add_fisherman(117,'Joan','Melendez',21,'F',8,'(602) 288-3567','ornare.facilisis.eget@Nulla.org');
add_fisherman(118,'Kylee','Boyle',22,'F',8,'(326) 889-2256','egestas.rhoncus.Proin@MaurismagnaDuis.edu');
add_fisherman(119,'Kirestin','Phelps',25,'F',3,'(654) 639-1674','Proin.nisl.sem@Suspendisse.net');
add_fisherman(120,'Adrienne','Malone',55,'F',0,'(876) 678-4987','enim@sedliberoProin.co.uk');
add_fisherman(121,'Kirby','Joseph',37,'F',10,'(421) 110-2111','Suspendisse.eleifend@nonummyultricies.edu');
add_fisherman(122,'Nina','Lynch',49,'F',9,'(650) 752-1330','Aliquam.ornare@sagittisNullam.co.uk');
add_fisherman(123,'Kelsie','Ferguson',29,'F',9,'(796) 176-1785','mi@odio.edu');
add_fisherman(124,'Stacy','Richard',52,'F',3,'(364) 110-3332','ut.dolor@sapien.org');
add_fisherman(125,'Medge','Daugherty',30,'F',3,'(957) 404-6955','In.at@liberoest.co.uk');
add_fisherman(126,'Emily','Avila',26,'F',6,'(925) 867-9646','nibh@nislsem.co.uk');
add_fisherman(127,'Laura','Shaffer',39,'F',4,'(448) 376-7788','Aenean.eget.magna@Nam.com');
add_fisherman(128,'Gwendolyn','Calhoun',59,'F',3,'(674) 231-7194','sem.Nulla.interdum@ornare.edu');
add_fisherman(129,'Jessica','Livingston',60,'F',3,'(729) 284-9273','quis.diam.luctus@neque.ca');
add_fisherman(130,'Grace','Rivera',54,'F',7,'(386) 353-8198','quis.massa.Mauris@Nulla.net');
add_fisherman(131,'Ainsley','Simpson',32,'F',4,'(864) 962-6476','Suspendisse.aliquet.sem@dignissimpharetra.ca');
add_fisherman(132,'Pandora','Valenzuela',55,'F',9,'(188) 999-4576','Pellentesque.habitant.morbi@inconsectetuer.edu');
add_fisherman(133,'Hayley','Mcknight',58,'F',0,'(727) 255-7194','urna@aliquetmolestietellus.co.uk');
add_fisherman(134,'Maggy','Bell',45,'F',10,'(338) 703-7264','porttitor.eros.nec@Proinnislsem.org');
add_fisherman(135,'Michelle','Juarez',42,'F',9,'(679) 871-8737','Sed@sedpede.edu');
add_fisherman(136,'Brianna','Patterson',35,'F',6,'(109) 990-4700','Nam@utdolor.com');
add_fisherman(137,'Yvonne','Holland',60,'F',10,'(884) 382-0173','primis.in.faucibus@nostra.com');
add_fisherman(138,'Jaime','Sparks',59,'F',6,'(527) 478-6822','ridiculus.mus@luctusut.net');
add_fisherman(139,'Lunea','Small',29,'F',5,'(126) 921-0682','sagittis.felis.Donec@lobortisClass.ca');
add_fisherman(140,'Ora','Stout',48,'F',1,'(157) 497-4270','Nam.interdum.enim@litoratorquentper.co.uk');
add_fisherman(141,'Maisie','Trevino',24,'F',4,'(938) 833-7022','velit@perconubianostra.org');
add_fisherman(142,'Judith','Keller',31,'F',3,'(729) 229-3378','In.condimentum@risus.co.uk');
add_fisherman(143,'Xantha','Bentley',23,'F',9,'(888) 961-9083','dolor.nonummy@elementum.org');
add_fisherman(144,'Ina','Bullock',34,'F',10,'(545) 877-3604','sit.amet@condimentum.co.uk');
add_fisherman(145,'Ella','Peck',29,'F',3,'(545) 195-5054','consequat@sit.edu');
add_fisherman(146,'Grace','Craft',46,'F',6,'(393) 166-4599','dui.Fusce@litoratorquentper.ca');
add_fisherman(147,'Nina','Smith',48,'F',5,'(798) 986-7674','egestas@nibhAliquamornare.net');
add_fisherman(148,'Carissa','Delgado',52,'F',2,'(497) 160-1669','pede.blandit.congue@ornare.edu');
add_fisherman(149,'Willa','Clark',29,'F',7,'(347) 966-4106','Nunc.mauris.elit@sed.co.uk');
add_fisherman(150,'Brenna','Dyer',52,'F',0,'(693) 158-0749','adipiscing.enim.mi@mi.co.uk');
add_fisherman(151,'Nita','Cook',21,'F',5,'(986) 720-0765','rutrum.magna@dapibusrutrum.edu');
add_fisherman(152,'Rowan','Walsh',26,'F',9,'(664) 780-2617','Fusce.fermentum@Duis.com');
add_fisherman(153,'Rina','Atkinson',53,'F',9,'(391) 597-3659','enim@sociisnatoquepenatibus.com');
add_fisherman(154,'Melodie','Warner',27,'F',4,'(420) 762-5427','Fusce.diam@aliquetsem.co.uk');
add_fisherman(155,'Isadora','Guthrie',22,'F',1,'(404) 134-6993','Mauris.quis@ipsumportaelit.ca');
add_fisherman(156,'Charissa','May',31,'F',1,'(199) 428-5239','Phasellus.dapibus.quam@tincidunt.ca');
add_fisherman(157,'May','Gray',55,'F',1,'(244) 181-6897','convallis.erat.eget@lacinia.org');
add_fisherman(158,'Remedios','Massey',42,'F',3,'(897) 598-6643','elit.erat.vitae@leoVivamusnibh.net');
add_fisherman(159,'Zelenia','Hartman',54,'F',4,'(827) 876-4017','augue@afacilisis.com');
add_fisherman(160,'Xaviera','Oneal',35,'F',9,'(485) 987-2385','mattis@lectusNullam.ca');
add_fisherman(161,'Mara','Wooten',54,'F',10,'(211) 227-6989','Maecenas.malesuada@magna.net');
add_fisherman(162,'Flavia','Kerr',22,'F',2,'(485) 972-7115','dictum@cursus.org');
add_fisherman(163,'Ivy','George',47,'F',6,'(927) 355-6602','turpis.non.enim@mollislectus.com');
add_fisherman(164,'Quintessa','Molina',44,'F',7,'(134) 482-2584','vel@quispede.edu');
add_fisherman(165,'Denise','Hammond',39,'F',8,'(664) 436-7360','Cras.lorem.lorem@scelerisque.ca');
add_fisherman(166,'Rhonda','Bush',30,'F',9,'(910) 621-2963','Ut@lacus.com');
add_fisherman(167,'Pearl','Barnes',48,'F',0,'(764) 174-2296','faucibus.orci@etrutrumeu.org');
add_fisherman(168,'Azalia','Todd',53,'F',6,'(978) 388-8444','ornare@sodalesnisi.net');
add_fisherman(169,'Alexa','Mcpherson',49,'F',6,'(190) 507-0077','dui.nec.tempus@a.com');
add_fisherman(170,'Audra','Strickland',46,'F',5,'(772) 168-0213','montes.nascetur.ridiculus@faucibus.net');
add_fisherman(171,'Veda','Petty',22,'F',6,'(408) 661-3742','lorem@lobortisrisusIn.ca');
add_fisherman(172,'Blythe','Collier',42,'F',3,'(489) 548-7831','lorem.ac.risus@risusMorbimetus.net');
add_fisherman(173,'Dacey','Thomas',36,'F',6,'(366) 676-5176','a.malesuada@fermentum.ca');
add_fisherman(174,'Tatyana','Moore',51,'F',1,'(344) 780-8014','a@sed.net');
add_fisherman(175,'Kelsie','Harper',28,'F',10,'(315) 208-5000','quis.turpis@sit.edu');
add_fisherman(176,'Hanae','Wright',51,'F',9,'(868) 267-5732','Nullam.nisl@mipedenonummy.org');
add_fisherman(177,'Kellie','Kim',52,'F',8,'(222) 201-1056','interdum.feugiat@dapibus.com');
add_fisherman(178,'Summer','Reynolds',45,'F',5,'(267) 611-9853','sagittis.Duis.gravida@nonummy.com');
add_fisherman(179,'Ginger','Klein',52,'F',8,'(157) 155-5508','lectus@mollis.org');
add_fisherman(180,'Tara','Harrison',55,'F',5,'(101) 547-7960','eget.tincidunt.dui@tellusSuspendissesed.com');
add_fisherman(181,'Miriam','Reilly',34,'F',3,'(173) 862-9533','neque@tempusrisusDonec.com');
add_fisherman(182,'Yolanda','Wooten',54,'F',2,'(830) 122-1115','lectus.justo@malesuada.edu');
add_fisherman(183,'Hannah','Owens',32,'F',7,'(943) 601-3107','senectus.et.netus@euenimEtiam.net');
add_fisherman(184,'Summer','Chan',60,'F',8,'(137) 926-8321','dis@Donecdignissim.org');
add_fisherman(185,'Indigo','Acosta',41,'F',5,'(169) 215-2402','arcu.Vivamus.sit@Sed.com');
add_fisherman(186,'Jael','Good',54,'F',3,'(392) 599-3840','accumsan.sed@temporestac.org');
add_fisherman(187,'Cynthia','Hurst',51,'F',6,'(595) 334-2504','egestas.Aliquam@magna.ca');
add_fisherman(188,'Irma','Haney',46,'F',2,'(250) 209-9900','fringilla.euismod.enim@ipsum.edu');
add_fisherman(189,'Macy','Rowe',31,'F',1,'(935) 313-2206','eu@metusIn.com');
add_fisherman(190,'Minerva','Holland',25,'F',3,'(628) 181-2190','per@ut.org');
add_fisherman(191,'Athena','Dillon',43,'F',5,'(271) 612-4844','eu@anuncIn.com');
add_fisherman(192,'Abra','Ryan',58,'F',7,'(834) 282-5298','ultricies@ascelerisque.net');
add_fisherman(193,'Aphrodite','Morrison',55,'F',7,'(699) 132-3488','egestas.rhoncus.Proin@Seddiam.net');
add_fisherman(194,'Kameko','Robbins',59,'F',8,'(208) 636-2813','ac@placeratorci.ca');
add_fisherman(195,'Rhonda','Mejia',56,'F',4,'(406) 314-9019','et@at.edu');
add_fisherman(196,'Danielle','Burke',58,'F',10,'(732) 365-2134','erat@gravidaAliquamtincidunt.edu');
add_fisherman(197,'Lacey','Conrad',46,'F',10,'(570) 146-4206','porttitor.eros.nec@vitae.ca');
add_fisherman(198,'Ainsley','Wallace',28,'F',5,'(354) 371-9649','tristique.ac@tempor.co.uk');
add_fisherman(199,'Ursa','Sharpe',58,'F',9,'(509) 180-4669','at@ipsumac.com');
add_fisherman(200,'Kirby','Ochoa',25,'F',5,'(414) 307-7404','est.mollis@mi.co.uk');
END;

BEGIN
add_location(1,'Charles River');
add_location(2,'Quabbin Lake');
add_location(3,'LLMC Fish Pier');
END;    

BEGIN
add_fisherman_details(1,'P.O. Box 205, 7251 Ut Av.','P.O. Box 629, 3397 Ut Rd.','Tucson','Arizona','4893');
add_fisherman_details(2,'P.O. Box 273, 5302 Tincidunt Ave','P.O. Box 977, 1410 Lectus Rd.','Bellary','Karnataka','10748');
add_fisherman_details(3,'239 Adipiscing St.','Ap #910-3187 Semper Rd.','Las Palmas','CN','12284');
add_fisherman_details(4,'Ap #762-7967 Sem Avenue','Ap #289-5902 Mauris Road','Malambo','ATL','19900-657');
add_fisherman_details(5,'P.O. Box 141, 9409 Metus. Av.','6420 Quis St.','Tranent','EL','56543');
add_fisherman_details(6,'688-9213 Accumsan Rd.','141-6067 Aliquam Rd.','Palma de Mallorca','BA','008094');
add_fisherman_details(7,'Ap #295-3515 Odio Ave','7795 Quisque Street','Pasuruan','East Java','85224-461');
add_fisherman_details(8,'P.O. Box 128, 2477 Risus. Street','P.O. Box 531, 4897 Tristique St.','Calle Blancos','SJ','Z7 1BJ');
add_fisherman_details(9,'P.O. Box 328, 6680 Ultricies Street','4666 Sed St.','Rea','Lombardia','36403-001');
add_fisherman_details(10,'Ap #433-1305 Tempus, St.','Ap #505-994 In Rd.','Carson City','Nevada','70400');
add_fisherman_details(11,'568-5400 Sed Ave','497-5903 Tellus Av.','Bremerhaven','HB','60443');
add_fisherman_details(12,'P.O. Box 538, 4845 Senectus Road','6875 Orci. Rd.','Saint-L?onard','Quebec','VV23 2RJ');
add_fisherman_details(13,'Ap #220-4655 Est Street','Ap #294-1868 Quis Rd.','Galway','C','Z1195');
add_fisherman_details(14,'497-8046 Dolor Road','P.O. Box 140, 5144 Sed Rd.','Berlin','BE','7811');
add_fisherman_details(15,'Ap #340-8734 Dolor, Av.','Ap #677-9590 Risus. Rd.','Yaroslavl','Yaroslavl Oblast','89043');
add_fisherman_details(16,'Ap #179-2673 Montes, Road','467-2162 Sit Street','Vienna','Vienna','4288');
add_fisherman_details(17,'P.O. Box 640, 5554 Turpis Ave','122-8075 Cursus St.','Bayswater','Western Australia','519824');
add_fisherman_details(18,'9311 Et Ave','4087 Est Ave','Huesca','AR','641519');
add_fisherman_details(19,'Ap #919-3616 Hendrerit Ave','P.O. Box 400, 9156 Placerat Av.','Orvault','Pays de la Loire','4692');
add_fisherman_details(20,'P.O. Box 406, 2450 Aliquet Road','695-9173 Mattis. Street','Piura','Piura','931332');
add_fisherman_details(21,'P.O. Box 495, 8183 Nec Avenue','719-4397 Euismod Ave','Mulhouse','AL','45951');
add_fisherman_details(22,'Ap #740-1065 Arcu Rd.','P.O. Box 551, 3094 Imperdiet, Road','North Las Vegas','Nevada','15743-309');
add_fisherman_details(23,'3256 A Road','Ap #815-9463 Eu Rd.','Berlin','Berlin','55524');
add_fisherman_details(24,'2787 Phasellus Road','1663 Libero. Street','Chelsea','QC','10708');
add_fisherman_details(25,'Ap #696-9235 Porttitor Ave','P.O. Box 203, 1348 Suscipit St.','Khanewal','Sindh','5688');
add_fisherman_details(26,'Ap #562-5693 Congue Av.','P.O. Box 122, 9715 Ipsum. Street','Dublin','Leinster','31110');
add_fisherman_details(27,'609-5061 In Street','584-9850 Augue Street','Barbania','Piemonte','60603');
add_fisherman_details(28,'789-6840 Sem Road','Ap #952-2209 Porttitor Rd.','Bida','NI','11211');
add_fisherman_details(29,'Ap #225-3938 Fermentum Avenue','3981 Nunc, Street','Savannah','GA','86973');
add_fisherman_details(30,'Ap #963-3388 Proin St.','9218 Ac, Rd.','Magangué','Bolívar','4009');
add_fisherman_details(31,'P.O. Box 373, 4572 Dis St.','596-6431 Inceptos Rd.','Milwaukee','Wisconsin','33055-579');
add_fisherman_details(32,'Ap #236-1760 Justo Av.','Ap #277-2795 Massa. Rd.','Galway','C','3739');
add_fisherman_details(33,'P.O. Box 759, 8648 Lectus St.','1829 Phasellus Avenue','Beauvais','PI','21916');
add_fisherman_details(34,'Ap #692-9160 Varius St.','Ap #141-9999 Lorem Rd.','León','Gto','05599');
add_fisherman_details(35,'Ap #896-9047 Diam Street','P.O. Box 543, 7493 Mauris Rd.','Columbia','MO','5372');
add_fisherman_details(36,'Ap #364-1316 Duis St.','P.O. Box 228, 3469 Luctus St.','Huancayo','JUN','73656-06238');
add_fisherman_details(37,'6287 Accumsan St.','4305 Sed Ave','Stamford','CT','Z8133');
add_fisherman_details(38,'P.O. Box 989, 6662 Vel, Av.','P.O. Box 364, 5948 Fusce St.','Glenrothes','Fife','L1P 7J5');
add_fisherman_details(39,'3042 Lacus. Road','208-435 Tellus Ave','Vladimir','VLA','6916');
add_fisherman_details(40,'P.O. Box 985, 2485 Ultrices Avenue','Ap #356-9094 Sem St.','Berlin','BE','54-159');
add_fisherman_details(41,'1811 Ut Av.','1142 Rutrum, St.','Milwaukee','Wisconsin','45656-57931');
add_fisherman_details(42,'Ap #570-8280 Eu Rd.','858 Suscipit, Street','Bremerhaven','HB','878151');
add_fisherman_details(43,'P.O. Box 877, 8612 A, Av.','Ap #144-4567 Praesent Avenue','Carmen','Cartago','6195 FT');
add_fisherman_details(44,'940-4457 Cras Street','Ap #557-7910 Eros Avenue','Grand Island','NE','839492');
add_fisherman_details(45,'672-5600 Risus. Av.','P.O. Box 158, 6585 Tristique Rd.','Berlin','BE','6387');
add_fisherman_details(46,'P.O. Box 738, 7239 Non Ave','389-1255 Cum Av.','Yurimaguas','Loreto','94513-682');
add_fisherman_details(47,'960-8498 Quam Rd.','Ap #646-9152 A Avenue','Montbéliard','FC','6706 MQ');
add_fisherman_details(48,'Ap #742-6695 Aenean Rd.','P.O. Box 426, 5615 Ligula Rd.','Barranca','Puntarenas','10258');
add_fisherman_details(49,'367-9546 Justo. Avenue','P.O. Box 400, 2389 Maecenas St.','Pyeongtaek','Gye','E03 0YY');
add_fisherman_details(50,'Ap #797-110 Rutrum, St.','P.O. Box 104, 7172 Ligula Rd.','Waiuku','NI','94618');
add_fisherman_details(51,'Ap #354-6105 Eu Road','Ap #928-7426 Condimentum. Rd.','Owerri','Imo','64990');
add_fisherman_details(52,'P.O. Box 391, 7394 Egestas Street','P.O. Box 389, 8876 Nisi Avenue','Tokoroa','NI','21309');
add_fisherman_details(53,'541-9495 Tristique St.','Ap #667-7196 Aliquam Av.','Las Condes','RM','760316');
add_fisherman_details(54,'Ap #145-4313 Donec Rd.','P.O. Box 967, 4159 Nisi. Rd.','Belfast','Ulster','00182-007');
add_fisherman_details(55,'P.O. Box 578, 7557 Justo Street','598-7433 Vitae Ave','Veere','Zeeland','19210-775');
add_fisherman_details(56,'Ap #547-4924 Mi Ave','6431 Tortor St.','Eigenbrakel','WB','1073');
add_fisherman_details(57,'1589 Sodales. Av.','Ap #280-6195 Diam Rd.','Itagüí','Antioquia','Z4556');
add_fisherman_details(58,'6095 Etiam St.','4811 Mauris Rd.','Trevignano Romano','LAZ','0757 GF');
add_fisherman_details(59,'P.O. Box 950, 6856 Cras Street','3894 Mollis Rd.','Sparwood','BC','98944');
add_fisherman_details(60,'788-8274 Amet Rd.','868-3613 Gravida Avenue','Vienna','Wie','10383');
add_fisherman_details(61,'6113 Accumsan Avenue','P.O. Box 245, 7498 Enim. Avenue','Berlin','Berlin','67931');
add_fisherman_details(62,'Ap #985-4439 Semper Av.','3587 Sapien Ave','Zierikzee','Zl','5278 QJ');
add_fisherman_details(63,'413-3782 Nec, Road','P.O. Box 449, 6879 Dolor, Av.','Graneros','VI','61740');
add_fisherman_details(64,'1579 Nec, St.','569-5275 Diam St.','Tczew','Pomorskie','28913');
add_fisherman_details(65,'P.O. Box 844, 5767 Nulla. Ave','P.O. Box 516, 9658 Egestas. Av.','San Carlos','Biobío','04215');
add_fisherman_details(66,'1238 Semper Road','776-580 Convallis Road','Pointe-au-Pic','QC','0272');
add_fisherman_details(67,'P.O. Box 674, 3616 Aenean Av.','465-5551 Magnis Rd.','Chiclayo','LAM','A9V 0N8');
add_fisherman_details(68,'P.O. Box 870, 9676 In Av.','3457 Iaculis St.','Detroit','MI','79958');
add_fisherman_details(69,'Ap #127-1633 Felis Street','Ap #918-3610 Ac St.','Tiltil','Metropolitana de Santiago','618014');
add_fisherman_details(70,'P.O. Box 882, 5186 Eu Rd.','815-230 Ultrices St.','Voronezh','Voronezh Oblast','10705');
add_fisherman_details(71,'Ap #629-8185 Nec Rd.','P.O. Box 137, 5594 Suspendisse Street','Bollnäs','Gävleborgs län','17581');
add_fisherman_details(72,'8344 Nisl St.','913-8236 Pellentesque St.','Calle Blancos','San José','7503');
add_fisherman_details(73,'4293 Maecenas Rd.','984-9034 Aliquam Av.','Gwadar','Balochistan','8773');
add_fisherman_details(74,'P.O. Box 346, 8751 Nascetur Rd.','Ap #349-4087 Urna Av.','Vlissegem','West-Vlaanderen','7606');
add_fisherman_details(75,'4580 Sed Street','8613 Eu Road','Ipís','SJ','52988-98120');
add_fisherman_details(76,'Ap #589-1125 Dictum Rd.','449-5049 Ut Avenue','Galway','Connacht','67-468');
add_fisherman_details(77,'638-9273 Suspendisse Ave','Ap #430-1816 Posuere Rd.','Oaxaca','Oax','810124');
add_fisherman_details(78,'339-9030 Vitae St.','Ap #188-1626 Lorem, Ave','Santander','CA','9560');
add_fisherman_details(79,'Ap #141-6021 Litora Avenue','Ap #105-5035 Consequat Rd.','Cartagena','BOL','232619');
add_fisherman_details(80,'444-1993 Eu, Street','Ap #960-7759 Natoque Road','Cork','M','5474');
add_fisherman_details(81,'535-7048 Orci Street','Ap #906-3184 Arcu. Street','Chitral','Khyber Pakhtoonkhwa','16940');
add_fisherman_details(82,'Ap #445-9114 Eu, Ave','580-1284 Nec Avenue','San Pietro al Tanagro','CAM','01831');
add_fisherman_details(83,'P.O. Box 844, 9088 Ac Rd.','401-8195 Volutpat Road','Minna','NI','8346');
add_fisherman_details(84,'P.O. Box 811, 1480 Nunc Avenue','P.O. Box 114, 5220 Tellus Av.','Ödemi?','?zm','12765-69343');
add_fisherman_details(85,'325-5969 Ut Avenue','1268 Lorem St.','Jundiaí','SP','19427');
add_fisherman_details(86,'5388 Nibh Rd.','2125 Fermentum St.','Bhopal','MP','24348');
add_fisherman_details(87,'Ap #849-7297 Auctor St.','Ap #983-4672 Fermentum St.','Karacabey','Bur','Z7411');
add_fisherman_details(88,'918-4720 Eu Av.','9910 Turpis. Ave','Melton','VIC','08937');
add_fisherman_details(89,'P.O. Box 411, 9478 Fermentum St.','359-553 Ut, St.','Voronezh','Voronezh Oblast','548836');
add_fisherman_details(90,'593-7644 A Rd.','892-7391 Eget Ave','Dokkum','Friesland','WU62 7VY');
add_fisherman_details(91,'Ap #252-596 Ultricies Rd.','Ap #897-9653 Nunc Street','Nashville','TN','14636');
add_fisherman_details(92,'3862 Vitae, Street','2345 Ut, Rd.','Carcassonne','LA','035093');
add_fisherman_details(93,'P.O. Box 891, 7033 Sit Street','7295 Commodo Av.','Little Rock','AK','9187');
add_fisherman_details(94,'616-7618 Ac, Ave','Ap #764-671 Tincidunt Rd.','Haveli','Azad Kashmir','23985');
add_fisherman_details(95,'P.O. Box 598, 6944 Interdum Ave','P.O. Box 292, 9573 Porttitor St.','Erci?','Van','56368');
add_fisherman_details(96,'593-9433 Fusce St.','Ap #700-9759 Nunc St.','Idaho Falls','Idaho','18623');
add_fisherman_details(97,'Ap #491-5104 Sapien. Ave','P.O. Box 703, 3243 Aliquam Road','Lauder','Berwickshire','899519');
add_fisherman_details(98,'544 Adipiscing Rd.','954-8946 Auctor Street','Berlin','BE','51195');
add_fisherman_details(99,'227-9647 Nulla. St.','807-8966 Sed Avenue','Lanark County','Ontario','47273');
add_fisherman_details(100,'194-7172 Neque. Rd.','870-9371 Ullamcorper St.','Alness','RO','67883-53949');
add_fisherman_details(101,'P.O. Box 230, 4460 Ultrices St.','5815 Arcu Rd.','Terneuzen','Zeeland','88498');
add_fisherman_details(102,'4478 Sed Av.','970-2691 Est Ave','Lagos','LA','247531');
add_fisherman_details(103,'Ap #213-7326 Nisl Rd.','2696 Mauris, Avenue','Bia?a Podlaska','LU','52963');
add_fisherman_details(104,'4739 Donec Av.','P.O. Box 867, 4174 Mauris Ave','Columbus','OH','57646');
add_fisherman_details(105,'Ap #967-7250 Elit, St.','Ap #410-7768 Vehicula St.','Cheyenne','Wyoming','50155');
add_fisherman_details(106,'Ap #312-1695 Orci, Ave','231-2189 Mauris St.','Apartadó','Antioquia','25605');
add_fisherman_details(107,'827-7329 Dis Rd.','1474 Litora Ave','Rixensart','WB','9712');
add_fisherman_details(108,'945-5340 Dolor St.','P.O. Box 883, 8547 Nisl. St.','Yeongcheon','Gye','36232');
add_fisherman_details(109,'105-3430 Vehicula. Av.','Ap #583-9027 Sem Av.','Barranca','LIM','3247');
add_fisherman_details(110,'4739 Non, Rd.','945-5532 Enim. Av.','Katsina','Katsina','S1C 4K5');
add_fisherman_details(111,'2809 Ut, Rd.','500-8118 Ut St.','The Hague','Z.','29999');
add_fisherman_details(112,'Ap #513-8658 Sem Rd.','185-2895 Aliquam, Rd.','Bida','NI','28845');
add_fisherman_details(113,'P.O. Box 199, 2678 Donec Rd.','Ap #155-2369 Tellus, Avenue','Port Moody','BC','995218');
add_fisherman_details(114,'527 Per Av.','193-4564 Vehicula Street','Mayerthorpe','Alberta','851484');
add_fisherman_details(115,'2638 Amet Road','Ap #216-1745 Lectus Av.','Murray Bridge','South Australia','58888');
add_fisherman_details(116,'4170 Ligula. St.','641-1809 Eleifend Road','Sapele','Delta','31735');
add_fisherman_details(117,'1924 Eget St.','336-4094 Sem. Av.','Kano','KN','04952');
add_fisherman_details(118,'631-8950 Euismod Rd.','999-3626 Ut Road','Dublin','Leinster','951186');
add_fisherman_details(119,'8790 Nunc Street','3466 Ipsum. St.','Belfast','U','4891');
add_fisherman_details(120,'9762 Fames Rd.','411-5062 Ornare, St.','Upplands Väsby','Stockholms län','409729');
add_fisherman_details(121,'9115 Orci Road','7256 Morbi Road','Bello','ANT','11510');
add_fisherman_details(122,'441-218 Amet, Rd.','Ap #988-2583 Morbi Avenue','Gold Coast','QLD','484536');
add_fisherman_details(123,'Ap #184-8213 Justo Avenue','401-2318 Nisi Av.','Nasirabad','Balochistan','61294');
add_fisherman_details(124,'8937 Cubilia Av.','7569 Mollis Ave','Monclova','Coahuila','51704');
add_fisherman_details(125,'480 Ut Avenue','Ap #284-9007 Metus. St.','Vienna','Wie','67268');
add_fisherman_details(126,'Ap #535-7916 Eu Ave','226-6898 Donec St.','Buner','Khyber Pakhtoonkhwa','7791');
add_fisherman_details(127,'6482 Sed Ave','471-1124 Gravida. Rd.','Istanbul','Istanbul','29-998');
add_fisherman_details(128,'322-3095 Ullamcorper Street','225-4078 Euismod Av.','Saint-Dizier','Champagne-Ardenne','88821');
add_fisherman_details(129,'P.O. Box 691, 7044 Ac Rd.','596-3175 Mauris Road','Daejeon','Chu','235508');
add_fisherman_details(130,'626 Fusce St.','562-9492 Cursus Avenue','Stalowa Wola','PK','71052');
add_fisherman_details(131,'695-5273 Pede Av.','1852 Ligula. Rd.','Tire','?zm','78775');
add_fisherman_details(132,'8966 Vel Av.','2443 Laoreet Av.','Edmundston','NB','70263');
add_fisherman_details(133,'Ap #247-7667 Sem, Ave','Ap #926-5289 Tellus. St.','Southaven','Mississippi','938031');
add_fisherman_details(134,'4805 Congue, Street','7775 Arcu Avenue','Aubagne','Provence-Alpes-Côte d''Azur','294428');
add_fisherman_details(135,'820-8309 Ornare, Ave','6339 Nulla St.','Norfolk County','Ontario','9854');
add_fisherman_details(136,'757-3338 Eu Ave','Ap #975-2901 Orci. Rd.','Magangué','BOL','17645');
add_fisherman_details(137,'P.O. Box 232, 8706 Eros Rd.','1782 Molestie Rd.','Makassar','South Sulawesi','L1H 8J7');
add_fisherman_details(138,'Ap #227-4211 Dis Rd.','P.O. Box 606, 7246 Eget Street','Savannah','GA','60304');
add_fisherman_details(139,'Ap #820-1785 Adipiscing Ave','3429 Lorem St.','Cochamó','X','78940');
add_fisherman_details(140,'Ap #451-8657 Vulputate Ave','P.O. Box 206, 8073 Lobortis Rd.','Hartford','CT','Z5235');
add_fisherman_details(141,'Ap #402-7743 Et Avenue','807-2094 Molestie St.','Vienna','Wie','2424 HX');
add_fisherman_details(142,'383-8490 Dolor. Av.','480 Sollicitudin Av.','Hudiksvall','Gävleborgs län','7817');
add_fisherman_details(143,'4035 Nulla St.','Ap #818-5519 Ac, Rd.','Wroc?aw','Dolno?l?skie','P3R 6E1');
add_fisherman_details(144,'887-9028 Cras Road','8636 Placerat, Ave','Pocheon','Gye','10913');
add_fisherman_details(145,'Ap #793-2284 Arcu. Road','Ap #916-8919 Vitae Avenue','São José','Santa Catarina','343825');
add_fisherman_details(146,'8124 Aenean Rd.','1825 Nibh Rd.','Worksop','NT','09043');
add_fisherman_details(147,'P.O. Box 322, 7789 Libero. Rd.','3192 Adipiscing Street','Tokoroa','North Island','17815');
add_fisherman_details(148,'4232 At Road','Ap #278-4813 Praesent Rd.','Bastia','CO','94212');
add_fisherman_details(149,'Ap #185-1627 Penatibus Road','Ap #800-8114 Egestas Avenue','Uyo','AK','976893');
add_fisherman_details(150,'521-5409 Egestas. Road','587-9599 Nunc Avenue','San Rafael','Alajuela','80297');
add_fisherman_details(151,'761-2629 Tellus. Avenue','6035 Suspendisse St.','Quesada','A','157481');
add_fisherman_details(152,'P.O. Box 946, 4625 Eleifend Rd.','302-5145 Nibh. Street','Habra','West Bengal','50450');
add_fisherman_details(153,'6210 Duis Ave','897-9942 Quisque Street','Honolulu','HI','10621');
add_fisherman_details(154,'P.O. Box 350, 5399 Fringilla Av.','2181 Parturient St.','Termini Imerese','Sicilia','105961');
add_fisherman_details(155,'Ap #201-7983 Pellentesque Ave','Ap #982-9683 Morbi Road','Racine','WI','50-378');
add_fisherman_details(156,'P.O. Box 478, 1456 Ut, Rd.','361-1649 Augue Avenue','Gavorrano','Toscana','33569');
add_fisherman_details(157,'234-458 Cursus. Road','P.O. Box 318, 2985 Nunc Ave','Ranchi','JH','451657');
add_fisherman_details(158,'Ap #289-1993 Mauris St.','Ap #841-6395 Ipsum Rd.','Surendranagar','Gujarat','784654');
add_fisherman_details(159,'173-1837 Fringilla, Av.','2466 Fringilla. Street','Sokoto','SO','10081');
add_fisherman_details(160,'8748 Phasellus Av.','8941 Fusce St.','Warrnambool','VIC','Z5517');
add_fisherman_details(161,'5497 Phasellus Ave','Ap #257-2944 Duis Avenue','Maiduguri','Borno','122215');
add_fisherman_details(162,'Ap #528-6851 Integer Rd.','448-2224 Erat St.','General Lagos','Arica y Parinacota','202061');
add_fisherman_details(163,'P.O. Box 645, 5549 Amet Street','Ap #795-8167 Libero St.','Piagge','MAR','764788');
add_fisherman_details(164,'763-2208 Id, St.','863-9983 Laoreet Rd.','Tewkesbury','GL','P0V 4H1');
add_fisherman_details(165,'800-1884 Adipiscing, Ave','6173 Ipsum. Ave','Launceston','Tasmania','12706');
add_fisherman_details(166,'229-7555 Ut Road','7583 Cras Av.','Itagüí','ANT','76862');
add_fisherman_details(167,'P.O. Box 606, 5016 Imperdiet Rd.','P.O. Box 925, 8528 Quisque St.','Cinco Esquinas','SJ','55-263');
add_fisherman_details(168,'Ap #110-6091 Aliquam Ave','6062 Vel Street','Tillicoultry','Clackmannanshire','99202');
add_fisherman_details(169,'136-3289 At Av.','Ap #793-8973 Donec Av.','Irkutsk','IRK','CY95 2CQ');
add_fisherman_details(170,'7802 Nunc Av.','452-4170 Imperdiet Ave','Saskatoon','Saskatchewan','3175');
add_fisherman_details(171,'Ap #210-4461 Aliquet, St.','Ap #471-1230 Eros St.','Radicofani','Toscana','99583');
add_fisherman_details(172,'8859 Accumsan St.','6700 Facilisis Street','General Escobedo','Nuevo León','33205');
add_fisherman_details(173,'362-6951 Mauris Rd.','Ap #568-6214 Etiam Rd.','Dutse','JI','0742 QK');
add_fisherman_details(174,'Ap #194-1439 Montes, Rd.','Ap #817-3886 Feugiat St.','Wetaskiwin','AB','16-897');
add_fisherman_details(175,'P.O. Box 519, 3286 Quis, Ave','488-3196 Fringilla Road','Semarang','Central Java','23184');
add_fisherman_details(176,'Ap #758-7107 Eros. Road','P.O. Box 786, 5637 Cum Avenue','Belfast','U','659436');
add_fisherman_details(177,'Ap #213-1942 Eu, Rd.','Ap #751-575 Venenatis Rd.','Wageningen','Gl','875692');
add_fisherman_details(178,'P.O. Box 584, 3527 Iaculis Avenue','Ap #983-8208 Et Ave','Orangeville','ON','86629');
add_fisherman_details(179,'Ap #215-3306 Vehicula Road','964-6614 Ipsum St.','Berlin','BE','946524');
add_fisherman_details(180,'559-2051 Vivamus Ave','694-3165 Interdum. St.','Haldia','West Bengal','1072');
add_fisherman_details(181,'Ap #121-6966 Felis Av.','P.O. Box 916, 5794 Magna. Street','Kediri','JI','28877');
add_fisherman_details(182,'4281 Non Avenue','791-9725 Sed Rd.','Strausberg','Brandenburg','15-630');
add_fisherman_details(183,'928-1687 Tellus Rd.','Ap #587-9921 Lobortis. St.','Sokoto','Sokoto','Y1 7HJ');
add_fisherman_details(184,'6317 Nulla Ave','5121 Nunc St.','Smithers','British Columbia','1785');
add_fisherman_details(185,'258-9568 Cursus Ave','Ap #969-2146 Vestibulum Street','Vienna','Vienna','K5V 4Y2');
add_fisherman_details(186,'894-4773 Nulla Avenue','323-9390 Posuere, St.','Berwick-upon-Tweed','NB','12267');
add_fisherman_details(187,'P.O. Box 859, 5111 A, St.','Ap #288-3073 Leo Road','Geelong','VIC','J2E 7QX');
add_fisherman_details(188,'P.O. Box 152, 7952 Nulla. St.','P.O. Box 498, 7314 Nascetur Avenue','Bihar Sharif','Bihar','753985');
add_fisherman_details(189,'Ap #761-8833 Elementum Rd.','3002 Amet St.','Cras-Avernas','Luik','511411');
add_fisherman_details(190,'1119 Nulla Av.','P.O. Box 924, 7184 Sed Street','Houston','BC','V9C 3R6');
add_fisherman_details(191,'Ap #358-9722 Elit Road','Ap #687-7140 Neque. St.','Provo','Utah','904425');
add_fisherman_details(192,'6430 Non Road','1112 Amet, Avenue','Juliaca','PUN','26528');
add_fisherman_details(193,'P.O. Box 292, 2781 Sit Road','Ap #962-7719 A, Ave','Paita','PIU','88-240');
add_fisherman_details(194,'P.O. Box 568, 2167 Nonummy Road','Ap #826-8080 Augue Avenue','Kano','KN','36835-728');
add_fisherman_details(195,'Ap #383-8955 Neque Rd.','888-8960 Imperdiet Street','Marneffe','Luik','130068');
add_fisherman_details(196,'8578 Quis Ave','Ap #511-6811 Fusce Av.','Casnate con Bernate','LOM','46156');
add_fisherman_details(197,'Ap #634-4470 Mauris, Rd.','P.O. Box 805, 5776 Pellentesque Ave','Kenosha','WI','X2C 5T5');
add_fisherman_details(198,'661-5192 Nibh. St.','9843 Tristique Avenue','Bhakkar','Punjab','65839');
add_fisherman_details(199,'397-4275 At Street','P.O. Box 112, 4571 Dui, Rd.','Fortaleza','CE','607439');
add_fisherman_details(200,'P.O. Box 269, 2813 Nec Av.','4694 Aliquam Avenue','Moignelee','NA','8421 IO');
END;

BEGIN
add_fish_species(500,'Perch',144,10);
add_fish_species(501,'Smelt',139,4);
add_fish_species(502,'Sturgeon',136,2);
add_fish_species(503,'Burbot',26,10);
add_fish_species(504,'Mackarel',49,1);
add_fish_species(505,'Winter Flounder',144,1);
add_fish_species(506,'Scup',53,1);
add_fish_species(507,'Black Sea Bass',59,13);
add_fish_species(508,'Brown Trout',106,15);
add_fish_species(509,'Largemouth Bass',134,14);
add_fish_species(510,'Bluegill',108,17);
add_fish_species(511,'Striped Bass',92,20);
add_fish_species(512,'Carp',135,20);
add_fish_species(513,'White Catfish',92,15);
add_fish_species(514,'Yellow Perch',112,20);
END;


BEGIN
add_bookings(100,64,117,to_timestamp('23-FEB-21 05.02.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(101,21,212,to_timestamp('21-APR-20 05.52.29.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(102,56,219,to_timestamp('29-APR-21 07.36.13.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(103,194,105,to_timestamp('23-JUL-20 11.08.12.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(104,66,177,to_timestamp('03-MAY-20 06.38.38.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(105,181,198,to_timestamp('10-FEB-21 04.15.15.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(106,190,219,to_timestamp('21-MAR-20 06.54.08.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(107,70,197,to_timestamp('21-SEP-20 07.22.44.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(108,102,160,to_timestamp('18-OCT-20 11.25.29.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(109,135,147,to_timestamp('09-APR-21 02.02.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(110,22,200,to_timestamp('28-DEC-20 10.45.16.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(111,149,161,to_timestamp('23-MAR-20 11.04.54.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(112,113,142,to_timestamp('01-SEP-20 06.56.29.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(113,147,184,to_timestamp('01-JAN-21 03.20.33.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(114,86,225,to_timestamp('16-MAY-20 08.02.08.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(115,88,144,to_timestamp('09-MAY-20 06.52.56.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(116,119,144,to_timestamp('06-APR-20 09.57.15.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(117,65,153,to_timestamp('31-AUG-20 04.22.53.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(118,54,174,to_timestamp('28-NOV-20 02.45.01.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(119,100,168,to_timestamp('25-JAN-21 12.27.14.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(120,83,196,to_timestamp('12-APR-21 01.37.01.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(121,8,129,to_timestamp('16-FEB-21 02.19.36.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(122,9,115,to_timestamp('10-MAY-20 07.48.05.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(123,142,111,to_timestamp('30-JAN-21 01.56.27.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(124,99,194,to_timestamp('19-NOV-20 01.02.12.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(125,60,208,to_timestamp('14-JUN-20 10.12.33.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(126,163,222,to_timestamp('20-APR-21 09.02.13.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(127,183,102,to_timestamp('17-APR-20 08.23.18.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(128,174,116,to_timestamp('23-JUL-20 04.13.58.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(129,173,207,to_timestamp('30-JUN-20 05.04.02.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(130,47,224,to_timestamp('01-SEP-20 07.21.31.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(131,177,118,to_timestamp('28-MAY-20 08.21.52.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(132,82,145,to_timestamp('21-MAR-21 11.16.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(133,193,210,to_timestamp('12-NOV-20 03.55.59.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(134,110,206,to_timestamp('07-APR-21 08.34.11.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(135,91,205,to_timestamp('31-OCT-20 02.41.48.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(136,167,148,to_timestamp('24-APR-21 11.32.33.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(137,89,201,to_timestamp('24-APR-20 07.24.35.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(138,43,193,to_timestamp('03-JUN-20 03.27.40.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(139,118,223,to_timestamp('27-SEP-20 08.26.39.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(140,200,221,to_timestamp('06-MAY-20 07.22.03.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(141,169,154,to_timestamp('13-AUG-20 03.36.29.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(142,32,137,to_timestamp('27-MAR-20 06.33.25.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(143,58,173,to_timestamp('29-SEP-20 09.33.08.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(144,87,111,to_timestamp('09-JUL-20 12.30.29.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(145,160,194,to_timestamp('12-DEC-20 07.56.45.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(146,150,116,to_timestamp('06-OCT-20 10.32.28.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(147,33,201,to_timestamp('21-MAY-20 12.56.57.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(148,152,115,to_timestamp('24-FEB-21 06.01.13.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(149,73,154,to_timestamp('16-APR-20 12.54.58.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(150,136,107,to_timestamp('07-NOV-20 09.18.10.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(151,81,117,to_timestamp('11-AUG-20 09.36.42.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(152,182,163,to_timestamp('14-JAN-21 02.35.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(153,5,198,to_timestamp('12-NOV-20 04.54.44.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(154,191,188,to_timestamp('05-AUG-20 09.25.06.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(155,41,169,to_timestamp('12-MAR-21 04.33.08.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(156,198,206,to_timestamp('21-MAY-20 09.37.55.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(157,145,144,to_timestamp('23-DEC-20 11.34.58.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(158,170,166,to_timestamp('04-AUG-20 02.21.49.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(159,10,110,to_timestamp('30-JAN-21 02.42.57.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(160,189,101,to_timestamp('18-DEC-20 07.24.06.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(161,39,107,to_timestamp('04-OCT-20 12.52.28.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(162,178,139,to_timestamp('29-OCT-20 11.49.18.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(163,134,126,to_timestamp('10-JAN-21 08.14.28.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(164,117,144,to_timestamp('15-APR-21 08.27.43.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(165,141,102,to_timestamp('19-JUL-20 12.49.08.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(166,187,192,to_timestamp('28-DEC-20 01.54.10.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(167,127,103,to_timestamp('26-MAR-21 06.18.10.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(168,162,172,to_timestamp('07-AUG-20 10.56.05.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(169,27,143,to_timestamp('26-MAR-20 05.20.57.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(170,13,212,to_timestamp('25-JUN-20 06.19.28.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(171,101,192,to_timestamp('06-JUL-20 12.00.23.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(172,115,110,to_timestamp('25-FEB-21 05.35.32.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(173,156,196,to_timestamp('05-APR-21 07.48.39.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(174,133,180,to_timestamp('29-MAY-20 05.16.24.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(175,151,185,to_timestamp('11-JUL-20 02.52.21.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(176,175,208,to_timestamp('14-MAY-20 07.01.04.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(177,107,205,to_timestamp('21-OCT-20 11.09.35.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(178,122,115,to_timestamp('16-FEB-21 07.32.21.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(179,104,129,to_timestamp('21-OCT-20 10.51.05.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(180,48,139,to_timestamp('26-OCT-20 12.30.45.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(181,172,169,to_timestamp('22-JUN-20 12.55.37.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(182,188,160,to_timestamp('09-MAR-21 06.00.04.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(183,171,143,to_timestamp('24-NOV-20 01.39.38.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(184,12,180,to_timestamp('15-MAR-21 11.34.15.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(185,164,106,to_timestamp('16-APR-20 09.31.22.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(186,109,152,to_timestamp('05-SEP-20 06.43.08.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(187,103,210,to_timestamp('16-DEC-20 03.22.26.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(188,57,216,to_timestamp('12-APR-21 10.52.53.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(189,114,115,to_timestamp('18-JAN-21 07.33.58.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(190,34,105,to_timestamp('19-JUL-20 03.44.34.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(191,112,223,to_timestamp('23-MAY-20 04.05.02.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(192,37,181,to_timestamp('29-MAR-20 11.28.38.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(193,23,153,to_timestamp('19-DEC-20 06.14.09.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(194,153,190,to_timestamp('12-DEC-20 09.49.26.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(195,90,127,to_timestamp('28-MAR-21 03.16.59.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(196,179,181,to_timestamp('13-AUG-20 12.51.37.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(197,106,139,to_timestamp('03-MAY-20 10.52.25.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(198,4,179,to_timestamp('25-MAY-20 12.23.14.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(199,16,144,to_timestamp('28-NOV-20 10.44.41.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(200,55,171,to_timestamp('06-SEP-20 07.54.59.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(201,6,124,to_timestamp('21-APR-21 10.33.21.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(202,68,101,to_timestamp('11-JUL-20 03.02.51.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(203,85,185,to_timestamp('16-APR-21 04.06.37.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(204,20,223,to_timestamp('03-AUG-20 04.30.24.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(205,78,159,to_timestamp('29-MAR-20 09.45.41.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(206,139,216,to_timestamp('24-MAR-21 08.59.31.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(207,50,203,to_timestamp('04-SEP-20 07.56.19.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(208,124,170,to_timestamp('19-JUN-20 01.08.21.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(209,46,161,to_timestamp('20-APR-20 11.00.42.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(210,132,118,to_timestamp('02-APR-20 06.36.43.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(211,11,117,to_timestamp('13-JUL-20 01.00.39.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(212,42,105,to_timestamp('11-OCT-20 01.02.42.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(213,94,119,to_timestamp('22-JUL-20 06.51.00.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(214,80,105,to_timestamp('10-APR-21 11.02.54.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(215,195,130,to_timestamp('04-JUN-20 08.38.04.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(216,148,184,to_timestamp('02-SEP-20 09.14.09.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(217,18,166,to_timestamp('06-MAR-21 12.26.07.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(218,93,159,to_timestamp('12-JUN-20 04.39.17.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(219,72,220,to_timestamp('26-MAR-21 04.48.20.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(220,196,199,to_timestamp('03-OCT-20 03.35.20.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(221,44,129,to_timestamp('20-JUL-20 10.07.44.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(222,69,180,to_timestamp('10-JUL-20 05.41.13.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(223,95,122,to_timestamp('04-MAY-20 12.58.35.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(224,197,225,to_timestamp('15-MAR-20 10.37.49.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(225,40,113,to_timestamp('20-SEP-20 06.15.18.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(226,116,183,to_timestamp('03-DEC-20 07.56.37.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(227,45,119,to_timestamp('27-OCT-20 01.30.15.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(228,192,118,to_timestamp('25-NOV-20 12.19.37.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(229,121,150,to_timestamp('26-NOV-20 07.54.27.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(230,186,113,to_timestamp('08-JUL-20 12.54.34.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(231,51,155,to_timestamp('29-MAR-20 02.49.08.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(232,184,101,to_timestamp('29-JUN-20 02.52.20.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(233,15,191,to_timestamp('31-MAR-21 03.25.59.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(234,176,172,to_timestamp('05-MAY-20 06.32.58.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(235,130,167,to_timestamp('23-SEP-20 06.39.35.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(236,79,204,to_timestamp('16-AUG-20 08.30.43.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(237,36,179,to_timestamp('10-MAR-20 07.00.45.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(238,84,189,to_timestamp('05-JAN-21 09.01.42.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(239,126,206,to_timestamp('06-AUG-20 03.12.53.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(240,125,192,to_timestamp('29-SEP-20 03.16.23.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(241,14,195,to_timestamp('31-JUL-20 04.09.38.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(242,129,148,to_timestamp('21-OCT-20 03.48.18.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(243,75,102,to_timestamp('30-APR-20 12.47.15.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(244,140,156,to_timestamp('06-JUN-20 05.50.01.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(245,146,182,to_timestamp('11-NOV-20 08.50.05.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(246,155,161,to_timestamp('28-MAR-21 05.40.16.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(247,76,153,to_timestamp('01-JUL-20 03.14.05.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(248,105,182,to_timestamp('21-AUG-20 01.05.45.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(249,52,135,to_timestamp('10-APR-21 12.20.18.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(250,92,141,to_timestamp('16-MAR-20 05.13.26.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(251,138,137,to_timestamp('20-JAN-21 06.08.40.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(252,61,184,to_timestamp('23-JUN-20 12.07.12.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(253,29,223,to_timestamp('15-JAN-21 08.22.33.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(254,168,131,to_timestamp('24-MAR-21 01.11.11.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(255,120,128,to_timestamp('19-JUN-20 05.31.33.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(256,158,112,to_timestamp('05-NOV-20 08.29.21.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(257,3,150,to_timestamp('10-MAY-20 12.17.57.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(258,67,211,to_timestamp('06-FEB-21 05.20.20.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(259,185,151,to_timestamp('27-JUL-20 03.54.34.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(260,137,211,to_timestamp('23-OCT-20 09.38.08.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(261,17,104,to_timestamp('21-AUG-20 12.07.42.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(262,161,159,to_timestamp('06-JUN-20 12.54.13.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(263,157,195,to_timestamp('06-FEB-21 06.25.32.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(264,59,213,to_timestamp('26-DEC-20 03.41.49.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(265,35,151,to_timestamp('09-OCT-20 02.31.05.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(266,166,199,to_timestamp('19-MAR-21 01.50.58.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(267,97,150,to_timestamp('04-FEB-21 07.25.50.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(268,26,153,to_timestamp('25-JAN-21 04.39.39.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'SUCCESS');
add_bookings(269,144,183,to_timestamp('15-JAN-21 09.17.30.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(270,63,132,to_timestamp('16-MAR-20 08.50.58.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(271,7,140,to_timestamp('04-APR-21 01.26.52.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(272,31,109,to_timestamp('06-OCT-20 09.22.45.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(273,53,130,to_timestamp('12-APR-20 01.27.50.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(274,143,221,to_timestamp('23-FEB-21 09.35.01.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(275,98,146,to_timestamp('03-JAN-21 03.25.46.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(276,165,168,to_timestamp('13-MAY-20 09.15.45.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(277,71,178,to_timestamp('27-MAR-21 10.51.05.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(278,199,138,to_timestamp('27-MAR-21 08.37.35.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(279,74,167,to_timestamp('09-NOV-20 03.31.48.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(280,19,186,to_timestamp('18-JUL-20 10.44.34.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(281,1,111,to_timestamp('16-DEC-20 09.18.41.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(282,96,196,to_timestamp('13-OCT-20 08.42.02.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(283,62,120,to_timestamp('15-MAY-20 12.30.29.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(284,154,218,to_timestamp('11-JUN-20 10.40.52.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(285,180,129,to_timestamp('06-NOV-20 02.04.58.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(286,38,180,to_timestamp('05-OCT-20 07.16.34.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(287,2,195,to_timestamp('16-JUN-20 03.02.46.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(288,128,106,to_timestamp('11-AUG-20 12.58.53.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(289,77,201,to_timestamp('25-JAN-21 05.17.07.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'PENDING');
add_bookings(290,25,128,to_timestamp('04-APR-20 09.25.17.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
add_bookings(291,111,156,to_timestamp('15-MAR-21 07.14.17.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
add_bookings(292,24,206,to_timestamp('26-APR-20 02.45.38.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
add_bookings(293,131,113,to_timestamp('19-SEP-20 06.15.35.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
add_bookings(294,159,197,to_timestamp('16-NOV-20 01.29.20.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
add_bookings(295,30,182,to_timestamp('14-DEC-20 04.35.47.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
add_bookings(296,49,112,to_timestamp('22-MAY-20 08.20.12.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
add_bookings(297,123,107,to_timestamp('25-SEP-20 04.50.09.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
add_bookings(298,108,218,to_timestamp('23-MAR-21 08.55.55.000000000 PM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
add_bookings(299,28,126,to_timestamp('02-JUN-20 12.05.51.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'FAILURE');
END;













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