-- Code by Mossmanikin & Neuromancer
-----------------------------------------------------------------------------------------------
-- TWiGS
-----------------------------------------------------------------------------------------------
-- For compatibility with older stuff
minetest.register_alias("trunks:twig",	"trunks:twig_1")

local flat_stick = {-1/2, -1/2, -1/2, 1/2, -7/16, 1/2}
local NoDe = { {1}, {2}, {3}, {4}, {5}, --[[{6},]] {7}, {8}, {9}, {10}, {11}, {12}, {13} }


for i in pairs(NoDe) do
	local NR = NoDe[i][1]
	local iNV = NR - 1
	minetest.register_node("trunks:twig_"..NR, {
		description = "Twig",
		inventory_image = "trunks_twig_"..NR..".png",
		wield_image = "trunks_twig_"..NR..".png",
		drawtype = "nodebox",
		tiles = { 
			"trunks_twig_"..NR..".png",
			"trunks_twig_"..NR..".png^[transformFY", -- mirror
			"trunks_twig_6.png" -- empty
		},
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = false,
		sunlight_propagates = true,
		buildable_to = true,
		node_box = {type = "fixed", fixed = flat_stick},
		groups = {
			dig_immediate=3, -- almost literally immediate, like just picking up
			attached_node=1,
			not_in_creative_inventory=iNV
		},
		drop = "trunks:twig_1",
		sounds = default.node_sound_leaves_defaults(),
		liquids_pointable = true,
		on_place = function(itemstack, placer, pointed_thing)
			local pt = pointed_thing
			local direction = minetest.dir_to_facedir(placer:get_look_dir())
			if minetest.get_node(pt.above).name=="air" then
				minetest.set_node(pt.above, {name="trunks:twig_"..math.random(1,4), param2=direction})
				if not minetest.setting_getbool("creative_mode") then
					itemstack:take_item()
				end
				return itemstack
			end
		end,
	})
end

-----------------------------------------------------------------------------------------------
-- MoSS
-----------------------------------------------------------------------------------------------
local flat_moss = {-1/2, -1/2, -1/2, 1/2, -15/32--[[<-flickers if smaller]], 1/2}

minetest.register_node("trunks:moss", {
	description = "Moss",
	drawtype = "nodebox",--"signlike",
	tiles = {"trunks_moss.png"},
	inventory_image = "trunks_moss.png",
	wield_image = "trunks_moss.png",
	paramtype = "light",
	paramtype2 = "facedir",--"wallmounted",
	sunlight_propagates = true,
	walkable = false,
	node_box = {type = "fixed", fixed = flat_moss},
	selection_box = {type = "fixed", fixed = flat_stick},--{type = "wallmounted"},
	groups = {dig_immediate=2--[[,attached_node=1]]}, -- falling moss is too annoying
	sounds = default.node_sound_leaves_defaults(),
})

-----------------------------------------------------------------------------------------------
-- MoSS & FuNGuS
-----------------------------------------------------------------------------------------------
minetest.register_node("trunks:moss_fungus", {
	description = "Moss with Fungus",
	drawtype = "nodebox",--"signlike",
	tiles = {"trunks_moss_fungus.png"},
	inventory_image = "trunks_moss_fungus.png",
	wield_image = "trunks_moss_fungus.png",
	paramtype = "light",
	paramtype2 = "facedir",--"wallmounted",
	sunlight_propagates = true,
	walkable = false,
	node_box = {type = "fixed", fixed = flat_moss},
	selection_box = {type = "fixed", fixed = flat_stick},--{type = "wallmounted"},
	groups = {dig_immediate=2--[[,attached_node=1]]}, -- falling moss is too annoying
	sounds = default.node_sound_leaves_defaults(),
})

-----------------------------------------------------------------------------------------------
-- TWiGS BLoCK
-----------------------------------------------------------------------------------------------
minetest.register_alias("woodstuff:twigs",	"trunks:twigs")

