h2omes = {}
h2omes.homes = {} -- table players home
h2omes.path = minetest.get_worldpath() .. "/h2omes/"
minetest.mkdir(h2omes.path)

h2omes.time_home = 2 * 60 --MFF 04/05/2016 2 minutes plus 20 minutes
h2omes.time_spawn = 5*60
h2omes.time_from_player = 5*60
h2omes.time_to_player = 5*60

local tmp_players = {}
local from_players = {}

h2omes.have_nether = false -- nether mod
if (minetest.get_modpath("nether") ~= nil) then
	h2omes.have_nether = true
end


function h2omes.check(name)
	if h2omes.homes[name] == nil then
		h2omes.homes[name] = {["home"] = {}, ["pit"] = {}}
	end
end


--function save_homes
function h2omes.save_homes(name)
	local file = h2omes.path..name
	local input, err = io.open(file, "w")
	if input then
		input:write(minetest.serialize(h2omes.homes[name]))
		input:close()
	else
		minetest.log("error", "open(" .. file .. ", 'w') failed: " .. err)
	end
end


--function load_homes
function h2omes.load_homes(name)
	h2omes.check(name)
	local file = h2omes.path..name
	local input, err = io.open(file, "r")
	if input then
		local data = minetest.deserialize(input:read())
		io.close(input)
		if data and type(data) == "table" then
			if data.home then
				if data.home.real then
					h2omes.homes[name].home.real = data.home.real
				end
				if data.home.nether then
					h2omes.homes[name].home.nether = data.home.nether
				end
			end
			if data.pit then
				if data.pit.real  then
					h2omes.homes[name].pit.real = data.pit.real
				end
				if data.pit.nether then
					h2omes.homes[name].pit.nether = data.pit.nether
				end
			end
		end
	end
end

-- disallowed tp real-->nether or nether-->real
function h2omes.can_teleport(from_pos, to_pos)
	if not h2omes.have_nether then -- not nether mod, -19600 is real
		return true
	end
	if from_pos.y < -19600 and to_pos.y < -19600 then
		return true
	elseif from_pos.y > -19600 and to_pos.y > -19600 then
		return true
	end
	return false
end


--function set_homes
function h2omes.set_home(name, home_type, pos)
	h2omes.check(name)
	if not pos then
		local player = minetest.get_player_by_name(name)
		if not player then return end
		pos = player:getpos()
	end
	if not pos then return false end
	if pos.y < -19600 and h2omes.have_nether then
		h2omes.homes[name][home_type].nether = pos
	else
		h2omes.homes[name][home_type].real = pos
	end
	minetest.chat_send_player(name, home_type.." set!")
	minetest.sound_play("dingdong",{to_player=name, gain = 1.0})
	h2omes.save_homes(name)
	return true
end


--function get_homes
function h2omes.get_home(name, home_type)
	h2omes.check(name)
	local player = minetest.get_player_by_name(name)
	if not player then return nil end
	local pos = player:getpos()
	if not pos then return nil end
	local status = "real"
	if pos.y < -19600 and h2omes.have_nether then
		status = "nether"
	end
	if h2omes.homes[name][home_type][status] then
		return h2omes.homes[name][home_type][status]
	end
	return nil
end


--function to_spawn
function h2omes.to_spawn(name)
	local player = minetest.get_player_by_name(name)
	if not player then return false end
	if minetest.setting_get_pos("static_spawnpoint") then
		minetest.chat_send_player(name, "Teleporting to spawn...")
		player:setpos(minetest.setting_get_pos("static_spawnpoint"))
		minetest.sound_play("teleport", {to_player=name, gain = 1.0})
		minetest.log("action","Player ".. name .." respawned. Next allowed respawn in ".. h2omes.time_spawn .." seconds.")
		return true
	else
		minetest.chat_send_player(name, "ERROR: No spawn point is set on this server!")
		return false
	end
