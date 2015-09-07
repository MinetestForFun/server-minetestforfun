-- Various kinds of tables

local S = homedecor.gettext

local materials = {
	{"glass","Glass"},
	{"wood","Wood"}
}

local tables_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5,    -0.5,  0.5,    -0.4375, 0.5 },
}

for i in ipairs(materials) do
	local m = materials[i][1]
	local d = materials[i][2]
	local s = nil

	if m == "glass" then
		s = default.node_sound_glass_defaults()
	else
		s = default.node_sound_wood_defaults()
	end

-- small square tables

	homedecor.register(m.."_table_small_square", {
		description = S(d.." Table (Small, Square)"),
		mesh = "homedecor_table_small_square.obj",
		tiles = { 'homedecor_'..m..'_table_small_square.png' },
		wield_image = 'homedecor_'..m..'_table_small_square_inv.png',
		inventory_image = 'homedecor_'..m..'_table_small_square_inv.png',
		groups = { snappy = 3 },
		sounds = s,
		selection_box = tables_cbox,
		collision_box = tables_cbox,
		on_place = minetest.rotate_node
	})

-- small round tables

	homedecor.register(m..'_table_small_round', {
		description = S(d.." Table (Small, Round)"),
		mesh = "homedecor_table_small_round.obj",
		tiles = { "homedecor_"..m.."_table_small_round.png" },
		wield_image = 'homedecor_'..m..'_table_small_round_inv.png',
		inventory_image = 'homedecor_'..m..'_table_small_round_inv.png',
		groups = { snappy = 3 },
		sounds = s,
		selection_box = tables_cbox,
		collision_box = tables_cbox,
		on_place = minetest.rotate_node
	})

-- Large square table pieces

	homedecor.register(m..'_table_large', {
		description = S(d.." Table Piece (large)"),
		tiles = {
			'homedecor_'..m..'_table_large_tb.png',
			'homedecor_'..m..'_table_large_tb.png',
			'homedecor_'..m..'_table_large_edges.png',
			'homedecor_'..m..'_table_large_edges.png',
			'homedecor_'..m..'_table_large_edges.png',
			'homedecor_'..m..'_table_large_edges.png'
		},
		wield_image = 'homedecor_'..m..'_table_large_inv.png',
		inventory_image = 'homedecor_'..m..'_table_large_inv.png',
		groups = { snappy = 3 },
		sounds = s,
		node_box = {
			type = "fixed",
			fixed = { -0.5, -0.5, -0.5, 0.5, -0.4375, 0.5 },
		},
		selection_box = tables_cbox,
		on_place = minetest.rotate_node
	})

	minetest.register_alias('homedecor:'..m..'_table_large_b', 'homedecor:'..m..'_table_large')
	minetest.register_alias('homedecor:'..m..'_table_small_square_b', 'homedecor:'..m..'_table_small_square')
	minetest.register_alias('homedecor:'..m..'_table_small_round_b', 'homedecor:'..m..'_table_small_round')

end

-- conversion routines for old non-6dfacedir tables

local tlist_s = {}
local tlist_t = {}
local dirs2 = { 9, 18, 7, 12 }

for i in ipairs(materials) do
	local m = materials[i][1]
	table.insert(tlist_s, "homedecor:"..m.."_table_large_s")
	table.insert(tlist_s, "homedecor:"..m.."_table_small_square_s")
	table.insert(tlist_s, "homedecor:"..m.."_table_small_round_s")

	table.insert(tlist_t, "homedecor:"..m.."_table_large_t")
	table.insert(tlist_t, "homedecor:"..m.."_table_small_square_t")
	table.insert(tlist_t, "homedecor:"..m.."_table_small_round_t")
end

minetest.register_abm({
	nodenames = tlist_s,
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local newnode = string.sub(node.name, 1, -3) -- strip the "_s" from the name
		local fdir = node.param2 or 0
		minetest.set_node(pos, {name = newnode, param2 = dirs2[fdir+1]})
	end
})

minetest.register_abm({
	nodenames = tlist_t,
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local newnode = string.sub(node.name, 1, -3) -- strip the "_t" from the name
		minetest.set_node(pos, { name = newnode, param2 = 20 })
	end
})

-- other tables

homedecor.register("utility_table_top", {
	description = S("Utility Table"),
	tiles = {
		'homedecor_utility_table_tb.png',
		'homedecor_utility_table_tb.png',
		'homedecor_utility_table_edges.png',
		'homedecor_utility_table_edges.png',
		'homedecor_utility_table_edges.png',
		'homedecor_utility_table_edges.png'
	},
	wield_image = 'homedecor_utility_table_tb.png',
	inventory_image = 'homedecor_utility_table_tb.png',
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "wallmounted",
	node_box = {
		type = "wallmounted",
		wall_bottom = { -0.5, -0.5,    -0.5,  0.5,   -0.4375, 0.5 },
		wall_top =    { -0.5,  0.4375, -0.5,  0.5,    0.5,    0.5 },
		wall_side =   { -0.5, -0.5,    -0.5, -0.4375, 0.5,    0.5 },
	},
	selection_box = {
		type = "wallmounted",
		wall_bottom = { -0.5, -0.5,    -0.5,  0.5,   -0.4375, 0.5 },
		wall_top =    { -0.5,  0.4375, -0.5,  0.5,    0.5,    0.5 },
		wall_side =   { -0.5, -0.5,    -0.5, -0.4375, 0.5,    0.5 },
	},
})

-- Various kinds of table legs

local materials = {"brass", "wrought_iron"}

for _, t in ipairs(materials) do
homedecor.register("table_legs_"..t, {
	description = S("Table Legs ("..t..")"),
	drawtype = "plantlike",
	tiles = {"homedecor_table_legs_"..t..".png"},
	inventory_image = "homedecor_table_legs_"..t..".png",
	wield_image = "homedecor_table_legs_"..t..".png",
	walkable = false,
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.37, -0.5, -0.37, 0.37, 0.5, 0.37 }
	},
})
end

homedecor.register("utility_table_legs", {
	description = S("Legs for Utility Table"),
	drawtype = "plantlike",
	tiles = { 'homedecor_utility_table_legs.png' },
	inventory_image = 'homedecor_utility_table_legs_inv.png',
	wield_image = 'homedecor_utility_table_legs.png',
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.37, -0.5, -0.37, 0.37, 0.5, 0.37 }
	},
})
