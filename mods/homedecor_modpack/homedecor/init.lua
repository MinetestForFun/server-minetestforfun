-- Home Decor mod by VanessaE
--
-- Mostly my own code, with bits and pieces lifted from Minetest's default
-- lua files and from ironzorg's flowers mod.  Many thanks to GloopMaster
-- for helping me figure out the inventories used in the nightstands/dressers.
--
-- The code for ovens, nightstands, refrigerators are basically modified
-- copies of the code for chests and furnaces.

homedecor = {}

homedecor.debug = 0

-- detail level for roofing slopes and also cobwebs

homedecor.detail_level = 16

homedecor.modpath = minetest.get_modpath("homedecor")
homedecor.intllib_modpath = minetest.get_modpath("intllib")

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end
homedecor.gettext = S

-- debug

local dbg = function(s)
	if homedecor.debug == 1 then
		print('[HomeDecor] ' .. s)
	end
end

-- infinite stacks

if minetest.get_modpath("unified_inventory") or not minetest.setting_getbool("creative_mode") then
	homedecor.expect_infinite_stacks = false
else
	homedecor.expect_infinite_stacks = true
end

--table copy

function homedecor.table_copy(t)
	local nt = { };
	for k, v in pairs(t) do
		if type(v) == "table" then
			nt[k] = homedecor.table_copy(v)
		else
			nt[k] = v
		end
	end
	return nt
end

-- Determine if the item being pointed at is the underside of a node (e.g a ceiling)

function homedecor.find_ceiling(itemstack, placer, pointed_thing)
	-- most of this is copied from the rotate-and-place function in builtin
	local unode = core.get_node_or_nil(pointed_thing.under)
	if not unode then
		return
	end
	local undef = core.registered_nodes[unode.name]
	if undef and undef.on_rightclick then
		undef.on_rightclick(pointed_thing.under, unode, placer,
				itemstack, pointed_thing)
		return
	end
	local pitch = placer:get_look_pitch()
	local fdir = core.dir_to_facedir(placer:get_look_dir())
	local wield_name = itemstack:get_name()

	local above = pointed_thing.above
	local under = pointed_thing.under
	local iswall = (above.y == under.y)
	local isceiling = not iswall and (above.y < under.y)
	local anode = core.get_node_or_nil(above)
	if not anode then
		return
	end
	local pos = pointed_thing.above
	local node = anode

	if undef and undef.buildable_to then
		pos = pointed_thing.under
		node = unode
		iswall = false
	end

	if core.is_protected(pos, placer:get_player_name()) then
		core.record_protection_violation(pos,
				placer:get_player_name())
		return
	end

	local ndef = core.registered_nodes[node.name]
	if not ndef or not ndef.buildable_to then
		return
	end
	return isceiling, pos
end

-- nodebox arithmetics and helpers
-- (please keep non-generic nodeboxes with their node definition)
dofile(homedecor.modpath.."/handlers/nodeboxes.lua")
-- expand and unexpand decor
dofile(homedecor.modpath.."/handlers/expansion.lua")
-- register nodes that cook stuff
dofile(homedecor.modpath.."/handlers/furnaces.lua")
-- glue it all together into a registration function
dofile(homedecor.modpath.."/handlers/registration.lua")

-- load various other components
dofile(homedecor.modpath.."/misc-nodes.lua")					-- the catch-all for all misc nodes
dofile(homedecor.modpath.."/tables.lua")
dofile(homedecor.modpath.."/electronics.lua")
dofile(homedecor.modpath.."/shutters.lua")
dofile(homedecor.modpath.."/shingles.lua")
dofile(homedecor.modpath.."/slopes.lua")

dofile(homedecor.modpath.."/door_models.lua")
dofile(homedecor.modpath.."/doors_and_gates.lua")

dofile(homedecor.modpath.."/fences.lua")

dofile(homedecor.modpath.."/lighting.lua")

dofile(homedecor.modpath.."/kitchen_appliances.lua")
dofile(homedecor.modpath.."/kitchen_furniture.lua")

dofile(homedecor.modpath.."/bathroom_furniture.lua")
dofile(homedecor.modpath.."/bathroom_sanitation.lua")

dofile(homedecor.modpath.."/laundry.lua")

dofile(homedecor.modpath.."/nightstands.lua")
dofile(homedecor.modpath.."/clocks.lua")
dofile(homedecor.modpath.."/misc-electrical.lua")

dofile(homedecor.modpath.."/paintings.lua")
dofile(homedecor.modpath.."/window_treatments.lua")

dofile(homedecor.modpath.."/crafts.lua")

dofile(homedecor.modpath.."/furniture.lua")
dofile(homedecor.modpath.."/furniture_medieval.lua")
dofile(homedecor.modpath.."/furniture_recipes.lua")
dofile(homedecor.modpath.."/climate-control.lua")

dofile(homedecor.modpath.."/cobweb.lua")

dofile(homedecor.modpath.."/handlers/locked.lua")

print("[HomeDecor] "..S("Loaded!"))
