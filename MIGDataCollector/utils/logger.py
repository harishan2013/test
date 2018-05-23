__author__ = 'naveen.krishnan'
import os
import logging
import logging.handlers

from MIGDataCollector.config import config

class MIGLogger:

    #TODO Use logger config file instead
    logging_level = {
        'DEBUG': logging.DEBUG,
        'INFO': logging.INFO,
        'WARNING': logging.DEBUG,
        'ERROR': logging.ERROR,
        'CRITICAL': logging.CRITICAL,
    }

    @staticmethod
    def __setup_logger__(logger_name, log_file, log_format, level=logging.INFO):
        l = logging.getLogger(logger_name)
        if not l.handlers:
            formatter = logging.Formatter(log_format)
            file_handler = logging.handlers.RotatingFileHandler(log_file, maxBytes=config.LOGGING_MAXSIZE_IN_A_FILE,
                                                                backupCount=config.LOGGING_MAX_FILES_TO_KEEP,
                                                                mode='a')
            file_handler.setFormatter(formatter)
            l.setLevel(level)
            l.addHandler(file_handler)

    @staticmethod
    def getLogger(name):
        if not os.path.exists(config.LOGGING_DESTINATION):
            os.makedirs(config.LOGGING_DESTINATION)
        log_destination = config.LOGGING_DESTINATION
        MIGLogger.__setup_logger__(name, log_destination + os.path.sep + config.APPLICATION_LOG_FILE, config.LOGGING_FORMAT, config.LOGGING_LEVEL)
        logger = logging.getLogger(name)
        return logger

    @staticmethod
    def get_event_data_logger(name, logfileprefix = '', fileformat=''):
        event_data_log_directory = config.LOGGING_DESTINATION + os.path.sep + config.EVENT_DATA_LOG_DIR_NAME
        if not os.path.exists(event_data_log_directory):
            os.makedirs(event_data_log_directory)
        logfiledestination = event_data_log_directory + os.path.sep + config.EVENT_DATA_LOG_FILE_NAME
        logfileformat = config.LOGGING_FORMAT
        if logfileprefix:
            logfiledestination = config.LOGGING_DESTINATION + os.path.sep + config.EVENT_DATA_LOG_DIR_NAME + os.path.sep + logfileprefix + config.EVENT_DATA_LOG_FILE_NAME
        if fileformat:
            logfileformat = fileformat

        MIGLogger.__setup_logger__(name, logfiledestination, logfileformat, config.LOGGING_LEVEL)
        logger = logging.getLogger(name)
        return logger


if __name__ == '__main__':

    data_log = MIGLogger.getLogger('data_log')
    for x in range(1, 3 ):
        data_log.critical('data logs')

    event_data_log = MIGLogger.get_event_data_logger('event_data_log')
    for x in range(1, 3 ):
        event_data_log.critical('Event data')

    event_data_log1 = MIGLogger.get_event_data_logger('cl_event_data_log','cas_')
    for x in range(1, 3):
        event_data_log1.critical('CAS Event data')
