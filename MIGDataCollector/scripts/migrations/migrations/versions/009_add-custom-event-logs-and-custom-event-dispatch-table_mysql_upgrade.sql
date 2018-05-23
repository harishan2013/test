-- -----------------------------------------------------
-- Table `custom_event_logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custom_event_logs` (
  `custom_event_log_id` int(20) NOT NULL AUTO_INCREMENT,
  `device_id` int(20) DEFAULT NULL,
  `user_id` varchar(100) NOT NULL,
  `event_date` datetime NOT NULL,
  `notification_message` text NOT NULL,
  PRIMARY KEY (`custom_event_log_id`)
) ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table `custom_event_dispatch_logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `custom_event_dispatch_logs` (
  `custom_event_dispatch_logs_id` int(20) NOT NULL AUTO_INCREMENT,
  `custom_event_log_id` int(20) NOT NULL,
  `event_sent_date` datetime NOT NULL,
  `event_sent_mode` text NOT NULL,
  `event_recipient` longtext NOT NULL,
  PRIMARY KEY (`custom_event_dispatch_logs_id`),
  KEY `fk__event_logs` (`custom_event_log_id`),
  CONSTRAINT `fk_custom_event_logs` FOREIGN KEY (`custom_event_log_id`) REFERENCES `custom_event_logs` (`custom_event_log_id`)
) ENGINE=InnoDB;