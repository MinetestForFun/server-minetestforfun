home = {}

home.homes_file = {["real"] = minetest.get_worldpath() .. "/realhomes",
					 ["nether"] = minetest.get_worldpath() .. "/netherhomes"}
home.homepos = {["real"] = {}, ["nether"] = {}}
home.timers = {}
home.HOME_INTERVAL = 20*60

home.sethome = function(name)
    local player = minetest.env:get_player_by_name(name)
    local pos = player:getpos()
	local p_status = "real"
	if pos.y < -19600 then
		p_status = "nether"
	end
    home.homepos[p_status][player:get_player_name()] = pos
    minetest.chat_send_player(name, "Home set!")
    local CHANGED = true
    if changed then
    	local output = io.open(home.homes_file[p_status], "w")
        for i, v in pairs(home.homepos[p_status]) do
            output:write(v.x.." "..v.y.." "..v.z.." "..i.."\n")
        end
        io.close(output)
        changed = false
    end
end

home.tohome = function(name)
    local player = minetest.env:get_player_by_name(name)
    if player == nil then
        -- just a check to prevent the server crashing
        return false
    end
	local p_status = "real"
	if player:getpos().y < -19600 then
		p_status = "nether"
	end
    if home.homepos[p_status][name] then
       if home.timers[name] ~= nil then
			local timer_player = os.difftime(os.time(),home.timers[name])
			if timer_player < home.HOME_INTERVAL then -- less than x minutes
				minetest.chat_send_player(name, "Please retry later, you used home last time less than ".. home.HOME_INTERVAL .." seconds ago.")
				minetest.chat_send_player(name, "Retry in: ".. home.HOME_INTERVAL-timer_player .." seconds.")
				minetest.log("action","Player ".. name .." tried to teleport home within forbidden interval.")
				return false
			end
		end
        player:setpos(home.homepos[p_status][player:get_player_name()])
        minetest.chat_send_player(name, "Teleported to home!")
        minetest.log("action","Player ".. name .." teleported to home. Last teleportation allowed in ".. home.HOME_INTERVAL .." seconds.")
        home.timers[name] = os.time()
        return true
    else
		minetest.chat_send_player(name, "Set a home using /sethome")
		return false
    end
end

local function loadhomes()
    for key,_ in pairs(home.homes_file) do
		local input = io.open(home.homes_file[key], "r")
		if input then
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
			io.close(input)
		else
			home.homepos[key] = {}
		end
	end
end

loadhomes()

minetest.register_privilege("home", "Can use /sethome and /home")

local changed = false

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
