home = {}

home.homes_file = {["real"] = minetest.get_worldpath() .. "/realhomes",
		["nether"] = minetest.get_worldpath() .. "/netherhomes"}
home.homepos = {["real"] = {}, ["nether"] = {}}
home.time = 2 * 60 --MFF 04/05/2016 2 minutes plus 20 minutes

home.sethome = function(name)
	local player = minetest.get_player_by_name(name)
	local pos = player:getpos()
	pos.y = pos.y+1
	local p_status = "real"
	if pos.y < -19600 then
		p_status = "nether"
	end

	local function assign_home()
			home.homepos[p_status][name] = pos
			minetest.chat_send_player(name, "Home set!")
			local output = io.open(home.homes_file[p_status], "w")
			output:write(minetest.serialize(home.homepos[p_status]))
			io.close(output)
			return true
	end

	return action_timers.wrapper(name, "sethome", "sethome_" .. name, home.time, assign_home, {})
end

home.tohome = function(name)
    local player = minetest.get_player_by_name(name)
    if player == nil then
        -- just a check to prevent the server crashing
        return false
    end
	local p_status = "real"
	if player:getpos().y < -19600 then
		p_status = "nether"
	end
	if home.homepos[p_status][name] then

		local function go_to_home()
        		player:setpos(home.homepos[p_status][player:get_player_name()])
        		minetest.chat_send_player(name, "Teleported to home!")
        		minetest.log("action","Player ".. name .." teleported to home. Next teleportation allowed in ".. home.time .." seconds.")
		        return true
		end

		return action_timers.wrapper(name, "home", "home_" .. name, home.time, go_to_home, {})
    else
		minetest.chat_send_player(name, "Set a home using /sethome")
		return false
    end
end

local function loadhomes()
    for key,_ in pairs(home.homes_file) do
		local input = io.open(home.homes_file[key], "r")
		if input then
			-- Old format handler
			local line = input:read()
			input:seek("set",0)
			if line == nil then return end
			if not line:match("return {") then
				repeat
					local x = input:read("*n")
					if x == nil then
						break
					end
					local y = input:read("*n")
					local z = input:read("*n")
					local name = input:read("*l")
					home.homepos[key][name:sub(2)] = {x = x, y = y, z = z}
				until input:read(0) == nil
			else
				home.homepos[key] = minetest.deserialize(input:read())
			end
			io.close(input)
		else
			home.homepos[key] = {}
		end
	end
end

loadhomes()

minetest.register_privilege("home", "Can use /sethome and /home")

minetest.register_chatcommand("home", {
    description = "Teleport you to your home point",
    privs = {home=true},
    func = home.tohome,
})

minetest.register_chatcommand("sethome", {
    description = "Set your home point",
    privs = {home=true},
    func = home.sethome,
})

minetest.log("action","[sethome] Loaded.")
