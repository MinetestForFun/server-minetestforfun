-----------------------------------------------------------------------------------------------
-- Grasses - Juncus 0.0.5
-----------------------------------------------------------------------------------------------
-- by Mossmanikin
-- textures & ideas partly by Neuromancer

-- License (everything): 	WTFPL
-- Contains code from: 		plants_lib
-- Looked at code from:		default			
-----------------------------------------------------------------------------------------------

abstract_dryplants.grow_juncus = function(pos)
	local juncus_type = math.random(2,3)
	local right_here = {x=pos.x, y=pos.y+1, z=pos.z}
	if minetest.get_node(right_here).name == "air"  -- instead of check_air = true,
	or minetest.get_node(right_here).name == "default:junglegrass" then
		if juncus_type == 2 then
			minetest.set_node(right_here, {name="dryplants:juncus_02"})
		else
			minetest.set_node(right_here, {name="dryplants:juncus"})
		end
	end
end

minetest.register_node("dryplants:juncus", {
	description = "Juncus",
	drawtype = "plantlike",
	visual_scale = 2,
	paramtype = "light",
	tiles = {"dryplants_juncus_03.png"},
	inventory_image = "dryplants_juncus_inv.png",
	walkable = false,
	buildable_to = true,
	groups = {
		snappy=3,
		flammable=2,
		attached_node=1,
		flora=1
		--not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.under
		local juncus_type = math.random(2,3)
		local right_here = {x=pos.x, y=pos.y+1, z=pos.z}
		if juncus_type == 2 then
			minetest.set_node(right_here, {name="dryplants:juncus_02"})
		else
			minetest.set_node(right_here, {name="dryplants:juncus"})
		end
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end,
})
minetest.register_node("dryplants:juncus_02", {
	description = "Juncus",
	drawtype = "plantlike",
	visual_scale = 2,
	paramtype = "light",
	tiles = {"dryplants_juncus_02.png"},
	walkable = false,
	buildable_to = true,
	groups = {
		snappy=3,
		flammable=2,
		attached_node=1,
		flora=1,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
	drop = "dryplants:juncus",
})
-----------------------------------------------------------------------------------------------
-- GENERATE SMALL JUNCUS
-----------------------------------------------------------------------------------------------
-- near water or swamp
plantslib:register_generate_plant({
    surface = {
		"default:dirt_with_grass", 
		--"default:desert_sand",
		--"default:sand",
		"stoneage:grass_with_silex",
		"sumpf:peat",
		"sumpf:sumpf"
	},
    max_count = JUNCUS_NEAR_WATER_PER_MAPBLOCK,
    rarity = 101 - JUNCUS_NEAR_WATER_RARITY,
    min_elevation = 1, -- above sea level
	near_nodes = {"default:water_source","sumpf:dirtywater_source","sumpf:sumpf"},
	near_nodes_size = 2,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_dryplants.grow_juncus
)
-- at dunes/beach
plantslib:register_generate_plant({
    surface = {
		--"default:dirt_with_grass", 
		--"default:desert_sand",
		"default:sand",
		--"stoneage:grass_with_silex",
		--"sumpf:peat",
		--"sumpf:sumpf"
	},
    max_count = JUNCUS_AT_BEACH_PER_MAPBLOCK,
    rarity = 101 - JUNCUS_AT_BEACH_RARITY,
    min_elevation = 1, -- above sea level
	near_nodes = {"default:dirt_with_grass"},
	near_nodes_size = 2,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_dryplants.grow_juncus
)
