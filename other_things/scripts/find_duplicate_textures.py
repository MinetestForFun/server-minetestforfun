#!/usr/bin/python2
# -*- coding: UTF-8 -*-

## script to display diplicated textures in mods and subgame
## by Crabman
## ./find_duplicate_textures.py /path_to_/minetest-minetestforfun-server or ../../path_to_/minetest-minetestforfun-server or ../../

import sys, os, glob

def format_center(string, lt):
	# "     string     " lt=string total
	return (('{:^%s}' % lt).format(string) )

def format_left(string, lt):
	# "string     "   lt=string total
	return (('{:<%s}' % lt).format(string) )

def format_right(string, lt):
	# "     string"   lt=string total
	return (('{:>%s}' % lt).format(string) )


class Textures:
	def __init__(self):
		self.textures_list = dict()
		self.duplicated = 0
	
	def get_duplicate_nb(self):
		return self.duplicated
	
	def get_nb(self):
		return len(self.textures_list)
	
	def set_textures(self, files):
		for texture in files:
			path, name = os.path.split(texture)
			if self.textures_list.has_key(name):
				if len(self.textures_list[name]) == 1:
					self.duplicated += 1
				self.textures_list[name].append(path)
			else:
				self.textures_list[name] = [path]
	
	def show_duplicate(self):
		for t, l in self.textures_list.iteritems():
			nb = len(l)
			if nb > 1:
				print("%s: %s %s" % (nb, format_left(t, 40), l) )


if __name__ == "__main__":
	if len(sys.argv) <=1:
		print("Missing arg path!")
		sys.exit(1)
	
	if sys.argv[1].startswith("/"):
		dir_path = sys.argv[1]
	else:
		dir_path = os.path.join(os.getcwd(), sys.argv[1])
	
	try:
		os.chdir(dir_path)
	except Exception as err:
		print(err)
		sys.exit(1)
	
	T = Textures()
	# find in subgame/mods and mods
	for f in ["*/mods", "mods"]:
		files = glob.glob( os.path.join(f,'*/textures/*.png') ) # find in mods
		T.set_textures(files)
		files = glob.glob( os.path.join(f,'*/*/textures/*.png') ) # find in modpack
		T.set_textures(files)
	print("%s textures total    %s duplicated\n" % ( T.get_nb(), T.get_duplicate_nb() ) )
	T.show_duplicate()

