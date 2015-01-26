-----------------------------------------------------------------------------------------------
-- Ferns - Fern 0.1.0
-----------------------------------------------------------------------------------------------
-- by Mossmanikin
-- License (everything): 	WTFPL
-- Contains code from: 		plants_lib
-- Looked at code from:		default, flowers, painting, trees
-- Dependencies: 			plants_lib
-- Supports:				dryplants, stoneage, sumpf		
-----------------------------------------------------------------------------------------------
-- some inspiration from here
-- https://en.wikipedia.org/wiki/Athyrium_yokoscense
-- http://www.mygarden.net.au/gardening/athyrium-yokoscense/3900/1
-----------------------------------------------------------------------------------------------

assert(abstract_ferns.config.enable_lady_fern == true)

-- Maintain backward compatibilty
minetest.register_alias("archaeplantae:fern",		"ferns:fern_03")
minetest.register_alias("archaeplantae:fern_mid",	"ferns:fern_02")
minetest.register_alias("archaeplantae:fern_small",	"ferns:fern_01")
minetest.register_alias("ferns:fern_04",      		"ferns:fern_02") -- for placing

local nodenames = {}

local function create_nodes()
	local images 	= { "ferns_fern.png", "ferns_fern_mid.png", "ferns_fern_big.png" }
	local vscales	= { 1, 2, 2.2 }
	local descs		= { "Lady-fern (Athyrium)", nil, nil }

	for i = 1, 3 do
		local node_on_place = nil
		if i == 1 then
			node_on_place = function(itemstack, placer, pointed_thing)
				-- place a random fern
				local stack = ItemStack("ferns:fern_0"..math.random(1,4))
				local ret = minetest.item_place(stack, placer, pointed_thing)
				return ItemStack("ferns:fern_01 "..itemstack:get_count()-(1-ret:get_count()))	-- TODO FIXME?
			end
		end
		nodenames[i] = "ferns:fern_"..string.format("%02d", i)
		minetest.register_node(nodenames[i], {
			description = descs[i] or ("Lady-fern (Athyrium) " .. string.format("%02d", i)),
			inventory_image = "ferns_fern.png",
			drawtype = "plantlike",
			visual_scale = vscales[i],
			paramtype = "light",
			tiles = { images[i] },
			walkable = false,
			buildable_to = true,
			groups = {snappy=3,flammable=2,attached_node=1,not_in_creative_inventory=1},
			sounds = default.node_sound_leaves_defaults(),
			selection_box = {
				type = "fixed",
				fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
			},
			drop = "ferns:fern_01",
			on_place = node_on_place
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

if abstract_ferns.config.lady_ferns_near_tree == true then
	plantslib:register_generate_plant({ -- near trees (woodlands)
		surface = {
			"default:dirt_with_grass",
			"default:mossycobble",
			"default:desert_sand",
			"default:sand",
			"default:jungletree",
			"stoneage:grass_with_silex",
			"sumpf:sumpf"
		},
		max_count = 30,
		rarity = 62,--63,
		min_elevation = 1, -- above sea level
		near_nodes = {"group:tree"},
		near_nodes_size = 3,--4,
		near_nodes_vertical = 2,--3,
		near_nodes_count = 1,
		plantlife_limit = -0.9,
		humidity_max = -1.0,
		humidity_min = 0.4,
		temp_max = -0.5, -- 55 °C (too hot?)
		temp_min = 0.75, -- -12 °C
		random_facedir = { 0, 179 },
	},
	nodenames
	)
end

if abstract_ferns.config.lady_ferns_near_rock == true then
	plantslib:register_generate_plant({ -- near stone (mountains)
		surface = {
			"default:dirt_with_grass",
			"default:mossycobble",
			"group:falling_node",
			--"default:jungletree",
			"stoneage:grass_with_silex",
			"sumpf:sumpf"
		},
		max_count = 35,
		rarity = 40,
		min_elevation = 1, -- above sea level
		near_nodes = {"group:stone"},
		near_nodes_size = 1,
		near_nodes_count = 16,
		plantlife_limit = -0.9,
		humidity_max = -1.0,
		humidity_min = 0.4,
		temp_max = -0.5, -- 55 °C (too hot?)
		temp_min = 0.75, -- -12 °C
		random_facedir = { 0, 179 },
	},
	nodenames
	)
end

if abstract_ferns.config.lady_ferns_near_ores == true then -- this one causes a huge fps drop
	plantslib:register_generate_plant({ -- near ores (potential mining sites)
		surface = {
			"default:dirt_with_grass",
			"default:mossycobble",
			"default:stone_with_coal",
			"default:stone_with_iron",
			"moreores:mineral_tin",
			"moreores:mineral_silver",
			"sumpf:sumpf"
		},
		max_count = 1200,--1600, -- maybe too much? :D
		rarity = 25,--15,
		min_elevation = 1, -- above sea level
		near_nodes = {
			"default:stone_with_iron",
			--"default:stone_with_copper",
			--"default:stone_with_mese",
			--"default:stone_with_gold",
			--"default:stone_with_diamond",
			"moreores:mineral_tin",
			"moreores:mineral_silver"
			--"moreores:mineral_mithril"
		},
		near_nodes_size = 2,
		near_nodes_vertical = 4,--5,--6,
		near_nodes_count = 2,--3,
		plantlife_limit = -0.9,
		humidity_max = -1.0,
		humidity_min = 0.4,
		temp_max = -0.5, -- 55 °C (too hot?)
		temp_min = 0.75, -- -12 °C
		random_facedir = { 0, 179 },
	},
	nodenames
	)
end

if abstract_ferns.config.lady_ferns_in_groups == true then -- this one is meant as a replacement of Ferns_near_Ores
	plantslib:register_generate_plant({
		surface = {
			"default:dirt_with_grass",
			"default:mossycobble",
			"default:stone_with_coal",
			"default:stone_with_iron",
			"moreores:mineral_tin",
			"moreores:mineral_silver",
			"sumpf:sumpf"
		},
		max_count = 70,
		rarity = 25,--15,
		min_elevation = 1, -- above sea level
		near_nodes = {
			"default:stone"
		},
		near_nodes_size = 2,
		near_nodes_vertical = 2,--6,
		near_nodes_count = 3,
		plantlife_limit = -0.9,
		humidity_max = -1.0,
		humidity_min = 0.4,
		temp_max = -0.5, -- 55 °C (too hot?)
		temp_min = 0.75, -- -12 °C
		random_facedir = { 0, 179 },
	},
	nodenames
	)
end
