__author__ = 'naveen.krishnan'

import json

import tornado

from MIGDataCollector.utils import logger

log = logger.MIGLogger.getLogger(__name__)
event_data_log = logger.MIGLogger.get_event_data_logger('data_log')
cl_event_data_log = logger.MIGLogger.get_event_data_logger('cl_data_log', 'cas_')


class DataLogFileLogger(object):
    def __init__(self):
        pass

    def write_datalog_tofile(self, metadata, data, client=None):
        try:
            default_version = '1.0'
            default_format = 'csv'
            if metadata.get('Content-Type') == 'csv' or metadata.get('Content-Type') is None:
                data = str(tornado.escape.native_str(data))
            elif metadata.get('Content-Type') == 'json':
                data = json.loads(data.decode('utf-8'))
            data_to_write_in_file = '{0} : {1} : {2} '.format(metadata.get('MIPVersion') or default_version,
                                                              metadata.get('Content-Type') or default_format, data)
            if client == 'cas_':
                cl_event_data_log.critical(data_to_write_in_file)
            else:
                event_data_log.critical(data_to_write_in_file)
            log.info('Event data log written successfully')
        except IOError as io_error:
            log.error('Error processing request : ' + str(io_error))
            return None
        finally:
            return None
