-- This file supplies Kitchen cabinets and kitchen sink

local S = homedecor.gettext

local counter_materials = { "", "granite", "marble", "steel" }

for _, mat in ipairs(counter_materials) do

	local desc = S("Kitchen Cabinet")
	local material = ""

	if mat ~= "" then
		desc = S("Kitchen Cabinet ("..mat.." top)")
		material = "_"..mat
	end

	homedecor.register("kitchen_cabinet"..material, {
		description = desc,
		tiles = { 'homedecor_kitchen_cabinet_top'..material..'.png',
				'homedecor_kitchen_cabinet_bottom.png',
				'homedecor_kitchen_cabinet_sides.png',
				'homedecor_kitchen_cabinet_sides.png',
				'homedecor_kitchen_cabinet_sides.png',
				'homedecor_kitchen_cabinet_front.png'},
		groups = { snappy = 3 },
		sounds = default.node_sound_wood_defaults(),
		infotext=S("Kitchen Cabinet"),
		inventory = {
			size=24,
		},
	})
end

local kitchen_cabinet_half_box = homedecor.nodebox.slab_y(0.5, 0.5)
homedecor.register("kitchen_cabinet_half", {
	description = S('Half-height Kitchen Cabinet (on ceiling)'),
	tiles = { 'homedecor_kitchen_cabinet_sides.png',
			'homedecor_kitchen_cabinet_bottom.png',
			'homedecor_kitchen_cabinet_sides.png',
			'homedecor_kitchen_cabinet_sides.png',
			'homedecor_kitchen_cabinet_sides.png',
			'homedecor_kitchen_cabinet_front_half.png'},
	selection_box = kitchen_cabinet_half_box,
	node_box = kitchen_cabinet_half_box,
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("Kitchen Cabinet"),
	inventory = {
		size=12,
	},
})

homedecor.register("kitchen_cabinet_with_sink", {
	description = S("Kitchen Cabinet with sink"),
	mesh = "homedecor_kitchen_sink.obj",
	tiles = { "homedecor_kitchen_sink.png" },
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("Under-sink cabinet"),
	inventory = {
		size=16,
	},
})

homedecor.register("copper_pans", {
	description = "Copper pans",
	tiles = {
		"homedecor_polished_copper.png"
	},
	inventory_image = "homedecor_copper_pans_inv.png",
	groups = { snappy=3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.1875, -0.0625, -0.48, 0.125}, -- NodeBox1
			{-0.375, -0.48, -0.1875, -0.36, -0.3125, 0.125}, -- NodeBox2
			{-0.0775, -0.48, -0.1875, -0.0625, -0.3125, 0.125}, -- NodeBox3
			{-0.375, -0.48, 0.11, -0.0625, -0.3125, 0.125}, -- NodeBox4
			{-0.375, -0.48, -0.1875, -0.0625, -0.3125, -0.1725}, -- NodeBox5
			{-0.25, -0.36, -0.5, -0.1875, -0.33, -0.1875}, -- NodeBox6
			{0.0625, -0.5, 0, 0.375, -0.48, 0.3125}, -- NodeBox7
			{0.0625, -0.48, 0, 0.0775, -0.3125, 0.3125}, -- NodeBox8
			{0.36, -0.48, 0, 0.375, -0.3125, 0.3125}, -- NodeBox9
			{0.0625, -0.48, 0, 0.375, -0.3125, 0.0175}, -- NodeBox10
			{0.0625, -0.48, 0.295, 0.375, -0.3125, 0.3125}, -- NodeBox11
			{0.1875, -0.36, -0.3125, 0.25, -0.33, 0}, -- NodeBox12
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.375, -0.5, -0.5, 0.375, -0.3125, 0.3125 }
	},
	on_place = minetest.rotate_node
})

homedecor.register("kitchen_faucet", {
	tiles = { "homedecor_bright_metal.png" },
	inventory_image = "homedecor_kitchen_faucet_inv.png",
	description = "Kitchen Faucet",
        groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{0, -0.5, 0.375, 0.0625, -0.1875, 0.4375}, -- NodeBox1
			{0, -0.1875, 0.35, 0.0625, -0.15, 0.4375}, -- NodeBox2
			{0, -0.15, 0.32, 0.0625, -0.11, 0.41}, -- NodeBox3
			{0.007, -0.12, 0.17, 0.055, -0.11, 0.1285}, -- NodeBox4
			{0, -0.11, 0.125, 0.0625, -0.07, 0.37}, -- NodeBox5
			{-0.05, -0.48, 0.385, 0.115, -0.455, 0.43}, -- NodeBox6
			{-0.05, -0.49, 0.395, 0.115, -0.445, 0.42}, -- NodeBox7
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.055, -0.5, 0.125, 0.12, -0.065, 0.4375 }
	},
})

homedecor.register("paper_towel", {
	mesh = "homedecor_paper_towel.obj",
	tiles = { "homedecor_paper_towel.png" },
	inventory_image = "homedecor_paper_towel_inv.png",
	description = "Paper towels",
	groups = { snappy=3 },
	selection_box = {
		type = "fixed",
		fixed = { -0.4375, 0.125, 0.0625, 0.4375, 0.4375, 0.5 }
	},
	collision_box = {
		type = "fixed",
		fixed = { -0.4375, 0.125, 0.0625, 0.4375, 0.4375, 0.5 }
	}
})

