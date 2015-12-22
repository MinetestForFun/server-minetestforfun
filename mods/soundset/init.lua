minetest.log("action","[mod soundset] Loading...")

soundset = {}
soundset.file = minetest.get_worldpath() .. "/sounds_config.txt"
soundset.gainplayers = {}
local tmp = {}
tmp["music"] = {}
tmp["ambience"]  = {}
tmp["other"] = {}

local function save_sounds_config()
	local input = io.open(soundset.file, "w")
	if input then
		input:write(minetest.serialize(soundset.gainplayers))
		input:close()
	else
		minetest.log("action","echec d'ouverture (mode:w) de " .. soundset.file)
	end
end


local function load_sounds_config()
	local file = io.open(soundset.file, "r")
	if file then
		soundset.gainplayers = minetest.deserialize(file:read("*all"))
		file:close()
	end
	if soundset.gainplayers == nil or type(soundset.gainplayers) ~= "table" then
		soundset.gainplayers = {}
	end
end

load_sounds_config()

soundset.set_sound = function(name, param)
	if param == "" then
		minetest.chat_send_player(name, "/setsound <music|ambience|mobs|other> <number>")
		return
	end
	local param_name, param_value = param:match("^(%S+)%s(%S+)$")
	if param_name == nil or param_value == nil then
		minetest.chat_send_player(name, "invalid param, /setsound <music|ambience|mobs|other> <number>")
		return
	end

	if param_name ~= "music" and param_name ~= "ambience" and param_name ~= "mobs" and param_name ~= "other" then
		minetest.chat_send_player(name, "invalid param " .. param_name)
		return
	end
	local value = tonumber(param_value)
	if value == nil then
		minetest.chat_send_player(name, "invalid value, " ..param_value .. " must be number")
		return
	end

	if value < 0 then
		value = 0
	elseif value > 100 then
		value = 100
	end

	if soundset.gainplayers[name][param_name] == value then
		minetest.chat_send_player(name, "volume " .. param_name .. " already set to " .. value)
		return
	end

	soundset.gainplayers[name][param_name] = value
	minetest.chat_send_player(name, "sound " .. param_name .. " set to " .. value)
	save_sounds_config()
end


soundset.get_gain = function(name, sound_type)
	if name == nil or name == "" then
		return 1
	end
	if not soundset.gainplayers[name] then return 1 end
	local gain = soundset.gainplayers[name][sound_type]
	if gain == nil then
		return 1
	end
	return gain/100
end

local inc = function(value)
	value = value + 5
	if value > 100 then
		value = 100
	end
	return value
end

local dec = function(value)
	value = value - 5
	if value < 0 then
		value = 0
	end
	return value
end


local formspec = "size[6,6]"..
				"label[2,0;Sound Menu]"..
				"label[0,1.2;MUSIC]"..
				"button[1.6,1;1,1;vmusic;-]"..
				"label[2.7,1.2;%s]"..
				"button[3.5,1;1,1;vmusic;+]"..
				"label[0,2.2;AMBIENCE]"..
				"button[1.6,2;1,1;vambience;-]"..
				"label[2.7,2.2;%s]"..
				"button[3.5,2;1,1;vambience;+]"..
				"label[0,3.2;OTHER]"..
				"button[1.6,3;1,1;vother;-]"..
				"label[2.7,3.2;%s]"..
				"button[3.5,3;1,1;vother;+]"..
				"button_exit[0.5,5.2;1.5,1;abort;Abort]"..
				"button_exit[4,5.2;1.5,1;abort;Ok]"


local on_show_settings = function(name, music, ambience, other)
	tmp["music"][name] = music
	tmp["ambience"][name] = ambience
	tmp["other"][name] = other
	minetest.show_formspec( name, "soundset:settings", string.format(formspec, tostring(music), tostring(ambience), tostring(other) ))
end

local clear_tmp = function(name)
	tmp["music"][name] = nil
	tmp["ambience"][name] = nil
	tmp["other"][name] = nil
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "soundset:settings" then
		local name = player:get_player_name()
		if not name or name == "" then return end
		local fmusic = tmp["music"][name] or 50
		local fambience = tmp["ambience"][name] or 50
		local fother = tmp["other"][name] or 50
		if fields["abort"] == "Ok" then
			if soundset.gainplayers[name]["music"] ~= fmusic or soundset.gainplayers[name]["ambience"] ~= fambience or soundset.gainplayers[name]["other"] ~= fother then
				soundset.gainplayers[name]["music"] = fmusic
				soundset.gainplayers[name]["ambience"] = fambience
				soundset.gainplayers[name]["other"] = fother
				save_sounds_config()
			end
			clear_tmp(name)
			return
		elseif fields["abort"] == "Abort" then
			clear_tmp(name)
			return
		elseif fields["vmusic"] == "+" then
			fmusic = inc(fmusic)
		elseif fields["vmusic"] == "-" then
			fmusic = dec(fmusic)
		elseif fields["vambience"] == "+" then
			fambience = inc(fambience)
		elseif fields["vambience"] == "-" then
			fambience = dec(fambience)
		elseif fields["vother"] == "+" then
			fother = inc(fother)
		elseif fields["vother"] == "-" then
			fother = dec(fother)
		elseif fields["quit"] == "true" then
			clear_tmp(name)
			return
		else
			return
		end

		on_show_settings(name, fmusic, fambience, fother)
	end
end)


if (minetest.get_modpath("unified_inventory")) then
	unified_inventory.register_button("menu_soundset", {
		type = "image",
		image = "soundset_menu_icon.png",
		tooltip = "sounds menu ",
		show_with = false, --Modif MFF (Crabman 30/06/2015)
		action = function(player)
			local name = player:get_player_name()
			if not name then return end
			on_show_settings(name, soundset.gainplayers[name]["music"], soundset.gainplayers[name]["ambience"], soundset.gainplayers[name]["other"])
		end,
	})
end

minetest.register_chatcommand("soundset", {
	params = "",
	description = "Display volume menu formspec",
	privs = {interact=true},
	func = function(name, param)
		if not name then return end
		on_show_settings(name, soundset.gainplayers[name]["music"], soundset.gainplayers[name]["ambience"], soundset.gainplayers[name]["other"])
	end
})


minetest.register_chatcommand("soundsets", {
	params = "<music|ambience|mobs|other> <number>",
	description = "Set volume sound <music|ambience|mobs|other>",
	privs = {interact=true},
	func = soundset.set_sound,
})

minetest.register_chatcommand("soundsetg", {
	params = "",
	 description = "Display volume sound <music|ambience|mobs|other>",
	privs = {interact=true},
	func = function(name, param)
		local conf = ""
		for k, v in pairs(soundset.gainplayers[name]) do
			conf = conf .. " " .. k .. ":" .. v
		end
		minetest.chat_send_player(name, "sounds conf " .. conf)
		minetest.log("action","Player ".. name .. " sound conf " .. conf)
	end
})

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if soundset.gainplayers[name] == nil then
		soundset.gainplayers[name] = { ["music"] = 50, ["ambience"] = 50, ["mobs"] = 50, ["other"] = 50 }
	end
end)

minetest.log("action","[mod soundset] Loaded")

