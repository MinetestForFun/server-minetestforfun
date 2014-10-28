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
if homedecor.intllib_modpath then
    dofile(homedecor.intllib_modpath.."/intllib.lua")
    S = intllib.Getter(minetest.get_current_modname())
else
    S = function ( s ) return s end
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

-- 

function homedecor.get_nodedef_field(nodename, fieldname)
	if not minetest.registered_nodes[nodename] then
		return nil
	end
	return minetest.registered_nodes[nodename][fieldname]
end

-- Stack one node above another

function homedecor.stack_vertically(itemstack, placer, pointed_thing, node1, node2)
	local pos = pointed_thing.under
	local pnode = minetest.get_node(pointed_thing.under)
	local rnodedef = minetest.registered_nodes[pnode.name]

	if not rnodedef["buildable_to"] then
		pos = pointed_thing.above
	end

	local fdir = minetest.dir_to_facedir(placer:get_look_dir())
	local pos2 = { x = pos.x, y=pos.y + 1, z = pos.z }

	local tnode = minetest.get_node(pos)
	local tnode2 = minetest.get_node(pos2)

	if homedecor.get_nodedef_field(tnode.name, "buildable_to")
	  and homedecor.get_nodedef_field(tnode2.name, "buildable_to")
	  and not minetest.is_protected(pos, placer:get_player_name())
	  and not minetest.is_protected(pos2, placer:get_player_name()) then
		minetest.add_node(pos, { name = node1, param2 = fdir })
		minetest.add_node(pos2, { name = node2, param2 = fdir })
		if not homedecor.expect_infinite_stacks then
			itemstack:take_item()
			return itemstack
		end
	end
end

-- Place one node right of or behind another

homedecor.fdir_to_right = {
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
	{  0,  1 },
}

homedecor.fdir_to_fwd = {
	{  0,  1 },
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
}

function homedecor.stack_sideways(itemstack, placer, pointed_thing, node1, node2, dir)
	local pos = pointed_thing.under
	local pnode = minetest.get_node(pointed_thing.under)
	local rnodedef = minetest.registered_nodes[pnode.name]

	if not rnodedef["buildable_to"] then
		pos = pointed_thing.above
	end

	local fdir = minetest.dir_to_facedir(placer:get_look_dir())
	local pos2
	if dir then
		pos2 = { x = pos.x + homedecor.fdir_to_right[fdir+1][1], y=pos.y, z = pos.z + homedecor.fdir_to_right[fdir+1][2] }
	else
		pos2 = { x = pos.x + homedecor.fdir_to_fwd[fdir+1][1], y=pos.y, z = pos.z + homedecor.fdir_to_fwd[fdir+1][2] }
	end

	local tnode = minetest.get_node(pos)
	local tnode2 = minetest.get_node(pos2)

	if homedecor.get_nodedef_field(tnode.name, "buildable_to")
	  and homedecor.get_nodedef_field(tnode2.name, "buildable_to")
	  and not minetest.is_protected(pos, placer:get_player_name())
	  and not minetest.is_protected(pos2, placer:get_player_name()) then
		minetest.add_node(pos, { name = node1, param2 = fdir })
		minetest.add_node(pos2, { name = node2, param2 = fdir })
		if not homedecor.expect_infinite_stacks then
			itemstack:take_item()
			return itemstack
		end
	end
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
dofile(homedecor.modpath.."/kitchen_cabinet.lua")
dofile(homedecor.modpath.."/refrigerator.lua")

dofile(homedecor.modpath.."/misc-bathroom.lua")

dofile(homedecor.modpath.."/laundry.lua")

dofile(homedecor.modpath.."/furnaces.lua")
dofile(homedecor.modpath.."/nightstands.lua")
dofile(homedecor.modpath.."/clocks.lua")
dofile(homedecor.modpath.."/misc-electrical.lua")

dofile(homedecor.modpath.."/paintings.lua")
dofile(homedecor.modpath.."/window_treatments.lua")

dofile(homedecor.modpath.."/crafts.lua")

dofile(homedecor.modpath.."/furniture.lua")
dofile(homedecor.modpath.."/furniture_medieval.lua")
dofile(homedecor.modpath.."/furniture_bathroom.lua")
dofile(homedecor.modpath.."/furniture_recipes.lua")
dofile(homedecor.modpath.."/climate-control.lua")

dofile(homedecor.modpath.."/cobweb.lua")

dofile(homedecor.modpath.."/locked.lua")



print("[HomeDecor] "..S("Loaded!"))
