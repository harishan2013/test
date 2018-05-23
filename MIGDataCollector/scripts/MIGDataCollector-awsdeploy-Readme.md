Steps to install MIGDataCollector in aws instance:



Login into aws instance in linux box:

miguser@ec2-52-38-167-66.us-west-2.compute.amazonaws.com

password :[password]

1.Create a newuser

sudo useradd -d /home/newuser -m newuser

sudo passwd [newuser pwd]

2.To get Admin Privileages update the below in visudo file,

sudo visudo

add "newuser ALL=(ALL:ALL) ALL"

3.Restart the Terminal:

sudo /etc/init.d/ssh restart

4.Login to check the user created for the aws instance:

ssh newuser @ec2-54-218-37-172.us-west-2.compute.amazonaws.com

5.To get the newuser login name as newuser@54-218-37-172 instead of $ please do the below update in passwd file,

sudi vi /etc/passwd

change "/bin/sh" to "/bin/bash" for newuser.

Login will be newuser@54-218-37-172

6.create mig folder in /var/log/ & /opt path and add the ownership to the newuser:

sudo mkdir -p /var/log/mig && sudo chown newuser:newuser /var/log/mig

sudo mkdir -p /opt/mig && sudo chown newuser:newuser/opt/mig

7.Create Virtual Environment to install the MIGDataCollector package:

cd /opt/mig

Install virtualenv  using the below command if virutalenv is not installed already,

Pip install virtualenv

Virtualenv DC

Source DC/bin/activate

(DC) sudo pip install   --upgrade --no-deps --force-reinstall --trusted-host 52.38.167.66 --index-url http://[username]:[password]@52.38.167.66:8500/simple MIGDataCollector

8.Install other package Dependencies using pip install of the requirements file in the project folder if not being installed during the .whl file installation

  /opt/mig/DC/lib/python2.7/site-packages/MIGDataCollector > pip install -r requirements.file

9.Update the configuration file present in the config folder if there is change in the port Information and the default port is 8000.

10.All the logs should go into /var/log/mig/ which we already created in the initial steps (ref:Example1).

11.Set the pythonpath environment variable globally in .bashrc file and also add the pythonpath in Upstart .conf file (ref:Example1).

12.Register Services with the system using Upstart Daemon script (ref:example1)

   List the steps to configure the services:
   
1.Create .conf file in /etc/init folder (ex: /etc/init/dcollect.conf)

2.Update the script as like in the example below,

Example1:

#!upstart

description "MIGDataCollector Server"

env USER=newuser

env PYTHONPATH=/opt/mig/DC/lib/python2.7/site-packages/MIGDataCollector

start on startup

stop on shutdown

respawn


export $PYTHONPATH

exec start-stop-daemon --start --make-pidfile --pidfile /var/run/dcollect.pid --
chuid $USER  --exec /usr/bin/python /opt/mig/DC/lib/python2.7/site-packages/MIGDataCollector/DataCollector/DataCollector.py 


3.Run the below cmd to start the service,

  sudo service dcollect start

4.dcollect.pid will be generated in /var/run/dcollect.pid.

5.log file will be generated in /var/log/mig/dcollect.log.

6.Run the below cmd  to stop the service,

  sudo service dcollect stop

Please change the pythonpath and python .py file path as per your project specified path.


