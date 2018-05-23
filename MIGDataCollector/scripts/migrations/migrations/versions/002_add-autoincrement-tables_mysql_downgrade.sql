SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE capabilities MODIFY COLUMN capability_id INT(20) NOT NULL;
ALTER TABLE devices MODIFY COLUMN device_id INT(20) NOT NULL;
ALTER TABLE device_capabilities_map MODIFY COLUMN device_capability_id INT(20) NOT NULL;
ALTER TABLE device_capability_event_data_logs MODIFY COLUMN event_data_log_id INT(20) NOT NULL;
ALTER TABLE edge_gateway_devices_map MODIFY COLUMN egateway_device_id INT(20) NOT NULL;
SET FOREIGN_KEY_CHECKS = 1;