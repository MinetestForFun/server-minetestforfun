local real_homes_file = minetest.get_worldpath() .. "/real_homes"
local nether_homes_file = minetest.get_worldpath() .. "/nether_homes"
local homepos = {real = {},nether = {}}

local function loadhomes()
    local input = io.open(real_homes_file, "r")
    if input then
		repeat
            local x = input:read("*n")
            if x == nil then
            	break
            end
            local y = input:read("*n")
            local z = input:read("*n")
            local name = input:read("*l")
            homepos.real[name:sub(2)] = {x = x, y = y, z = z}
        until input:read(0) == nil
        io.close(input)
    else
        homepos.real = {}
    end
    
    input = io.open(nether_homes_file, "r")
    if input then
		repeat
			local x = input:read("*n")
			if x == nil then
				break
			end
			local y = input:read("*n")
			local z = input:read("*n") 
			local name = input:read("*n")
			homepos.nether[name:sub(2)] = {x = x, y = y, z = z}
		until input:read(0) == nil
		io.close(input)
	else
		homepos.nether = {}
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
        if not player_in_nether then return end
        local is_in_nether = table.icontains(players_in_nether, name)

        if player == nil then
            -- just a check to prevent the server crashing
            return false
        end
        if homepos[player:get_player_name()] then
			if is_in_nether then
				player:setpos(nether.homepos[player:get_player_name()])
            else
				player:setpos(real.homepos[player:get_player_name()])
			end
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
        if not players_in_nether then return end
        local is_in_nether = table.icontains(players_in_nether, name)
        if is_in_nether then
			homepos.nether[player:get_player_name()] = pos
		else
			homepos.real[player:get_player_name()] = pos
		end
        minetest.chat_send_player(name, "Home set!")
        changed = true
        if changed then
			if is_in_nether then
				local output = io.open(nether_homes_file, "w")
            else
				local output = io.open(real_homes_file, "w")
			end
            for i, v in pairs(homepos) do
                output:write(v.x.." "..v.y.." "..v.z.." "..i.."\n")
            end
            io.close(output)
            changed = false
        end
    end,
})
