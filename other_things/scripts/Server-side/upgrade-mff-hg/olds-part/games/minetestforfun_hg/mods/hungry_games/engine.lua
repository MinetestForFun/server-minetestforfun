local votes = 0
local starting_game = false
local ingame = false
local force_init_warning = false
local grace = false
local countdown = false

minetest.register_privilege("ingame",{description = "privs when player is in current game HG.", give_to_singleplayer = false})

local registrants = {}
local voters = {}
local voters_hud = {}
local currGame = {}
local gameSequenceNumber = 0	--[[ Sequence number of current round, will be incremented each round.
				     Used to determine whether minetest.after calls are still valid or should be discarded. ]]
local voteSequenceNumber = 0

local spots_shuffled = {}

local timer_hudids = {}

local timer = nil
local timer_updated = nil
local timer_mode = nil	-- nil, "vote", "starting", "grace"

local maintenance_mode = false		-- is true when server is in maintenance mode, no games can be started while in maintenance mode

-- Initial setup
minetest.setting_set("enable_damage", "false")
survival.disable()

hb.register_hudbar("votes", 0xFFFFFF, "Votes", { bar = "hungry_games_votebar.png", icon = "hungry_games_voteicon.png" }, 0, 0, false)

local update_timer_hud = function(text)
	local players = minetest.get_connected_players()
	for i=1,#players do
		local player = players[i]
		local name = player:get_player_name()
		if timer_hudids[name] ~= nil then
			player:hud_change(timer_hudids[name], "text", text)
		end
	end
end

local set_timer = function(name, time)
	timer_mode = name
	timer = time
	timer_updated = nil
end

local unset_timer = function()
	timer_mode = nil
	timer_updated = nil
	update_timer_hud("")
end

local refill_chests
refill_chests = function(args) --When called with just a gameSequenceNumber, starts a countdown to chest refill, refills chests after hungry_games.chest_refill_interval, and then starts another countdown. Does NOT refill chests when called initially
	local gsn = args[1]
	local refill = args[2] --Flag: if true, then refill chests and start countdown to next refill, if false, just start countdown to next refill
	if gsn ~= gameSequenceNumber or not ingame then
		return
	else
		if refill then
			minetest.chat_send_all("Refilling chests")
			random_chests.refill()
		end

		if hungry_games.chest_refill_interval == -1 then --If chest refilling is disabled, just refill once
			return
		else
			unset_timer()
			set_timer("chest_refill", hungry_games.chest_refill_interval)
			minetest.after(hungry_games.chest_refill_interval, refill_chests, {gsn, true})
		end
	end
end

local end_grace = function(gsn)
	if ingame and gsn == gameSequenceNumber then
		minetest.setting_set("enable_pvp", "true")
		minetest.chat_send_all("Grace period over!")
		grace = false
		unset_timer()
		refill_chests({gameSequenceNumber})
		minetest.sound_play("hungry_games_grace_over")
	end
end

local needed_votes = function()
	local num = #minetest.get_connected_players()
	if num <= hungry_games.vote_unanimous then
		return num
	else
		return math.ceil(num*hungry_games.vote_percent)
	end
end

local update_votebars = function()
	local players = minetest.get_connected_players()
	for i=1, #players do
		hb.change_hudbar(players[i], "votes", votes, needed_votes())
		if #players < 2 or ingame or starting_game or maintenance_mode then
			hb.hide_hudbar(players[i], "votes")
		else
			hb.unhide_hudbar(players[i], "votes")
		end
	end
end

