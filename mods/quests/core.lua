-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	-- If you don't use insertions (@1, @2, etc) you can use this:
	S = function(s) return s end
end


-- registers a quest for later use
--
-- questname is the name of the quest to identify it later
-- 	it should follow the naming conventions: "modname:questname"
-- quest is a table in the following format
-- 	{
--	  title, 		-- is shown to the player and should contain usefull information about the quest.
--	  description, 		-- a small description of the mod.
-- 	  max,			-- is the desired maximum. If max is 1, no maximum is displayed. defaults to 1
-- 	  autoaccept, 		-- is true or false, wether the result of the quest should be dealt by this mode or the registering mod.
-- 	  callback 		-- when autoaccept is true, at the end of the quest, it gets removed and callback is called.
--	                        -- function(playername, questname, metadata)
--	}
--
-- returns true, when the quest was successfully registered
-- returns falls, when there was already such a quest
function quests.register_quest(questname, quest)
	if (quests.registered_quests[questname] ~= nil) then
		return false -- The quest was not registered since there already a quest with that name
	end
	quests.registered_quests[questname] =
		{ title       = quest.title or S("missing title"),
		  description = quest.description or S("missing description"),
		  max         = quest.max or 1,
		  autoaccept  = quest.autoaccept or false,
		  callback    = quest.callback, }
	return true
end

-- starts a quest for a specified player
--
-- playername - the name of the player
-- questname  - the name of the quest, which was registered with quests.register_quest
-- metadata   - optional additional data
--
-- returns false on failure
-- returns true if the quest was started
function quests.start_quest(playername, questname, metadata)
	if (quests.registered_quests[questname] == nil) then
		return false
	end
	if (quests.active_quests[playername] == nil) then
		quests.active_quests[playername] = {}
	end
	if (quests.active_quests[playername][questname] ~= nil) then
		return false -- the player has already this quest
	end
	quests.active_quests[playername][questname] = {value = 0, metadata = metadata}

	quests.update_hud(playername)
	quests.show_message("new", playername, S("New quest:") .. " " .. quests.registered_quests[questname].title)
	return true
end

-- when something happens that has effect on a quest, a mod should call this method
-- playername is the name of the player
-- questname is the quest which gets updated
-- the quest gets updated by value
-- this method calls a previously specified callback if autoaccept is true
--
-- returns true if the quest is finished
-- returns false if there is no such quest or the quest continues
function quests.update_quest(playername, questname, value)
	if (quests.active_quests[playername] == nil) then
		quests.active_quests[playername] = {}
	end
	if (quests.active_quests[playername][questname] == nil) then
		return false -- there is no such quest
	end
	if (quests.active_quests[playername][questname].finished) then
		return false -- the quest is already finished
	end
	if (value == nil) then
		return false -- no value given
	end
	quests.active_quests[playername][questname]["value"] = quests.active_quests[playername][questname]["value"] + value
	if (quests.active_quests[playername][questname]["value"] >= quests.registered_quests[questname]["max"]) then
		quests.active_quests[playername][questname]["value"] = quests.registered_quests[questname]["max"]
		if (quests.registered_quests[questname]["autoaccept"]) then
			if (quests.registered_quests[questname]["callback"] ~= nil) then
				quests.registered_quests[questname]["callback"](playername, questname,
					quests.active_quests[playername][questname].metadata)
			end
			quests.accept_quest(playername,questname)
			quests.update_hud(playername)
		end
		return true -- the quest is finished
	end
	quests.update_hud(playername)
	return false -- the quest continues
end

-- When the mod handels the end of quests himself, e.g. you have to talk to somebody to finish the quest,
-- you have to call this method to end a quest
-- returns true, when the quest is completed
-- returns false, when the quest is still ongoing
function quests.accept_quest(playername, questname)
	if (quests.active_quests[playername][questname] and not quests.active_quests[playername][questname].finished) then
		if (quests.successfull_quests[playername] == nil) then
			quests.successfull_quests[playername] = {}
		end
		if (quests.successfull_quests[playername][questname] ~= nil) then
			quests.successfull_quests[playername][questname].count = quests.successfull_quests[playername][questname].count + 1
		else
			quests.successfull_quests[playername][questname] = {count = 1}
		end
		quests.active_quests[playername][questname].finished = true
		for _,quest in ipairs(quests.hud[playername].list) do
			if (quest.name == questname) then
				local player = minetest.get_player_by_name(playername)
				player:hud_change(quest.id, "number", quests.colors.success)
			end
		end
		quests.show_message("success", playername, S("Quest completed:") .. " " .. quests.registered_quests[questname].title)
		minetest.after(3, function(playername, questname)
			quests.active_quests[playername][questname] = nil
			quests.update_hud(playername)
		end, playername, questname)
		return true -- the quest is finished, the mod can give a reward
	end
	return false -- the quest hasn't finished
end

-- call this method, when you want to end a quest even when it was not finished
-- example: the player failed
--
-- returns false if the quest was not aborted
-- returns true when the quest was aborted
function quests.abort_quest(playername, questname)
	if (questname == nil) then
		return false
	end	
	if (quests.failed_quests[playername] == nil) then
		quests.failed_quests[playername] = {}
	end
	if (quests.active_quests[playername][questname] == nil) then
		return false
	end
	if (quests.failed_quests[playername][questname] ~= nil) then
		quests.failed_quests[playername][questname].count = quests.failed_quests[playername][questname].count + 1
	else
		quests.failed_quests[playername][questname] = { count = 1 }
	end

	quests.active_quests[playername][questname].finished = true
	for _,quest in ipairs(quests.hud[playername].list) do
		if (quest.name == questname) then
			local player = minetest.get_player_by_name(playername)
			player:hud_change(quest.id, "number", quests.colors.failed)
		end
	end
	quests.show_message("failed", playername, S("Quest failed:") .. " " .. quests.registered_quests[questname].title)
	minetest.after(3, function(playername, questname)
		quests.active_quests[playername][questname] = nil
		quests.update_hud(playername)
	end, playername, questname)
end

-- get metadata of the quest if the quest exists, else return nil
function quests.get_metadata(playername, questname)
	if (quests.active_quests[playername] == nil or quests.active_quests[playername][questname] == nil) then
		return nil
	end
	return quests.active_quests[playername][questname].metadata
end

-- set metadata of the quest
function quests.set_metadata(playername, questname, metadata)
	if (quests.active_quests[playername] == nil or quests.active_quests[playername][questname] == nil) then
		return
	end
	quests.active_quests[playername][questname].metadata = metadata
end

