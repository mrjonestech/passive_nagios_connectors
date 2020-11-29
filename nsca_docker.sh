#!/bin/bash
#Check_docker for Nagios
#
# By George Jones
# Github: https://github.com/mrjonestech
# Dockerhub: https://hub.docker.com/u/misterjonestech/

SERVER=localhost #this is the nagios server's address/fqdn. In this case, we're using an ssh tunnel with the server being reachable via localhost
PORTNUMBER=5667 #change this if necessary
HOST=$HOSTNAME

dockerstatus=$( systemctl is-active docker )
cond1="active"
cond2="inactive"
cond3="unknown"

if [ "$dockerstatus" = "$cond1" ]; then
	echo "$HOST;passive_check_docker;0;OK - $dockerstatus" | /usr/sbin/send_nsca -H $SERVER -p $PORTNUMBER -d ";" -c /etc/send_nsca.cfg
	exit 0
elif [ "$dockerstatus" = "$cond2" ]; then
        echo "$HOST;passive_check_docker;2;CRITICAL - $dockerstatus" | /usr/sbin/send_nsca -H $SERVER -p $PORTNUMBER -d ";" -c /etc/send_nsca.cfg
        exit 2
elif [ "$dockerstatus" = "$cond3" ]; then
        echo "$HOST;passive_check_docker;3;UNKNOWN - $dockerstatus" | /usr/sbin/send_nsca -H $SERVER -p $PORTNUMBER -d ";" -c /etc/send_nsca.cfg
        exit 3
fi
