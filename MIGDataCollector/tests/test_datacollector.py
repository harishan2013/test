__author__ = 'naveen.krishnan'

from MIGDataCollector.tests import httptestbasehandler

class HttpBaseHandler(httptestbasehandler.HttpTestBaseHandler):
    def test_root_url_with_http_get(self):
        response = self.fetch('/', method='GET')
        self.assertEqual(response.code, 405)

    def test_root_url_with_http_post(self):
        post_args = 'test data'
        response = self.fetch('/', method='POST', body=post_args)
        self.assertEqual(response.code, 202)

    def test_cas_url_with_http_post(self):
        post_args = 'test data'
        response = self.fetch('/cas', method='POST', body=post_args)
        self.assertEqual(response.code, 202)