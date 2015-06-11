screwdriver = screwdriver or {}

minetest.register_node("plasmascreen:stand", {
	description = "Plasma Screen TV Stand",
	tiles = {"plasmascreen_back.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{0.5000,-0.5000,0.0625,-0.5000,-0.4375,-0.5000}, --NodeBox 1
			{-0.1875,-0.5000,-0.3750,0.1875,0.1250,-0.1250}, --NodeBox 2
			{-0.5000,-0.2500,-0.5000,0.5000,0.5000,-0.3750}, --NodeBox 3
			{-0.3750,-0.1875,-0.3750,0.3750,0.3125,-0.2500}, --NodeBox 4
		}
	},
	selection_box = {
		type = "fixed",
			fixed = {
			{-0.5000, -0.5000, -0.5000, 0.5000, 0.5000, 0.0000},
		}
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2},
})

minetest.register_alias("plasmascreen:screen1", "air")
minetest.register_alias("plasmascreen:screen2", "air")
minetest.register_alias("plasmascreen:screen3", "air")
minetest.register_alias("plasmascreen:screen4", "air")
minetest.register_alias("plasmascreen:screen5", "plasmascreen:tv")
minetest.register_alias("plasmascreen:screen6", "air")

local fdir_to_left = {
	{ -1,  0 },
	{  0,  1 },
	{  1,  0 },
	{  0, -1 },
}

local fdir_to_right = {
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
	{  0,  1 },
}

local tv_cbox = {
	type = "fixed",
	fixed = {-1.5050, -0.3125, 0.3700, 1.5050, 1.5050, 0.5050}
}

local function checkwall(pos)

	local fdir = minetest.get_node(pos).param2

	local dxl = fdir_to_left[fdir + 1][1]	-- dxl = "[D]elta [X] [L]eft"
	local dzl = fdir_to_left[fdir + 1][2]	-- Z left

	local dxr = fdir_to_right[fdir + 1][1]	-- X right
	local dzr = fdir_to_right[fdir + 1][2]	-- Z right

	local node1 = minetest.get_node({x=pos.x+dxl, y=pos.y, z=pos.z+dzl})
	if not node1 or not minetest.registered_nodes[node1.name]
	  or not minetest.registered_nodes[node1.name].buildable_to then
		return false
	end

	local node2 = minetest.get_node({x=pos.x+dxr, y=pos.y, z=pos.z+dzr})
	if not node2 or not minetest.registered_nodes[node2.name]
	  or not minetest.registered_nodes[node2.name].buildable_to then
		return false
	end

	local node3 = minetest.get_node({x=pos.x+dxl, y=pos.y+1, z=pos.z+dzl})
	if not node3 or not minetest.registered_nodes[node3.name]
	  or not minetest.registered_nodes[node3.name].buildable_to then
		return false
	end

	local node4 = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z})
	if not node4 or not minetest.registered_nodes[node4.name]
	  or not minetest.registered_nodes[node4.name].buildable_to then
		return false
	end

	local node5 = minetest.get_node({x=pos.x+dxr, y=pos.y+1, z=pos.z+dzr})
	if not node5 or not minetest.registered_nodes[node5.name]
	  or not minetest.registered_nodes[node5.name].buildable_to then
		return false
	end

	return true
end

minetest.register_node("plasmascreen:tv", {
	description = "Plasma TV",
	drawtype = "mesh",
	mesh = "plasmascreen_tv.obj",
	tiles = {
		"plasmascreen_case.png",
		{ name="plasmascreen_video.png",
			animation={
				type="vertical_frames",
				aspect_w = 42,
				aspect_h = 23,
				length = 44
			}
		}

	},
	inventory_image = "plasmascreen_tv_inv.png",
	wield_image = "plasmascreen_tv_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 10,
	selection_box = tv_cbox,
	collision_box = tv_cbox,
	on_rotate = screwdriver.disallow,
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2},
	after_place_node = function(pos, placer, itemstack)
		if not checkwall(pos) then
			minetest.set_node(pos, {name = "air"})
			return true	-- "API: If return true no item is taken from itemstack"
		end
	end,
	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.set_node(pos, {name = "plasmascreen:tv_off", param2 = node.param2})
	end
})

minetest.register_node("plasmascreen:tv_off", {
	description = "Plasma TV (off)",
	drawtype = "mesh",
	mesh = "plasmascreen_tv.obj",
	tiles = {
		"plasmascreen_case_off.png",
		"plasmascreen_screen_off.png",
	},
	inventory_image = "plasmascreen_tv_inv.png",
	wield_image = "plasmascreen_tv_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 10,
	selection_box = tv_cbox,
	collision_box = tv_cbox,
	on_rotate = screwdriver.disallow,
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, not_in_creative_inventory=1},
	after_place_node = function(pos, placer, itemstack)
		if not checkwall(pos) then
			minetest.set_node(pos, {name = "air"})
			return true	-- "API: If return true no item is taken from itemstack"
		end
	end,
	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.set_node(pos, {name = "plasmascreen:tv", param2 = node.param2})
	end,
	drop = "plasmascreen:tv"
})

-- crafting recipes

minetest.register_craft({
	output = "plasmascreen:tv",
	recipe = {
		{'default:glass', 'default:coal_lump', 'default:glass'},
		{'default:steel_ingot', 'default:copper_ingot', 'default:steel_ingot'},
		{'default:glass', 'default:glass', 'default:glass'},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "plasmascreen:tv",
	recipe = {'homedecor:television', 'homedecor:television'},
})

minetest.register_craft({
	output = "plasmascreen:stand",
	recipe = {
		{'', '', ''},
		{'', 'default:steel_ingot', ''},
		{'group:stick', 'default:coal_lump', 'group:stick'},
	}
})
