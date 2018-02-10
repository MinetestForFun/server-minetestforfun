for _, colour in pairs({"red", "white", "black", "blue", "green"}) do-- fancy shaped bed
	beds.register_bed("beds:fancy_bed_" .. colour, {
		description = "Fancy Bed (" .. colour .. ")",
		inventory_image = "beds_bed_fancy_" .. colour .. ".png",
		wield_image = "beds_bed_fancy_" .. colour .. ".png",
		tiles = {
		    bottom = {
			"beds_bed_top1_" .. colour .. ".png",
			"default_wood.png",
			"beds_bed_side1_" .. colour .. ".png",
			"beds_bed_side1_" .. colour .. ".png^[transformFX",
			"default_wood.png",
			"beds_bed_foot_" .. colour .. ".png",
		    },
		    top = {
			"beds_bed_top2_" .. colour .. ".png",
			"default_wood.png",
			"beds_bed_side2_" .. colour .. ".png",
			"beds_bed_side2_" .. colour .. ".png^[transformFX",
			"beds_bed_head.png",
			"default_wood.png",
		    }
		},
		nodebox = {
		    bottom = {
			{-0.5, -0.5, -0.5, -0.375, -0.065, -0.4375},
			{0.375, -0.5, -0.5, 0.5, -0.065, -0.4375},
			{-0.5, -0.375, -0.5, 0.5, -0.125, -0.4375},
			{-0.5, -0.375, -0.5, -0.4375, -0.125, 0.5},
			{0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
			{-0.4375, -0.3125, -0.4375, 0.4375, -0.0625, 0.5},
		      },
		      top = {
			{-0.5, -0.5, 0.4375, -0.375, 0.1875, 0.5},
			{0.375, -0.5, 0.4375, 0.5, 0.1875, 0.5},
			{-0.5, 0, 0.4375, 0.5, 0.125, 0.5},
			{-0.5, -0.375, 0.4375, 0.5, -0.125, 0.5},
			{-0.5, -0.375, -0.5, -0.4375, -0.125, 0.5},
			{0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
			{-0.4375, -0.3125, -0.5, 0.4375, -0.0625, 0.4375},
		      }
		},
		selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
		recipe = {
			{"", "", "group:stick"},
			{"wool:" .. colour, "wool:" .. colour, "wool:white"},
			{"group:wood", "group:wood", "group:wood"},
		},
	})

	-- simple shaped bed
	beds.register_bed("beds:bed_" .. colour, {
		description = "Simple Bed (" .. colour .. ")",
		inventory_image = "beds_bed_" .. colour .. ".png",
		wield_image = "beds_bed_" .. colour .. ".png",
		tiles = {
		    bottom = {
			"beds_bed_top_bottom_" .. colour .. ".png^[transformR90",
			"default_wood.png",
			"beds_bed_side_bottom_r_" .. colour .. ".png",
			"beds_bed_side_bottom_r_" .. colour .. ".png^[transformfx",
			"beds_transparent.png",
			"beds_bed_side_bottom_" .. colour .. ".png"
		    },
		    top = {
			"beds_bed_top_top_" .. colour .. ".png^[transformR90",
			"default_wood.png",
			"beds_bed_side_top_r_" .. colour .. ".png",
			"beds_bed_side_top_r_" .. colour .. ".png^[transformfx",
			"beds_bed_side_top.png",
			"beds_transparent.png",
		    }
		},
		nodebox = {
		    bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		    top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		},
		selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
		recipe = {
			{"wool:" .. colour, "wool:" .. colour, "wool:white"},
			{"group:wood", "group:wood", "group:wood"}
		},
	
	})
end

minetest.register_alias("beds:bed", "beds:bed_red")
minetest.register_alias("beds:fancy_bed", "beds:fancy_bed_red")
minetest.register_alias("beds:bed_bottom", "beds:bed_red_bottom")
minetest.register_alias("beds:bed_top", "beds:bed_red_top")
minetest.register_alias("beds:fancy_bed_top", "beds:fancy_bed_red_top")
minetest.register_alias("beds:fancy_bed_bottom", "beds:fancy_bed_red_bottom")
