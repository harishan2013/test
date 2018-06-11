# MIGateway - McWane India Gateway project.
The endpoint for the IoT devices to receive the data and process.
Current protocol support for transfering the data from devices is http, with CSV and json data format support - as per the MIG data protocol
The data getting into the Gateway is received and acknowledged to the devices about the acceptance. Once the data is
  acknowledged then the data is logged in log files and published to the queue for further processing..

# Development Setup..
TODO

# Releases
## 1.0.0 
1. Initial release with support for CSV format

## 1.0.1
1.  Support for cas HTTP endpoints.

## 1.0.2
1.  Bug fixes in http endpoint.

## 1.0.3
1.  Support for cas HTTP endpoints bug fixes.

## 1.0.4
1. Message queue configuration scripts added. Added http end point for viewing of the application and event logs.

## 1.0.5
1. Release after Fixing the hardcoded server url in the eventlog viewer pages.

## 1.0.6
1. Hardcoded log file url removed from the html file.

## 1.0.7
1. View logs is now formatted and getting updated in the browser for every log entry.

## 1.0.8
1. User Security implemented for viewing the log files.
2. Users are added to configuration python files which is used only for McWane purpose and not exposed outside.

## 1.0.9
1. setup.py file modification

## 1.0.10
1. Queue changes changes and bug fixes.

## 1.0.11
1. Upstart scripts documentations updates.

## 1.0.13
1. Rabbitmq connection issue fix.

## 1.0.14
1. Using blocking connection ( open and close ) for each http request

## 1.1.0
1. Unique key creation for ivr events table

## 1.1.1
1. Added raw_unit column for the device_map table.

## 1.2.0
1. Added migration scripts for event_processing_config table.
2. Addition of version history in README.md file.

## 1.2.1
1. jenkinsscript review changes.
2. setup.file update for requirements.txt file

## 1.2.2
1. Packaging of MIGDataCollector for use in Bootstrap applications.

## 1.2.3
1. HTTP Header change from specific key 'ContentFormat' to generic key 'Content-Type'

## 1.2.4
1. Pylint Code review and Report Generation in Jenkins Job

## 1.2.5
1. Fix for displaying all the log files in the webpage in logfileviewer

## 1.2.6
1. Addition of migration scripts for customer, sites and devices relationships.

## 1.2.7
1. Migration scripts fix on removing hardcoded database name.

## 1.2.8
1. New DB scripts addition for BIMUI Changes.

## 1.2.9
1. New DB scripts for custom event logs.

## 1.2.10
1. New DB scripts for level, consumption and receipts storage.

## 1.2.11
1. DB column name changes to match the model and script

## 1.2.12
1. Issue fix for changing the DB index changes to match the model and script

## 1.2.13
1. Added new tables upgrade and downgrade scripts for notification related functionalities

##1.2.14
1. Upgrade and downgrade scripts for adding a notification_data column to notification_messages.

##1.2.15
1. Version.sh and setup.py file update.

##1.2.16
1. Upgrade and downgrade scripts added for session_management tables

##1.2.17
1. Upgrade and downgrade db script for altering user_email coulmn to Nullable.

##1.2.18
1. Upgrade and downgrade db script for adding auto increment to module_role_map table.
2. Upgrade and downgrade db script for adding unqiue index to user_id in user_role_map table.