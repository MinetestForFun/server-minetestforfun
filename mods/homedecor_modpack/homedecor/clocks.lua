local clock_sbox = {
	type = "fixed",
	fixed = { -8/32, -8/32, 14/32, 8/32, 8/32, 16/32 }
}

local clock_materials = {
	{ "plastic", "homedecor_generic_plastic_black.png^[colorize:#ffffff:220" },
	{ "wood", "default_wood.png" }
}

for i in ipairs(clock_materials) do
	local m1 = clock_materials[i][1]
	local m2 = clock_materials[i][2]
	homedecor.register("analog_clock_"..m1, {
		description = "Analog clock ("..m1..")",
		mesh = "homedecor_analog_clock.obj",
		tiles = {
			"homedecor_analog_clock_face.png",
			m2,
			"homedecor_analog_clock_back.png"
		},
		inventory_image = "homedecor_analog_clock_"..m1.."_inv.png",
		walkable = false,
		selection_box = clock_sbox,
		groups = {snappy=3},
		sounds = default.node_sound_wood_defaults(),
	})
end

homedecor.register("digital_clock", {
	description = "Digital clock",
	tiles = {
		"homedecor_digital_clock_edges.png",
		"homedecor_digital_clock_edges.png",
		"homedecor_digital_clock_edges.png",
		"homedecor_digital_clock_edges.png",
		"homedecor_digital_clock_back.png",
		"homedecor_digital_clock_front.png"
	},
	inventory_image = "homedecor_digital_clock_inv.png",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.28125, -0.25, 0.4375, 0.3125, 0.25, 0.5},
		}
	},
	walkable = false,
	sounds = default.node_sound_wood_defaults(),
	groups = {snappy=3},
})

homedecor.register("alarm_clock", {
	description = "Alarm clock",
	tiles = {
		"homedecor_alarm_clock_top.png",
		"homedecor_alarm_clock_bottom.png",
		"homedecor_alarm_clock_sides.png",
		"homedecor_alarm_clock_sides.png^[transformFX",
		"homedecor_alarm_clock_back.png",
		"homedecor_alarm_clock_front.png"
	},
	inventory_image = "homedecor_alarm_clock_inv.png",
	node_box = {
		type = "fixed",
		fixed = {
			{ -9/32, -16/32, 7/32, 10/32, -5/32, 16/32 },
		}
	},
	walkable = false,
	sounds = default.node_sound_wood_defaults(),
	groups = {snappy=3},
})

local gf_cbox = {
	type = "fixed",
	fixed = { -7/16, -8/16, -7/16, 7/16, 24/16, 7/16 }
}

homedecor.register("grandfather_clock", {
	description = "Grandfather Clock",
	mesh = "homedecor_grandfather_clock.obj",
	tiles = {
		"default_glass.png",
		"homedecor_grandfather_clock_face.png",
		"homedecor_generic_wood_luxury.png",
		"homedecor_grandfather_clock_face_edge.png",
		"homedecor_generic_metal_brass.png"
	},
	inventory_image = "homedecor_grandfather_clock_inv.png",
	groups = { snappy = 3 },
	selection_box = gf_cbox,
	collision_box = gf_cbox,
	sounds = default.node_sound_wood_defaults(),
	expand = { top="placeholder" },
	on_rotate = screwdriver.rotate_simple
})

minetest.register_alias("homedecor:grandfather_clock_bottom", "homedecor:grandfather_clock")
minetest.register_alias("homedecor:grandfather_clock_top", "air")
