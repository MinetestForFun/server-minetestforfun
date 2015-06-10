--Global config and function table.
snow = {
	snowball_gravity = 100/109,
	snowball_velocity = 19,
	sleds = true,
	enable_snowfall = true,
	lighter_snowfall = false,
	debug = false,
	smooth_biomes = true,
	christmas_content = true,
	smooth_snow = true,
	min_height = 3,
}

--Config documentation.
local doc = {
	snowball_gravity = "The gravity of thrown snowballs",
	snowball_velocity = "How fast players throw snowballs",
	sleds = "Disable this to prevent sleds from being riden.",
	enable_snowfall = "Enables falling snow.",
	lighter_snowfall = "Reduces the amount of resources and fps used by snowfall.",
	debug = "Enables debug output. Currently it only prints mgv6 info.",
	smooth_biomes = "Enables smooth transition of biomes (mgv6)",
	smooth_snow = "Disable this to stop snow from being smoothed.",
	christmas_content = "Disable this to remove christmas saplings from being found.",
	min_height = "The minumum height a snow biome will generate (mgv7)",
}

--Manage config.
--Saves contents of config to file.
local function saveConfig(path, config, doc)
	local file = io.open(path,"w")
	if file then
		for i,v in pairs(config) do
			local t = type(v)
			if t == "string" or t == "number" or t == "boolean" then
				if doc and doc[i] then
					file:write("# "..doc[i].."\n")
				end
				file:write(i.." = "..tostring(v).."\n")
			end
		end
	end
end
--Loads config and returns config values inside table.
local function loadConfig(path)
	local config = {}
	local file = io.open(path,"r")
  	if file then
  		io.close(file)
		for line in io.lines(path) do
			if line:sub(1,1) ~= "#" then
				local i, v = line:match("^(%S*) = (%S*)")
				if i and v then
					if v == "true" then v = true end
					if v == "false" then v = false end
					if tonumber(v) then v = tonumber(v) end
					config[i] = v
				end
			end
		end
		return config
	else
		--Create config file.
		return nil
	end
end

minetest.register_on_shutdown(function()
	saveConfig(minetest.get_modpath("snow").."/config.txt", snow, doc)
end)

local config = loadConfig(minetest.get_modpath("snow").."/config.txt")
if config then
	for i,v in pairs(config) do
		if type(snow[i]) == type(v) then
			snow[i] = v
		end
	end
else
	saveConfig(minetest.get_modpath("snow").."/config.txt", snow, doc)
end

for i,v in pairs(snow) do
	local t = type(v)
	if t == "string"
	or t == "number"
	or t == "boolean" then
		local v = minetest.setting_get("snow_"..i)
		if v ~= nil then
			if v == "true" then v = true end
			if v == "false" then v = false end
			if tonumber(v) then v = tonumber(v) end
			snow[i] = v
		end
	end
end


--MENU

local get_formspec = function()
	local p = -0.5
	local formspec = "label[0,-0.3;Settings:]"
	for i,v in pairs(snow) do
		local t = type(v)
		if t == "string"
		or t == "number" then
			p = p + 1.5
			formspec = formspec.."field[0.3,"..p..";2,1;snow:"..i..";"..i..";"..v.."]"
		elseif t == "boolean" then
			p = p + 0.5
			formspec = formspec.."checkbox[0,"..p..";snow:"..i..";"..i..";"..tostring(v).."]"
		end
	end
	p = p + 1
	formspec = "size[4,"..p..";]\n"..formspec
	return formspec
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "snow:menu" then
		return
	end
	for i,v in pairs(snow) do
		local t = type(v)
		if t == "string" or t == "number" or t == "boolean" then
			local field = fields["snow:"..i]
			if field then
				if t == "string" then
					snow[i] = field
				end
				if t == "number" then
					snow[i] = tonumber(field)
				end
				if t == "boolean" then
					if field == "true" then
						snow[i] = true
					elseif field == "false" then
						snow[i] = false
					end
				end
			end
		end
	end
end)


minetest.register_chatcommand("snow", {
	description = "Show a menu for various actions",
	privs = {server=true},
	func = function(name)
		minetest.chat_send_player(name, "Showing snow menu…")
		minetest.show_formspec(name, "snow:menu", get_formspec())
	end,
})
