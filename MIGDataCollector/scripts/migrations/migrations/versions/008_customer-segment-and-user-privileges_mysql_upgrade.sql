-- -----------------------------------------------------
-- Table `segment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `segment` (
  `segment_id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(30) NOT NULL,
  `type` VARCHAR(30) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NOT NULL,
  `updated_by` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`segment_id`),
  UNIQUE INDEX `segment_id_UNIQUE` (`segment_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `region` (
  `region_id` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(20) NOT NULL,
  `state` VARCHAR(30) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NOT NULL,
  `updated_by` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`region_id`),
  UNIQUE INDEX `region_id_UNIQUE` (`region_id` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `customer` - DROP and CREATE
-- -----------------------------------------------------

DROP TABLE IF EXISTS `customer_site_map` ;

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(50) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NOT NULL,
  `updated_by` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer_region_segment_mapping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `customer_region_segment_mapping` (
  `customer_region_segment_mapping_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `region_id` INT NOT NULL,
  `segment_id` INT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NOT NULL,
  `updated_by` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`customer_region_segment_mapping_id`),
  UNIQUE INDEX `customer_region_segment_mapping_id_UNIQUE` (`customer_region_segment_mapping_id` ASC),
  INDEX `fk_segment_id_idx` (`segment_id` ASC),
  INDEX `fk_customer_id_idx` (`customer_id` ASC),
  INDEX `fk_region_id_idx` (`region_id` ASC),
  CONSTRAINT `fk_segment_id`
    FOREIGN KEY (`segment_id`)
    REFERENCES `segment` (`segment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_region_id`
    FOREIGN KEY (`region_id`)
    REFERENCES `region` (`region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `site_devices_map` and `site` - DROP
-- -----------------------------------------------------
DROP TABLE IF EXISTS `site_devices_map` ;

DROP TABLE IF EXISTS `site` ;

-- -----------------------------------------------------
-- Table `site` CREATE
-- -----------------------------------------------------

CREATE TABLE `site` (
  `site_id` INT NOT NULL AUTO_INCREMENT,
  `csr_id` INT NOT NULL,
  `site_name` VARCHAR(50) NOT NULL,
  `address` VARCHAR(150) NOT NULL,
  `business` VARCHAR(50) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NOT NULL,
  `updated_by` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`site_id`),
  UNIQUE INDEX `site_id_UNIQUE` (`site_id` ASC),
  INDEX `fk_csr_id_idx` (`csr_id` ASC),
  CONSTRAINT `fk_csr_id`
    FOREIGN KEY (`csr_id`)
    REFERENCES `customer_region_segment_mapping` (`customer_region_segment_mapping_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `site_capacity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `site_capacity` (
  `site_capacity_id` INT NOT NULL AUTO_INCREMENT,
  `site_id` INT NOT NULL,
  `total_tanks` INT NOT NULL,
  `total_capacity` FLOAT NOT NULL,
  `min_capacity` FLOAT NOT NULL,
  `max_capacity` FLOAT NOT NULL,
  PRIMARY KEY (`site_capacity_id`),
  UNIQUE INDEX `site_capacity_id_UNIQUE` (`site_capacity_id` ASC),
  INDEX `fk_site_id_idx` (`site_id` ASC),
  CONSTRAINT `fk_site_id`
    FOREIGN KEY (`site_id`)
    REFERENCES `site` (`site_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `site_devices_map` CREATE
-- -----------------------------------------------------

CREATE TABLE `site_devices_map` (
  `site_devices_map_id` INT NOT NULL AUTO_INCREMENT,
  `site_id` INT NOT NULL,
  `device_id` INT NOT NULL,
  `device_ext_id` VARCHAR(50) NOT NULL,
  `device_lat` FLOAT NOT NULL,
  `device_long` FLOAT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NOT NULL,
  `updated_by` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`site_devices_map_id`),
  UNIQUE INDEX `site_devices_map_id_UNIQUE` (`site_devices_map_id` ASC),
  INDEX `fk_site_id_idx` (`site_id` ASC),
  CONSTRAINT `fk_site_id_sdmap`
    FOREIGN KEY (`site_id`)
    REFERENCES `site` (`site_id`),
  INDEX `fk_device_id_idx` (`device_id` ASC),
  CONSTRAINT `fk_device_id_sdmap`
    FOREIGN KEY (`device_id`)
    REFERENCES `devices` (`device_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `contact` (
  `contact_id` INT NOT NULL AUTO_INCREMENT,
  `site_id` INT NOT NULL,
  `department` VARCHAR(50) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `phone_number` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NULL,
  `rank` INT NOT NULL,
  PRIMARY KEY (`contact_id`),
  UNIQUE INDEX `contact_id_UNIQUE` (`contact_id` ASC),
  INDEX `fk_site_id_contact_idx` (`site_id` ASC),
  CONSTRAINT `fk_site_id_contact`
    FOREIGN KEY (`site_id`)
    REFERENCES `site` (`site_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `module`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `module` (
  `module_id` INT NOT NULL AUTO_INCREMENT,
  `module_name` VARCHAR(45) NOT NULL,
  `display_name` VARCHAR(45) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NOT NULL,
  `updated_by` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`module_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(50) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NOT NULL,
  `updated_by` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE INDEX `role_id_UNIQUE` (`role_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(45) NOT NULL,
  `user_password` VARCHAR(45) NOT NULL,
  `user_email` VARCHAR(45) NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NOT NULL,
  `updated_by` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC),
  UNIQUE INDEX `user_email_UNIQUE` (`user_email` ASC),
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_role_map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_role_map` (
  `user_role_map_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NOT NULL,
  `updated_by` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`user_role_map_id`),
  UNIQUE INDEX `user_role_map_id_UNIQUE` (`user_role_map_id` ASC),
  INDEX `fk_role_id_idx` (`role_id` ASC),
  INDEX `fk_user_id_idx` (`user_id` ASC),
  CONSTRAINT `fk_role_id`
    FOREIGN KEY (`role_id`)
    REFERENCES `role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `device_role_map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `device_role_map` (
  `device_role_map_id` INT NOT NULL AUTO_INCREMENT,
  `role_id` INT NOT NULL,
  `device_id` INT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NOT NULL,
  `updated_by` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`device_role_map_id`),
  UNIQUE INDEX `user_role_map_id_UNIQUE` (`device_role_map_id` ASC),
  INDEX `fk_device_id_idx` (`device_id` ASC),
  INDEX `fk_role_id_idx` (`role_id` ASC),
  CONSTRAINT `fk_device_id_drmap`
    FOREIGN KEY (`device_id`)
    REFERENCES `devices` (`device_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_role_id_drmap`
    FOREIGN KEY (`role_id`)
    REFERENCES `role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `feature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` INT NOT NULL AUTO_INCREMENT,
  `feature_name` VARCHAR(45) NOT NULL,
  `module_id` INT NOT NULL,
  PRIMARY KEY (`feature_id`),
  UNIQUE INDEX `feature_id_UNIQUE` (`feature_id` ASC),
  INDEX `fk_module_id_idx` (`module_id` ASC),
  CONSTRAINT `fk_module_id`
    FOREIGN KEY (`module_id`)
    REFERENCES `module` (`module_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `module_role_map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `module_role_map` (
  `module_role_map_id` INT NOT NULL,
  `feature_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NOT NULL,
  `updated_by` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`module_role_map_id`),
  INDEX `fk_role_id_idx` (`role_id` ASC),
  INDEX `fk_feature_id_idx` (`feature_id` ASC),
  CONSTRAINT `fk_feature_id`
    FOREIGN KEY (`feature_id`)
    REFERENCES `feature` (`feature_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_role_id_mrmap`
    FOREIGN KEY (`role_id`)
    REFERENCES `role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `feature_contact_map`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `feature_contact_map` (
  `feature_contact_map_id` INT NOT NULL AUTO_INCREMENT,
  `feature_id` INT NOT NULL,
  `contact_id` INT NOT NULL,
  `created_date` DATETIME NOT NULL,
  `updated_date` DATETIME NOT NULL,
  `updated_by` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`feature_contact_map_id`),
  UNIQUE INDEX `contact_feature_map_id_UNIQUE` (`feature_contact_map_id` ASC),
  INDEX `fk_feature_id_idx` (`feature_id` ASC),
  INDEX `fk_contact_id_idx` (`contact_id` ASC),
  CONSTRAINT `fk_feature_id_fcmap`
    FOREIGN KEY (`feature_id`)
    REFERENCES `feature` (`feature_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contact_id_fcmap`
    FOREIGN KEY (`contact_id`)
    REFERENCES `contact` (`contact_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;