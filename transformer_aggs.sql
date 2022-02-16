delimiter //
CREATE OR REPLACE PROCEDURE `derive_transformer_aggs`(i int(11) NULL) RETURNS void AS 
declare x int;
begin
 
while True loop
	echo select concat(current_timestamp,": deriving aggs") as "status";
	replace into transformer_aggregation select transformer_id, min(read_kwh), max(read_kwh), avg(read_kwh), sum(read_kwh), count(read_kwh), stddev(read_kwh), current_timestamp from ami_reads a, meter_to_transformer m where a.meter_id = m.meter_id group by transformer_id;
	replace into daily_transformer_aggregation select transformer_id, date(read_dt) , min(read_kwh), max(read_kwh), avg(read_kwh), sum(read_kwh), count(read_kwh), stddev(read_kwh), current_timestamp from ami_reads a, meter_to_transformer m where a.meter_id = m.meter_id group by transformer_id,date(read_dt);
    replace into interval_transformer_aggregation select transformer_id, read_dt , min(read_kwh) , max(read_kwh), avg(read_kwh) , sum(read_kwh), count(read_kwh), stddev(read_kwh) , current_timestamp 
 from ami_reads a, meter_to_transformer m 
 where a.meter_id = m.meter_id 
 and minute(read_dt)%10=0 
 group by transformer_id,read_dt;
 
 replace into hourly_transformer_aggregation
 select transformer_id, date_format(read_dt,"%Y-%m-%d %H:00:00") as read_dt, min(read_kwh) , max(read_kwh), avg(read_kwh) , sum(read_kwh), count(read_kwh), stddev(read_kwh) , current_timestamp 
 from ami_reads a, meter_to_transformer m 
 where a.meter_id = m.meter_id 
 group by transformer_id,date_format(read_dt,"%Y-%m-%d %H:00:00") ;
   
    
	x = sleep(i);
end loop;
end;
//
delimiter ;