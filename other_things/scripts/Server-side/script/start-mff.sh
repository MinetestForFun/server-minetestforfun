#!/bin/bash

DEBUG='/home/quentinbd/script/debug-mff.txt'
MOREDEBUG='/home/quentinbd/script/moredebug-mff.txt'

cd /home/quentinbd/mff

while true
	do
	sleep 5

	echo "----------------------" >>$MOREDEBUG
	echo "Server restarted at "`date` >>$MOREDEBUG
	echo "----------------------" >>$MOREDEBUG

	echo "0" >/tmp/players_c.txt

	/home/quentinbd/mff/bin/minetestserver \
		--world /home/quentinbd/mff/worlds/minetestforfun/ \
		--config /home/quentinbd/mff/minetest.conf \
		--gameid minetestforfun_game \
		--port 30001 \
#		--logfile $DEBUG

	sleep 25
done &>> $MOREDEBUG

