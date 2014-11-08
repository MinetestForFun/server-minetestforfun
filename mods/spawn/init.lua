minetest.register_on_chat_message(function(name, message, playername, player)
	local cmd = "/spawn"
	if message:sub(0, #cmd) == cmd then
		if message == '/spawn' then
			local player = minetest.get_player_by_name(name)
			if minetest.setting_get_pos("static_spawnpoint") then
				minetest.chat_send_player(player:get_player_name(), "Teleporting to spawn...")
				player:setpos(minetest.setting_get_pos("static_spawnpoint"))
			else
				minetest.chat_send_player(player:get_player_name(), "ERROR: No spawn point is set on this server!")
			end
			return true
		end
	end
end)
