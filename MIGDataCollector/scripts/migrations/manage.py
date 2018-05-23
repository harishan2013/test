#!/usr/bin/env python
from migrate.versioning.shell import main
from MIGDataCollector.config import config

databaseURL = ''+config.DRIVER+'+pymysql://'+config.USER+':'+config.PASSWORD+'@'+config.HOST+'/'+config.DATABASE+''

if __name__ == '__main__':
    # mysql-python library is not supported in windows, added PyMySQL library for all OS support
    main(url=databaseURL, debug='False', repository='migrations')


