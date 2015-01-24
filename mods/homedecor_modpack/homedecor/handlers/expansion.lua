local S = homedecor.gettext

-- selects which node was pointed at based on it being known, and either clickable or buildable_to
local function select_node(pointed_thing)
	local pos = pointed_thing.under
	local def = minetest.registered_nodes[minetest.get_node(pos).name]

	if not def or (not def.on_rightclick and not def.buildable_to) then
		pos = pointed_thing.above
		def = minetest.registered_nodes[minetest.get_node(pos).name]
	end
	return pos, def
end

-- abstract function checking if 2 given nodes can and may be build to a place
local function is_buildable_to(placer_name, pos, def, pos2)
	local def = def or minetest.registered_nodes[minetest.get_node(pos).name]
	local def2 = minetest.registered_nodes[minetest.get_node(pos2).name]

	return def and def.buildable_to and def2 and def2.buildable_to
		and not minetest.is_protected(pos, placer_name)
		and not minetest.is_protected(pos2, placer_name)
end

-- place one or two nodes if and only if both can be placed
local function stack(itemstack, placer, fdir, pos, def, pos2, node1, node2)
	local placer_name = placer:get_player_name() or ""
	if is_buildable_to(placer_name, pos, def, pos2) then
		local fdir = fdir or minetest.dir_to_facedir(placer:get_look_dir())
		minetest.set_node(pos, { name = node1, param2 = fdir })
		node2 = node2 or "air" -- this can be used to clear buildable_to nodes even though we are using a multinode mesh
		minetest.set_node(pos2, { name = node2, param2 = (node2 ~= "air" and fdir) or nil })

		-- temporary check if this is a locked node to set its infotext
		local nodename = itemstack:get_name()
		if string.find(nodename, "_locked") then
			local meta = minetest.get_meta(pos)
			meta:set_string("owner", placer_name)
			meta:set_string("infotext", S("Locked %s (owned by %s)"):format(minetest.registered_nodes[nodename].infotext, placer_name))
		end

		if not homedecor.expect_infinite_stacks then
			itemstack:take_item()
			return itemstack
		end
	end
end

-- Stack one node above another
-- leave the last argument nil if it's one 2m high node
function homedecor.stack_vertically(itemstack, placer, pointed_thing, node1, node2)
	local pos, def = select_node(pointed_thing)
	if def.on_rightclick then
		return def.on_rightclick(pointed_thing.under, minetest.get_node(pos), placer, itemstack)
	end

	local top_pos = { x=pos.x, y=pos.y+1, z=pos.z }

	return stack(itemstack, placer, nil, pos, def, top_pos, node1, node2)
end

-- Stack one door node above another
-- like  homedecor.stack_vertically but tests first if it was placed as a right wing, then uses node1_right and node2_right instead
local fdir_to_left = {
	{ -1,  0 },
	{  0,  1 },
	{  1,  0 },
	{  0, -1 },
}
function homedecor.stack_wing(itemstack, placer, pointed_thing, node1, node2, node1_right, node2_right)
	local pos, def = select_node(pointed_thing)
	if def.on_rightclick then
		return def.on_rightclick(pointed_thing.under, minetest.get_node(pos), placer, itemstack)
	end

	local forceright = placer:get_player_control()["sneak"]
	local fdir = minetest.dir_to_facedir(placer:get_look_dir())

	local is_right_wing = node1 == minetest.get_node({ x = pos.x + fdir_to_left[fdir+1][1], y=pos.y, z = pos.z + fdir_to_left[fdir+1][2] }).name
	if forceright or is_right_wing then
		node1, node2 = node1_right, node2_right
	end

	local top_pos = { x=pos.x, y=pos.y+1, z=pos.z }
	return stack(itemstack, placer, fdir, pos, def, top_pos, node1, node2)
end

-- Place one node right of or behind another
homedecor.fdir_to_right = {
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
	{  0,  1 },
}

homedecor.fdir_to_fwd = {
	{  0,  1 },
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
}

function homedecor.stack_sideways(itemstack, placer, pointed_thing, node1, node2, dir)
	local pos, def = select_node(pointed_thing)
	if def.on_rightclick then
		return def.on_rightclick(pointed_thing.under, minetest.get_node(pos), placer, itemstack)
	end

	local fdir = minetest.dir_to_facedir(placer:get_look_dir())
	local fdir_transform = dir and homedecor.fdir_to_right or homedecor.fdir_to_fwd

	local pos2 = { x = pos.x + fdir_transform[fdir+1][1], y=pos.y, z = pos.z + fdir_transform[fdir+1][2] }

	return stack(itemstack, placer, fdir, pos, def, pos2, node1, node2)
end
