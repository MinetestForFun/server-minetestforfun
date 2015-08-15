-------------------------------------
-- Eject entities when placing node
--

unwalkable_nodes = {}

minetest.after(0, function()
	for itemname, node in pairs(minetest.registered_nodes) do
		if node.walkable == false then
			table.insert(unwalkable_nodes, 1, itemname)
		end
	end
end)

minetest.register_on_placenode(function(pos)
	local objs = minetest.get_objects_inside_radius(pos, 1)
	local minp, maxp = {x=pos.x-1, y=pos.y, z=pos.z-1}, {x=pos.x+1, y=pos.y+1, z=pos.z+1}
	local nodes = minetest.find_nodes_in_area(minp, maxp, unwalkable_nodes)
	if table.getn(nodes) == 0 then
		return
	end
	for _,obj in pairs(objs) do
		if not obj:is_player() and obj:get_entity_name() == "builtin:item" then
			obj:setpos(nodes[math.random(1,#nodes)])
		end
	end
end)

