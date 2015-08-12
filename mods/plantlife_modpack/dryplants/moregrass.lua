-----------------------------------------------------------------------------------------------
-- Grasses - More Tall Grass 0.0.2
-----------------------------------------------------------------------------------------------
-- by Mossmanikin

-- License (everything): 	WTFPL
-- Contains code from: 		biome_lib
-- Looked at code from:		default				
-----------------------------------------------------------------------------------------------

abstract_dryplants.grow_grass = function(pos)
	local right_here = {x=pos.x, y=pos.y+1, z=pos.z}
	local grass_size = math.random(1,5)
	if minetest.get_node(right_here).name == "air"  -- instead of check_air = true,
	or minetest.get_node(right_here).name == "default:junglegrass" then
		minetest.set_node(right_here, {name="default:grass_"..grass_size})
	end
end

biome_lib:register_generate_plant({
    surface = {
		"default:dirt_with_grass",
		"stoneage:grass_with_silex",
		"sumpf:peat",
		"sumpf:sumpf"
	},
    max_count = TALL_GRASS_PER_MAPBLOCK,
    rarity = 101 - TALL_GRASS_RARITY,
    min_elevation = 1, -- above sea level
	plantlife_limit = -0.9,
  },
  abstract_dryplants.grow_grass
)
