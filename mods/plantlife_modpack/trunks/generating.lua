-- Code by Mossmanikin, Neuromancer, and others

local function clone_node(name)
	local node2 = {}
	local node = minetest.registered_nodes[name]
	for k,v in pairs(node) do
		node2[k]=v
	end
	return node2
end

-----------------------------------------------------------------------------------------------
-- TWiGS
-----------------------------------------------------------------------------------------------

abstract_trunks.place_twig = function(pos)
	local twig_size 	= math.random(1,27)
	
	local right_here 	= {x=pos.x  , y=pos.y+1, z=pos.z  }
	local north 		= {x=pos.x  , y=pos.y+1, z=pos.z+1}
	local north_east 	= {x=pos.x+1, y=pos.y+1, z=pos.z+1}
	local east 			= {x=pos.x+1, y=pos.y+1, z=pos.z  }
	local south_east 	= {x=pos.x+1, y=pos.y+1, z=pos.z-1}
	local south 		= {x=pos.x  , y=pos.y+1, z=pos.z-1}
	local south_west 	= {x=pos.x-1, y=pos.y+1, z=pos.z-1}
	local west 			= {x=pos.x-1, y=pos.y+1, z=pos.z  }
	local north_west 	= {x=pos.x-1, y=pos.y+1, z=pos.z+1}
	
	local node_here 	= minetest.get_node(right_here)
	local node_north 	= minetest.get_node(north)
	local node_n_e 		= minetest.get_node(north_east)
	local node_east 	= minetest.get_node(east)
	local node_s_e 		= minetest.get_node(south_east)
	local node_south 	= minetest.get_node(south)
	local node_s_w 		= minetest.get_node(south_west)
	local node_west 	= minetest.get_node(west)
	local node_n_w 		= minetest.get_node(north_west)
--	small twigs	
	if twig_size <= 16 then
		minetest.set_node(right_here, {name="trunks:twig_"..math.random(1,4), param2=math.random(0,3)})
	end
-- 	big twigs
	if Big_Twigs == true then
--	big twig 1		
	if twig_size == 17 then
		if not (minetest.registered_nodes[minetest.get_node({x=pos.x+1,y=pos.y,z=pos.z+1}).name].buildable_to
			or minetest.registered_nodes[minetest.get_node({x=pos.x+1,y=pos.y,z=pos.z}).name].buildable_to) then
			
			if minetest.registered_nodes[node_here.name].buildable_to then
				minetest.set_node(right_here, {name="trunks:twig_5"})
			end
			if minetest.registered_nodes[node_n_e.name].buildable_to then
				minetest.set_node(north_east, {name="trunks:twig_7"})
			end
			if minetest.registered_nodes[node_east.name].buildable_to then
				minetest.set_node(east, 	  {name="trunks:twig_8"})
			end
		end
	elseif twig_size == 18 then
		if not (minetest.registered_nodes[minetest.get_node({x=pos.x+1,y=pos.y,z=pos.z-1}).name].buildable_to
			or minetest.registered_nodes[minetest.get_node({x=pos.x,y=pos.y,z=pos.z-1}).name].buildable_to) then
			
			if minetest.registered_nodes[node_here.name].buildable_to then
				minetest.set_node(right_here, {name="trunks:twig_5", param2=1})
			end
			if minetest.registered_nodes[node_s_e.name].buildable_to then
				minetest.set_node(south_east, {name="trunks:twig_7", param2=1})
			end
			if minetest.registered_nodes[node_south.name].buildable_to then
				minetest.set_node(south, 	  {name="trunks:twig_8", param2=1})
			end
		end
	elseif twig_size == 19 then
		if not (minetest.registered_nodes[minetest.get_node({x=pos.x+1,y=pos.y,z=pos.z-1}).name].buildable_to
			or minetest.registered_nodes[minetest.get_node({x=pos.x-1,y=pos.y,z=pos.z}).name].buildable_to) then
			
			if minetest.registered_nodes[node_here.name].buildable_to then
				minetest.set_node(right_here, {name="trunks:twig_5", param2=2})
			end
			if minetest.registered_nodes[node_s_w.name].buildable_to then
				minetest.set_node(south_west, {name="trunks:twig_7", param2=2})
			end
			if minetest.registered_nodes[node_west.name].buildable_to then
				minetest.set_node(west, 	  {name="trunks:twig_8", param2=2})
			end
		end
	elseif twig_size == 20 then
		if not (minetest.registered_nodes[minetest.get_node({x=pos.x-1,y=pos.y,z=pos.z+1}).name].buildable_to
			or minetest.registered_nodes[minetest.get_node({x=pos.x,y=pos.y,z=pos.z+1}).name].buildable_to) then
			
			if minetest.registered_nodes[node_here.name].buildable_to then
				minetest.set_node(right_here, {name="trunks:twig_5", param2=3})
			end
			if minetest.registered_nodes[node_n_w.name].buildable_to then
				minetest.set_node(north_west, {name="trunks:twig_7", param2=3})
			end
			if minetest.registered_nodes[node_north.name].buildable_to then
				minetest.set_node(north, 	  {name="trunks:twig_8", param2=3})
			end
		end
