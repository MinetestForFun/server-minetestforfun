#!/bin/bash

# This program auto-generates colorized textures for all 89 of the Unified 
# Dyes colors, based on one or two input files.

# Copyright (C) 2012-2013, Vanessa Ezekowitz
# Email: vanessaezekowitz@gmail.com
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

if [ -z "`which convert`" ] ; then {
	echo "Please install Imagemagick."
	exit 1
} fi

if [ -z "`which bc`" ] ; then {
	echo "Please install GNU bc."
	exit 1
} fi

if [ $1 = "-t" ] ; then {
	TINT_OVERLAY=$1
	BASE=$2
	COMPOSITE=$3
} else {
	TINT_OVERLAY=""
	BASE=$1
	COMPOSITE=$2
} fi

if [ -z $1 ] || [ $1 == "--help" ] || [ $1 == "-h" ] || [[ $1 == "-t" && -z $3 ]] ; then {

	echo -e "\nUsage:
\ngentextures.sh basename [overlay_filename]
gentextures.sh -t basename overlay_filename

\nThis script requires up to three parameters which supply the base 
filename of the textures, an optional .png overlay, and possibly the 
'-t' switch.  The 'basename' is the first part of the filename that your 
textures will use when your mod is done, which should almost always be 
the same as the one-word name of your mod.  For example, if you supply 
the word 'mymod', this script will produce filenames like mymod_red.jpg 
or 'mymod_dark_blue_s50.jpg'.  The texture that this script will read 
and recolor is derived from this parameter, and will be of the form 
'basename_base.jpg', i.e. 'mymod_base.jpg'. \nYou can also supply an 
overlay image filename.  This image needs to be a .png or .gif or some 
other alpha-capable format supported by ImageMagick, and will be 
composited onto the output files after they have been colorized, but 
without being modified.  This is useful when you have some part of your 
base image that will either get changed undesirably (for example, the 
mortar among several bricks, or the shading detail of a stone pattern).  
Simply draw two images: one containing the whole image to be colored, 
and one containing the parts that should not be changed, with either 
full or partial alpha transparency where the re-colored base image 
should show through.  Skilled use of color and alpha on this overlay can 
lead to some interesting effects. \nIf you add '-t' as the first 
parameter, the script will switch to 'tint overlay' mode.  For this mode 
to work, you must also supply the base name as usual, and you must 
include an overlay image filename.  Rather than re-color the base 
texture, the script will alter the hue/saturation/value of the overlay 
texture file instead, and leave the base texture unchanged.  When using 
this mode, the base texture should be drawn in some neutral color, but 
any color is fine if it results in what you wanted.\n"


	exit 1
} fi

if [[ ! -e $BASE"_base.jpg" ]]; then {
	echo -e "\nThe basename '"$BASE"_base.jpg' was not found."
        echo -e "\nAborting.\n"
	exit 1
} fi

if [[ ! -z $COMPOSITE && ! -e $COMPOSITE ]]; then {
	echo -e "\nThe requested composite file '"$COMPOSITE"' was not found."
        echo -e "\nAborting.\n"
	exit 1
} fi

convert $BASE"_base.jpg" -modulate 1,2,3 tempfile.jpg 1>/dev/null 2>/dev/null

if (( $? )) ; then {
	echo -e "\nImagemagick failed while testing the base texture file."
	echo -e "\nEither the base file '"$BASE"_base.jpg' isn't an image,"
	echo "or it is broken, or Imagemagick itself just didn't work."
	echo -e "\nPlease check and correct your base image and try again."
	echo -e "\nAborting.\n"
	exit 1
} fi

if [ ! -z $COMPOSITE ] ; then {
	convert $BASE"_base.jpg" -modulate 1,2,3 $COMPOSITE -composite tempfile.jpg 1>/dev/null 2>/dev/null

	if (( $? )) ; then {
		echo -e "\nImagemagick failed while testing the composite file."
		echo -e "\nEither the composite file '"$COMPOSITE"' isn't an image"
		echo "or it is broken, or Imagemagick itself just didn't work."
		echo -e "\nPlease check and correct your composite image and try again."
		echo -e "\nAborting.\n"
		exit 1
	} fi
} fi

rm tempfile.jpg

base_colors="red orange yellow lime green aqua cyan skyblue blue violet magenta redviolet"

echo -e -n "\nGenerating filenames based on "$BASE"_base.jpg"
if [ ! -z $COMPOSITE ] ; then {
	echo ","
	echo -n "using "$COMPOSITE" as an overlay"
} fi

if [ ! -z $TINT_OVERLAY ] ; then {
	echo ","
	echo -n "and tinting the overlay instead of the base texture"
} fi

echo -e "...\n"

mkdir -p generated-textures

function generate_texture () {
	name=$1
	h=$2
	s=$3
	v=$4
	if [ -z $TINT_OVERLAY ]; then {
		if [ -z $COMPOSITE ]; then {
			convert $BASE"_base.jpg" -modulate $v,$s,$h -quality 97 "generated-textures/"$BASE"_"$name".jpg"
		} else {
			convert $BASE"_base.jpg" -modulate $v,$s,$h -quality 97 $COMPOSITE -composite "generated-textures/"$BASE"_"$name".jpg"
		} fi
	} else {
		convert $COMPOSITE -modulate $v,$s,$h -quality 97 MIFF:- | composite MIFF:- $BASE"_base.jpg" "generated-textures/"$BASE"_"$name".jpg"
	} fi
}

hue=0
for color_name in $base_colors ; do
	hue2=`echo "scale=10; ("$hue"*200/360)+100" |bc`
	echo $color_name "("$hue" degrees)"
	echo "     dark"
	generate_texture "dark_"$color_name $hue2 100 33
	echo "     medium"
	generate_texture "medium_"$color_name $hue2 100 66
	echo "     full"
	generate_texture $color_name $hue2 100 100
	echo "     light"
	generate_texture "light_"$color_name $hue2 100 150
	echo "     dark, 50% saturation"
	generate_texture "dark_"$color_name"_s50" $hue2 50 33
	echo "     medium, 50% saturation"
	generate_texture "medium_"$color_name"_s50" $hue2 50 66
	echo "     full, 50% saturation"
	generate_texture $color_name"_s50" $hue2 50 100 
	hue=$((hue+30))
done

echo "greyscales"
echo "     black"
generate_texture black 0 0 15
echo "     dark grey"
generate_texture darkgrey 0 0 50
echo "     medium grey"
generate_texture grey 0 0 100
echo "     light grey"
generate_texture lightgrey 0 0 150
echo "     white"
generate_texture white 0 0 190
