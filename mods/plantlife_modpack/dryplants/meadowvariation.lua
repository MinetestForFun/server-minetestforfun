-----------------------------------------------------------------------------------------------
-- Grasses - Meadow Variation 0.0.1
-----------------------------------------------------------------------------------------------
-- by Mossmanikin

-- License (everything): 	WTFPL
-- Contains code from: 		plants_lib
-- Looked at code from:		default				
-----------------------------------------------------------------------------------------------

abstract_dryplants.grow_grass_variation = function(pos)
	local right_here = {x=pos.x, y=pos.y, z=pos.z}
	minetest.set_node(right_here, {name="dryplants:grass_short"})
end

plantslib:register_generate_plant({
    surface = {
		"default:dirt_with_grass",
	},
    max_count = 4800,
    rarity = 25,
    min_elevation = 1, -- above sea level
	plantlife_limit = -0.9,
  },
  abstract_dryplants.grow_grass_variation
)
