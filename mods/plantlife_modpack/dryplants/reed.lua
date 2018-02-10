-----------------------------------------------------------------------------------------------
-- Dry Plants - Reed 0.0.5
-----------------------------------------------------------------------------------------------
-- by Mossmanikin
-- License (everything): 	WTFPL
-- Looked at code from:		darkage, default, stairs
-- Dependencies: 			default
-----------------------------------------------------------------------------------------------
-- support for i18n
local S = plantlife_i18n.gettext

minetest.register_alias("stairs:stair_wetreed",				"dryplants:wetreed_roof")
minetest.register_alias("stairs:slab_wetreed",				"dryplants:wetreed_slab")
minetest.register_alias("stairs:stair_reed",				"dryplants:reed_roof")
minetest.register_alias("stairs:slab_reed",					"dryplants:reed_slab")


-----------------------------------------------------------------------------------------------
-- Wet Reed
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:wetreed", {
	description = S("Wet Reed"),
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"dryplants_reed_wet.png"},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

-----------------------------------------------------------------------------------------------
-- Wet Reed Slab
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:wetreed_slab", {
	description = S("Wet Reed Slab"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"dryplants_reed_wet.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

-----------------------------------------------------------------------------------------------
-- Wet Reed Roof
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:wetreed_roof", {
	description = S("Wet Reed Roof"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"dryplants_reed_wet.png"},
	node_box = {
		type = "fixed",
--				{ left	, bottom , front  ,  right ,  top   ,  back  }
		fixed = {
			{-1/2, 0, 0, 1/2, 1/2, 1/2},
			{-1/2, -1/2, -1/2, 1/2, 0, 0},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-1/2, 0, 0, 1/2, 1/2, 1/2},
			{-1/2, -1/2, -1/2, 1/2, 0, 0},
		}
	},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

if AUTO_ROOF_CORNER == true then

	local CoRNeR = {
--		  MaTeRiaL
		{"wetreed"},
		{"reed"}
	}

	for i in pairs(CoRNeR) do

		local MaTeRiaL = CoRNeR[i][1]
		local roof = "dryplants:"..MaTeRiaL.."_roof"
		local corner = "dryplants:"..MaTeRiaL.."_roof_corner"
		local corner_2 = "dryplants:"..MaTeRiaL.."_roof_corner_2"

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
end

-----------------------------------------------------------------------------------------------
-- Wet Reed Roof Corner
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:wetreed_roof_corner", {
	description = S("Wet Reed Roof Corner"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"dryplants_reed_wet.png"},
	node_box = {
		type = "fixed",
--				{ left	, bottom , front  ,  right ,  top   ,  back  }
		fixed = {
			{-1/2, 0, 0, 0, 1/2, 1/2},
			{0, -1/2, 0, 1/2, 0, 1/2},
			{-1/2, -1/2, -1/2, 0, 0, 0},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-1/2, 0, 0, 0, 1/2, 1/2},
			{0, -1/2, 0, 1/2, 0, 1/2},
			{-1/2, -1/2, -1/2, 0, 0, 0},
		}
	},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

-----------------------------------------------------------------------------------------------
-- Wet Reed Roof Corner 2
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:wetreed_roof_corner_2", {
	description = S("Wet Reed Roof Corner 2"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"dryplants_reed_wet.png"},
	node_box = {
		type = "fixed",
--				{ left	, bottom , front  ,  right ,  top   ,  back  }
		fixed = {
			{-1/2, -1/2, 0, 0, 0, 1/2},
			{0, 0, 0, 1/2, 1/2, 1/2},
			{-1/2, 0, -1/2, 0, 1/2, 0},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-1/2, -1/2, 0, 0, 0, 1/2},
			{0, 0, 0, 1/2, 1/2, 1/2},
			{-1/2, 0, -1/2, 0, 1/2, 0},
		}
	},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

-----------------------------------------------------------------------------------------------
-- Wet Reed becomes (dry) Reed over time
-----------------------------------------------------------------------------------------------
if REED_WILL_DRY == true then

	local DRyiNG = {
--	  	  WeT									 DRy
		{"dryplants:wetreed",					"dryplants:reed"},
		{"dryplants:wetreed_slab",				"dryplants:reed_slab"},
		{"dryplants:wetreed_roof",				"dryplants:reed_roof"},
		{"dryplants:wetreed_roof_corner",		"dryplants:reed_roof_corner"},
		{"dryplants:wetreed_roof_corner_2",		"dryplants:reed_roof_corner_2"}
	}
	for i in pairs(DRyiNG) do

		local WeT = DRyiNG[i][1]
		local DRy = DRyiNG[i][2]

		minetest.register_abm({
			nodenames = {WeT},
			interval = REED_DRYING_TIME, --1200, -- 20 minutes: a minetest-day/night-cycle
			chance = 1,
			action = function(pos)
				local direction = minetest.get_node(pos).param2
				minetest.set_node(pos, {name=DRy, param2=direction})
			end,
		})
	end
end

-----------------------------------------------------------------------------------------------
-- Reed
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reed", {
	description = S("Reed"),
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"dryplants_reed.png"},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

-----------------------------------------------------------------------------------------------
-- Reed Slab
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reed_slab", {
	description = S("Reed Slab"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"dryplants_reed.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

-----------------------------------------------------------------------------------------------
-- Reed Roof
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reed_roof", {
	description = S("Reed Roof"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"dryplants_reed.png"},
	node_box = {
		type = "fixed",
--				{ left	, bottom , front  ,  right ,  top   ,  back  }
		fixed = {
			{-1/2, 0, 0, 1/2, 1/2, 1/2},
			{-1/2, -1/2, -1/2, 1/2, 0, 0},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-1/2, 0, 0, 1/2, 1/2, 1/2},
			{-1/2, -1/2, -1/2, 1/2, 0, 0},
		}
	},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

-----------------------------------------------------------------------------------------------
-- Reed Roof Corner
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reed_roof_corner", {
	description = S("Reed Roof Corner"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"dryplants_reed.png"},
	node_box = {
		type = "fixed",
--				{ left	, bottom , front  ,  right ,  top   ,  back  }
		fixed = {
			{-1/2, 0, 0, 0, 1/2, 1/2},
			{0, -1/2, 0, 1/2, 0, 1/2},
			{-1/2, -1/2, -1/2, 0, 0, 0},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-1/2, 0, 0, 0, 1/2, 1/2},
			{0, -1/2, 0, 1/2, 0, 1/2},
			{-1/2, -1/2, -1/2, 0, 0, 0},
		}
	},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

-----------------------------------------------------------------------------------------------
-- Reed Roof Corner 2
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reed_roof_corner_2", {
	description = S("Reed Roof Corner 2"),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"dryplants_reed.png"},
	node_box = {
		type = "fixed",
--				{ left	, bottom , front  ,  right ,  top   ,  back  }
		fixed = {
			{-1/2, -1/2, 0, 0, 0, 1/2},
			{0, 0, 0, 1/2, 1/2, 1/2},
			{-1/2, 0, -1/2, 0, 1/2, 0},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-1/2, -1/2, 0, 0, 0, 1/2},
			{0, 0, 0, 1/2, 1/2, 1/2},
			{-1/2, 0, -1/2, 0, 1/2, 0},
		}
	},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})
