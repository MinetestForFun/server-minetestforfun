#!/usr/bin/env python3
# -*- encoding: utf-8 -*-
##########################
## Skin Preview Generator
## ßÿ Mg / LeMagnesium
## License : WTFPL
##

import sys
import os.path

from PIL import Image

for arg in sys.argv[1:]:
	try:
		open(arg)
	except Exception as err:
		print("Couldn't open {} : {}".format(os.path.basename(arg), err))
		continue

	im = Image.open(arg).convert("RGBA")
	print("Opened {}".format(os.path.basename(arg)))

	s = im.size
	if not s[0] == s[1] * 2:
		print("Invalid size : {}".format(s))
		continue

	cw = int(s[0] / 8)

#	backp = Image.new("RGBA", (cw * 2, cw * 4))

	head = im.crop(box = (cw, cw, cw * 2, cw * 2))
	chest = im.crop(box = (
		cw * 2 + int(1/2.0 * cw),
		cw * 2 + int(1/2.0 * cw),
		cw * 3 + int(1/2.0 * cw),
		s[1],
	))
	leftarm = im.crop(box = (
		5 * cw + int(cw / 2),
		2 * cw + int(cw / 2),
		6 * cw,
		s[1]
	))
	rightarm = im.crop(box = (
		6 * cw,
		2 * cw + int(cw / 2),
		6 * cw + int(cw / 2),
		s[1]
	))
	leftleg = im.crop(box = (
		int(1/2 * cw),
		2 * cw + int(cw / 2),
		cw,
		s[1]
	))

	# Paste
	front = Image.new("RGBA", (
		cw * 2, # + int(2/8.0 * cw),
		cw * 4
	))
	for y in range(front.size[0]):
		for x in range(front.size[1]):
			front.putpixel((y, x), (255, 255, 255, 0))

	front.paste(head, box = (
		int(cw / 2),
		0,
	))

	front.paste(chest, box = (
		int(cw / 2),
		cw
	))

	front.paste(leftarm, box = (
		0,
		cw
	))

	front.paste(leftarm, box = (
		int(1.5 * cw),
		cw
	))

	front.paste(leftleg, box = (
		int(cw / 2),
		int(2.5 * cw)
	))

	front.paste(leftleg, box = (
		cw,
		int(2.5 * cw)
	))

	exts = os.path.splitext(arg)
	front.save("{}_preview{}".format(exts[0], "".join(exts[1:])))
