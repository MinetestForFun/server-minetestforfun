
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
	drawtype = "signlike",
	tiles = {"lavatemple_ladder.png"},
	inventory_image = "lavatemple_ladder.png",
	wield_image = "lavatemple_ladder.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	selection_box = {type = "wallmounted"},
	groups = {dark=1},
	legacy_wallmounted = true,
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
