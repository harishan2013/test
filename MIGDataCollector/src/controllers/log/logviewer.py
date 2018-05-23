__author__ = 'naveen.krishnan'

import os

class LogViewer(object):

    @staticmethod
    def getstaticpath():
        dirname = os.path.dirname(__file__)
        STATIC_PATH = dirname + os.path.sep + '..' + os.path.sep + '..' + os.path.sep + '..' + os.path.sep + 'static'
        return STATIC_PATH