local timers = {}
local SPAWN_INTERVAL = 10*60


minetest.register_on_chat_message(function(name, message, playername, player)
	local cmd = "/spawn"
	if message:sub(0, #cmd) == cmd then
		if message == '/spawn' then
			local player = minetest.get_player_by_name(name)
			
			-- Checking timers
			local timer_player = os.difftime(os.time(),timers[name])
			if timer_player ~= nil and timer_player < SPAWN_INTERVAL then -- less than x minutes
				minetest.chat_send_player(name, "Please retry later, you used spawn last time less than ".. SPAWN_INTERVAL .." seconds ago.")
				minetest.chat_send_player(name, "Retry in: ".. SPAWN_INTERVAL-timer_player .." seconds.")
				minetest.log("action","Player ".. name .." tried to respawn within forbidden interval.")
				return false
			end

			if minetest.setting_get_pos("static_spawnpoint") then
				minetest.chat_send_player(player:get_player_name(), "Teleporting to spawn...")
				player:setpos(minetest.setting_get_pos("static_spawnpoint"))
				minetest.log("action","Player ".. name .." respawned. Next allowed respawn in ".. SPAWN_INTERVAL .." seconds.")
				timers[name] = os.time()
				return true
			else
				minetest.chat_send_player(player:get_player_name(), "ERROR: No spawn point is set on this server!")
				return false
			end
		end
	end
end)
