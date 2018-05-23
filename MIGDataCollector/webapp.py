__author__ = 'naveen.krishnan'

import tornado.ioloop
import tornado.web

from MIGDataCollector.config import config
from MIGDataCollector.utils import logger
from MIGDataCollector.src.controllers.datacollector import datacollector
from MIGDataCollector.src.controllers.log import logfileviewer, logdataviewer

log = logger.MIGLogger.getLogger(__name__)


class DataCollectorApp(object):
    @staticmethod
    def init(start=True):
        port = config.port
        make_app().listen(port)
        log.info('Server listening in port {0}'.format(str(port)))
        if start:
            tornado.ioloop.IOLoop.instance().start()

def make_app():
    application = tornado.web.Application([
        (r"/", datacollector.DataCollector),
        (r"/cas", datacollector.CasDataCollector),
        # The below urls are not exposed to the user. For debugging and troubleshooting purpose only
        (r"/logdt", logfileviewer.LogFileViewer),
        (r"/log/([A-Za-z]+)/([A-Za-z0-9\_\.\-]+)", logdataviewer.LogDataViewer),
    ])
    return application


if __name__ == "__main__":
    DataCollectorApp.init()
