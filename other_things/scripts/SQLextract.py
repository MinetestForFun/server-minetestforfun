#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import sys, os, sqlite3

home = os.environ.get("HOME")
db = "%s/rollback/rollback.sqlite" % (home)


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




def select_nodes_id():
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


def get_node(nodeid):
	if not nodeid:
		return None
	try:
		return select_nodes_id()[nodeid-1][1]
	except IndexError:
		print(nodeid)


def select_player_id(table, player_name):
	try:
		conn = sqlite3.connect(db)
		cur = conn.cursor()
	except:
		print("Problème avec la base de données")
		return("")
	try:
		cur.execute("SELECT id FROM " + str(table) + " WHERE name=:name", {"name": "player:%s" % player_name})
	except sqlite3.OperationalError as err:
		print(err)
		return ("")
	else:
		result = cur.fetchall()
	finally:
		cur.close()
		conn.close()
	return(result)

def get_player(id):
	try:
		conn = sqlite3.connect(db)
		cur = conn.cursor()
	except:
		print("problème avec la base de données")
		return ("")
	try:
		cur.execute("SELECT name from actor WHERE id=%d" % id)
	except sqlite3.OperationalError as err:
		print(err)
		return ("")
	else:
		result = cur.fetchall()[0][0]
	finally:
		cur.close()
		conn.close()
	return result[len("player:"):]


def ston(a):
	if a:
		return str(a)
	else:
		return a

def write_list(nodes):
	try:
		name = "database-output.txt"
		f = open(name, "w")
	except Exception as err:
		print(err)
		sys.exit(1)

	for node in nodes:
		f.write("[")
		f.write("id=%d" % node[0])
		f.write(";actor=%s" % get_player(node[1]))
		f.write(";type=%d" % node[3])
		f.write(";list=%s" % ston(node[4]))
		f.write(",index=%s" % ston(node[5]))
		f.write(",add=%s" % ston(node[6]))
		f.write(",stacknode=%s" % get_node(node[7]))
		f.write(",stackquantity=%s" % ston(node[8]))
		f.write(",nodemeta=%s" % ston(node[9]))
		f.write(";x=%s,y=%s,z=%s" % (node[10], node[11], node[12]))
		f.write(";oldnode=%s" % get_node(node[13]))
		f.write(",oldparam1=%s" % node[14])
		f.write(",oldparam2=%s" % ston(node[15]))
		f.write(",oldmeta=%s" % ston(node[16]))
		f.write(":newnode=%s" % get_node(node[17]))
		f.write(",newparam1=%s" % ston(node[18]))
		f.write(",newparam2=%s" % ston(node[19]))
		f.write(",newmeta=%s" % ston(node[20]))
		f.write("]\n")

	f.close()




if __name__ == '__main__':
	#select all nodes player as set i where time >= time
	all_nodes = select_all_nodes(0) #1418613979)

	# write in file
#	for x in range(0,len(all_nodes)):
#		print(all_nodes[x])
	write_list(all_nodes)
