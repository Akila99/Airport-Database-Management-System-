-- Student Number(s): FEASI202
					--PATPI201

-- Student Name(s):Akila Frenando
				-- Thejan panduka

/*	Database Creation & Population Script
	Produce a script to create the database you designed in Task 1 (incorporating any changes you have made since then).  
	Be sure to give your columns the same data types, properties and constraints specified in your data dictionary, and be sure to name tables and columns consistently.  
	Include any logical and correct default values and any check or unique constraints that you feel are appropriate.

	Make sure this script can be run multiple times without resulting in any errors (hint: drop the database if it exists before trying to create it).  
	You can use/adapt the code at the start of the creation scripts of the sample databases available in the unit materials to implement this.

	See the assignment brief for further information. 
*/


-- Write your creation script here
--*************************************************************************************
--We first check if the database exists, and drop it if it does.

IF DB_ID('Airport_system') IS NOT NULL             
	BEGIN
		PRINT 'Database exists - dropping.';
		
		USE master;		
		ALTER DATABASE Airport_system SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		
		DROP DATABASE Airport_system;
	END

GO

--***************************************************************************************
-- Now we build the database so that we know it does not exist.

PRINT 'Creating database.';

CREATE DATABASE Airport_system;

GO

--****************************************************************************************
--Now that an empty database has been created, we will make it the active one.

USE Airport_system;

GO

--****************************************************************************************
--We now create the tables in the database.

PRINT 'Creating country table...';

--Now we are creating country table

create table country 
(
country_code char (2) not null,
country_name varchar (30) not null,

constraint cntry_pk primary key (country_code),
constraint cntry_name_uk unique (country_name)
);
 
 --****************************************************************************************
 --Now we are creating airport table

print'Creating airport table';

create table airport
(
airport_code  char(3) not null,
airport_name  varchar(50) not null,
latitude      float  not null,
longitude     float  not null,
country_code  char(2) not null,

constraint air_code_pk primary key (airport_code),
constraint air_name_uk unique (airport_name),
constraint contry_code_fk  foreign key (country_code) references country(country_code)
);

--******************************************************************************************
--Now we are creating flight table

print'Creating flight table'

create table flight
(
flight_no  varchar(8) not null,
distance   varchar(10) not null,
arrival_airport_code    char(3) not null,
depature_airport_code  char(3) not null,

constraint flight_no_pk primary key (flight_no),
constraint arrival_fk foreign key (arrival_airport_code) references airport(airport_code),
constraint depature_fk foreign key (depature_airport_code) references airport(airport_code)
);


--*******************************************************************************************
--Now we are creating model table

print 'creating model table'

create table model
(
model_num         varchar(10) not null,
manufacturer_name char(6) not null,
travel_range      smallint not null, 
cruise_speed      smallint not null,

constraint mod_num_pk primary key (model_num)
);


--*********************************************************************************************
--now we are creating qualification table 

print' creating qualification table'

create table qualification
(
model_num varchar(10) not null,
pilot_id  int not null,

constraint mod_no_pilot_id_pk primary key (model_num,pilot_id),
constraint mod_num_fk foreign key(model_num) references model(model_num),


);


--************************************************************************************************
--Now we are creating pilot table

--Note that this table has a compound primary key consisting of the pilot_id and co_pilot_id.

print 'creating pilot table'
create table pilot
(
pilot_id int not null ,
first_name varchar(10) not null,
last_name varchar(10) not null,
date_of_birth date not null,
fly_hours  time not null,

constraint pilot_id_pk primary key (pilot_id)
);


--**************************************************************************************************
-- Now we are creating plane table

print 'creating plane table'
create table plane 
(
rego_num char(7) not null,
model_num varchar(10) not null,
build_year date null,
first_capacity tinyint, 
bus_capacity tinyint, 
econ_capacity int,

constraint rego_pk primary key (rego_num),
constraint plane_model_fk foreign key (model_num)
	references model(model_num)
);


--*****************************************************************************************************
--Now we are creating attendant table

print 'creating attendant table'
create table attendant
(
attendant_id int ,
first_name varchar (10) not null,
last_name varchar (10) not null,
date_of_birth date not null,
hire_date date null,
mentor_id int  null,

constraint attendant_fk primary key (attendant_id),
constraint mentor_fk foreign key (mentor_id)references attendant(attendant_id)
);

--*********************************************************************************************************
--Now we are creating flight instance table

