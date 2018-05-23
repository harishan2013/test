__author__ = 'naveen.krishnan'

from tornado.testing import AsyncHTTPTestCase
import MIGDataCollector.webapp

class HttpTestBaseHandler(AsyncHTTPTestCase):
    def setUp(self):
        super(HttpTestBaseHandler, self).setUp()

    def get_app(self):
        return MIGDataCollector.webapp.make_app()