--	big twig 2		
	elseif twig_size == 21 then
		if not (minetest.registered_nodes[minetest.get_node({x=pos.x,y=pos.y,z=pos.z+1}).name].buildable_to
			or minetest.registered_nodes[minetest.get_node({x=pos.x+1,y=pos.y,z=pos.z+1}).name].buildable_to) then
			
			if minetest.registered_nodes[node_here.name].buildable_to then
				minetest.set_node(right_here, {name="trunks:twig_9"})
			end
			if minetest.registered_nodes[node_north.name].buildable_to then
				minetest.set_node(north, 	  {name="trunks:twig_10"})
			end
			if minetest.registered_nodes[node_n_e.name].buildable_to then
				minetest.set_node(north_east, {name="trunks:twig_11"})
			end
		end
	elseif twig_size == 22 then
		if not (minetest.registered_nodes[minetest.get_node({x=pos.x+1,y=pos.y,z=pos.z}).name].buildable_to
			or minetest.registered_nodes[minetest.get_node({x=pos.x+1,y=pos.y,z=pos.z-1}).name].buildable_to) then
			
			if minetest.registered_nodes[node_here.name].buildable_to then
				minetest.set_node(right_here, {name="trunks:twig_9", param2=1})
			end
			if minetest.registered_nodes[node_east.name].buildable_to then
				minetest.set_node(east, 	  {name="trunks:twig_10", param2=1})
			end
			if minetest.registered_nodes[node_s_e.name].buildable_to then
				minetest.set_node(south_east, {name="trunks:twig_11", param2=1})
			end
		end
	elseif twig_size == 23 then
		if not (minetest.registered_nodes[minetest.get_node({x=pos.x,y=pos.y,z=pos.z-1}).name].buildable_to
			or minetest.registered_nodes[minetest.get_node({x=pos.x-1,y=pos.y,z=pos.z-1}).name].buildable_to) then
			
			if minetest.registered_nodes[node_here.name].buildable_to then
				minetest.set_node(right_here, {name="trunks:twig_9", param2=2})
			end
			if minetest.registered_nodes[node_south.name].buildable_to then
				minetest.set_node(south, 	  {name="trunks:twig_10", param2=2})
			end
			if minetest.registered_nodes[node_s_w.name].buildable_to then
				minetest.set_node(south_west, {name="trunks:twig_11", param2=2})
			end
		end
	elseif twig_size == 24 then
		if not (minetest.registered_nodes[minetest.get_node({x=pos.x-1,y=pos.y,z=pos.z}).name].buildable_to
			or minetest.registered_nodes[minetest.get_node({x=pos.x-1,y=pos.y,z=pos.z+1}).name].buildable_to) then
			
			if minetest.registered_nodes[node_here.name].buildable_to then
				minetest.set_node(right_here, {name="trunks:twig_9", param2=3})
			end
			if minetest.registered_nodes[node_west.name].buildable_to then
				minetest.set_node(west, 	  {name="trunks:twig_10", param2=3})
			end
			if minetest.registered_nodes[node_n_w.name].buildable_to then
				minetest.set_node(north_west, {name="trunks:twig_11", param2=3})
			end
		end
	elseif twig_size <= 25 then
		minetest.set_node(right_here, {name="trunks:twig_"..math.random(12,13), param2=math.random(0,3)})
	end
	end
