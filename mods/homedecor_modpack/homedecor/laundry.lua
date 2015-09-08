-- laundry devices

homedecor.register("washing_machine", {
	description = "Washing Machine",
	tiles = {
		"homedecor_washing_machine_top.png",
		"homedecor_washing_machine_bottom.png",
		"homedecor_washing_machine_sides.png",
		"homedecor_washing_machine_sides.png^[transformFX",
		"homedecor_washing_machine_back.png",
		"homedecor_washing_machine_front.png"
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.375, 0.375},
			{-0.5, -0.5, 0.3125, 0.5, 0.5, 0.5},
		}
	},
	selection_box = { type = "regular" },
	groups = { snappy = 3 },
})

homedecor.register("dryer", {
	description = "Tumble dryer",
	tiles = {
		"homedecor_dryer_top.png",
		"homedecor_dryer_bottom.png",
		"homedecor_dryer_sides.png",
		"homedecor_dryer_sides.png^[transformFX",
		"homedecor_dryer_back.png",
		"homedecor_dryer_front.png"
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.375, 0.375},
			{-0.5, -0.5, 0.3125, 0.5, 0.5, 0.5},
		}
	},
	selection_box = { type = "regular" },
	groups = { snappy = 3 },
})

local ib_cbox = {
	type = "fixed",
	fixed = { -6/16, -8/16, -4/16, 17/16, 4/16, 4/16 }
}

homedecor.register("ironing_board", {
	description = "Ironing board",
	mesh = "homedecor_ironing_board.obj",
	tiles = {
		"wool_grey.png",
		"homedecor_generic_metal_black.png^[brighten"
	},
	expand = {right = "placeholder"},
	groups = { snappy = 3 },
	selection_box = ib_cbox,
	collision_box = ib_cbox
})
