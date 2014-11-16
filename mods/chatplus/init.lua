-- Chat Plus
-- =========
-- Advanced chat functionality
-- =========

chatplus = {
	log_file = minetest.get_worldpath().."/chat_log.txt",
	_defsettings = {
		log = false, -- Set to true to log chat in a file found in the world directory.
		use_gui = true,
		distance = 0,
		badwords = "" -- Words not allowed to be said in chat, separated by commas. Uncomment the code near the end to make this work.
	}
}

function chatplus.init()
	chatplus.load()
	chatplus.clean_players()
	
	if not chatplus.players then
		chatplus.players = {}
	end
	chatplus.count = 0
	chatplus.loggedin = {}
	chatplus._handlers = {}
end

function chatplus.setting(name)
	local get = minetest.setting_get("chatplus_"..name)
	if get then
		return get
	elseif chatplus._defsettings[name]~= nil then
		return chatplus._defsettings[name]
	else
		minetest.log("[chatplus] Setting chatplus_"..name.." not found.")
		return nil
	end	
end

function chatplus.load()
	-- Initialize the log
	if chatplus.setting("log") then
		chatplus.log_handle = io.open(chatplus.log_file,"a+")
		if not chatplus.log_handle then
			minetest.log("error","Unable to open chatplus log file: "..chatplus.log_file)
		else
			minetest.log("action","Logging chatplus to: "..chatplus.log_file)
		end	
	end
	
	-- Load player data
	minetest.log("[chatplus] Loading data.")
	local file = io.open(minetest.get_worldpath().."/chatplus.txt", "r")
	if file then
		local table = minetest.deserialize(file:read("*all"))
		file:close()
		if type(table) == "table" then
			chatplus.players = table
			return
		end
	end	
end

function chatplus.save()
	minetest.log("[chatplus] Saving data.")
	
	local file = io.open(minetest.get_worldpath().."/chatplus.txt", "w")
	if file then
		file:write(minetest.serialize(chatplus.players))
		file:close()
	end
end

