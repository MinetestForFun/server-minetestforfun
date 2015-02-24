# Vines

## Features
- Rope block for spawning rope that slowly drops into the deep.
- Vines are climbable and slowly grow downward.
- Shears that allow the collecting of vines.
- Spawns vines on jungletree leaves.
- Roots on the bottom of dirt and dirt with grass nodes.
- Spawns vines on trees located in swampy area.
- Jungle vines that spawn on the side of jungletrees

## API
The API is very minimal. It allows the registering of vines and the spawning of
existing vines on nodes of your own.

If you want vines to spawn on a certain node then you can choose which vine by
adding to the node groups the unique group of that vine. This is determined by
the name of the vine ( see vines.lua ) appended with '_vines'.
An example would be.

"willow_vines" or "jungle_vines"

There are two types of vines. One that spawns at the bottom of nodes and uses the
plantlike drawtype, and vines that spawn on the side that use signlike
drawtype. The type is determined by the spawn_on_side property in the biome
table.

### Example
*taken from mod*

```lua

  vines.register_vine( name, definitions, biome )

  --e.g.

  vines.register_vine( 'vine', {
    description = "Vines",
    average_length = 9
  }, biome )

```

### definitions
|key|           type|  description|
|---|           ---|   ---|
|description|   string|The vine's tooltip description|
|average_length|int|   The average length of vines|

For biome definitions please see the [plants_lib API documentation](https://github.com/VanessaE/plantlife_modpack/blob/master/API.txt)

## Notice
Vines use after_destruct on registered leave nodes to remove vines from which
the leaves are removed. This is done by using the override function.
Malfunctions may occur if other mods override the after_destruct of these nodes
also.
