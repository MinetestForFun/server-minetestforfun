minetest.register_privilege("whois", {
    description = "Allows player to see other player IPs"})

-- Created by Krock to stop mass-account-creators
-- License: WTFPL

ipnames = {}
ipnames.data = {}
ipnames.tmp_data = {}
ipnames.changes = false
ipnames.save_interval = 120
ipnames.save_time = 0
ipnames.file = minetest.get_worldpath().."/ipnames.txt"

ipnames.name_per_ip_limit = tonumber(minetest.setting_get("max_names_per_ip")) or 5

-- Get accounts self:
minetest.register_chatcommand("whois", {
	description = "Gets all players who have the same IP as the specified player",
	privs = {whois = true},
	func = function(name, param)
		if not ipnames.data[param] then
			minetest.chat_send_player(name, "The player \"" .. param .. "\" did not join yet.")
			return
		end
		
		local ip = ipnames.data[param]
		local names = "";
		for k, v in pairs(ipnames.data) do
			if v == ip then
				if names ~= "" then
					names = names .. ", " .. k
				else
					names = names .. " " .. k
				end
			end
		end
		minetest.chat_send_player(name, "Players for IP address " .. ip .. ": " .. names)
	end,
})

-- Get IP if player tries to join, ban if there are too much names per IP:
minetest.register_on_prejoinplayer(function(name, ip)
	-- Only stop new accounts:
	ipnames.tmp_data[name] = ip
	if not ipnames.data[name] then
		local count = 1
		local names = ""
		for k, v in pairs(ipnames.data) do
			if v == ip then
				count = count + 1
				names = names .. k .. ", "
			end
		end
		
		if count <= ipnames.name_per_ip_limit and count > 1 then
			minetest.log("action", name .. " now has " .. count .. " accounts. Other accounts: " .. names)
		end
		
		if count > ipnames.name_per_ip_limit then
			ipnames.tmp_data[name] = nil
			if tostring(ip) ~= "127.0.0.1" then
				return ("\nYou exceeded the limit of accounts (" .. ipnames.name_per_ip_limit ..
				").\nYou already have the following accounts:\n" .. names)
			end
		end
	end
end)

-- Save IP if player joined:
minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	ipnames.data[name] = ipnames.tmp_data[name]
	ipnames.tmp_data[name] = nil
	ipnames.changes = true
end)

function ipnames.load_data()
	local file = io.open(ipnames.file, "r")
	if not file then
		return
	end
	for line in file:lines() do
		if line ~= "" then
			local data = line:split("|")
			if #data >= 2 then
				ipnames.data[data[1]] = data[2]
			end
		end
	end
	io.close(file)
end

function ipnames.save_data()
	if not ipnames.changes then
		return
	end
	ipnames.changes = false
	local file = io.open(ipnames.file, "w")
	for i, v in pairs(ipnames.data) do
		if v ~= nil then
			file:write(i .. "|" .. v .. "\n")
		end
	end
	io.close(file)
end

minetest.register_globalstep(function(t)
	ipnames.save_time = ipnames.save_time + t
	if ipnames.save_time < ipnames.save_interval then
		return
	end
	ipnames.save_time = 0
	ipnames.save_data()
end)

minetest.register_on_shutdown(function() ipnames.save_data() end)

minetest.after(3, function() ipnames.load_data() end)
