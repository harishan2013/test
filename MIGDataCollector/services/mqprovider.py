__author__ = 'naveen.krishnan'

import pika

from MIGDataCollector.utils import logger
from MIGDataCollector.config import config

log = logger.MIGLogger.getLogger(__name__)


class MQProvider(object):
    _connection = None

    def get_mq_connection(self):  # return a pika connection
        try:
            log.info("Creating new Rabbitmq connection")
            credentials = pika.PlainCredentials(config.MESSAGE_QUEUE_USERNAME, config.MESSAGE_QUEUE_PASSWORD)
            parameters = pika.ConnectionParameters(host=config.MESSAGE_QUEUE_SERVER,
                                                   port=config.MESSAGE_QUEUE_PORT,
                                                   virtual_host=config.MESSAGE_QUEUE_VHOST,
                                                   credentials=credentials)
            log.info(
                "Opening connection to the message queue running in Server : {} port : {}".format(
                    config.MESSAGE_QUEUE_SERVER, config.MESSAGE_QUEUE_PORT))
            MQProvider._connection = pika.BlockingConnection(parameters)
            log.debug("Connection created")
        except Exception as exception:
            raise exception
        return MQProvider._connection
