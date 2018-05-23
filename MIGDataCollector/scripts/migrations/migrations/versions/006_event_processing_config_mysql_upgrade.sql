-- -----------------------------------------------------
-- Table `event_processing_config`
-- -----------------------------------------------------
CREATE TABLE `event_processing_config` (
  `event_device_capability_id` int(11) NOT NULL,
  `processing_device_capability_id` int(11) NOT NULL,
  `created_date` datetime NOT NULL,
  `modified_date` datetime NOT NULL,
  PRIMARY KEY (`event_device_capability_id`),
  KEY `FK_event_device_capability_id_device_capability_map` (`event_device_capability_id`),
  KEY `FK_processing_device_capability_id_device_capability_map` (`processing_device_capability_id`),
  CONSTRAINT `FK_event_device_capability_id_device_capability_map` FOREIGN KEY (`event_device_capability_id`) REFERENCES `device_capabilities_map` (`device_capability_id`),
  CONSTRAINT `FK_processing_device_capability_id_device_capability_map` FOREIGN KEY (`processing_device_capability_id`) REFERENCES `device_capabilities_map` (`device_capability_id`)
);