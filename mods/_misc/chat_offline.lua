-- This allows me to chat and use basic commands without being in-game
-- Based on the External Command mod by Menche

minetest.register_globalstep(
	function(dtime)
		f = (io.open(minetest.get_worldpath("external_cmd").."/message", "r"))
		if f ~= nil then
			local message = f:read("*line")
			f:close()
			os.remove(minetest.get_worldpath("external_cmd").."/message")
			if message ~= nil then
				local cmd, param = string.match(message, "^/([^ ]+) *(.*)")
				if not param then
					param = ""
				end
				local cmd_def = minetest.chatcommands[cmd]
				if cmd_def then
					cmd_def.func("CraigyDavi", param)
				else
					minetest.chat_send_all("<CraigyDavi> "..message)
				end
			end
		end
	end
)