minetest.register_node("trunks:twigs", {
	description = "Twigs Block",
	paramtype2 = "facedir",
	tiles = {"trunks_twigs.png"},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

-----------------------------------------------------------------------------------------------
-- TWiGS SLaB
-----------------------------------------------------------------------------------------------
minetest.register_alias("woodstuff:twigs_slab",	"trunks:twigs_slab")

minetest.register_node("trunks:twigs_slab", {
	description = "Twigs Slab",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"trunks_twigs.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

-----------------------------------------------------------------------------------------------
-- TWiGS RooF
-----------------------------------------------------------------------------------------------
minetest.register_alias("woodstuff:twigs_roof",	"trunks:twigs_roof")

minetest.register_node("trunks:twigs_roof", {
	description = "Twigs Roof",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"trunks_twigs.png"},
	node_box = {
		type = "fixed",
--			{ left, bottom, front, right, top, back }
		fixed = {
			{-1/2, 0, 0, 1/2, 1/2, 1/2},
			{-1/2, -1/2, -1/2, 1/2, 0, 0},
		}
	},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

-----------------------------------------------------------------------------------------------
-- TWiGS RooF CoRNeR
-----------------------------------------------------------------------------------------------
minetest.register_alias("woodstuff:twigs_roof_corner",	"trunks:twigs_roof_corner")

minetest.register_node("trunks:twigs_roof_corner", {
	description = "Twigs Roof Corner 1",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"trunks_twigs_corner.png",
		"trunks_twigs_corner.png",
		"trunks_twigs.png"
	},
	node_box = {
		type = "fixed",
--			{ left, bottom, front, right, top, back }
		fixed = {
			{-1/2, 0, 0, 0, 1/2, 1/2},
			{0, -1/2, 0, 1/2, 0, 1/2},
			{-1/2, -1/2, -1/2, 0, 0, 0},
		}
	},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

-----------------------------------------------------------------------------------------------
-- TWiGS RooF CoRNeR 2
-----------------------------------------------------------------------------------------------
minetest.register_alias("woodstuff:twigs_roof_corner_2",	"trunks:twigs_roof_corner_2")

minetest.register_node("trunks:twigs_roof_corner_2", {
	description = "Twigs Roof Corner 2",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"trunks_twigs_corner.png",
		"trunks_twigs_corner.png",
		"trunks_twigs.png"
	},
	node_box = {
		type = "fixed",
--			{ left, bottom, front, right, top, back }
		fixed = {
			{-1/2, -1/2, 0, 0, 0, 1/2},
			{0, 0, 0, 1/2, 1/2, 1/2},
			{-1/2, 0, -1/2, 0, 1/2, 0},
		}
	},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

if Auto_Roof_Corner == true then

	local roof = "trunks:twigs_roof"
	local corner = "trunks:twigs_roof_corner"
	local corner_2 = "trunks:twigs_roof_corner_2"

	minetest.register_abm({
		nodenames = {roof},
		interval = 1,
		chance = 1,
		action = function(pos)
	
			local node_east = 			minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z  })
			local node_west = 			minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z  })
			local node_north = 			minetest.get_node({x=pos.x,   y=pos.y, z=pos.z+1})
			local node_south = 			minetest.get_node({x=pos.x,   y=pos.y, z=pos.z-1})
		-- corner 1
			if ((node_west.name == roof and node_west.param2 == 0)
			or (node_west.name == corner and node_west.param2 == 1))
			and ((node_north.name == roof and node_north.param2 == 3)
			or (node_north.name == corner and node_north.param2 == 3))
			then
				minetest.set_node(pos, {name=corner, param2=0})
			end
		
			if ((node_north.name == roof and node_north.param2 == 1)
			or (node_north.name == corner and node_north.param2 == 2))
			and ((node_east.name == roof and node_east.param2 == 0)
			or (node_east.name == corner and node_east.param2 == 0))
			then
				minetest.set_node(pos, {name=corner, param2=1})
			end
		
			if ((node_east.name == roof and node_east.param2 == 2)
			or (node_east.name == corner and node_east.param2 == 3))
			and ((node_south.name == roof and node_south.param2 == 1)
			or (node_south.name == corner and node_south.param2 == 1))
			then
				minetest.set_node(pos, {name=corner, param2=2})
			end
		
			if ((node_south.name == roof and node_south.param2 == 3)
			or (node_south.name == corner and node_south.param2 == 0))
			and ((node_west.name == roof and node_west.param2 == 2)
			or (node_west.name == corner and node_west.param2 == 2))
			then
				minetest.set_node(pos, {name=corner, param2=3})
			end
		-- corner 2
			if ((node_west.name == roof and node_west.param2 == 2)
			or (node_west.name == corner_2 and node_west.param2 == 1))
			and ((node_north.name == roof and node_north.param2 == 1)
			or (node_north.name == corner_2 and node_north.param2 == 3))
			then
				minetest.set_node(pos, {name=corner_2, param2=0})
			end
		
			if ((node_north.name == roof and node_north.param2 == 3)
			or (node_north.name == corner_2 and node_north.param2 == 2))
			and ((node_east.name == roof and node_east.param2 == 2)
			or (node_east.name == corner_2 and node_east.param2 == 0))
			then
				minetest.set_node(pos, {name=corner_2, param2=1})
			end
		
			if ((node_east.name == roof and node_east.param2 == 0)
			or (node_east.name == corner_2 and node_east.param2 == 3))
			and ((node_south.name == roof and node_south.param2 == 3)
			or (node_south.name == corner_2 and node_south.param2 == 1))
			then
				minetest.set_node(pos, {name=corner_2, param2=2})
			end
		
			if ((node_south.name == roof and node_south.param2 == 1)
			or (node_south.name == corner_2 and node_south.param2 == 0))
			and ((node_west.name == roof and node_west.param2 == 0)
			or (node_west.name == corner_2 and node_west.param2 == 2))
			then
				minetest.set_node(pos, {name=corner_2, param2=3})
			end

		end,
	})
end

-- MM: The following stuff is just for testing purposes for now; no generating of roots.
--     I'm not satisfied with this; they should be either bigger or a different drawtype.
-----------------------------------------------------------------------------------------------
-- RooTS 
-----------------------------------------------------------------------------------------------
if Roots == true then -- see settings.txt

local roots_cube =	{-2/16, -1/2, -3/16, 2/16, 1/16, 1/2}

local roots_sheet = {0, -1/2, -1/2, 0, 1/16, 1/2}

local TRuNKS = {
--	  MoD 						 TRuNK
    {"default",  				"tree"						},
	{"default",					"jungletree"				},
	
	{"trees",					"tree_conifer"				},
	{"trees",					"tree_mangrove"				},
	{"trees",					"tree_palm"					},
	
	{"moretrees",				"apple_tree_trunk"			},
	{"moretrees",				"beech_trunk"				},
	{"moretrees",				"birch_trunk"				},
	{"moretrees",				"fir_trunk"					},
	{"moretrees",				"oak_trunk"					},
	{"moretrees",				"palm_trunk"				},
	{"moretrees",				"pine_trunk"				},
	{"moretrees",				"rubber_tree_trunk"			},
	{"moretrees",				"rubber_tree_trunk_empty"	},
	{"moretrees",				"sequoia_trunk"				},
	{"moretrees",				"spruce_trunk"				},
	{"moretrees",				"willow_trunk"				},
}

for i in pairs(TRuNKS) do
	local 	MoD = 			TRuNKS[i][1]
	local 	TRuNK = 		TRuNKS[i][2]
	if minetest.get_modpath(MoD) ~= nil then
		
		local des = minetest.registered_nodes[MoD..":"..TRuNK].description
	
		minetest.register_node("trunks:"..TRuNK.."root", {
			description = des.." Root",
			paramtype = "light",
			paramtype2 = "facedir",
			tiles = {
--[[top]]		MoD.."_"..TRuNK..".png",
--[[bottom]]	MoD.."_"..TRuNK..".png",
--[[right]]		MoD.."_"..TRuNK..".png^trunks_root_mask.png^[makealpha:0,0,0",
--[[left]]		MoD.."_"..TRuNK..".png^trunks_root_mask.png^[transformFX^[makealpha:0,0,0",
--[[back]]		MoD.."_"..TRuNK..".png",
--[[front]]		MoD.."_"..TRuNK..".png"
			},
			drawtype = "nodebox",
			selection_box = {type = "fixed", fixed = roots_cube},
			node_box = {type = "fixed", fixed = roots_sheet},
			groups = {
				tree=1,
				snappy=1,
				choppy=2,
				oddly_breakable_by_hand=1,
				flammable=2--,
				--not_in_creative_inventory=1 -- atm in inv for testing 
			},
			--drop = "trunks:twig_1", -- not sure about this yet
			sounds = default.node_sound_wood_defaults(),
		}) 
	
	end
end
end