end

if Twigs_on_ground == true then
plantslib:register_generate_plant({
    surface = {"default:dirt_with_grass"},
    max_count = Twigs_on_ground_Max_Count,
    rarity = Twigs_on_ground_Rarity,
    min_elevation = 1,
	max_elevation = 40,
	near_nodes = {"group:tree","ferns:fern_03","ferns:fern_02","ferns:fern_01"},
	near_nodes_size = 3,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_trunks.place_twig
)
end

if Twigs_on_water == true then
plantslib:register_generate_plant({
    surface = {"default:water_source"},
    max_count = Twigs_on_water_Max_Count,
    rarity = Twigs_on_water_Rarity,
    min_elevation = 1,
	max_elevation = 40,
	near_nodes = {"group:tree"},
	near_nodes_size = 3,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_trunks.place_twig
)
end

-----------------------------------------------------------------------------------------------
-- TRuNKS
-----------------------------------------------------------------------------------------------
local TRuNKS = {
--	  MoD 						 TRuNK						NR
    {"default",  				"tree",				 		 1},
	{"default",					"jungletree",				 2},
	
	{"trees",					"tree_conifer",		 		 3},
	{"trees",					"tree_mangrove",			 4},
	{"trees",					"tree_palm",				 5},
	
	{"moretrees",				"apple_tree_trunk",			 6},
	{"moretrees",				"beech_trunk",				 7},
	{"moretrees",				"birch_trunk",				 8},
	{"moretrees",				"fir_trunk",				 9},
	{"moretrees",				"oak_trunk",				10},
	{"moretrees",				"palm_trunk",				11},
	{"moretrees",				"pine_trunk",				12},
	{"moretrees",				"rubber_tree_trunk",		13},
	{"moretrees",				"rubber_tree_trunk_empty",	14},
	{"moretrees",				"sequoia_trunk",			15},
	{"moretrees",				"spruce_trunk",				16},
	{"moretrees",				"willow_trunk",				17},
}

if Horizontal_Trunks == true then -- see settings.txt
for i in pairs(TRuNKS) do
	local 	MoD = 	TRuNKS[i][1]
	local 	TRuNK = TRuNKS[i][2]
	local 	NR = 	TRuNKS[i][3]
	local	trunkname = MoD..":"..TRuNK
	if minetest.get_modpath(MoD) ~= nil 
	and NR < 6 -- moretrees trunks allready have facedir
	and minetest.registered_nodes[trunkname] then -- the node being called exists.
			temptrunk = clone_node(trunkname)
			temptrunk.paramtype2 = "facedir"
			minetest.register_node(":"..trunkname, temptrunk)
	end
end
end
	
abstract_trunks.place_trunk = function(pos)
	
	local right_here = {x=pos.x, y=pos.y+1, z=pos.z}
	local north = {x=pos.x, y=pos.y+1, z=pos.z+1}
	local north2 = {x=pos.x, y=pos.y+1, z=pos.z+2}
	local south = {x=pos.x, y=pos.y+1, z=pos.z-1}
	local south2 = {x=pos.x, y=pos.y+1, z=pos.z-2}
	local west = {x=pos.x-1, y=pos.y+1, z=pos.z}
	local west2 = {x=pos.x-2, y=pos.y+1, z=pos.z}
	local east = {x=pos.x+1, y=pos.y+1, z=pos.z}
	local east2 = {x=pos.x+2, y=pos.y+1, z=pos.z}
	
	local node_here = minetest.get_node(right_here)
	local node_north = minetest.get_node(north)
	local node_north2 = minetest.get_node(north2)
	local node_south = minetest.get_node(south)
	local node_south2 = minetest.get_node(south2)
	local node_west = minetest.get_node(west)
	local node_west2 = minetest.get_node(west2)
	local node_east = minetest.get_node(east)
	local node_east2 = minetest.get_node(east2)
	if minetest.registered_nodes[node_here.name].buildable_to then -- instead of check_air = true,
		for i in pairs(TRuNKS) do
			local 	MoD = 			TRuNKS[i][1]
			local 	TRuNK = 		TRuNKS[i][2]
			local 	NR = 			TRuNKS[i][3]
			local 	chance = 		math.random(1, 17)
			local 	length = 		math.random(3,5)
			if chance == NR then
				local trunk_type = math.random(1,3)
				if trunk_type == 1 then
					if minetest.get_modpath(MoD) ~= nil then
						minetest.set_node(right_here, {name=MoD..":"..TRuNK})
					else
						minetest.set_node(right_here, {name="default:tree"})
					end
				elseif trunk_type == 2 and Horizontal_Trunks == true then
					if minetest.get_modpath(MoD) ~= nil then
						if minetest.registered_nodes[node_north.name].buildable_to then
							minetest.set_node(north, {name=MoD..":"..TRuNK, param2=4})
						end
						
						if length >= 4 and minetest.registered_nodes[node_north2.name].buildable_to then
							minetest.set_node(north2, {name=MoD..":"..TRuNK, param2=4})
						end

						minetest.set_node(right_here, {name=MoD..":"..TRuNK, param2=4})
						if minetest.registered_nodes[node_south.name].buildable_to then
							minetest.set_node(south, {name=MoD..":"..TRuNK, param2=4})
						end
						if length == 5 and minetest.registered_nodes[node_south2.name].buildable_to then
							minetest.set_node(south2, {name=MoD..":"..TRuNK, param2=4})
						end
					else
						if minetest.registered_nodes[node_north.name].buildable_to then
							minetest.set_node(north, {name="default:tree", param2=4})
						end
						if length >= 4 and minetest.registered_nodes[node_north2.name].buildable_to then
							minetest.set_node(north2, {name="default:tree", param2=4})
						end
						minetest.set_node(right_here, {name="default:tree", param2=4})
						if minetest.registered_nodes[node_south.name].buildable_to then
							minetest.set_node(south, {name="default:tree", param2=4})
						end
						if length == 5 and minetest.registered_nodes[node_south2.name].buildable_to then
							minetest.set_node(south2, {name="default:tree", param2=4})
						end
					end
				elseif trunk_type == 3 and Horizontal_Trunks == true then
					if minetest.get_modpath(MoD) ~= nil then
						if minetest.registered_nodes[node_west.name].buildable_to then
							minetest.set_node(west, {name=MoD..":"..TRuNK, param2=12})
						end
						if length >= 4 and minetest.registered_nodes[node_west2.name].buildable_to then
							minetest.set_node(west2, {name=MoD..":"..TRuNK, param2=12})
						end
						minetest.set_node(right_here, {name=MoD..":"..TRuNK, param2=12})
						if minetest.registered_nodes[node_east.name].buildable_to then
							minetest.set_node(east, {name=MoD..":"..TRuNK, param2=12})
						end
						if length == 5 and minetest.registered_nodes[node_east2.name].buildable_to then
							minetest.set_node(east2, {name=MoD..":"..TRuNK, param2=12})
						end
					else
						if minetest.registered_nodes[node_west.name].buildable_to then
							minetest.set_node(west, {name="default:tree", param2=12})
						end
						if length >= 4 and minetest.registered_nodes[node_west2.name].buildable_to then
							minetest.set_node(west2, {name="default:tree", param2=12})
						end
						minetest.set_node(right_here, {name="default:tree", param2=12})
						if minetest.registered_nodes[node_east.name].buildable_to then
							minetest.set_node(east, {name="default:tree", param2=12})
						end
						if length == 5 and minetest.registered_nodes[node_east2.name].buildable_to then
							minetest.set_node(east2, {name="default:tree", param2=12})
						end
					end
				end
			end
		end
	end
end

plantslib:register_generate_plant({
    surface = {"default:dirt_with_grass"},
    max_count = Trunks_Max_Count, -- 320,
    rarity = Trunks_Rarity, -- 99,
    min_elevation = 1,
	max_elevation = 40,
	avoid_nodes = {"group:tree"},
	avoid_radius = 1,
	near_nodes = {"group:tree","ferns:fern_03","ferns:fern_02","ferns:fern_01"},
	near_nodes_size = 3,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_trunks.place_trunk
)

-----------------------------------------------------------------------------------------------
-- MoSS & FuNGuS -- on ground
-----------------------------------------------------------------------------------------------
if Moss_on_ground == true then
abstract_trunks.grow_moss_on_ground = function(pos)
	local on_ground = {x=pos.x, y=pos.y+1, z=pos.z}
	local moss_type = math.random(1,21)
	
	if moss_type == 1 then
		minetest.set_node(on_ground, {name="trunks:moss_fungus", param2=math.random(0,3)})
	else
		minetest.set_node(on_ground, {name="trunks:moss", param2=math.random(0,3)})
	end
	
end

plantslib:register_generate_plant({
    surface = {"default:dirt_with_grass"},
    max_count = Moss_on_ground_Max_Count,
    rarity = Moss_on_ground_Rarity,
    min_elevation = 1,
	max_elevation = 40,
	near_nodes = {
		"group:tree",
		"ferns:fern_03",
		"ferns:fern_02",
		"ferns:fern_01"
	},
	near_nodes_size = 2,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_trunks.grow_moss_on_ground
)
end

-----------------------------------------------------------------------------------------------
-- MoSS & FuNGuS -- on trunks
-----------------------------------------------------------------------------------------------
if Moss_on_trunk == true then
abstract_trunks.grow_moss_on_trunk = function(pos)
	local on_ground = {x=pos.x, y=pos.y+1, z=pos.z}
	local at_side_n = {x=pos.x, y=pos.y, z=pos.z+1}
	local at_side_e = {x=pos.x+1, y=pos.y, z=pos.z}
	local at_side_s = {x=pos.x, y=pos.y, z=pos.z-1}
	local at_side_w = {x=pos.x-1, y=pos.y, z=pos.z}
	local undrneath = {x=pos.x, y=pos.y-1, z=pos.z}
	
	local node_here = minetest.get_node(on_ground)
	local node_north = minetest.get_node(at_side_n)
	local node_east = minetest.get_node(at_side_e)
	local node_south = minetest.get_node(at_side_s)
	local node_west = minetest.get_node(at_side_w)
	local node_under = minetest.get_node(undrneath)
	
	--if minetest.get_item_group(node_under.name, "tree") < 1 then
		local moss_type = math.random(1,41)
		if minetest.registered_nodes[node_here.name].buildable_to then -- instead of check_air = true,
			if moss_type == 1 then
				minetest.set_node(on_ground, {name="trunks:moss_fungus", param2=math.random(0,3) --[[1]]})
			elseif moss_type < 22 then
				minetest.set_node(on_ground, {name="trunks:moss", param2=math.random(0,3) --[[1]]})
			end
		end
		local moss_type = math.random(1,31) -- cliche of more moss at north
		if minetest.registered_nodes[node_north.name].buildable_to then -- instead of check_air = true,
			if moss_type == 1 then
				minetest.set_node(at_side_n, {name="trunks:moss_fungus", param2=math.random(4,7)}) -- 5,4,6,7
			elseif moss_type < 22 then
				minetest.set_node(at_side_n, {name="trunks:moss", param2=math.random(4,7)})
			end
		end
		local moss_type = math.random(1,41)
		if minetest.registered_nodes[node_east.name].buildable_to then -- instead of check_air = true,
			if moss_type == 1 then
				minetest.set_node(at_side_e, {name="trunks:moss_fungus", param2=math.random(12,15)})
			elseif moss_type < 22 then
				minetest.set_node(at_side_e, {name="trunks:moss", param2=math.random(12,15)})
			end
		end
		local moss_type = math.random(1,41)
		if minetest.registered_nodes[node_south.name].buildable_to then -- instead of check_air = true,
			if moss_type == 1 then
				minetest.set_node(at_side_s, {name="trunks:moss_fungus", param2=math.random(8,11)})
			elseif moss_type < 22 then
				minetest.set_node(at_side_s, {name="trunks:moss", param2=math.random(8,11)})
			end
		end
		local moss_type = math.random(1,41)
		if minetest.registered_nodes[node_west.name].buildable_to then -- instead of check_air = true,
			if moss_type == 1 then
				minetest.set_node(at_side_w, {name="trunks:moss_fungus", param2=math.random(16,19)})
			elseif moss_type < 22 then
				minetest.set_node(at_side_w, {name="trunks:moss", param2=math.random(16,19)})
			end
		end
	--end
end

plantslib:register_generate_plant({
    surface = {
		"default:tree",
		"default:jungletree",
		"trees:tree_conifer",
		"trees:tree_mangrove",
		--"trees:tree_palm",
		"moretrees:apple_tree_trunk",
		"moretrees:beech_trunk",
		"moretrees:birch_trunk",
		"moretrees:fir_trunk",
		"moretrees:oak_trunk",
		--"moretrees:palm_trunk",
		"moretrees:pine_trunk",
		"moretrees:rubber_tree_trunk",
		"moretrees:rubber_tree_trunk_empty",
		"moretrees:sequoia_trunk",
		"moretrees:spruce_trunk",
		"moretrees:willow_trunk",
		"default:mossycobble"
	},
    max_count = Moss_on_trunk_Max_Count,
    rarity = Moss_on_trunk_Rarity,
    min_elevation = 1,
	max_elevation = 40,
    plantlife_limit = -0.9,
	check_air = false,
  },
  "abstract_trunks.grow_moss_on_trunk"
)
end

-----------------------------------------------------------------------------------------------
-- RooTS 
-----------------------------------------------------------------------------------------------
if Roots == true then -- see settings.txt

abstract_trunks.grow_roots = function(pos)
	local twig_size 	= math.random(1,27)
	
	local right_here 	= {x=pos.x  , y=pos.y  , z=pos.z  }
	local below 		= {x=pos.x  , y=pos.y-1, z=pos.z  }
	local north 		= {x=pos.x  , y=pos.y  , z=pos.z+1}
	local east 			= {x=pos.x+1, y=pos.y  , z=pos.z  }
	local south 		= {x=pos.x  , y=pos.y  , z=pos.z-1}
	local west 			= {x=pos.x-1, y=pos.y  , z=pos.z  }
	
	local node_here 	= minetest.get_node(right_here)
	local node_below	= minetest.get_node(below)
	local node_north 	= minetest.get_node(north)
	local node_east 	= minetest.get_node(east)
	local node_south 	= minetest.get_node(south)
	local node_west 	= minetest.get_node(west)

	for i in pairs(TRuNKS) do
		local 	MoD = 			TRuNKS[i][1]
		local 	TRuNK = 		TRuNKS[i][2]
		if minetest.get_modpath(MoD) ~= nil 
		and node_here.name == MoD..":"..TRuNK 
		and string.find(node_below.name, "dirt")
		and node_here.param2 == 0 then
			if minetest.registered_nodes[node_north.name].buildable_to then
				minetest.set_node(north, {name="trunks:"..TRuNK.."root", param2=2})
			end
			if minetest.registered_nodes[node_east.name].buildable_to then
				minetest.set_node(east, {name="trunks:"..TRuNK.."root", param2=3})
			end
			if minetest.registered_nodes[node_south.name].buildable_to then
				minetest.set_node(south, {name="trunks:"..TRuNK.."root", param2=0})
			end
			if minetest.registered_nodes[node_west.name].buildable_to then
				minetest.set_node(west, {name="trunks:"..TRuNK.."root", param2=1})
			end
		end
	end
end

plantslib:register_generate_plant({
    surface = {"group:tree"},
    max_count = 1000,
    rarity = 1,
    min_elevation = 1,
	max_elevation = 40,
	near_nodes = {"default:dirt_with_grass"},
	near_nodes_size = 1,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -1,
    check_air = false,
  },
  "abstract_trunks.grow_roots"
)

end