local drop_player_items = function(playerName, clear) --If clear != nil, don't drop items, just clear inventory
	if not playerName then
		return
	end

	local player = minetest.get_player_by_name(playerName)

	if not player then
		return
	end

	local pos = player:getpos()
	local inv = player:get_inventory()

	if not clear then
		--Drop main and craft inventories
		local inventoryLists = {inv:get_list("main"), inv:get_list("craft")}

		for _,inventoryList in pairs(inventoryLists) do
			for i,v in pairs(inventoryList) do
				local obj = minetest.env:add_item({x=math.floor(pos.x)+math.random(), y=pos.y, z=math.floor(pos.z)+math.random()}, v)
				if obj ~= nil then
					obj:get_luaentity().collect = true
					local x = math.random(1, 5)
					if math.random(1,2) == 1 then
						x = -x
					end
					local z = math.random(1, 5)
					if math.random(1,2) == 1 then
						z = -z
					end
					obj:setvelocity({x=1/x, y=obj:getvelocity().y, z=1/z})
				end
			end
		end
	end

	inv:set_list("craft", {})
	inv:set_list("main", {})

	--Drop armor inventory
	local armor_inv = minetest.get_inventory({type="detached", name=player:get_player_name().."_armor"})
	local player_inv = player:get_inventory()
	for i = 1,6 do
		if not clear then
			local stack = inv:get_stack("armor", i)
			local x = math.random(0, 6)/2 --MFF (09/08/2015)
			local z = math.random(0, 6)/2 --MFF (09/08/2015)
			pos.x = pos.x + x
			pos.z = pos.z + z
			minetest.add_item(pos, stack)
			pos.x = pos.x - x
			pos.z = pos.z - z
		end
		armor_inv:set_stack("armor", i, nil)
		player_inv:set_stack("armor", i, nil)
	end
	armor:set_player_armor(player)
	return
end

local stop_game = function()
	for _,player in ipairs(minetest.get_connected_players()) do
		minetest.after(0.1, function()
			local name = player:get_player_name()
		   	local privs = minetest.get_player_privs(name)
			player:set_nametag_attributes({color = {a=255, r=255, g=255, b=255}})
			privs.fast = nil
			privs.fly = nil
			privs.interact = true
			privs.ingame = nil
			minetest.set_player_privs(name, privs)
			drop_player_items(name, true)
			player:set_hp(20)
			spawning.spawn(player, "lobby")
		end)
		ingame = false
	end
	registrants = {}
	currGame = {}
	ingame = false
	grace = false
	countdown = false
	starting_game = false
	force_init_warning = false
	survival.disable()
	minetest.setting_set("enable_damage", "false")
	unset_timer()
	ranked.save_players_ranks()
	ranked.update_formspec()
	update_rank_skins()
end

local check_win = function()
	if ingame then
		local count = 0
		for _,_ in pairs(currGame) do
			count = count + 1
		end
		if count <= 1 then
			local winnerName
			for playerName,_ in pairs(currGame) do
				local winnerName = playerName
				ranked.inc(playerName, "nb_wins")
				minetest.chat_send_player(winnerName, "You won!")
				local endstr = "The Hungry Games are now over, " .. winnerName .. " was the winner."
				minetest.chat_send_all(endstr)
				irc:say(endstr)
				minetest.sound_play("hungry_games_victory")
			end

			local players = minetest.get_connected_players()
			for _,player in ipairs(players) do
				local name = player:get_player_name()
				local privs = minetest.get_player_privs(name)
				minetest.set_player_privs(name, privs)
			end

			stop_game()
			update_votebars()
		end
	elseif starting_game then
		local players = minetest.get_connected_players()
		if #players < 2 then
			if #players == 1 then
				local winnerName = players[1]:get_player_name()
				minetest.chat_send_player(winnerName, "You won! (All other players have left.)")
				minetest.sound_play("hungry_games_victory")

				local privs = minetest.get_player_privs(winnerName)
				minetest.set_player_privs(winnerName, privs)
			end
			stop_game()
		end
	end
end

local get_spots = function()
	i = 1
	while true do
		if spawning.is_spawn("player_"..i) then
			i = i + 1
		else
			return i - 1
		end
	end
end

local reset_player_state = function(player)
	local name = player:get_player_name()
	player:set_hp(20)
	survival.reset_player_state(name, "hunger")
	survival.reset_player_state(name, "thirst")
end

