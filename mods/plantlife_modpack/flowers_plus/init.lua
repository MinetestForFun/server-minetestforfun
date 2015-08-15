local S = biome_lib.intllib

-- This file supplies a few additional plants and some related crafts
-- for the plantlife modpack.  Last revision:  2013-04-24

flowers_plus = {}

local SPAWN_DELAY = 1000
local SPAWN_CHANCE = 200
local flowers_seed_diff = 329
local lilies_max_count = 320
local lilies_rarity = 33
local seaweed_max_count = 320
local seaweed_rarity = 33
local sunflowers_max_count = 10
local sunflowers_rarity = 25

-- register the various rotations of waterlilies

local lilies_list = {
	{ nil  , nil 	   , 1	},
	{ "225", "22.5"    , 2	},
	{ "45" , "45"      , 3	},
	{ "675", "67.5"    , 4	},
	{ "s1" , "small_1" , 5	},
	{ "s2" , "small_2" , 6	},
	{ "s3" , "small_3" , 7	},
	{ "s4" , "small_4" , 8	},
}

for i in ipairs(lilies_list) do
	local deg1 = ""
	local deg2 = ""
	local lily_groups = {snappy = 3,flammable=2,flower=1}

	if lilies_list[i][1] ~= nil then
		deg1 = "_"..lilies_list[i][1]
		deg2 = "_"..lilies_list[i][2]
		lily_groups = { snappy = 3,flammable=2,flower=1, not_in_creative_inventory=1 }
	end

	minetest.register_node(":flowers:waterlily"..deg1, {
		description = S("Waterlily"),
		drawtype = "nodebox",
		tiles = {
			"flowers_waterlily"..deg2..".png",
			"flowers_waterlily"..deg2..".png^[transformFY"
		},
		inventory_image = "flowers_waterlily.png",
		wield_image  = "flowers_waterlily.png",
		sunlight_propagates = true,
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = false,
		groups = lily_groups,
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = { -0.4, -0.5, -0.4, 0.4, -0.45, 0.4 },
		},
		node_box = {
			type = "fixed",
			fixed = { -0.5, -0.49, -0.5, 0.5, -0.49, 0.5 },
		},
		buildable_to = true,

		liquids_pointable = true,
		drop = "flowers:waterlily",
		on_place = function(itemstack, placer, pointed_thing)
			local keys=placer:get_player_control()
			local pt = pointed_thing

			local place_pos = nil
			local top_pos = {x=pt.under.x, y=pt.under.y+1, z=pt.under.z}
			local under_node = minetest.get_node(pt.under)
			local above_node = minetest.get_node(pt.above)
			local top_node   = minetest.get_node(top_pos)

			if biome_lib:get_nodedef_field(under_node.name, "buildable_to") then
				if under_node.name ~= "default:water_source" then
					place_pos = pt.under
				elseif top_node.name ~= "default:water_source"
				       and biome_lib:get_nodedef_field(top_node.name, "buildable_to") then
					place_pos = top_pos
				else
					return
				end
			elseif biome_lib:get_nodedef_field(above_node.name, "buildable_to") then
				place_pos = pt.above
			end

			if place_pos and not minetest.is_protected(place_pos, placer:get_player_name()) then

			local nodename = "default:cobble" -- if this block appears, something went....wrong :-)

				if not keys["sneak"] then
					local node = minetest.get_node(pt.under)
					local waterlily = math.random(1,8)
					if waterlily == 1 then
						nodename = "flowers:waterlily"
					elseif waterlily == 2 then
						nodename = "flowers:waterlily_225"
					elseif waterlily == 3 then
						nodename = "flowers:waterlily_45"
					elseif waterlily == 4 then
						nodename = "flowers:waterlily_675"
					elseif waterlily == 5 then
						nodename = "flowers:waterlily_s1"
					elseif waterlily == 6 then
						nodename = "flowers:waterlily_s2"
					elseif waterlily == 7 then
						nodename = "flowers:waterlily_s3"
					elseif waterlily == 8 then
						nodename = "flowers:waterlily_s4"
					end
					minetest.set_node(place_pos, {name = nodename, param2 = math.random(0,3) })
				else
					local fdir = minetest.dir_to_facedir(placer:get_look_dir())
					minetest.set_node(place_pos, {name = "flowers:waterlily", param2 = fdir})
				end

				if not biome_lib.expect_infinite_stacks then
					itemstack:take_item()
				end
				return itemstack
			end
		end,
	})
