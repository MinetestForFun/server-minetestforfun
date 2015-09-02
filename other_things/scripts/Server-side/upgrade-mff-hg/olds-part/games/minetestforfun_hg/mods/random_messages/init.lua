--[[
RandomMessages mod by arsdragonfly.
arsdragonfly@gmail.com
6/19/2013
--]]
--Time between two subsequent messages.
local MESSAGE_INTERVAL = 0

math.randomseed(os.time())

random_messages = {}
random_messages.messages = {} --This table contains all messages.

function random_messages.initialize() --Set the interval in minetest.conf.
	minetest.setting_set("random_messages_interval",120)
	minetest.setting_save();
	return 120
end

function random_messages.set_interval() --Read the interval from minetest.conf(set it if it doesn'st exist)
	MESSAGE_INTERVAL = tonumber(minetest.setting_get("random_messages_interval")) or random_messages.initialize()
end

function random_messages.read_messages()
	local line_number = 1
	local input = io.open(minetest.get_worldpath().."/random_messages","r")
	if not input then
		local output = io.open(minetest.get_worldpath().."/random_messages","w")
		output:write("Blame the server admin! He/She has probably not edited the random messages yet.\n")
		output:write("Tell your dumb admin that this line is in (worldpath)/random_messages \n")
		io.close(output)
		input = io.open(minetest.get_worldpath().."/random_messages","r")
	end
	for line in input:lines() do
		random_messages.messages[line_number] = line
		line_number = line_number + 1
	end
	io.close(input)
end

function random_messages.display_message(message_number)
	if random_messages.messages[message_number] then
		minetest.chat_send_all(random_messages.messages[message_number])
	end
end

function random_messages.show_message()
	random_messages.display_message(math.random(#random_messages.messages))
end

--When server starts:
random_messages.set_interval()
random_messages.read_messages()

local TIMER = 0
minetest.register_globalstep(function(dtime)
	TIMER = TIMER + dtime;
	if TIMER > MESSAGE_INTERVAL then
		random_messages.show_message()
		TIMER = 0
	end
end)

