SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE `module_role_map` MODIFY COLUMN `module_role_map_id` INT ;
SET FOREIGN_KEY_CHECKS = 1;

ALTER TABLE `user_role_map` DROP INDEX `user_id_UNIQUE`;