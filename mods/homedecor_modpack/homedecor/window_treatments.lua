
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
			},
		},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.0625, 0.5, 0.5, 0.0625}
		},
	},
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
			},
		},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.0625, 0.5, 0.5, 0.0625}
			},
		},
})

homedecor.register("blinds_thick", {
	description = "Window Blinds (thick)",
	tiles = { "homedecor_windowblinds.png" },
	walkable = false,
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.527123, 0.375, 0.3125, 0.523585, 0.5, 0.5}, -- NodeBox1
			{-0.5, 0.304245, 0.3125, 0.5, 0.3125, 0.5}, -- NodeBox2
			{-0.5, 0.244104, 0.3125, 0.5, 0.25, 0.5}, -- NodeBox3
			{-0.5, 0.180424, 0.3125, 0.5, 0.1875, 0.5}, -- NodeBox4
			{-0.5, 0.116745, 0.3125, 0.5, 0.125, 0.5}, -- NodeBox5
			{-0.5, 0.0566037, 0.3125, 0.5, 0.0625, 0.5}, -- NodeBox6
			{-0.5, -0.00707551, 0.3125, 0.5, 0, 0.5}, -- NodeBox7
			{-0.5, -0.0707547, 0.3125, 0.5, -0.0625, 0.5}, -- NodeBox8
			{-0.5, -0.130896, 0.3125, 0.5, -0.125, 0.5}, -- NodeBox9
			{-0.5, -0.194576, 0.3125, 0.5, -0.1875, 0.5}, -- NodeBox10
			{-0.5, -0.258255, 0.3125, 0.5, -0.25, 0.5}, -- NodeBox11
			{-0.5, -0.318396, 0.3125, 0.5, -0.3125, 0.5}, -- NodeBox12
			{-0.5, -0.5, 0.3125, 0.5, -0.4375, 0.5}, -- NodeBox13
			{-0.5, -0.378538, 0.3125, 0.5, -0.375, 0.5}, -- NodeBox14
			{-0.375, -0.5, 0.367925, -0.367925, 0.4375, 0.445755}, -- NodeBox15
			{0.367924, -0.5, 0.367925, 0.375, 0.5, 0.445755}, -- NodeBox16
			{0.375, 0.375, 0.25, 0.4375, 0.4375, 0.3125}, -- NodeBox17
			{0.396226, -0.325, 0.268868, 0.417453, 0.375, 0.290094}, -- NodeBox18
			},
		},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.527123, -0.5, 0.25, 0.523585, 0.5, 0.5}
			},
		},
})

homedecor.register("blinds_thin", {
	description = "Window Blinds (thin)",
	tiles = { "homedecor_windowblinds.png" },
	walkable = false,
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.52, 0.375, 0.4375, 0.52, 0.5, 0.5}, -- NodeBox1
			{-0.5, 0.304245, 0.4375, 0.5, 0.3125, 0.5}, -- NodeBox2
			{-0.5, 0.244104, 0.4375, 0.5, 0.25, 0.5}, -- NodeBox3
			{-0.5, 0.180424, 0.43755, 0.5, 0.1875, 0.5}, -- NodeBox4
			{-0.5, 0.116745, 0.4375, 0.5, 0.125, 0.5}, -- NodeBox5
			{-0.5, 0.0566037, 0.4375, 0.5, 0.0625, 0.5}, -- NodeBox6
			{-0.5, -0.00707551, 0.4375, 0.5, 0, 0.5}, -- NodeBox7
			{-0.5, -0.0707547, 0.4375, 0.5, -0.0625, 0.5}, -- NodeBox8
			{-0.5, -0.130896, 0.4375, 0.5, -0.125, 0.5}, -- NodeBox9
			{-0.5, -0.194576, 0.4375, 0.5, -0.1875, 0.5}, -- NodeBox10
			{-0.5, -0.258255, 0.4375, 0.5, -0.25, 0.5}, -- NodeBox11
			{-0.5, -0.318396, 0.4375, 0.5, -0.3125, 0.5}, -- NodeBox12
			{-0.5, -0.5, 0.4375, 0.5, -0.4375, 0.5}, -- NodeBox13
			{-0.5, -0.378538, 0.4375, 0.5, -0.375, 0.5}, -- NodeBox14
			{-0.375, -0.49, 0.4575, -0.367925, 0.4375, 0.48}, -- NodeBox15
			{0.367924, -0.49, 0.4575, 0.375, 0.5, 0.48}, -- NodeBox16
			{0.375, 0.375, 0.375, 0.4375, 0.4375, 0.4375}, -- NodeBox17
			{0.396226, -0.325, 0.4, 0.417453, 0.375, 0.42}, -- NodeBox18
			},
		},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.52, -0.5, 0.375, 0.52, 0.5, 0.5}
			},
		},
})

local curtaincolors = {
	"red",
	"green",
	"blue",
	"white",
	"pink",
	"violet"
}

for c in ipairs(curtaincolors) do
	local color = curtaincolors[c]
	local color_d = S(curtaincolors[c])

	homedecor.register("curtain_"..color, {
		description = S("Curtains (%s)"):format(color_d),
		tiles = { "homedecor_curtain_"..color..".png" },
		inventory_image = "homedecor_curtain_"..color..".png",
		wield_image = "homedecor_curtain_"..color..".png",
		drawtype = 'signlike',
		sunlight_propagates = true,
		use_texture_alpha = true,
		walkable = false,
		groups = { snappy = 3 },
		sounds = default.node_sound_leaves_defaults(),
		paramtype2 = 'wallmounted',
		selection_box = {
			type = "wallmounted",
		},
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
		tiles = { "homedecor_curtain_open_"..color..".png" },
		inventory_image = "homedecor_curtain_open_"..color..".png",
		wield_image = "homedecor_curtain_open_"..color..".png",
		drawtype = 'signlike',
		sunlight_propagates = true,
		use_texture_alpha = true,
		walkable = false,
		groups = { snappy = 3 },
		sounds = default.node_sound_leaves_defaults(),
		paramtype2 = 'wallmounted',
		selection_box = {
			type = "wallmounted",
		},
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
	{ "brass", "Brass", "homedecor_tile_brass2.png" },
	{ "wrought_iron", "Wrought iron", "homedecor_tile_wrought_iron2.png" },
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
		sunlight_propagates = true,
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
