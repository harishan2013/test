CREATE TABLE IF NOT EXISTS `notification_type` (
  `notification_type_id` INT NOT NULL AUTO_INCREMENT,
  `notification_type` VARCHAR(45) NOT NULL,
  `notification_capability` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`notification_type_id`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `notification_status` (
  `notification_status_id` INT NOT NULL AUTO_INCREMENT,
  `notification_status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`notification_status_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `notification_messages` (
  `notification_id` INT NOT NULL AUTO_INCREMENT,
  `device_id` INT NOT NULL,
  `notification_datetime` DATETIME NOT NULL,
  `notification_message` TEXT NOT NULL,
  `notification_type_id` INT NOT NULL,
  `notification_status_id` INT NOT NULL,
  `status_changed_datetime` DATETIME NOT NULL,
  `status_changed_by` VARCHAR(45) NOT NULL,
  `comments` TEXT NULL,
  PRIMARY KEY (`notification_id`),
  INDEX `fk_notification_status_id_nfc_idx` (`notification_status_id` ASC),
  INDEX `fk_notification_type_id_nfc_idx` (`notification_type_id` ASC),
  INDEX `fk_device_id_nfc_idx` (`device_id` ASC),
  CONSTRAINT `fk_notification_type_id_nfc`
    FOREIGN KEY (`notification_type_id`)
    REFERENCES `notification_type` (`notification_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notification_status_id_nfc`
    FOREIGN KEY (`notification_status_id`)
    REFERENCES `notification_status` (`notification_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_device_id_nfc`
    FOREIGN KEY (`device_id`)
    REFERENCES `devices` (`device_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Dumping data for table notification_status: ~3 rows (approximately)
INSERT INTO `notification_status` (`notification_status_id`, `notification_status`) VALUES
	(1, 'Pending'),
	(2, 'In Progress'),
	(3, 'Action Taken');

-- Dumping data for table notification_type: ~3 rows (approximately)
INSERT INTO `notification_type` (`notification_type_id`, `notification_type`, `notification_capability`) VALUES
	(1, 'LLA', 'A122'),
	(2, 'HLA', 'B122'),
	(3, 'GLD', 'C122');
