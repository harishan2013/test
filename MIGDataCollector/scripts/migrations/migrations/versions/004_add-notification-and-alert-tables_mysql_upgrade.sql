-- -----------------------------------------------------
-- Table `notification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `notification`
  (
     `notification_id`   INT(20) NOT NULL auto_increment,
     `notification_type` VARCHAR(20) NOT NULL,
     PRIMARY KEY (`notification_id`)
  ) engine=innodb;


-- -----------------------------------------------------
-- Table `event_response_configuration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_response_configuration`
  (
     `event_response_configuration_id` INT(20) NOT NULL auto_increment,
     `device_capability_id`            INT(20) NOT NULL,
     `notification_id`                 INT(20) NOT NULL,
     `notification_recipients`         TEXT NOT NULL,
     `notification_message`            TEXT NOT NULL,
     PRIMARY KEY (`event_response_configuration_id`),
     INDEX `fk__device_capabilities_map` (`device_capability_id`),
     INDEX `fk_event_response_configuration_notification` (`notification_id`),
     CONSTRAINT `fk__device_capabilities_map` FOREIGN KEY (
     `device_capability_id`) REFERENCES `device_capabilities_map` (
     `device_capability_id`),
     CONSTRAINT `fk_event_response_configuration_notification` FOREIGN KEY (
     `notification_id`) REFERENCES `notification` (`notification_id`)
  ) engine=innodb;


-- -----------------------------------------------------
-- Table `event_logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_logs`
  (
     `event_log_id`         INT(20) NOT NULL auto_increment,
     `device_capability_id` INT(20) NOT NULL,
     `event_date`           DATETIME NOT NULL,
     `event_data`           TEXT NOT NULL,
     `notification_message` TEXT NOT NULL,
     PRIMARY KEY (`event_log_id`),
     INDEX `fk_event_logs_device_capabilities_map` (`device_capability_id`),
     CONSTRAINT `fk_event_logs_device_capabilities_map` FOREIGN KEY (
     `device_capability_id`) REFERENCES `device_capabilities_map` (
     `device_capability_id`)
  ) engine=innodb;


-- -----------------------------------------------------
-- Table `event_dispatch_logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_dispatch_logs`
  (
     `event_dispatch_logs_id` INT(20) NOT NULL auto_increment,
     `event_log_id`           INT(20) NOT NULL,
     `event_sent_date`        DATETIME NOT NULL,
     `event_sent_mode`        TEXT NOT NULL,
     `event_recipient`        LONGTEXT NOT NULL,
     PRIMARY KEY (`event_dispatch_logs_id`),
     INDEX `fk__event_logs` (`event_log_id`),
     CONSTRAINT `fk__event_logs` FOREIGN KEY (`event_log_id`) REFERENCES
     `event_logs` (`event_log_id`)
  ) engine=innodb;

------------------------------------------------------------------------------------------------------------------------


