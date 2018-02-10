-- support for i18n
local S = plantlife_i18n.gettext
-----------------------------------------------------------------------------------------------
-- Ferns - Crafting 0.0.5
-----------------------------------------------------------------------------------------------
-- (by Mossmanikin)
-- License (everything): 	WTFPL
-----------------------------------------------------------------------------------------------
minetest.register_craft({
	type = "shapeless",
	output = "ferns:fiddlehead 3",
	recipe = {"ferns:fern_01"},
	replacements = {
		{"ferns:fern_01", "ferns:ferntuber"}
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "ferns:fiddlehead 3",
	recipe = {"ferns:tree_fern_leaves"},
	replacements = {
		{"ferns:tree_fern_leaves", "ferns:sapling_tree_fern"}
	},
})
-----------------------------------------------------------------------------------------------
-- FIDDLEHEAD
-----------------------------------------------------------------------------------------------
minetest.register_alias("archaeplantae:fiddlehead",      "ferns:fiddlehead")

minetest.register_craftitem("ferns:fiddlehead", {
	description = S("Fiddlehead"),
	inventory_image = "ferns_fiddlehead.png",
	on_use = minetest.item_eat(-1), -- slightly poisonous when raw
})
minetest.register_craft({
	type = "cooking",
	output = "ferns:fiddlehead_roasted",
	recipe = "ferns:fiddlehead",
	cooktime = 1,
})
minetest.register_craftitem("ferns:fiddlehead_roasted", {
	description = S("Roasted Fiddlehead"),
	inventory_image = "ferns_fiddlehead_roasted.png",
	on_use = minetest.item_eat(1), -- edible when cooked
})
-----------------------------------------------------------------------------------------------
-- FERN TUBER
-----------------------------------------------------------------------------------------------
minetest.register_alias("archaeplantae:ferntuber",      "ferns:ferntuber")

minetest.register_craftitem("ferns:ferntuber", {
	description = S("Fern Tuber"),
	inventory_image = "ferns_ferntuber.png",
})
minetest.register_craft({
	type = "cooking",
	output = "ferns:ferntuber_roasted",
	recipe = "ferns:ferntuber",
	cooktime = 3,
})

minetest.register_alias("archaeplantae:ferntuber_roasted",      "ferns:ferntuber_roasted")

minetest.register_craftitem("ferns:ferntuber_roasted", {
	description = S("Roasted Fern Tuber"),
	inventory_image = "ferns_ferntuber_roasted.png",
	on_use = minetest.item_eat(3),
})
-----------------------------------------------------------------------------------------------
-- HORSETAIL  (EQUISETUM) --> GREEN DYE https://en.wikipedia.org/wiki/Equisetum
-----------------------------------------------------------------------------------------------
minetest.register_craft({
	type = "shapeless",
	output = "dye:green",
	recipe = {"group:horsetail"},
})
-----------------------------------------------------------------------------------------------
-- GLUE WOODEN TOOLS with RESIN & POLISH them with HORSETAIL (planned)
-----------------------------------------------------------------------------------------------
--[[minetest.register_craft({
	type = "shapeless",
	output = "default:pick_wood",
	recipe = {"default:pick_wood","group:horsetail","farming:string","default:stick"},
})
minetest.register_craft({
	type = "shapeless",
	output = "default:shovel_wood",
	recipe = {"default:shovel_wood","group:horsetail","farming:string","default:stick"},
})
minetest.register_craft({
	type = "shapeless",
	output = "default:axe_wood",
	recipe = {"default:axe_wood","group:horsetail","farming:string","default:stick"},
})
minetest.register_craft({
	type = "shapeless",
	output = "default:sword_wood",
	recipe = {"default:sword_wood","group:horsetail","farming:string","default:stick"},
})
minetest.register_craft({
	type = "shapeless",
	output = "farming:hoe_wood",
	recipe = {"farming:hoe_wood","group:horsetail","farming:string","default:stick"},
})]]
