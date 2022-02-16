delimiter //
CREATE or replace PROCEDURE `data_validation`(batch query(`_meter_id` int(11) NULL, `_read_dt` datetime NULL, `_read_kwh` decimal(10,4) NULL)) RETURNS void AS 
declare 
check_query query(meter_id int, read_dt datetime, read_kwh decimal(10,2), 14daycount int, 14dayavg decimal(10,2), delta decimal(10,2)) = select b._meter_id, b._read_dt, b._read_kwh, count(a.m_average) as "14daycount" , avg(a.m_average) as "14dayavg", b._read_kwh/avg(a.m_average) as "delta"
from batch b
left join daily_meter_aggregation a on (b._meter_id = a.meter_id and a.agg_date >= date(b._read_dt) - interval 14 day and a.agg_date < date(b._read_dt))
where b._read_kwh > 10
group by 1,2
having 14daycount >= 14
and delta not between .1 and 10;

begin

insert into ami_reads select * from batch;
   
insert into ami_alarms(meter_id, alarm_dt, alarm, value, create_dt)
select meter_id, read_dt,case when delta <= .1 then "low_read_alarm" when delta >= 10 then "high_read_alarm" end as alarm_name ,delta, current_timestamp() from check_query;

EXCEPTION
	when OTHERS then
    
end;
//
delimiter ;