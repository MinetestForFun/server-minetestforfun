--
-- Edited chat commands from core
--

-- /shutdown
-- /ban
-- /itemdb

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

minetest.register_chatcommand("itemdb", {
	params = "",
	description = "Give itemstring of wielded item",
	privs = {},
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if not player then return false end
		local item   = player:get_wielded_item()

		if item:get_name() == "" then
			minetest.chat_send_player(name,"You're handling nothing.")
			return true
		else
			if not minetest.registered_items[item:get_name()] then
				minetest.chat_send_player(name,"You are handling an unknown item (known before as " .. item:get_name() ..").")
				return true
			else
				minetest.chat_send_player(name,"You are handling a " .. minetest.registered_items[item:get_name()].description .. " also known as " .. item:get_name() .. ".")
				return true
			end
		end
	end
})
