use utility;


CREATE TABLE `ami_reads` (
  `meter_id` int(11) DEFAULT NULL,
  `read_dt` datetime DEFAULT NULL,
  `read_kwh` decimal(10,4) DEFAULT NULL,
  SHARD KEY `meter_id` (`meter_id`),
  KEY `read_dt` (`read_dt`) USING CLUSTERED COLUMNSTORE
);

CREATE TABLE `ami_alarms` (
  `meter_id` int(11) DEFAULT NULL,
  `alarm_dt` datetime DEFAULT NULL,
  `alarm` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `value` decimal(10,4) DEFAULT NULL,
  `create_dt` datetime DEFAULT NULL,
  `written_to_kafka` datetime(6) DEFAULT NULL,
  SHARD KEY `meter_id` (`meter_id`),
  KEY `alarm_dt` (`alarm_dt`) USING CLUSTERED COLUMNSTORE
);

CREATE TABLE `voltage_reads` (
  `meter_id` int(11) DEFAULT NULL,
  `read_dt` datetime DEFAULT NULL,
  `read_volt` decimal(10,4) DEFAULT NULL, 
  SHARD KEY `meter_id` (`meter_id`), 
  KEY `read_dt` (`read_dt`) USING CLUSTERED COLUMNSTORE 
  );

CREATE TABLE `transformer_reads` ( `transformer_id` int(11) DEFAULT NULL, `read_dt` datetime DEFAULT NULL, `read_kwh` 
decimal(10,4) DEFAULT NULL, SHARD KEY `transformer_id` (`transformer_id`), KEY `read_dt` (`read_dt`) USING CLUSTERED COLUMNSTORE );