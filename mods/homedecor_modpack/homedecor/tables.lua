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

	minetest.register_node("homedecor:"..m.."_table_small_square", {
		description = S(d.." Table (Small, Square)"),
		drawtype = 'mesh',
		mesh = "homedecor_table_small_square.obj",
		tiles = { 'homedecor_'..m..'_table_small_square.png' },
		wield_image = 'homedecor_'..m..'_table_small_square_inv.png',
		inventory_image = 'homedecor_'..m..'_table_small_square_inv.png',
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = true,
		groups = { snappy = 3 },
		sounds = s,
		paramtype2 = "facedir",
		selection_box = tables_cbox,
		collision_box = tables_cbox,
		on_place = minetest.rotate_node
	})

-- small round tables

	minetest.register_node('homedecor:'..m..'_table_small_round', {
		description = S(d.." Table (Small, Round)"),
		drawtype = "mesh",
		mesh = "homedecor_table_small_round.obj",
		tiles = { "homedecor_"..m.."_table_small_round.png" },
		wield_image = 'homedecor_'..m..'_table_small_round_inv.png',
		inventory_image = 'homedecor_'..m..'_table_small_round_inv.png',
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = true,
		groups = { snappy = 3 },
		sounds = s,
		paramtype2 = "facedir",
		selection_box = tables_cbox,
		collision_box = tables_cbox,
		on_place = minetest.rotate_node
	})

-- Large square table pieces

	minetest.register_node('homedecor:'..m..'_table_large', {
		description = S(d.." Table Piece (large)"),
		drawtype = 'nodebox',
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
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = true,
		groups = { snappy = 3 },
		sounds = s,
		paramtype2 = "facedir",
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
		minetest.add_node(pos, {name = newnode, param2 = dirs2[fdir+1]})
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

minetest.register_node('homedecor:utility_table_top', {
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
	drawtype = "nodebox",
	sunlight_propagates = false,
	paramtype = "light",
	walkable = true,
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

minetest.register_node("homedecor:table_legs_brass", {
        description = S("Brass Table Legs"),
        drawtype = "plantlike",
        tiles = {"homedecor_table_legs_brass.png"},
        inventory_image = "homedecor_table_legs_brass.png",
        wield_image = "homedecor_table_legs_brass.png",
        paramtype = "light",
        walkable = false,
        groups = {snappy=3},
        sounds = default.node_sound_leaves_defaults(),
	walkable = true,
        selection_box = {
		type = "fixed",
		fixed = { -0.37, -0.5, -0.37, 0.37, 0.5, 0.37 }
	},
})

minetest.register_node("homedecor:table_legs_wrought_iron", {
        description = S("Wrought Iron Table Legs"),
        drawtype = "plantlike",
        tiles = {"homedecor_table_legs_wrought_iron.png"},
        inventory_image = "homedecor_table_legs_wrought_iron.png",
        wield_image = "homedecor_table_legs_wrought_iron.png",
        paramtype = "light",
        walkable = false,
        groups = {snappy=3},
        sounds = default.node_sound_leaves_defaults(),
	walkable = true,
        selection_box = {
		type = "fixed",
		fixed = { -0.37, -0.5, -0.37, 0.37, 0.5, 0.37 }
	},
})

minetest.register_node('homedecor:utility_table_legs', {
	description = S("Legs for Utility Table"),
	drawtype = "plantlike",
	tiles = { 'homedecor_utility_table_legs.png' },
	inventory_image = 'homedecor_utility_table_legs_inv.png',
	wield_image = 'homedecor_utility_table_legs.png',
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
        selection_box = {
		type = "fixed",
		fixed = { -0.37, -0.5, -0.37, 0.37, 0.5, 0.37 }
	},
})

minetest.register_node("homedecor:desk", {
	drawtype = "nodebox",
	description = "Desk",
	tiles = {
		"forniture_wood.png",
		"forniture_wood.png",
		"forniture_wood.png",
		"forniture_wood.png",
		"forniture_wood.png",
		"homedecor_desk_front_l.png"
	},
	inventory_image = "homedecor_desk_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.4375, 0.375, 0.5, 0.5},
			{-0.5, 0.4375, -0.4375, 0.5, 0.5, 0.5},
			{-0.4375, -0.4375, -0.5, 0.3125, -0.0625, -0.4375},
			{-0.4375, 0, -0.5, 0.3125, 0.375, 0.5},
			{0.3125, -0.375, 0.4375, 0.5, 0.25, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 1.5, 0.5, 0.5 }
	},
	groups = { snappy = 3 },
	on_place = function(itemstack, placer, pointed_thing)
		return homedecor.stack_sideways(itemstack, placer, pointed_thing,
			"homedecor:desk", "homedecor:desk_r", true)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local fdir = oldnode.param2
		if not fdir or fdir > 3 then return end
		local pos2 = { x = pos.x + homedecor.fdir_to_right[fdir+1][1], y=pos.y, z = pos.z + homedecor.fdir_to_right[fdir+1][2] }
		if minetest.get_node(pos2).name == "homedecor:desk_r" then
			minetest.remove_node(pos2)
		end
	end
})

minetest.register_node("homedecor:desk_r", {
	drawtype = "nodebox",
	tiles = {
		"forniture_wood.png",
		"forniture_wood.png",
		"forniture_wood.png",
		"forniture_wood.png",
		"homedecor_desk_back_r.png",
		"homedecor_desk_front_r.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.4375, -0.4375, 0.5, 0.5, 0.5},
			{0.375, -0.5, -0.4375, 0.5, 0.5, 0.5},
			{-0.5, 0.3125, -0.4375, 0.5, 0.375, 0.5},
			{-0.5, 0.3125, -0.4375, -0.4375, 0.5, 0.5},
			{-0.5, -0.375, 0.4375, 0.4375, 0.25, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { 0,0,0,0,0,0 }
	},
	groups = { snappy = 3, not_in_creative_inventory=1 }
})

