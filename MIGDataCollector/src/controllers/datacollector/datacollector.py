__author__ = 'naveen.krishnan'

from MIGDataCollector.config import config
from MIGDataCollector.services import DataLogFileLogger, DataLogMQLogger
from MIGDataCollector.utils import logger
from MIGDataCollector.src.controllers import migcontroller

log = logger.MIGLogger.getLogger(__name__)


class DataCollector(migcontroller.MigController):
    def post(self):
        try:
            x_real_ip = self.request.headers.get("X-Real-IP")
            remote_ip = x_real_ip or self.request.remote_ip
            headers = self.request.headers
            data_from_request_body = self.request.body
            log.info('POST Request called with --- {0} --- from IP {1}'.format(data_from_request_body, remote_ip))
            self.set_status(202)
            self.__senddataforprocessing__(headers, data_from_request_body)
        except (IOError, Exception) as io_error:
            log.error('Error processing request : ' + str(io_error))
            self.set_status(202)
        finally:
            self.set_status(202)

    def options(self):
        '''---To Add Header Information We Use options Method It Will Not Directly Do Post When We Add Header Information
        It will First Send As Option Method then it will Convert as Post-- For Reference:http://stackoverflow.com/questions/35254742/tornado-server-enable-cors-requests---'''
        self.set_header('Access-Control-Allow-Origin', '*')  # It is to support cross origin Browser support
        self.set_header('Access-Control-Allow-Methods', 'POST,OPTIONS')  # It is to support Methods
        self.set_header('Access-Control-Allow-Headers', 'MIPVersion,ContentFormat')  # It is to support Custom Headers
        self.set_status(200)

    def __senddataforprocessing__(self, headers, data):
        try:
            data_logfile_logger = DataLogFileLogger.DataLogFileLogger()
            data_logfile_logger.write_datalog_tofile(headers, data)
            DataLogMQLogger.DatalogMQLogger(config, data, headers)
        except IOError as io_error:
            log.error('Error sending the data : ' + str(io_error))
        except Exception as exception:
            raise exception


class CasDataCollector(DataCollector):
    def __senddataforprocessing__(self, metadata, data):
        try:
            data_logfile_logger = DataLogFileLogger.DataLogFileLogger()
            client = 'cas_'
            data_logfile_logger.write_datalog_tofile(metadata, data, client)
            DataLogMQLogger.DatalogMQLogger(config, data)
        except IOError as io_error:
            log.error('Error sending the data : ' + str(io_error))
        except Exception as exception:
            raise exception

