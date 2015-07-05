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

minetest.register_node("watershed:icydirt", {
	description = "Icy dirt",
	tiles = {"watershed_icydirt.png"},
	is_ground_content = false,
	groups = {crumbly=1},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_snow_footstep", gain=0.15},
		dug = {name="default_snow_footstep", gain=0.45},
	}),
})

minetest.register_alias("watershed:grass", "default:dirt_with_grass")

minetest.register_alias("watershed:redstone", "default:desert_stone")

minetest.register_alias("watershed:redcobble", "default:desert_cobble")

minetest.register_alias("watershed:stone", "default:stone")

minetest.register_alias("watershed:cactus", "default:cactus")

minetest.register_node("watershed:goldengrass", {
	description = "Golden Grass",
	drawtype = "plantlike",
	tiles = {"watershed_goldengrass.png"},
	inventory_image = "watershed_goldengrass.png",
	wield_image = "watershed_goldengrass.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = false,
	groups = {snappy=3,flammable=3,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})

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

minetest.register_node("watershed:permafrost", {
	description = "Permafrost",
	tiles = {"watershed_permafrost.png"},
	is_ground_content = false,
	groups = {crumbly=1},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("watershed:vine", {
	description = "Jungletree vine",
	drawtype = "airlike",
	paramtype = "light",
	walkable = false,
	climbable = true,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("watershed:freshice", {
	description = "Fresh ice",
	tiles = {"watershed_freshice.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_alias("watershed:cloud", "default:cloud")

minetest.override_item("default:cloud", {
	description = "Cloud",
	drawtype = "glasslike",
	tiles = {"watershed_cloud.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	post_effect_color = {a=23, r=241, g=248, b=255},
})

minetest.register_node("watershed:luxore", {
	description = "Lux ore",
	tiles = {"watershed_luxore.png"},
	paramtype = "light",
	light_source = 14,
	groups = {cracky=3},
	drop = "watershed:luxcrystal 8",
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("watershed:light", {
	description = "Light",
	tiles = {"watershed_light.png"},
	paramtype = "light",
	light_source = 14,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_alias("watershed:acaciawood", "moretrees:acacia_wood")

minetest.register_alias("watershed:pinewood", "default:pinewood")



minetest.register_alias("watershed:freshwater", "default:river_water_source")

minetest.register_alias("watershed:freshwaterflow", "default:river_water_flowing")

minetest.register_alias("watershed:lava", "default:lava_source")

minetest.register_alias("watershed:lavaflow", "default:lava_flowing")

minetest.register_alias("watershed:mixwater", "default:river_water_source")

minetest.register_alias("watershed:mixwaterflow", "default:river_water_flowing")

-- Items

minetest.register_craftitem("watershed:luxcrystal", {
	description = "Lux crystal",
	inventory_image = "watershed_luxcrystal.png",
})

-- Crafting

minetest.register_craft({
	type = "cooking",
	output = "default:desert_stone",
	recipe = "watershed:redcobble",
})

minetest.register_craft({
    output = "watershed:light 8",
    recipe = {
        {"default:glass", "default:glass", "default:glass"},
        {"default:glass", "watershed:luxcrystal", "default:glass"},
        {"default:glass", "default:glass", "default:glass"},
    },
})

-- Buckets

bucket.register_liquid(
	"watershed:freshwater",
	"watershed:freshwaterflow",
	"watershed:bucket_freshwater",
	"watershed_bucketfreshwater.png",
	"River Water Bucket"
)

minetest.register_alias("watershed:bucket_lava", "bucket:bucket_lava")

-- Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "watershed:bucket_lava",
	burntime = 60,
	replacements = {{"watershed:bucket_lava", "bucket:bucket_empty"}},
})
