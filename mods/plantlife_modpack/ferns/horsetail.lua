-----------------------------------------------------------------------------------------------
-- Archae Plantae - Horsetail 0.0.5
-----------------------------------------------------------------------------------------------
-- by Mossmanikin
-- License (everything): 	WTFPL
-- Contains code from: 		plants_lib
-- Looked at code from:		default, flowers, trees
-- Dependencies: 			plants_lib
-- Supports:				dryplants, stoneage, sumpf			
-----------------------------------------------------------------------------------------------

assert(abstract_ferns.config.enable_horsetails == true)

-----------------------------------------------------------------------------------------------
-- HORSETAIL  (EQUISETUM)
-----------------------------------------------------------------------------------------------

local node_names = {}

local function create_nodes()
	local selection_boxes = {
		{ -0.15, -1/2, -0.15, 0.15, -1/16, 0.15 },
		{ -0.15, -1/2, -0.15, 0.15, 1/16, 0.15 },
		{ -0.15, -1/2, -0.15, 0.15, 4/16, 0.15 },
		{ -0.15, -1/2, -0.15, 0.15, 7/16, 0.15 },
	}

	for i = 1, 4 do
		local node_name = "ferns:horsetail_" .. string.format("%02d", i)
		local node_img = "ferns_horsetail_" .. string.format("%02d", i) .. ".png"
		local node_desc
		local node_on_use = nil
		local node_drop = "ferns:horsetail_04"

		if i == 1 then
			node_desc = "Young Horsetail (Equisetum)"
			node_on_use = minetest.item_eat(1) -- young ones edible https://en.wikipedia.org/wiki/Equisetum
			node_drop = node_name
		elseif i == 4 then
			node_desc = "Horsetail (Equisetum)"
		else
			node_desc = "Horsetail (Equisetum) ".. string.format("%02d", i)
		end

		node_names[i] = node_name

		minetest.register_node(node_name, {
			description = node_desc,
			drawtype = "plantlike",
			paramtype = "light",
			tiles = { node_img },
			inventory_image = node_img,
			walkable = false,
			buildable_to = true,
			groups = {snappy=3,flammable=2,attached_node=1,horsetail=1},
			sounds = default.node_sound_leaves_defaults(),
			selection_box = {
				type = "fixed",
				fixed = selection_boxes[i],
			},
			on_use = node_on_use,
			drop = node_drop,
		})
	end
end

-----------------------------------------------------------------------------------------------
-- Init
-----------------------------------------------------------------------------------------------

create_nodes()

-----------------------------------------------------------------------------------------------
-- Spawning
-----------------------------------------------------------------------------------------------
if abstract_ferns.config.enable_horsetails_spawning == true then
	plantslib:spawn_on_surfaces({
		spawn_delay = 1200,
		spawn_plants = node_names,
		spawn_chance = 400,
		spawn_surfaces = {
			"default:dirt_with_grass",
			"default:desert_sand",
			"default:sand",
			"dryplants:grass_short",
			"stoneage:grass_with_silex",
			"default:mossycobble",
			"default:gravel"
		},
		seed_diff = 329,
		min_elevation = 1, -- above sea level
		near_nodes = {"default:water_source","default:gravel"},
		near_nodes_size = 2,
		near_nodes_vertical = 1,
		near_nodes_count = 1,
		--random_facedir = { 0, 179 },
	})
end

-----------------------------------------------------------------------------------------------
-- Generating
-----------------------------------------------------------------------------------------------

if abstract_ferns.config.enable_horsetails_on_grass == true then
	plantslib:register_generate_plant({
		surface = {
			"default:dirt_with_grass",
			"sumpf:sumpf"
		},
		max_count = 35,
		rarity = 40,
		min_elevation = 1, -- above sea level
		near_nodes = {
			"group:water", -- likes water (of course)
			"default:gravel", -- near those on gravel
			"default:sand", -- some like sand
			"default:clay", -- some like clay
			"stoneage:grass_with_silex",
			"default:mossycobble",
			"default:cobble",
			"sumpf:sumpf"
		},
		near_nodes_size = 3,
		near_nodes_vertical = 2,--3,
		near_nodes_count = 1,
		plantlife_limit = -0.9,
		humidity_min = 0.4,
		temp_max = -0.5, -- 55 °C
		temp_min = 0.53, -- 0 °C, dies back in winter
		--random_facedir = { 0, 179 },
	},
	node_names
	)
end

if abstract_ferns.config.enable_horsetails_on_stones == true then
	plantslib:register_generate_plant({
		surface = {
			"default:gravel", -- roots go deep
			"default:mossycobble",
			"stoneage:dirt_with_silex",
			"stoneage:grass_with_silex",
			"stoneage:sand_with_silex", -- roots go deep
		},
		max_count = 35,
		rarity = 20,
		min_elevation = 1, -- above sea level
		plantlife_limit = -0.9,
		humidity_min = 0.4,
		temp_max = -0.5, -- 55 °C
		temp_min = 0.53, -- 0 °C, dies back in winter
		--random_facedir = { 0, 179 },
	},
	node_names
	)
end
