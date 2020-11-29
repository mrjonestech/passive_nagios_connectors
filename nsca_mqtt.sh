#!/bin/bash
#nsca_mqtt.sh for Nagios
#Retrieve the active/inactive/unknown status of Mosquitto and send it to the Nagios server.
#
# By George Jones
# Github: https://github.com/mrjonestech
# Dockerhub: https://hub.docker.com/u/misterjonestech/

SERVER=localhost #this is the nagios server's address/fqdn. In this case, we're using an ssh tunnel with the server being reachable via localhost
PORTNUMBER=5667 #change this if necessary
HOST=$HOSTNAME

mqttstatus=$( systemctl is-active mosquitto )
cond1="active"
cond2="inactive"
cond3="unknown"

if [ "$mqttstatus" = "$cond1" ]; then
	echo "${HOST};passive_check_mosquitto;0;OK - $mqttstatus" | /usr/sbin/send_nsca -H $SERVER -p $PORTNUMBER -d ";" -c /etc/send_nsca.cfg
	exit 0
elif [ "$mqttstatus" = "$cond2" ]; then
        echo "${HOST};passive_check_mosquitto;2;CRITICAL - $mqttstatus" | /usr/sbin/send_nsca -H $SERVER -p $PORTNUMBER -d ";" -c /etc/send_nsca.cfg
        exit 2
elif [ "$mqttstatus" = "$cond3" ]; then
        echo "${HOST};passive_check_mosquitto;3;UNKNOWN - $mqttstatus" | /usr/sbin/send_nsca -H $SERVER -p $PORTNUMBER -d ";" -c /etc/send_nsca.cfg
        exit 3
fi

