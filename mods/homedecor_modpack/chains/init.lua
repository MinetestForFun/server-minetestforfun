local chains_sbox = {
	type = "fixed",
	fixed = { -0.1, -0.625, -0.1, 0.1, 0.5, 0.1 }
}

local topchains_sbox = {
	type = "fixed",
	fixed = {
		{ -0.25, 0.35, -0.25, 0.25, 0.5, 0.25 },
		{ -0.1, -0.625, -0.1, 0.1, 0.4, 0.1 }
	}
}

minetest.register_node("chains:chain", {
	description = "Hanging chain (wrought iron)",
	drawtype = "mesh",
	mesh = "chains.obj",
	tiles = {"chains_wrought_iron.png"},
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	inventory_image = "chain_wrought_iron_inv.png",
	groups = {cracky=3},
	selection_box = chains_sbox,
})

minetest.register_node("chains:chain_brass", {
	description = "Hanging chain (brass)",
	drawtype = "mesh",
	mesh = "chains.obj",
	tiles = {"chains_brass.png"},
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	inventory_image = "chain_brass_inv.png",
	groups = {cracky=3},
	selection_box = chains_sbox,
})

minetest.register_node("chains:chain_top", {
	description = "Hanging chain (ceiling mount, wrought iron)",
	drawtype = "mesh",
	mesh = "top_chains.obj",
	tiles = {"chains_wrought_iron.png"},
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	inventory_image = "top_chain_wrought_iron_inv.png",
	groups = {cracky=3},
	selection_box = topchains_sbox,
})

minetest.register_node("chains:chain_top_brass", {
	description = "Hanging chain (ceiling mount, brass)",
	drawtype = "mesh",
	mesh = "top_chains.obj",
	tiles = {"chains_brass.png"},
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	inventory_image = "top_chain_brass_inv.png",
	groups = {cracky=3},
	selection_box = topchains_sbox,
})

minetest.register_node("chains:chandelier", {
	description = "Chandelier (wrought iron)",
	paramtype = "light",
	light_source = LIGHT_MAX-2,
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	tiles = {
		"chains_wrought_iron.png",
		"chains_candle.png",
		{
			name="chains_candle_flame.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0
			}
		}
	},
	drawtype = "mesh",
	mesh = "chains_chandelier.obj",
	groups = {cracky=3},
	sounds =  default.node_sound_stone_defaults(),
})

minetest.register_node("chains:chandelier_brass", {
	description = "Chandelier (brass)",
	paramtype = "light",
	light_source = LIGHT_MAX-2,
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	tiles = {
		"chains_brass.png",
		"chains_candle.png",
		{
			name="chains_candle_flame.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0
			}
		}
	},
	drawtype = "mesh",
	mesh = "chains_chandelier.obj",
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
