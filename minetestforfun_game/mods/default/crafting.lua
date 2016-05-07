-- mods/default/crafting.lua

minetest.register_craft({
	output = 'default:wood 9',
	recipe = {
		{'default:tree'},
	}
})

minetest.register_craft({
	output = 'default:cherry_plank 6',
	recipe = {
		{'default:cherry_log'},
	}
})

minetest.register_craft({
	output = 'default:junglewood 4',
	recipe = {
		{'default:jungletree'},
	}
})

minetest.register_craft({
	output = 'default:pine_wood 4',
	recipe = {
		{'default:pine_tree'},
	}
})

minetest.register_craft({
	output = 'default:acacia_wood 4',
	recipe = {
		{'default:acacia_tree'},
	}
})

minetest.register_craft({
	output = 'default:aspen_wood 4',
	recipe = {
		{'default:aspen_tree'},
	}
})

minetest.register_craft({
	output = 'default:stick 9',
	recipe = {
		{'group:wood'},
	}
})

minetest.register_craft({
	output = 'default:sign_wall_steel 3',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:sign_wall_wood 3',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:torch 4',
	recipe = {
		{'default:coal_lump'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:pick_wood',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_stone',
	recipe = {
		{'group:stone', 'group:stone', 'group:stone'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_steel',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_bronze',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_silver',
	recipe = {
		{'default:silver_ingot', 'default:silver_ingot', 'default:silver_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_gold',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_mese',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_mithril',
	recipe = {
		{'default:mithril_ingot', 'default:mithril_ingot', 'default:mithril_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_diamond',
	recipe = {
		{'default:diamond', 'default:diamond', 'default:diamond'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_nyan',
	recipe = {
		{'default:nyancat', 'default:nyancat', 'default:nyancat'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:shovel_wood',
	recipe = {
		{'group:wood'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_stone',
	recipe = {
		{'group:stone'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_steel',
	recipe = {
		{'default:steel_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_bronze',
	recipe = {
		{'default:bronze_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_silver',
	recipe = {
		{'default:silver_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_gold',
	recipe = {
		{'default:gold_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_mese',
	recipe = {
		{'default:mese_crystal'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_mithril',
	recipe = {
		{'default:mithril_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_diamond',
	recipe = {
		{'default:diamond'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = "default:shovel_nyan",
	recipe = {
		{"default:nyancat"},
		{"group:stick"},
		{"group:stick"},
	}
})

minetest.register_craft({
	output = 'default:axe_wood',
	recipe = {
		{'group:wood', 'group:wood'},
		{'group:wood', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_stone',
	recipe = {
		{'group:stone', 'group:stone'},
		{'group:stone', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_steel',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_bronze',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot'},
		{'default:bronze_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_silver',
	recipe = {
		{'default:silver_ingot', 'default:silver_ingot'},
		{'default:silver_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = "default:axe_gold",
	recipe = {
		{"default:gold_ingot", "default:gold_ingot"},
		{"default:gold_ingot", "group:stick"},
		{"", "group:stick"},
	}
})

minetest.register_craft({
	output = 'default:axe_mese',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_mithril',
	recipe = {
		{'default:mithril_ingot', 'default:mithril_ingot'},
		{'default:mithril_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_diamond',
	recipe = {
		{'default:diamond', 'default:diamond'},
		{'default:diamond', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = "default:axe_nyan",
	recipe = {
		{"default:nyancat", "default:nyancat"},
		{"default:nyancat", "group:stick"},
		{"", "group:stick"},
	}
})

minetest.register_craft({
	output = 'default:axe_wood',
	recipe = {
		{'group:wood', 'group:wood'},
		{'group:stick', 'group:wood'},
		{'group:stick',''},
	}
})

minetest.register_craft({
	output = 'default:axe_stone',
	recipe = {
		{'group:stone', 'group:stone'},
		{'group:stick', 'group:stone'},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_steel',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot'},
		{'group:stick', 'default:steel_ingot'},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_bronze',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot'},
		{'group:stick', 'default:bronze_ingot'},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_silver',
	recipe = {
		{'default:silver_ingot', 'default:silver_ingot'},
		{'group:stick', 'default:silver_ingot'},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_gold',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot'},
		{'group:stick', 'default:gold_ingot'},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_mese',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal'},
		{'group:stick', 'default:mese_crystal'},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_mithril',
	recipe = {
		{'default:mithril_ingot', 'default:mithril_ingot'},
		{'group:stick', 'default:mithril_ingot'},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_diamond',
	recipe = {
		{'default:diamond', 'default:diamond'},
		{'group:stick', 'default:diamond'},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_nyan',
	recipe = {
		{'default:nyancat', 'default:nyancat'},
		{'group:stick', 'default:nyancat'},
		{'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:sword_wood',
	recipe = {
		{'group:wood'},
		{'group:wood'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_stone',
	recipe = {
		{'group:stone'},
		{'group:stone'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_steel',
	recipe = {
		{'default:steel_ingot'},
		{'default:steel_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_bronze',
	recipe = {
		{'default:bronze_ingot'},
		{'default:bronze_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_silver',
	recipe = {
		{'default:silver_ingot'},
		{'default:silver_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = "default:sword_gold",
	recipe = {
		{"default:gold_ingot"},
		{"default:gold_ingot"},
		{"group:stick"},
	}
})

minetest.register_craft({
	output = 'default:sword_mese',
	recipe = {
		{'default:mese_crystal'},
		{'default:mese_crystal'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_mithril',
	recipe = {
		{'default:mithril_ingot'},
		{'default:mithril_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_diamond',
	recipe = {
		{'default:diamond'},
		{'default:diamond'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = "default:sword_nyan",
	recipe = {
		{"default:nyancat"},
		{"default:nyancat"},
		{"group:stick"},
	}
})


minetest.register_craft({ 			-- Ultimate Warrior weapon
	output = 'default:dungeon_master_s_blood_sword',
	recipe = {
		{"mobs:dungeon_master_blood", "nether:white", "mobs:dungeon_master_blood"},
		{"mobs:dungeon_master_blood", "mobs:dungeon_master_diamond", "mobs:dungeon_master_blood"},
		{"moreores:mithril_block", "mobs:zombie_tibia", "moreores:mithril_block"},
	}
})

minetest.register_craft({
	output = 'default:rail 24',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'group:stick', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'default:chest',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', '', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'default:chest_locked',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', 'group:ingot', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "default:chest_locked",
	recipe = {"default:chest", "group:ingot"},
})

minetest.register_craft({
	output = 'default:furnace',
	recipe = {
		{'group:stone', 'group:stone', 'group:stone'},
		{'group:stone', '', 'group:stone'},
		{'group:stone', 'group:stone', 'group:stone'},
	}
})

minetest.register_craft({
	output = "default:furnace_locked",
	recipe = {
		{"group:stone", "group:stone", "group:stone"},
		{"group:stone", "group:ingot", "group:stone"},
		{"group:stone", "group:stone", "group:stone"},
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "default:furnace_locked",
	recipe = {"default:furnace", "group:ingot"},
})

minetest.register_craft({
	type = "shapeless",
	output = "default:bronze_ingot",
	recipe = {"default:steel_ingot", "default:copper_ingot"},
})

minetest.register_craft({
	type = "shapeless",
	output = "default:bronze_ingot 3",
	recipe = {
		"default:tin_ingot",
		"default:copper_ingot",
		"default:copper_ingot",
	}
})

minetest.register_craft({
	output = 'default:coalblock',
	recipe = {
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'default:coal_lump 9',
	recipe = {
		{'default:coalblock'},
	}
})

minetest.register_craft({
	output = 'default:steelblock',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'default:steel_ingot 9',
	recipe = {
		{'default:steelblock'},
	}
})

minetest.register_craft({
	output = 'default:copperblock',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
	}
})

minetest.register_craft({
	output = 'default:copper_ingot 9',
	recipe = {
		{'default:copperblock'},
	}
})

minetest.register_craft({
	output = 'default:tinblock',
	recipe = {
		{'default:tin_ingot', 'default:tin_ingot', 'default:tin_ingot'},
		{'default:tin_ingot', 'default:tin_ingot', 'default:tin_ingot'},
		{'default:tin_ingot', 'default:tin_ingot', 'default:tin_ingot'},
	}
})

minetest.register_craft({
	output = 'default:tin_ingot 9',
	recipe = {
		{'default:tinblock'},
	}
})


minetest.register_craft({
	output = 'default:bronzeblock',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
	}
})

minetest.register_craft({
	output = 'default:bronze_ingot 9',
	recipe = {
		{'default:bronzeblock'},
	}
})

minetest.register_craft({
	output = 'default:silverblock',
	recipe = {
		{'default:silver_ingot', 'default:silver_ingot', 'default:silver_ingot'},
		{'default:silver_ingot', 'default:silver_ingot', 'default:silver_ingot'},
		{'default:silver_ingot', 'default:silver_ingot', 'default:silver_ingot'},
	}
})

minetest.register_craft({
	output = 'default:silver_ingot 9',
	recipe = {
		{'default:silverblock'},
	}
})

minetest.register_craft({
	output = 'default:goldblock',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
	}
})

minetest.register_craft({
	output = 'default:mithrilblock',
	recipe = {
		{'default:mithril_ingot', 'default:mithril_ingot', 'default:mithril_ingot'},
		{'default:mithril_ingot', 'default:mithril_ingot', 'default:mithril_ingot'},
		{'default:mithril_ingot', 'default:mithril_ingot', 'default:mithril_ingot'},
	}
})

minetest.register_craft({
	output = 'default:mithril_ingot 9',
	recipe = {
		{'default:mithrilblock'},
	}
})

minetest.register_craft({
	output = 'default:gold_ingot 9',
	recipe = {
		{'default:goldblock'},
	}
})

minetest.register_craft({
	output = 'default:diamondblock',
	recipe = {
		{'default:diamond', 'default:diamond', 'default:diamond'},
		{'default:diamond', 'default:diamond', 'default:diamond'},
		{'default:diamond', 'default:diamond', 'default:diamond'},
	}
})

minetest.register_craft({
	output = 'default:diamond 9',
	recipe = {
		{'default:diamondblock'},
	}
})

minetest.register_craft({
	output = 'default:sandstone 2',
	recipe = {
		{'default:sand', 'default:sand'},
		{'default:sand', 'default:sand'},
	}
})

minetest.register_craft({
	output = 'default:sand 4',
	recipe = {
		{'default:sandstone'},
	}
})

minetest.register_craft({
	output = 'default:sandstonebrick 4',
	recipe = {
		{'default:sandstone', 'default:sandstone'},
		{'default:sandstone', 'default:sandstone'},
	}
})


minetest.register_craft({
	output = "default:desert_sand",
	recipe = {
		{"default:sand"},
	}
})

minetest.register_craft({
	output = 'default:clay',
	recipe = {
		{'default:clay_lump', 'default:clay_lump'},
		{'default:clay_lump', 'default:clay_lump'},
	}
})

minetest.register_craft({
	output = 'default:clay_lump 4',
	recipe = {
		{'default:clay'},
	}
})

minetest.register_craft({
	output = 'default:brick',
	recipe = {
		{'default:clay_brick', 'default:clay_brick'},
		{'default:clay_brick', 'default:clay_brick'},
	}
})

minetest.register_craft({
	output = 'default:clay_brick 4',
	recipe = {
		{'default:brick'},
	}
})

minetest.register_craft({
	output = 'default:paper',
	recipe = {
		{'default:papyrus', 'default:papyrus', 'default:papyrus'},
	}
})

minetest.register_craft({
	output = 'default:book',
	recipe = {
		{'default:paper'},
		{'default:paper'},
		{'default:paper'},
	}
})

minetest.register_craft({
	output = 'default:bookshelf',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'default:book', 'default:book', 'default:book'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'default:ladder_wood 3',
	recipe = {
		{'group:stick', '', 'group:stick'},
		{'group:stick', 'group:stick', 'group:stick'},
		{'group:stick', '', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:ladder_steel 15',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'default:mese',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'default:mese_crystal 9',
	recipe = {
		{'default:mese'},
	}
})

minetest.register_craft({
	output = 'default:mese_crystal_fragment 9',
	recipe = {
		{'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = "default:sand",
	recipe = {
		{"default:gravel"},
	}
})

minetest.register_craft({
	output = "default:dirt 4",
	type = "shapeless",
	recipe = {"default:gravel", "default:gravel", "default:gravel", "default:gravel"}
})

minetest.register_craft({
	output = "default:gravel",
	recipe = {
		{"default:cobble"},
	}
})

minetest.register_craft({
	output = "default:desert_stone 2",
	recipe = {
		{"default:desert_sand", "default:desert_sand"},
		{"default:desert_sand", "default:desert_sand"},
	}
})


minetest.register_craft({
	output = 'default:meselamp 1',
	recipe = {
		{'', 'default:mese_crystal',''},
		{'default:mese_crystal', 'default:glass', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'default:obsidian_shard 9',
	recipe = {
		{'default:obsidian'}
	}
})

minetest.register_craft({
	output = 'default:obsidian',
	recipe = {
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
	}
})

minetest.register_craft({
	output = 'default:obsidianbrick 4',
	recipe = {
		{'default:obsidian', 'default:obsidian'},
		{'default:obsidian', 'default:obsidian'}
	}
})

minetest.register_craft({
	output = "default:ladder_obsidian 4",
	recipe = {
		{"default:obsidianbrick", "", "default:obsidianbrick"},
		{"default:obsidianbrick", "default:obsidianbrick", "default:obsidianbrick"},
		{"default:obsidianbrick", "", "default:obsidianbrick"}
	}
})

minetest.register_craft({
	output = 'default:stonebrick 4',
	recipe = {
		{'default:stone', 'default:stone'},
		{'default:stone', 'default:stone'},
	}
})

minetest.register_craft({
	output = 'default:desert_stonebrick 4',
	recipe = {
		{'default:desert_stone', 'default:desert_stone'},
		{'default:desert_stone', 'default:desert_stone'},
	}
})

minetest.register_craft({
	output = 'default:snowblock',
	recipe = {
		{'default:snow', 'default:snow', 'default:snow'},
		{'default:snow', 'default:snow', 'default:snow'},
		{'default:snow', 'default:snow', 'default:snow'},
	}
})

minetest.register_craft({
	output = 'default:snow 9',
	recipe = {
		{'default:snowblock'},
	}
})

minetest.register_craft({
	output = "maptools:superapple",
	type = "shapeless",
	recipe = {"default:apple", "default:mese", "default:mese"},
})

--
-- Crafting (tool repair)
--
minetest.register_craft({
	type = "toolrepair",
	additional_wear = -0.02,
})

--
-- Cooking recipes
--

minetest.register_craft({
	type = "cooking",
	output = "default:glass",
	recipe = "group:sand",
})

minetest.register_craft({
	type = "cooking",
	output = "default:obsidian_glass",
	recipe = "default:obsidian_shard",
})

minetest.register_craft({
	type = "cooking",
	output = "default:stone",
	recipe = "default:cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "default:stone",
	recipe = "default:mossycobble",
})

minetest.register_craft({
	type = "cooking",
	output = "default:desert_stone",
	recipe = "default:desert_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "default:iron_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "default:copper_ingot",
	recipe = "default:copper_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "default:tin_ingot",
	recipe = "default:tin_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "default:silver_ingot",
	recipe = "default:silver_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "default:gold_ingot",
	recipe = "default:gold_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "default:mithril_ingot",
	recipe = "default:mithril_lump",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 2, -- //MFF(Mg|07/24/15)
	output = "default:clay_brick",
	recipe = "default:clay_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "default:clay_burned",
	recipe = "default:clay",
})

--
-- Fuels
--

minetest.register_craft({
	type = "fuel",
	recipe = "group:tree",
	burntime = 40,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:stick",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:junglegrass",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:leaves",
	burntime = 4,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:cactus",
	burntime = 20,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:papyrus",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:bookshelf",
	burntime = 50,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_wood",
	burntime = 4,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_acacia_wood",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_junglewood",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_pine_wood",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_aspen_wood",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:ladder_wood",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:wood",
	burntime = 10,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:lava_source",
	burntime = 80,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:torch",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:sign_wall_wood",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:chest",
	burntime = 80,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:chest_locked",
	burntime = 85,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:nyancat",
	burntime = 7200,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:nyancat_rainbow",
	burntime = 1200,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:sapling",
	burntime = 10,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:apple",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:coal_lump",
	burntime = 40,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:coalblock",
	burntime = 370,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:grass_1",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:dry_grass_1",
	burntime = 2,
})

