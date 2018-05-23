-- -----------------------------------------------------
-- Table `ivr_config`
-- -----------------------------------------------------
CREATE TABLE `ivr_config` (
	`ivr_config_id` INT(20) NOT NULL auto_increment,
	`device_capability_id` INT(20) NOT NULL,
	`sub_device` VARCHAR(45) NOT NULL,
	`sub_device_order` INT(20) NOT NULL,
	`ivr_threshold_enabled` BIT(1) NOT NULL,
	`processing_enabled` BIT(1) NOT NULL,
	`processing_formula` TEXT NOT NULL,
	`reverse_processing_formula` TEXT NOT NULL,
	`unit` VARCHAR(20) NOT NULL,
	`raw_unit` VARCHAR(20) NULL,
	`created_date` DATETIME NOT NULL,
	`modified_date` DATETIME NOT NULL,
	PRIMARY KEY (`ivr_config_id`),
	INDEX `FK_ivr_config_device_capabilities_map` (`device_capability_id`),
	CONSTRAINT `FK_ivr_config_device_capabilities_map` FOREIGN KEY (`device_capability_id`) REFERENCES `device_capabilities_map` (`device_capability_id`)
);


-- -----------------------------------------------------
-- Table `ivr_data_events`
-- -----------------------------------------------------
CREATE TABLE `ivr_data_events` (
	`ivr_data_events_id` INT(20) NOT NULL auto_increment,
	`device_capability_id` INT(20) NOT NULL,
	`recorded_date` DATETIME NOT NULL,
	`created_date` DATETIME NOT NULL,
	PRIMARY KEY (`ivr_data_events_id`),
	UNIQUE KEY `device_capability_id_recorded_date` (`device_capability_id`,`recorded_date`),
	INDEX `FK_ivr_data_events_device_capabilities_map` (`device_capability_id`),
	CONSTRAINT `FK_ivr_data_events_device_capabilities_map` FOREIGN KEY (`device_capability_id`) REFERENCES `device_capabilities_map` (`device_capability_id`)
);


-- -----------------------------------------------------
-- Table `ivr_data_events_logs`
-- -----------------------------------------------------
CREATE TABLE `ivr_data_events_logs` (
	`ivr_data_events_logs_id` INT(20) NOT NULL auto_increment,
	`ivr_data_events_id` INT(20) NOT NULL,
	`ivr_config_id` INT(20) NOT NULL,
	`raw_value` DECIMAL(30,20) NOT NULL,
	`processed_value` DECIMAL(30,20) NOT NULL,
	PRIMARY KEY (`ivr_data_events_logs_id`),
	INDEX `FK_ivr_data_events_logs_ivr_data_events` (`ivr_data_events_id`),
	INDEX `FK_ivr_data_events_logs_ivr_config` (`ivr_config_id`),
	CONSTRAINT `FK_ivr_data_events_logs_ivr_config` FOREIGN KEY (`ivr_config_id`) REFERENCES `ivr_config` (`ivr_config_id`),
	CONSTRAINT `FK_ivr_data_events_logs_ivr_data_events` FOREIGN KEY (`ivr_data_events_id`) REFERENCES `ivr_data_events` (`ivr_data_events_id`)
);


------------------------------------------------------------------------------------------------------------------------


