-- Lantern-Mod by RHR for Minetest 0.49 --
--===========================================

--
-- register nodes:
--
minetest.register_node("lantern:lantern", {
	description = "Lantern",
	drawtype = "nodebox",
	tiles = {"lantern_tb.png","lantern_tb.png","lantern.png","lantern.png","lantern.png","lantern.png"},
	paramtype = "light",
	sunlight_propagates = true,
	light_source = LIGHT_MAX-1,
	paramtype2 = "wallmounted",
	walkable = false,
	groups = {snappy = 2, cracky = 2, dig_immediate = 3},
	sounds = default.node_sound_glass_defaults(),
	node_box = {
		type = "wallmounted",
		wall_top = {-1/6, 1/6, -1/6, 1/6, 0.5, 1/6},		
		wall_bottom = {-1/6, -0.5, -1/6, 1/6, -1/6, 1/6}, 	
		wall_side = {-1/6, -1/6, -1/6, -0.5, 1/6, 1/6},
		},
})

minetest.register_node("lantern:fence_black", {
	description = "Black Fence",
	drawtype = "fencelike",
	tiles = {"default_obsidian.png"},
	paramtype = "light",
	is_ground_content = true,
	walkable = true,
	groups = {choppy = 2, flammable = 1, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_defaults(),
	selection_box = {
	type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
		},
})

minetest.register_node("lantern:candle", {
	description = "Candle",
	drawtype = "plantlike",
	inventory_image = "candle_inv.png",
	tiles = {
			{name="candle.png", animation={type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 0.8}},
		},	
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	light_source = LIGHT_MAX - 1,
	groups = {dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_defaults(),
	selection_box = {
			type = "fixed",
			fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
		},
})

minetest.register_node("lantern:lamp", {
	description = "Lamp",
	tiles = {"default_obsidian.png", "default_obsidian.png", "lantern_lamp.png", "lantern_lamp.png", "lantern_lamp.png", "lantern_lamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	light_source = LIGHT_MAX - 1,
	groups = {snappy = 2, cracky = 2, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

--
-- register lampposts in all 4 directions
--
minetest.register_node("lantern:lantern_lampost1", {
	description = "Lampost 1",
	drawtype = "fencelike",
	tiles = {"default_obsidian.png"},
	inventory_image = "lamppost1.png",
	wield_image = "lamppost_inv.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = true,
	groups = {choppy = 2, dig_immediate = 2, flammable = 1},
	sounds = default.node_sound_defaults(),
	after_place_node = function(pos)
		minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "lantern:fence_lampost"})
		minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z},{name = "lantern:fence_lampost"})
		minetest.set_node({x = pos.x, y = pos.y + 3, z = pos.z},{name = "lantern:fence_lampost"})
		minetest.set_node({x = pos.x - 1, y = pos.y + 3, z = pos.z },{name = "lantern:fence_lampost"})
		minetest.set_node({x = pos.x - 1, y = pos.y + 2, z = pos.z },{name = "lantern:lamp1"})
	end
})


minetest.register_node("lantern:lantern_lampost2", {
	description = "Lampost 2",
	drawtype = "fencelike",
	tiles = {"default_obsidian.png"},
	inventory_image = "lamppost2.png",
	wield_image = "lamppost_inv.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = true,
	groups = {choppy = 2, dig_immediate = 2, flammable = 1},
	sounds = default.node_sound_defaults(),
	after_place_node = function(pos)
		minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "lantern:fence_lampost"})
		minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z},{name = "lantern:fence_lampost"})
		minetest.set_node({x = pos.x, y = pos.y + 3, z = pos.z},{name = "lantern:fence_lampost"})
		minetest.set_node({x = pos.x, y = pos.y + 3, z = pos.z - 1},{name = "lantern:fence_lampost"})
		minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z - 1},{name = "lantern:lamp2"})
	end
})


