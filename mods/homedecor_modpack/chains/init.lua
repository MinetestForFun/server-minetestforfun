print("[Chains] v1.2")

-- wrought iron items

minetest.register_node("chains:chain", {
	description = "Hanging chain (wrought iron)",
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	drops = "",
	tiles = { "chains_chain.png" },
	inventory_image = "chains_chain.png",
	drawtype = "plantlike",
	groups = {cracky=3},
	sounds =  default.node_sound_stone_defaults(),
})

minetest.register_node("chains:chain_top", {
	description = "Hanging chain (ceiling mount, wrought iron)",
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	drops = "",
	tiles = { "chains_chain_top.png" },
	inventory_image = "chains_chain_top_inv.png",
	drawtype = "plantlike",
	groups = {cracky=3},
	sounds =  default.node_sound_stone_defaults(),
})

minetest.register_node("chains:chandelier", {
	description = "Chandelier (wrought iron)",
	paramtype = "light",
	walkable = false,
	light_source = LIGHT_MAX-2,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	drops = "",
	tiles = { {name="chains_chandelier.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}},
	inventory_image = "chains_chandelier_inv.png",
	drawtype = "plantlike",
	groups = {cracky=3},
	sounds =  default.node_sound_stone_defaults(),
})

-- brass-based items

minetest.register_node("chains:chain_brass", {
	description = "Hanging chain (brass)",
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	drops = "",
	tiles = { "chains_chain_brass.png" },
	inventory_image = "chains_chain_brass.png",
	drawtype = "plantlike",
	groups = {cracky=3},
	sounds =  default.node_sound_stone_defaults(),
})

minetest.register_node("chains:chain_top_brass", {
	description = "Hanging chain (ceiling mount, brass)",
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	drops = "",
	tiles = { "chains_chain_top_brass.png" },
	inventory_image = "chains_chain_top_brass_inv.png",
	drawtype = "plantlike",
	groups = {cracky=3},
	sounds =  default.node_sound_stone_defaults(),
})

minetest.register_node("chains:chandelier_brass", {
	description = "Chandelier (brass)",
	paramtype = "light",
	walkable = false,
	light_source = LIGHT_MAX-2,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	drops = "",
	tiles = { {name="chains_chandelier_brass.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}},
	inventory_image = "chains_chandelier_brass_inv.png",
	drawtype = "plantlike",
	groups = {cracky=3},
	sounds =  default.node_sound_stone_defaults(),
})

-- crafts

minetest.register_craft({
	output = 'chains:chain 2',
	recipe = {
		{'glooptest:chainlink'},
		{'glooptest:chainlink'},
		{'glooptest:chainlink'},
	}
})

minetest.register_craft({
	output = 'chains:chain_top',
	recipe = {
		{'default:steel_ingot'},
		{'glooptest:chainlink'},
	},
})

minetest.register_craft({
	output = 'chains:chandelier',
	recipe = {
		{'', 'glooptest:chainlink', ''},
		{'default:torch', 'glooptest:chainlink', 'default:torch'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

-- brass versions

minetest.register_craft({
	output = 'chains:chain_brass 2',
	recipe = {
		{'homedecor:chainlink_brass'},
		{'homedecor:chainlink_brass'},
		{'homedecor:chainlink_brass'},
	}
})

minetest.register_craft({
	output = 'chains:chain_top_brass',
	recipe = {
		{'technic:brass_ingot'},
		{'homedecor:chainlink_brass'},
	},
})

minetest.register_craft({
	output = 'chains:chandelier_brass',
	recipe = {
		{'', 'homedecor:chainlink_brass', ''},
		{'default:torch', 'homedecor:chainlink_brass', 'default:torch'},
		{'technic:brass_ingot', 'technic:brass_ingot', 'technic:brass_ingot'},
	}
})

