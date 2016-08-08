minetest.register_node(":default:rail", {
	description = "Rail",
	drawtype = "raillike",
	tiles = {
		"default_rail.png", "default_rail_curved.png",
		"default_rail_t_junction.png", "default_rail_crossing.png"
	},
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
	groups = carts:get_rail_groups(),
})


-- Copper rail

if minetest.get_modpath("moreores") then
	-- Moreores' copper rail
	minetest.register_alias("carts:rail_copper", "moreores:copper_rail")
else
	carts:register_rail(":carts:rail_copper", {
		description = "Copper rail",
		tiles = {
			"carts_rail_cp.png", "carts_rail_curved_cp.png",
			"carts_rail_t_junction_cp.png", "carts_rail_crossing_cp.png"
		},
		groups = carts:get_rail_groups(),
	})

	minetest.register_craft({
		output = "carts:rail_copper 16",
		recipe = {
			{"default:copper_ingot", "group:stick", "default:copper_ingot"},
			{"default:copper_ingot", "group:stick", "default:copper_ingot"},
			{"default:copper_ingot", "group:stick", "default:copper_ingot"},
		}
	})
end

-- Speed up

-- Rail Power

carts:register_rail(":carts:rail_power", {
	description = "Powered rail",
	tiles = {
		"carts_rail_pwr.png", "carts_rail_curved_pwr.png",
		"carts_rail_t_junction_pwr.png", "carts_rail_crossing_pwr.png"
	},
	groups = carts:get_rail_groups(),

	after_place_node = function(pos, placer, itemstack)
		if not mesecon then
			minetest.get_meta(pos):set_string("cart_acceleration", "1")
		end
	end,

	mesecons = {
		effector = {
			action_on = function(pos, node)
				carts:boost_rail(pos, 1)
			end,

			action_off = function(pos, node)
				minetest.get_meta(pos):set_string("cart_acceleration", "0")
			end,
		},
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "carts:rail_power",
	recipe = {"group:rail", "default:mese_crystal_fragment"},
})


-- Rail Brake

carts:register_rail(":carts:rail_brake", {
	description = "Brake rail",
	tiles = {
		"carts_rail_brk.png", "carts_rail_curved_brk.png",
		"carts_rail_t_junction_brk.png", "carts_rail_crossing_brk.png"
	},
	groups = carts:get_rail_groups(),

	after_place_node = function(pos, placer, itemstack)
		if not mesecon then
			minetest.get_meta(pos):set_string("cart_acceleration", "-1")
		end
	end,

	mesecons = {
		effector = {
			action_on = function(pos, node)
				minetest.get_meta(pos):set_string("cart_acceleration", "-1")
			end,

			action_off = function(pos, node)
				minetest.get_meta(pos):set_string("cart_acceleration", "0")
			end,
		},
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "carts:rail_brake",
	recipe = {"group:rail", "default:coal_lump"},
})

-- Start stop rail (temporary removed for mff)

--[[carts:register_rail("carts:startstoprail", {
	description = "Start-stop rail",
	tiles = {
		"carts_rail_ss.png", "carts_rail_curved_ss.png",
		"carts_rail_t_junction_ss.png", "carts_rail_crossing_ss.png"
	},
	groups = carts:get_rail_groups(),

	after_place_node = function(pos, placer, itemstack)
		if not mesecon then
			minetest.get_meta(pos):set_string("cart_acceleration", "halt")
		end
	end,

	mesecons = {
		effector = {
			action_on = function(pos, node)
				carts:boost_rail(pos, 0.5)
			end,

			action_off = function(pos, node)
				minetest.get_meta(pos):set_string("cart_acceleration", "halt")
			end,
		},
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "carts:startstoprail 2",
	recipe = {"carts:powerrail", "carts:brakerail"},
})--]]

--Alias

minetest.register_alias("carts:powerrail", "carts:rail_power")
minetest.register_alias("carts:power_rail", "carts:rail_power")
minetest.register_alias("carts:brakerail", "carts:rail_brake")
minetest.register_alias("carts:brake_rail", "carts:rail_brake")
