CREATE TABLE `daily_meter_aggregation` (
  `meter_id` int(11) NOT NULL DEFAULT '0',
  `agg_date` date NOT NULL DEFAULT '0000-00-00 00:00:00',
  `m_average` decimal(12,2) DEFAULT NULL,
  `m_sum` decimal(12,2) DEFAULT NULL,
  `create_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`meter_id`,`agg_date`),
  SHARD KEY `meter_id` (`meter_id`),
  KEY `agg_date` (`agg_date`)
);

CREATE TABLE meter_aggregation ( meter_id int(11) NOT NULL DEFAULT '0', m_average decimal(12,2) DEFAULT NULL, m_sum decimal(12,2) 
DEFAULT NULL, create_dt datetime DEFAULT NULL, PRIMARY KEY (meter_id), SHARD KEY meter_id (meter_id) ) ;

CREATE TABLE `daily_transformer_aggregation` (
  `transformer_id` int(11) NOT NULL DEFAULT '0',
  `agg_date` date NOT NULL DEFAULT '0000-00-00 00:00:00',
  `m_min` decimal(12,2) DEFAULT NULL,
  `m_max` decimal(12,2) DEFAULT NULL,
  `m_average` decimal(12,2) DEFAULT NULL,
  `m_sum` decimal(12,2) DEFAULT NULL,
  `m_count` int(11) DEFAULT NULL,
  `m_stddev` decimal(12,2) DEFAULT NULL,
  `create_dt` datetime DEFAULT NULL,
  `kva` as m_sum/1000/24/.9 PERSISTED decimal(12,2),
  PRIMARY KEY (`transformer_id`,`agg_date`),
  SHARD KEY `transformer_id` (`transformer_id`),
  KEY `agg_date` (`agg_date`)
);
 
 
CREATE TABLE `hourly_transformer_aggregation` (
  `transformer_id` int(11) NOT NULL DEFAULT '0',
  `agg_date` datetime NOT NULL,
  `m_min` decimal(12,2) DEFAULT NULL,
  `m_max` decimal(12,2) DEFAULT NULL,
  `m_average` decimal(12,2) DEFAULT NULL,
  `m_sum` decimal(12,2) DEFAULT NULL,
  `m_count` int(11) DEFAULT NULL,
  `m_stddev` decimal(12,2) DEFAULT NULL,
  `create_dt` datetime DEFAULT NULL,
  `kva` as m_sum/1000/1/.9 PERSISTED decimal(12,2),
  PRIMARY KEY (`transformer_id`,`agg_date`),
  SHARD KEY `transformer_id` (`transformer_id`),
  KEY `agg_date` (`agg_date`)
);

CREATE TABLE `interval_transformer_aggregation` (
  `transformer_id` int(11) NOT NULL DEFAULT '0',
  `agg_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `m_min` decimal(12,2) DEFAULT NULL,
  `m_max` decimal(12,2) DEFAULT NULL,
  `m_average` decimal(12,2) DEFAULT NULL,
  `m_sum` decimal(12,2) DEFAULT NULL,
  `m_count` int(11) DEFAULT NULL,
  `m_stddev` decimal(12,2) DEFAULT NULL,
  `create_dt` datetime DEFAULT NULL,
  `kva` as m_sum/1000/.167/.9 PERSISTED decimal(12,2),
  PRIMARY KEY (`transformer_id`,`agg_date`),
  SHARD KEY `transformer_id` (`transformer_id`),
  KEY `agg_date` (`agg_date`)
);
