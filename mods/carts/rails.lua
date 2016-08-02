minetest.register_node(":default:rail", { 
	description = "Rail",
	drawtype = "raillike",
	tiles = {"default_rail.png", "default_rail_curved.png", "default_rail_t_junction.png", "default_rail_crossing.png"},
	inventory_image = "default_rail.png",
	wield_image = "default_rail.png",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy = 2, snappy = 1, dig_immediate = 2, rail = 1, connect_to_raillike = 1},
	--[[mesecons = {
		effector = {
			action_off = function(pos, node)
				minetest.get_meta(pos):set_string("cart_acceleration", "0.5")
				minetest.get_meta(pos):set_string("cart_touring_velocity", cart:get_staticdata().velocity)
			end,

			action_on = function(pos, node)
				minetest.get_meta(pos):set_string("cart_acceleration", "0")
			end,
		},
	},--]]
})

minetest.register_node("carts:rail_copper", {
	description = "Copper Rail",
	drawtype = "raillike",
	tiles = {"carts_rail_copper.png", "carts_rail_copper_curved.png", "carts_rail_copper_t_junction.png", "carts_rail_copper_crossing.png"},
	inventory_image = "carts_rail_copper.png",
	wield_image = "carts_rail_copper.png",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy = 2, snappy = 1, dig_immediate = 2, rail = 1, connect_to_raillike = 1},
})

minetest.register_node("carts:rail_invisible", {
	description = "Invisible Rail",
	stack_max = 10000,
	range = 12,
	drawtype = "raillike",
	tiles = {"invisible.png", "invisible.png", "invisible.png", "invisible.png"},
	inventory_image = "default_rail.png^default_steel_ingot.png",
	wield_image = "default_rail.png^default_steel_ingot.png",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	drop = "",
	groups = {unbreakable = 1, rail = 1, connect_to_raillike = 1, not_in_creative_inventory = 1},
})

minetest.register_node("carts:rail_power", {
	description = "Powered Rail",
	drawtype = "raillike",
	tiles = {"carts_rail_pwr.png", "carts_rail_curved_pwr.png", "carts_rail_t_junction_pwr.png", "carts_rail_crossing_pwr.png"},
	inventory_image = "carts_rail_pwr.png",
	wield_image = "carts_rail_pwr.png",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy = 2, snappy = 1, dig_immediate = 2, rail = 1, connect_to_raillike = 1},

	after_place_node = function(pos, placer, itemstack)
		minetest.get_meta(pos):set_string("cart_acceleration", "1")
		--minetest.get_meta(pos):set_string("cart_touring_velocity", cart:get_staticdata().velocity)
	end,

	--[[mesecons = {
		effector = {
			action_off = function(pos, node)
				minetest.get_meta(pos):set_string("cart_acceleration", "0.5")
			end,

			action_on = function(pos, node)
				minetest.get_meta(pos):set_string("cart_acceleration", "0")
			end,
		},
	},--]]
})

minetest.register_node("carts:rail_power_invisible", {
	description = "Invisible Powered Rail",
	stack_max = 10000,
	range = 12,
	drawtype = "raillike",
	tiles = {"invisible.png", "invisible.png", "invisible.png", "invisible.png"},
	inventory_image = "default_rail.png^default_mese_crystal_fragment.png",
	wield_image = "default_rail.png^default_mese_crystal_fragment.png",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	drop = "",
	groups = {unbreakable = 1, rail = 1, connect_to_raillike = 1, not_in_creative_inventory = 1},

	after_place_node = function(pos, placer, itemstack)
		minetest.get_meta(pos):set_string("cart_acceleration", "10")
		--minetest.get_meta(pos):set_string("cart_touring_velocity", cart:get_staticdata().velocity)
	end,
})

minetest.register_node("carts:rail_brake", {
	description = "Brake Rail",
	drawtype = "raillike",
	tiles = {"carts_rail_brk.png", "carts_rail_curved_brk.png", "carts_rail_t_junction_brk.png", "carts_rail_crossing_brk.png"},
	inventory_image = "carts_rail_brk.png",
	wield_image = "carts_rail_brk.png",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy = 2, snappy = 1, dig_immediate = 2, rail = 1, connect_to_raillike = 1},

	after_place_node = function(pos, placer, itemstack)
		minetest.get_meta(pos):set_string("cart_acceleration", "-1")
		--minetest.get_meta(pos):set_string("cart_touring_velocity", cart.TARGET_TOUR_V)
	end,

	--[[mesecons = {
		effector = {
			action_off = function(pos, node)
				minetest.get_meta(pos):set_string("cart_acceleration", "-0.2")
			end,

			action_on = function(pos, node)
				minetest.get_meta(pos):set_string("cart_acceleration", "0")
			end,
		},
	},--]]
})

minetest.register_node("carts:rail_brake_invisible", {
	description = "Invisible Brake Rail",
	stack_max = 10000,
	range = 12,
	drawtype = "raillike",
	tiles = {"invisible.png", "invisible.png", "invisible.png", "invisible.png"},
	inventory_image = "default_rail.png^default_coal_lump.png",
	wield_image = "default_rail.png^default_coal_lump.png",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	drop = "",
	groups = {bendy = 2, snappy = 1, dig_immediate = 2, rail = 1, connect_to_raillike = 1, not_in_creative_inventory = 1},

	after_place_node = function(pos, placer, itemstack)
		minetest.get_meta(pos):set_string("cart_acceleration", "-10")
		--minetest.get_meta(pos):set_string("cart_touring_velocity", cart:get_staticdata().velocity)
	end,
})


minetest.register_craft({
	output = "carts:rail_copper 16",
	recipe = {
		{"default:copper_ingot", "group:stick", "default:copper_ingot"},
		{"default:copper_ingot", "group:stick", "default:copper_ingot"},
		{"default:copper_ingot", "group:stick", "default:copper_ingot"},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "carts:rail_power",
	recipe = {"group:rail", "default:mese_crystal_fragment"},
})

minetest.register_craft({
	type = "shapeless",
	output = "carts:rail_brake",
	recipe = {"group:rail", "default:coal_lump"},
})



minetest.register_alias("carts:powerrail", "carts:rail_power")
minetest.register_alias("carts:power_rail", "carts:rail_power")
minetest.register_alias("carts:brakerail", "carts:rail_brake")
minetest.register_alias("carts:brake_rail", "carts:rail_power")