print 'creating flight instance table'
create table flight_instance
(
flight_instance_id int not null ,
Date_Time_Arrival datetime not null,
Date_Time_Departure datetime not null,
rego_num char(7) not null,
flight_no  varchar(8) not null,
pilot_id int not null,
co_pilot_id int not null,
flight_service_manager int not null ,

constraint fgt_instc_pk primary key (flight_instance_id),
constraint fgt_instc_rego_fk foreign key (rego_num) references plane(rego_num),
constraint fgt_instc_flight_no_fk foreign key (flight_no) references flight(flight_no),
constraint fgh_instc_pilot_id_fk foreign key (pilot_id) references pilot(pilot_id),
constraint fgh_instc_co_pilot_id_fk foreign key (co_pilot_id) references pilot(pilot_id),
constraint fgt_instc_fgt_service_manager_fk foreign key (flight_service_manager) references attendant(attendant_id)
);
 

--************************************************************************************************************
--Now we are creating cabin crew table

print 'creating cabin crew table'
create table cabin_crew
(
flight_instance_id int,
attendant_id int,

constraint cn_crew_fgt_instc_fk foreign key (flight_instance_id) references flight_instance(flight_instance_id),
constraint cn_crew_attendant_fk foreign key (attendant_id) references attendant(attendant_id)
);

--**************************************************************************************************************
-- End of creating tables.

alter table qualification
add constraint qul_pilot_id_fk foreign key (pilot_id)references pilot(pilot_id);














/*	Database Population Statements
	Following the SQL statements to create your database and its tables, you must include statements to populate the database with sufficient test data.
	Make sure referential integrity is observed � you cannot add data to a column with a foreign key constraint if you do not yet have data in the column it references.

	You may wish to start working on your views and queries and write INSERT statements that add the data needed to test each one as you go.   
	The final create.sql should be able to create your database and populate it with enough data to make sure that all views and queries return meaningful results.

	Since writing sample data is time-consuming and quite tedious, I have provided data for several of the tables below.
	Adapt the INSERT statements as needed, and write your own INSERT statements for the remaining tables at the end of the file.
*/





/*  The following statement inserts the details of 4 countries into a table named "country".
    It specifies values for 2 columns:  Country code and country name.
	Make sure that the columns in your country table are suitable to contain the values below (you are welcome to change the table/column names).
	If desired, additional data for this table can be found at: https://www.nationsonline.org/oneworld/country_code_list.htm
*/






/*	The following statement inserts the details of 5 airports into a table named "airport". 
    It specifies values for 5 columns:  Airport code, airport name, latitude, longitude and country code.
	Make sure that the columns in your airport table are suitable to contain the values below (you are welcome to change the table/column names).
	If desired, additional data for this table can be found at: https://www.world-airport-codes.com/
*/






/*	The following statement inserts the details of 4 plane models into a table named "model". 
    It specifies values for 4 columns:  Model number, manufacturer name, travel range in kms and cruise speed in km/h.
	Make sure that the columns in your airport table are suitable to contain the values below (you are welcome to change the table/column names).
	If desired, additional data for this table can be found at: https://www.aircraftcompare.com/ (Jumbo and Mid Size Passenger Jets categories)
*/






/*	The following statement inserts the details of 6 planes into a table named "plane". 
    It specifies values for 6 columns:  Registration number, model number, build year and first, business and economy class passenger capacities.
	Make sure that the columns in your airport table are suitable to contain the values below (you are welcome to change the table/column names).
	Seating capacities were sourced from https://www.seatguru.com/ (note that the data below includes two A380 800s and two 777 200LRs, with different seating layouts).
*/



		


-- Write the insert statements to add data to the rest of the tables here.

--*************************************
--Inserting values to country table

insert into country (country_code, country_name)
values ('AU', 'Australia'),
	   ('NZ', 'New Zealand'),
	   ('IN', 'India'),
	   ('CN', 'China');


--**************************************
--Inserting values to airport table 

insert into airport (airport_code, airport_name, latitude, longitude, country_code)
values ('PER', 'Perth International Airport',					-31.9403,		115.9670029,	'AU'),
	   ('SYD', 'Sydney Kingsford Smith International Airport',	-33.9460983,	151.177002,		'AU'),
	   ('AKL', 'Auckland International Airport',				-37.0080986,	174.7920074,	'NZ'),
	   ('DEL', 'Indhira Gandhi International Airport',			28.5664997,		77.1031036,		'IN'),
	   ('PEK', 'Beijing Capital International Airport',			40.080101,		116.5849991,	'CN'); 

