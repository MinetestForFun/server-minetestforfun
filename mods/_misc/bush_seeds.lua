minetest.register_craftitem(":bushes:youngtree", {
	description = "Young tree",
	inventory_image = "bushes_youngtree.png",
	on_place = function(stack, user, pointed_thing)
		if pointed_thing.type ~= "node" then return end
		local pos = pointed_thing.under
	
		for y = 1, 4 do
			local m = 0
			if (y > 2) then m = 1 end
			for z = 0, m do
				if minetest.get_node({x = pos.x, y = pos.y+y, z = pos.z+z}).name ~= "air" or minetest.is_protected({x = pos.x, y = pos.y+y, z = pos.z+z}, user:get_player_name()) then
					return
				end
			end
		end
	
		abstract_bushes.grow_youngtree_node2(pointed_thing.under, 4)
		stack:set_count(stack:get_count() - 1)
		return stack
	end,
})

minetest.register_craft({
	output = "bushes:youngtree",
	recipe = {
		{"bushes:BushLeaves1", "default:stick", "bushes:BushLeaves1"},
		{"", "default:stick", ""},
		{"", "default:stick", ""},
	},
})
