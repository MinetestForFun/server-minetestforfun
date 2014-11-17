local homes_file = {["real"] = minetest.get_worldpath() .. "/realhomes",
					 ["nether"] = minetest.get_worldpath() .. "/netherhomes"}
local homepos = {["real"] = {}, ["nether"] = {}}

local function loadhomes()
    for key,_ in pairs(homes_file) do
		local input = io.open(homes_file[key], "r")
		if input then
			repeat
				local x = input:read("*n")
				if x == nil then
					break
				end
				local y = input:read("*n")
				local z = input:read("*n")
				local name = input:read("*l")
				homepos[key][name:sub(2)] = {x = x, y = y, z = z}
			until input:read(0) == nil
			io.close(input)
		else
			homepos[key] = {}
		end
	end
end

loadhomes()

minetest.register_privilege("home", "Can use /sethome and /home")

local changed = false

minetest.register_chatcommand("home", {
    description = "Teleport you to your home point",
    privs = {home=true},
    func = function(name)
        local player = minetest.env:get_player_by_name(name)
        if player == nil then
            -- just a check to prevent the server crashing
            return false
        end
		local p_status = "real"
		if player:getpos().y < -19600 then
			p_status = "nether"
		end
        if homepos[p_status][player:get_player_name()] then
            player:setpos(homepos[p_status][player:get_player_name()])
            minetest.chat_send_player(name, "Teleported to home!")
        else
            minetest.chat_send_player(name, "Set a home using /sethome")
        end
    end,
})

minetest.register_chatcommand("sethome", {
    description = "Set your home point",
    privs = {home=true},
    func = function(name)
        local player = minetest.env:get_player_by_name(name)
        local pos = player:getpos()
		local p_status = "real"
		if pos.y < -19600 then
			p_status = "nether"
		end
        homepos[p_status][player:get_player_name()] = pos
        minetest.chat_send_player(name, "Home set!")
        changed = true
        if changed then
        	local output = io.open(homes_file[p_status], "w")
            for i, v in pairs(homepos[p_status]) do
                output:write(v.x.." "..v.y.." "..v.z.." "..i.."\n")
            end
            io.close(output)
            changed = false
        end
    end,
})
