whoison = {}
whoison.lastrun = os.time()
whoison.lastseen = {}

local filename = minetest.get_worldpath().."/online-players"
local seenfile = minetest.get_worldpath().."/last-seen"

function whoison.createFile(loopit)
	local file = io.open(filename, "w")
	file:write(os.time().."\n")
	file:write(minetest.get_server_status().."\n")
	for _,player in ipairs(minetest.get_connected_players()) do

		local name = player:get_player_name()
		whoison.updateStats(name)
		local ppos = minetest.pos_to_string(player:getpos())
		local datastring = name.."|"..ppos.."\n"
		file:write( datastring )
	end
	file:close()
	minetest.log("action","Updated online player file")
	if ( loopit == true ) then
		minetest.after(300,whoison.createFile,true)
	end
	whoison.lastrun = os.time()
end

function whoison.saveLastSeen()
	local f = io.open(seenfile,"w")
	f:write(minetest.serialize(whoison.lastseen))
	f:close()
end

function whoison.loadLastSeen()
	local f = io.open(seenfile,"r")
	if ( f ~= nil ) then
		local ls = f:read("*all")
		f:close()
		if ( ls ~= nil and ls ~= "" ) then
			whoison.lastseen = minetest.deserialize(ls)
		end
	end
end

function whoison.getLastOnline(name)
	whoison.updateFormat(name)
	return whoison.lastseen[name]['lastonline']
end

function whoison.getTimeOnline(name)
	whoison.updateFormat(name)
	return whoison.lastseen[name]['timeonline']
end

function whoison.updateStats(name)
	whoison.updateFormat(name)
	whoison.lastseen[name]['timeonline'] = whoison.lastseen[name]['timeonline'] + ( os.time() - whoison.lastrun )
	whoison.lastseen[name]['lastonline'] = os.time()
end

function whoison.updateFormat(name)
	if ( type(whoison.lastseen[name]) ~= "table" ) then
		-- update old data to new format
		minetest.log("action",name.." lastseen is not a table... fixing...")
		local lo = whoison.lastseen[name]
		whoison.lastseen[name] = {timeonline=0,lastonline=lo}
	end
end

minetest.register_on_joinplayer(function (player)
	whoison.createFile(false)
	whoison.saveLastSeen()
end)

minetest.register_on_leaveplayer(function (player)
	whoison.createFile(false)
	whoison.saveLastSeen()
end)

minetest.register_chatcommand("seen",{
	param = "<name>",
	description = "Tells the last time a player was online",
	func = function (name, param)
		if ( param ~= nil ) then
			local t = whoison.getLastOnline(param)
			if ( t ~= nil ) then
				local diff = (os.time() - t)
				minetest.chat_send_player(name,param.." was last online "..breakdowntime(diff).." ago")
			else
				minetest.chat_send_player(name,"Sorry, I have no record of "..param)
			end
		else
			minetest.chat_send_player(name,"Usage is /seen <name>")
		end
	end
})

minetest.register_chatcommand("timeonline",{
	param = "<name>",
	description = "Shows the cumulative time a player has been online",
	func = function (name, param)
		if ( param ~= nil ) then
			local t = whoison.getTimeOnline(param)
			if ( t ~= nil ) then
				minetest.chat_send_player(name,param.." has been online for "..breakdowntime(t))
			else
				minetest.chat_send_player(name,"Sorry, I have no record of "..param)
			end
		else
			minetest.chat_send_player(name,"Usage is /timeonline <name>")
		end
	end
})

--minetest.register_chatcommand("timeonline", core.chatcommands["played"])

function breakdowntime(t)
	local countdown = t
	local answer = ""

	if countdown >= 86400 then
		local days = math.floor(countdown / 86400)
		countdown = countdown % 86400
		answer = days .. " days "
	end
	if countdown >= 3600 then
		local hours = math.floor(countdown / 3600)
		countdown = countdown % 3600
		answer = answer .. hours .. " hours "
	end
	if countdown >= 60 then
		local minutes = math.floor(countdown / 60)
		countdown = countdown % 60
		answer = answer .. minutes .. " minutes "
	end

	local seconds = countdown
	answer = answer .. seconds .. " seconds"

	return answer
end

minetest.after(10,whoison.createFile,true)

whoison.loadLastSeen()