end

local algae_list = { {nil}, {2}, {3}, {4} }

for i in ipairs(algae_list) do
	local num = ""
	local algae_groups = {snappy = 3,flammable=2,flower=1}

	if algae_list[i][1] ~= nil then
		num = "_"..algae_list[i][1]
		algae_groups = { snappy = 3,flammable=2,flower=1, not_in_creative_inventory=1 }
	end

	minetest.register_node(":flowers:seaweed"..num, {
		description = S("Seaweed"),
		drawtype = "nodebox",
		tiles = {
			"flowers_seaweed"..num..".png",
			"flowers_seaweed"..num..".png^[transformFY"
		},
		inventory_image = "flowers_seaweed_2.png",
		wield_image  = "flowers_seaweed_2.png",
		sunlight_propagates = true,
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = false,
		groups = algae_groups,
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = { -0.4, -0.5, -0.4, 0.4, -0.45, 0.4 },
		},
		node_box = {
			type = "fixed",
			fixed = { -0.5, -0.49, -0.5, 0.5, -0.49, 0.5 },
		},
		buildable_to = true,

		liquids_pointable = true,
		drop = "flowers:seaweed",
		on_place = function(itemstack, placer, pointed_thing)
			local keys=placer:get_player_control()
			local pt = pointed_thing

			local place_pos = nil
			local top_pos = {x=pt.under.x, y=pt.under.y+1, z=pt.under.z}
			local under_node = minetest.get_node(pt.under)
			local above_node = minetest.get_node(pt.above)
			local top_node   = minetest.get_node(top_pos)

			if biome_lib:get_nodedef_field(under_node.name, "buildable_to") then
				if under_node.name ~= "default:water_source" then
					place_pos = pt.under
				elseif top_node.name ~= "default:water_source"
				       and biome_lib:get_nodedef_field(top_node.name, "buildable_to") then
					place_pos = top_pos
				else
					return
				end
			elseif biome_lib:get_nodedef_field(above_node.name, "buildable_to") then
				place_pos = pt.above
			end

			if not minetest.is_protected(place_pos, placer:get_player_name()) then

			local nodename = "default:cobble" -- :D

				if not keys["sneak"] then
					--local node = minetest.get_node(pt.under)
					local seaweed = math.random(1,4)
					if seaweed == 1 then
						nodename = "flowers:seaweed"
					elseif seaweed == 2 then
						nodename = "flowers:seaweed_2"
					elseif seaweed == 3 then
						nodename = "flowers:seaweed_3"
					elseif seaweed == 4 then
						nodename = "flowers:seaweed_4"
					end
					minetest.set_node(place_pos, {name = nodename, param2 = math.random(0,3) })
				else
					local fdir = minetest.dir_to_facedir(placer:get_look_dir())
					minetest.set_node(place_pos, {name = "flowers:seaweed", param2 = fdir})
				end

				if not biome_lib.expect_infinite_stacks then
					itemstack:take_item()
				end
				return itemstack
			end
		end,
	})
end

local box = {
	type="fixed",
	fixed = { { -0.2, -0.5, -0.2, 0.2, 0.5, 0.2 } },
}

local sunflower_drop = "farming:seed_wheat"
if minetest.registered_items["farming:seed_spelt"] then
	sunflower_drop = "farming:seed_spelt"
end

