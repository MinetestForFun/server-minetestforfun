local clock_cbox = {
	type = "fixed",
	fixed = {
		{ -8/32, -3/32, 14/32, 8/32, 3/32, 16/32 },
		{ -7/32, -5/32, 14/32, 7/32, 5/32, 16/32 },
		{ -6/32, -6/32, 14/32, 6/32, 6/32, 16/32 },
		{ -5/32, -7/32, 14/32, 5/32, 7/32, 16/32 },
		{ -3/32, -8/32, 14/32, 3/32, 8/32, 16/32 }
	}
}

local clock_sbox = {
	type = "fixed",
	fixed = { -8/32, -8/32, 14/32, 8/32, 8/32, 16/32 }
}

local materials = {"plastic", "wood"}

for _, m in ipairs(materials) do
	homedecor.register("analog_clock_"..m, {
		description = "Analog clock ("..m..")",
		mesh = "homedecor_analog_clock.obj",
		tiles = { "homedecor_analog_clock_"..m..".png" },
		inventory_image = "homedecor_analog_clock_"..m.."_inv.png",
		collision_box = clock_cbox,
		selection_box = clock_sbox,
		groups = {snappy=3},
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
		"homedecor_grandfather_clock_wood.png",
		"homedecor_grandfather_clock_face_edge.png",
		"homedecor_tile_brass2.png"
	},
	inventory_image = "homedecor_grandfather_clock_inv.png",
	groups = { snappy = 3 },
	selection_box = gf_cbox,
	collision_box = gf_cbox,
	sounds = default.node_sound_wood_defaults(),
	expand = { top="air" },
})

minetest.register_alias("homedecor:grandfather_clock_bottom", "homedecor:grandfather_clock")
minetest.register_alias("homedecor:grandfather_clock_top", "air")


