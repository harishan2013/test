CREATE TABLE IF NOT EXISTS `session_management_table` (
	`session_id` VARCHAR(100) NOT NULL,
	`user_id` INT(11) NOT NULL,
	`created_datetime` DATETIME(6) NOT NULL,
	PRIMARY KEY (`session_id`),
	INDEX `user_id` (`user_id`),
	CONSTRAINT `session_management_table_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
)
ENGINE=InnoDB;