#!/bin/bash

DEBUG='/home/quentinbd/script/debug-mff-skyblock.txt'
MOREDEBUG='/home/quentinbd/script/moredebug-mff-skyblock.txt'

cd /home/quentinbd/mff-skyblock

while true
	do
	sleep 5

	echo "----------------------" >>$MOREDEBUG
	echo "Server restarted at "`date` >>$MOREDEBUG
	echo "----------------------" >>$MOREDEBUG

	echo "0" >/tmp/players_c.txt

	/home/quentinbd/mff-skyblock/bin/minetestserver \
		--world /home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/ \
		--config /home/quentinbd/mff-skyblock/minetest.conf \
		--gameid minetestforfun_skyblock \
		--port 30054 \
#		--logfile $DEBUG

	sleep 25
done &>> $MOREDEBUG
