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
			player_inv:set_stack(listname, index, nil)
			return stack:get_count()
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

-- Inventory description buttons
local pbutton_form = "size[10,10]" ..
   "button_exit[4.5,9.5;1,0.5;pmenu_leave;Leave]" ..
   "tabheader[0,0;pmenu_header;infos"

function pclasses.api.textify(text)
	return ("textarea[0.5,0.2;9.6,5.8;pmenu_data;;%s]"):format(text)
end

local pbuttons = {}
local pforms = {}
local pinfo = pclasses.api.textify(
      "PClasses (Player Classes) allows you to become a member of specific classes implemented " ..
      "with abilities, advantages, and reserved items. Each one of the classes defined grants " ..
      "the right to carry items, called reserved items, tied to the abilities of a class. A " ..
      "hunter will be able to use arrows, whereas a warrior can own powerful weapons. Each time " ..
      "you switch classes, you will lose your stats and items, the latter being transfered into " ..
      "a special part of your inventory, the graveyard. Once you return to a class that allows " ..
      "you to use those items, they will return in your main inventory.\n" ..
      "You can use this menu to navigate between classes and read informations about what " ..
      "abilities come with specific classes.\n" ..
      "You can see on this man the location of all class buildings available, containing their " ..
      "respective class pedestals."
) .. "image[2.4,5.6;6,4;pclasses_buildings.png]"


minetest.after(0, function()
		  for cname, cdef in pairs(pclasses.classes) do
		     if cname ~= pclasses.conf.superuser_class then
			pbutton_form = pbutton_form .. ',' .. cname
			table.insert(pbuttons, cname)
		     end
		  end
		  pbutton_form = pbutton_form .. ";1]"
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
      if formname ~= "" then return end

      if fields.pmenu_header then
	 if fields.pmenu_header + 0 == 1 then
	    player:set_inventory_formspec(pbutton_form .. pinfo)
	 else
	    player:set_inventory_formspec(string.sub(pbutton_form, 1, -3) .. fields.pmenu_header .. "]" .. (pclasses.classes[pbuttons[fields.pmenu_header-1]].informations or "No informations available"))
	 end
	 return

      elseif fields.pmenu_leave then
	 player:set_inventory_formspec(pforms[player:get_player_name()])
	 pforms[player:get_player_name()] = nil
      end
end)

unified_inventory.register_button("pclasses", {
				  type = "image",
				  image = "pclasses_inv.png",
				  tooltip = "Player Classes Descriptions",
				  action = function(player)
				      if not pforms[player:get_player_name()] then
					 pforms[player:get_player_name()] = player:get_inventory_formspec()
					 player:set_inventory_formspec(pbutton_form .. pinfo)
				      end
				   end
})
