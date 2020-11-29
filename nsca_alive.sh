#!/bin/bash
# nsca_alive.sh script to keep sending an "alive" message to show that a client is currently up and running.
# This will be displayed under "passive_check_alive" in Nagios for each of the client machines being onitored passively.
# for use by NSCA for Nagios.
#
# By George Jones
# Github: https://github.com/mrjonestech
# Dockerhub: https://hub.docker.com/u/misterjonestech/

PLUGINS='/usr/lib/nagios/plugins' #Change this if your Nagios plugins are installed elsewhere
SERVER=localhost #this is the nagios server's address/fqdn. In this case, we're using an ssh tunnel with the server being reachable via localhost
PORTNUMBER=5667 #change this if necessary
HOST=$HOSTNAME

SERVICE="passive_check_alive"
TEXT="Alive"

echo -e "${HOST};${SERVICE};0;${TEXT}" | /usr/sbin/send_nsca -H $SERVER -p $PORTNUMBER -d ";" -c /etc/send_nsca.cfg

exit 0
