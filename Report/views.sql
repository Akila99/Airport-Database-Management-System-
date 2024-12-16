--Creating flight instance view

CREATE VIEW flight_ins
as select flight_instance_id ,Date_Time_Arrival,Date_Time_Departure,fi.rego_num,fi.flight_no,fi.pilot_id,co_pilot_id, 
          fi.flight_service_manager,f.arrival_airport_code,f.depature_airport_code,
          p.first_name+ ' ' + p.last_name as 'pilot full name', cp.first_name +' '+ cp.last_name as 'co_pilot_ name',
          pl.model_num,( pl.first_capacity+ pl.econ_capacity) as 'expected attendants',distance,a.first_name+ '  ' +a.last_name as' FSM name'
    
from  flight_instance as fi inner join flight as f
on fi.flight_no = f.flight_no inner join plane as pl
on fi.rego_num = pl.rego_num inner join attendant as a
on fi.flight_service_manager = a.attendant_id inner join pilot as p
on fi.pilot_id = p.pilot_id inner join pilot as cp 
on fi.co_pilot_id = cp.pilot_id



--Creating departing Flight Information View

Create view dep_flig_info_view
as select fi.flight_no as 'Flight Number', arrival_airport_code as 'Destination',DATEADD(hh, -1, Date_Time_Departure )as 'Boarding Time', m.model_num as 'Plane'
         from flight_instance as fi inner join flight as f
         on fi.flight_no = f.flight_no inner join model as m
         on m.model_num = m.model_num
         order by [Boarding Time] 
		 offset 0 rows


select * from dep_flig_info_view