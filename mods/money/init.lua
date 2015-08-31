--[[
	Mod by Kotolegokot and Xiong (2012-2013)
	Rev. kilbith and nerzhul (2015)
]]

money = {}

dofile(minetest.get_modpath("money") .. "/settings.txt") -- Loading settings.

local function has_shop_privilege(meta, player)--Does player have permissions for this shop?
	return player:get_player_name() == meta:get_string("owner") or minetest.get_player_privs(player:get_player_name())["money_admin"]
end

minetest.register_craft({
	output = "money:shop",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:mese", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
	},
})

minetest.register_alias("shop", "money:shop")

minetest.register_privilege("money_admin", {
	description = "Has access to admin shops",
	give_to_singleplayer = false
})

--Barter shop.
minetest.register_node("money:barter_shop", {
	description = "Barter Shop",
	tiles = {"money_barter_shop.png"},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name())
		meta:set_string("infotext", "Untuned Barter Shop (owned by " .. placer:get_player_name() .. ")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "size[8,5.6]"..
			"field[0.256,0.5;8,1;bartershopname;Name of your barter shop:;]"..
			"field[0.256,1.5;8,1;nodename1;What kind of a node do you want to exchange:;]"..
			"field[0.256,2.5;8,1;nodename2;for:;]"..
			"field[0.256,3.5;8,1;amount1;Amount of first kind of node:;]"..
			"field[0.256,4.5;8,1;amount2;Amount of second kind of node:;]"..
			"button_exit[3.1,5;2,1;button;Proceed]")
		meta:set_string("infotext", "Untuned Barter Shop")
		meta:set_string("owner", "")
		meta:set_string("form", "yes")
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main") and (meta:get_string("owner") == player:get_player_name() or minetest.get_player_privs(player:get_player_name())["money_admin"])
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not has_shop_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a barter shop belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_shop_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a barter shop belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_shop_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a barter shop belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
    on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in barter shop at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to barter shop at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, count, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from barter shop at "..minetest.pos_to_string(pos))
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		if meta:get_string("form") == "yes" then
			if fields.bartershopname ~= "" and minetest.registered_items[fields.nodename1] and minetest.registered_items[fields.nodename2] and tonumber(fields.amount1) and tonumber(fields.amount1) >= 1 and tonumber(fields.amount2) and tonumber(fields.amount2) >= 1 and (meta:get_string("owner") == sender:get_player_name() or minetest.get_player_privs(sender:get_player_name())["money_admin"]) then
				meta:set_string("formspec", "size[8,10;]"..
					"list[context;main;0,0;8,4;]"..
					"label[0.256,4.5;"..fields.amount2.." "..fields.nodename2.." --> "..fields.amount1.." "..fields.nodename1.."]"..
					"button[3.1,5;2,1;button;Exchange]"..
					"list[current_player;main;0,6;8,4;]")
				meta:set_string("bartershopname", fields.bartershopname)
				meta:set_string("nodename1", fields.nodename1)
				meta:set_string("nodename2", fields.nodename2)
				meta:set_string("amount1", fields.amount1)
				meta:set_string("amount2", fields.amount2)
				meta:set_string("infotext", "Barter Shop \"" .. fields.bartershopname .. "\" (owned by " .. meta:get_string("owner") .. ")")
				local inv = meta:get_inventory()
				inv:set_size("main", 8*4)
				meta:set_string("form", "no")
			end
		elseif fields["button"] then
			local sender_name = sender:get_player_name()
			local inv = meta:get_inventory()
			local sender_inv = sender:get_inventory()
			if not inv:contains_item("main", meta:get_string("nodename1") .. " " .. meta:get_string("amount1")) then
				minetest.chat_send_player(sender_name, "In the barter shop is not enough goods.")
				return
			elseif not sender_inv:contains_item("main", meta:get_string("nodename2") .. " " .. meta:get_string("amount2")) then
				minetest.chat_send_player(sender_name, "In your inventory is not enough goods.")
				return
			elseif not inv:room_for_item("main", meta:get_string("nodename2") .. " " .. meta:get_string("amount2")) then
				minetest.chat_send_player(sender_name, "In the barter shop is not enough space.")
				return
			elseif not sender_inv:room_for_item("main", meta:get_string("nodename1") .. " " .. meta:get_string("amount1")) then
				minetest.chat_send_player(sender_name, "In your inventory is not enough space.")
				return
			end
			inv:remove_item("main", meta:get_string("nodename1") .. " " .. meta:get_string("amount1"))
			sender_inv:remove_item("main", meta:get_string("nodename2") .. " " .. meta:get_string("amount2"))
			inv:add_item("main", meta:get_string("nodename2") .. " " .. meta:get_string("amount2"))
			sender_inv:add_item("main", meta:get_string("nodename1") .. " " .. meta:get_string("amount1"))
			minetest.chat_send_player(sender_name, "You exchanged " .. meta:get_string("amount2") .. " " .. meta:get_string("nodename2") .. " on " .. meta:get_string("amount1") .. " " .. meta:get_string("nodename1") .. ".")
		end
	end,
})
--End.