minetest.register_globalstep(function(dtime)
	if timer_mode ~= nil then
		timer = timer - dtime
		if timer_updated == nil or timer_updated - timer >= 1 then
			timer_updated = timer
			if timer >= 0 then
				if timer_mode == "grace" then
					update_timer_hud(string.format("Grace period: %ds", math.ceil(timer)))
				elseif timer_mode == "vote" then
					update_timer_hud(string.format("Next round in max. %ds.", math.ceil(timer)))
				elseif timer_mode == "starting" then
					update_timer_hud(string.format("Game starts in %ds.", math.ceil(timer)))
				elseif timer_mode == "chest_refill" then
					update_timer_hud(string.format("%ds to chest refill", math.ceil(timer)))
				else
					unset_timer()
				end
			else
				unset_timer()
			end
		end
	end
end)

local start_game_now = function(input)
	local contestants = input[1]
	local gsn = input[2]
	if gsn ~= gameSequenceNumber or not starting_game then
		return false
	end
	for i,player in ipairs(contestants) do
		local name = player:get_player_name()
		if minetest.get_player_by_name(name) then
			ranked.inc(name, "nb_games")
			currGame[name] = true
			player:set_nametag_attributes({color = {a=255, r=0, g=255, b=0}})
			local privs = minetest.get_player_privs(name)
			privs.fast = nil
			privs.fly = nil
			privs.interact = true
			privs.ingame = true
			minetest.set_player_privs(name, privs)
			minetest.after(0.1, function(table)
				local player = table[1]
				local i = table[2]
				local gsn = table[3]
				if gsn ~= gameSequenceNumber then
					return
				end
				local name = player:get_player_name()
				if spawning.is_spawn("player_"..i) then
					spawning.spawn(player, "player_"..i)
				end
			end, {player, spots_shuffled[i], gameSequenceNumber})
		end
	end
	ingame = true
	local startstr = "The Hungry Games has begun!"
	minetest.chat_send_all(startstr)
	irc:say(startstr)
	if hungry_games.grace_period > 0 then
		if hungry_games.grace_period >= 60 then
			minetest.chat_send_all("You have "..(dump(hungry_games.grace_period)/60).."min until grace period ends!")
		else
			minetest.chat_send_all("You have "..dump(hungry_games.grace_period).."s until grace period ends!")
		end
		grace = true
		set_timer("grace", hungry_games.grace_period)
		minetest.setting_set("enable_pvp", "false")
		minetest.after(hungry_games.grace_period, end_grace, gameSequenceNumber)
	else
		grace = false
		unset_timer()
	end
	minetest.setting_set("enable_damage", "true")
	survival.enable()
	votes = 0
	voters = {}
	update_votebars()
	ingame = true
	countdown = false
	starting_game = false
	minetest.sound_play("hungry_games_start")
	ranked.save_players_ranks()
	return true
end

