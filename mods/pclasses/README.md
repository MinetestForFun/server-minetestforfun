Player Classes
==============

Yet another class mod for Minetest.

# TODO
 - Flush and read system for `pclasses.datas.players`


# Namespaces

## pclasses
 - All our stuff

### pclasses.api
 - All functions used to declare, get, set classes

### pclasses.classes
 - All classes and their specs

### pclasses.datas
 - Miscellaneous datas

#### pclasses.datas.players
 - List of all players' class. Index is player's name and value is the class's name

#### pclasses.datas.hud_ids
 - Surely useful in the future with a hypothetical hud to show current class


# Functions

### pclasses.api.create_class_id
 - Arguments : None
 - Indicates the next free id/index in the classes' table

### pclasses.api.id_for_class
 - Arguments : cname (class' name)
 - Returns the id/index corresponding the class in the classes' table
 - Returns 0 if not found, nil if no name given

### pclasses.api.register_class(cname)
 - Argument : cname
 - Registers a class in the classes' table
 - Pretty useless at the moment
 - Returns class' id or nil if any error

### pclasses.api.get_class_by_id
 - Argument : id
 - Return the class' specs (table) corresponding an id or nil when not found

### pclasses.api.get_class_by_name
 - Argument : cname
 - Return the class' specs (table) corresponding a class name or nil if not found

### pclasses.api.get_player_class
 - Argument : pname (player's name)
 - Return the player's current class' name

### pclasses.api.get_class_players
 - Argument : cname
 - Return a list (table) of all players with class cname

### pclasses.api.set_player_class
 - Arguments : pname, cname
 - Assign a player the cname class

