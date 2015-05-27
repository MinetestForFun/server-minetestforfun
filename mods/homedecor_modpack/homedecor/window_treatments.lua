local S = homedecor.gettext

homedecor.register("window_quartered", {
	description = "Window (quartered)",
	tiles = {
		"homedecor_window_sides.png",
		"homedecor_window_sides.png",
		"homedecor_window_sides.png",
		"homedecor_window_sides.png",
		"homedecor_window_quartered.png",
		"homedecor_window_quartered.png"
	},
	use_texture_alpha = true,
	groups = {snappy=3},
	sounds = default.node_sound_glass_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.025, 0.5, 0.5, 0}, -- NodeBox1
			{-0.5, 0.4375, -0.0625, 0.5, 0.5, 0.0625}, -- NodeBox2
			{-0.5, -0.5, -0.0625, 0.5, -0.4375, 0.0625}, -- NodeBox3
			{-0.5, -0.0625, -0.025, 0.5, 0.0625, 0.025}, -- NodeBox4
			{0.4375, -0.5, -0.0625, 0.5, 0.5, 0.0625}, -- NodeBox5
			{-0.5, -0.5, -0.0625, -0.4375, 0.5, 0.0625}, -- NodeBox6
			{-0.0625, -0.5, -0.025, 0.0625, 0.5, 0.025}, -- NodeBox7
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.0625, 0.5, 0.5, 0.0625}
	}
})

homedecor.register("window_plain", {
	description = "Window (plain)",
	tiles = {
		"homedecor_window_sides.png",
		"homedecor_window_sides.png",
		"homedecor_window_sides.png",
		"homedecor_window_sides.png",
		"homedecor_window_frame.png",
		"homedecor_window_frame.png"
	},
	use_texture_alpha = true,
	groups = {snappy=3},
	sounds = default.node_sound_glass_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.025, 0.5, 0.5, 0}, -- NodeBox1
			{-0.5, 0.4375, -0.0625, 0.5, 0.5, 0.0625}, -- NodeBox2
			{-0.5, -0.5, -0.0625, 0.5, -0.4375, 0.0625}, -- NodeBox3
			{0.4375, -0.5, -0.0625, 0.5, 0.5, 0.0625}, -- NodeBox4
			{-0.5, -0.5, -0.0625, -0.4375, 0.5, 0.0625}, -- NodeBox5
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.0625, 0.5, 0.5, 0.0625}
	}
})

local wb1_cbox = {
	type = "fixed",
	fixed = { -8/16, -8/16, 5/16, 8/16, 8/16, 8/16 },
}

homedecor.register("blinds_thick", {
	description = "Window Blinds (thick)",
	mesh = "homedecor_windowblind_thick.obj",
	inventory_image = "homedecor_windowblind_thick_inv.png",
	tiles = {
		"homedecor_windowblind_strings.png",
		"homedecor_windowblinds.png"
	},
	walkable = false,
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = wb1_cbox
})

local wb2_cbox = {
	type = "fixed",
	fixed = { -8/16, -8/16, 6/16, 8/16, 8/16, 8/16 },
}

homedecor.register("blinds_thin", {
	description = "Window Blinds (thin)",
	mesh = "homedecor_windowblind_thin.obj",
	inventory_image = "homedecor_windowblind_thin_inv.png",
	tiles = {
		"homedecor_windowblind_strings.png",
		"homedecor_windowblinds.png"
	},
	walkable = false,
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = wb2_cbox
})

local curtaincolors = {
	{ "red",    "#ad2323e0:175" },
	{ "green",  "#27a927e0:175" },
	{ "blue",   "#2626c6e0:175" },
	{ "white",  "#ffffffe0:175" },
	{ "pink",   "#ff8fb7e0:175" },
	{ "violet", "#7f29d7e0:175" },
}

