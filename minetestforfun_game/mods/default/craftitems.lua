-- mods/default/craftitems.lua

minetest.register_craftitem("default:stick", {
	description = "Stick",
	stack_max = 1000,
	inventory_image = "default_stick.png",
	wield_image = "default_stick.png^[transformR90",
	groups = {stick = 1},
})

minetest.register_craftitem("default:paper", {
	description = "Paper",
	wield_scale = {x = 1, y = 1, z = 0.25},
	inventory_image = "default_paper.png",
})

minetest.register_craftitem("default:book", {
	description = "Book",
	inventory_image = "default_book.png",
})

minetest.register_craftitem("default:coal_lump", {
	description = "Coal Lump",
	wield_scale = {x = 1, y = 1, z = 2},
	inventory_image = "default_coal_lump.png",
})

minetest.register_craftitem("default:iron_lump", {
	description = "Iron Lump",
	wield_scale = {x = 1, y = 1, z = 2},
	inventory_image = "default_iron_lump.png",
	groups = {ingot_lump = 1},
})

minetest.register_craftitem("default:copper_lump", {
	description = "Copper Lump",
	wield_scale = {x = 1, y = 1, z = 2},
	inventory_image = "default_copper_lump.png",
	groups = {ingot_lump = 1},
})

minetest.register_craftitem("default:mese_crystal", {
	description = "Mese Crystal",
	inventory_image = "default_mese_crystal.png",
})

minetest.register_craftitem("default:gold_lump", {
	description = "Gold Lump",
	wield_scale = {x = 1, y = 1, z = 2},
	inventory_image = "default_gold_lump.png",
	groups = {ingot_lump = 1},
})

minetest.register_craftitem("default:diamond", {
	description = "Diamond",
	inventory_image = "default_diamond.png",
})

minetest.register_craftitem("default:clay_lump", {
	description = "Clay Lump",
	stack_max = 200,
	wield_scale = {x = 1, y = 1, z = 2},
	inventory_image = "default_clay_lump.png",
})

minetest.register_craftitem("default:steel_ingot", {
	description = "Steel Ingot",
	wield_scale = {x = 1, y = 1, z = 2},
	inventory_image = "default_steel_ingot.png",
	groups = {ingot = 1},
})

minetest.register_craftitem("default:copper_ingot", {
	description = "Copper Ingot",
	wield_scale = {x = 1, y = 1, z = 2},
	inventory_image = "default_copper_ingot.png",
	groups = {ingot = 1},
})

minetest.register_craftitem("default:bronze_ingot", {
	description = "Bronze Ingot",
	wield_scale = {x = 1, y = 1, z = 2},
	inventory_image = "default_bronze_ingot.png",
	groups = {ingot = 1},
})

minetest.register_craftitem("default:gold_ingot", {
	description = "Gold Ingot",
	wield_scale = {x = 1, y = 1, z = 2},
	inventory_image = "default_gold_ingot.png",
	groups = {ingot = 1},
})

minetest.register_craftitem("default:mese_crystal_fragment", {
	description = "Mese Crystal Fragment",
	inventory_image = "default_mese_crystal_fragment.png",
})

minetest.register_craftitem("default:clay_brick", {
	description = "Clay Brick",
	wield_scale = {x = 1, y = 1, z = 2},
	inventory_image = "default_clay_brick.png",
})

minetest.register_craftitem("default:scorched_stuff", {
	description = "Scorched Stuff",
	inventory_image = "default_scorched_stuff.png",
})

minetest.register_craftitem("default:obsidian_shard", {
	description = "Obsidian Shard",
	inventory_image = "default_obsidian_shard.png",
})
