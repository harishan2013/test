__author__ = 'naveen.krishnan'

import os

from MIGDataCollector.config import config
from MIGDataCollector.utils import logger
from MIGDataCollector.src.controllers import migcontroller
from MIGDataCollector.src.controllers.log import logviewer

log = logger.MIGLogger.getLogger(__name__)


class LogDataViewer(migcontroller.MigController):
    def get(self, type, filename):
        try:
            if type == 'logs':
                type = ''
            else:
                type = os.path.sep + 'eventlogs'
            with open(config.LOGGING_DESTINATION + type + os.path.sep + filename, "r") as file_data:
                file_array = []
                for data in file_data:
                    file_array.append(data)
            self.render(os.path.join(logviewer.LogViewer.getstaticpath(), 'template.html'), title=filename, items=file_array)
        except IOError as io_error:
            log.error('Error reading the log data : ' + str(io_error))
        finally:
            pass