minetest.register_node(":flowers:sunflower", {
	description = "Sunflower",
	drawtype = "mesh",
	paramtype = "light",
	paramtype2 = "facedir",
	inventory_image = "flowers_sunflower_inv.png",
	mesh = "flowers_sunflower.obj",
	tiles = { "flowers_sunflower.png" },
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = { dig_immediate=3, flora=1, flammable=3 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = box,
	collision_box = box,
	drop = {
		max_items = 1,
		items = {
			{items = {sunflower_drop}, rarity = 8},
			{items = {"flowers:sunflower"}},
		}
	}
})

local extra_aliases = {
	"waterlily",
	"waterlily_225",
	"waterlily_45",
	"waterlily_675",
	"seaweed"
}

for i in ipairs(extra_aliases) do
	local flower = extra_aliases[i]
	minetest.register_alias("flowers:flower_"..flower, "flowers:"..flower)
end

minetest.register_alias( "trunks:lilypad"         ,	"flowers:waterlily_s1" )
minetest.register_alias( "along_shore:lilypads_1" , "flowers:waterlily_s1" )
minetest.register_alias( "along_shore:lilypads_2" , "flowers:waterlily_s2" )
minetest.register_alias( "along_shore:lilypads_3" , "flowers:waterlily_s3" )
minetest.register_alias( "along_shore:lilypads_4" , "flowers:waterlily_s4" )
minetest.register_alias( "along_shore:pondscum_1" ,	"flowers:seaweed"      )
minetest.register_alias( "along_shore:seaweed_1"  ,	"flowers:seaweed"      )
minetest.register_alias( "along_shore:seaweed_2"  ,	"flowers:seaweed_2"    )
minetest.register_alias( "along_shore:seaweed_3"  ,	"flowers:seaweed_3"    )
minetest.register_alias( "along_shore:seaweed_4"  ,	"flowers:seaweed_4"    )

-- ongen registrations

flowers_plus.grow_waterlily = function(pos)
	local right_here = {x=pos.x, y=pos.y+1, z=pos.z}
	for i in ipairs(lilies_list) do
		local chance = math.random(1,8)
		local ext = ""
		local num = lilies_list[i][3]

		if lilies_list[i][1] ~= nil then
			ext = "_"..lilies_list[i][1]
		end

		if chance == num then
			minetest.set_node(right_here, {name="flowers:waterlily"..ext, param2=math.random(0,3)})
		end
	end
end

biome_lib:register_generate_plant({
    surface = {"default:water_source"},
    max_count = lilies_max_count,
    rarity = lilies_rarity,
    min_elevation = 1,
	max_elevation = 40,
	near_nodes = {"default:dirt_with_grass"},
	near_nodes_size = 4,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
	temp_max = -0.22,
    temp_min = 0.22,
  },
  flowers_plus.grow_waterlily
)

flowers_plus.grow_seaweed = function(pos)
	local right_here = {x=pos.x, y=pos.y+1, z=pos.z}
	minetest.set_node(right_here, {name="along_shore:seaweed_"..math.random(1,4), param2=math.random(1,3)})
end

biome_lib:register_generate_plant({
    surface = {"default:water_source"},
    max_count = seaweed_max_count,
    rarity = seaweed_rarity,
    min_elevation = 1,
	max_elevation = 40,
	near_nodes = {"default:dirt_with_grass"},
	near_nodes_size = 4,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  flowers_plus.grow_seaweed
)

-- seaweed at beaches
-- MM: not satisfied with it, but IMHO some beaches should have some algae
biome_lib:register_generate_plant({
    surface = {"default:water_source"},
    max_count = seaweed_max_count,
    rarity = seaweed_rarity,
    min_elevation = 1,
	max_elevation = 40,
	near_nodes = {"default:sand"},
	near_nodes_size = 1,
	near_nodes_vertical = 0,
	near_nodes_count = 3,
    plantlife_limit = -0.9,
	temp_max = -0.64, -- MM: more or less random values, just to make sure it's not everywhere
    temp_min = -0.22, -- MM: more or less random values, just to make sure it's not everywhere
  },
  flowers_plus.grow_seaweed
)
biome_lib:register_generate_plant({
    surface = {"default:sand"},
    max_count = seaweed_max_count*2,
    rarity = seaweed_rarity/2,
    min_elevation = 1,
	max_elevation = 40,
	near_nodes = {"default:water_source"},
	near_nodes_size = 1,
	near_nodes_vertical = 0,
	near_nodes_count = 3,
    plantlife_limit = -0.9,
	temp_max = -0.64, -- MM: more or less random values, just to make sure it's not everywhere
    temp_min = -0.22, -- MM: more or less random values, just to make sure it's not everywhere
  },
  flowers_plus.grow_seaweed
)

biome_lib:register_generate_plant({
	surface = {"default:dirt_with_grass"},
	avoid_nodes = { "flowers:sunflower" },
	max_count = sunflowers_max_count,
	rarity = sunflowers_rarity,
	min_elevation = 0,
	plantlife_limit = -0.9,
	temp_max = 0.53,
	random_facedir = {0,3},
  },
  "flowers:sunflower"
)

-- spawn ABM registrations

biome_lib:spawn_on_surfaces({
	spawn_delay = SPAWN_DELAY/2,
	spawn_plants = {
		"flowers:waterlily",
		"flowers:waterlily_225",
		"flowers:waterlily_45",
		"flowers:waterlily_675",
		"flowers:waterlily_s1",
		"flowers:waterlily_s2",
		"flowers:waterlily_s3",
		"flowers:waterlily_s4"
	},
	avoid_radius = 2.5,
	spawn_chance = SPAWN_CHANCE*4,
	spawn_surfaces = {"default:water_source"},
	avoid_nodes = {"group:flower", "group:flora" },
	seed_diff = flowers_seed_diff,
	light_min = 9,
	depth_max = 2,
	random_facedir = {0,3}
})

biome_lib:spawn_on_surfaces({
	spawn_delay = SPAWN_DELAY*2,
	spawn_plants = {"flowers:seaweed"},
	spawn_chance = SPAWN_CHANCE*2,
	spawn_surfaces = {"default:water_source"},
	avoid_nodes = {"group:flower", "group:flora"},
	seed_diff = flowers_seed_diff,
	light_min = 4,
	light_max = 10,
	neighbors = {"default:dirt_with_grass"},
	facedir = 1
})

biome_lib:spawn_on_surfaces({
	spawn_delay = SPAWN_DELAY*2,
	spawn_plants = {"flowers:seaweed"},
	spawn_chance = SPAWN_CHANCE*2,
	spawn_surfaces = {"default:dirt_with_grass"},
	avoid_nodes = {"group:flower", "group:flora" },
	seed_diff = flowers_seed_diff,
	light_min = 4,
	light_max = 10,
	neighbors = {"default:water_source"},
	ncount = 1,
	facedir = 1
})

biome_lib:spawn_on_surfaces({
	spawn_delay = SPAWN_DELAY*2,
	spawn_plants = {"flowers:seaweed"},
	spawn_chance = SPAWN_CHANCE*2,
	spawn_surfaces = {"default:stone"},
	avoid_nodes = {"group:flower", "group:flora" },
	seed_diff = flowers_seed_diff,
	light_min = 4,
	light_max = 10,
	neighbors = {"default:water_source"},
	ncount = 6,
	facedir = 1
})

biome_lib:spawn_on_surfaces({
	spawn_delay = SPAWN_DELAY*2,
	spawn_plants = {"flowers:sunflower"},
	spawn_chance = SPAWN_CHANCE*2,
	spawn_surfaces = {"default:dirt_with_grass"},
	avoid_nodes = {"group:flower", "flowers:sunflower"},
	seed_diff = flowers_seed_diff,
	light_min = 11,
	light_max = 14,
	min_elevation = 0,
	plantlife_limit = -0.9,
	temp_max = 0.53,
	random_facedir = {0,3},
	avoid_radius = 5
})

-- Cotton plants are now provided by the default "farming" mod.
-- old cotton plants -> farming cotton stage 8
-- cotton wads -> string (can be crafted into wool blocks)
-- potted cotton plants -> potted white dandelions

minetest.register_alias("flowers:cotton_plant", "farming:cotton_8")
minetest.register_alias("flowers:flower_cotton", "farming:cotton_8")
minetest.register_alias("flowers:flower_cotton_pot", "flowers:potted_dandelion_white")
minetest.register_alias("flowers:potted_cotton_plant", "flowers:potted_dandelion_white")
minetest.register_alias("flowers:cotton", "farming:string")
minetest.register_alias("flowers:cotton_wad", "farming:string")
minetest.register_alias("sunflower:sunflower", "flowers:sunflower")

minetest.log("action", S("[Flowers] Loaded."))
