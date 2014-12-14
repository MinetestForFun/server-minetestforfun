
print (" ---- Overrider christmas_craft = true! ---- ")

minetest.register_node(":default:dirt_with_grass", {
	description = "Dirt with Grass",
	tiles = {"snow.png", "default_dirt.png", "grass_w_snow_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1},
	drop = {
		max_items = 2, items = {
			{items = {'default:dirt'},	rarity = 0,},
			{items = {'christmas_craft:snowball'},	rarity = 0,},	
		}},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

minetest.register_node(":default:leaves", {
	description = "Leaves",
	drawtype = "nodebox",
	visual_scale = 1.3,
	tiles = {"snow.png", "christmas_craft_leaves_top.png", "christmas_craft_leaves_side.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'default:sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'default:leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
		node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, 
		},
	},
	
})





print (" ---- Overrider christmas_craft [OK] ---- ")

