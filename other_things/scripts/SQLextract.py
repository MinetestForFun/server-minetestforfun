#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import sys, os, sqlite3

home = os.environ.get("HOME")
db = "%s/rollback/rollback.sqlite" % (home)

#############
## Node IDs
#

def get_node_ids():
	try:
		conn = sqlite3.connect(db)
		cur = conn.cursor()
	except sqlite3.OperationalError as err:
		print(err)
		sys.exit(1)
	try:
		cur.execute("SELECT * FROM node")
	except sqlite3.OperationalError as err:
		print(err)
		sys.exit(1)
	else:
		result = cur.fetchall()
	finally:
		cur.close()
		conn.close()
	return(result)

node_ids = get_node_ids()

def get_node(nodeid):
	if not nodeid:
		return None
	else:
		return node_ids[nodeid-1][1]

###############
## Player IDs
#

def get_player_ids():
	try:
		conn = sqlite3.connect(db)
		cur = conn.cursor()
	except sqlite3.OperationalError as err:
		print(err)
		sys.exit(1)
	try:
		cur.execute("SELECT * FROM actor")
	except sqlite3.OperationalError as err:
		print(err)
		sys.exit(1)
	else:
		result = cur.fetchall()
	finally:
		cur.close()
		conn.close()
	return result

player_ids = get_player_ids()

def get_player(id):
	if id:
		return player_ids[id-1][1][len("player:"):]
	else:
		return None

########################################################################
## Utilities
#

def ston(a):
	"""
		Returns a string equal to a or None
	"""
	if a:
		return str(a)
	else:
		return a

def select_all_nodes(stamp):
	try:
		conn = sqlite3.connect(db)
		conn.text_factory = str
		cur = conn.cursor()
	except sqlite3.OperationalError as err:
		print(err)
		sys.exit(1)
	try:
		cur.execute("SELECT * FROM action WHERE timestamp >=:stamp", {"stamp":stamp})
	except sqlite3.OperationalError as err:
		print(err)
		sys.exit(1)
	else:
		result = cur.fetchall()
	finally:
		cur.close()
		conn.close()
	return(result)

def write_list(nodes):
	try:
		name = "database-output.txt"
		f = open(name, "w")
	except Exception as err:
		print(err)
		sys.exit(1)

	for node in nodes:
		# Init bracket and basic datas
		f.write("[")
		f.write("id=%d" % node[0])
		f.write(";actor=%s" % get_player(node[1]))
		f.write(";type=%d" % node[3])
		# Inventory Manipulation
		f.write(";list=%s" % ston(node[4]))
		f.write(",index=%s" % ston(node[5]))
		f.write(",add=%s" % ston(node[6]))
		f.write(",stacknode=%s" % get_node(node[7]))
		f.write(",stackquantity=%s" % ston(node[8]))
		f.write(",nodemeta=%s" % ston(node[9]))
		# Position
		f.write(";x=%s,y=%s,z=%s" % (node[10], node[11], node[12]))
		# Old node
		f.write(";oldnode=%s" % get_node(node[13]))
		f.write(",oldparam1=%s" % node[14])
		f.write(",oldparam2=%s" % ston(node[15]))
		f.write(",oldmeta=%s" % ston(node[16]))
		# New node
		f.write(":newnode=%s" % get_node(node[17]))
		f.write(",newparam1=%s" % ston(node[18]))
		f.write(",newparam2=%s" % ston(node[19]))
		f.write(",newmeta=%s" % ston(node[20]))
		# Ending
		f.write("]\n")

	f.close()



########################################################################
## Main
#

if __name__ == '__main__':
	#select all nodes player as set i where time >= time
	all_nodes = select_all_nodes(0) #1418613979)

	# write in file
#	for x in range(0,len(all_nodes)):
#		print(all_nodes[x])
	write_list(all_nodes)