for c in ipairs(curtaincolors) do
	local color = curtaincolors[c][1]
	local hue = curtaincolors[c][2]
	local color_d = S(curtaincolors[c][1])

	homedecor.register("curtain_"..color, {
		description = S("Curtains (%s)"):format(color_d),
		tiles = { "homedecor_curtain.png^[colorize:"..hue },
		inventory_image = "homedecor_curtain.png^[colorize:"..hue,
		wield_image = "homedecor_curtain.png^[colorize:"..hue,
		drawtype = 'signlike',
		use_texture_alpha = true,
		walkable = false,
		groups = { snappy = 3 },
		sounds = default.node_sound_leaves_defaults(),
		paramtype2 = 'wallmounted',
		selection_box = { type = "wallmounted" },
	-- Open the curtains
		on_rightclick = function(pos, node, clicker, itemstack)
			local topnode = minetest.get_node({x=pos.x, y=pos.y+1.0, z=pos.z})
			if string.find(topnode.name, "homedecor:curtainrod") then
				local fdir = node.param2
				minetest.set_node(pos, { name = "homedecor:curtain_open_"..color, param2 = fdir })
			end
		end
	})

	homedecor.register("curtain_open_"..color, {
		description = S("Curtains (%s)"):format(color_d),
		tiles = { "homedecor_curtain_open.png^[colorize:"..hue },
		inventory_image = "homedecor_curtain_open.png^[colorize:"..hue,
		wield_image = "homedecor_curtain_open.png^[colorize:"..hue,
		drawtype = 'signlike',
		use_texture_alpha = true,
		walkable = false,
		groups = { snappy = 3 },
		sounds = default.node_sound_leaves_defaults(),
		paramtype2 = 'wallmounted',
		selection_box = { type = "wallmounted" },
	-- Close the curtains
		on_rightclick = function(pos, node, clicker, itemstack)
			local topnode = minetest.get_node({x=pos.x, y=pos.y+1.0, z=pos.z})
			if string.find(topnode.name, "homedecor:curtainrod") then
				local fdir = node.param2
				minetest.set_node(pos, { name = "homedecor:curtain_"..color, param2 = fdir })
			end
		end
	})

end

local mats = {
	{ "brass", "Brass", "homedecor_generic_metal_brass.png" },
	{ "wrought_iron", "Wrought iron", "homedecor_generic_metal_wrought_iron.png" },
	{ "wood", "Wooden", "default_wood.png" }
}

for i in ipairs(mats) do
	local material = mats[i][1]
	local mat_name = mats[i][2]
	local texture = mats[i][3]
	homedecor.register("curtainrod_"..material, {
		tiles = { texture },
		inventory_image  = "homedecor_curtainrod_"..material.."_inv.png",
		description = "Curtain Rod ("..mat_name..")",
		groups = { snappy = 3 },
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, 0.375, 0.5, -0.4375, 0.4375},
				{-0.4375, -0.5, 0.4375, -0.375, -0.4375, 0.5},
				{0.375, -0.5, 0.4375, 0.4375, -0.4375, 0.5}
			}
		}
	})
end

homedecor.register("window_flowerbox", {
	description = "Window flowerbow",
	tiles = {
		"homedecor_flowerbox_top.png",
		"homedecor_flowerbox_bottom.png",
		"homedecor_flowerbox_sides.png"
	},
	inventory_image = "homedecor_flowerbox_inv.png",
	sounds = default.node_sound_stone_defaults(),
	groups = { snappy = 3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, 0.25, -0.125, 0.375, 0.5, 0.375}, -- NodeBox1
			{-0.3125, 0.4375, 0.375, -0.25, 0.4875, 0.5}, -- NodeBox2
			{0.25, 0.4375, 0.375, 0.3125, 0.4875, 0.5}, -- NodeBox3
		}
	}
})

homedecor.register("stained_glass", {
	description = "Stained Glass",
	tiles = {"homedecor_stained_glass.png"},
	inventory_image = "homedecor_stained_glass.png",
	groups = {snappy=3},
	use_texture_alpha = true,
	light_source = 3,
	sounds = default.node_sound_glass_defaults(),
	node_box = {
		type = "fixed",
		fixed = { {-0.5, -0.5, 0.46875, 0.5, 0.5, 0.5} }
	}
})
