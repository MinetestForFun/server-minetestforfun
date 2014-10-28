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
minetest.register_node("molehills:molehill",{
	drawtype = "nodebox",
	description = "Mole Hill",
	inventory_image = "molehills_side.png",
    tiles = {
		"molehills_dirt.png",--"molehill_top.png",
		"molehills_dirt.png",--"molehill_top.png",
		"molehills_dirt.png"--"molehill_side.png"
	},
    paramtype = "light",
    node_box = {
        type = "fixed",
        fixed = {
--			{ left, bottom, front, right, top,   back}
			{-2/16, -3/16, -1/16,  2/16, -2/16,  1/16},
			{-1/16, -3/16, -2/16,  1/16, -2/16,  2/16},
--			{ left, bottom, front, right, top,   back}
			{-4/16, -4/16, -2/16,  4/16, -3/16,  2/16},
			{-2/16, -4/16, -4/16,  2/16, -3/16,  4/16},
			{-3/16, -4/16, -3/16,  3/16, -3/16,  3/16},
--			{ left, bottom, front, right, top,   back}
			{-5/16, -5/16, -2/16,  5/16, -4/16,  2/16},
			{-2/16, -5/16, -5/16,  2/16, -4/16,  5/16},
			{-4/16, -5/16, -4/16,  4/16, -4/16,  4/16},
--			{ left, bottom, front, right, top,   back}
			{-6/16, -6/16, -2/16,  6/16, -5/16,  2/16},
			{-2/16, -6/16, -6/16,  2/16, -5/16,  6/16},
			{-5/16, -6/16, -4/16,  5/16, -5/16,  4/16},
			{-4/16, -6/16, -5/16,  4/16, -5/16,  5/16},
--			{ left, bottom, front, right, top,   back}
			{-7/16, -7/16, -3/16,  7/16, -6/16,  3/16},
			{-3/16, -7/16, -7/16,  3/16, -6/16,  7/16},
			{-6/16, -7/16, -4/16,  6/16, -6/16,  4/16},
			{-4/16, -7/16, -6/16,  4/16, -6/16,  6/16},
			{-5/16, -7/16, -5/16,  5/16, -6/16,  5/16},
--			{ left, bottom, front, right, top,   back}
--[[b]]		{-1/2 , -1/2 , -3/16,  1/2 , -7/16,  3/16}, -- left to right
--[[o]]		{-3/16, -1/2 , -1/2 ,  3/16, -7/16,  1/2 }, -- front to back
--[[t]]		{-7/16, -1/2 , -5/16,  7/16, -7/16,  5/16},
--[[t]]		{-5/16, -1/2 , -7/16,  5/16, -7/16,  7/16},
--[[m]]		{-6/16, -1/2 , -6/16,  6/16, -7/16,  6/16}, -- mid
        },
    },
    selection_box = {
        type = "fixed",
        fixed = {-1/2, -1/2, -1/2, 1/2, 2/16, 1/2},
    },
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

plantslib:register_generate_plant({
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

-----------------------------------------------------------------------------------------------
print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
-----------------------------------------------------------------------------------------------
