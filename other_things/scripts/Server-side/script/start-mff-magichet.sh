#!/bin/bash

DEBUG='/home/quentinbd/script/debug-mff-magichet.txt'
MOREDEBUG='/home/quentinbd/script/moredebug-mff-magichet.txt'

cd /home/quentinbd/mff-magichet

while true
	do
	sleep 5

	echo "----------------------" >>$MOREDEBUG
	echo "Server restarted at "`date` >>$MOREDEBUG
	echo "----------------------" >>$MOREDEBUG

	echo "0" >/tmp/players_c.txt

	/home/quentinbd/mff-magichet/bin/minetestserver \
		--world /home/quentinbd/mff-magichet/worlds/minetestforfun-magichet/ \
		--config /home/quentinbd/mff-magichet/minetest.conf \
		--gameid minetestforfun_magichet \
		--port 30091 \
#		--logfile $DEBUG

	sleep 25
done &>> $MOREDEBUG
