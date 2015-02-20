minetest.log("action","[mod soundset] Loading...")

sounds = {}
sounds.file = minetest.get_worldpath() .. "/sounds_config.txt"
sounds.gainplayers = {}


sounds.set_sound = function(name, param)
	if param == "" then
		minetest.chat_send_player(name, "/setsound <music|ambience|mobs|other> <number>")
		return
	end
	local param_name, param_value = param:match("^(%S+)%s(%S+)$")
	if param_name == nil or param_value == nil then
		minetest.chat_send_player(name, "invalid param, /setsound <music|ambience|mobs|other> <number>")
		minetest.log("action", "invalid param, see /setsound <music|ambience|mobs|other> <number>")
		return
	end
	
	if param_name ~= "music" and param_name ~= "ambience" and param_name ~= "mobs" and param_name ~= "other" then
		minetest.chat_send_player(name, "invalid param " .. param_name)
		minetest.log("action", "invalid param, /setsound " .. param_name)
		return
	end
	local value = tonumber(param_value)
	if value == nil then
		minetest.log("action", "invalid value, " ..param_value .. " must be number")
		return
	end
	
	if value < 0 then
		value = 0
	elseif value > 100 then
		value = 100
	end
	
	if sounds.gainplayers[name][param_name] == value then
		minetest.chat_send_player(name, "volume " .. param_name .. " already set to " .. value)
		minetest.log("action", name ..", volume " .. param_name .. "  already set to " .. value)
		return
	end
		
	sounds.gainplayers[name][param_name] = value
	minetest.chat_send_player(name, "sound " .. param_name .. " set to " .. value)
	minetest.log("action", name ..", sound " .. param_name .. " set to " .. value)


	local input = io.open(sounds.file, "w")
	if input then
		input:write(minetest.serialize(sounds.gainplayers))
		input:close()
	else
		minetest.log("action","echec d'ouverture (mode:w) de " .. sounds.file)
	end
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



local function load_sounds_config()
	local file = io.open(sounds.file, "r")
	if file then
		sounds.gainplayers = minetest.deserialize(file:read("*all"))
		file:close()
	end
	if sounds.gainplayers == nil then
		sounds.gainplayers = {}
	end
end


load_sounds_config()

minetest.register_chatcommand("setsound", {
	params = "<music|ambience|mobs|other> <number>",
	 description = "set volume sound <music|ambience|mobs|other>",
	privs = {},
	func = sounds.set_sound,
})

minetest.register_chatcommand("getsound", {
	params = "",
	 description = "print volume sound <music|ambience|mobs|other>",
	privs = {},
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

