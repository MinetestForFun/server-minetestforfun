-- reading previous quests
local file = io.open(minetest.get_worldpath().."/quests", "r")
if file then
	minetest.log("action", "Reading quests...")
	quests = minetest.deserialize(file:read("*all"))
	file:close()
end
quests = quests or {}
quests.registered_quests = {}
quests.active_quests = quests.active_quests or {}
quests.successfull_quests = quests.successfull_quests or {}
quests.failed_quests = quests.failed_quests or {}
quests.hud = quests.hud or {}
for idx,_ in pairs(quests.hud) do
	quests.hud[idx].first = true
end


quests.formspec_lists = {}
function quests.round(num, n) 
	local mult = 10^(n or 0)
	return math.floor(num * mult + .5) / mult
end

quests.colors = {
	new     = "0xAAAA00",
	success = "0x00AD00",
	failed  = "0xAD0000"
}


local MP = minetest.get_modpath("quests")

dofile(MP .. "/central_message.lua")
dofile(MP .. "/core.lua")
dofile(MP .. "/hud.lua")
dofile(MP .. "/formspecs.lua")

-- support for unified_inventory
if (minetest.get_modpath("unified_inventory") ~= nil) then
	dofile(minetest.get_modpath("quests") .. "/unified_inventory.lua")
elseif (minetest.get_modpath("inventory_plus") ~= nil) then
	dofile(minetest.get_modpath("quests") .. "/inventory_plus.lua")
end


-- write the quests to file
minetest.register_on_shutdown(function() 
	minetest.log("action", "Writing quests to file")
	for playername, quest in pairs(quests.active_quests) do
		for questname, questspecs in pairs(quest) do
			if (questspecs.finished) then
				quests.active_quests[playername][questname] = nil -- make sure no finished quests are saved as unfinished
			end
		end
	end
	local file = io.open(minetest.get_worldpath().."/quests", "w")
	if (file) then
		file:write(minetest.serialize({ --registered_quests  = quests.registered_quests,
						active_quests      = quests.active_quests,
						successfull_quests = quests.successfull_quests,
						failed_quests	   = quests.failed_quests,
						hud 		   = quests.hud}))
		file:close()
	end
end)
