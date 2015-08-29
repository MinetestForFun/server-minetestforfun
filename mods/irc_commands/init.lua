
local irc_users = {}
local irc_tokens = {}
local tokens_file = minetest.get_worldpath() .. "/irc_tokens"

local old_chat_send_player = minetest.chat_send_player
minetest.chat_send_player = function(name, message)
	for nick, loggedInAs in pairs(irc_users) do
		if name == loggedInAs and not minetest.get_player_by_name(name) then
			irc:say(nick, message)
		end
	end
	return old_chat_send_player(name, message)
end

-- Load/Save tokens
local function load_tokens()
	local f = io.open(tokens_file, "r")
	local tokens = {}
	if f then
		tokens = minetest.deserialize(f:read())	
		f:close()
	end
	return tokens
end
irc_tokens = load_tokens()

local function save_tokens()
	local f = io.open(tokens_file, "w")
	if f then
		f:write(minetest.serialize(irc_tokens))
		f:close()
		return true
	else
		minetest.log("error", "[IRC_Commands] Tokens storage file couldn't be created!")
		return false
	end
end

local function generate_token(name)
	local passtr = ""
	for i = 1, math.random(20,40) do
		passtr = passtr .. tostring(math.random(1,65535))
	end
	return minetest.get_password_hash(name, passtr)
end

-- Note: You can and **should** regulary regenerate tokens
minetest.register_chatcommand("gen_token", {
	description = "Generate irc token to log in",
	privs = {shout = true},
	func = function(name, param)
		if not minetest.get_player_by_name(name) then
			return false, "You need to be logged in to the server to generate tokens"
		end
		local h = ""
		if irc_tokens[name] then
			h = " new"
		end
		irc_tokens[name] = generate_token(name)
		minetest.chat_send_player(name, "Here is you" .. h .. " token : " .. irc_tokens[name])
		save_tokens()

		-- Disconnect any user using this login
		for nick, loggedInAs in pairs(irc_users) do
			if loggedInAs == name then
				minetest.log("action", nick.."@IRC has been logged out from "
					..irc_users[nick] .. " (token regenerated)")
				irc_users[nick] = nil
				irc:say(nick, "Token regenerated. You are now logged off.")
			end		
		end
		return true
	end
})

minetest.register_chatcommand("del_token", {
	description = "Delete your entry in the token register",
	privs = {shout = true},
	func = function(name)
		if not minetest.get_player_by_name(name) then
			return false, "You need to be logged in to the server to generate tokens"
		end
		if not irc_tokens[name] then
			return true, "You had no entry in the tokens' register"
		else
			irc_tokens[name] = nil
			save_tokens()
			-- Disconnect any user using this login
			for nick, loggedInAs in pairs(irc_users) do
				if loggedInAs == name then
					minetest.log("action", nick.."@IRC has been logged out from "
						..irc_users[nick] .. " (token regenerated)")
					irc_users[nick] = nil
					irc:say(nick, "Token regenerated. You are now logged off.")
				end		
			end
			return true, "Access for you using a token has been removed. Use /gen_token to create" ..
				" a new token at any time"
		end
	end
})

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


-- Pretty much a copypasta of the command right after this one
-- We'll keep "login" until passwords are broken. When it happens,
-- We'll remove "tlogin" and modify "login" to handle tokens
irc:register_bot_command("tlogin", {
	params = "<username> <pass_token>",
	description = "Login as an user to run commands, using a token",
	func = function(user, args)
		if args == "" then
			return false, "You need a username and a token."
		end
		local playerName, token = args:match("^(%S+)%s(%S+)$")
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
		if irc_tokens[playerName] and
			irc_tokens[playerName] == token then
			minetest.log("action", "User " .. user.nick
					.." from IRC logs in as " .. playerName .. " using their token")
			irc_users[user.nick] = playerName
			return true, "You are now logged in as " .. playerName
		else
			minetest.log("action", user.nick.."@IRC attempted to log in as "
				..playerName.." unsuccessfully using a token")
			return false, "Incorrect token or player does not exist."
		end
	end
})

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

irc:register_bot_command("timeofday", {
	description = "Tell the in-game time of day",
	func = function(user, args)
		local timeofday = minetest.get_timeofday()
		local hours, minutes = math.modf(timeofday * 24)
		minutes = math.floor(minutes * 60)
		return true, "It's " .. hours .. " h " .. minutes .. " min."
	end
})
