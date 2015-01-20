--[[
=====================================================================
** Map Tools **
By Calinou.

Copyright (c) 2012-2015 Calinou and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
=====================================================================
--]]

maptools = {}

local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end
maptools.intllib = S

local modpath = minetest.get_modpath("maptools")

dofile(modpath .. "/config.lua")
dofile(modpath .. "/aliases.lua")
dofile(modpath .. "/craftitems.lua")
dofile(modpath .. "/default_nodes.lua")
dofile(modpath .. "/nodes.lua")
dofile(modpath .. "/tools.lua")

--[[
Map Tools by Calinou
Licensed under the zlib license for code and CC BY-SA 3.0 for textures, see LICENSE.txt for info.
--]]

-- Redefine cloud so that the admin pickaxe can mine it.

minetest.register_node(":default:cloud", {
	description = S("Cloud"),
	tiles = {"default_cloud.png"},
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = maptools.creative},
	sounds = default.node_sound_defaults(),
})

-- Items

minetest.register_craft({
	type = "fuel",
	recipe = "maptools:infinitefuel",
	burntime = 1000000000,
})

-- Items

minetest.register_craftitem("maptools:copper_coin", {
	description = S("Copper Coin"),
	inventory_image = "maptools_copper_coin.png",
	wield_scale = {x = 0.5, y = 0.5, z = 0.25},
	stack_max = 10000,
	groups = {not_in_creative_inventory = maptools.creative},
})

minetest.register_craftitem("maptools:silver_coin", {
	description = S("Silver Coin"),
	inventory_image = "maptools_silver_coin.png",
	wield_scale = {x = 0.5, y = 0.5, z = 0.25},
	stack_max = 10000,
	groups = {not_in_creative_inventory = maptools.creative},
})

minetest.register_craftitem("maptools:gold_coin", {
	description = S("Gold Coin"),
	inventory_image = "maptools_gold_coin.png",
	wield_scale = {x = 0.5, y = 0.5, z = 0.25},
	stack_max = 10000,
	groups = {not_in_creative_inventory = maptools.creative},
})

minetest.register_craftitem("maptools:infinitefuel", {
	description = S("Infinite Fuel"),
	inventory_image = "maptools_infinitefuel.png",
	stack_max = 10000,
	groups = {not_in_creative_inventory = maptools.creative},
})

minetest.register_on_punchnode(function(pos, node, puncher)
	if puncher:get_wielded_item():get_name() == "maptools:pick_admin"
	and minetest.get_node(pos).name ~= "air" then
		minetest.log("action", puncher:get_player_name() .. " digs " .. minetest.get_node(pos).name .. " at " .. minetest.pos_to_string(pos) .. " using an Admin Pickaxe.")
		minetest.remove_node(pos) -- The node is removed directly, which means it even works on non-empty containers and group-less nodes.
		nodeupdate(pos) -- Run node update actions like falling nodes.
	end
end)

if minetest.setting_getbool("log_mods") then
	minetest.log("action", S("[maptools] loaded."))
end
