minetest.register_alias("watershed:appleleaf", "default:leaves")

minetest.register_alias("watershed:appling", "default:sapling")

minetest.register_alias("watershed:acaciatree", "moretrees:acacia_tree")

minetest.register_alias("watershed:acacialeaf", "moretrees:acacia_sapling")

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
	description = "Golden grass",
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
	description = "Dry grass",
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

minetest.register_node("watershed:cloud", {
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



minetest.register_node("watershed:freshwater", {
	description = "Freshwater source",
	inventory_image = minetest.inventorycube("watershed_freshwater.png"),
	drawtype = "liquid",
	tiles = {
		{
			name="watershed_freshwateranim.png",
			animation={type="vertical_frames",
			aspect_w=16, aspect_h=16, length=2.0}
		}
	},
	special_tiles = {
		{
			name="watershed_freshwateranim.png",
			animation={type="vertical_frames",
			aspect_w=16, aspect_h=16, length=2.0},
			backface_culling = false,
		}
	},
	alpha = WATER_ALPHA,
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "watershed:freshwaterflow",
	liquid_alternative_source = "watershed:freshwater",
	liquid_viscosity = WATER_VISC,
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a=64, r=100, g=150, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1},
})

minetest.register_node("watershed:freshwaterflow", {
	description = "Flowing freshwater",
	inventory_image = minetest.inventorycube("watershed_freshwater.png"),
	drawtype = "flowingliquid",
	tiles = {"watershed_freshwater.png"},
	special_tiles = {
		{
			image="watershed_freshwaterflowanim.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
		{
			image="watershed_freshwaterflowanim.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
	},
	alpha = WATER_ALPHA,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	is_ground_content = false,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "watershed:freshwaterflow",
	liquid_alternative_source = "watershed:freshwater",
	liquid_viscosity = WATER_VISC,
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a=64, r=100, g=150, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1},
})

minetest.register_alias("watershed:lava", "default:lava_source")

minetest.register_alias("watershed:lavaflow", "default:lava_flowing")

minetest.register_node("watershed:mixwater", {
	description = "Mixed water source",
	inventory_image = minetest.inventorycube("watershed_mixwater.png"),
	drawtype = "liquid",
	tiles = {
		{
			name="watershed_mixwateranim.png",
			animation={type="vertical_frames",
			aspect_w=16, aspect_h=16, length=2.0}
		}
	},
	special_tiles = {
		{
			name="watershed_mixwateranim.png",
			animation={type="vertical_frames",
			aspect_w=16, aspect_h=16, length=2.0},
			backface_culling = false,
		}
	},
	alpha = WATER_ALPHA,
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "watershed:mixwaterflow",
	liquid_alternative_source = "watershed:mixwater",
	liquid_viscosity = WATER_VISC,
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a=64, r=100, g=120, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1},
})

minetest.register_node("watershed:mixwaterflow", {
	description = "Flowing mixed water",
	inventory_image = minetest.inventorycube("watershed_mixwater.png"),
	drawtype = "flowingliquid",
	tiles = {"watershed_mixwater.png"},
	special_tiles = {
		{
			image="watershed_mixwaterflowanim.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
		{
			image="watershed_mixwaterflowanim.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
	},
	alpha = WATER_ALPHA,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	is_ground_content = false,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "watershed:mixwaterflow",
	liquid_alternative_source = "watershed:mixwater",
	liquid_viscosity = WATER_VISC,
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a=64, r=100, g=120, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1},
})

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

minetest.register_craft({
	output = "watershed:acaciawood 4",
	recipe = {
		{"watershed:acaciatree"},
	}
})

minetest.register_craft({
	output = "watershed:pinewood 4",
	recipe = {
		{"watershed:pinetree"},
	}
})

-- Buckets

bucket.register_liquid(
	"watershed:freshwater",
	"watershed:freshwaterflow",
	"watershed:bucket_freshwater",
	"watershed_bucketfreshwater.png",
	"WS Fresh Water Bucket"
)

bucket.register_liquid(
	"watershed:lava",
	"watershed:lavaflow",
	"watershed:bucket_lava",
	"bucket_lava.png",
	"WS Lava Bucket"
)

-- Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "watershed:bucket_lava",
	burntime = 60,
	replacements = {{"watershed:bucket_lava", "bucket:bucket_empty"}},
})

-- Register stairs and slabs

stairs.register_stair_and_slab("acaciawood", "watershed:acaciawood",
		{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		{"watershed_acaciawood.png"},
		"Acaciawood stair",
		"Acaciawood slab",
		default.node_sound_wood_defaults())

stairs.register_stair_and_slab("pinewood", "watershed:pinewood",
		{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		{"watershed_pinewood.png"},
		"Pinewood stair",
		"Pinewood slab",
		default.node_sound_wood_defaults())
