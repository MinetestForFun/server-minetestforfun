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

