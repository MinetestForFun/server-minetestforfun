
Doyousketch2's Stained Glass mod
ver 1.2

Image: http://oi47.tinypic.com/hst6s3.jpg

With alpha enabled: http://oi44.tinypic.com/5vraxf.jpg

==============================================================================

Dependencies: VanessaE's Unified Dyes, Calinou's More Blocks

to Install:

Unzip the mod file you just downloaded.

it should be something like: Doyousketch2-stained_glass-1.1.zip
or stained_glass-master.zip, depending on where you downloaded it from

rename the new folder that looks like: 
Doyousketch2-stained_glass-1.1 -or- stained_glass-master
to simply read "stained_glass"

then move it into your Minetest mods folder.

==============================================================================


Recipe for standard colors:

image: http://oi50.tinypic.com/1ibs7c.jpg

	dye
	super glow glass
	super glow glass
	super glow glass


Recipe for pastel colors:

image: http://oi45.tinypic.com/2wbvkti.jpg

	light dye
	white paint
	super glow glass
	super glow glass
	super glow glass


Recipe for faint colors:

image: http://oi45.tinypic.com/2wbvkti.jpg

	light dye
	white paint
	white paint
	super glow glass
	super glow glass
	super glow glass


All recipes produce three glowing stained glass blocks.
Pastel blocks give back an empty bucket.
Faint blocks give back two empty buckets.


==============================================================================


The Palette includes:

	red, orange, yellow, lime, green, aqua
	cyan, skyblue, blue, violet, magenta, redviolet

Full & half-saturation, medium and dark shades have been included
as well as light, pastel, and faint tints.


==============================================================================


Misc. Notes
-----------

Please don't try to use /give commands, the items are now in numerical format,
and it would be tough to try to explain it.

If you really want to try, it goes like this:

yellow    = 1
lime      = 2
green     = 3
aqua      = 4
cyan      = 5
skyblue   = 6
blue      = 7
violet    = 8
magenta   = 9
redviolet = 10
red       = 11
orange    = 12


however, minetest sees it in the order 10, 11, 12, 1, 2, 3...
so redviolet actually comes first.

and for whatever reason, minetest doesn't take blank spaces _ into consideration.
so the attributes just act like the next column of digits.

I had to offset them to keep it all in order.

Brightness:

dark   = 3
medium = 4
full   = 5

Saturation:

50%    = 6
full   = 7

so "Red, dark 50%"  would be: stained_glass:11_3_6
"Blue, medium full-saturation" is: stained_glass:7_4_7

then we get to the bright colors.

same hue numbers, 1 - 12
but the attributes are:

light  = 8
pastel = 9
faint  = 91

so "Violet, light" is: stained_glass:8_8
and ""Orange, faint" is: stained_glass:12_91

I think this is too much to keep track of, but I hope this explains things in case anybody else is developing code.
For everyday purposes, let the computer keep track of the registered nodes, and just pick them out with the menu instead.


==============================================================================


