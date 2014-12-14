--dofile(minetest.get_modpath("christmas_craft").."/mods.lua")--disabled because 4seasons is not installed
dofile(minetest.get_modpath("christmas_craft").."/crafts.lua") --temporary disabled because cristmas is over--
dofile(minetest.get_modpath("christmas_craft").."/settings.lua") -- makes it snow
-- blocks --

minetest.register_node("christmas_craft:snowman", {
	description = "Snowman",
	tiles = {"snow.png", "snow.png", "snow.png",
		"snow.png", "snow.png", "Snowman_F.png"},
	is_ground_content = true,
	paramtype2 = "facedir",
	groups = {crumbly=3},
	sounds = default.node_sound_sand_defaults(),
}) 



minetest.register_node("christmas_craft:christmas_lights", {
	description = "christmas lights",
	drawtype = "signlike",
	light_source = 10,
	walkable = false,
	tiles = {
		{name="lights_animated.png", animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=3.0}},
		},
	inventory_image =  "c_lights.png",
	wield_image = "c_lights.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	selection_box = {
		type = "wallmounted",
	},
	groups = {oddly_breakable_by_hand = 3}, 
})

minetest.register_node("christmas_craft:christmas_wreath", {
	description = "Christmas Wreath",
	drawtype = "signlike",
	walkable = false,
	tiles = {
		{name="Wreath.png", animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=3.0}},
		},
	inventory_image =  "Wreath.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	selection_box = {
		type = "wallmounted",
	},
	groups = {oddly_breakable_by_hand = 3}, 
})

minetest.register_node("christmas_craft:christmas_star", {
	description = "christmas Star",
	drawtype = "plantlike",
	light_source = 10,
	tiles = {"star.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("christmas_craft:snow_block", {
	description = "snow block",
	tiles = {"snow.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("christmas_craft:christmas_leaves", {
	description = "Christmas leaves",
	drawtype = "allfaces_optional",
	tiles = {"christmas_leaves.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {crumbly=3},
	sounds = default.node_sound_sand_defaults(),
})



minetest.register_node("christmas_craft:red_baubles", {
	description = "Red Baubles",
	drawtype = "nodebox",
	tiles = {"christmas_craft_baubles_top_re.png^christmas_craft_baubles_top.png","christmas_craft_baubles_top_re.png","christmas_craft_baubles_side_re.png"},
	is_ground_content = true,
	paramtype = "light",
	groups = {crumbly=3},
	sounds = default.node_sound_sand_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.438, -0.25, 0.25, -0.05, 0.25},
			{-0.08, 0.5, -0.08, 0.08, -0.0, 0.08},
			
			-- side , top , side , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.438, -0.25, 0.25, -0.05, 0.25},
			{-0.08, 0.5, -0.08, 0.08, -0.0, 0.08},
		},
	},
})

minetest.register_node("christmas_craft:yellow_baubles", {
	description = "Yellow Baubles",
	drawtype = "nodebox",
	tiles = {"christmas_craft_baubles_top_ye.png^christmas_craft_baubles_top.png","christmas_craft_baubles_top_ye.png","christmas_craft_baubles_side_ye.png"},
	is_ground_content = true,
	paramtype = "light",
	groups = {crumbly=3},
	sounds = default.node_sound_sand_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.438, -0.25, 0.25, -0.05, 0.25},
			{-0.08, 0.5, -0.08, 0.08, -0.0, 0.08},
			
			-- side , top , side , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.438, -0.25, 0.25, -0.05, 0.25},
			{-0.08, 0.5, -0.08, 0.08, -0.0, 0.08},
		},
	},
})

minetest.register_node("christmas_craft:green_baubles", {
	description = "Green Baubles",
	drawtype = "nodebox",
	tiles = {"christmas_craft_baubles_top_gr.png^christmas_craft_baubles_top.png","christmas_craft_baubles_top_gr.png","christmas_craft_baubles_side_gr.png"},
	is_ground_content = true,
	paramtype = "light",
	groups = {crumbly=3},
	sounds = default.node_sound_sand_defaults(),
		node_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.438, -0.25, 0.25, -0.05, 0.25},
			{-0.08, 0.5, -0.08, 0.08, -0.0, 0.08},
			
			-- side , top , side , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.438, -0.25, 0.25, -0.05, 0.25},
			{-0.08, 0.5, -0.08, 0.08, -0.0, 0.08},
		},
	},
})


