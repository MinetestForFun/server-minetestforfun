
-- 3D Mushroom mod by VanessaE
--
-- License:  WTFPL for everything.

mushroom = {}

minetest.override_item("flowers:mushroom_brown", {
	drawtype = "mesh",
	mesh = "3dmushrooms.obj",
	tiles = {"3dmushrooms_brown.png"},
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3}
	},
	inventory_image = "3dmushrooms_brown_inv.png"
})

minetest.override_item("flowers:mushroom_red", {
	drawtype = "mesh",
	mesh = "3dmushrooms.obj",
	tiles = {"3dmushrooms_red.png"},
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3}
	},
	inventory_image = "3dmushrooms_red_inv.png"
})

-- aliases to the default mushrooms

minetest.register_alias("mushroom:brown", "flowers:mushroom_brown")
minetest.register_alias("mushroom:brown_natural", "flowers:mushroom_brown")
minetest.register_alias("mushroom:spore_brown", "flowers:mushroom_brown")
minetest.register_alias("mushroom:spore2", "flowers:mushroom_brown")
minetest.register_alias("mushroom:brown_essence", "flowers:mushroom_brown")

minetest.register_alias("mushroom:red", "flowers:mushroom_red")
minetest.register_alias("mushroom:red_natural", "flowers:mushroom_red")
minetest.register_alias("mushroom:spore_red", "flowers:mushroom_red")
minetest.register_alias("mushroom:spore1", "flowers:mushroom_red")
minetest.register_alias("mushroom:poison", "flowers:mushroom_red")

minetest.register_alias("mushroom:identifier", "default:mese_crystal_fragment")

minetest.log("action", "[3D Mushrooms] loaded.")
