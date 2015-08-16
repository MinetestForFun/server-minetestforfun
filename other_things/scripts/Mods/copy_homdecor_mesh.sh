#!/bin/bash
#
# Script created by LeMagnesium on 4/18/15
# This script should be launched from the root of the clone or deeper in it
# It copies all the meshes from homdecor from the mmdb's copy I have to our
# own version
# @param : $1 or the fresh clone from the mmdb's path while $2 is the static
# path to our version

if [ -z $1 ]
then
	echo "Missing parameter : source"
else
	if [ -z $2 ]
	then
		echo "Missing parameter : target"
	else
		cp $1/lavalamp/models/* $2/lavalamp/models/
		cp $1/chains/models/* $2/chains/models/
		cp $1/computer/models/* $2/computer/models/
		cp $1/plasmascreen/models/* $2/plasmascreen/models/
		cp $1/homedecor_3d_extras/models/* $2/homedecor_3d_extras/models/
		cp $1/inbox/models/* $2/inbox/models/
		cp $1/homedecor/models/* $2/homedecor/models/
		cp $1/lrfurn/models/* $2/lrfurn/models/
		echo "Done."
	fi
fi