minetest.register_node("christmas_craft:blue_baubles", {
	description = "Blue Baubles",
	drawtype = "nodebox",
	tiles = {"christmas_craft_baubles_top_bl.png^christmas_craft_baubles_top.png","christmas_craft_baubles_top_bl.png","christmas_craft_baubles_side_bl.png"},
	is_ground_content = true,
	paramtype = "light",
	groups = {crumbly=3},
	sounds = default.node_sound_sand_defaults(),
		node_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.438, -0.25, 0.25, -0.05, 0.25},
			{-0.08, 0.5, -0.08, 0.08, -0.0, 0.08},
			
			-- side , top , side , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.438, -0.25, 0.25, -0.05, 0.25},
			{-0.08, 0.5, -0.08, 0.08, -0.0, 0.08},
		},
	},
})

minetest.register_node("christmas_craft:orange_baubles", {
	description = "Orange Baubles",
	drawtype = "nodebox",
	tiles = {"christmas_craft_baubles_top_or.png^christmas_craft_baubles_top.png","christmas_craft_baubles_top_or.png","christmas_craft_baubles_side_or.png"},
	is_ground_content = true,
	paramtype = "light",
	groups = {crumbly=3},
	sounds = default.node_sound_sand_defaults(),
		node_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.438, -0.25, 0.25, -0.05, 0.25},
			{-0.08, 0.5, -0.08, 0.08, -0.0, 0.08},
			
			-- side , top , side , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.438, -0.25, 0.25, -0.05, 0.25},
			{-0.08, 0.5, -0.08, 0.08, -0.0, 0.08},
		},
	},
})

minetest.register_node("christmas_craft:violet_baubles", {
	description = "Violet Baubles",
	drawtype = "nodebox",
	tiles = {"christmas_craft_baubles_top_vi.png^christmas_craft_baubles_top.png","christmas_craft_baubles_top_vi.png","christmas_craft_baubles_side_vi.png"},
	is_ground_content = true,
	paramtype = "light",
	groups = {crumbly=3},
	sounds = default.node_sound_sand_defaults(),
		node_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.438, -0.25, 0.25, -0.05, 0.25},
			{-0.08, 0.5, -0.08, 0.08, -0.0, 0.08},
			
			-- side , top , side , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.438, -0.25, 0.25, -0.05, 0.25},
			{-0.08, 0.5, -0.08, 0.08, -0.0, 0.08},
		},
	},
})

minetest.register_node("christmas_craft:pink_baubles", {
	description = "Pink Baubles",
	drawtype = "nodebox",
	tiles = {"christmas_craft_baubles_top_pi.png^christmas_craft_baubles_top.png","christmas_craft_baubles_top_pi.png","christmas_craft_baubles_side_pi.png"},
	is_ground_content = true,
	paramtype = "light",
	groups = {crumbly=3},
	sounds = default.node_sound_sand_defaults(),
		node_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.438, -0.25, 0.25, -0.05, 0.25},
			{-0.08, 0.5, -0.08, 0.08, -0.0, 0.08},
			
			-- side , top , side , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.438, -0.25, 0.25, -0.05, 0.25},
			{-0.08, 0.5, -0.08, 0.08, -0.0, 0.08},
		},
	},
})

minetest.register_node("christmas_craft:silver_baubles", {
	description = "Silver Baubles",
	drawtype = "nodebox",
	tiles = {"christmas_craft_baubles_top_si.png^christmas_craft_baubles_top.png","christmas_craft_baubles_top_si.png","christmas_craft_baubles_side_si.png"},
	is_ground_content = true,
	paramtype = "light",
	groups = {crumbly=3},
	sounds = default.node_sound_sand_defaults(),
		node_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.438, -0.25, 0.25, -0.05, 0.25},
			{-0.08, 0.5, -0.08, 0.08, -0.0, 0.08},
			
			-- side , top , side , side , bottom, side,
				
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.438, -0.25, 0.25, -0.05, 0.25},
			{-0.08, 0.5, -0.08, 0.08, -0.0, 0.08},
		},
	},
})

