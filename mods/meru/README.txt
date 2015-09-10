meru 0.3.1 by paramat
For Minetest 0.4.12 and later
Depends default
License WTFPL

Meru mod is a vertical 1 dimensional realm, 1D referring to large scale structure, and can act as a vertical connector between horizontal realms, such as the ground and the floatlands.
A single spike shaped mountain is created in newly generated chunks, at a random location within a chosen area, by default this area is +/-1024 for use in a new world, to add a mountain to an existing world you need to edit these area parameters to a completely ungenerated part of your world.
For testing this mod or for cheating edit parameter COORD = true, the co-ordinates of the mountain will be printed to terminal while within the generation area.
The mountain is a hollow cone made of stone and desert stone, with a smooth transition across biome boundaries. By default the height is 2km. There are a few cave entrances on the surface, these 'fissure system' caves expand under the surface helping the creation of a path upwards. If the mountain generates over water you can use the central conical void to jump down the last few hundred metres.
There are many parameters for fine tuning the structure, some parameters change smoothly with height or distance from the center. Reducing noise to zero at the center creates a perfect spike as a summit. Constant noise throughout often creates floating islands at the summit. Choosing zero noise throughout creates a smooth geometric conical shape. There is a parameter CONVEX to control whether the basic conical structure bulges outwards or is pinched inwards in the middle.