end


--function to_homes
function h2omes.to_home(name, home_type)
	h2omes.check(name)
	local player = minetest.get_player_by_name(name)
	if not player then return false end
	local pos = player:getpos()
	if not pos then return false end
	local status = "real"
	if pos.y < -19600 and h2omes.have_nether then
		status = "nether"
	end
	if h2omes.homes[name][home_type][status] then
		player:setpos(h2omes.homes[name][home_type][status])
		minetest.chat_send_player(name, "Teleported to "..home_type.."!")
		minetest.sound_play("teleport", {to_player=name, gain = 1.0})
		return true
	end
	return false
end


--function to_player
function h2omes.to_player(name, to_pos, to_name)
	local player = minetest.get_player_by_name(name)
	if not player then return false end
	local from_pos = player:getpos()
	if to_pos then
		if h2omes.can_teleport(from_pos, to_pos) then
			minetest.chat_send_player(name, "Teleporting to player "..to_name)
			player:setpos(to_pos)
			minetest.sound_play("teleport", {to_player=name, gain = 1.0})
			return true
		else
			minetest.chat_send_player(name, "Sorry, teleport between 2 worlds(real/nether) is not allowed!")
			return false
		end
	else
		minetest.chat_send_player(name, "ERROR: No position to player!")
		return false
	end
end


function h2omes.update_pos(name, pos, from_name)
	from_players[name] = {name=from_name, pos=pos}
	minetest.chat_send_player(name, from_name .." sent you their position to teleport")
	minetest.sound_play("dingdong",{to_player=name, gain = 0.8})
	return true
end


function h2omes.send_pos_to_player(name, pos, to_name)
	local player = minetest.get_player_by_name(to_name)
	if not player or not pos then return false end
	if action_timers.wrapper(name, "send_pos_to_player", "from_player_" .. to_name, h2omes.time_from_player, h2omes.update_pos, {to_name, pos, name}) then
		minetest.chat_send_player(name, "Your position has been sent to "..to_name)
		return true
	else
		minetest.chat_send_player(name, "Error: "..to_name.." already received a request. please try again later.")
	end
	return false
end