------------
--nodes--
	
	-- presents --
	
	minetest.register_node("christmas_craft:present_box", {
		description = "Present Box",
		tiles = {"christmas_craft_present_box.png"},
		is_ground_content = true,
		paramtype = "light",
		groups = {crumbly=3},
		sounds = default.node_sound_sand_defaults(),
	})
	
	minetest.register_node("christmas_craft:Christmas_present", {
		description = "Christmas Present",
		tiles = {"christmas_craft_present_wh.png^christmas_craft_bow_top.png", "christmas_craft_present_wh.png^christmas_craft_bow_bottom.png", "christmas_craft_present_wh.png^christmas_craft_bow_side.png"},
		is_ground_content = true,
		groups = {crumbly=3},
		drop = {
			max_items = 1, min_items = 1, items = {
				{items = {'default:bookshelf'},	rarity = 90,},
				{items = {'default:pick_mese'},	rarity = 80,},
				{items = {'default:shovel_steel'},	rarity = 90,},
				{items = {'default:axe_steel'},	rarity = 90,},
				{items = {'default:pick_steel'},	rarity = 90,},
				{items = {'default:sign_wall'},	rarity = 80,},
				{items = {'default:chest'},	rarity = 80,},
				{items = {'default:furnace'},	rarity = 80,},
				{items = {'default:steelblock'},	rarity = 80,},
				{items = {'default:coal_lump'},	rarity = 80,},
				{items = {'default:pick_diamond'},	rarity = 75,},
				{items = {'default:shovel_diamond'},	rarity = 75,},
				{items = {'default:axe_diamond'},	rarity = 75,},
				{items = {'default:diamondblock'},	rarity = 75},
				{items = {'fake_fire:flint_and_steel'},	rarity = 90,},
				{items = {'default:chest_locked'},	rarity = 80,},
				{items = {'default:brick'},	rarity = 80,},
				{items = {'default:dirt_with_grass'}, rarity = 80,},	
			}},
		sounds = default.node_sound_dirt_defaults({
			footstep = {name="default_grass_footstep", gain=0.4},
		}),
	})
	
	minetest.register_node("christmas_craft:Christmas_present_green", {
		description = "Christmas Present Green ",
		tiles = {"christmas_craft_present_gr.png^christmas_craft_bow_top.png", "christmas_craft_present_gr.png^christmas_craft_bow_bottom.png", "christmas_craft_present_gr.png^christmas_craft_bow_side.png"},
		is_ground_content = true,
		groups = {crumbly=3},
		drop = {
			max_items = 2, items = {
				{items = {'default:bookshelf'},	rarity = 15,},
				{items = {'default:pick_mese'},	rarity = 20,},
				{items = {'default:shovel_steel'},	rarity = 15,},
				{items = {'default:axe_steel'},	rarity = 15,},
				{items = {'default:pick_steel'},	rarity = 15,},
				{items = {'default:sign_wall'},	rarity = 20,},
				{items = {'default:chest'},	rarity = 20,},
				{items = {'default:furnace'},	rarity = 20,},
				{items = {'default:steelblock'},	rarity = 25,},
				{items = {'default:coal_lump'},	rarity = 25,},
				{items = {'diamonds:pick'},	rarity = 30,},
				{items = {'diamonds:shovel'},	rarity = 30,},
				{items = {'diamonds:axe'},	rarity = 30,},
				{items = {'diamonds:block'},	rarity = 30,},
				{items = {'fake_fire:flint_and_steel'},	rarity = 15,},
				{items = {'default:chest_locked'},	rarity = 20,},
				{items = {'default:brick'},	rarity = 25,},
				{items = {'default:dirt_with_grass'},	rarity = 30,},	
			}},
		sounds = default.node_sound_dirt_defaults({
			footstep = {name="default_grass_footstep", gain=0.4},
		}),
	})
	
	minetest.register_node("christmas_craft:Christmas_present_red", {
		description = "Christmas Present Red ",
		tiles = {"christmas_craft_present_re.png^christmas_craft_bow_top.png", "christmas_craft_present_re.png^christmas_craft_bow_bottom.png", "christmas_craft_present_re.png^christmas_craft_bow_side.png"},
		is_ground_content = true,
		groups = {crumbly=3},
		drop = {
			max_items = 2, items = {
				{items = {'default:bookshelf'},	rarity = 15,},
				{items = {'default:pick_mese'},	rarity = 20,},
				{items = {'default:shovel_steel'},	rarity = 15,},
				{items = {'default:axe_steel'},	rarity = 15,},
				{items = {'default:pick_steel'},	rarity = 15,},
				{items = {'default:sign_wall'},	rarity = 20,},
				{items = {'default:chest'},	rarity = 20,},
				{items = {'default:furnace'},	rarity = 20,},
				{items = {'default:steelblock'},	rarity = 25,},
				{items = {'default:coal_lump'},	rarity = 25,},
				{items = {'diamonds:pick'},	rarity = 30,},
				{items = {'diamonds:shovel'},	rarity = 30,},
				{items = {'diamonds:axe'},	rarity = 30,},
				{items = {'diamonds:block'},	rarity = 30,},
				{items = {'fake_fire:flint_and_steel'},	rarity = 15,},
				{items = {'default:chest_locked'},	rarity = 20,},
				{items = {'default:brick'},	rarity = 25,},
				{items = {'default:dirt_with_grass'},	rarity = 30,},	
			}},
		sounds = default.node_sound_dirt_defaults({
			footstep = {name="default_grass_footstep", gain=0.4},
		}),
	})

	minetest.register_node("christmas_craft:Christmas_present_blue", {
		description = "Christmas Present Blue ",
		tiles = {"christmas_craft_present_bl.png^christmas_craft_bow_top.png", "christmas_craft_present_bl.png^christmas_craft_bow_bottom.png", "christmas_craft_present_bl.png^christmas_craft_bow_side.png"},
		is_ground_content = true,
		groups = {crumbly=3},
		drop = {
			max_items = 2, items = {
				{items = {'default:bookshelf'},	rarity = 15,},
				{items = {'default:pick_mese'},	rarity = 20,},
				{items = {'default:shovel_steel'},	rarity = 15,},
				{items = {'default:axe_steel'},	rarity = 15,},
				{items = {'default:pick_steel'},	rarity = 15,},
				{items = {'default:sign_wall'},	rarity = 20,},
				{items = {'default:chest'},	rarity = 20,},
				{items = {'default:furnace'},	rarity = 20,},
				{items = {'default:steelblock'},	rarity = 25,},
				{items = {'default:coal_lump'},	rarity = 25,},
				{items = {'diamonds:pick'},	rarity = 30,},
				{items = {'diamonds:shovel'},	rarity = 30,},
				{items = {'diamonds:axe'},	rarity = 30,},
				{items = {'diamonds:block'},	rarity = 30,},
				{items = {'fake_fire:flint_and_steel'},	rarity = 15,},
				{items = {'default:chest_locked'},	rarity = 20,},
				{items = {'default:brick'},	rarity = 25,},
				{items = {'default:dirt_with_grass'},	rarity = 30,},	
			}},
		sounds = default.node_sound_dirt_defaults({
			footstep = {name="default_grass_footstep", gain=0.4},
		}),
	})
	
	minetest.register_node("christmas_craft:Christmas_present_yellow", {
		description = "Christmas Present Yellow ",
		tiles = {"christmas_craft_present_ye.png^christmas_craft_bow_top.png", "christmas_craft_present_ye.png^christmas_craft_bow_bottom.png", "christmas_craft_present_ye.png^christmas_craft_bow_side.png"},
		is_ground_content = true,
		groups = {crumbly=3},
		drop = {
			max_items = 2, items = {
				{items = {'default:bookshelf'},	rarity = 15,},
				{items = {'default:pick_mese'},	rarity = 20,},
				{items = {'default:shovel_steel'},	rarity = 15,},
				{items = {'default:axe_steel'},	rarity = 15,},
				{items = {'default:pick_steel'},	rarity = 15,},
				{items = {'default:sign_wall'},	rarity = 20,},
				{items = {'default:chest'},	rarity = 20,},
				{items = {'default:furnace'},	rarity = 20,},
				{items = {'default:steelblock'},	rarity = 25,},
				{items = {'default:coal_lump'},	rarity = 25,},
				{items = {'diamonds:pick'},	rarity = 30,},
				{items = {'diamonds:shovel'},	rarity = 30,},
				{items = {'diamonds:axe'},	rarity = 30,},
				{items = {'diamonds:block'},	rarity = 30,},
				{items = {'fake_fire:flint_and_steel'},	rarity = 15,},
				{items = {'default:chest_locked'},	rarity = 20,},
				{items = {'default:brick'},	rarity = 25,},
				{items = {'default:dirt_with_grass'},	rarity = 30,},	
			}},
		sounds = default.node_sound_dirt_defaults({
			footstep = {name="default_grass_footstep", gain=0.4},
		}),
	})
	
	minetest.register_node("christmas_craft:Christmas_present_red", {
		description = "Christmas Present Red ",
		tiles = {"christmas_craft_present_re.png^christmas_craft_bow_top.png", "christmas_craft_present_re.png^christmas_craft_bow_bottom.png", "christmas_craft_present_re.png^christmas_craft_bow_side.png"},
		is_ground_content = true,
		groups = {crumbly=3},
		drop = {
			max_items = 2, items = {
				{items = {'default:bookshelf'},	rarity = 15,},
				{items = {'default:pick_mese'},	rarity = 20,},
				{items = {'default:shovel_steel'},	rarity = 15,},
				{items = {'default:axe_steel'},	rarity = 15,},
				{items = {'default:pick_steel'},	rarity = 15,},
				{items = {'default:sign_wall'},	rarity = 20,},
				{items = {'default:chest'},	rarity = 20,},
				{items = {'default:furnace'},	rarity = 20,},
				{items = {'default:steelblock'},	rarity = 25,},
				{items = {'default:coal_lump'},	rarity = 25,},
				{items = {'diamonds:pick'},	rarity = 30,},
				{items = {'diamonds:shovel'},	rarity = 30,},
				{items = {'diamonds:axe'},	rarity = 30,},
				{items = {'diamonds:block'},	rarity = 30,},
				{items = {'fake_fire:flint_and_steel'},	rarity = 15,},
				{items = {'default:chest_locked'},	rarity = 20,},
				{items = {'default:brick'},	rarity = 25,},
				{items = {'default:dirt_with_grass'},	rarity = 30,},	
			}},
		sounds = default.node_sound_dirt_defaults({
			footstep = {name="default_grass_footstep", gain=0.4},
		}),
	})
	
	minetest.register_node("christmas_craft:Christmas_present_violet", {
		description = "Christmas Present Violet ",
		tiles = {"christmas_craft_present_vi.png^christmas_craft_bow_top.png", "christmas_craft_present_vi.png^christmas_craft_bow_bottom.png", "christmas_craft_present_vi.png^christmas_craft_bow_side.png"},
		is_ground_content = true,
		groups = {crumbly=3},
		drop = {
			max_items = 2, items = {
				{items = {'default:bookshelf'},	rarity = 15,},
				{items = {'default:pick_mese'},	rarity = 20,},
				{items = {'default:shovel_steel'},	rarity = 15,},
				{items = {'default:axe_steel'},	rarity = 15,},
				{items = {'default:pick_steel'},	rarity = 15,},
				{items = {'default:sign_wall'},	rarity = 20,},
				{items = {'default:chest'},	rarity = 20,},
				{items = {'default:furnace'},	rarity = 20,},
				{items = {'default:steelblock'},	rarity = 25,},
				{items = {'default:coal_lump'},	rarity = 25,},
				{items = {'diamonds:pick'},	rarity = 30,},
				{items = {'diamonds:shovel'},	rarity = 30,},
				{items = {'diamonds:axe'},	rarity = 30,},
				{items = {'diamonds:block'},	rarity = 30,},
				{items = {'fake_fire:flint_and_steel'},	rarity = 15,},
				{items = {'default:chest_locked'},	rarity = 20,},
				{items = {'default:brick'},	rarity = 25,},
				{items = {'default:dirt_with_grass'},	rarity = 30,},	
			}},
		sounds = default.node_sound_dirt_defaults({
			footstep = {name="default_grass_footstep", gain=0.4},
		}),
	})
	
	minetest.register_node("christmas_craft:Christmas_present_orange", {
		description = "Christmas Present Orange ",
		tiles = {"christmas_craft_present_or.png^christmas_craft_bow_top.png", "christmas_craft_present_or.png^christmas_craft_bow_bottom.png", "christmas_craft_present_or.png^christmas_craft_bow_side.png"},
		is_ground_content = true,
		groups = {crumbly=3},
		drop = {
			max_items = 2, items = {
				{items = {'default:bookshelf'},	rarity = 15,},
				{items = {'default:pick_mese'},	rarity = 20,},
				{items = {'default:shovel_steel'},	rarity = 15,},
				{items = {'default:axe_steel'},	rarity = 15,},
				{items = {'default:pick_steel'},	rarity = 15,},
				{items = {'default:sign_wall'},	rarity = 20,},
				{items = {'default:chest'},	rarity = 20,},
				{items = {'default:furnace'},	rarity = 20,},
				{items = {'default:steelblock'},	rarity = 25,},
				{items = {'default:coal_lump'},	rarity = 25,},
				{items = {'diamonds:pick'},	rarity = 30,},
				{items = {'diamonds:shovel'},	rarity = 30,},
				{items = {'diamonds:axe'},	rarity = 30,},
				{items = {'diamonds:block'},	rarity = 30,},
				{items = {'fake_fire:flint_and_steel'},	rarity = 15,},
				{items = {'default:chest_locked'},	rarity = 20,},
				{items = {'default:brick'},	rarity = 25,},
				{items = {'default:dirt_with_grass'},	rarity = 30,},	
			}},
		sounds = default.node_sound_dirt_defaults({
			footstep = {name="default_grass_footstep", gain=0.4},
		}),
	})
	
	minetest.register_node("christmas_craft:Christmas_present_pink", {
		description = "Christmas Present Pink ",
		tiles = {"christmas_craft_present_pi.png^christmas_craft_bow_top.png", "christmas_craft_present_pi.png^christmas_craft_bow_bottom.png", "christmas_craft_present_pi.png^christmas_craft_bow_side.png"},
		is_ground_content = true,
		groups = {crumbly=3},
		drop = {
			max_items = 2, items = {
				{items = {'default:bookshelf'},	rarity = 15,},
				{items = {'default:pick_mese'},	rarity = 20,},
				{items = {'default:shovel_steel'},	rarity = 15,},
				{items = {'default:axe_steel'},	rarity = 15,},
				{items = {'default:pick_steel'},	rarity = 15,},
				{items = {'default:sign_wall'},	rarity = 20,},
				{items = {'default:chest'},	rarity = 20,},
				{items = {'default:furnace'},	rarity = 20,},
				{items = {'default:steelblock'},	rarity = 25,},
				{items = {'default:coal_lump'},	rarity = 25,},
				{items = {'diamonds:pick'},	rarity = 30,},
				{items = {'diamonds:shovel'},	rarity = 30,},
				{items = {'diamonds:axe'},	rarity = 30,},
				{items = {'diamonds:block'},	rarity = 30,},
				{items = {'fake_fire:flint_and_steel'},	rarity = 15,},
				{items = {'default:chest_locked'},	rarity = 20,},
				{items = {'default:brick'},	rarity = 25,},
				{items = {'default:dirt_with_grass'},	rarity = 30,},	
			}},	
		sounds = default.node_sound_dirt_defaults({
			footstep = {name="default_grass_footstep", gain=0.4},
		}),
	})
