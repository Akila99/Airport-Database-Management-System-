--Query 1 Plane finder

select rego_num, m.model_num, travel_range as 'range',first_capacity + ' ' + econ_capacity as 'total_capacity'
from plane as p inner join model as m
on p.model_num= m.model_num
where first_capacity + ' ' + econ_capacity >= 400 and travel_range >= 14000
order by range desc


--Query 2  Flight Descriptions

select 'The ' + convert(varchar, fi.Date_Time_Departure) + ' instance of flight ' + fi.flight_no
+ ' from ' + fi.depature_airport_code + ' to ' + fi.arrival_airport_code +' takes '
 + convert(varchar, DATEDIFF(hour, fi.Date_Time_Departure, fi.Date_Time_Arrival)) +' hours.' as 'flight instance description'
from flight_ins fi;




--Query 3 attendant comparison

select a.attendant_id, a.first_name+' '+a.last_name as 'attendant name',DATEDIFF (YY,a.hire_date,getdate()) as 'attendant_work_years',m.mentor_id,
		m.first_name+' '+m.last_name as 'mentor name',DATEDIFF (YY,m.hire_date,getdate()) as 'mentor work years'
from attendant as a inner join attendant as m
	on a.mentor_id=m.attendant_id

--Query 4 – Understaffed Flights

select fins.flight_instance_id ,flight_no,Date_Time_departure,( pl.first_capacity+ pl.econ_capacity) as 'expected attendants',
		( pl.first_capacity+pl.bus_capacity + pl.econ_capacity) as 'rostered attendants'
from plane as pl join flight_ins as fins
on pl.rego_num=fins.rego_num


--Query 5 – Lost Umbrella


 
