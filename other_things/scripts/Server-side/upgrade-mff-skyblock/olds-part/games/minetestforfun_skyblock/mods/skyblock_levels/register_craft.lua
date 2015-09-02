--[[

Skyblock for Minetest

Copyright (c) 2015 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-skyblock
License: GPLv3

]]--


-- desert_stone
minetest.register_craft({
	output = 'default:desert_stone',
	recipe = {
		{'default:desert_sand', 'default:desert_sand'},
		{'default:desert_sand', 'default:desert_sand'},
	}
})

-- mossycobble
minetest.register_craft({
	output = 'default:mossycobble',
	recipe = {
		{'group:flora'},
		{'default:cobble'},
	}
})

-- stone_with_coal
minetest.register_craft({
	output = 'default:stone_with_coal 2',
	recipe = {
		{'default:coal_lump'},
		{'default:stone'},
	}
})

-- stone_with_iron
minetest.register_craft({
	output = 'default:stone_with_iron 2',
	recipe = {
		{'default:iron_lump'},
		{'default:stone'},
	}
})

-- stone_with_copper
minetest.register_craft({
	output = 'default:stone_with_copper 2',
	recipe = {
		{'default:copper_lump'},
		{'default:stone'},
	}
})

-- stone_with_gold
minetest.register_craft({
	output = 'default:stone_with_gold 2',
	recipe = {
		{'default:gold_lump'},
		{'default:stone'},
	}
})

-- stone_with_mese
minetest.register_craft({
	output = 'default:stone_with_mese 2',
	recipe = {
		{'default:mese_crystal'},
		{'default:stone'},
	}
})

-- stone_with_diamond
minetest.register_craft({
	output = 'default:stone_with_diamond 2',
	recipe = {
		{'default:diamond'},
		{'default:stone'},
	}
})

-- obsidian
minetest.register_craft({
	output = 'default:obsidian 2',
	recipe = {
		{'default:obsidian_shard'},
		{'default:stone'},
	}
})

-- sand
minetest.register_craft({
	output = 'default:sand 4',
	recipe = {
		{'default:obsidian_shard'},
	}
})

-- cobble
minetest.register_craft({
	type = 'cooking',
	output = 'default:cobble 2',
	recipe = 'default:dirt',
})

-- gravel
minetest.register_craft({
	output = 'default:gravel 2',
	recipe = {
		{'default:cobble'},
	}
})

-- dirt
minetest.register_craft({
	output = 'default:dirt 2',
	recipe = {
		{'default:gravel'},
	}
})

-- clay_lump
minetest.register_craft({
	output = 'default:clay_lump 4',
	recipe = {
		{'default:dirt'},
	}
})

-- locked_chest from chest
minetest.register_craft({
	output = 'default:chest_locked',
	recipe = {
		{'default:steel_ingot'},
		{'default:chest'},
	}
})

-- sapling from leaves and sticks
minetest.register_craft({
	output = 'default:sapling',
	recipe = {
		{'default:leaves', 'default:leaves', 'default:leaves'},
		{'default:leaves', 'default:leaves', 'default:leaves'},
		{'', 'default:stick', ''},
	}
})

-- junglesapling from jungleleaves and sticks
minetest.register_craft({
	output = 'default:junglesapling',
	recipe = {
		{'default:jungleleaves', 'default:jungleleaves', 'default:jungleleaves'},
		{'default:jungleleaves', 'default:jungleleaves', 'default:jungleleaves'},
		{'', 'default:stick', ''},
	}
})

-- pine_sapling from pine_needles and sticks
minetest.register_craft({
	output = 'default:pine_sapling',
	recipe = {
		{'default:pine_needles', 'default:pine_needles', 'default:pine_needles'},
		{'default:pine_needles', 'default:pine_needles', 'default:pine_needles'},
		{'', 'default:stick', ''},
	}
})

-- desert_cobble from dirt and gravel
minetest.register_craft({
	output = 'default:desert_cobble 2',
	recipe = {
		{'default:dirt'},
		{'default:gravel'},
	}
})

-- desert_sand from desert_stone
minetest.register_craft({
	output = 'default:desert_sand 4',
	recipe = {
		{'default:desert_stone'},
	}
})

-- snowblock from bucket_water
minetest.register_craft({
	output = 'default:ice',
	recipe = {
		{'bucket:bucket_water'},
	}
})

-- ice from snowblock
minetest.register_craft({
	output = 'default:ice',
	recipe = {
		{'default:snowblock', 'default:snowblock'},
		{'default:snowblock', 'default:snowblock'},
	}
})

-- snowblock from ice
minetest.register_craft({
	output = 'default:snowblock 4',
	recipe = {
		{'default:ice'},
	}
})

-- glass from desert_sand
minetest.register_craft({
	type = 'cooking',
	output = 'default:glass',
	recipe = 'default:desert_sand',
})

