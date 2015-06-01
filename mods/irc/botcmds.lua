irc.whereis_timer = {}
irc.whereis_timer_max_limit = 120
irc.bot_commands = {}

function irc:check_botcmd(msg)
	local prefix = irc.config.command_prefix
	local nick = irc.conn.nick:lower()
	local text = msg.args[2]
	local nickpart = text:sub(1, #nick + 2):lower()

	-- First check for a nick prefix
	if nickpart == nick..": " or
	   nickpart == nick..", " then
		self:bot_command(msg, text:sub(#nick + 3))
		return true
	-- Then check for the configured prefix
	elseif prefix and text:sub(1, #prefix):lower() == prefix:lower() then
		self:bot_command(msg, text:sub(#prefix + 1))
		return true
	end
	return false
end


function irc:bot_command(msg, text)
	if text:sub(1, 1) == "@" then
		local found, _, player_to, message = text:find("^.([^%s]+)%s(.+)$")
		if not minetest.get_player_by_name(player_to) then
			irc:reply("User '"..player_to.."' is not in the game.")
			return
		elseif not irc.joined_players[player_to] then
			irc:reply("User '"..player_to.."' is not using IRC.")
			return
		end
		minetest.chat_send_player(player_to,
				"PM from "..msg.user.nick.."@IRC: "..message, false)
		irc:reply("Message sent!")
		return
	end
	local pos = text:find(" ", 1, true)
	local cmd, args
	if pos then
		cmd = text:sub(1, pos - 1)
		args = text:sub(pos + 1)
	else
		cmd = text
		args = ""
	end
 
	if not self.bot_commands[cmd] then
		self:reply("Unknown command '"..cmd.."'. Try 'list'."
			.." Or use @playername <message> to send a private message")
		return
	end
 
	local success, message = self.bot_commands[cmd].func(msg.user, args)
	if message then
		self:reply(message)
	end
end


function irc:register_bot_command(name, def)
	if (not def.func) or (type(def.func) ~= "function") then
		error("Erroneous bot command definition. def.func missing.", 2)
	elseif name:sub(1, 1) == "@" then
		error("Erroneous bot command name. Command name begins with '@'.", 2)
	end
	self.bot_commands[name] = def
end


irc:register_bot_command("help", {
	params = "<command>",
	description = "Get help about a command",
	func = function(user, args)
		if args == "" then
			return false, "No command name specified. Use 'list' for a list of commands."
		end

		local cmd = irc.bot_commands[args]
		if not cmd then
			return false, "Unknown command '"..cmdname.."'."
		end

		return true, ("Usage: %c%s %s -- %s"):format(
				irc.config.command_prefix,
				args,
				cmd.params or "<no parameters>",
				cmd.description or "<no description>")
	end
})


irc:register_bot_command("list", {
	params = "",
	description = "List available commands.",
	func = function(user, args)
		local cmdlist = "Available commands: "
		for name, cmd in pairs(irc.bot_commands) do
			cmdlist = cmdlist..name..", "
		end
		return true, cmdlist.." -- Use 'help <command name>' to get"
			.." help about a specific command."
	end
})


irc:register_bot_command("whereis", {
	params = "<player>",
	description = "Tell the location of <player>",
	func = function(user, args)
		if args == "" then
			return false, "Player name required."
		end
		local player = minetest.get_player_by_name(args)
		if not player then
			return false, "There is no player named '"..args.."'"
		end
		if irc.whereis_timer[user.nick] ~= nil then
			local timer_player = os.difftime(os.time(),irc.whereis_timer[user.nick])
			if timer_player < irc.whereis_timer_max_limit then
				local answer = "Command used too often, retry in %d seconds."
				return false,answer:format(irc.whereis_timer_max_limit - timer_player)
			end
		end
		local fmt = "Player %s is at (%.2f,%.2f,%.2f)"
		local pos = player:getpos()
		irc.whereis_timer[user.nick] = os.time()
		minetest.log("action","IRC user ".. user.nick.."!"..user.username.."@"..user.host.." asked for position of player "..player:get_player_name())
		minetest.chat_send_player(player:get_player_name(),"IRC user ".. user.nick.."!"..user.username.."@"..user.host.." asked for your position")
		return true, fmt:format(args, pos.x, pos.y, pos.z)
	end
})


local starttime = os.time()
irc:register_bot_command("uptime", {
	description = "Tell how much time the server has been up",
	func = function(user, args)
		local cur_time = os.time()
		local diff = os.difftime(cur_time, starttime)
		local fmt = "Server has been running for %d:%02d:%02d"
		return true, fmt:format(
			math.floor(diff / 60 / 60),
			math.floor(diff / 60) % 60,
			math.floor(diff) % 60
		)
	end
})


irc:register_bot_command("players", {
	description = "List the players on the server",
	func = function(user, args)
		local players = minetest.get_connected_players()
		local names = {}
		for _, player in pairs(players) do
			table.insert(names, player:get_player_name())
		end
		return true, "Connected players: "
				..table.concat(names, ", ")
	end
})

