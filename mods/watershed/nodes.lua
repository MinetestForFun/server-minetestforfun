minetest.register_alias("watershed:appleleaf", "default:leaves")

minetest.register_alias("watershed:appling", "default:sapling")

minetest.register_alias("watershed:acaciatree", "moretrees:acacia_trunk")

minetest.register_alias("watershed:acacialeaf", "moretrees:acacia_leaves")

minetest.register_alias("watershed:acacialing", "moretrees:acacia_sapling")

minetest.register_alias("watershed:pinetree", "default:pinetree")

minetest.register_alias("watershed:needles", "default:pine_needles")

minetest.register_alias("watershed:pineling", "default:pine_sapling")

minetest.register_alias("watershed:jungleleaf", "default:jungleleaves")

minetest.register_alias("watershed:jungling", "default:junglesapling")

minetest.register_alias("watershed:dirt", "default:dirt")

minetest.register_alias("watershed:icydirt", "default:dirt_with_grass")

minetest.register_alias("watershed:grass", "default:dirt_with_grass")

minetest.register_alias("watershed:redstone", "default:desert_stone")

minetest.register_alias("watershed:redcobble", "default:desert_cobble")

minetest.register_alias("watershed:stone", "default:stone")

minetest.register_alias("watershed:cactus", "default:cactus")

minetest.register_alias("watershed:goldengrass", "default:dry_shrub")

minetest.register_node("watershed:drygrass", {
	description = "Dry Dirt",
	tiles = {"watershed_drygrass.png"},
	is_ground_content = false,
	groups = {crumbly=1,soil=1},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

minetest.register_alias("watershed:permafrost", "default:dirt")

minetest.register_alias("watershed:freshice", "default:ice")

minetest.register_alias("watershed:cloud", "default:cloud")

minetest.override_item("default:cloud", {
	description = "Cloud",
	drawtype = "glasslike",
	tiles = {"default_cloud.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	post_effect_color = {a=23, r=241, g=248, b=255},
	groups = {not_in_creative_inventory=1},
})

minetest.register_alias("watershed:luxore", "default:stone")

minetest.register_alias("watershed:light", "lantern:lamp")

minetest.register_alias("watershed:acaciawood", "moretrees:acacia_wood")

minetest.register_alias("watershed:pinewood", "default:pinewood")


minetest.register_alias("watershed:freshwater", "default:river_water_source")

minetest.register_alias("watershed:freshwaterflow", "default:river_water_flowing")

minetest.register_alias("watershed:lava", "default:lava_source")

minetest.register_alias("watershed:lavaflow", "default:lava_flowing")

minetest.register_alias("watershed:mixwater", "default:river_water_source")

minetest.register_alias("watershed:mixwaterflow", "default:river_water_flowing")

-- Items

minetest.register_alias("watershed:luxcrystal", "default:cobble")

-- Crafting

