#!/bin/bash
#Get servers list
set -f
string=$DEPLOY_SERVER
#Iterate servers for deploy and pull last commit
      echo "Deploy project on server ${array[i]}"    
      ssh ubuntu@$string "cd /opt && git pull origin master"