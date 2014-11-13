--Sprint mod for Minetest by GunshipPenguin

--Configuration variables, these are all explained in README.md
local SPRINT_SPEED = 1.35
local SPRINT_JUMP = 1.1
local SPRINT_STAMINA = 10
local SPRINT_TIMEOUT = 0.5
local SPRINT_WARN = true
STOP_ON_CLICK = true --If true, sprinting will stop when either the left mouse button or the right mouse button is pressed

local players = {}

minetest.register_on_joinplayer(function(player)
	players[player:get_player_name()] = {state = 0, timeOut = 0, stamina = SPRINT_STAMINA, moving = false}
end)
minetest.register_on_leaveplayer(function(player)
	playerName = player:get_player_name()
	players[playerName] = nil
end)
minetest.register_globalstep(function(dtime)
	--Get the gametime
	local gameTime = minetest.get_gametime()

	--Loop through all connected players
	for playerName,playerInfo in pairs(players) do
		local player = minetest.get_player_by_name(playerName)
		if player ~= nil then
			--Check if they are moving or not
			players[playerName]["moving"] = player:get_player_control()["up"]
			-- s'arrete si le joueur fait un clique gauche ou droit
			if player:get_player_control()["RMB"] or player:get_player_control()["LMB"] and STOP_ON_CLICK == true then
				players[playerName]["state"] = 0
				player:set_physics_override({speed=1.0, jump=1.0})
			end
			--If the player has tapped w longer than SPRINT_TIMEOUT ago, set his/her state to 0
			if playerInfo["state"] == 2 then
				if playerInfo["timeOut"] + SPRINT_TIMEOUT < gameTime then
					players[playerName]["timeOut"] = nil
					setState(playerName, 0)
				end

			--If the player is sprinting, create particles behind him/her 
			elseif playerInfo["state"] == 3 and gameTime % 0.1 == 0 then
				local numParticles = math.random(1, 2)
				local playerPos = player:getpos()
				local playerNode = minetest.get_node({x=playerPos["x"], y=playerPos["y"]-1, z=playerPos["z"]})
				if playerNode["name"] ~= "air" then
					for i=1, numParticles, 1 do
						minetest.add_particle({
							pos = {x=playerPos["x"]+math.random(-1,1)*math.random()/2,y=playerPos["y"]+0.1,z=playerPos["z"]+math.random(-1,1)*math.random()/2},
							vel = {x=0, y=5, z=0},
							acc = {x=0, y=-13, z=0},
							expirationtime = math.random(),
							size = math.random()+0.5,
							collisiondetection = true,
							vertical = false,
							texture = "default_dirt.png",
						})
					end
				end
			end

			--Adjust player states
			if players[playerName]["moving"] == false and playerInfo["state"] == 3 then --Stopped
				setState(playerName, 0)
			elseif players[playerName]["moving"] == true and playerInfo["state"] == 0 then --Moving
				setState(playerName, 1)
			elseif players[playerName]["moving"] == false and playerInfo["state"] == 1 then --Primed
				setState(playerName, 2)
			elseif players[playerName]["moving"] == true and playerInfo["state"] == 2 then --Sprinting
				setState(playerName, 3)
			end
			
			--Lower the player's stamina by dtime if he/she is sprinting and set his/her state to 0 if stamina is zero
			if playerInfo["state"] == 3 then 
				playerInfo["stamina"] = playerInfo["stamina"] - dtime
				if playerInfo["stamina"] <= 0 then
					playerInfo["stamina"] = 0
					setState(playerName, 0)
					if SPRINT_WARN then
						minetest.chat_send_player(playerName, "Votre sprint s'arrete, plus d'endurance ! Your sprint stamina has run out !")
					end
				end
			
			--Increase player's stamina if he/she is not sprinting and his/her stamina is less than SPRINT_STAMINA
			elseif playerInfo["state"] ~= 3 and playerInfo["stamina"] < SPRINT_STAMINA then
				playerInfo["stamina"] = playerInfo["stamina"] + dtime
			end
		end
	end
end)

function setState(playerName, state) --Sets the state of a player (0=stopped, 1=moving, 2=primed, 3=sprinting)
	local player = minetest.get_player_by_name(playerName)
	local gameTime = minetest.get_gametime()
	if players[playerName] then
		players[playerName]["state"] = state
		if state == 0 then--Stopped
			player:set_physics_override({speed=1.0,jump=1.0})
		elseif state == 2 then --Primed
			players[playerName]["timeOut"] = gameTime
		elseif state == 3 then --Sprinting
			player:set_physics_override({speed=SPRINT_SPEED,jump=SPRINT_JUMP})
		end
		return true
	end
	return false
end
