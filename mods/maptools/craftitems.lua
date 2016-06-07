--[[
Map Tools: item definitions

Copyright (c) 2012-2015 Calinou and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

local S = maptools.intllib

maptools.creative = maptools.config["hide_from_creative_inventory"]

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

minetest.register_craft({
	type = "fuel",
	recipe = "maptools:infinitefuel",
	burntime = 1000000000,
})

-- Coin based craft recipes
-- //MFF_BEG(Mg|07/24/15)
-- //MFF_BEG(Darcidride|07/06/16)

--[[
-- 9CC -> 1SC
minetest.register_craft({
	output = "maptools:silver_coin",
	recipe = {
		{"maptools:copper_coin", "maptools:copper_coin", "maptools:copper_coin"},
		{"maptools:copper_coin", "maptools:copper_coin", "maptools:copper_coin"},
		{"maptools:copper_coin", "maptools:copper_coin", "maptools:copper_coin"},
	}
})

-- 9SC -> 1GC
minetest.register_craft({
	output = "maptools:gold_coin",
	recipe = {
		{"maptools:silver_coin", "maptools:silver_coin", "maptools:silver_coin"},
		{"maptools:silver_coin", "maptools:silver_coin", "maptools:silver_coin"},
		{"maptools:silver_coin", "maptools:silver_coin", "maptools:silver_coin"},
	}
})

-- 1GC -> 9SC
minetest.register_craft({
	output = "maptools:silver_coin 9",
	recipe = {
		{"maptools:gold_coin"}
	}
})

-- 1SC -> 9CC
minetest.register_craft({
	output = "maptools:copper_coin 9",
	recipe = {
		{"maptools:silver_coin"}
	}
})

--
-- //MFF_END(Mg|07/24/15)
-- //MFF_END(Darcidride|07/06/16)
--]] 
