-- NODES

-- Pine Needles
minetest.register_node("snow:needles",{
	description = "Pine Needles",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"snow_needles.png"},
	waving = 1,
	paramtype = "light",
	groups = {snappy=3, leafdecay=5},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'snow:sapling_pine'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'snow:needles'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

--[[
If christmas_content is enabled, then this next part will override the pine needles' drop code
(in the code section above) and adds Xmas tree saplings to the items that are dropped.
The Xmas tree needles are registred and defined a farther down in this nodes.lua file.

~ LazyJ

--]]

if snow.christmas_content then
	--Christmas trees

	minetest.override_item("snow:needles", {
		drop = {
			max_items = 1,
			items = {
				{
					-- player will get xmas tree with 1/120 chance
					items = {'snow:xmas_tree'},
					rarity = 120,
				},
				{
					-- player will get sapling with 1/20 chance
					items = {'snow:sapling_pine'},
					rarity = 20,
				},
				{
					-- player will get leaves only if he get no saplings,
					-- this is because max_items is 1
					items = {'snow:needles'},
				}
			}
		}
	})
end


	--Christmas easter egg
	minetest.register_on_mapgen_init( function()
		if rawget(_G, "skins") then
			skins.add("character_snow_man")
		end
	end
	)



--[[
Original, static Xmas lights. Keep so people can "turn off" the
animation if it is too much for them. ~ LazyJ

--Decorated Pine leaves
minetest.register_node("snow:needles_decorated", {
	description = "Decorated Pine Needles",
	drawtype = "allfaces_optional",
	tiles = {"snow_needles_decorated.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3},
		drop = {
		max_items = 1,
		items = {
			{
				-- player will get xmas tree with 1/20 chance
				items = {'snow:xmas_tree'},
				rarity = 50,
			},
			{
				-- player will get sapling with 1/20 chance
				items = {'snow:sapling_pine'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'snow:needles_decorated'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})
--]]



-- Animated, "blinking lights" version. ~ LazyJ

-- Decorated Pine Leaves
minetest.register_node("snow:needles_decorated", {
	description = "Decorated Pine Needles",
	drawtype = "allfaces_optional",
	light_source = 5,
	inventory_image = minetest.inventorycube("snow_needles_decorated.png"),
	--tiles = {"snow_needles_decorated.png"},
	tiles = {
		{name="snow_needles_decorated_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=20.0}}
	},
	paramtype = "light",
	groups = {snappy=3, leafdecay=5},
		drop = {
		max_items = 1,
		items = {
			{
				-- player will get xmas tree with 1/120 chance
				items = {'snow:xmas_tree'},
				rarity = 120,
			},
			{
				-- player will get sapling with 1/20 chance
				items = {'snow:sapling_pine'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'snow:needles_decorated'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})




-- Xmas Tree Sapling
minetest.register_node("snow:xmas_tree", {
	description = "Christmas Tree",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"snow_xmas_tree.png"},
	inventory_image = "snow_xmas_tree.png",
	wield_image = "snow_xmas_tree.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3},
	sounds = default.node_sound_defaults(),
})



-- Pine Sapling
minetest.register_node("snow:sapling_pine", {
	description = "Pine Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"snow_sapling_pine.png"},
	inventory_image = "snow_sapling_pine.png",
	wield_image = "snow_sapling_pine.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3},
	sounds = default.node_sound_defaults(),

})



-- Star on Xmas Trees
minetest.register_node("snow:star", {
	description = "Star",
	--drawtype = "torchlike",
	drawtype = "plantlike", -- Stars disappeared when viewed at the right angle. "Plantlike" solved the visual problem. ~ LazyJ
	tiles = {"snow_star.png"},
	inventory_image = "snow_star.png",
	wield_image = "snow_star.png",
	paramtype = "light",
	walkable = false,
	--groups = {snappy=2,dig_immediate=3},
	groups = {cracky=1, crumbly=1, choppy=1, oddly_breakable_by_hand=1}, -- Don't want the ornament breaking too easily because you have to punch it to turn it on and off. ~ LazyJ
	sounds = default.node_sound_glass_defaults({dig = {name="default_glass_footstep", gain=0.2}}), -- Breaking "glass" sound makes it sound like a real, broken, Xmas tree ornament (Sorry, Mom!).  ;)-  ~ LazyJ
	on_punch = function(pos, node) -- Added a "lit" star that can be punched on or off depending on your preference. ~ LazyJ
		node.name = "snow:star_lit"
		minetest.set_node(pos, node)
		nodeupdate(pos)
	end,
})



-- Star (Lit Version) on Xmas Trees
minetest.register_node("snow:star_lit", {
	description = "Star Lighted",
	drawtype = "plantlike",
	light_source = LIGHT_MAX,
	tiles = {"snow_star_lit.png"},
	wield_image = "snow_star.png",
	paramtype = "light",
	walkable = false,
	drop = "snow:star",
	groups = {cracky=1, crumbly=1, choppy=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults({dig = {name="default_glass_footstep", gain=0.2}}),
	on_punch = function(pos, node)
		node.name = "snow:star"
		minetest.set_node(pos, node)
		nodeupdate(pos)
	end,
})



-- Moss
minetest.register_node("snow:moss", {
	description = "Moss",
	inventory_image = "snow_moss.png",
	tiles = {"snow_moss.png"},
	drawtype = "signlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	selection_box = {
		type = "wallmounted",
	},
	is_ground_content = true,
	groups = {crumbly=3, attached_node=1},
})



local function snow_onto_dirt(pos)
	pos.y = pos.y - 1
	local node = minetest.get_node(pos)
	if node.name == "default:dirt_with_grass"
	or node.name == "default:dirt" then
		node.name = "default:dirt_with_snow"
		minetest.set_node(pos, node)
	end
end



-- Snow Brick
minetest.register_node("snow:snow_brick", {
	description = "Snow Brick",
	tiles = {"snow_snow_brick.png"},
	is_ground_content = true,
	freezemelt = "default:water_source",
	liquidtype = "none",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir", -- Allow blocks to be rotated with the screwdriver or
	-- by player position. ~ LazyJ
	 -- I made this a little harder to dig than snow blocks because
	 -- I imagine snow brick as being much more dense and solid than fluffy snow. ~ LazyJ
	groups = {cracky=2, crumbly=2, choppy=2, oddly_breakable_by_hand=2, melts=1, icemaker=1, cooks_into_ice=1},
	 --Let's use the new snow sounds instead of the old grass sounds. ~ LazyJ
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_snow_footstep", gain=0.25},
		dig = {name="default_dig_crumbly", gain=0.4},
		dug = {name="default_snow_footstep", gain=0.75},
		place = {name="default_place_node", gain=1.0}
	}),
 	-- The "on_construct" part below, thinking in terms of layers, dirt_with_snow could also
 	-- double as dirt_with_frost which adds subtlety to the winterscape. ~ LazyJ
	on_construct = snow_onto_dirt
})



-- Snow Cobble  ~ LazyJ
-- Described as Icy Snow
minetest.register_node("snow:snow_cobble", {
	description = "Icy Snow",
	tiles = {"snow_snow_cobble.png"},
	is_ground_content = true,
	liquidtype = "none",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	 -- I made this a little harder to dig than snow blocks because
	 -- I imagine snow brick as being much more dense and solid than fluffy snow. ~ LazyJ
	groups = {cracky=2, crumbly=2, choppy=2, oddly_breakable_by_hand=2, melts=1, icemaker=1, cooks_into_ice=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_snow_footstep", gain=0.25},
		dig = {name="default_dig_crumbly", gain=0.4},
		dug = {name="default_snow_footstep", gain=0.75},
		place = {name="default_place_node", gain=1.0}
	}),
 	-- The "on_construct" part below, thinking in terms of layers, dirt_with_snow could also
 	-- double as dirt_with_frost which adds subtlety to the winterscape. ~ LazyJ
	on_construct = snow_onto_dirt
})



-- Override Default Nodes to Add Extra Functions

-- This adds code to the existing default ice. ~ LazyJ
minetest.override_item("default:ice", {
	-- The Lines: 1. Alpah to make semi-transparent ice, 2 to work with
	-- the dirt_with_grass/snow/just dirt ABMs. ~ LazyJ, 2014_03_09
	use_texture_alpha = true, -- 1
	param2 = 0,
	--param2 is reserved for how much ice will freezeover.
	sunlight_propagates = true, -- 2
	drawtype = "glasslike",
	inventory_image  = minetest.inventorycube("default_ice.png").."^[brighten",
	liquidtype = "none",
	 -- I made this a lot harder to dig than snow blocks because ice is much more dense
	 -- and solid than fluffy snow. ~ LazyJ
	groups = {cracky=2, crumbly=1, choppy=1, --[[oddly_breakable_by_hand=1,]] melts=1},
	on_construct = snow_onto_dirt,
	liquids_pointable = true,
	--Make ice freeze over when placed by a maximum of 10 blocks.
	after_place_node = function(pos)
		minetest.set_node(pos, {name="default:ice", param2=math.random(0,10)})
	end
})



-- This adds code to the existing, default snowblock. ~ LazyJ
minetest.override_item("default:snowblock", {
	liquidtype = "none", -- LazyJ to make dirt below change to dirt_with_snow (see default, nodes.lua, dirt ABM)
	paramtype = "light",  -- LazyJ to make dirt below change to dirt_with_snow (see default, nodes.lua, dirt ABM)
	sunlight_propagates = true, -- LazyJ to make dirt below change to dirt_with_snow (see default, nodes.lua, dirt ABM)
	 -- Snow blocks should be easy to dig because they are just fluffy snow. ~ LazyJ
	groups = {cracky=3, crumbly=3, choppy=3, oddly_breakable_by_hand=3, melts=1, icemaker=1, cooks_into_ice=1, falling_node=1},
	--drop = "snow:snow_cobble",
	on_construct = snow_onto_dirt
		-- Thinking in terms of layers, dirt_with_snow could also double as
		-- dirt_with_frost which adds subtlety to the winterscape. ~ LazyJ, 2014_04_04
})
