
minetest.register_node("lavatemple:brick", {
	description = "Darkbrick",
	tiles = {"lavatemple_brick.png"},
	groups = {dark=1},
	sounds = default.node_sound_stone_defaults(),
})

stairs.register_stair_and_slab(
	"lavatemple_brick",
	"lavatemple:brick",
	{dark=1},
	{"lavatemple_brick.png"},
	"Darkbrick Stair",
	"Darkbrick Slab",
	default.node_sound_stone_defaults()
)

minetest.register_node("lavatemple:ladder", {
	description = "Darkbrick Ladder",
	drawtype = "nodebox",
	tiles = {"lavatemple_ladder.png"},
	inventory_image = "lavatemple_ladder_inv.png",
	wield_image = "lavatemple_ladder_inv.png",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "wallmounted",
	climbable = true,
	walkable = true,
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.375, 0.4375, -0.5, 0.375, 0.5, 0.5},
		wall_bottom = {-0.375, -0.5, -0.5, 0.375, -0.4375, 0.5},
		wall_side   = {-0.5, -0.5, -0.375, -0.4375, 0.5, 0.375},
	},
	selection_box = {type = "wallmounted"},
	legacy_wallmounted = true,
	groups = {dark=1, cracky = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lavatemple:fence_brick", {
	description = "Darkbrick fence",
	drawtype = "fencelike",
	paramtype = "light",
	tiles = {"lavatemple_brick.png"},
	groups = {dark=1},
	sounds = default.node_sound_stone_defaults(),
})
