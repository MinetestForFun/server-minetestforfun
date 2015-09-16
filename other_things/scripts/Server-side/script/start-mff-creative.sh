#!/bin/bash

DEBUG='/home/quentinbd/script/debug-mff-creative.txt'
MOREDEBUG='/home/quentinbd/script/moredebug-mff-creative.txt'

cd /home/quentinbd/mff-creative

while true
	do
	sleep 5

	echo "----------------------" >>$MOREDEBUG
	echo "Server restarted at "`date` >>$MOREDEBUG
	echo "----------------------" >>$MOREDEBUG

	echo "0" >/tmp/players_c.txt

	/home/quentinbd/mff-creative/bin/minetestserver \
		--world /home/quentinbd/mff-creative/worlds/minetestforfun-creative/ \
		--config /home/quentinbd/mff-creative/minetest.conf \
		--gameid minetestforfun_creative \
		--port 30091 \
#		--logfile $DEBUG

	sleep 25
done &>> $MOREDEBUG
