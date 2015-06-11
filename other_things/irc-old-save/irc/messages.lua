local irc = require("irc.main")

irc.msgs = {}
local msgs = irc.msgs

local msg_meta = {}
msg_meta.__index = msg_meta

function irc.Message(opts)
	opts = opts or {}
	setmetatable(opts, msg_meta)
	if opts.raw then
		opts:fromRFC1459(opts.raw)
	end
	return opts
end

local tag_escapes = {
	[";"] = "\\:",
	[" "] = "\\s",
	["\0"] = "\\0",
	["\\"] = "\\\\",
	["\r"] = "\\r",
	["\n"] = "\\n",
}

local tag_unescapes = {}
for x, y in pairs(tag_escapes) do tag_unescapes[y] = x end

function msg_meta:toRFC1459()
	local s = ""

	if self.tags then
		s = s.."@"
		for key, value in pairs(self.tags) do
			s = s..key
			if value ~= true then
				value = value:gsub("[; %z\\\r\n]", tag_escapes)
				s = s.."="..value
			end
			s = s..";"
		end
		-- Strip trailing semicolon
		s = s:sub(1, -2)
		s = s.." "
	end

	s = s..self.command

	local argnum = #self.args
	for i = 1, argnum do
		local arg = self.args[i]
		local startsWithColon = (arg:sub(1, 1) == ":")
		local hasSpace = arg:find(" ")
		if i == argnum and (hasSpace or startsWithColon) then
			s = s.." :"
		else
			assert(not hasSpace and not startsWithColon,
					"Message arguments can not be "
					.."serialized to RFC1459 format")
			s = s.." "
		end
		s = s..arg
	end

	return s
end

local function parsePrefix(prefix)
	local user = {}
	user.nick, user.username, user.host = prefix:match("^(.+)!(.+)@(.+)$")
	if not user.nick and prefix:find(".", 1, true) then
		user.server = prefix
	end
	return user
end

function msg_meta:fromRFC1459(line)
	-- IRCv3 tags
	if line:sub(1, 1) == "@" then
		self.tags = {}
		local space = line:find(" ", 1, true)
		-- For each semicolon-delimited section from after
		-- the @ character to before the space character.
		for tag in line:sub(2, space - 1):gmatch("([^;]+)") do
			local eq = tag:find("=", 1, true)
			if eq then
				self.tags[tag:sub(1, eq - 1)] =
					tag:sub(eq + 1):gsub("\\([:s0\\rn])", tag_unescapes)
			else
				self.tags[tag] = true
			end
		end
		line = line:sub(space + 1)
	end

	if line:sub(1, 1) == ":" then
		local space = line:find(" ", 1, true)
		self.prefix = line:sub(2, space - 1)
		self.user = parsePrefix(self.prefix)
		line = line:sub(space + 1)
	end

	local pos
	self.command, pos = line:match("(%S+)()")
	-- /MFF BEGIN
	if not pos then
		minetest.log("error", "[IRC] This crash message was intended to see the value of a breaking variable. line = " .. (line or "nil"))
		return
	end
	-- /MFF END (Mg|06/01/2015)
	line = line:sub(pos)

	self.args = self.args or {}
	for pos, param in line:gmatch("()(%S+)") do
		if param:sub(1, 1) == ":" then
			param = line:sub(pos + 1)
			table.insert(self.args, param)
			break
		end
		table.insert(self.args, param)
	end
end

function msgs.privmsg(to, text)
	return irc.Message({command="PRIVMSG", args={to, text}})
end

function msgs.notice(to, text)
	return irc.Message({command="NOTICE", args={to, text}})
end

function msgs.action(to, text)
	return irc.Message({command="PRIVMSG", args={to, ("\x01ACTION %s\x01"):format(text)}})
end

function msgs.ctcp(command, to, args)
	s = "\x01"..command
	if args then
		s = ' '..args
	end
	s = s..'\x01'
	return irc.Message({command="PRIVMSG", args={to, s}})
end

function msgs.kick(channel, target, reason)
	return irc.Message({command="KICK", args={channel, target, reason}})
end

function msgs.join(channel, key)
	return irc.Message({command="JOIN", args={channel, key}})
end

function msgs.part(channel, reason)
	return irc.Message({command="PART", args={channel, reason}})
end

function msgs.quit(reason)
	return irc.Message({command="QUIT", args={reason}})
end

function msgs.kill(target, reason)
	return irc.Message({command="KILL", args={target, reason}})
end

function msgs.kline(time, mask, reason, operreason)
	local args = nil
	if time then
		args = {time, mask, reason..'|'..operreason}
	else
		args = {mask, reason..'|'..operreason}
	end
	return irc.Message({command="KLINE", args=args})
end

function msgs.whois(nick, server)
	local args = nil
	if server then
		args = {server, nick}
	else
		args = {nick}
	end
	return irc.Message({command="WHOIS", args=args})
end

function msgs.topic(channel, text)
	return irc.Message({command="TOPIC", args={channel, text}})
end

function msgs.invite(channel, target)
	return irc.Message({command="INVITE", args={channel, target}})
end

function msgs.nick(nick)
	return irc.Message({command="NICK", args={nick}})
end

function msgs.mode(target, modes)
	-- We have to split the modes parameter because the mode string and
	-- each parameter are seperate arguments (The first command is incorrect)
	--   MODE foo :+ov Nick1 Nick2
	--   MODE foo +ov Nick1 Nick2
	local mt = irc.split(modes)
	return irc.Message({command="MODE", args={target, unpack(mt)}})
end

