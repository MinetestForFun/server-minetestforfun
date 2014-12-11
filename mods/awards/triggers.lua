-- AWARDS
--    by Rubenwardy
-------------------------------------------------------
-- this is the trigger handler file for the awards mod
-------------------------------------------------------

-- Function and table holders for Triggers
awards.onDig = {}
awards.onPlace = {}
awards.onChat = {}
awards.onDeath = {}
awards.onJoin = {}

-- Trigger Handles
minetest.register_on_dignode(function(pos, oldnode, digger)
	if not digger or not pos or not oldnode then
		return
	end
	local nodedug = string.split(oldnode.name, ":")
	if #nodedug ~= 2 then
		--minetest.log("error","Awards mod: "..oldnode.name.." is in wrong format!")
		return
	end
	local mod = nodedug[1]
	local item = nodedug[2]
	local playern = digger:get_player_name()

	if (not playern or not nodedug or not mod or not item) then
		return
	end
	awards.assertPlayer(playern)
	awards.tbv(awards.players[playern].count, mod)
	awards.tbv(awards.players[playern].count[mod], item, 0)

	-- Increment counter
	awards.players[playern].count[mod][item]=awards.players[playern].count[mod][item] + 1

	-- Run callbacks and triggers
	local player=digger
	local data=awards.players[playern]
	for i=1,# awards.onDig do
		local res = nil
		if type(awards.onDig[i]) == "function" then
			-- Run trigger callback
			res = awards.onDig[i](player,data)
		elseif type(awards.onDig[i]) == "table" then
			-- Handle table trigger
			if not awards.onDig[i].node or not awards.onDig[i].target or not awards.onDig[i].award then
				-- table running failed!
				print("[ERROR] awards - onDig trigger "..i.." is invalid!")
			else
				-- run the table
				local tnodedug = string.split(awards.onDig[i].node, ":")
				local tmod=tnodedug[1]
				local titem=tnodedug[2]
				if tmod==nil or titem==nil or not data.count[tmod] or not data.count[tmod][titem] then
					-- table running failed!
				elseif data.count[tmod][titem] > awards.onDig[i].target-1 then
					res=awards.onDig[i].award
				end
			end
		end

		if res then
			awards.give_achievement(playern,res)
		end
	end
end)

minetest.register_on_placenode(function(pos,node,digger)
	if not digger or not pos or not node or not digger:get_player_name() or digger:get_player_name()=="" then
		return
	end
	local nodedug = string.split(node.name, ":")
	if #nodedug ~= 2 then
		--minetest.log("error","Awards mod: "..node.name.." is in wrong format!")
		return
	end
	local mod=nodedug[1]
	local item=nodedug[2]
	local playern = digger:get_player_name()

	-- Run checks
	if (not playern or not nodedug or not mod or not item) then
		return
	end
	awards.assertPlayer(playern)
	awards.tbv(awards.players[playern].place, mod)
	awards.tbv(awards.players[playern].place[mod], item, 0)

	-- Increment counter
	awards.players[playern].place[mod][item] = awards.players[playern].place[mod][item] + 1

	-- Run callbacks and triggers
	local player = digger
	local data = awards.players[playern]
	for i=1,# awards.onPlace do
		local res = nil
		if type(awards.onPlace[i]) == "function" then
			-- Run trigger callback
			res = awards.onPlace[i](player,data)
		elseif type(awards.onPlace[i]) == "table" then
			-- Handle table trigger
			if not awards.onPlace[i].node or not awards.onPlace[i].target or not awards.onPlace[i].award then
				print("[ERROR] awards - onPlace trigger "..i.." is invalid!")
			else
				-- run the table
				local tnodedug = string.split(awards.onPlace[i].node, ":")
				local tmod = tnodedug[1]
				local titem = tnodedug[2]
				if tmod==nil or titem==nil or not data.place[tmod] or not data.place[tmod][titem] then
					-- table running failed!
				elseif data.place[tmod][titem] > awards.onPlace[i].target-1 then
					res = awards.onPlace[i].award
				end
			end
		end

		if res then
			awards.give_achievement(playern,res)
		end
	end
end)

minetest.register_on_dieplayer(function(player)
	-- Run checks
	local name = player:get_player_name()
	if not player or not name or name=="" then
		return
	end
	
	-- Get player	
	awards.assertPlayer(name)
	local data = awards.players[name]

	-- Increment counter
	data.deaths = data.deaths + 1
	
	-- Run callbacks and triggers
	for _,trigger in pairs(awards.onDeath) do
		local res = nil
		if type(trigger) == "function" then
			res = trigger(player,data)
		elseif type(trigger) == "table" then
			if trigger.target and trigger.award then
				if data.deaths and data.deaths >= trigger.target then
					res = trigger.award
				end
			end
		end
		if res ~= nil then
			awards.give_achievement(name,res)
		end
	end
end)

minetest.register_on_joinplayer(function(player)
	-- Run checks
	local name = player:get_player_name()
	if not player or not name or name=="" then
		return
	end
	
	-- Get player	
	awards.assertPlayer(name)
	local data = awards.players[name]

	-- Increment counter
	data.joins = data.joins + 1
	
	-- Run callbacks and triggers
	for _,trigger in pairs(awards.onJoin) do
		local res = nil
		if type(trigger) == "function" then
			res = trigger(player,data)
		elseif type(trigger) == "table" then
			if trigger.target and trigger.award then
				if data.joins and data.joins >= trigger.target then
					res = trigger.award
				end
			end
		end
		if res ~= nil then
			awards.give_achievement(name,res)
		end
	end
end)

minetest.register_on_chat_message(function(name, message)
	-- Run checks
	local idx = string.find(message,"/")
	if not name or (idx ~= nil and idx <= 1)  then
		return
	end

	-- Get player
	awards.assertPlayer(name)
	local data = awards.players[name]
	local player = minetest.get_player_by_name(name)
	
	-- Increment counter
	data.chats = data.chats + 1
	
	-- Run callbacks and triggers	
	for _,trigger in pairs(awards.onChat) do
		local res = nil
		if type(trigger) == "function" then
			res = trigger(player,data)
		elseif type(trigger) == "table" then
			if trigger.target and trigger.award then
				if data.chats and data.chats >= trigger.target then
					res = trigger.award
				end
			end
		end
		if res ~= nil then
			awards.give_achievement(name,res)
		end
	end
end)

minetest.register_on_newplayer(function(player)
	local playern = player:get_player_name()
	awards.assertPlayer(playern)
end)

minetest.register_on_shutdown(function()
	awards.save()
end)
