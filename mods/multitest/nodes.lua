-- nodes
minetest.register_node("multitest:rubberblock", {
    description = "Rubber Block",
	tiles = {"multitest_rubberblock.png"},
	groups = {oddly_breakable_by_hand=5,crumbly=3},
})

minetest.register_node("multitest:blackstone", {
    description = "Blackstone",
	tiles = {"multitest_blackstone.png"},
	groups = {cracky=3, stone=1},
	drop = 'multitest:blackcobble',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("multitest:blackcobble", {
    description = "Black Cobblestone",
	tiles = {"multitest_blackcobble.png"},
	groups = {cracky=2, stone=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("multitest:blackstone_paved", {
    description = "Paved Blackstone",
	tiles = {"multitest_blackstone_paved.png"},
	groups = {cracky=2, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("multitest:blackstone_paved", {
    description = "Paved Blackstone",
	tiles = {"multitest_blackstone_paved.png"},
	groups = {cracky=2, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("multitest:blackstone_brick", {
    description = "Blackstone Bricks",
	tiles = {"multitest_blackstone_brick.png"},
	groups = {cracky=2, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

--[[ maintenant dans farming redo
minetest.register_node("multitest:hayblock", {
	description = "Hay Bale",
	tiles = {"multitest_hayblock_top.png", "multitest_hayblock_top.png", "multitest_hayblock.png"},
	paramtype2 = "facedir",
	groups = {snappy=1,flammable=2,crumbly=1,cracky=4,oddly_breakable_by_hand=2},
	sounds = default.node_sound_sand_defaults(),
	on_place = minetest.rotate_node
})
--]]

minetest.register_node("multitest:checkered_floor", {
    description = "Checkered Floor",
	tiles = {"multitest_checkered_floor.png"},
	groups = {cracky=2, oddly_breakable_by_hand=4},
	sounds = default.node_sound_stone_defaults(),
})

--[[
minetest.register_node("multitest:lamp", {
	description = "Lamp",
	tiles = {"multitest_lamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	light_source = LIGHT_MAX-1,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})
]]
minetest.register_alias("multitest:lamp", "lantern:lantern")

minetest.register_node("multitest:andesite", {
	description = "Andesite",
	tiles = {"multitest_andesite.png"},
	groups = {cracky=3,},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("multitest:diorite", {
	description = "Diorite",
	tiles = {"multitest_diorite.png"},
	groups = {cracky=3,},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("multitest:granite", {
	description = "Granite",
	tiles = {"multitest_granite.png"},
	groups = {cracky=3,},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("multitest:andesite_smooth", {
	description = "Smooth Andesite",
	tiles = {"multitest_andesite_smooth.png"},
	groups = {cracky=3,},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("multitest:diorite_smooth", {
	description = "Smooth Diorite",
	tiles = {"multitest_diorite_smooth.png"},
	groups = {cracky=3,},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("multitest:granite_smooth", {
	description = "Smooth Granite",
	tiles = {"multitest_granite_smooth.png"},
	groups = {cracky=3,},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("multitest:sandstone_carved", {
	description = "Carved Sandstone",
	tiles = {"multitest_sandstone_carved_top.png", "multitest_sandstone_carved_top.png", "multitest_sandstone_carved.png"},
	groups = {crumbly=2,cracky=4,},
	sounds = default.node_sound_sand_defaults(),
})

-- stairs:stair_blackstone
stairs.register_stair_and_slab("blackstone", "multitest:blackstone",
	{cracky=3, stone=1},
	{"multitest_blackstone.png"},
	"Blackstone Stairs",
	"Blackstone Slab", nil)

stairs.register_stair_and_slab("blackcobble", "multitest:blackcobble",
	{cracky=3, stone=1},
	{"multitest_blackcobble.png"},
	"Black Cobble Stairs",
	"Black Cobble Slab", nil)

stairs.register_stair_and_slab("blackstone_bricks", "multitest:blackstone_brick",
	{cracky=3, stone=1},
	{"multitest_blackstone_brick.png"},
	"Blackstonestone brick Stairs",
	"Blackstone Brick Slab", nil)

stairs.register_stair_and_slab("blackstone_paved", "multitest:blackstone_paved",
	{cracky=3, stone=1},
	{"multitest_blackstone_paved.png"},
	"Paved Blackstone Stairs",
	"Paved Blackstone Slab", nil)

-- others
for i, v in ipairs(multitest.colors) do
	minetest.register_node("multitest:carpet_"..v, {
		tiles = {"wool_"..v..".png"},
		description = multitest.colornames[i].."Carpet",
		groups = {oddly_breakable_by_hand=2,flammable=3},
		drawtype="nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
			}
		}
	})
end

minetest.register_node("multitest:door_mat", {
	description = "Door Mat",
	tiles = {"multitest_door_mat.png"},
	inventory_image = "multitest_door_mat.png",
	wield_image = "multitest_door_mat.png",
	groups = {oddly_breakable_by_hand=2,flammable=3},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.363675, 0.5, -0.454674, 0.426703},
		}
	}
})

minetest.register_node("multitest:sponge_block", {
	description = "Sponge Block (Decorative)",
	tiles = {"multitest_sponge_block.png"},
	groups = {oddly_breakable_by_hand=3,},
})