minetest.register_node("lantern:lantern_lampost3", {
	description = "Lampost 3",
	drawtype = "fencelike",
	tiles = {"default_obsidian.png"},
	inventory_image = "lamppost3.png",
	wield_image = "lamppost_inv.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = true,
	groups = {choppy = 2, dig_immediate = 2, flammable = 1},
	sounds = default.node_sound_defaults(),
	after_place_node = function(pos)
		minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "lantern:fence_lampost"})
		minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z},{name = "lantern:fence_lampost"})
		minetest.set_node({x = pos.x, y = pos.y + 3, z = pos.z},{name = "lantern:fence_lampost"})
		minetest.set_node({x = pos.x + 1, y = pos.y + 3, z = pos.z},{name = "lantern:fence_lampost"})
		minetest.set_node({x = pos.x + 1, y = pos.y + 2, z = pos.z},{name = "lantern:lamp3"})
	end
	})


minetest.register_node("lantern:lantern_lampost4", {
	description = "Lampost 4",
	drawtype = "fencelike",
	tiles = {"default_obsidian.png"},
	inventory_image = "lamppost4.png",
	wield_image = "lamppost_inv.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = true,
	groups = {choppy = 2, dig_immediate = 2, flammable = 1},
	sounds = default.node_sound_defaults(),
	after_place_node = function(pos)
		minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "lantern:fence_lampost"})
		minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z},{name = "lantern:fence_lampost"})
		minetest.set_node({x = pos.x, y = pos.y + 3, z = pos.z},{name = "lantern:fence_lampost"})
		minetest.set_node({x = pos.x, y = pos.y + 3, z = pos.z + 1},{name = "lantern:fence_lampost"})
		minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z + 1},{name = "lantern:lamp4"})
	end
})

--
-- this node is only used  for lampost and can't be crafted/used by the player
--
minetest.register_node("lantern:fence_lampost", {
	description = "Fence Lamppost",
	drawtype = "fencelike",
	tiles = {"default_obsidian.png"},
	paramtype = "light",
	is_ground_content = true,
	walkable = true,
	groups = {choppy = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_defaults(),
})

--
-- the nodes lantern:lamp1, lamp2, lamp3 and lamp4 are only used for the lamposts and can't be crafted/used by the player
-- these nodes are also removing the lantern with "after_dig_node"
--
minetest.register_node("lantern:lamp1", {
	description = "Lamp1",
	drop = 'lantern:lantern_lampost1',
	tiles = {"default_obsidian.png", "default_obsidian.png", "lantern_lamp.png", "lantern_lamp.png", "lantern_lamp.png", "lantern_lamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	light_source = LIGHT_MAX - 1,
	groups = {snappy = 2, cracky = 2, oddly_breakable_by_hand = 3, not_in_creative_inventory = 1},
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
	type = "fixed",
	fixed = {-0.5, -2.5, -0.5, 1.5, 1.5, 0.5}, 
	},
	after_dig_node = function(pos)
		minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})	
		minetest.remove_node({x = pos.x + 1, y = pos.y + 1, z = pos.z })	
		minetest.remove_node({x = pos.x + 1, y = pos.y , z = pos.z })
		minetest.remove_node({x = pos.x + 1, y = pos.y - 1, z = pos.z })	
		minetest.remove_node({x = pos.x + 1, y = pos.y - 2, z = pos.z })	
	end
})	

minetest.register_node("lantern:lamp2", {
	description = "Lamp2",
	drop = 'lantern:lantern_lampost2',
	tiles = {"default_obsidian.png", "default_obsidian.png", "lantern_lamp.png", "lantern_lamp.png", "lantern_lamp.png", "lantern_lamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	light_source = LIGHT_MAX - 1,
	groups = {snappy = 2, cracky = 2, oddly_breakable_by_hand = 3, not_in_creative_inventory = 1},
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
	type = "fixed",
	fixed = {-0.5, -2.5, -0.5, 0.5, 1.5, 1.5}, 
	},
	after_dig_node = function(pos)
		minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})	
		minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z + 1})	
		minetest.remove_node({x = pos.x, y = pos.y , z = pos.z + 1})
		minetest.remove_node({x = pos.x, y = pos.y - 1, z = pos.z + 1})	
		minetest.remove_node({x = pos.x, y = pos.y - 2, z = pos.z + 1})	
	end
})	

