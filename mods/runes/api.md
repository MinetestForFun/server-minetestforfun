RUNES' API
==========

(as accurate as possible)

# 1. How it **does** work

  Every rune registered uses the same method to work and access its environment. Runes are first registered using a specific function.
Their datas are stored somewhere in a namespace (see below). You can use multiple values to indicate the needed amount of mana, the type of
the rune, its texture(s), etc. Then, once a rune is registered (as an item, for minetest), the most important thing is to connect its handler(s).
Another specific function is used to this, where you pass as an argument the reference to a function receiving the parameters of the item/node's callback
(eg. on_punch, on_dig, on_use, etc). The handler can choose to return "true" in order to manage the use of mana by itself instead of letting the
item's code in minetest.registered_items[rune].callback do it.

# Functions

#### `runes.register_rune(parameters)`
The most important function. This is the function you use to declare your rune and its specifications to minetest itself.
It takes one argument, a table. This table can have the following articles :
    	- `name` is mandatory, it's the rune's name (which will be used to craft its itemstring : runes:rune_name_level)
 - `desc` is the item's description
 - `img` is another table :
	- ["minor"] = texture_file
	- ["medium"] = texture_file
	- ["major"] = texture_file
	None of these parameters are mandatory. Runes can have 1 or 2 or 3 levels (ok, not implemented yet, but it's coming).
	You can use a single value like `img = texture_file` and the texture will be applied for all levels
 - `type` is the type of rune. At the moment, three types are available :
	- "craftitem" will register a craftitem
	- "cube" will register a node
	- "plate" will register a little slab 0.1 node thin
 - `needed_mana` is yet another table with different levels :
	- ["minor"] = value
	- ["medium"] = value
	- ["major"] = value
	When using this rune at level "major", the ["major"] value of mana will be taken by default if the player has enough mana,
	or it will be forbidden for him to use the rune if he doesn't have enough mana.
	You don't have to indicate that parameter and just let the handler manage the mana.

#### `runes.functions.connect(itemname, callback, handler)`
This function will connect a registered rune's callback to its handler. It takes three mandatory arguments :
 - `itemname` is the rune's identification name (aka. `name` for earlier). The same handler is used for every level
	of a rune, so it has to determine what level he will handle (it's actually passed to it)
 - `callback` is a code identifying the callback. It can be :
	- `use` for `on_use`
	- `place` for `after_place_node`
	- `dig` for `after_dig_node` (actually commented due to bugs in this section)
	- `can_dig` for `can_dig` (true logic)
	- `punch` for `on_punch` (rather logic too)
 - `handler` is the function handling the callback. See below for details.
Do not hesitate to consult lua_api.txt in order to see which callbacks are handled by what type of runes (craftitems, and nodes).

#### `runes.functions.register_amulet(name, desc, maxcount, manadiff)`
Amulets are special items able to increase the maximum of mana you can stock. Here are the arguments expected to register an amulet :
 - `name` is its name, used to create its itemstring : 'runes:name_amulet'
	Don't feel forced to use '_amulet' in an amulet name, it's completly useless.    
 - `desc` is the item description.
 - `maxcount` represents the maximum amount of this amulet you can have per stack (aka `stack_max`, see lua_api.txt for this).
 - `manadiff` is the amount of space you will get to stock more mana in your inventory. A global_step loop is charged with the task
	of regulary looking into everyone's rune inventory to calculate every player's max_mana. If you loose amulets, your mana_max
will dicrease (and mana may be lost with it).

#### `runes.functions.register_detached_inventory(player)`
This function is only important for rune's inners. It registers a detached inventory to contain runes. Do not bother using it, there is no
actual use of it out of runes' core.

#### `runes.functions.save_detached_inventory(player)`
Saves player's rune inventory on hard drive (in minetest.get_worldpath() .. "/runes/" .. player:get_player_name() .. "_rune.inv").

# Namespaces

Here are a few namespaces that could be useful :
 - `runes` global namespace, contains everything. Note : When [this](https://github.com/minetest/minetest/pull/2039) is merged, do what we have to do.
 - `runes.datas` miscellaneous datas, including tables with parameters transmitted to the registration functions.
 - `runes.datas.item`, the item's datas transmitted to registration
 - `runes.datas.handlers`, handlers of everynodes (the index of this dictionnary is the rune's name)
 - `runes.datas.amulets`, amulet's datas, used for the global_step loop and registration
 - `runes.functions`, multiple useful functions