function h2omes.show_formspec_home(name)
	if tmp_players[name] == nil then
		tmp_players[name] = {}
	end
	local player = minetest.get_player_by_name(name)
	if not player then return false end
	local formspec = {"size[8,9]label[3.15,0;Home Settings]"}
	local pos = player:getpos()
	--spawn
	table.insert(formspec, "label[3.45,0.8;TO SPAWN]")
	local spawn_pos = minetest.setting_get_pos("static_spawnpoint")
	if spawn_pos then
		if h2omes.can_teleport(pos, spawn_pos) then
			table.insert(formspec, string.format("label[2.9,1.3;x:%s, y:%s, z:%s]", math.floor(spawn_pos.x), math.floor(spawn_pos.y), math.floor(spawn_pos.z) ))
			table.insert(formspec, "button_exit[6,1.1;1.5,1;to_spawn;To Spawn]")
		else
			table.insert(formspec, "label[1.5,1.3;teleport between 2 worlds(real/nether) is not allowed]")
		end
	else
		table.insert(formspec, "label[3.3,1.3;No spawn set]")
	end

	--home
	table.insert(formspec, "label[3.5,2.1;TO HOME]")
	table.insert(formspec, "button[0.5,2.4;1.5,1;set_home;Set Home]")
	local home_pos = h2omes.get_home(name, "home")
	if home_pos then
		table.insert(formspec, string.format("label[2.9,2.5;x:%s, y:%s, z:%s]", math.floor(home_pos.x), math.floor(home_pos.y), math.floor(home_pos.z) ))
		table.insert(formspec, "button_exit[6,2.4;1.5,1;to_home;To Home]")
	else
		table.insert(formspec, "label[3.3,2.5;Home no set]")
	end

	--pit
	table.insert(formspec, "label[3.55,3.4;TO PIT]")
	table.insert(formspec, "button[0.5,3.7;1.5,1;set_pit;Set Pit]")
	local pit_pos = h2omes.get_home(name, "pit")
	if pit_pos then
		table.insert(formspec, string.format("label[2.9,3.8;x:%s, y:%s, z:%s]", math.floor(pit_pos.x), math.floor(pit_pos.y), math.floor(pit_pos.z) ))
		table.insert(formspec, "button_exit[6,3.7;1.5,1;to_pit;To Pit]")
	else
		table.insert(formspec, "label[3.3,3.8;Pit no set]")
	end

	--to player
	table.insert(formspec, "label[3.35,4.7;TO PLAYER]")
	local to_player = from_players[name]
	if to_player and to_player.name and to_player.pos then
		table.insert(formspec, string.format("label[0.5,5.1;To %s]", to_player.name))
		table.insert(formspec,string.format("label[2.9,5.1;x:%s, y:%s, z:%s]", math.floor(to_player.pos.x),math.floor(to_player.pos.y),math.floor(to_player.pos.z)))
		table.insert(formspec, "button_exit[6,5;1.5,1;to_player;To Player]")
	else
		table.insert(formspec, "label[2.7,5.1;No request from player]")
	end

	table.insert(formspec, "label[2.8,6;SEND MY POS TO PLAYER]")
	if not tmp_players[name] or not tmp_players[name].players_list or #tmp_players[name].players_list < 1 or tmp_players[name].refresh then
		tmp_players[name].refresh = nil
		tmp_players[name].players_list = {}
		tmp_players[name].selected_id = 0
		for _,player in pairs(minetest.get_connected_players()) do
			local player_name = player:get_player_name()
			if player_name and player_name ~= "" and player_name ~= name then
				table.insert(tmp_players[name].players_list, player_name)
			end
		end
		tmp_players[name]["select_player"] = nil
	end
	if #tmp_players[name].players_list == 0 then
		table.insert(formspec, "label[3,6.4;No player, try later]")
	else
		table.insert(formspec,"button[3.5,6.4;1.5,1;refresh;refresh]")
		table.insert(formspec, "dropdown[0.5,6.5;3,1;select_player;"..table.concat(tmp_players[name].players_list, ",")..";"..tmp_players[name].selected_id.."]")
	end
	if tmp_players[name].selected_id and tmp_players[name].selected_id > 0 then
		table.insert(formspec, "button_exit[6,6.4;1.5,1;send_to;Send To]")
	end

	table.insert(formspec, "button_exit[3.25,8.3;1.5,1;close;Close]")
	minetest.show_formspec(name, "h2omes:formspec", table.concat(formspec))
end


