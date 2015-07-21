--- HIGLY UNFINISHED!!!!
--- HIGLY UNFINISHED!!!!
--- HIGLY UNFINISHED!!!!
--- HIGLY UNFINISHED!!!!
--- HIGLY UNFINISHED!!!!
--- HIGLY UNFINISHED!!!!
--- HIGLY UNFINISHED!!!!
--- HIGLY UNFINISHED!!!!
--- HIGLY UNFINISHED!!!!
--- HIGLY UNFINISHED!!!!
--- HIGLY UNFINISHED!!!!
--- HIGLY UNFINISHED!!!!
-- GOT THAT ENOUGH?
--        - gravgun
mff.quests = {}
mff.QPREFIX = "mff_quests:"

mff.quests.quests = {
	testdiggydiggyhole = {
		title = "Dig 10 nodes",
		max = 10,
		desc = "As long as you can not dig, you are not a real miner.",
		periodicity = 10,
		objective = {
			dig = {"default:stone"}
		}
	}
}

mff.quests.quest_status = {}

function table.contains(table, element)
	for _, value in pairs(table) do
		if value == element then
		return true
		end
	end
	return false
end

function mff.quests.start_quest(playername, qname, meta)
	mff.quests.quest_status[playername][qname] = 0
	quests.start_quest(playername, mff.QPREFIX .. qname, meta)
end

function mff.quests.restart_periodic_quest(playername, qname)
	mff.quests.start_quest(playername, qname)
end

function mff.quests.start_periodicity_timer(playername, qname)
	local tstamp = -mff.quests.quest_status[playername][qname]
	minetest.after(tstamp-os.time(), mff.quests.restart_periodic_quest, playername, qname)
end

function mff.quests.start_all_periodicity_timers(playername)
	local qstatus = mff.quests.quest_status[playername]
	for qname, _ in pairs(qstatus) do
		mff.quests.start_periodicity_timer(playername, qname)
	end
end

function mff.quests.set_quest_ended(playername, questname, metadata)
	local qstatus = mff.quests.quest_status[playername]
	local qname = questname:sub(mff.QPREFIX:len()+1)
	local qinfo = mff.quests.quests[qname]
	if qinfo.periodicity ~= nil and qinfo.periodicity >= 1 then
		qstatus[qname] = -(os.time() + qinfo.periodicity)
		mff.quests.start_periodicity_timer(playername, qname)
	else
		qstatus[qname] = nil
	end
end

-- Register the quests defined above
for qname, quest in pairs(mff.quests.quests) do
	quests.register_quest(mff.QPREFIX .. qname, {
		title = quest.title,
		description = quest.desc,
		max = quest.max,
		autoaccept = true,
		callback = mff.quests.set_quest_ended
	})
end

-- For quests where you have to dig something, the updates happen here
minetest.register_on_dignode(function(pos, oldnode, digger)
	local qstatus = mff.quests.quest_status[digger:get_player_name()]
	for qname, quest in pairs(mff.quests.quests) do
		if qstatus[qname] ~= nil and qstatus[qname] >= 0 then
			if quest.objective.dig then
				if table.contains(quest.objective.dig, oldnode.name) then
					quests.update_quest(digger:get_player_name(), mff.QPREFIX .. qname, 1)
				end
			end
		end
	end
end)

-- TODO load data 
--[[
for playername in players do
	mff.quests.start_all_periodicity_timers(playername)
end
]]

minetest.register_on_joinplayer(function (player)
	-- TODO do nothing
	mff.quests.quest_status[player:get_player_name()] = {}
	mff.quests.start_quest(player:get_player_name(), "testdiggydiggyhole")
end)

minetest.register_on_leaveplayer(function (player)
	-- TODO do nothing
	mff.quests.quest_status[player:get_player_name()] = nil
end)

minetest.register_on_shutdown(function()
	-- TODO save data
end)