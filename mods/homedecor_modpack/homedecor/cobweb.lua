minetest.register_node("homedecor:cobweb_corner", {
	description = "Cobweb",
	drawtype = "torchlike",
	tiles = { "homedecor_cobweb_torchlike.png" },
	inventory_image = "homedecor_cobweb_inv.png",
	wield_image = "homedecor_cobweb_inv.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	liquid_viscosity = 8,
	liquidtype = "source",
	liquid_alternative_flowing = "homedecor:cobweb_corner",
	liquid_alternative_source = "homedecor:cobweb_corner",
	liquid_renewable = false,
	liquid_range = 0,
	walkable = false,
	selection_box = { type = "regular" },
	visual_scale = 1.4,
	groups = { snappy = 3, liquid=3 },
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		homedecor.rotate_cobweb(pos)
	end
})

minetest.register_node("homedecor:cobweb_centered", {
	description = "Cobweb",
	drawtype = "nodebox",
	tiles = { "homedecor_cobweb.png" },
	inventory_image = "homedecor_cobweb_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	liquid_viscosity = 8,
	liquidtype = "source",
	liquid_alternative_flowing = "homedecor:cobweb_centered",
	liquid_alternative_source = "homedecor:cobweb_centered",
	liquid_renewable = false,
	liquid_range = 0,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.1, 0.5, 0.5, 0.1 }
	},
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0, 0.5, 0.5, 0 }
	},
	groups = { snappy = 3, liquid=3, not_in_creative_inventory = 1 },
	drop = "homedecor:cobweb_corner"
})

minetest.register_node("homedecor:cobweb_flat", {
	description = "Cobweb",
	drawtype = "nodebox",
	tiles = { "homedecor_cobweb.png" },
	inventory_image = "homedecor_cobweb_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	liquid_viscosity = 8,
	liquidtype = "source",
	liquid_alternative_flowing = "homedecor:cobweb_flat",
	liquid_alternative_source = "homedecor:cobweb_flat",
	liquid_renewable = false,
	liquid_range = 0,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0.4, 0.5, 0.5, 0.5 }
	},
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0.495, 0.5, 0.5, 0.495 }
	},
	groups = { snappy = 3, liquid=3, not_in_creative_inventory = 1 },
	drop = "homedecor:cobweb_corner"
})

minetest.register_node("homedecor:cobweb_plantlike", {
	description = "Cobweb",
	drawtype = "plantlike",
	tiles = { "homedecor_cobweb_plantlike.png" },
	inventory_image = "homedecor_cobweb_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	liquid_viscosity = 8,
	liquidtype = "source",
	liquid_alternative_flowing = "homedecor:cobweb_plantlike",
	liquid_alternative_source = "homedecor:cobweb_plantlike",
	liquid_renewable = false,
	liquid_range = 0,
	walkable = false,
	selection_box = { type = "regular" },
	visual_scale = 1.189,
	groups = { snappy = 3, liquid=3, not_in_creative_inventory = 1 },
	drop = "homedecor:cobweb_corner"
})

-- helper function to rotate the cobweb after it's placed

function homedecor.rotate_cobweb(pos)
	local wall_xm = minetest.get_node({ x=pos.x-1, y=pos.y, z=pos.z }).name
	local wall_xp = minetest.get_node({ x=pos.x+1, y=pos.y, z=pos.z }).name
	local wall_zm = minetest.get_node({ x=pos.x,   y=pos.y, z=pos.z-1}).name
	local wall_zp = minetest.get_node({ x=pos.x,   y=pos.y, z=pos.z+1}).name

	local iswall_xm = (wall_xm ~= "air" and not string.find(wall_xm, "homedecor:cobweb"))
	local iswall_xp = (wall_xp ~= "air" and not string.find(wall_xp, "homedecor:cobweb"))
	local iswall_zm = (wall_zm ~= "air" and not string.find(wall_zm, "homedecor:cobweb"))
	local iswall_zp = (wall_zp ~= "air" and not string.find(wall_zp, "homedecor:cobweb"))

	-- only xm+zp, or only xp+zm means on-floor torchlike

	if (iswall_xm and iswall_zp and not iswall_xp and not iswall_zm)
	or (iswall_xp and iswall_zm and not iswall_xm and not iswall_zp) then
		minetest.set_node(pos, {name = "homedecor:cobweb_corner", param2 = 1})

	-- only xm+zm, or only xp+zp means on-ceiling torchlike

	elseif (iswall_xm and iswall_zm and not iswall_xp and not iswall_zp)
	or (iswall_xp and iswall_zp and not iswall_xm and not iswall_zm) then
		minetest.set_node(pos, {name = "homedecor:cobweb_corner", param2 = 0})

	-- only xm+xp means nodebox (not rotated, 0 degrees)

	elseif iswall_xm and iswall_xp and not iswall_zm and not iswall_zp then
		minetest.set_node(pos, {name = "homedecor:cobweb_centered", param2 = 0})

	-- only zm+zp means nodebox rotated to 90 degrees

	elseif iswall_zm and iswall_zp and not iswall_xm and not iswall_xp then
		minetest.set_node(pos, {name = "homedecor:cobweb_centered", param2 = 1})

	-- ok, there aren't any simple two-wall corners or opposing walls.
	-- Are there any standalone walls?

	elseif iswall_xm and not iswall_xp and not iswall_zm and not iswall_zp then
		minetest.set_node(pos, {name = "homedecor:cobweb_flat", param2 = 3})

	elseif iswall_xp and not iswall_xm and not iswall_zm and not iswall_zp then
		minetest.set_node(pos, {name = "homedecor:cobweb_flat", param2 = 1})

	elseif iswall_zm and not iswall_xm and not iswall_xp and not iswall_zp then
		minetest.set_node(pos, {name = "homedecor:cobweb_flat", param2 = 2})

	elseif iswall_zp and not iswall_xm and not iswall_xp and not iswall_zm then
		minetest.set_node(pos, {name = "homedecor:cobweb_flat", param2 = 0})

	-- if all else fails, place the plantlike version as a fallback.

	else
		minetest.set_node(pos, {name = "homedecor:cobweb_plantlike", param2 = 0})
	end

end

-- convert existing cobwebs

minetest.register_abm({
	nodenames = { "homedecor:cobweb" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		homedecor.rotate_cobweb(pos)
	end
})