function chatplus.clean_players()
	if not chatplus.players then
		chatplus.players = {}
		return
	end

	minetest.log("[chatplus] Cleaning player lists.")
	for key,value in pairs(chatplus.players) do
		if value.messages then
			value.inbox = value.messages
			value.messages = nil			
		end
		
		if (
			(not value.inbox or #value.inbox==0) and
			(not value.ignore or #value.ignore==0)
		) then
			minetest.log("Deleting blank player "..key..".")
			value[key] = nil
		end
	end
	chatplus.save()
	minetest.log("[chatplus] Cleaning complete.")
end

function chatplus.poke(name,player)
	local function check(name,value)
		if not chatplus.players[name][value] then
			chatplus.players[name][value] = {}
		end
	end
	if not chatplus.players[name] then
		chatplus.players[name] = {}
	end
	check(name,"ignore")
	check(name,"inbox")
	
	chatplus.players[name].enabled = true
	
	if player then
		if player=="end" then
			chatplus.players[name].enabled = false
			chatplus.loggedin[name] = nil
		else
			if not chatplus.loggedin[name] then
				chatplus.loggedin[name] = {}				
			end
			chatplus.loggedin[name].player = player
		end
	end
	
	chatplus.save()
	
	return chatplus.players[name]
end

function chatplus.register_handler(func,place)
	if not place then
		table.insert(chatplus._handlers,func)
	else
		table.insert(chatplus._handlers,place,func)
	end
end

function chatplus.send(from,msg)
	-- Log chat message
	if chatplus.log_handle ~= nil then
		chatplus.log_handle:write(
			os.date("%Y-%m-%d, %I:%M%p")..
			" | <"..from.."> "..
			msg..
			"\r\n"
		)
		chatplus.log_handle:flush()
	end
	
	minetest.log("action", "<"..from.."> "..msg)
	
	-- Loop through senders
	for key,value in pairs(chatplus.loggedin) do
		local res = nil
		for i=1,#chatplus._handlers do
			if chatplus._handlers[i] then
				res = chatplus._handlers[i](from,key,msg)
				
				if res ~= nil then
					break
				end
			end
		end
		if (res == nil or res == true) and key~=from then
			minetest.chat_send_player(key,"<"..from.."> "..msg,false)
		end
	end

	return true
end

-- Minetest callbacks
minetest.register_on_chat_message(chatplus.send)
minetest.register_on_joinplayer(function(player)
	local _player = chatplus.poke(player:get_player_name(),player)

	if chatplus.log_handle ~= nil then
		chatplus.log_handle:write(os.date("%Y-%m-%d, %I:%M%p").." O "..player:get_player_name().." joined the game.\r\n")
		chatplus.log_handle:flush()
	end

	-- Inbox stuff.
	if _player.inbox and #_player.inbox>0 then
		minetest.after(10,minetest.chat_send_player,player:get_player_name(),"("..#_player.inbox..") You have mail! Type /inbox to view them.")	
	end
end)
minetest.register_on_leaveplayer(function(player)
	chatplus.poke(player:get_player_name(),"end")
	if chatplus.log_handle ~= nil then
		chatplus.log_handle:write(os.date("%Y-%m-%d, %I:%M%p").." X "..player:get_player_name().." left the game.\r\n")
		chatplus.log_handle:flush()
	end
end)

-- Init
chatplus.init()

-- Ignoring
chatplus.register_handler(function(from,to,msg)
	if chatplus.players[to] and chatplus.players[to].ignore and chatplus.players[to].ignore[from]==true then
		return false
	end
	return nil
end)

minetest.register_chatcommand("ignore", {
	params = "<name>",
	description = "Ignore a player",
	func = function(name, param)
		chatplus.poke(name)
		if not chatplus.players[name].ignore[param]==true then
			chatplus.players[name].ignore[param]=true
			minetest.chat_send_player(name,param.." has been ignored.")
			chatplus.save()
		else
			minetest.chat_send_player(name,param.." is already ignored.")
		end
	end
})

minetest.register_chatcommand("unignore", {
	params = "<name>",
	description = "Stop ignoring a player",
	func = function(name, param)
		chatplus.poke(name)
		if chatplus.players[name].ignore[param]==true then
			chatplus.players[name].ignore[param]=false
			minetest.chat_send_player(name,param.." has been unignored")
			chatplus.save()
		else
			minetest.chat_send_player(name,param.." is already unignored.")
		end
	end
})

-- inbox
function chatplus.showInbox(name,forcetest)
	if not chatplus.players[name] then
		return false
	end

	local player = chatplus.players[name]

	if not player.inbox or #player.inbox==0 then
		minetest.chat_send_player(name,"Your inbox is empty.")
		return false
	end
	local setting = chatplus.setting("use_gui")
	if (setting == true or setting == "true" or setting == "1") and not forcetest then
		local fs = "size[10,5]textlist[0,0;9.75,5;inbox;"
		for i=1,#player.inbox do
			if i > 1 then
				fs = fs .. ","
			end
			fs = fs .. minetest.formspec_escape(player.inbox[i])
		end
		fs = fs .. "]"
		print(fs)
		minetest.show_formspec(name, "chatplus:inbox", fs)
	else
		minetest.chat_send_player(name,"("..#player.inbox..") You have mail:")
		for i=1,#player.inbox do
			minetest.chat_send_player(name,player.inbox[i],false)
		end
		minetest.chat_send_player(name,"("..#player.inbox..")",false)
	end

	return true
end

minetest.register_chatcommand("inbox", {
	params = "[clear]",
	description = "Shows your inbox",
	func = function(name, param)
		if param == "clear" then
			local player = chatplus.poke(name)
			player.inbox = {}
			chatplus.save()
			minetest.chat_send_player(name,"Inbox cleared.")
		elseif param == "text" or param == "txt" or param == "t" then
			chatplus.showInbox(name,true)
		else
			chatplus.showInbox(name,false)
		end
	end,
})

minetest.register_chatcommand("mail", {
	params = "<name> <message>",
	description = "Add a message to a player's inbox",
	func = function(name, param)
		chatplus.poke(name)
		local to, msg = string.match(param, "([%a%d_]+) (.+)")
		
		if not to or not msg then
			minetest.chat_send_player(name,"Usage: /mail <player> <message>",false)
			return
		end

		--[[
		minetest.log("To: "..to..", From: "..name..", Message: "..msg)
		if chatplus.log_handle ~= nil then
			chatplus.log_handle:write(os.date("%Y-%m-%d, %I:%M%p").." @ To: "..to..", From: "..name..", Message: "..msg)
			chatplus.log_handle:flush()
		end
		--]]
		if chatplus.players[to] then
			table.insert(chatplus.players[to].inbox,os.date("%Y-%m-%d, %I:%M%p").." | <"..name.."> "..msg)
			minetest.chat_send_player(name,"Message sent.")
			chatplus.save()
		else
			minetest.chat_send_player(name,to.." does not exist.")
		end
	end,
})


minetest.register_globalstep(function(dtime)
	chatplus.count = chatplus.count + dtime
	if chatplus.count > 5 then
		chatplus.count = 0
		-- loop through player list
		for key,value in pairs(chatplus.players) do
			if (
				chatplus.loggedin and
				chatplus.loggedin[key] and
				chatplus.loggedin[key].player and
				value and
				value.inbox and
				chatplus.loggedin[key].player.hud_add and
				chatplus.loggedin[key].lastcount ~= #value.inbox
			) then				
				if chatplus.loggedin[key].msgicon then
					chatplus.loggedin[key].player:hud_remove(chatplus.loggedin[key].msgicon)
				end

				if chatplus.loggedin[key].msgicon2 then
					chatplus.loggedin[key].player:hud_remove(chatplus.loggedin[key].msgicon2)
				end

				if #value.inbox>0 then
					chatplus.loggedin[key].msgicon = chatplus.loggedin[key].player:hud_add({
						hud_elem_type = "image",
						name = "MailIcon",
						position = {x=0.52, y=0.52},
						text="chatplus_mail.png",
						scale = {x=1,y=1},
						alignment = {x=0.5, y=0.5},
					})
					chatplus.loggedin[key].msgicon2 = chatplus.loggedin[key].player:hud_add({
						hud_elem_type = "text",
						name = "MailText",
						position = {x=0.55, y=0.52},
						text=#value.inbox.." /inbox",
						scale = {x=1,y=1},
						alignment = {x=0.5, y=0.5},
					})					
				end
				chatplus.loggedin[key].lastcount = #value.inbox
			end
		end
	end
end)


--[[
chatplus.register_handler(function(from,to,msg)
	if chatplus.setting("distance") <= 0 then
		return nil
	end

	local from_o = minetest.get_player_by_name(from)
	local to_o = minetest.get_player_by_name(to)

	if not from_o or not to_o then
		return nil
	end

	if (
		chatplus.setting("distance") ~= 0 and
		chatplus.setting("distance") ~= nil and
		(vector.distance(from_o:getpos(),to_o:getpos()) > tonumber(chatplus.setting("distance")))
	)then
		return false
	end
	return nil
end)
--]]

--[[
chatplus.register_handler(function(from,to,msg)
	local words = chatplus.setting("badwords"):split(",")
	for _,v in pairs(words) do
		if (v:trim()~="") and ( msg:find(v:trim(), 1, true) ~= nil ) then
			minetest.chat_send_player(from, "Swearing is not allowed.")
			return false
		end
	end
	return nil
end)
--]]

if minetest.setting_getbool("log_mods") then
	minetest.log("action", "Carbone: [chatplus] loaded.")
end
