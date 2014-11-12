seendebug = true
local last_time = os.time()
local save_interval = 60

if minetest.setting_get("seen.save_interval") ~= nil then
	local save_int = minetest.setting_get("seen.save_interval")
	if tonumber(save_int) > 20 then
		save_interval = save_int
	end
end

local function save_data(sett, data)
	if sett ~= nil then
		data_ser = minetest.serialize(data)
		sett:set("data", data_ser)
		sett:write()
	else
		minetest.chat_send_all("Seen Mod: Saving data failed. Please shout at the server admin!")
	end
end

local function load_data(sett, field)
	local loaded = sett:get("data")
	local def = sett:get("default")
	if loaded ~= nil then
		local data = minetest.deserialize(loaded)
	else
		local data = {}
	end
end

local function relative_time (time)
	local diff = os.time() - time
	if diff == 0 then
		return "now"
	elseif diff > 0 then
		local day_diff = math.floor(diff/86400)
		if day_diff == 0 then
			if diff < 60 then
				return "a few seconds ago"
			end
			if diff < 120 then
				return "1 minute ago."
			end
			if diff < 3600 then
				 return tostring(math.floor(diff/60)).." minutes ago"
			end
			if diff < 7200 then
				return "1 hour ago"
			end
			if diff < 86400 then
				return tostring(math.floor(diff/3600)).." hours ago"
			end
		end
		if day_diff == 1 then
			return "yesterday"
		end
		if day_diff < 7 then
			return tostring(day_diff).." days ago"
		end
		if day_diff < 31 then
			return tostring(math.ceil(day_diff/7)).." weeks ago"
		end
		if day_diff < 60 then
			return "last month"
		end
		return os.date("%B %Y", time)
	else
		local diff = math.abs(diff)
		local day_diff = math.floor(diff/86400)
		if day_diff == 0 then
			if diff < 120 then
				return "in a minute"
			end
			if diff < 3600 then
				return "in "..tostring(math.floor(diff/60)).." minutes"
			end
			if diff < 7200 then
				return "in an hour"
			end
			if diff < 86400 then
				return "in "..tostring(math.floor(diff/3600)).." hours"
			end
		end
		if day_diff == 1 then
			return "tomorrow"
		end
		if day_diff < 4 then
			return os.date("%A", time)
		end
		if day_diff < 7 + (7 - tonumber(os.date("%w"))) then
			return "next week"
		end
		if math.ceil (day_diff / 7) < 4 then
			return "in "..tostring(math.ceil(day_diff/7)).." weeks"
		end
		if tonumber(os.date("%m", time)) == tonumber(os.date("%m")) + 1 then
			return "next month"
		end
		return os.date("%B %Y", time);
	end
end

local function print_r(tab,com)
	if seendebug == true then
		print("DEBUG: "..com)
		table.foreach(tab, print)
		print("-----")
		return true
	else
		return false
	end
end

local function debug(var, com)
	if seendebug == true then
		print("DEBUG: "..com)
		print(var)
		minetest.chat_send_all("DEBUG: "..var.."// "..com)
		print("-----")
		return true
	else
		return false
	end
end

local config_file = minetest.get_worldpath().."/seen.txt"
--in case of not existant config file, it
--will create it
local file_desc = io.open(config_file, "a")
file_desc:close()

--create config instance
local config = Settings(config_file)
local data
local seens = {}

data = config:get("data")
if data ~= nil then
	seens = minetest.deserialize(data)
	for _, player in pairs( minetest.get_connected_players() ) do
		name = player:get_player_name()
		seens[name] = os.time()
	end
else
	seens = {}
	for _, player in pairs( minetest.get_connected_players() ) do
		name = player:get_player_name()
		seens[name] = os.time()
	end
end
save_data(config, seens)

minetest.register_on_newplayer(function(player)
	name = player:get_player_name()
	seens[name] = os.time()
	save_data(config, seens)
	return true
end)

minetest.register_on_joinplayer(function(player)
	name = player:get_player_name()
	seens[name] = os.time()
	save_data(config, seens)
	return true
end)

minetest.register_on_leaveplayer(function(player)
	name = player:get_player_name()
	seens[name] = os.time()
	save_data(config, seens)
	return true
end)

minetest.register_on_shutdown(function()
	for _, player in pairs( minetest.get_connected_players() ) do
		name = player:get_player_name()
		seens[name] = os.time()
	end
	save_data(config, seens)
	return true
end)

minetest.register_globalstep(function ( dtime )
	if os.time() >= last_time then
		last_time = os.time() + save_interval
		for _, player in pairs( minetest.get_connected_players() ) do
			name = player:get_player_name()
			seens[name] = os.time()
		end
		save_data(config, seens)
	end
end);

minetest.register_chatcommand("seen", {
	params = "<name>",
	description = "Recherche quand un joueur etait en ligne pour la derniere fois.",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then
			return
		end
		if param ~= nil and param ~= "" then
			if seens[param] ~= nil then
				minetest.chat_send_player(name, param.." etait en ligne pour la derniere fois "..relative_time(seens[param]))
			else
				minetest.chat_send_player(name, "Il n'y a aucune donnees sur "..param..". Peut-etre que l'identifiant n'est pas correcte ?")
			end
		end
	end,
})
