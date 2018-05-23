SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE `module_role_map` MODIFY COLUMN `module_role_map_id` INT auto_increment;
SET FOREIGN_KEY_CHECKS = 1;

ALTER TABLE `user_role_map` ADD UNIQUE INDEX `user_id_UNIQUE`(`user_id`);