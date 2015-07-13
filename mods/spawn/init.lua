local SPAWN_INTERVAL = 5*60


minetest.register_chatcommand("spawn", {
	description = "Teleport a player to the defined spawnpoint",
	func = function(name)
		local player = minetest.get_player_by_name(name)

		local function go_to_spawn()
			if minetest.setting_get_pos("static_spawnpoint") then
				minetest.chat_send_player(player:get_player_name(), "Teleporting to spawn...")
				player:setpos(minetest.setting_get_pos("static_spawnpoint"))
				minetest.log("action","Player ".. name .." respawned. Next allowed respawn in ".. SPAWN_INTERVAL .." seconds.")
				return true
			else
				minetest.chat_send_player(player:get_player_name(), "ERROR: No spawn point is set on this server!")
				return false
			end
		end

		-- Checking timers
		if not action_timers.api.get_timer("spawn_" .. name) then
			action_timers.api.register_timer("spawn_" .. name, SPAWN_INTERVAL)
			return go_to_spawn()
		else
			local res = action_timers.api.do_action("spawn_" .. name, go_to_spawn)
			print(res)
			if tonumber(res) then
				minetest.chat_send_player(name, "Please retry later, you used spawn last time less than ".. SPAWN_INTERVAL .." seconds ago.")
				minetest.chat_send_player(name, "Retry in: ".. math.floor(res) .." seconds.")
				minetest.log("action","Player ".. name .." tried to respawn within forbidden interval.")
				return false
			else
				return res
			end
		end
	end
})
