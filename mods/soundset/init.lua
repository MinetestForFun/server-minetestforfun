minetest.log("action","[mod soundset] Loading...")

sounds = {}
sounds.file = minetest.get_worldpath() .. "/sounds_config.txt"
sounds.gaindefault = { ["musique"] = 100, ["ambience"] = 100, ["mobs"] = 100, ["other"] = 100 }
sounds.gainplayers = {}


sounds.set_sound = function(name, param)
	if param == "" then
		minetest.chat_send_player(name, "/setsound <musique|ambience|mobs|other> <number>")
		return
	end
	local param_name, param_value = param:match("^(%S+)%s(%S+)$")
	if param_name == nil or param_value == nil then
		minetest.chat_send_player(name, "invalid param, /setsound <musique|ambience|mobs|other> <number>")
		minetest.log("action", "invalid param, see /setsound <musique|ambience|mobs|other> <number>")
		return
	end
	
	if param_name ~= "musique" and param_name ~= "ambience" and param_name ~= "mobs" and param_name ~= "other" then
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
		minetest.chat_send_player(name, "ambience " .. param_name .. " already set to " .. value)
		minetest.log("action", name ..", ambience " .. param_name .. "  already set to " .. value)
		return
	end
		
	sounds.gainplayers[name][param_name] = value
	minetest.chat_send_player(name, "sound " .. param_name .. " set to " .. value)
	minetest.log("action", name ..", sound " .. param_name .. " set to " .. value)
	local output = io.open(sounds.file, "w")
	for i, v in pairs(sounds.gainplayers) do
		output:write(v.musique .. " " .. v.ambience .. " " .. v.mobs .. " " .. v.other .. " " .. i .."\n")
	end
	io.close(output)

end


sounds.get_gain = function(name, sound_type)
	return sounds.gainplayers[name][sound_type]/50
end


local function load_sounds_config()
	local input = io.open(sounds.file, "r")
	if input then
		repeat
			local musique = input:read("*n")
			if musique == nil then
				break
			end
			local ambience = input:read("*n")
			
			local mobs = input:read("*n")
			
			local other = input:read("*n")
			
			local name = input:read("*l")
			
			sounds.gainplayers[name:sub(2)] = {musique = musique, ambience = ambience, mobs = mobs, other = other}
		until input:read(0) == nil
		io.close(input)
	end
end


load_sounds_config()

minetest.register_chatcommand("setsound", {
    params = "",
     description = "set volume sound <musique|ambience|mobs|other>",
    privs = {},
    func = sounds.set_sound,
})

minetest.register_chatcommand("getsound", {
    params = "",
     description = "print volume sound <musique|ambience|mobs|other>",
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
		sounds.gainplayers[name] = sounds.gaindefault
	end
end)
minetest.log("action","[mod soundset] Loaded")

