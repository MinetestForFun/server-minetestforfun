minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
	if newnode.name ~= "default:torch" or minetest.get_item_group(oldnode.name, "water") == 0 then
		return
	end
	minetest.remove_node(pos, newnode)
	minetest.set_node(pos, oldnode)
	minetest.add_item(pos, "default:torch")
end)
