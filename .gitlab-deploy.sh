#!/bin/bash
#Get servers list
set -f
string=$DEPLOY_SERVER
#Iterate servers for deploy and pull last commit
      echo "Deploy project on server ${array[i]}"    
      ssh ubuntu@$string "cd /opt && git clone http://Hariharan:SVR53S6usDk9ysxFDPB-@gitlab.com/mws-technology/MIGDataModel.git"