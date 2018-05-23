CREATE TABLE IF NOT EXISTS `device_interval_readings` (
  `device_id` INT NOT NULL,
  `recorded_datetime` DATETIME NOT NULL,
  `recorded_level` DECIMAL(30,20) NOT NULL,
  UNIQUE INDEX `device_id_dir` (`device_id` ASC, `recorded_datetime` ASC),
  CONSTRAINT `fk_device_id_dir`
    FOREIGN KEY (`device_id`)
    REFERENCES `devices` (`device_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `device_consumption_readings` (
  `device_id` INT NOT NULL,
  `recorded_datetime` DATETIME NOT NULL,
  `consumption` DECIMAL(30,20) NOT NULL,
  UNIQUE INDEX `device_id_dcr` (`device_id` ASC, `recorded_datetime` ASC),
  CONSTRAINT `fk_device_id_dcr`
    FOREIGN KEY (`device_id`)
    REFERENCES `devices` (`device_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `device_receipt_readings` (
  `device_id` INT NOT NULL,
  `recorded_datetime` DATETIME NOT NULL,
  `receipt` DECIMAL(30,20) NOT NULL,
  UNIQUE INDEX `device_id_drr` (`device_id` ASC, `recorded_datetime` ASC),
  CONSTRAINT `fk_device_id_drr`
    FOREIGN KEY (`device_id`)
    REFERENCES `devices` (`device_id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION)
ENGINE = InnoDB;