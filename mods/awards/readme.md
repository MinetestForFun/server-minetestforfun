Awards
------

by Andrew "Rubenwardy" Ward, GPL 3.0 or later.

This mod adds achievements to Minetest.

Majority of awards are back ported from Calinou's
old fork in Carbone, under same license.


Code Reference
--------------

The API
=======
* awards.register_achievement(name,data_table)
	* name
	* desciption
	* sound [optional]
	* image [optional]
	* trigger [optional] [table]
		* type - "dig", "place", "death", "chat" or "join"
		* (for dig/place type) node - the nodes name
		* (for all types) target - how many to dig / place
	* secret [optional] - if true, then player needs to unlock to find out what it is.
* awards.give_achievement(name,award)
	* -- gives an award to a player
* awards.register_onDig(func(player,data))
	* -- return award name or null
* awards.register_onPlace(func(player,data))
	* -- return award name or null
* awards.register_onDeath(func(player,data))
	* -- return award name or null
* awards.register_onChat(func(player,data))
	* -- return award name or null
* awards.register_onJoin(func(player,data))
	* -- return award name or null


Player Data
===========

A list of data referenced/hashed by the player's name.
* player name
	* name [string]
	* count [table] - dig counter
		* modname [table]
			* itemname [int]
	* place [table] - place counter
		* modname [table]
			* itemname [int]
	* deaths
	* chats
	* joins
