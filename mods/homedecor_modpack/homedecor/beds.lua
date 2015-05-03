local S = homedecor.gettext

local bedcolors = {
	"red",
	"green",
	"blue",
	"violet",
	"brown",
	"darkgrey",
	"orange",
	"yellow",
	"pink",
}

local bed_sbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 1.5 }
}

local bed_cbox = {
	type = "fixed",
	fixed = { 
		{ -0.5, -0.5, -0.5, 0.5, -0.05, 1.5 },
		{ -0.5, -0.5, 1.44, 0.5, 0.5, 1.5 },
		{ -0.5, -0.5, -0.5, 0.5, 0.18, -0.44 },
	}
}

local kbed_sbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.5, 1.5, 0.5, 1.5 }
}

local kbed_cbox = {
	type = "fixed",
	fixed = { 
		{ -0.5, -0.5, -0.5, 1.5, -0.05, 1.5 },
		{ -0.5, -0.5, 1.44, 1.5, 0.5, 1.5 },
		{ -0.5, -0.5, -0.5, 1.5, 0.18, -0.44 },
	}
}

for _, color in ipairs(bedcolors) do
	local color2=color
	if color == "darkgrey" then
		color2 = "dark_grey"
	end
	homedecor.register("bed_"..color.."_regular", {
		mesh = "homedecor_bed_regular.obj",
		tiles = {
			"homedecor_bed_frame.png",
			"default_wood.png",
			"wool_white.png",
			"wool_"..color2..".png",
			"homedecor_bed_bottom.png",
			"wool_"..color2..".png^[brighten", -- pillow
		},
		inventory_image = "homedecor_bed_"..color.."_inv.png",
		description = S("Bed (%s)"):format(color),
		groups = {snappy=3},
		selection_box = bed_sbox,
		collision_box = bed_cbox,
		sounds = default.node_sound_wood_defaults(),
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			if not placer:get_player_control().sneak then
				return homedecor.bed_expansion(pos, placer, itemstack, pointed_thing, color)
			end
		end,
		after_dig_node = function(pos)
			homedecor.unextend_bed(pos, color)
		end,
		on_rightclick = function(pos, node, clicker)
			if minetest.get_modpath("beds") then
				beds.on_rightclick(pos, clicker)
			else return end
		end
	})

	homedecor.register("bed_"..color.."_extended", {
		mesh = "homedecor_bed_extended.obj",
		tiles = {
			"homedecor_bed_frame.png",
			"default_wood.png",
			"wool_white.png",
			"wool_"..color2..".png",
			"homedecor_bed_bottom.png",
			"wool_"..color2..".png^[brighten",
		},
		groups = {snappy=3, not_in_creative_inventory=1},
		selection_box = bed_sbox,
		collision_box = bed_cbox,
		sounds = default.node_sound_wood_defaults(),
		expand = { forward = "air" },
		after_dig_node = function(pos)
			homedecor.unextend_bed(pos, color)
		end,
		on_rightclick = function(pos, node, clicker)
			if minetest.get_modpath("beds") then
				beds.on_rightclick(pos, clicker)
			else return end
		end,
		drop = "homedecor:bed_"..color.."_regular"
	})

	homedecor.register("bed_"..color.."_kingsize", {
		mesh = "homedecor_bed_kingsize.obj",
		tiles = {
			"homedecor_bed_frame.png",
			"default_wood.png",
			"wool_white.png",
			"wool_"..color2..".png",
			"homedecor_bed_bottom.png",
			"wool_"..color2..".png^[brighten",
		},
		inventory_image = "homedecor_bed_kingsize_"..color.."_inv.png",
		description = S("Bed (%s, king sized)"):format(color),
		groups = {snappy=3, not_in_creative_inventory=1},
		selection_box = kbed_sbox,
		collision_box = kbed_cbox,
		sounds = default.node_sound_wood_defaults(),
		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			local inv = digger:get_inventory()
			if digger:get_player_control().sneak and inv:room_for_item("main", "bed_"..color.."_regular 1") then
				inv:remove_item("main", "homedecor:bed_"..color.."_kingsize 1")
				inv:add_item("main", "homedecor:bed_"..color.."_regular 2")
			end
		end,
		on_rightclick = function(pos, node, clicker)
			if minetest.get_modpath("beds") then
				beds.on_rightclick(pos, clicker)
			else return end
		end
	})

	minetest.register_alias("homedecor:bed_"..color.."_foot",    "homedecor:bed_"..color.."_regular")
	minetest.register_alias("homedecor:bed_"..color.."_footext", "homedecor:bed_"..color.."_extended")
	minetest.register_alias("homedecor:bed_"..color.."_head",    "air")

end
