DROP TABLE IF EXISTS `site_devices_map` ;
DROP TABLE IF EXISTS `customer_site_map` ;
DROP TABLE IF EXISTS `site` ;
DROP TABLE IF EXISTS `customer` ;

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