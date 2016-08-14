--rewrite function minetest.rotate_node(itemstack, placer, pointed_thing) to refill inventory
local old_rotate_node = minetest.rotate_node
function minetest.rotate_node(itemstack, placer, pointed_thing)
	local stack_name = itemstack:get_name()
	local ret = old_rotate_node(itemstack, placer, pointed_thing)
	if  ret:get_count() == 0 and not minetest.setting_getbool("creative_mode") then
		local index = placer:get_wield_index()
		local inv = placer:get_inventory()
		if inv:get_list("main") then
			for i, stack in ipairs(inv:get_list("main")) do
				if i ~= index and stack:get_name() == stack_name then
					ret:add_item(stack)
					stack:clear()
					inv:set_stack("main", i, stack)
					minetest.log("action", "Inventory Tweaks: refilled stack("..stack_name..") of "  .. placer:get_player_name())
					break
				end
			end
		end
	end
	return ret
end
