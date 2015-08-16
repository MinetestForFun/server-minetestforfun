#!/bin/bash

DEBUG='/home/quentinbd/script/debug-mff-hg.txt'
MOREDEBUG='/home/quentinbd/script/moredebug-mff-hg.txt'

cd /home/quentinbd/mff-hg

while true
	do
	sleep 5

	echo "----------------------" >>$MOREDEBUG
	echo "Server restarted at "`date` >>$MOREDEBUG
	echo "----------------------" >>$MOREDEBUG

	echo "0" >/tmp/players_c.txt

	/home/quentinbd/mff-hg/bin/minetestserver \
		--world /home/quentinbd/mff-hg/worlds/minetestforfun-hg/ \
		--config /home/quentinbd/mff-hg/minetest.conf \
		--gameid hungry_games \
		--port 30042 \
#		--logfile $DEBUG

	sleep 25
done &>> $MOREDEBUG
