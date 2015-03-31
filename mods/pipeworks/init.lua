-- Pipeworks mod by Vanessa Ezekowitz - 2013-07-13
--
-- This mod supplies various steel pipes and plastic pneumatic tubes
-- and devices that they can connect to.
--
-- License: WTFPL
--

pipeworks = {}

local DEBUG = false

pipeworks.worldpath = minetest.get_worldpath()
pipeworks.modpath = minetest.get_modpath("pipeworks")

dofile(pipeworks.modpath.."/default_settings.txt")

-- Read the external config file if it exists.
if io.open(pipeworks.worldpath.."/pipeworks_settings.txt","r") then
	dofile(pipeworks.worldpath.."/pipeworks_settings.txt")
	io.close()
end

-- Random variables

pipeworks.expect_infinite_stacks = true
if minetest.get_modpath("unified_inventory") or not minetest.setting_getbool("creative_mode") then
	pipeworks.expect_infinite_stacks = false
end

pipeworks.meseadjlist={{x=0,y=0,z=1},{x=0,y=0,z=-1},{x=0,y=1,z=0},{x=0,y=-1,z=0},{x=1,y=0,z=0},{x=-1,y=0,z=0}}

pipeworks.rules_all = {{x=0, y=0, z=1},{x=0, y=0, z=-1},{x=1, y=0, z=0},{x=-1, y=0, z=0},
		{x=0, y=1, z=1},{x=0, y=1, z=-1},{x=1, y=1, z=0},{x=-1, y=1, z=0},
		{x=0, y=-1, z=1},{x=0, y=-1, z=-1},{x=1, y=-1, z=0},{x=-1, y=-1, z=0},
		{x=0, y=1, z=0}, {x=0, y=-1, z=0}}

pipeworks.mesecons_rules={{x=0,y=0,z=1},{x=0,y=0,z=-1},{x=1,y=0,z=0},{x=-1,y=0,z=0},{x=0,y=1,z=0},{x=0,y=-1,z=0}}

pipeworks.liquid_texture = "default_water.png"

-- Helper functions

function pipeworks.fix_image_names(table, replacement)
	local outtable={}
	for i in ipairs(table) do
		outtable[i]=string.gsub(table[i], "_XXXXX", replacement)
	end

	return outtable
end

function pipeworks.add_node_box(t, b)
	if not t or not b then return end
	for i in ipairs(b)
		do table.insert(t, b[i])
	end
end

function pipeworks.may_configure(pos, player)
	local name = player:get_player_name()
	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")

	if owner ~= "" then -- wielders and filters
		return owner == name
	end
	return not minetest.is_protected(pos, name)
end

function pipeworks.replace_name(tbl,tr,name)
	local ntbl={}
	for key,i in pairs(tbl) do
		if type(i)=="string" then
			ntbl[key]=string.gsub(i,tr,name)
		elseif type(i)=="table" then
			ntbl[key]=pipeworks.replace_name(i,tr,name)
		else
			ntbl[key]=i
		end
	end
	return ntbl
end

-------------------------------------------
-- Load the various other parts of the mod

dofile(pipeworks.modpath.."/common.lua")
dofile(pipeworks.modpath.."/models.lua")
dofile(pipeworks.modpath.."/autoplace_pipes.lua")
dofile(pipeworks.modpath.."/autoplace_tubes.lua")
dofile(pipeworks.modpath.."/luaentity.lua")
dofile(pipeworks.modpath.."/item_transport.lua")
dofile(pipeworks.modpath.."/flowing_logic.lua")
dofile(pipeworks.modpath.."/crafts.lua")
dofile(pipeworks.modpath.."/tube_registration.lua")
dofile(pipeworks.modpath.."/routing_tubes.lua")
dofile(pipeworks.modpath.."/sorting_tubes.lua")
dofile(pipeworks.modpath.."/vacuum_tubes.lua")
dofile(pipeworks.modpath.."/signal_tubes.lua")
dofile(pipeworks.modpath.."/decorative_tubes.lua")
dofile(pipeworks.modpath.."/filter-injector.lua")
dofile(pipeworks.modpath.."/trashcan.lua")
dofile(pipeworks.modpath.."/wielder.lua")

if pipeworks.enable_pipes then dofile(pipeworks.modpath.."/pipes.lua") end
if pipeworks.enable_teleport_tube then dofile(pipeworks.modpath.."/teleport_tube.lua") end
if pipeworks.enable_pipe_devices then dofile(pipeworks.modpath.."/devices.lua") end
if pipeworks.enable_redefines then dofile(pipeworks.modpath.."/compat.lua") end
if pipeworks.enable_autocrafter then dofile(pipeworks.modpath.."/autocrafter.lua") end

minetest.register_alias("pipeworks:pipe", "pipeworks:pipe_110000_empty")

print("Pipeworks loaded!")

