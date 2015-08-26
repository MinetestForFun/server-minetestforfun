------------------------
-- PClasses' inventory
--

-- Inventory for 'dead' items
pclasses.api.create_graveyard_inventory = function(player)
	local pname = player:get_player_name()
	local grave_inv = minetest.get_inventory({type = "detached", name = pname .. "_graveyard"})
	if grave_inv then
		return grave_inv
	end
	local player_inv = minetest.get_inventory({type = "player", name = pname})
	grave_inv = minetest.create_detached_inventory(pname .. "_graveyard", {
		on_take = function(inv, listname, index, stack, player)
			player_inv:set_stack(listname, index, nil)
		end,
		on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			local stack = inv:get_stack(to_list, to_index)
			player_inv:set_stack(to_list, to_index, stack)
			player_inv:set_stack(from_list, from_index, nil)
		end,
		allow_take = function(inv, listname, index, stack, player)
			return 0
		end,
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return 0
		end,
		allow_put = function(inv, listname, index, stack, player)
			return 0
		end,
	})
	grave_inv:set_size("graveyard", 7*8)
	player_inv:set_size("graveyard", 7*8)
	for i = 1,56 do
		local stack = player_inv:get_stack("graveyard", i)
		grave_inv:set_stack("graveyard", i, stack)
	end
	return grave_inv
end

unified_inventory.register_button("graveyard", {
	type = "image",
	image = "pclasses_grave_button.png",
	tooltip = "Item Graveyard",
})

unified_inventory.register_page("graveyard", {
	get_formspec = function(player)
		local pname = player:get_player_name()
		local form = "label[0,0;Graveyard]" ..
			"list[detached:" .. pname .. "_graveyard;graveyard;0.5,0.7;7,8]"
		return {formspec = form, draw_inventory = false}
	end
})

minetest.register_chatcommand("clear_graveyard", {
	description = "Clear Graveyard Inventory",
	privs = {},
	func = function(name, param)
		local grave_inv = minetest.get_inventory({type = "detached", name = name .. "_graveyard"})
		grave_inv:set_list("graveyard", {})
		minetest.get_player_by_name(name):get_inventory():set_list("graveyard", {})
		return true, "Graveyard flushed"
	end,
})

function pclasses.api.vacuum_graveyard(player)
	local pname = player:get_player_name()
	local grave_inv = minetest.get_inventory({type = "detached", name = pname .. "_graveyard"})
	local player_inv = minetest.get_inventory({type = "player", name = pname})

	if not grave_inv then return end

	for i = 1,7*8 do
		local stack = grave_inv:get_stack("graveyard", i)
		if pclasses.data.reserved_items[stack:get_name()] and pclasses.api.util.can_have_item(pname, stack:get_name()) then
			grave_inv:set_stack("graveyard", i, nil)
			player_inv:set_stack("graveyard", i, nil)
			if player_inv:room_for_item("main", stack) then
				player_inv:add_item("main", stack)
			else
				minetest.add_item(player:getpos(), stack)
			end
		end
	end
end