------------

------------
--Items--

	-- paper --

	minetest.register_craftitem("christmas_craft:paper_blue", {
		description = "Blue paper",
		inventory_image = "christmas_craft_paper_bl.png",
		stack_max = 99,
		liquids_pointable = false,
	})

	minetest.register_craftitem("christmas_craft:paper_yellow", {
		description = "Yellow paper",
		inventory_image = "christmas_craft_paper_ye.png",
		stack_max = 99,
		liquids_pointable = false,
	})

	minetest.register_craftitem("christmas_craft:paper_green", {
		description = "Green paper",
		inventory_image = "christmas_craft_paper_gr.png",
		stack_max = 99,
		liquids_pointable = false,
	})

	minetest.register_craftitem("christmas_craft:paper_red", {
		description = "Red paper",
		inventory_image = "christmas_craft_paper_re.png",
		stack_max = 99,
		liquids_pointable = false,
	})

	minetest.register_craftitem("christmas_craft:paper_violet", {
		description = "Violet paper",
		inventory_image = "christmas_craft_paper_vi.png",
		stack_max = 99,
		liquids_pointable = false,
	})

	minetest.register_craftitem("christmas_craft:paper_orange", {
		description = "Orange paper",
		inventory_image = "christmas_craft_paper_or.png",
		stack_max = 99,
		liquids_pointable = false,
	})

	minetest.register_craftitem("christmas_craft:paper_pink", {
		description = "Pink paper",
		inventory_image = "christmas_craft_paper_pi.png",
		stack_max = 99,
		liquids_pointable = false,
	})
	
	-- string --
	
		minetest.register_craftitem("christmas_craft:red_ribbon", {
		description = "Red Ribbon",
		inventory_image = "christmas_craft_red_ribbon.png",
		stack_max = 99,
		liquids_pointable = false,
	})
	
	-- wish list --
	
	minetest.register_craftitem("christmas_craft:wish_list", {
		description = "Wish list",
		inventory_image = "christmas_craft_which_list.png",
		stack_max = 99,
		liquids_pointable = false,
	})
	
