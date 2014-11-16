dofile(minetest.get_modpath("quartz").."/settings.txt")

--Node Registration

--Quartz Crystal
minetest.register_craftitem("quartz:quartz_crystal", {
	description = "Quartz Crystal",
	inventory_image = "quartz_crystal_full.png",
})
minetest.register_craftitem("quartz:quartz_crystal_piece", {
	description = "Quartz Crystal Piece",
	inventory_image = "quartz_crystal_piece.png",
})

--Ore
minetest.register_node("quartz:quartz_ore", {
         description = "Quartz Ore",
 	 tiles = {"default_stone.png^quartz_ore.png"},
	 groups = {cracky=3, stone=1},
	 drop = 'quartz:quartz_crystal',
         sounds = default.node_sound_stone_defaults(),
})
	 
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "quartz:quartz_ore",
    wherein        = "default:stone",
    clust_scarcity = 10*10*10,
    clust_num_ores = 6,
    clust_size     = 5,
    height_min     = -31000,
    height_max     = -5,
})

--Quartz Block
minetest.register_node("quartz:block", {
	description = "Quartz Block",
	tiles = {"quartz_block.png"},
	groups = {cracky=3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
})

--Chiseled Quartz
minetest.register_node("quartz:chiseled", {
	description = "Chiseled Quartz",
	tiles = {"quartz_chiseled.png"},
	groups = {cracky=3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
})

--Quartz Pillar
minetest.register_node("quartz:pillar", {
	description = "Quartz Pillar",
	paramtype2 = "facedir",
	tiles = {"quartz_pillar_top.png", "quartz_pillar_top.png", "quartz_pillar_side.png"},
	groups = {cracky=3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
	on_place = minetest.rotate_node
})


--Stairs & Slabs
stairs.register_stair_and_slab("quartzblock", "quartz:block",
		{cracky=3, oddly_breakable_by_hand=1},
		{"quartz_block.png"},
		"Quartz stair",
		"Quartz slab",
		default.node_sound_glass_defaults())

stairs.register_slab("quartzstair", "quartz:pillar",
		{cracky=3, oddly_breakable_by_hand=1},
		{"quartz_pillar_top.png", "quartz_pillar_top.png", "quartz_pillar_side.png"},
		"Quartz Pillar stair",
		"Quartz Pillar slab",
		default.node_sound_glass_defaults())		

		
		
		
		
		
		
--Crafting

--Quartz Crystal Piece
minetest.register_craft({
	output = '"quartz:quartz_crystal_piece" 3',
	recipe = {
		{'quartz:quartz_crystal'}
	}
})

--Quartz Block
minetest.register_craft({
	output = '"quartz:block" 4',
	recipe = {
		{'quartz:quartz_crystal', 'quartz:quartz_crystal', ''},
		{'quartz:quartz_crystal', 'quartz:quartz_crystal', ''},
		{'', '', ''}
	}
})
	
--Chiseled Quartz
minetest.register_craft({
	output = 'quartz:chiseled 2',
	recipe = {
		{'stairs:slab_quartzblock', '', ''},
		{'stairs:slab_quartzblock', '', ''},
		{'', '', ''},
	}
})

--Chiseled Quartz(for stairsplus)
minetest.register_craft({
	output = 'quartz:chiseled 2',
	recipe = {
		{'quartz:slab_block', '', ''},
		{'quartz:slab_block', '', ''},
		{'', '', ''},
	}
})

--Quartz Pillar
minetest.register_craft({
	output = 'quartz:pillar 2',
	recipe = {
		{'quartz:block', '', ''},
		{'quartz:block', '', ''},
		{'', '', ''},
	}
})

--abms
local dirs2 = { 12, 9, 18, 7, 12 }

minetest.register_abm({
	nodenames = { "quartz:pillar_horizontal" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local fdir = node.param2 or 0
			nfdir = dirs2[fdir+1]
		minetest.add_node(pos, {name = "quartz:pillar", param2 = nfdir})
	end,
})

--These are deprecated, don't use them

if enable_horizontal_pillar then
	--Quartz Pillar (horizontal)
	minetest.register_node("quartz:pillar_horizontal", {
			description = "Quartz Pillar Horizontal",
			tiles = {"quartz_pillar_side.png", "quartz_pillar_side.png", "quartz_pillar_side.png^[transformR90",
			"quartz_pillar_side.png^[transformR90", "quartz_pillar_top.png", "quartz_pillar_top.png"},
			paramtype2 = "facedir",
			drop = 'quartz:pillar',
			groups = {cracky=3, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
			sounds = default.node_sound_glass_defaults(),
	})
end


--Compatibility with stairsplus

if minetest.get_modpath("moreblocks") and enable_stairsplus then
	register_stair_slab_panel_micro("quartz", "block", "quartz:block",
	{cracky=3},
	{"quartz_block.png"},
	"Quartz Block",
	"block",
	0)
	
	register_stair_slab_panel_micro("quartz", "chiseled", "quartz:chiseled",
	{cracky=3},
	{"quartz_chiseled.png"},
	"Chiseled Quartz",
	"chiseled",
	0)
	
	register_stair_slab_panel_micro("quartz", "pillar", "quartz:pillar",
	{cracky=3},
	{"quartz_pillar_top.png", "quartz_pillar_top.png", "quartz_pillar_side.png"},
	"Quartz Pillar",
	"pillar",
	0)
	
	table.insert(circular_saw.known_stairs, "quartz:block")
	table.insert(circular_saw.known_stairs, "quartz:chiseled")
	table.insert(circular_saw.known_stairs, "quartz:pillar")
end	
