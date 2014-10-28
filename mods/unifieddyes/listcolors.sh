#!/bin/bash

# This program lists out the RGB triads for the colors used in each of the 89
# dyes found in the Unified Dyes mod.

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

pushd . >/dev/null

cd textures

echo -e "\n\nFull-saturation colors:"
echo -e "-----------------------\n"

for i in `ls *dark*.png|grep -v _s50|grep -v paint|grep -v black` ; do
	rgb=`convert $i -crop 1x1+8+11 -depth 8 txt: |grep "0,0: (" |cut -f 2- -d "(" |cut -f 1-3 -d ","`
	color=`basename $i .png | sed 's/_/ /g; s/unifieddyes //; s/s50/50% saturation/'`
	printf "%-32s %-12s %s\n" "$color" "$rgb" "$i"
done |sort

for i in `ls *medium*.png|grep -v _s50|grep -v paint|grep -v black` ; do
	rgb=`convert $i -crop 1x1+8+11 -depth 8 txt: |grep "0,0: (" |cut -f 2- -d "(" |cut -f 1-3 -d ","`
	color=`basename $i .png | sed 's/_/ /g; s/unifieddyes //; s/s50/50% saturation/'`
	printf "%-32s %-12s %s\n" "$color" "$rgb" "$i"
done |sort

for i in `ls *.png|grep -v medium |grep -v dark|grep -v _s50|grep -v paint|grep -v black|grep -v titanium` ; do
	rgb=`convert $i -crop 1x1+8+11 -depth 8 txt: |grep "0,0: (" |cut -f 2- -d "(" |cut -f 1-3 -d ","`
	color=`basename $i .png | sed 's/_/ /g; s/unifieddyes //; s/s50/50% saturation/'`
	printf "%-32s %-12s %s\n" "$color" "$rgb" "$i"
done |sort


echo -e "\nLow-saturation colors:"
echo -e "----------------------\n"

for i in `ls *dark*_s50.png|grep -v paint|grep -v black` ; do
	rgb=`convert $i -crop 1x1+8+11 -depth 8 txt: |grep "0,0: (" |cut -f 2- -d "(" |cut -f 1-3 -d ","`
	color=`basename $i .png | sed 's/_/ /g; s/unifieddyes //; s/s50/50% saturation/'`
	printf "%-32s %-12s %s\n" "$color" "$rgb" "$i"
done |sort

for i in `ls *medium*_s50.png|grep -v paint|grep -v black` ; do
	rgb=`convert $i -crop 1x1+8+11 -depth 8 txt: |grep "0,0: (" |cut -f 2- -d "(" |cut -f 1-3 -d ","`
	color=`basename $i .png | sed 's/_/ /g; s/unifieddyes //; s/s50/50% saturation/'`
	printf "%-32s %-12s %s\n" "$color" "$rgb" "$i"
done |sort

for i in `ls *_s50.png|grep -v dark|grep -v medium|grep -v paint|grep -v black` ; do
	rgb=`convert $i -crop 1x1+8+11 -depth 8 txt: |grep "0,0: (" |cut -f 2- -d "(" |cut -f 1-3 -d ","`
	color=`basename $i .png | sed 's/_/ /g; s/unifieddyes //; s/s50/50% saturation/'`
	printf "%-32s %-12s %s\n" "$color" "$rgb" "$i"
done |sort

echo -e "\nGreyscale:"
echo -e "----------\n"

printf "%-32s %-12s %s\n" "black" "  0,  0,  0" "unifieddyes_black.png"
printf "%-32s %-12s %s\n" "dark grey" " 64, 64, 64" "unifieddyes_darkgrey_paint.png"
printf "%-32s %-12s %s\n" "medium grey" "128,128,128" "unifieddyes_grey_paint.png"
printf "%-32s %-12s %s\n" "light grey" "192,192,192" "unifieddyes_lightgrey_paint.png"
printf "%-32s %-12s %s\n" "white" "255,255,255" "unifieddyes_white_paint.png"

popd >/dev/null
