--[[

Inventory Plus for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-particles
License: GPLv3

Cisun: Author of inventory_plus_armor_shield.png (WTPFL)
Wuzzy: Author of inventory_plus_crafting_icon.png (WTFPL)
Other texture files made by Jordach (CC-BY-SA 3.0).

]]--


-- expose api
inventory_plus = {}

-- define buttons
inventory_plus.buttons = {}
inventory_plus.buttons_ordered = {}

-- default inventory page
inventory_plus.default = minetest.setting_get("inventory_default") or "main"

-- register_button
inventory_plus.register_button = function(player,name,label)
	local player_name = player:get_player_name()
	if inventory_plus.buttons[player_name] == nil then
		inventory_plus.buttons[player_name] = {["main"] = "Main"}
	end
	if inventory_plus.buttons_ordered[player_name] == nil then
		inventory_plus.buttons_ordered[player_name] = {[1]="main"}
	end
	if inventory_plus.buttons[player_name][name] == nil then
		inventory_plus.buttons[player_name][name] = label
		table.insert(inventory_plus.buttons_ordered[player_name], name)
	end
end

inventory_plus.is_called = function(fields, compare_tabidname, player)
	local player_name = player:get_player_name()
	local input_id = tonumber(fields.inventory_plus_tabs)
	if input_id ~= nil and inventory_plus.buttons_ordered[player_name][input_id] == compare_tabidname then
		return true
	else
		return false
	end
end

-- set_inventory_formspec
inventory_plus.set_inventory_formspec = function(player,formspec)
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	if privs.hg_maker then
		-- if creative mode is on then wait a bit
		minetest.after(0.1,function(tbl)
			local player = minetest.get_player_by_name(tbl.name)
			if player ~= nil then
				player:set_inventory_formspec(tbl.formspec)
			end
		end, {name=name, formspec=formspec})
	else
		player:set_inventory_formspec(formspec)
	end
end

inventory_plus.get_tabheader = function(player,tabidname)
	local name = player:get_player_name()
	local tabheader = "tabheader[0,0;inventory_plus_tabs;"
	local bord = inventory_plus.buttons_ordered[name]
	local tabid
	if bord == nil or #bord == 1 then
		return ""
	end
	for i=1,#bord do
		local bordi = bord[i]
		if bordi == tabidname then
			tabid = i
		end
		local tabname = inventory_plus.buttons[name][bordi]
		tabheader = tabheader .. tabname
		if i~=#inventory_plus.buttons_ordered[name] then
			tabheader = tabheader .. ","
		end
	end
	tabheader = tabheader .. ";"..tostring(tabid)..";false;true]"
	return tabheader
end

