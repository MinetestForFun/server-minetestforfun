-----------------------------------------------------------------------------------------------
local title		= "Mole Hills"
local version 	= "0.0.3"
local mname		= "molehills"
-----------------------------------------------------------------------------------------------
-- Idea by Sokomine
-- Code & textures by Mossmanikin

abstract_molehills = {}

dofile(minetest.get_modpath("molehills").."/molehills_settings.txt")

-----------------------------------------------------------------------------------------------
-- NoDe
-----------------------------------------------------------------------------------------------

local mh_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.5, 0.5, -0.125, 0.5}
}

minetest.register_node("molehills:molehill",{
	drawtype = "mesh",
	mesh = "molehill_molehill.obj",
	description = "Mole Hill",
	inventory_image = "molehills_side.png",
	tiles = { "molehills_dirt.png" },
	paramtype = "light",
	selection_box = mh_cbox,
	collision_box = mh_cbox,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
})

-----------------------------------------------------------------------------------------------
-- CRaFTiNG
-----------------------------------------------------------------------------------------------
minetest.register_craft({ -- molehills --> dirt
	output = "default:dirt",
	recipe = {
		{"molehills:molehill","molehills:molehill"},
		{"molehills:molehill","molehills:molehill"},
	}
})

-----------------------------------------------------------------------------------------------
-- GeNeRaTiNG
-----------------------------------------------------------------------------------------------
abstract_molehills.place_molehill = function(pos)
	local right_here 	= {x=pos.x  , y=pos.y+1, z=pos.z  }
	if  minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z  }).name ~= "air"
	and minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z  }).name ~= "air"
	and minetest.get_node({x=pos.x  , y=pos.y, z=pos.z+1}).name ~= "air"
	and minetest.get_node({x=pos.x  , y=pos.y, z=pos.z-1}).name ~= "air"
	and minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z+1}).name ~= "air"
	and minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z-1}).name ~= "air"
	and minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z+1}).name ~= "air"
	and minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z-1}).name ~= "air" then
		minetest.set_node(right_here, {name="molehills:molehill"})
	end
end

biome_lib:register_generate_plant({
    surface = {"default:dirt_with_grass"},
    max_count = Molehills_Max_Count,
    rarity = Molehills_Rarity,
    min_elevation = 1,
	max_elevation = 40,
	avoid_nodes = {"group:tree","group:liquid","group:stone","group:falling_node"--[[,"air"]]},
	avoid_radius = 4,
    plantlife_limit = -0.3,
  },
  abstract_molehills.place_molehill
)

biome_lib:register_generate_plant({
    surface = {"default:dirt_with_dry_grass"},
    max_count = Molehills_Max_Count,
    rarity = 97,
    min_elevation = 1,
	max_elevation = 40,
	avoid_nodes = {"group:tree","group:liquid","group:stone","group:falling_node"--[[,"air"]]},
	avoid_radius = 4,
    plantlife_limit = -0.3,
  },
  abstract_molehills.place_molehill
)

-----------------------------------------------------------------------------------------------
minetest.log("action", "[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
-----------------------------------------------------------------------------------------------
