#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import sys, os

# if used on windows ??
# use os.path.join() -> path sep win "\" or linux "/"
p_textures = os.path.join("u_skins", "textures")
p_meta = os.path.join("u_skins", "meta")

try:
	f = open("removed_skins.txt", "r")
	skins_exclued = f.readlines()
except IOError as err:
	sys.stderr.write("%s\n" % err)
	sys.exit(1)
else:
	f.close()

print("il y a %d skins exclus." % len(skins_exclued))

for skin in skins_exclued:
	# if not int value, ignore
	try:
		skin = "character_%s" % int(skin.strip())
	except ValueError as err:
		sys.stderr.write("%s\n" % err)
		continue
	# for texture, preview and meta files
	for f_skin in ( os.path.join(p_textures,"%s.png" % skin),
					os.path.join(p_textures,"%s_preview.png" % skin),
					os.path.join(p_meta, "%s.txt" % skin) ):
		if os.path.exists(f_skin):
			try:
				os.remove(f_skin)
			except exception as err:
				print(err)
				pass
			else:
				print('skin "%s" effacé' % f_skin)

sys.exit(0)
