-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.


-- Namespace for functions

flowers = {}


-- Map Generation

dofile(minetest.get_modpath("flowers") .. "/mapgen.lua")


--
-- Flowers
--

-- Aliases for original flowers mod

minetest.register_alias("flowers:flower_rose", "flowers:rose")
minetest.register_alias("flowers:flower_tulip", "flowers:tulip")
minetest.register_alias("flowers:flower_dandelion_yellow", "flowers:dandelion_yellow")
minetest.register_alias("flowers:flower_geranium", "flowers:geranium")
minetest.register_alias("flowers:flower_viola", "flowers:viola")
minetest.register_alias("flowers:flower_dandelion_white", "flowers:dandelion_white")


-- Flower registration

local function add_simple_flower(name, desc, box, f_groups)
	-- Common flowers' groups
	f_groups.snappy = 3
	f_groups.flammable = 2
	f_groups.flower = 1
	f_groups.flora = 1
	f_groups.attached_node = 1

	minetest.register_node("flowers:" .. name, {
		description = desc,
		drawtype = "plantlike",
		tiles = {"flowers_" .. name .. ".png"},
		inventory_image = "flowers_" .. name .. ".png",
		wield_image = "flowers_" .. name .. ".png",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		stack_max = 99,
		groups = f_groups,
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = box
		}
	})
end

flowers.datas = {
	{"rose", "Rose", {-0.15, -0.5, -0.15, 0.15, 0.3, 0.15}, {color_red = 1}},
	{"tulip", "Orange Tulip", {-0.15, -0.5, -0.15, 0.15, 0.2, 0.15}, {color_orange = 1}},
	{"dandelion_yellow", "Yellow Dandelion", {-0.15, -0.5, -0.15, 0.15, 0.2, 0.15}, {color_yellow = 1}},
	{"geranium", "Blue Geranium", {-0.15, -0.5, -0.15, 0.15, 0.2, 0.15}, {color_blue = 1}},
	{"viola", "Viola", {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5}, {color_violet = 1}},
	{"dandelion_white", "White dandelion", {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5}, {color_white = 1}}
}

for _,item in pairs(flowers.datas) do
	add_simple_flower(unpack(item))
end


--
-- Mushrooms
--

local mushrooms_datas = {
	{"brown", 2},
	{"red", -6}
}

for _, m in pairs(mushrooms_datas) do
	local name, nut = m[1], m[2]

	-- Register fertile mushrooms

	-- These are placed by mapgen and the growing ABM.
	-- These drop an infertile mushroom, and 0 to 3 spore
	-- nodes with an average of 1.25 per mushroom, for
	-- a slow multiplication of mushrooms when farming.

	minetest.register_node("flowers:mushroom_fertile_" .. name, {
		description = string.sub(string.upper(name), 0, 1) ..
			string.sub(name, 2) .. " Fertile Mushroom",
		tiles = {"flowers_mushroom_" .. name .. ".png"},
		inventory_image = "flowers_mushroom_" .. name .. ".png",
		wield_image = "flowers_mushroom_" .. name .. ".png",
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, attached_node = 1,
			not_in_creative_inventory = 1},
		drop = {
			items = {
				{items = {"flowers:mushroom_" .. name}},
				{items = {"flowers:mushroom_spores_" .. name}, rarity = 4},
				{items = {"flowers:mushroom_spores_" .. name}, rarity = 2},
				{items = {"flowers:mushroom_spores_" .. name}, rarity = 2}
			}
		},
		sounds = default.node_sound_leaves_defaults(),
		on_use = minetest.item_eat(nut),
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3}
		}
	})

	-- Register infertile mushrooms

	-- These do not drop spores, to avoid the use of repeated digging
	-- and placing of a single mushroom to generate unlimited spores.

	minetest.register_node("flowers:mushroom_" .. name, {
		description = string.sub(string.upper(name), 0, 1) ..
			string.sub(name, 2) .. " Mushroom",
		tiles = {"flowers_mushroom_" .. name .. ".png"},
		inventory_image = "flowers_mushroom_" .. name .. ".png",
		wield_image = "flowers_mushroom_" .. name .. ".png",
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, attached_node = 1},
		sounds = default.node_sound_leaves_defaults(),
		on_use = minetest.item_eat(nut),
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3}
		}
	})

	-- Register mushroom spores

	minetest.register_node("flowers:mushroom_spores_" .. name, {
		description = string.sub(string.upper(name), 0, 1) ..
			string.sub(name, 2) .. " Mushroom Spores",
		drawtype = "signlike",
		tiles = {"flowers_mushroom_spores_" .. name .. ".png"},
		inventory_image = "flowers_mushroom_spores_" .. name .. ".png",
		wield_image = "flowers_mushroom_spores_" .. name .. ".png",
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		selection_box = {
			type = "wallmounted",
		},
		groups = {dig_immediate = 3, attached_node = 1},
	})
end
