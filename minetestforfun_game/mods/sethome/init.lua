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
        
		local player = minetest.get_player_by_name(name)
		local player_pos = player:getpos()
        local is_player_in_nether = player_pos.y < -19600

        if player == nil then
            -- just a check to prevent the server crashing
            return false
        end

        if is_player_in_nether then
			if homepos.nether[name] ~= nil then
				player:setpos(homepos.nether[name])
				minetest.log("action",name.." teleported with /home to "..homepos.nether[name].x..","..homepos.nether[name].y..","..homepos.nether[name].z..", in the nether.")
				core.chat_send_player(name, "Teleported to home in the nether!")
			else
				core.chat_send_player(name, "Set a home in the nether using /sethome")
			end
		else
			if homepos.real[name] ~= nil then
				player:setpos(homepos.real[name])
				minetest.log("action",name.." teleported with /home to "..homepos.real[name].x..","..homepos.real[name].y..","..homepos.real[name].z..", in the real world.")
				core.chat_send_player(name,"Teleported to home in the real world!")
			else
				core.chat_send_player(name, "Set a home in the real world using /sethome")
			end
        end
    end,
})

minetest.register_chatcommand("sethome", {
    description = "Set your home point",
    privs = {home=true},
    func = function(name)
		
		local player_pnt = minetest.get_player_by_name(name)
		local player_pos = player_pnt:getpos()
		local player_is_in_nether = player_pos.y < -19600
		
		if player_is_in_nether == true then
			homepos.nether[name] = pos
			minetest.log("action",name.." set its home position to "..player_pos.x..","..player_pos.y..","..player_pos.z..", in the nether.")
			core.chat_send_player(name,"Home set in the nether!")
		else
			homepos.real[name] = pos
			minetest.log("action",name.." set its home position to "..player_pos.x..","..player_pos.y..","..player_pos.z..", in the real world.")
			core.chat_send_player(name,"Home set in the real world!")
		end
		
		changed = true
        if changed then
			local output = 0
			
			if is_in_nether then
				output = io.open(nether_homes_file, "w")
				if output == 0 then return end -- Had not open the file
				for i, v in pairs(homepos.nether) do
					output:write(v.x.." "..v.y.." "..v.z.." "..i.."\n")
				end
            else
				output = io.open(real_homes_file, "w")
				for i, v in pairs(homepos.real) do
					output:write(v.x.." "..v.y.." "..v.z.." "..i.."\n")
				end
			end
			
            io.close(output)
            changed = false
        end
    end,
})
