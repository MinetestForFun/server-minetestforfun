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
	mapgen_rarity = 18,
	mapgen_size = 210,
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
	mapgen_rarity = "mapgen rarity in %",
	mapgen_size = "size of the generated… (has an effect to the rarity, too)",
}


-- functions for dynamically changing settings

local on_configurings,n = {},1
function snow.register_on_configuring(func)
	on_configurings[n] = func
	n = n+1
end

local function change_setting(name, value)
	if snow[name] == value then
		return
	end
	for i = 1,n-1 do
		if on_configurings[i](name, value) == false then
			return
		end
	end
	snow[name] = value
end


local function value_from_string(v)
	if v == "true" then
		v = true
	elseif v == "false" then
		v = false
	else
		local a_number = tonumber(v)
		if a_number then
			v = a_number
		end
	end
	return v
end

local allowed_types = {string = true, number = true, boolean = true}

--Saves contents of config to file.
local function saveConfig(path, config, doc)
	local file = io.open(path,"w")
	if not file then
		minetest.log("error", "[snow] could not open config file for writing at "..path)
		return
	end
	for i,v in pairs(config) do
		if allowed_types[type(v)] then
			if doc and doc[i] then
				file:write("# "..doc[i].."\n")
			end
			file:write(i.." = "..tostring(v).."\n")
		end
	end
	file:close()
end

local modpath = minetest.get_modpath("snow")

minetest.register_on_shutdown(function()
	saveConfig(modpath.."/config.txt", snow, doc)
end)


-- load settings from config.txt

local config
do
	local path = modpath.."/config.txt"
	local file = io.open(path,"r")
	if not file then
		--Create config file.
		return
	end
	io.close(file)
	config = {}
	for line in io.lines(path) do
		if line:sub(1,1) ~= "#" then
			local i, v = line:match("^(%S*) = (%S*)")
			if i and v then
				config[i] = value_from_string(v)
			end
		end
	end
end

if config then
	for i,v in pairs(config) do
		if type(snow[i]) == type(v) then
			snow[i] = v
		else
			minetest.log("error", "[snow] wrong type of setting "..i)
		end
	end
else
	saveConfig(modpath.."/config.txt", snow, doc)
end


-- load settings from minetest.conf

for i,v in pairs(snow) do
	if allowed_types[type(v)] then
		local v = minetest.setting_get("snow_"..i)
		if v ~= nil then
			snow[i] = value_from_string(v)
		end
	end
end


--MENU

local function form_sort_func(a,b)
	return a[1] < b[1]
end

--[[
local function form_sort_func_bool(a,b)
	if a[2] == b[2] then
		return a[1] < b[1]
	else
		return b[2]
	end
end--]]

local function get_formspec()
	local ids,n1,n2 = {{},{}},1,1
	for i,v in pairs(snow) do
		local t = type(v)
		if t == "string"
		or t == "number" then
			ids[2][n2] = {i,v}
			n2 = n2+1
		elseif t == "boolean" then
			ids[1][n1] = {i,v}
			n1 = n1+1
		end
	end
	table.sort(ids[2], form_sort_func)
	table.sort(ids[1], form_sort_func)

	local p = -0.5
	local formspec = "label[0,-0.3;Settings:]"
	for n = 1,n1-1 do
		local i,v = unpack(ids[1][n])
		p = p + 0.5
		formspec = formspec.."checkbox[0,"..p..";snow:"..i..";"..i..";"..tostring(v).."]"
	end
	for n = 1,n2-1 do
		local i,v = unpack(ids[2][n])
		p = p + 1.5
		formspec = formspec.."field[0.3,"..p..";2,1;snow:"..i..";"..i..";"..v.."]"
	end
	p = p + 1
	formspec = "size[4,"..p..";]\n"..formspec
	return formspec
end

minetest.register_chatcommand("snow", {
	description = "Show a menu for various actions",
	privs = {server=true},
	func = function(name)
		minetest.chat_send_player(name, "Showing snow menu…")
		minetest.show_formspec(name, "snow:menu", get_formspec())
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "snow:menu" then
		return
	end
	for i,v in pairs(snow) do
		local t = type(v)
		if allowed_types[t] then
			local field = fields["snow:"..i]
			if field then
				if t == "number" then
					field = tonumber(field)
				elseif t == "boolean" then
					if field == "true" then
						field = true
					elseif field == "false" then
						field = false
					else
						field = nil
					end
				elseif t ~= "string" then
					field = nil
				end
				if field ~= nil then
					change_setting(i, field)
				end
			end
		end
	end
end)
