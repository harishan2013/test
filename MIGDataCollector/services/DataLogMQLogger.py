__author__ = 'naveen.krishnan'

import pika

from MIGDataCollector.services import mqprovider
from MIGDataCollector.utils import logger

log = logger.MIGLogger.getLogger(__name__)


class DatalogMQLogger(object):
    def __init__(self, config, data, headers):
        try:
            log.info("constructor is invoked")
            self.host = config.MESSAGE_QUEUE_SERVER
            self.port = config.MESSAGE_QUEUE_PORT
            self.user = config.MESSAGE_QUEUE_USERNAME
            self.passwd = config.MESSAGE_QUEUE_PASSWORD
            self.exchange = config.MESSAGE_QUEUE_EXCHANGE
            self.queue = config.MESSAGE_QUEUE_NAME
            self.routing_key = config.MESSAGE_QUEUE_ROUTING_KEY
            self.virtualhost = config.MESSAGE_QUEUE_VHOST
            self.msg = data
            self.headers = headers
            self.connect_and_publish()
        except Exception as exception:
            raise exception

    def connect_and_publish(self):
        try:
            log.info("Initiating open connection to the message queue")
            self.connection = mqprovider.MQProvider().get_mq_connection()
            self.channel = self.connection.channel()
            self.channel.exchange_declare(exchange=self.exchange, durable=True)
            self.channel.queue_declare(queue=self.exchange, durable=True)
            self.push_data_to_messagequeue()
            log.info("Done publishing message to the message queue")
        except Exception as exception:
            raise exception

    def push_data_to_messagequeue(self):
        try:
            log.debug("Entered into DatalogMQLogger > push_data_to_messagequeue()")
            message = self.msg
            log.info("Message -- {0} -- is ready to publish".format(message))
            default_version = '1.0'
            default_format = 'csv'
            properties = pika.BasicProperties(headers={'MIPVersion': self.headers.get('MIPVersion') or default_version,
                                                       'Content-Type': self.headers.get(
                                                           'Content-Type') or default_format})
            self.channel.basic_publish(exchange=self.exchange,
                                       routing_key=self.routing_key,
                                       body=message,
                                       properties=properties)
            log.info("Message -- {0} -- is ready to publish".format(message))
            log.info("Message published successfully")
            log.debug("Completed publishing the message to the queue")
            self.channel.close()
            self.connection.close()

        except Exception as exception:
            raise exception
