DROP TABLE IF EXISTS `feature_contact_map` ;
DROP TABLE IF EXISTS `module_role_map` ;
DROP TABLE IF EXISTS `feature` ;
DROP TABLE IF EXISTS `user_role_map` ;
DROP TABLE IF EXISTS `device_role_map` ;
DROP TABLE IF EXISTS `module` ;
DROP TABLE IF EXISTS `role` ;
DROP TABLE IF EXISTS `user` ;
DROP TABLE IF EXISTS `site_devices_map` ;
DROP TABLE IF EXISTS `contact` ;
DROP TABLE IF EXISTS `site_capacity` ;
DROP TABLE IF EXISTS `site` ;
DROP TABLE IF EXISTS `customer_region_segment_mapping` ;
DROP TABLE IF EXISTS `customer` ;
DROP TABLE IF EXISTS `region` ;
DROP TABLE IF EXISTS `segment` ;

-- -----------------------------------------------------
-- Table `customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `site`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `site` (
  `site_id` INT NOT NULL AUTO_INCREMENT,
  `site_name` VARCHAR(45) NOT NULL,
  `site_address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`site_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `customer_site_map`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `customer_site_map` (
  `customer_site_map_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `site_id` INT NOT NULL,
  PRIMARY KEY (`customer_site_map_id`),
  INDEX `fk_csm_customer_id_idx` (`customer_id` ASC),
  INDEX `fk_csm_site_id_idx` (`site_id` ASC),
  CONSTRAINT `fk_csm_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_csm_site_id`
    FOREIGN KEY (`site_id`)
    REFERENCES `site` (`site_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `site_devices_map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `site_devices_map` (
  `site_devices_map_id` INT NOT NULL,
  `site_id` INT NOT NULL,
  `device_id` INT NOT NULL,
  `device_lat` VARCHAR(20) NOT NULL,
  `device_long` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`site_devices_map_id`),
  INDEX `fk_sdm_site_id_idx` (`site_id` ASC),
  INDEX `fk_sdm_device_id_idx` (`device_id` ASC),
  CONSTRAINT `fk_sdm_site_id`
    FOREIGN KEY (`site_id`)
    REFERENCES `site` (`site_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sdm_device_id`
    FOREIGN KEY (`device_id`)
    REFERENCES `devices` (`device_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;