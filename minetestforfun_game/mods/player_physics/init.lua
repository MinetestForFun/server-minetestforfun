local players = {}
player_physics = {}


function player_physics.check(playerName)
	if players[playerName] == nil then
		players[playerName] = {speed = {}, jump = {}, gravity={}, temp={}}
	end
end


minetest.register_on_joinplayer(function(player)
	local playerName = player:get_player_name()
	player_physics.check(playerName)
end)


minetest.register_on_leaveplayer(function(player)
	local playerName = player:get_player_name()
	players[playerName] = nil
end)


function player_physics.set_stats(player, uuid, stats)
	if type(stats) ~= "table" then
		minetest.log("error", "player_physics: set_stats(player, uuid, stat) stats must be table(eg:{speed=1})")
		return
	end
	local playerName = player:get_player_name()
	player_physics.check(playerName)
	for stat, v in pairs(stats) do
		if (stat == "speed" or stat == "jump" or stat == "gravity") and type(v) == "number" then
			players[playerName][stat][uuid] = v
		end
	end
end


function player_physics.remove_stats(player, uuid)
	local playerName = player:get_player_name()
	player_physics.check(playerName)
	for _, stat in pairs({"speed", "jump", "gravity"}) do
		players[playerName][stat][uuid] = nil
	end
end


function player_physics.add_effect(player, uuid, time, stats)
	if type(stats) ~= "table" then
		minetest.log("error", "player_physics: add_effect(player, uuid, time, stats) stats must be table(eg:{speed=1})")
		return
	end
	if type(time) ~= "number" then
		minetest.log("error", "player_physics: add_effect(player, uuid, time, stats) time must be number")
		return
	end
	local playerName = player:get_player_name()
	player_physics.check(playerName)
	for stat, v in pairs(stats) do
		if (stat == "speed" or stat == "jump" or stat == "gravity") and type(v) == "number" then
			players[playerName]["temp"][uuid][stat] = {value=v, time=time}
		end
	end
end


function player_physics.remove_effect(player, uuid)
	local playerName = player:get_player_name()
	player_physics.check(playerName)
	players[playerName]["temp"][uuid] = nil
end


minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		local playerName = player:get_player_name()
		if playerName ~= "" then
			player_physics.check(playerName)
			local stats ={speed=1, jump=1, gravity=1}

			for _, stat in pairs({"speed", "jump", "gravity"}) do
				for uuid, v in pairs(players[playerName][stat]) do
					stats[stat] = stats[stat] + v
				end
			end

			--temporary effect
			for uuid, _ in pairs(players[playerName]["temp"]) do
				for stat, v in pairs(players[playerName]["temp"][uuid]) do
					stats[stat] = stats[stat] + v.value
					local t = v.time-dtime
					if t > 0 then
						players[playerName]["temp"][uuid][stat].time = t
					else
						players[playerName]["temp"][uuid][stat] = nil
					end
				end
			end --/temporary effect

			if stats.speed > 4 then
				stats.speed = 4
			elseif stats.speed < 0 then
				stats.speed = 0
			end

			if stats.jump > 3 then
				stats.jump = 3
			elseif stats.jump < 0 then
				stats.jump = 0
			end

			if stats.gravity > 2 then
				stats.gravity = 2
			elseif stats.gravity < -2 then
				stats.gravity = -2
			end
			player:set_physics_override(stats)
		end
	end
end)

