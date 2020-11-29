#!/bin/bash
# ca_log.sh script to check /var/log and send the data formatted 
# for use by NSCA for Nagios. 
#
# By George Jones
# Github: https://github.com/mrjonestech
# Dockerhub: https://hub.docker.com/u/misterjonestech/

PLUGINS='/usr/lib/nagios/plugins' #Change this if your Nagios plugins are installed elsewhere
SERVER=localhost #this is the nagios server's address/fqdn. In this case, we're using an ssh tunnel with the server being reachable via localhost
PORTNUMBER=5667 #change this if necessary
HOST=$HOSTNAME

SERVICE='passive_check_log'
TEXT=$( ${PLUGINS}/check_disk -w 20% -c 10% -p /var/log ) ;
RET=$?

echo -e "${HOST};${SERVICE};${RET};${TEXT}" | /usr/sbin/send_nsca -H $SERVER -p $PORTNUMBER -d ";" -c /etc/send_nsca.cfg

exit 0
#eof
