-----------------------------------------------------------------------------------------------
local title		= "Grasses" -- former "Dry plants"
local version 	= "0.1.5"
local mname		= "dryplants"
-----------------------------------------------------------------------------------------------
-- by Mossmanikin
-- textures & ideas partly by Neuromancer

-- License (everything): 	WTFPL
-- Contains code from: 		default, farming 
-- Looked at code from:		darkage, sickle, stairs
-- Dependencies: 			default, farming, plants_lib
-- Supports:				
-----------------------------------------------------------------------------------------------
abstract_dryplants = {}

dofile(minetest.get_modpath("dryplants").."/crafting.lua")
dofile(minetest.get_modpath("dryplants").."/settings.txt")
dofile(minetest.get_modpath("dryplants").."/reed.lua")
if REEDMACE_GENERATES == true then
dofile(minetest.get_modpath("dryplants").."/reedmace.lua")
end
if SMALL_JUNCUS_GENERATES == true then
dofile(minetest.get_modpath("dryplants").."/juncus.lua")
end
if EXTRA_TALL_GRASS_GENERATES == true then
dofile(minetest.get_modpath("dryplants").."/moregrass.lua")
end
--dofile(minetest.get_modpath("dryplants").."/meadowvariation.lua")

-----------------------------------------------------------------------------------------------
-- Sickle
-----------------------------------------------------------------------------------------------
-- turns nodes with group flora=1 & flower=0 into cut grass
local function sickle_on_use(itemstack, user, pointed_thing, uses)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return
	end
	if pt.type ~= "node" then
		return
	end
	
	local under = minetest.get_node(pt.under)
	local p = {x=pt.under.x, y=pt.under.y+1, z=pt.under.z}
	local above = minetest.get_node(p)
	
	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return
	end
	if not minetest.registered_nodes[above.name] then
		return
	end
	
	local node = minetest.get_node(pt.under)
	-- check if something that can be cut using fine tools
	if minetest.get_item_group(under.name, "snappy") > 0 then
		-- check if flora but no flower
		if minetest.get_item_group(under.name, "flora") == 1 and minetest.get_item_group(under.name, "flower") == 0 then
			-- turn the node into cut grass, wear out item and play sound
			minetest.set_node(pt.under, {name="dryplants:grass"})
		else -- otherwise get the drop
			local inv = user:get_inventory()
			local name = minetest. get_node(pt.under).name
			
			local the_drop = minetest.registered_nodes[name].drop
			
			if the_drop ~= nil then
				if inv:room_for_item("main", the_drop) then
					inv:add_item("main", the_drop)
				end
			else
				if inv:room_for_item("main", name) then
					inv:add_item("main", name)
				end
			end
			minetest.remove_node(pt.under)
		end
		minetest.sound_play("default_dig_crumbly", {
			pos = pt.under,
			gain = 0.5,
		})
		itemstack:add_wear(65535/(uses-1))
		return itemstack
	elseif string.find(node.name, "default:dirt_with_grass") then
		minetest.set_node(pt.under, {name="dryplants:grass_short"})
		minetest.set_node(pt.above, {name="dryplants:grass"})
		minetest.sound_play("default_dig_crumbly", {
			pos = pt.under,
			gain = 0.5,
		})
		itemstack:add_wear(65535/(uses-1))
		return itemstack
	end
end
-- the tool
minetest.register_tool("dryplants:sickle", {
	description = "Sickle",
	inventory_image = "dryplants_sickle.png",
	on_use = function(itemstack, user, pointed_thing)
		return sickle_on_use(itemstack, user, pointed_thing, 220)
	end,
})

-----------------------------------------------------------------------------------------------
-- Cut Grass
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:grass", {
	description = "Cut Grass",
	inventory_image = "dryplants_grass.png",
	wield_image = "dryplants_grass.png",
	paramtype = "light",
	sunlight_propagates = true,
	tiles = {"dryplants_grass.png"},
	drawtype = "nodebox",
	node_box = {
	    type = "fixed",
        fixed = {-0.5   , -0.5   , -0.5   ,   0.5   , -0.4375,  0.5   },
    },
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

-----------------------------------------------------------------------------------------------
-- Cut Grass becomes Hay over time
-----------------------------------------------------------------------------------------------
minetest.register_abm({
	nodenames = {"dryplants:grass"},
	interval = HAY_DRYING_TIME, --1200, -- 20 minutes: a minetest-day/night-cycle
	chance = 1,
	action = function(pos)
		minetest.set_node(pos, {name="dryplants:hay"})
	end,
})

-----------------------------------------------------------------------------------------------
-- Hay
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:hay", {
	description = "Hay",
	inventory_image = "dryplants_hay.png",
	wield_image = "dryplants_hay.png",
	paramtype = "light",
	sunlight_propagates = true,
	tiles = {"dryplants_hay.png"},
	drawtype = "nodebox",
	node_box = {
	    type = "fixed",
        fixed = {-0.5   , -0.5   , -0.5   ,   0.5   , -0.4375,  0.5   },
    },
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

-----------------------------------------------------------------------------------------------
-- Short Grass
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:grass_short", {
	description = "Short Grass",
	tiles = {"default_grass.png^dryplants_grass_short.png", "default_dirt.png", "default_dirt.png^default_grass_side.png^dryplants_grass_short_side.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1,not_in_creative_inventory=1},
	--drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

-----------------------------------------------------------------------------------------------
-- Short Grass becomes Dirt with Grass over time
-----------------------------------------------------------------------------------------------
minetest.register_abm({
	nodenames = {"dryplants:grass_short"},
	interval = GRASS_REGROWING_TIME, --1200, -- 20 minutes: a minetest-day/night-cycle
	chance = 100/GRASS_REGROWING_CHANCE,
	action = function(pos)
		minetest.set_node(pos, {name="default:dirt_with_grass"})
	end,
})

-----------------------------------------------------------------------------------------------
print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
-----------------------------------------------------------------------------------------------
