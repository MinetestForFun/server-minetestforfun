
local S = homedecor.gettext

homedecor.register("bars", {
	description = S("Bars"),
	tiles = { "homedecor_generic_metal_black.png^[transformR270" },
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.50, -0.10, -0.4,  0.50,  0.10 },
			{ -0.1, -0.50, -0.10,  0.1,  0.50,  0.10 },
			{  0.4, -0.50, -0.10,  0.5,  0.50,  0.10 },
			{ -0.5, -0.50, -0.05,  0.5, -0.45,  0.05 },
			{ -0.5,  0.45, -0.05,  0.5,  0.50,  0.05 },
		},
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.1, 0.5, 0.5, 0.1 },
	},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

--L Binding Bars
homedecor.register("L_binding_bars", {
	description = S("Binding Bars"),
	tiles = { "homedecor_generic_metal_black.png^[transformR270" },
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.10, -0.50, -0.50,  0.10,  0.50, -0.40 },
			{ -0.15, -0.50, -0.15,  0.15,  0.50,  0.15 },
			{  0.40, -0.50, -0.10,  0.50,  0.50,  0.10 },
			{  0.00, -0.50, -0.05,  0.50, -0.45,  0.05 },
			{ -0.05, -0.50, -0.50,  0.05, -0.45,  0.00 },
			{  0.00,  0.45, -0.05,  0.50,  0.50,  0.05 },
			{ -0.05,  0.45, -0.50,  0.05,  0.50,  0.00 },
		},
	},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

local chain_cbox = {
	type = "fixed",
	fixed = {-1/2, -1/2, 1/4, 1/2, 1/2, 1/2},
}

homedecor.register("chains", {
	description = S("Chains"),
	mesh = "forniture_chains.obj",
	tiles = { "homedecor_generic_metal_black.png" },
	inventory_image="forniture_chains_inv.png",
	selection_box = chain_cbox,
	walkable = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

homedecor.register("torch_wall", {
	description = S("Wall Torch"),
	mesh = "forniture_torch.obj",
	tiles = {
		{
			name="forniture_torch_flame.png",
			animation={
				type="vertical_frames",
				aspect_w=40,
				aspect_h=40,
				length=1.0,
			},
		},
		"homedecor_generic_metal_black.png",
		"homedecor_generic_metal_black.png^[brighten",
		"forniture_coal.png",
	},
	inventory_image="forniture_torch_inv.png",
	walkable = false,
	light_source = 14,
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.45, 0.15, 0.15,0.35, 0.5 },
	},
	groups = {cracky=3},
})

local wl_cbox = {
	type = "fixed",
	fixed = { -0.2, -0.5, 0, 0.2, 0.5, 0.5 },
}

homedecor.register("wall_lamp", {
	description = S("Wall Lamp"),
	mesh = "homedecor_wall_lamp.obj",
	tiles = {"homedecor_generic_metal_black.png^[brighten", "homedecor_generic_wood_luxury.png^[colorize:#000000:30",
			"homedecor_light.png", "homedecor_generic_metal_wrought_iron.png"},
	use_texture_alpha = true,
	inventory_image = "homedecor_wall_lamp_inv.png",
	groups = {snappy=3},
	light_source = 11,
	selection_box = wl_cbox,
	walkable = false
})

minetest.register_alias("3dforniture:bars", "homedecor:bars")
minetest.register_alias("3dforniture:L_binding_bars", "homedecor:L_binding_bars")
minetest.register_alias("3dforniture:chains", "homedecor:chains")
minetest.register_alias("3dforniture:torch_wall", "homedecor:torch_wall")

minetest.register_alias('bars', 'homedecor:bars')
minetest.register_alias('binding_bars', 'homedecor:L_binding_bars')
minetest.register_alias('chains', 'homedecor:chains')
minetest.register_alias('torch_wall', 'homedecor:torch_wall')
