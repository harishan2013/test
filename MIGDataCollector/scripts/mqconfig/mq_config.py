__author__ = 'naveen.krishnan'

import sys

import pika

from MIGDataCollector.config import config


class MQConfiguration(object):
    def __init__(self, connect=False):
        if connect:
            self.__connect_and_openchannel__()

    def showHelp(self):
        print('Valid options are')
        print('-c --> For initial setup of the exchange, queue and bindings')
        print('-del --> For deletion of the exchange, queue and bindings')
        print('-h --> For showing the help')
        # TODO to implement in later versions
        print('-v --> For getting the current mq version ')
        print('-u --> For upgrade to a specific version')
        print('-d --> For downgrading to a specific version')

    def __connect_and_openchannel__(self):
        print('Connecting to the MQ Server')
        self.credentials = pika.PlainCredentials(config.MESSAGE_QUEUE_USERNAME, config.MESSAGE_QUEUE_PASSWORD)
        self.connection = pika.BlockingConnection(
            pika.ConnectionParameters(config.MESSAGE_QUEUE_SERVER, config.MESSAGE_QUEUE_PORT,
                                      config.MESSAGE_QUEUE_VHOST, self.credentials))
        self.channel = self.connection.channel()
        print('Connection established to the MQ Server')

    # --create the basic exchange, queue and the bindings
    def create(self, mqversion, queue_name, routing_key):
        print('-' * 100)
        print('Setting up the Rabbit mq exchange, queues and configuring the server')
        try:
            if mqversion is 'null':
                queue_name = config.MESSAGE_QUEUE_NAME
                routing_key = config.MESSAGE_QUEUE_ROUTING_KEY
                self.channel.exchange_declare(exchange=config.MESSAGE_QUEUE_EXCHANGE, exchange_type='direct',
                                              durable=True, auto_delete=False)
            self.channel.queue_declare(queue=queue_name, durable=True, auto_delete=False)
            self.channel.queue_bind(exchange=config.MESSAGE_QUEUE_EXCHANGE, queue=queue_name,
                                    routing_key=routing_key)
            print('-' * 100)
            print('Setup done')
        except Exception as exception:
            print('Problem setting up the queue')
            print(exception)
        finally:
            self.channel.close()
            self.connection.close()

    # --clean_all - remove all and clean the exchanges, queues and bindings
    def clean_all(self, mqversion, queue_name, routing_key):
        print('-' * 100)
        print('Deleting the Rabbit mq exchange, queues and configuring the server')
        try:
            if mqversion is 'null':
                queue_name = config.MESSAGE_QUEUE_NAME
                routing_key = config.MESSAGE_QUEUE_ROUTING_KEY
                self.channel.exchange_delete(exchange=config.MESSAGE_QUEUE_EXCHANGE, if_unused=False)
            self.channel.queue_unbind(exchange=config.MESSAGE_QUEUE_EXCHANGE, queue=str(queue_name),
                                      routing_key=str(routing_key))
            self.channel.queue_delete(queue=str(queue_name), if_unused=False, if_empty=False)
            print('-' * 100)
            print('Delete done')
        except Exception as exception:
            print('Problem deleting up the queue' + exception)
        finally:
            self.channel.close()
            self.connection.close()

    """
    TODO: To change the create queue is generic with version iteration!
    """
    # --upgrade to current version if not any version specified
    def upgrade_to_version(self, mq_version, queue_name, routing_key):
        print('-' * 100)
        if mq_version == '1.1.0':
            try:
                self.create(mq_version, config.MESSAGE_QUEUE_NAME_NOTIFICATION,
                            config.MESSAGE_QUEUE_NAME_ROUTING_KEY_NOTIFICATION)
            except Exception as exception:
                print('Problem upgrading the queue' + exception)

    """
    TODO: To change the delete queue is generic with version iteration!
    """
    # --downgrade to current version if not any version specified
    def downgrade_to_version(self, mq_version, queue_name, routing_key):
        print('-' * 100)
        if mq_version == '1.0.0':
            try:
                self.clean_all(mq_version, config.MESSAGE_QUEUE_NAME_NOTIFICATION,
                               config.MESSAGE_QUEUE_NAME_ROUTING_KEY_NOTIFICATION)
            except Exception as exception:
                print('Problem downgrading the queue' + exception)

    def call(self, function, mq_version):
        function(mq_version, "", "")


if __name__ == '__main__':
    print('-' * 100)
    mq = MQConfiguration()
    if len(sys.argv) <= 1:
        option = '-h'
    else:
        option = sys.argv[1] if len(sys.argv) > 1 else 'null'
        version = sys.argv[2] if len(sys.argv) > 2 else 'null'
    arg_options = {'-c': mq.create, '-del': mq.clean_all, '-h': mq.showHelp, '-u': mq.upgrade_to_version,
                   '-d': mq.downgrade_to_version}

    if option == '-h' or option not in arg_options.keys():
        mq.call(arg_options['-h'])
    else:
        mq = MQConfiguration(connect=True)
        arg_options = {'-c': mq.create, '-del': mq.clean_all, '-h': mq.showHelp, '-u': mq.upgrade_to_version,
                       '-d': mq.downgrade_to_version}
        mq.call(arg_options[option], version)
    print('-' * 100)
