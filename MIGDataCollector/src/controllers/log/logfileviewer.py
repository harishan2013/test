__author__ = 'naveen.krishnan'

import os

import tornado

from MIGDataCollector.config import config, Users
from MIGDataCollector.utils import logger
from MIGDataCollector.services import DataLogFileLogger
from MIGDataCollector.src.controllers import migcontroller
from MIGDataCollector.src.controllers.log import logviewer

log = logger.MIGLogger.getLogger(__name__)
STATIC_PATH = logviewer.LogViewer.getstaticpath()


class LogFileViewer(migcontroller.MigController):
    def get(self):
        self.render(os.path.join(STATIC_PATH, 'login.html'))

    def post(self):
        try:
            username = self.get_argument("username")
            password = self.get_argument("password")
            if username in Users.users.keys():
                expected_password = Users.users[username]
            if expected_password == password:
                eventdata_logs = []
                application_logs = []
                for eventdata_log in sorted(
                        os.listdir(config.LOGGING_DESTINATION + os.path.sep + config.EVENT_DATA_LOG_DIR_NAME)):
                    if '.log' in eventdata_log:
                        eventdata_logs.append(eventdata_log)

                for application_log in sorted(os.listdir(config.LOGGING_DESTINATION)):
                    if '.log' in application_log:
                        application_logs.append(application_log)

                serverurl = self.request.host
                log.info('Server url is >>' + str(serverurl))
                self.render(os.path.join(STATIC_PATH, 'index.html'), eventdatalogs=eventdata_logs,
                            application_logs=application_logs,
                            server=serverurl)
            else:
                self.send_error(401)
        except IOError as io_error:
            log.error('Error processing request : ' + str(io_error))
        except:
            log.error('Error processing request :')
        finally:
            pass

    def __getdatafromfile__(self):
        try:
            data = DataLogFileLogger.read_datalog_fromfile()
            return str(tornado.escape.native_str(data))
        except IOError as io_error:
            log.error('Error reading the data : ' + str(io_error))
        finally:
            pass
