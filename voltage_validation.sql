delimiter //
CREATE OR REPLACE PROCEDURE `voltage_validation`(batch query(`_meter_id` int(11) NULL,
`_read_dt` datetime NULL, `_read_volt` decimal(10,4) NULL)) RETURNS void 
AS 
declare val decimal(10,4);
 
declare high_alarm_q query(_val decimal(10,4)) =
select 00.00;
 
declare v_meter_id int;
declare v_read_dt datetime;
declare v_read_kwh decimal(10,4);
begin
insert
	into voltage_reads
select * from batch;
insert into ami_alarms(meter_id, alarm_dt, alarm, value,create_dt)
 
select _meter_id, _read_dt,"voltage_out_of_bounds" , _read_volt, current_timestamp()
from batch
where _read_volt not between 110 and 130;
end;
//
delimiter ;