minetest.register_craft({--Barter shop recipe.
	output = "money:barter_shop",
	recipe = {
		{"locked_sign:sign_wall_locked"},
		{"default:chest_locked"},
	},
})

minetest.register_alias("barter_shop", "money:barter_shop")


-- Admin barter shop
minetest.register_node("money:admin_barter_shop", {
	description = "Admin Barter Shop",
	tiles = {"money_admin_barter_shop.png"},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "size[8,4.6]"..
			"field[0.256,0.5;8,1;nodename1;What kind of a node do you want to exchange:;]"..
			"field[0.256,1.5;8,1;nodename2;for:;]"..
			"field[0.256,2.5;8,1;amount1;Amount of first kind of node:;]"..
			"field[0.256,3.5;8,1;amount2;Amount of second kind of node:;]"..
			"button_exit[3.1,4;2,1;button;Proceed]")
		meta:set_string("infotext", "Untuned Admin Barter Shop")
		meta:set_string("form", "yes")
	end,
	can_dig = function(pos,player)
		return minetest.get_player_privs(player:get_player_name())["money_admin"]
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		if meta:get_string("form") == "yes" then
			if minetest.registered_items[fields.nodename1] and minetest.registered_items[fields.nodename2] and tonumber(fields.amount1) and tonumber(fields.amount1) >= 1 and tonumber(fields.amount2) and tonumber(fields.amount2) >= 1 and (meta:get_string("owner") == sender:get_player_name() or minetest.get_player_privs(sender:get_player_name()).money_admin) then
				meta:set_string("formspec", "size[8,6;]"..
					"label[0.256,0.0;"..fields.amount2.." "..fields.nodename2.." --> "..fields.amount1.." "..fields.nodename1.."]"..
					"button[3.1,0.5;2,1;button;Exchange]"..
					"list[current_player;main;0,1.5;8,4;]")
				meta:set_string("nodename1", fields.nodename1)
				meta:set_string("nodename2", fields.nodename2)
				meta:set_string("amount1", fields.amount1)
				meta:set_string("amount2", fields.amount2)
				meta:set_string("infotext", "Admin Barter Shop")
				meta:set_string("form", "no")
			end
		elseif fields["button"] then
			local sender_name = sender:get_player_name()
			local sender_inv = sender:get_inventory()
			if not sender_inv:contains_item("main", meta:get_string("nodename2") .. " " .. meta:get_string("amount2")) then
				minetest.chat_send_player(sender_name, "In your inventory is not enough goods.")
				return
			elseif not sender_inv:room_for_item("main", meta:get_string("nodename1") .. " " .. meta:get_string("amount1")) then
				minetest.chat_send_player(sender_name, "In your inventory is not enough space.")
				return
			end
			sender_inv:remove_item("main", meta:get_string("nodename2") .. " " .. meta:get_string("amount2"))
			sender_inv:add_item("main", meta:get_string("nodename1") .. " " .. meta:get_string("amount1"))
			minetest.chat_send_player(sender_name, "You exchanged " .. meta:get_string("amount2") .. " " .. meta:get_string("nodename2") .. " on " .. meta:get_string("amount1") .. " " .. meta:get_string("nodename1") .. ".")
		end
	end,
})
--End.

minetest.register_alias("admin_barter_shop", "money:admin_barter_shop")

minetest.log("action", "[Money] Loaded")
