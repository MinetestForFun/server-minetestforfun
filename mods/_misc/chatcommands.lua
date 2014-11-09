--
-- Edited chat commands from core
--

-- /me
-- /help
-- /privs
-- /grant
-- /revoke
-- /setpassword
-- /clearpassword
-- /auth_reload
-- /teleport
-- /set
-- /mods
-- /give
-- /giveme
-- /spawnentity
-- /pulverize
-- /rollback_check
-- /rollback
-- /status

minetest.register_chatcommand("time", {
	params = "<0...24000>",
	description = "set time of day",
	privs = {settime=true},
	func = function(name, param)
		if param == "" then
			return false, "Missing time."
		end
		local newtime = tonumber(param)
		if newtime == nil then
			return false, "Invalid time."
		end
		minetest.set_timeofday((newtime % 24000) / 24000)
		minetest.log("action", name .. " sets time " .. newtime)
		minetest.chat_send_all(name .. " changed the time of day.")
	end,
})

minetest.register_chatcommand("shutdown", {
	description = "shutdown server",
	privs = {server=true},
	func = function(name, param)
		minetest.log("action", name .. " shuts down server")
		minetest.request_shutdown()
		minetest.chat_send_all(name .. " just shut down the server.")
	end,
})

minetest.register_chatcommand("ban", {
	params = "<name>",
	description = "Ban IP of player",
	privs = {ban=true},
	func = function(name, param)
		if param == "" then
			return true, "Ban list: " .. minetest.get_ban_list()
		end
		if not minetest.get_player_by_name(param) then
			return false, "This player is not online at the moment. Use a /future_ban instead."
		end
		if not minetest.ban_player(param) then
			return false, "Failed to ban player."
		end
		local desc = minetest.get_ban_description(param)
		minetest.log("action", name .. " bans " .. desc .. ".")
		return true, "Banned " .. desc .. "."
	end,
})

-- /unban
-- /kick
-- /clearobjects
-- /msg

--
-- Other chat commands
--

-- Spawn command
--minetest.register_chatcommand("spawn", {
--    params = "",
--    description = "Teleport to the spawn location.",
--    privs = {shout=true},
--    func = function(name, param)
--            local player = minetest.get_player_by_name(name)
--            minetest.chat_send_player(name, "Teleported to spawn!")
--            player:setpos({x=0.0, y=5.0, z=0.0})
--            return true
--    end,
--})
--[[
-- Sethome command
minetest.register_chatcommand("sethome", {
        params = "",
        description = "Set your home location.",
        privs = {shout=true},
        func = function(name, param)
                player = minetest.get_player_by_name(name)
                test = player:getpos()
                local file = io.open(minetest.get_worldpath().."/home/"..player:get_player_name().."_home", "w")
                if not file then
                        minetest.chat_send_player(name, "Il y a eut une erreur, s'il vous plait contactez le detenteur du serveur.")
                        return
                end
                file:write(minetest.pos_to_string(test))
                file:close()
                minetest.chat_send_player(name, "Votre emplacement 'home' est definit ! Tapez /home pour vous y teleporter.")
        end
})

-- Home command
minetest.register_chatcommand("home", {
	params = "",
	description = "Vous teleporte a l'emplacement de votre 'home'.",
	privs = {shout=true},
	func = function(name, param)
		player = minetest.get_player_by_name(name)
		local file = io.open(minetest.get_worldpath().."/home/"..player:get_player_name().."_home", "r")
		if not file then
			minetest.chat_send_player(name, "Vous devez definir votre emplacement 'home' ! Pour ce faire, utilisez la commande /sethome.")
			return
		end
		local line = file:read("*line")
		file:close()
		local pos = minetest.string_to_pos(string.sub(line, 1, string.find(line, ")")))
		if not pos or type(pos) ~= "table" then
			minetest.chat_send_player(name, "Il y a eut une erreur, s'il vous plait contactez le detenteur du serveur.")
			return
		end
		minetest.get_player_by_name(name):setpos(pos)
		minetest.chat_send_player(name, "Vous voilà chez vous.")
	end
})
--]]
