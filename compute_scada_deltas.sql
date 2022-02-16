delimiter //
CREATE OR REPLACE PROCEDURE `compute_scada_deltas`(i int(11) NULL) RETURNS void AS 
declare x int;
begin
 
while True loop
 
 replace into transformer_alarms select tr.transformer_id, tr.read_dt, "interval" as "interval", "SCADA_10%_HIGHER_THEFT",  tr.read_kwh / a.m_sum  as value, current_timestamp()  from transformer_reads tr, interval_transformer_aggregation  a where tr.transformer_id = a.transformer_id  and tr.read_dt = a.agg_date and a.m_count >= 25  and (a.m_sum*1.001) < tr.read_kwh ;
 
replace into transformer_alarms select tr.transformer_id, tr.read_dt, "interval" as "interval", "SCADA_20%_LOWER_ORPHAN", tr.read_kwh / a.m_sum  as value, current_timestamp()  from transformer_reads tr, interval_transformer_aggregation  a where tr.transformer_id = a.transformer_id  and tr.read_dt = a.agg_date and a.m_count >= 25 and  a.m_sum > (tr.read_kwh*1.50);
	x = sleep(i);
end loop;
end;
//
delimiter ;