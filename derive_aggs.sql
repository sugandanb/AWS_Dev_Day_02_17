delimiter //
CREATE OR REPLACE PROCEDURE `derive_aggs`(i int(11) NULL) RETURNS void AS 
declare x int;
begin
while True loop
	echo
  select concat(current_timestamp, ": deriving aggs") as "status";
 
  replace into meter_aggregation
  select meter_id, avg(read_kwh), sum(read_kwh), current_timestamp
  from ami_reads
  group by meter_id;
 
  replace into daily_meter_aggregation
  select meter_id, date(read_dt) ,avg(read_kwh), sum(read_kwh), current_timestamp
  from ami_reads
  group by meter_id,date(read_dt);
 
  replace into monthly_meter_aggregation
  select meter_id, str_to_date(concat(year(read_dt), "-", month(read_dt)),
	'%Y-%m') as "agg" ,avg(read_kwh), sum(read_kwh), current_timestamp
  From ami_reads
  group by meter_id, year(read_dt), month(read_dt) ;
  x = sleep(i);
 end loop;
end;
//
delimiter ;