--***************************************
--Inserting in to flight table

insert into flight 
values  ('NZ105','970km','PEK','PER'),
		('EK435','700km','AKL','DEL'),
		('PR219','500km','SYD','PEK'),
		('NZ992','1000km','PER','AKL'),
		('CZ306','500km','PEK','SYD');


--***************************************
--Inserting in to model table

INSERT INTO model (model_num, manufacturer_name, travel_range, cruise_speed)
VALUES	('A340 300',	'Airbus',	13705,	896), 
		('A380 800',	'Airbus',	16112,	1088), 
		('737 600',		'Boeing',	5649,	827), 
		('777 200LR',	'Boeing',	17500,	945);

--***************************************
--Inserting in to pilot table

insert into pilot (pilot_id,first_name, last_name,date_of_birth,fly_hours)
values  ( 1,'Randall','Zlotkey','1996-02-17','05:45:34'),
		(2,'Bruce','Hunold','1988-11-01','10:20:43'),
		(3,'Jennifer','Matos','1976-08-10','07:30:30'),
		(4,'Ellen','Gietz','1990-01-23','06:35:55'),
		(5,'Davies','William','1991-12-02','03:05:54');

--***************************************
--Inserting in to plane table

INSERT INTO plane (rego_num, model_num, build_year, first_capacity, bus_capacity, econ_capacity)
VALUES  ('VH-ABC', 'A340 300',	'2010',   40, 28, 179),
		('VH-DEF', 'A380 800',	'2013',   14, 64, 406),
		('VH-GHI', 'A380 800',	'2016',   0,  58, 557),
		('VH-JKL', '737 600',	'1998',   0,  12, 101),
		('VH-MNO', '777 200LR',	'2008',   8,  35, 195),
		('VH-PQR', '777 200LR', '2012',   8,  42, 216);


--***************************************
--Inserting in to attendant table
insert into attendant (attendant_id,first_name,last_name,date_of_birth,hire_date,mentor_id)
values  (215,'Lex','Vargas', '1976-01-20' , '1991-03-21' ,234),
		(278,'Robin', 'Steven' , '1980-11-09' , '1998-11-25' ,NULL),
		(234,'Roy','William','1967-09-23','2000-03-10',NULL),
		(290,'Lexi','Ernst','1988-11-09','2005-11-03',278),
		(265,'Shelley','Higgins','1970-08-09','2010-07-01',234);

       
--***************************************
--Inserting in to qualification table
insert into qualification (model_num, pilot_id)
values  ('A340 300', 2),
		('A380 800', 4),
		('737 600', 1),
		('777 200LR',3);

--***************************************
--Inserting in to flight instance table
insert into flight_instance ( flight_instance_id ,Date_Time_Arrival,Date_Time_Departure,rego_num,flight_no,pilot_id,co_pilot_id, flight_service_manager)
values  (2545,'2016-07-04 05:30', '2016-07-05 06:00','VH-DEF','NZ105' , 4,1,290),
		(2543,'2016-07-03 09:00', '2016-07-04 12:00','VH-GHI','CZ306' , 1,4,265),
		(2761,'2016-06-11 3:40', '2016-06-13 7:05','VH-PQR','NZ992' , 2,3,234),
		(2890,'2016-11-25 14:30', '2016-11-26 7:45','VH-GHI','EK435' , 3,2,278);
       


--***************************************
--Inserting in to cabin crew table
insert into cabin_crew (flight_instance_id,attendant_id)
values  (2545,265),
		(2545,290),
		(2890,278),
		(2761,234),
		(2543,278);
		
insert into flight
values ('SA101','800km','SYD','PEK');
-- You are responsible for coming up with the data for these tables - see the assignment brief for further details.

-- For realistic data regarding distances and flight times between airports, use https://www.airmilescalculator.com/
-- Remember that you do not need to create a lot of data and it does not need to be realistic or comprehensive.


insert into attendant
values (270,'Froi','Dexter','1974-08-06','2010-07-01',NULL);

insert into flight_instance
values (2716,'2016-11-25 14:30', '2016-11-26 7:45','VH-GHI','CZ306' , 1,4,265);

insert into cabin_crew
values (2716,270);

