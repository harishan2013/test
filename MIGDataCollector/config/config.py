__author__ = 'naveen.krishnan'

#TODO Use configparser instead
#System Configuration
port = 8000
LOGGING_DESTINATION = '/var/logs/MIGDC'
APPLICATION_LOG_FILE = 'MIGDataCollector.log'
LOGGING_LEVEL = 'INFO'
LOGGING_FORMAT = '%(asctime)s : %(name)s : %(levelname)s : %(message)s'
LOGGING_MAXSIZE_IN_A_FILE =  5242880  #in bytes - default set to 5MB - 5242880
LOGGING_MAX_FILES_TO_KEEP = 50

#Application Configuration
EVENT_DATA_LOG_DIR_NAME = 'eventlogs'
EVENT_DATA_LOG_FILE_NAME ='eventdata.log'

#MessageQueue Configuration
MESSAGE_QUEUE_SERVER = 'localhost'
MESSAGE_QUEUE_PORT = 5672
MESSAGE_QUEUE_VHOST = '/'
MESSAGE_QUEUE_USERNAME = 'guest'
MESSAGE_QUEUE_PASSWORD = 'guest'
MESSAGE_QUEUE_EXCHANGE = 'mig'
MESSAGE_QUEUE_NAME = 'mig'
MESSAGE_QUEUE_ROUTING_KEY = 'mig'
MESSAGE_QUEUE_NAME_NOTIFICATION = 'notification'
MESSAGE_QUEUE_NAME_ROUTING_KEY_NOTIFICATION = 'notification'

#Database Migration Configuration
DRIVER = "mysql"
HOST = "localhost"
USER = "root"
PASSWORD = ""
DATABASE = "miggatewaydb"