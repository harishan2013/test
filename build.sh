#!/usr/bin/env bash
#Get servers list
#set -f
#string=$DEPLOY_SERVER
#Iterate servers for deploy and pull last commit
      echo "Deploy project on server"    
      #ssh ubuntu@ec2-13-232-57-200.ap-south-1.compute.amazonaws.com "cd /opt && git clone http://Hariharan:SVR53S6usDk9ysxFDPB-@gitlab.com/mws-technology/MIGDataModel.git"
      apt-get update -qy
      apt-get install -y sshpass
      #sshpass -p $SSH_PRIVATE_KEY  rsync -avz -e ssh charlie@13.232.57.200:"cd /opt && git clone http://Hariharan:SVR53S6usDk9ysxFDPB-@gitlab.com/mws-technology/MIGDataModel.git"
      #sshpass -p ubuntu ssh ubuntu@13.232.57.200
      #sshpass -p charlie ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=password -o PubkeyAuthentication=no charlie@13.232.57.200 "cd /opt && sh test.sh"
      #sshpass -p $DEPLOY_PASS ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=password -o PubkeyAuthentication=no $DEPLOY_USER@$DEPLOY_SERVER "cd /opt && ls -lt"
      sshpass -p $DEPLOY_PASS ssh -o StrictHostKeyChecking=no -o PreferredAuthentications=password -o PubkeyAuthentication=no d.nandakumar@13.233.15.57 "cd /opt && ls -lt"