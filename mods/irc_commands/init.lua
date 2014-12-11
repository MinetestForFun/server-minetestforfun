
local irc_users = {}

local old_chat_send_player = minetest.chat_send_player
minetest.chat_send_player = function(name, message)
	for nick, loggedInAs in pairs(irc_users) do
		if name == loggedInAs and not minetest.get_player_by_name(name) then
			irc:say(nick, message)
		end
	end
	return old_chat_send_player(name, message)
end

irc:register_hook("NickChange", function(user, newNick)
	for nick, player in pairs(irc_users) do
		if nick == user.nick then
			irc_users[newNick] = irc_users[user.nick]
			irc_users[user.nick] = nil
		end
	end
end)

irc:register_hook("OnPart", function(user, channel, reason)
	irc_users[user.nick] = nil
end)

irc:register_hook("OnKick", function(user, channel, target, reason)
	irc_users[target] = nil
end)

irc:register_hook("OnQuit", function(user, reason)
	irc_users[user.nick] = nil
end)

irc:register_bot_command("login", {
	params = "<username> <password>",
	description = "Login as a user to run commands",
	func = function(user, args)
		if args == "" then
			return false, "You need a username and password."
		end
		local playerName, password = args:match("^(%S+)%s(%S+)$")
		if not playerName then
			return false, "Player name and password required."
		end
		local inChannel = false
		local users = irc.conn.channels[irc.config.channel].users
		for cnick, cuser in pairs(users) do
			if user.nick == cnick then
				inChannel = true
				break
			end
		end
		if not inChannel then
			return false, "You need to be in the server's channel to login."
		end
		if minetest.auth_table[playerName] and
				minetest.auth_table[playerName].password ==
				minetest.get_password_hash(playerName, password) then
			minetest.log("action", "User "..user.nick
					.." from IRC logs in as "..playerName)
			irc_users[user.nick] = playerName
			return true, "You are now logged in as "..playerName
		else
			minetest.log("action", user.nick.."@IRC attempted to log in as "
				..playerName.." unsuccessfully")
			return false, "Incorrect password or player does not exist."
		end
	end
})

irc:register_bot_command("logout", {
	description = "Logout",
	func = function (user, args)
		if irc_users[user.nick] then
			minetest.log("action", user.nick.."@IRC logs out from "
				..irc_users[user.nick])
			irc_users[user.nick] = nil
			return true, "You are now logged off."
		else
			return false, "You are not logged in."
		end
	end,
})

irc:register_bot_command("cmd", {
	params = "<command>",
	description = "Run a command on the server",
	func = function (user, args)
		if args == "" then
			return false, "You need a command."
		end
		if not irc_users[user.nick] then
			return false, "You are not logged in."
		end
		local found, _, commandname, params = args:find("^([^%s]+)%s(.+)$")
		if not found then
			commandname = args
		end
		local command = minetest.chatcommands[commandname]
		if not command then
			return false, "Not a valid command."
		end
		if not minetest.check_player_privs(irc_users[user.nick], command.privs) then
			return false, "Your privileges are insufficient."
		end
		minetest.log("action", user.nick.."@IRC runs "
			..args.." as "..irc_users[user.nick])
		return command.func(irc_users[user.nick], (params or ""))
	end
})

irc:register_bot_command("say", {
	params = "message",
	description = "Say something",
	func = function (user, args)
		if args == "" then
			return false, "You need a message."
		end
		if not irc_users[user.nick] then
			return false, "You are not logged in."
		end
		if not minetest.check_player_privs(irc_users[user.nick], {shout=true}) then
			minetest.log("action", ("%s@IRC tried to say %q as %s"
				.." without the shout privilege.")
					:format(user.nick, args, irc_users[user.nick]))
			return false, "You can not shout."
		end
		minetest.log("action", ("%s@IRC says %q as %s.")
				:format(user.nick, args, irc_users[user.nick]))
		minetest.chat_send_all("<"..irc_users[user.nick].."@IRC> "..args)
		return true, "Message sent successfuly."
	end
})