------------

-- minetest.register_craftitem("christmas_craft:snow_ball", {
--	description = "Snow ball",
--	inventory_image = "snow_ball.png",
--	stack_max = 16,
--	liquids_pointable = false, 
--})


-- crafts --

--for craft see in craft.lua

-- override --
--minetest.registered_nodes["default:stick"].drawtype="torchlike";
--minetest.registered_nodes["default:stick"].selection_box = {
--		type = "wallmounted",
--		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
--	}

minetest.register_node(":default:stick", {
	description = "stick",
	drawtype = "torchlike",
	--tiles = {"default_torch_on_floor.png", "default_torch_on_ceiling.png", "default_torch.png"},
	tiles = {"side_stick.png"},
	inventory_image = "default_stick.png",
	wield_image = "default_stick.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	groups = {choppy=2,dig_immediate=3,flammable=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})

-- complex node  -- 

snowball_DAMAGE=0.5
snowball_GRAVITY=9
snowball_VELOCITY=19

--Shoot snowball.
local snow_shoot_snowball=function (item, player, pointed_thing)
	local playerpos=player:getpos()
	local obj=minetest.env:add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, "christmas_craft:snowball_entity")
	local dir=player:get_look_dir()
	obj:setvelocity({x=dir.x*snowball_VELOCITY, y=dir.y*snowball_VELOCITY, z=dir.z*snowball_VELOCITY})
	obj:setacceleration({x=dir.x*-3, y=-snowball_GRAVITY, z=dir.z*-3})
	item:take_item()
	return item
end


--The snowball Entity
snow_snowball_ENTITY={
	physical = false,
	timer=0,
	damage=1,
	gravity=10,
	velocity=19,
	range=1,
	textures = {"snowball.png"},
	lastpos={},
	collisionbox = {-0.25,-0.25,-0.25, 0.25,0.25,0.25},
	
}


--Snowball_entity.on_step()--> called when snowball is moving.
snow_snowball_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)
	
	--Become item when hitting a node.
	if self.lastpos.x~=nil then --If there is no lastpos for some reason.
		if node.name ~= "air" then
			self.object:remove()
		end
		if node.name == "default:water_source" then
			minetest.sound_play("cannons_splash",
			{pos = pos, gain = 1.0, max_hear_distance = 32,})
			self.object:remove()
		end
		
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z} -- Set lastpos-->Node will be added at last pos outside the node
	
end

minetest.register_entity("christmas_craft:snowball_entity", snow_snowball_ENTITY)

--Snowball.
minetest.register_craftitem("christmas_craft:snowball", {
	Description = "Snowball",
	inventory_image = "snowball.png",
	on_use = snow_shoot_snowball,
})

--Snow.
minetest.register_node("christmas_craft:snow", {
	tiles = {"snow.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = "light",
	param2 = nil,
	--param2 is reserved for what vegetation is hiding inside.
	--mapgen defines the vegetation.
	--1 = Moss
	groups = {crumbly=3,melts=1,falling_node=1},
	buildable_to = true,
	drop = 'christmas_craft:snowball',
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.35, 0.5}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.35, 0.5}
		},
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.45},
	}),
})



