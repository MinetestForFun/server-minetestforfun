minetest.log("action","[mod soundset] Loading...")

sounds = {}
sounds.file = minetest.get_worldpath() .. "/sounds_config.txt"
sounds.gainplayers = {}
sounds.tmp = {}


local function save_sounds_config()
	local input = io.open(sounds.file, "w")
	if input then
		input:write(minetest.serialize(sounds.gainplayers))
		input:close()
	else
		minetest.log("action","echec d'ouverture (mode:w) de " .. sounds.file)
	end
end


local function load_sounds_config()
	local file = io.open(sounds.file, "r")
	if file then
		sounds.gainplayers = minetest.deserialize(file:read("*all"))
		file:close()
	end
	if sounds.gainplayers == nil or type(sounds.gainplayers) ~= "table" then
		sounds.gainplayers = {}
	end
end

load_sounds_config()

sounds.set_sound = function(name, param)
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
	
	if sounds.gainplayers[name][param_name] == value then
		minetest.chat_send_player(name, "volume " .. param_name .. " already set to " .. value)
		return
	end
		
	sounds.gainplayers[name][param_name] = value
	minetest.chat_send_player(name, "sound " .. param_name .. " set to " .. value)
	save_sounds_config()
end


sounds.get_gain = function(name, sound_type)
	if name == nil or name == "" then
		return 1
	end
	local gain = sounds.gainplayers[name][sound_type]
	if gain == nil then
		return 1
	end
	return gain/50
end


local formspec = "size[6,6]"..
				"label[2,0;Sound Menu]"..
				"label[0.3,1.2;MUSIC]"..
				"image_button[1.6,1;1,1;soundset_dec.png;vmusic;-]"..
				"label[2.7,1.2;%s]"..
				"image_button[3.5,1;1,1;soundset_inc.png;vmusic;+]"..
				"label[0,2.2;AMBIENCE]"..
				"image_button[1.6,2;1,1;soundset_dec.png;vambience;-]"..
				"label[2.7,2.2;%s]"..
				"image_button[3.5,2;1,1;soundset_inc.png;vambience;+]"..
				"button_exit[0.5,5.2;1.5,1;abort;Abort]"..
				"button_exit[4,5.2;1.5,1;abort;Ok]"


local on_show_settings = function(name, music, ambience)
	if not sounds.tmp[name] then
		sounds.tmp[name] = {}
	end
	sounds.tmp[name]["music"] = music
	sounds.tmp[name]["ambience"] = ambience
	minetest.show_formspec( name, "soundset:settings", string.format(formspec, tostring(music), tostring(ambience) ))
end


minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "soundset:settings" then
		local name = player:get_player_name()
		if not name then return end
		local fmusic = sounds.tmp[name]["music"]
		local fambience = sounds.tmp[name]["ambience"]
		if fields["abort"] == "Ok" then
			if sounds.gainplayers[name]["music"] ~= fmusic or sounds.gainplayers[name]["ambience"] ~= fambience then
				sounds.gainplayers[name]["music"] = fmusic
				sounds.gainplayers[name]["ambience"] = fambience
				save_sounds_config()
			end
			sounds.tmp[name] = nil
			return
		elseif fields["abort"] == "Abort" then
			sounds.tmp[name] = nil
			return
		elseif fields["vmusic"] == "+" then
			if fmusic < 100 then
				fmusic = fmusic +5
				if fmusic > 100 then
					fmusic = 100
				end
			end
		elseif fields["vmusic"] == "-" then
			if fmusic > 0 then
				fmusic = fmusic -5
				if fmusic < 0 then
					fmusic = 0
				end
			end
		elseif fields["vambience"] == "+" then
			if fambience < 100 then
				fambience = fambience +5
				if fambience > 100 then
					fambience = 100
				end
			end
		elseif fields["vambience"] == "-" then
			if fambience > 0 then
				fambience = fambience -5
				if fambience < 0 then
					fambience = 0
				end
			end
		elseif fields["quit"] == "true" then
			sounds.tmp[name] = nil
			return
		else
			return
		end

		on_show_settings(name, fmusic, fambience)
	end
end)


if (minetest.get_modpath("unified_inventory")) then
	unified_inventory.register_button("menu_soundset", {
		type = "image",
		image = "soundset_menu_icon.png",
		tooltip = "sounds menu ",
		action = function(player)
			local name = player:get_player_name()
			if not name then return end
			on_show_settings(name, sounds.gainplayers[name]["music"], sounds.gainplayers[name]["ambience"])
		end,
	})
end

minetest.register_chatcommand("soundset", {
	params = "",
	description = "Display volume menu formspec",
	privs = {interact=true},
	func = function(name, param)
		if not name then return end
		on_show_settings(name, sounds.gainplayers[name]["music"], sounds.gainplayers[name]["ambience"])
	end
})	



minetest.register_chatcommand("soundsets", {
	params = "<music|ambience|mobs|other> <number>",
	description = "Set volume sound <music|ambience|mobs|other>",
	privs = {interact=true},
	func = sounds.set_sound,
})

minetest.register_chatcommand("soundsetg", {
	params = "",
	 description = "Display volume sound <music|ambience|mobs|other>",
	privs = {interact=true},
	func = function(name, param)
		local conf = ""
		for k, v in pairs(sounds.gainplayers[name]) do
			conf = conf .. " " .. k .. ":" .. v
		end
		minetest.chat_send_player(name, "sounds conf " .. conf)
		minetest.log("action","Player ".. name .. " sound conf " .. conf)
	end
})

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if sounds.gainplayers[name] == nil then
		sounds.gainplayers[name] = { ["music"] = 50, ["ambience"] = 50, ["mobs"] = 50, ["other"] = 50 }
	end
end)

minetest.log("action","[mod soundset] Loaded")