minetest.register_on_player_receive_fields(function(player, formname, fields)
	local name = player:get_player_name()
	if not name or name == "" then return end
	if formname == "h2omes:formspec" then
		if fields["set_home"] then
			--h2omes.set_home(name, "home")
			action_timers.wrapper(name, "sethome", "sethome_" .. name, h2omes.time_home, h2omes.set_home, {name, "home"})
			h2omes.show_formspec_home(name)
		elseif fields["set_pit"] then
			--h2omes.set_home(name, "pit")
			action_timers.wrapper(name, "setpit", "sethome_" .. name, h2omes.time_home, h2omes.set_home, {name, "pit"})
			h2omes.show_formspec_home(name)
		elseif fields["to_home"] then
			--h2omes.to_home(name, "home")
			action_timers.wrapper(name, "home", "tohome_" .. name, h2omes.time_home, h2omes.to_home, {name, "home"})
		elseif fields["to_pit"] then
			--h2omes.to_home(name, "pit")
			action_timers.wrapper(name, "pit", "tohome_" .. name, h2omes.time_home, h2omes.to_home, {name, "pit"})
		elseif fields["to_spawn"] then
			action_timers.wrapper(name, "spawn", "tospawn_" .. name, h2omes.time_spawn, h2omes.to_spawn, {name})
		elseif fields["to_player"] then
			if not from_players[name] then return end
			local to_name = from_players[name].name
			local pos = from_players[name].pos
			from_players[name] = nil
			if not to_name or not pos then return end
			h2omes.to_player(name, pos, to_name)
		elseif fields["send_to"] then
			local to_name = tmp_players[name]["select_player"]
			if not to_name then return end
			local pos = player:getpos()
			action_timers.wrapper(name, "send_pos_to_player", "to_player_" .. name, h2omes.time_to_player, h2omes.send_pos_to_player, {name, pos, to_name})
			tmp_players[name] = nil
		elseif fields["refresh"] then
			tmp_players[name].refresh = true
		elseif fields["select_player"] then
			for i, n in pairs(tmp_players[name].players_list) do
				if n == fields["select_player"] then
					tmp_players[name]["select_player"] = fields["select_player"]
					tmp_players[name].selected_id = i
					break
				end
			end
		end
		if not fields["quit"] then
			h2omes.show_formspec_home(name)
		end
	end
end)


minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if not name or name == "" then return end
	h2omes.load_homes(name)
end)


minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	if not name or name == "" then return end
	h2omes.homes[name] = nil
	tmp_players[name] = nil
	from_players[name] = nil
end)


minetest.register_privilege("home", "Can use /sethome, /home, /setpit and /pit")

minetest.register_chatcommand("spawn", {
	description = "Teleport a player to the defined spawnpoint",
	func = function(name)
		local to_pos = minetest.setting_get_pos("static_spawnpoint")
		if not to_pos then
			minetest.chat_send_player(name, "ERROR: No spawn point is set on this server!")
			return false
		end
		local player = minetest.get_player_by_name(name)
		if not player then return end
		from_pos = player:getpos()
		if h2omes.can_teleport(from_pos, to_pos) then
			action_timers.wrapper(name, "spawn", "tospawn_" .. name, h2omes.time_spawn, h2omes.to_spawn, {name})
		else
			minetest.chat_send_player(name, "Sorry, teleport between 2 worlds(real/nether) is not allowed!")
		end
	end
})

minetest.register_chatcommand("home", {
	description = "Teleport you to your home point",
	privs = {home=true},
	func = function (name, params)
		if not h2omes.get_home(name, "home") then
			minetest.chat_send_player(name, "Set a home using /sethome")
			return false
		end
		--h2omes.to_home(name, "home")
		return action_timers.wrapper(name, "home", "tohome_" .. name, h2omes.time_home, h2omes.to_home, {name, "home"})
	end,
})


minetest.register_chatcommand("sethome", {
	description = "Set your home point",
	privs = {home=true},
	func = function (name, params)
		--h2omes.set_home(name, "home")
		return action_timers.wrapper(name, "sethome", "sethome_" .. name, h2omes.time_home, h2omes.set_home, {name, "home"})
	end,
})


minetest.register_chatcommand("pit", {
	description = "Teleport you to your pit point",
	privs = {home=true},
	func = function (name, params)
		if not h2omes.get_home(name, "pit") then
			minetest.chat_send_player(name, "Set a pit using /setpit")
			return false
		end
		--h2omes.to_home(name, "pit")
		return action_timers.wrapper(name, "pit", "tohome_" .. name, h2omes.time_home, h2omes.to_home, {name, "pit"})
	end,
})


minetest.register_chatcommand("setpit", {
	description = "Set your pit point",
	privs = {home=true},
	func = function (name, params)
		--h2omes.set_home(name, "pit")
		return action_timers.wrapper(name, "setpit", "sethome_" .. name, h2omes.time_home, h2omes.set_home, {name, "pit"})
	end,
})

minetest.log("action","[h2omes] Loaded.")
