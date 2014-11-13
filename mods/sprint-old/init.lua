--Sprint mod for minetest by GunshipPenguin

--CHANGE THESE VARIABLES TO ADJUST SPRINT SPEED/JUMP HEIGHT
--1 represents normal speed/jump height so 1.5 would mean 50% more and 2.0 would be 100% more
SPRINT_SPEED = 1.30 --Speed while sprinting
SPRINT_JUMP = 1.10 --Jump height while sprinting
STOP_ON_CLICK = true --If true, sprinting will stop when either the left mouse button or the right mouse button is pressed

players = {}
minetest.register_on_joinplayer(function(player)
	players[player:get_player_name()] = {state = 0, timeOut = 0}
end)
minetest.register_on_leaveplayer(function(player)
	playerName = player:get_player_name()
	players[playerName] = nil
end)
minetest.register_globalstep(function(dtime)

	--Loop through all connected players
	for playerName,playerInfo in pairs(players) do
	
		player = minetest.get_player_by_name(playerName)
		if player ~= nil then
			playerMovement = player:get_player_control()["up"]
			if player:get_player_control()["RMB"] or player:get_player_control()["LMB"] and STOP_ON_CLICK == true then
				players[playerName]["state"] = 0
				player:set_physics_override({speed=1.0, jump=1.0})
			end			

			if playerInfo["state"] == 2 then
				players[playerName]["timeOut"] = players[playerName]["timeOut"] + 1
				if playerInfo["timeOut"] == 10 then
					players[playerName]["timeOut"] = 0
					players[playerName]["state"] = 0
				end
			end

			if playerMovement == false and playerInfo["state"] == 3 then --Stopped
				players[playerName]["state"] = 0
				player:set_physics_override({speed=1.0,jump=1.0})
			elseif playerMovement == true and playerInfo["state"] == 0 then --Moving
				players[playerName]["state"] = 1
			elseif playerMovement == false and playerInfo["state"] == 1 then --Primed
				players[playerName]["state"] = 2
			elseif playerMovement == true and playerInfo["state"] == 2 then --Sprinting
				players[playerName]["state"] = 3
				player:set_physics_override({speed=SPRINT_SPEED,jump=SPRINT_JUMP})
			end
		end
	end
end)
