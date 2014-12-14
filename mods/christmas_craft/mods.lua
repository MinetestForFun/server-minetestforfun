
print (" ---- mods override is Loading! ---- ")

-- leaves -- 


--minetest.register_node(":4seasons:leaves_winter", {
--	description = "Leaves",
--	drawtype = "allfaces_optional",
--	visual_scale = 1.3,
--	tile_images = {"4seasons_leaves_with_snow.png"},
--	paramtype = "light",
--	groups = {snappy=3, leafdecay=3, flammable=2},
--	drop = {
--		max_items = 1, items = {
--			{items = {'default:sapling'},	rarity = 20,},
--			{items = {'4seasons:leaves_winter'},}
--		}},
--	sounds = default.node_sound_leaves_defaults(),
--})

 -- why are u overwriting that? its just the normal 4 season leaves.

 
 -- grass --

minetest.register_node(":4seasons:grass_winter", {
	description = "Dirt with snow",
	tiles = {"4seasons_snow.png", "default_dirt.png", "default_dirt.png^4seasons_grass_w_snow_side.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = {
		max_items = 2, items = {
			{items = {'default:dirt'},	rarity = 0,},
			{items = {'christmas_craft:snowball'},	rarity = 0,},	
		}},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

--normal sand
minetest.register_node(":4seasons:sand_winter", {
	description = "Sand with snow",
	tiles = {"4seasons_snow.png", "default_sand.png", "default_sand.png^4seasons_sand_w_snow_side.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = {'default:sand',
	max_items = 2, items = {
			{items = {'default:sand'},	rarity = 0,},
			{items = {'christmas_craft:snowball'},	rarity = 0,},	
		}},

	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})
--desert sand
minetest.register_node(":4seasons:desertsand_winter", {
	description = "Desert Sand with snow",
	tiles = {"4seasons_snow.png", "default_desert_sand.png", "default_desert_sand.png^4seasons_desertsand_w_snow_side.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = {'default:desert_sand',
	max_items = 2, items = {
			{items = {'default:desert_sand'},	rarity = 0,},
			{items = {'christmas_craft:snowball'},	rarity = 0,},	
		}},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

--cactus winter

minetest.register_node(":4seasons:cactus_winter", {
	description = "Cactus",
	tiles = {"4seasons_cactus_wsnow_top.png", "4seasons_cactus_wsnow_top.png", "4seasons_cactus_wsnow_side.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=3,flammable=2},
	drop = {'default:cactus',
	max_items = 2, items = {
			{items = {'default:cactus'},	rarity = 0,},
			{items = {'christmas_craft:snowball'},	rarity = 0,},	
		}},
	sounds = default.node_sound_wood_defaults(),
})