local start_game = function()
	if starting_game or ingame then
		return
	end
	gameSequenceNumber = gameSequenceNumber + 1
	starting_game = true
	grace = false
	countdown = true
	votes = 0
	voters = {}
	update_votebars()

	local i = 1
	if hungry_games.countdown > 8.336 then
		minetest.after(hungry_games.countdown-8.336, function(gsn)
			if gsn == gameSequenceNumber and starting_game then
				minetest.sound_play("hungry_games_prestart")
			end
		end, gameSequenceNumber)
	end

	random_chests.clear()
	random_chests.refill()

	--Find out how many spots there are to spawn
	local nspots = get_spots()
	local diff =  nspots-table.getn(registrants)
	local contestants = {}

	-- Shuffle players
	local players = minetest.get_connected_players()
	local players_shuffled = {}
	local shuffle_free = {}
	for j=1,#players do
		shuffle_free[j] = j
	end
	for j=1,#players do
		local rnd = math.random(1, #shuffle_free)
		players_shuffled[j] = players[shuffle_free[rnd]]
		table.remove(shuffle_free, rnd)
	end

	-- Shuffle spots as well
	shuffle_free = {}
	spots_shuffled = {}
	for j=1,nspots do
		shuffle_free[j] = j
	end
	for j=1,nspots do
		local rnd = math.random(1, #shuffle_free)
		spots_shuffled[j] = shuffle_free[rnd]
		table.remove(shuffle_free, rnd)
	end

	-- Spawn players
	for p=1,#players_shuffled  do
		local player = players_shuffled[p]
		if diff > 0 then
			registrants[player:get_player_name()] = true
			diff = diff - 1
		end
		drop_player_items(player:get_player_name(), true)
		minetest.after(0.1, function(list)
			local player = list[1]
			local spawn_id = list[2]
			local gsn = list[3]
			if gsn ~= gameSequenceNumber or not starting_game then
				return
			end
			local name = player:get_player_name()
			if registrants[name] == true and spawn_id ~= nil and spawning.is_spawn("player_"..spawn_id) then
				table.insert(contestants, player)
				spawning.spawn(player, "player_"..spawn_id)
				reset_player_state(player)
				minetest.chat_send_player(name, "Get ready to fight!")
			else
				minetest.chat_send_player(name, "There are no spots for you to spawn!")
			end
		end, {player, spots_shuffled[i], gameSequenceNumber})
		if registrants[player:get_player_name()] then i = i + 1 end
	end
	minetest.setting_set("enable_damage", "false")
	if hungry_games.countdown > 0 then
		set_timer("starting", hungry_games.countdown)
		for i=1, (hungry_games.countdown-1) do
			minetest.after(i, function(list)
				local contestants = list[1]
				local i = list[2]
				local gsn = list[3]
				if gsn ~= gameSequenceNumber or not starting_game then
					return
				end
				local time_left = hungry_games.countdown-i
				if time_left%4==0 and time_left >= 16 then
					minetest.sound_play("hungry_games_starting_drum")
				end
				for i,player in ipairs(contestants) do
					minetest.after(0.1, function(table)
						local player = table[1]
						local i = table[2]
						local name = player:get_player_name()
						if spawning.is_spawn("player_"..i) then
							spawning.spawn(player, "player_"..i)
						end
					end, {player, spots_shuffled[i]})
				end
			end, {contestants,i,gameSequenceNumber})
		end
		minetest.after(hungry_games.countdown, start_game_now, {contestants,gameSequenceNumber})
	else
		start_game_now({contestants,gameSequenceNumber})
	end
end

local check_votes = function()
	if not ingame then
		local players = minetest.get_connected_players()
		local num = table.getn(players)
		if num > 1 and (votes >= needed_votes()) then
			start_game()
			return true
		end
	end
	return false
end

--Check if theres only one player left and stop hungry games.
minetest.register_on_dieplayer(function(player)
	local playerName = player:get_player_name()
	local pos = player:getpos()

	local count = 0
	for _,_ in pairs(currGame) do
		count = count + 1
	end
	count = count - 1

	if ingame and currGame[playerName] and count ~= 1 then
		player:set_nametag_attributes({color = {a=255, r=255, g=0, b=0}})
		local deathstr = playerName .. " has died! Players left: " .. tostring(count)
		minetest.chat_send_all(deathstr)
		irc:say(deathstr)
		ranked.inc(playerName, "nb_lost")
	end

	drop_player_items(playerName)
	currGame[playerName] = nil
	check_win()

   	local privs = minetest.get_player_privs(playerName)
	if privs.ingame then
		minetest.sound_play("hungry_games_death", {pos = pos})
		privs.ingame = nil
		minetest.set_player_privs(playerName, privs)
		minetest.chat_send_player(playerName, "You are now spectating")
	end
--[[	if privs.ingame or privs.fly then
   		if privs.interact and (hungry_games.death_mode == "spectate") then
		   	privs.fast = true
			privs.fly = true
			privs.interact = nil
			privs.ingame = nil
			minetest.set_player_privs(playerName, privs)
			minetest.chat_send_player(playerName, "You are now spectating")
		end
   	end]] -- Spectate disabled
end)

minetest.register_on_respawnplayer(function(player)
	player:set_hp(20)
	local name = player:get_player_name()
	drop_player_items(name, true)
	player:set_hp(20)
   	local privs = minetest.get_player_privs(name)
   	if (privs.interact or privs.fly) and (hungry_games.death_mode == "spectate") then
		spawning.spawn(player, "spawn")
	elseif (hungry_games.death_mode == "lobby") then
		spawning.spawn(player, "lobby")
	end
	return true
end)

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
   	local privs = minetest.get_player_privs(name)
	privs.vote = true
	privs.register = true
	privs.fast = nil
	privs.fly = nil
	privs.interact = true
	privs.ingame = nil
	minetest.set_player_privs(name, privs)

	if ingame then
		player:set_nametag_attributes({color = {a=255, r=255, g=0, b=0}})
	end

	if hungry_games.death_mode == "spectate" then
		minetest.chat_send_player(name, "You are now spectating")
	end

	spawning.spawn(player, "lobby")
	reset_player_state(player)
	hb.init_hudbar(player, "votes", votes, needed_votes(), (maintenance_mode or ingame or starting_game or #minetest.get_connected_players() < 2))
	update_votebars()
	timer_hudids[name] = player:hud_add({
		hud_elem_type = "text",
		position = { x=0.5, y=0 },
		offset = { x=0, y=20 },
		direction = 0,
		text = "",
		number = 0xFFFFFF,
		alignment = {x=0,y=0},
		size = {x=100,y=24},
	})
	if ingame then
		minetest.after(1, survival.player_hide_hudbar, name)
	end
	inventory_plus.register_button(player,"hgvote","HG Vote")
	inventory_plus.register_button(player,"hgranks","HG Ranks")
end)

minetest.register_on_newplayer(function(player)
	local name = player:get_player_name()
   	local privs = minetest.get_player_privs(name)
	privs.register = true
	minetest.set_player_privs(name, privs)

end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	if currGame[name] then
		drop_player_items(name)
		ranked.inc(name, "nb_quit")
		ranked.inc(name, "nb_lost")
	else
		drop_player_items(name, true)
	end
	currGame[name] = nil
	timer_hudids[name] = nil
   	local privs = minetest.get_player_privs(name)
	if voters[name] and votes > 0 then
		votes = votes - 1
		voters[name] = nil
	end
	if votes < 2 and timer_mode == "vote" then
		unset_timer()
		minetest.chat_send_all("Automatic game start has been aborted; there are less than 2 votes.")
		force_init_warning = false
	end
	update_votebars()
	if registrants[name] then registrants[name] = nil end
	minetest.after(1, function()
		check_votes()
		check_win()
	end)
end)

minetest.register_privilege("hg_admin", "Hungry Games Admin.")
minetest.register_privilege("hg_maker", "Hungry Games Map Maker.")
minetest.register_privilege("vote", "Privilege to vote.")
minetest.register_privilege("register", "Privilege to register.")

--Hungry Games Chat Commands.
minetest.register_chatcommand("hg", {
	params = "start | restart | stop | build | [un]set player_<n> | lobby | spawn | maintenance",
	description = "Manage Hungry Games. start: Start Hungry Games; restart: Restart Hungry Games; stop: Abort current game; build: Building mode to set up lobby, arena, etc.; set player_<n>: Set spawn position of player <n> (starting by 1); set lobby: Set spawn position in lobby; set spawn: Set initial spawn position for new players; unset: Like set, but removes spawn position; maintenance: Toggle maintenance mode",
	privs = {hg_admin=true},
	func = function(name, param)
		--Catch param.
		local parms = {}
		repeat
			v, p = param:match("^(%S*) (.*)")
			if p then
				param = p
			end
			if v then
				table.insert(parms,v)
			else
				v = param:match("^(%S*)")
				table.insert(parms,v)
				break
			end
		until false
		local ret
		local num_players  = #minetest.get_connected_players()
		--Restarts/Starts game.
		if parms[1] == "start" then
			if maintenance_mode then
				minetest.chat_send_player(name, "This server is currently in maintenance mode, no games can be started while it is in maintenance mode. Use \"/hg maintenance off\" to disable it.")
				return
			end
			if num_players < 2 then
				minetest.chat_send_player(name, "At least 2 players are needed to start a new round.")
				return
			end
			if get_spots() < 2 then
				minetest.chat_send_player(name, "There are less than 2 active spawn positions. Please set new spawn positions with \"/hg set player_#\".")
				return
			end
			local nostart
			if starting_game or ingame then
				nostart = true
			end
			if nostart then
				minetest.chat_send_player(name, "There is already a game running!")
			end
			ret = start_game()
			if ret == false then
				minetest.chat_send_player(name, "The game could not be started.")
			end
		elseif parms[1] == "restart" or parms[1] == 'r' then
			if maintenance_mode then
				minetest.chat_send_player(name, "This server is currently in maintenance mode, no games can be started while it is in maintenance mode. Use \"/hg maintenance off\" to disable it.")
				return
			end
			if starting_game or ingame then
				stop_game()
			end
			if num_players < 2 then
				minetest.chat_send_player(name, "At least 2 players are needed to start a new round.")
				return
			end
			if get_spots() < 2 then
				minetest.chat_send_player(name, "There are less than 2 active spawn positions. Please set new spawn positions with \"/hg set player_#\".")
				return
			end
			ret = start_game()
			if ret == false then
				minetest.chat_send_player(name, "The game could not be restarted.")
			end

		--Stops Game.
		elseif parms[1] == "stop" then
			if starting_game or ingame then
				stop_game()
				update_votebars()
				minetest.chat_send_all("The Hunger Games have been stopped!")
			else
				minetest.chat_send_player(name, "The game has already been stopped.")
			end
		elseif parms[1] == "build" then
			if not ingame then
				local privs = minetest.get_player_privs(name)
				privs.interact = true
				privs.fly = true
				privs.fast = true
				minetest.set_player_privs(name, privs)

				minetest.chat_send_player(name, "You now have interact and fly/fast!")
			else
				minetest.chat_send_player(name, "You cant build while in a match!")
				return
			end
		elseif parms[1] == "set" then
			if parms[2] ~= nil and (parms[2] == "spawn" or parms[2] == "lobby" or parms[2]:match("player_%d")) then
				local pos = {}
				if parms[3] and parms[4] and parms[5] then
					pos = {x=parms[3],y=parms[4],z=parms[5]}
					spawning.set_spawn(parms[2], pos)
				else
					pos = minetest.env:get_player_by_name(name):getpos()
					spawning.set_spawn(parms[2], pos)
				end
				minetest.chat_send_player(name, parms[2].." has been set to "..pos.x.." "..pos.y.." "..pos.z)
			else
				minetest.chat_send_player(name, "Set what?")
			end
		elseif parms[1] == "unset" then
			if parms[2] ~= nil and (parms[2] == "spawn" or parms[2] == "lobby" or parms[2]:match("player_%d")) then
				spawning.unset_spawn(parms[2])
				minetest.chat_send_player(name, parms[2].." has been unset.")
			else
				minetest.chat_send_player(name, "Unset what?")
			end
		elseif parms[1] == "maintenance" then
			local maintenance_action
			if parms[2] ~= nil then
				if parms[2] == "on" then
					maintenance_action = true
				elseif parms[2] == "off" then
					maintenance_action = false
				end
			else
				maintenance_action = not maintenance_mode
			end

			if maintenance_action == true then
				stop_game()
				votes = 0
				voters = {}
				maintenance_mode = true
				update_votebars()
				minetest.chat_send_all("This server is now in maintenance mode. The Hungry Games have been suspended until further notice.")
			elseif maintenance_action == false then
				votes = 0
				voters = {}
				maintenance_mode = false
				update_votebars()
				minetest.chat_send_all("Server maintenance finished. The Hungry Games can begin!")
			else
				minetest.chat_send_player(name, "Invalid command syntax! Syntax: \"/hg maintenance [on|off]\"")
			end
		else
			minetest.chat_send_player(name, "Unknown subcommand! Use /help hg for a list of available subcommands.")
		end
	end,
})

minetest.register_chatcommand("vote", {
	description = "Vote to start the Hungry Games. (You can also use voteblocks and the vote menu in your inventory)",
	privs = {vote=true},
	func = function(name, param)
		if not minetest.get_player_by_name(name) then
			return false, "You need to be ingame to vote"
		end
		if maintenance_mode then
			minetest.chat_send_player(name, "This server is currently in maintenance mode, no games can be started at the moment. Please come back later when the server maintenance is over.")
			return
		end
		local players = minetest.get_connected_players()
		local num = #players
		if num < 2 then
			minetest.chat_send_player(name, "At least 2 players are needed to start a new round.")
			return
		end
		if get_spots() < 2 then
			minetest.chat_send_player(name, "Spawn positions haven't been set yet. The game can not be started at the moment.")
			return
		end
		if not ingame and not starting_game then
			if voters[name] ~= nil then
				minetest.chat_send_player(name, "You already have voted.")
				return
			end
			voters[name] = true
			votes = votes + 1
			update_votebars()
			minetest.chat_send_all(name.. " has voted to begin! Votes so far: "..votes.."; Votes needed: "..needed_votes())

			local cv = check_votes()
			if votes > 1 and force_init_warning == false and cv == false and hungry_games.vote_countdown ~= nil then
				minetest.chat_send_all("The match will automatically be initiated in " .. math.floor(hungry_games.vote_countdown/60) .. " minutes " .. math.fmod(hungry_games.vote_countdown, 60) .. " seconds.")
				force_init_warning = true
				set_timer("vote", hungry_games.vote_countdown)
				voteSequenceNumber = voteSequenceNumber + 1
				minetest.after(hungry_games.vote_countdown, function (gsn, vsn)
					if not (starting_game or ingame and gsn == gameSequenceNumber) and timer_mode == "vote" and voteSequenceNumber == vsn then
						start_game()
					end
				end, gameSequenceNumber, voteSequenceNumber)
			end
		else
			minetest.chat_send_player(name, "Already ingame!")
			return
		end
	end,
})

minetest.register_chatcommand("register", {
	description = "Register to take part in the Hungry Games",
	privs = {register=true},
	func = function(name, param)
		if not minetest.get_player_by_name(name) then
			return false, "You need to be ingame to vote"
		end
		--Catch param.
		local parms = {}
		repeat
			v, p = param:match("^(%S*) (.*)")
			if p then
				param = p
			end
			if v then
				table.insert(parms,v)
			else
				v = param:match("^(%S*)")
				table.insert(parms,v)
				break
			end
		until false
		if table.getn(registrants) < get_spots() then
			registrants[name] = true
			minetest.chat_send_player(name, "You have registered!")
		else
			minetest.chat_send_player(name, "Sorry! There are no spots left for you to spawn.")
		end
	end,
})

-- get vote formspec
local get_player_vote_formspec = function(name)
	local formspec = {}
	table.insert(formspec, "label[3,0;Registration And Vote]")
	-- register
	table.insert(formspec, "button[0,1.5;1.5,1;hgregister;Register]")
	table.insert(formspec, "label[1.6,1.5;Click to register and reserve your place for the next Hunger Games]")
	table.insert(formspec, "label[1.6,2;(Useful when many in-game players)]")
	-- vote
	table.insert(formspec, "button[0,3.5;1.5,1;hgvote;Vote]")
	table.insert(formspec, "label[1.6,3.5;Click to vote and start Hunger Games]")
	table.insert(formspec, "label[1.6,4;(The Hunger Games start when there are at least 50% players voted)]")
	return table.concat(formspec)
end

-- Remind to vote
local hudkit = dofile(minetest.get_modpath("hungry_games") .. "/hudkit.lua")
vote_hud = hudkit()
vote_reminder = function()
	local playerlist = minetest.get_connected_players()
	for index, player in pairs(playerlist) do
		if not ingame and not starting_game and not grace and not countdown and maintenance_mode == false
			and not voters[player:get_player_name()] and #playerlist >= 2 then
			if not vote_hud:exists(player, "hungry_games:vote_reminder") then
				vote_hud:add(player, "hungry_games:vote_reminder", {
					hud_elem_type = "text",
					position = {x = 0.5, y = 0.25},
					scale = {x = 100, y = 100},
					text = "Remember to vote using a voteblock, your \"vote\" inventory or /vote to start the Hungry Games!",
					offset = {x=0, y = 0},
					number = 0xFF0000
				})
			end
		else
			if vote_hud:exists(player, "hungry_games:vote_reminder") then
				vote_hud:remove(player, "hungry_games:vote_reminder")
			end
		end
	end
	minetest.after(1, vote_reminder)
end

vote_reminder()

-- inventory_plus ranked menu
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if inventory_plus.is_called(fields, "hgvote", player) then
		local formspec = "size[9,8.5]"..
				default.inventory_background..
				default.inventory_listcolors..
				inventory_plus.get_tabheader(player, "hgvote")
		formspec = formspec .. get_player_vote_formspec(player:get_player_name())
		inventory_plus.set_inventory_formspec(player, formspec)
	end
	if fields["hgvote"] then
		local name = player:get_player_name()
		if minetest.get_player_privs(name).vote then
			vote(name)
		else
			minetest.chat_send_player(name, "Sorry! You don't have vote privs.")
		end
		return
	elseif fields["hgregister"] then
		local name = player:get_player_name()
		if minetest.get_player_privs(name).register then
			register(name)
		else
			minetest.chat_send_player(name, "Sorry! You don't have register privs.")
		end
		return
	end
end)


minetest.register_chatcommand("build", {
	description = "Give yourself interact",
	privs = {hg_maker=true},
	func = function(name, param)
		if not ingame then
				local privs = minetest.get_player_privs(name)
				privs.interact = true
				privs.fly = true
				privs.fast = true
				minetest.set_player_privs(name, privs)

				minetest.chat_send_player(name, "You now have interact and fly/fast!")
		else
			minetest.chat_send_player(name, "You cant build while in a match!")
			return
		end
	end,
})


minetest.register_craftitem("hungry_games:planks", {
	description = "Planks",
	inventory_image = "default_wood.png",
	groups = {wood=1},
})

minetest.register_craftitem("hungry_games:stones", {
	description = "Stones",
	inventory_image = "default_cobble.png",
	groups = {stone=1},
})

--special block vote (V,O,T,E)
for i in ipairs({1,2,3,4}) do
	minetest.register_node("hungry_games:blockvote_"..i, {
		description = "Command Block Vote "..i,
		inventory_image = minetest.inventorycube("hungry_games_blockvote_"..i.."_inv.png"),
		range = 12,
		stack_max = 99,
		drawtype = "normal",
		tiles = {
		"hungry_games_blockvote.png", "hungry_games_blockvote.png", {name = "hungry_games_blockvote_"..i..".png", animation={type = "vertical_frames", aspect_w= 32, aspect_h = 32, length = 3}}
	},


		drop = "",
		paramtype2 = "facedir",
		light_source = 13,
		sunlight_propagates = true,
		groups = {unbreakable = 1},
		sounds = default.node_sound_wood_defaults(),

		after_place_node = function(pos, placer)
			local meta = minetest.get_meta(pos)
			meta:set_string("infotext", "Punch it to vote")
		end,

		on_punch = function(pos, node, puncher, pointed_thing)
			if not puncher then return end
			minetest.after(0.10, vote, puncher:get_player_name())
		end,
	})
end