-- get_formspec
inventory_plus.get_formspec = function(player,page)
	local f = {}
	local fp = #f
	fp = fp + 1
	f[fp] = "size[9,8.5]"
	fp = fp + 1
	f[fp] = default.inventory_background
	fp = fp + 1
	f[fp] = default.inventory_listcolors

	-- player inventory
	fp = fp + 1
	f[fp] = "box[0.3,4.2;8.2,4.5;#FFFFFF40]"
	fp = fp + 1
	f[fp] = "label[0.5,4.2;Inventory]"
	fp = fp + 1
	f[fp] = "list[current_player;main;0.5,4.7;8,4;]"

	-- main page
	if page=="main" then

		local name = player:get_player_name()
		-- tabs
		local tabheader = inventory_plus.get_tabheader(player,page)
		fp = fp + 1
		f[fp] = tabheader

		-- armor
		fp = fp + 1
		f[fp] = "box[-0.1,-0.1;4.1,4.1;#FFFFFF40]"
		fp = fp + 1
		f[fp] = "label[0,-0.1;Armor]"
		fp = fp + 1
		f[fp] = "image[0,0;1,1;inventory_plus_armor_head.png]"
		fp = fp + 1
		f[fp] = "image[0,1;1,1;inventory_plus_armor_torso.png]"
		fp = fp + 1
		f[fp] = "image[0,2;1,1;inventory_plus_armor_legs.png]"
		fp = fp + 1
		f[fp] = "image[0,3;1,1;inventory_plus_armor_feet.png]"
		fp = fp + 1
		f[fp] = "image[1,1;1,1;inventory_plus_armor_shield.png]"
		fp = fp + 1
		f[fp] = "list[detached:"..name.."_armor;armor;2,0;1,1;1]"
		fp = fp + 1
		f[fp] = "list[detached:"..name.."_armor;armor;2,1;1,1;2]"
		fp = fp + 1
		f[fp] = "list[detached:"..name.."_armor;armor;2,2;1,1;3]"
		fp = fp + 1
		f[fp] = "list[detached:"..name.."_armor;armor;2,3;1,1;4]"
		fp = fp + 1
		f[fp] = "list[detached:"..name.."_armor;armor;3,1;1,1;5]"

		-- crafting
		fp = fp + 1
		f[fp] = "box[4.4,0;4.6,3.5;#FFFFFF40]"
		fp = fp + 1
		f[fp] = "label[4.5,0;Crafting]"
		fp = fp + 1
		f[fp] = "image[7.5,1.5;0.5,1;inventory_plus_crafting_icon.png]"
		fp = fp + 1
		f[fp] = "list[current_player;craftpreview;8,1.5;1,1;]"
		if minetest.setting_getbool("inventory_craft_small") then
			fp = fp + 1
			f[fp] = "list[current_player;craft;4.5,0.5;2,2;]"
			player:get_inventory():set_width("craft", 2)
			player:get_inventory():set_size("craft", 2*2)
		else
			fp = fp + 1
			f[fp] = "list[current_player;craft;4.5,0.5;3,3;]"
			player:get_inventory():set_width("craft", 3)
			player:get_inventory():set_size("craft", 3*3)
		end
	end

	return table.concat(f, "")
end

-- trash slot
inventory_plus.trash = minetest.create_detached_inventory("trash", {
	allow_put = function(inv, listname, index, stack, player)
		if minetest.setting_getbool("creative_mode") then
			return stack:get_count()
		else
			return 0
		end
	end,
	on_put = function(inv, listname, index, stack, player)
		inv:set_stack(listname, index, nil)
	end,
})
inventory_plus.trash:set_size("main", 1)

-- refill slot
inventory_plus.refill = minetest.create_detached_inventory("refill", {
	allow_put = function(inv, listname, index, stack, player)
		local privs = minetest.get_player_privs(name)
		if privs.hg_maker then
			return stack:get_count()
		else
			return 0
		end
	end,
	on_put = function(inv, listname, index, stack, player)
		inv:set_stack(listname, index, ItemStack(stack:get_name().." "..stack:get_stack_max()))
	end,
})
inventory_plus.refill:set_size("main", 1)

-- register_on_joinplayer
minetest.register_on_joinplayer(function(player)
	if minetest.setting_getbool("inventory_craft_small") then
		player:get_inventory():set_width("craft", 2)
		player:get_inventory():set_size("craft", 2*2)
	else
		player:get_inventory():set_width("craft", 3)
		player:get_inventory():set_size("craft", 3*3)
	end
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	minetest.after(1,function(name)
		local player = minetest.get_player_by_name(name)
		if player ~= nil then
			inventory_plus.set_inventory_formspec(player,inventory_plus.get_formspec(player, inventory_plus.default))
		end
	end, name)
end)

-- register_on_player_receive_fields
minetest.register_on_player_receive_fields(function(player, formname, fields)
	-- main
	if inventory_plus.is_called(fields, "main", player) then
		inventory_plus.set_inventory_formspec(player, inventory_plus.get_formspec(player,"main"))
	end
end)

-- log that we started
minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))
