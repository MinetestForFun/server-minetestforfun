local S = homedecor.gettext

local bedcolors = {
	{ "black",       "#000000:200" }, --new cg72
	{ "brown",       "#603010:175" },
	{ "blue",        "#0000d0:150" },
	{ "cyan",        "#009fa7:150" }, --new cg72
	{ "darkgrey",    "#101010:175" },
	{ "dark_green",  "#007000:150" },
	{ "green",       "#00d000:150" }, --new cg72
	{ "grey",        "#101010:100" }, --new cg72
	{ "magenta",     "#e0048b:150" }, --new cg72
	{ "orange",      "#ff3000:150" },
	{ "pink",        "#ff80b0:150" },	
	{ "red",         "#d00000:150" },
	{ "violet",      "#7000e0:150" },
	{ "white",       "#000000:000" }, --new cg72
	{ "yellow",      "#ffe000:150" }
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

for i in ipairs(bedcolors) do
	local color = bedcolors[i][1]
	local color2=color
	local hue = bedcolors[i][2]

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
		inventory_image = "homedecor_bed_inv.png^(homedecor_bed_overlay_inv.png^[colorize:"..hue..")",
		description = S("Bed (%s)"):format(color),
		groups = {snappy=3},
		selection_box = bed_sbox,
		collision_box = bed_cbox,
		sounds = default.node_sound_wood_defaults(),
		on_rotate = screwdriver.disallow,
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
		selection_box = bed_sbox,
		collision_box = bed_cbox,
		sounds = default.node_sound_wood_defaults(),
		expand = { forward = "air" },
		on_rotate = screwdriver.disallow,
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
		inventory_image = "homedecor_bed_kingsize_inv.png^(homedecor_bed_kingsize_overlay_inv.png^[colorize:"..hue..")",
		groups = {snappy=3, not_in_creative_inventory=1},
		description = S("Bed (%s, king sized)"):format(color),
		groups = {snappy=3, not_in_creative_inventory=1},
		selection_box = kbed_sbox,
		collision_box = kbed_cbox,
		sounds = default.node_sound_wood_defaults(),
		on_rotate = screwdriver.disallow,
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


for _, w in pairs({"mahogany", "oak"}) do
	homedecor.register("nightstand_"..w.."_one_drawer", {
		description = S("Nightstand with One Drawer ("..w..")"),
		tiles = { 'homedecor_nightstand_'..w..'_tb.png',
			'homedecor_nightstand_'..w..'_tb.png^[transformFY',
			'homedecor_nightstand_'..w..'_lr.png^[transformFX',
			'homedecor_nightstand_'..w..'_lr.png',
			'homedecor_nightstand_'..w..'_back.png',
			'homedecor_nightstand_'..w..'_1_drawer_front.png'},
		node_box = {
			type = "fixed",
			fixed = {
				{ -8/16,     0, -30/64,  8/16,  8/16,   8/16 },	-- top half
				{ -7/16,  1/16, -32/64,  7/16,  7/16, -29/64}, 	-- drawer face
				{ -8/16, -8/16, -30/64, -7/16,     0,   8/16 },	-- left
				{  7/16, -8/16, -30/64,  8/16,     0,   8/16 },	-- right
				{ -8/16, -8/16,   7/16,  8/16,     0,   8/16 },	-- back
				{ -8/16, -8/16, -30/64,  8/16, -7/16,   8/16 }	-- bottom
			}
		},
		groups = { snappy = 3 },
		sounds = default.node_sound_wood_defaults(),
		selection_box = { type = "regular" },
		infotext=S("One-drawer Nightstand"),
		inventory = {
			size=8,
			lockable=true,
		},
	})

	homedecor.register("nightstand_"..w.."_two_drawers", {
		description = S("Nightstand with Two Drawers ("..w..")"),
		tiles = { 'homedecor_nightstand_'..w..'_tb.png',
			'homedecor_nightstand_'..w..'_tb.png^[transformFY',
			'homedecor_nightstand_'..w..'_lr.png^[transformFX',
			'homedecor_nightstand_'..w..'_lr.png',
			'homedecor_nightstand_'..w..'_back.png',
			'homedecor_nightstand_'..w..'_2_drawer_front.png'},
		node_box = {
			type = "fixed",
			fixed = {
				{ -8/16, -8/16, -30/64,  8/16,  8/16,   8/16 },	-- main body
				{ -7/16,  1/16, -32/64,  7/16,  7/16, -29/64 },	-- top drawer face
				{ -7/16, -7/16, -32/64,  7/16, -1/16, -29/64 },	-- bottom drawer face
			}
		},
		groups = { snappy = 3 },
		sounds = default.node_sound_wood_defaults(),
		selection_box = { type = "regular" },
		infotext=S("Two-drawer Nightstand"),
		inventory = {
			size=16,
			lockable=true,
		},
	})
end
