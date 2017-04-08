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

### pclasses.api.util
 - Some utility functions

### pclasses.conf
 - Some configuration values

### pclasses.classes
 - All classes and their specs

### pclasses.data
 - Miscellaneous data

#### pclasses.data.players
 - List of all players' class. Index is player's name and value is the class's name

#### pclasses.data.hud_ids
 - Surely useful in the future with a hypothetical hud to show current class


# Functions

### pclasses.api.register_class
 - Arguments : cname, def
 - Registers a class and its specifications
 - Def is a definition table that can contain many functions/values :
    - `on_assigned` which is a function, receiving as argument the player name
    - `on_unassigned` which is a function, receiving as argument the player name
    - `on_update` which is a function, receiving as argument the player name
    - `switch_params`, which is a table, containing parameters for the switch pedestal :
      - `holo_item` is mandatory. It's the itemstring of the item to be put over the pedestal
      - `color` is optional. Default is white. It's a RGB table.
      - `tile` is optional. Default is none. It's a string of the texture to be applied over the pedestal

### pclasses.register_class_switch
 - Arguments : cname, params
 - Used internally to create switch pedestals
 - `params` is the `def` table given to `pclasses.api.register_class`, documented above

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
 - Returns true if achieved, false if not

### pclasses.api.util.does_wear_full_armor
 - Arguments : pname, material, noshield
 - Returns true if player `pname` is wearing the full armor made out of `material`
 - `noshield` must be true when the full armor has no shield

### pclasses.api.util.can_have_item
 - Arguments : pname, itemname
 - Returns true if player `pname` can have items `itemstring` in his main inventory, according to his class

###  pclasses.api.util.on_update
 - Arguments : pname
 - Update player's stats

### pclasses.api.reserve_item
 - Arguments : cname, itemstring
 - Adds an entry in the reserved items' table. Players will need to belong to class `cname` in order to have items `itemstring` in their main inventory
 - Note : You can reserve the same item for two classes, any player of either of both can then have the item

### pclasses.api.create_graveyard_inventory
 - Argument : player
 - Creates a detached inventory dedicated to 'dead' items (confiscated reserved items)
 - Used internally, should not be used outside of pclasses

### pclasses.api.vacuum_graveyard
 - Argument : player
 - Check all of `player`'s graveyard inventory to get them back items they obtained to right to have
