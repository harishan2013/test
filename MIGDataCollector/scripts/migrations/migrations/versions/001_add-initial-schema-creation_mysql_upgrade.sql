-- -----------------------------------------------------
-- Table `CAPABILITIES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `capabilities`
  (
     `capability_id`   INT(20) NOT NULL,
     `capability_desc` VARCHAR(45) NOT NULL,
     PRIMARY KEY (`capability_id`)
  ) engine=innodb;


-- -----------------------------------------------------
-- Table `devices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `devices`
  (
     `device_id`     INT(20) NOT NULL,
     `device_ext_id` VARCHAR(45) NOT NULL,
     `active`        TINYINT(1) NOT NULL,
     `created_date`  DATETIME NOT NULL,
     `modified_date` DATETIME NOT NULL,
     PRIMARY KEY (`device_id`)
  ) engine=innodb;



-- -----------------------------------------------------
-- Table `device_capabilities_map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `device_capabilities_map`
  (
     `device_capability_id` INT(20) NOT NULL,
     `device_id`            INT(20) NOT NULL,
     `capability_id`        INT(20) NOT NULL,
     `capability_port`      VARCHAR(10) NOT NULL,
     `created_date`         DATETIME NOT NULL,
     `modified_date`        DATETIME NOT NULL,
     PRIMARY KEY (`device_capability_id`),
     INDEX `fk_device_capabilities_map_devices` (`device_id`),
     INDEX `fk_device_capabilities_map_capabilities` (`capability_id`),
     CONSTRAINT `fk_device_capabilities_map_capabilities` FOREIGN KEY (
     `capability_id`) REFERENCES `capabilities` (`capability_id`),
     CONSTRAINT `fk_device_capabilities_map_devices` FOREIGN KEY (`device_id`)
     REFERENCES `devices` (`device_id`)
  ) engine=innodb;


-- -----------------------------------------------------
-- Table `device_capability_event_data_logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `device_capability_event_data_logs`
  (
     `event_data_log_id`    INT(20) NOT NULL,
     `device_capability_id` INT(20) NOT NULL,
     `recorded_value`       VARCHAR(45) NOT NULL,
     `recorded_time`        DATETIME NOT NULL,
     PRIMARY KEY (`event_data_log_id`),
     INDEX `fk_device_capability_event_data_logs_device_capabilities_map` (
     `device_capability_id`),
     CONSTRAINT `fk_device_capability_event_data_logs_device_capabilities_map`
     FOREIGN KEY (`device_capability_id`) REFERENCES `device_capabilities_map` (
     `device_capability_id`)
  ) engine=innodb;

-- -----------------------------------------------------
-- Table `interval_capability_tracking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `interval_capability_tracking`
  (
     `device_capability_id`    INT(20) NOT NULL,
     `interval_time_sec`       DECIMAL(20, 0) NOT NULL,
     `nc_warn_grace_time_sec`  DECIMAL(20, 0) NOT NULL,
     `nc_error_grace_time_sec` DECIMAL(20, 0) NOT NULL,
     `nc_monitoring_enabled`   TINYINT(1) NOT NULL,
     `created_date`            DATETIME NOT NULL,
     `modified_date`           DATETIME NOT NULL,
     INDEX `fk_interval_capability_tracking_device_capabilities_map` (
     `device_capability_id`),
     CONSTRAINT `fk_interval_capability_tracking_device_capabilities_map`
     FOREIGN KEY (`device_capability_id`) REFERENCES `device_capabilities_map` (
     `device_capability_id`)
  ) engine=innodb;

-- -----------------------------------------------------
-- Table `interval_capability_tracking_logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `interval_capability_tracking_logs`
  (
     `device_capability_id`       INT(20) NOT NULL,
     `latest_contact_date`        DATETIME NOT NULL,
     `expected_next_contact_date` DATETIME NOT NULL,
     INDEX `fk_interval_capability_tracking_logs_device_capabilities_map` (
     `device_capability_id`),
     CONSTRAINT `fk_interval_capability_tracking_logs_device_capabilities_map`
     FOREIGN KEY (`device_capability_id`) REFERENCES `device_capabilities_map` (
     `device_capability_id`)
  ) engine=innodb;


-- -----------------------------------------------------
-- Table `metered_devices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `metered_devices`
  (
     `device_capability_id` INT(20) NOT NULL,
     `meter_unit`           VARCHAR(45) NOT NULL,
     `latest_meter_reading` DECIMAL(20, 0) NOT NULL,
     `recorded_date`        DATETIME NOT NULL,
     `created_date`         DATETIME NOT NULL,
     `modified_date`        DATETIME NOT NULL,
     INDEX `fk_metered_devices_device_capabilities_map` (`device_capability_id`)
     ,
     CONSTRAINT `fk_metered_devices_device_capabilities_map` FOREIGN KEY (
     `device_capability_id`) REFERENCES `device_capabilities_map` (
     `device_capability_id`)
  ) engine=innodb;


-- -----------------------------------------------------
-- Table `metered_device_consumption`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `metered_device_consumption`
  (
     `metered_device_consumption_id` INT(20) NOT NULL,
     `device_capability_id`          INT(20) NOT NULL,
     `consumption_type`              VARCHAR(45) NOT NULL,
     `consumption_period`            VARCHAR(45) NOT NULL,
     `consumption_value`             VARCHAR(45) NOT NULL,
     `period_start_reading`          DECIMAL(20, 0) NOT NULL,
     `created_date`                  DATETIME NOT NULL,
     `modified_date`                 DATETIME NOT NULL,
     PRIMARY KEY (`metered_device_consumption_id`),
     INDEX `fk_metered_device_consumption_device_capabilities_map` (
     `device_capability_id`),
     CONSTRAINT `fk_metered_device_consumption_device_capabilities_map` FOREIGN
     KEY (`device_capability_id`) REFERENCES `device_capabilities_map` (
     `device_capability_id`)
  ) engine=innodb;



-- -----------------------------------------------------
-- Table `edge_gateway_devices_map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `edge_gateway_devices_map`
  (
     `egateway_device_id` INT(20) NOT NULL,
     `edge_device_id`     INT(20) NOT NULL,
     `network_device_id`  INT(20) NOT NULL,
     `active`             TINYINT(1) NOT NULL,
     `created_date`       DATETIME NOT NULL,
     `modified_date`      DATETIME NOT NULL,
     PRIMARY KEY (`egateway_device_id`)
  ) engine=innodb;


------------------------------------------------------------------------------------------------------------------------
