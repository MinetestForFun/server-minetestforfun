--Menu mobs spawner
mobs.shown_spawner_menu = function(player_name)
	local formspec = {"size[8,9]label[2.7,0;Mobs Spawner]"}
	if mobs["spawning_mobs"] ~= nil then
		local Y = 1
		local X = 1
		for name, etat in pairs(mobs["spawning_mobs"]) do
			table.insert(formspec, "item_image_button["..X..","..Y..";1,1;"..name..";"..name..";]")
			X = X+1
			if X > 6 then
				X = 1
				Y = Y+1.2
			end
		end
	end
	table.insert(formspec, "button_exit[3.9,8.5;1.2,1;close;Close]")
	minetest.show_formspec(player_name, "mobs:spawner", table.concat(formspec))
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local player_name = player:get_player_name()
	if not player_name then return end
	if formname == "mobs:spawner" then	
		for f in pairs(fields) do
			if string.find(f, "mobs:") then
				local pos = player:getpos()
				pos.y = pos.y+1
				minetest.add_entity(pos, f)
				return
			end	
		end
	end
end)


if (minetest.get_modpath("unified_inventory")) ~= nil then
	unified_inventory.register_button("menu_mobs", {
		type = "image",
		image = "mobs_dungeon_master_fireball.png",
		tooltip = "Mobs Spawner Menu",
		show_with = "server",
		action = function(player)
			local player_name = player:get_player_name()
			if not player_name then return end
			if minetest.check_player_privs(player_name, {server=true}) then
				mobs.shown_spawner_menu(player_name)
			end
		end,
	})
else
	minetest.register_chatcommand("mobs_spawner", {
		params = "",
		description = "Spawn entity at given (or your) position",
		privs = {server=true},
		func = function(name, param)
			mobs.shown_spawner_menu(name)
		end,
	})	
end