minetest.register_node("lantern:lamp3", {
	description = "Lamp3",
	drop = 'lantern:lantern_lampost3',
	tiles = {"default_obsidian.png", "default_obsidian.png", "lantern_lamp.png", "lantern_lamp.png", "lantern_lamp.png", "lantern_lamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	light_source = LIGHT_MAX - 1,
	groups = {snappy = 2, cracky = 2, oddly_breakable_by_hand = 3, not_in_creative_inventory = 1},
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
	type = "fixed",
	fixed = {-1.5, -2.5, -0.5, 0.5, 1.5, 0.5}, 
	},
	after_dig_node = function(pos)
		minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})	
		minetest.remove_node({x = pos.x - 1, y = pos.y + 1, z = pos.z})	
		minetest.remove_node({x = pos.x - 1, y = pos.y , z = pos.z})
		minetest.remove_node({x = pos.x - 1, y = pos.y - 1, z = pos.z})	
		minetest.remove_node({x = pos.x - 1, y = pos.y - 2, z = pos.z})	
	end
})	

minetest.register_node("lantern:lamp4", {
	description = "Lamp4",
	drop = 'lantern:lantern_lampost4',
	tiles = {"default_obsidian.png", "default_obsidian.png", "lantern_lamp.png", "lantern_lamp.png", "lantern_lamp.png", "lantern_lamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	light_source = LIGHT_MAX - 1,
	groups = {snappy = 2, cracky = 2, oddly_breakable_by_hand = 3, not_in_creative_inventory = 1},
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
	type = "fixed",
	fixed = {-0.5, -2.5, -1.5, 0.5, 1.5, 0.5}, 
	},
	after_dig_node = function(pos)
		minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})	
		minetest.remove_node({x = pos.x, y = pos.y + 1, z = pos.z - 1})	
		minetest.remove_node({x = pos.x, y = pos.y , z = pos.z - 1})
		minetest.remove_node({x = pos.x, y = pos.y - 1, z = pos.z - 1})	
		minetest.remove_node({x = pos.x, y = pos.y - 2, z = pos.z - 1})	
	end
})	

--
-- register crafting recipes:
--
minetest.register_craft({
	output = 'lantern:candle 12',
	recipe = {
		{'default:coal_lump','default:coal_lump'},
		{'group:stick','group:stick'},
		}
})

minetest.register_craft({
	output = 'lantern:lantern 4',
	recipe = {
		{'','group:stick',''},
		{'group:stick','lantern:candle','group:stick'},
		{'','group:stick',''},
		}
})

minetest.register_craft({
	output = 'lantern:lantern 4',
	recipe = {
		{'group:stick','','group:stick'},
		{'','lantern:candle',''},
		{'group:stick','','group:stick'},
		}
})

minetest.register_craft({
	type = "shapeless",
	output = 'lantern:fence_black',
	recipe = {'default:coal_lump', 'default:fence_wood'},
})

minetest.register_craft({
	output = 'lantern:lamp 4',
	recipe = {
	{'','default:steel_ingot',''},
	{'default:steel_ingot','lantern:candle','default:steel_ingot'},
	{'','default:steel_ingot',''},
	}
})

minetest.register_craft({
	output = 'lantern:lamp 4',
	recipe = {
	{'default:steel_ingot','','default:steel_ingot'},
	{'','lantern:candle',''},
	{'default:steel_ingot','','default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'lantern:lantern_lampost1',
	recipe = {
	{'lantern:fence_black','lantern:fence_black',''},
	{'lantern:fence_black','lantern:lamp',''},
	{'lantern:fence_black','',''},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = 'lantern:lantern_lampost2',
	recipe = {"lantern:lantern_lampost1"}
})

minetest.register_craft({
	type = "shapeless",
	output = 'lantern:lantern_lampost3',
	recipe = {"lantern:lantern_lampost2"}
})

minetest.register_craft({
	type = "shapeless",
	output = 'lantern:lantern_lampost4',
	recipe = {"lantern:lantern_lampost3"}
})

minetest.register_craft({
	type = "shapeless",
	output = 'lantern:lantern_lampost1',
	recipe = {"lantern:lantern_lampost4"}
})