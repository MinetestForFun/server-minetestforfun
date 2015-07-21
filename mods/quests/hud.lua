-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	-- If you don't use insertions (@1, @2, etc) you can use this:
	S = function(s) return s end
end

local show_max = 10 -- the maximum visible quests.

local hud_config = { position = {x = 1, y = 0.2},
			offset = { x = -200, y = 0},
			number = quests.colors.new }

-- call this function to enable the HUD for the player that shows his quests
-- the HUD can only show up to show_max quests
function quests.show_hud(playername, autohide)
	if (quests.hud[playername] == nil) then
		quests.hud[playername] = { autohide = autohide}
	end
	if (quests.hud[playername].list ~= nil) then
		return
	end
	local hud = {
		hud_elem_type = "text",
		alignment = {x=1, y=1},
		position = {x = hud_config.position.x, y = hud_config.position.y},
		offset = {x = hud_config.offset.x, y = hud_config.offset.y},
		number = hud_config.number,
		text = S("Quests:") }



	local player = minetest.get_player_by_name(playername)
	if (player == nil) then
		return false
	end
	quests.hud[playername].list = {}
	table.insert(quests.hud[playername].list, { value=0, id=player:hud_add(hud) })
	minetest.after(0, quests.update_hud, playername)
end

-- call this method to hide the hud
function quests.hide_hud(playername)
	local player = minetest.get_player_by_name(playername)
	if (player == nil or quests.hud[playername] == nil or quests.hud[playername].list == nil) then
		return
	end
	for _,quest in pairs(quests.hud[playername].list) do
		player:hud_remove(quest.id)
		if (quest.id_background ~= nil) then
			player:hud_remove(quest.id_background)
		end
		if (quest.id_bar ~= nil) then
			player:hud_remove(quest.id_bar)
		end
	end
	quests.hud[playername].list = nil
end


local function get_quest_hud_string(questname, quest)
	local quest_string = quests.registered_quests[questname].title
	if (quests.registered_quests[questname].max ~= 1) then
		quest_string = quest_string .. "\n               ("..quests.round(quest.value, 2).."/"..quests.registered_quests[questname].max..")"
	end
	return quest_string
end

-- only for internal use
-- updates the hud
function quests.update_hud(playername)
	if (quests.hud[playername] == nil or quests.active_quests[playername] == nil) then
		return
	end
	if (quests.hud[playername].list == nil) then
		if (quests.hud[playername].autohide and next(quests.active_quests[playername]) ~= nil) then
			quests.show_hud(playername)
		end
		return
	end
	local player = minetest.get_player_by_name(playername)
	if (player == nil) then
		return
	end

	-- Check for changes in the hud
	local i = 2 -- the first element is the title
	local change = false
	local visible = {}
	local remove = {}
	for j,hud_element in ipairs(quests.hud[playername].list) do
		if (hud_element.name ~= nil) then
			if (quests.active_quests[playername][hud_element.name] ~= nil) then
				if (hud_element.value ~= quests.active_quests[playername][hud_element.name].value) then
					hud_element.value = quests.active_quests[playername][hud_element.name].value
					player:hud_change(hud_element.id, "text", get_quest_hud_string(hud_element.name, quests.active_quests[playername][hud_element.name]))
					if (hud_element.id_bar ~= nil) then
						player:hud_change(hud_element.id_bar, "scale",
							{ x = math.floor(20 * hud_element.value / quests.registered_quests[hud_element.name].max),
							  y = 1})
					end
				end
				if (i ~= j) then
					player:hud_change(hud_element.id, "offset", { x= hud_config.offset.x, y=hud_config.offset.y + (i-1) *40})
					if (hud_element.id_background ~= nil) then
						player:hud_change(hud_element.id_background, "offset", { x= hud_config.offset.x, y=hud_config.offset.y + (i-1) *40 + 22})
					end
					if (hud_element.id_bar ~= nil) then
						player:hud_change(hud_element.id_bar, "offset", { x= hud_config.offset.x + 2, y=hud_config.offset.y + (i-1) *40 + 24})
					end

				end
				visible[hud_element.name] = true
				i = i + 1
			else
				player:hud_remove(hud_element.id)
				if (hud_element.id_background ~= nil) then
					player:hud_remove(hud_element.id_background)
				end
				if (hud_element.id_bar ~= nil) then
					player:hud_remove(hud_element.id_bar)
				end
				table.insert(remove, j)
			end
		end
	end
	--remove ended quests
	if (remove[1] ~= nil) then
		for _,j in ipairs(remove) do
			table.remove(quests.hud[playername].list, j)
			i = i - 1
		end
	end

	if (i >= show_max + 1) then
		return
	end
	-- add new quests
	local counter = i - 1
	for questname,questspecs in pairs(quests.active_quests[playername]) do
		if (not visible[questname]) then
			local id = player:hud_add({	hud_elem_type = "text",
							alignment = { x=1, y= 1 },
							position = {x = hud_config.position.x, y = hud_config.position.y},
							offset = {x = hud_config.offset.x, y = hud_config.offset.y + counter * 40},
							number = hud_config.number,
							text = get_quest_hud_string(questname, questspecs) })
			local id_background
			local id_bar
			if (quests.registered_quests[questname].max ~= 1) then
				id_background = player:hud_add({ hud_elem_type = "image",
								 scale = { x = 1, y = 1 },
								 size = { x = 2, y = 4 },
								 alignment = { x = 1, y = 1 },
								 position = { x = hud_config.position.x, y = hud_config.position.y },
								 offset = { x = hud_config.offset.x, y = hud_config.offset.y + counter * 40 + 22 },
								 text = "quests_questbar_background.png" })
				id_bar = player:hud_add({hud_elem_type = "image",
							 scale = { x = math.floor(20 * questspecs.value / quests.registered_quests[questname].max),
								y = 1 },
							 alignment = { x = 1, y = 1 },
							 position = { x = hud_config.position.x, y = hud_config.position.y },
							 offset = { x = hud_config.offset.x + 2, y = hud_config.offset.y + counter * 40 + 24 },
							 text = "quests_questbar.png" })
			end

			table.insert(quests.hud[playername].list, {  name          = questname,
								id            = id,
								id_background = id_background,
								id_bar        = id_bar,
								value         = questspecs.value })
			counter = counter + 1
			if (counter >= show_max + 1) then
				break
			end
		end
	end

	if (quests.hud[playername].autohide) then
		if (next(quests.active_quests[playername]) == nil) then
			player:hud_change(quests.hud[playername].list[1].id, "text", S("No more Quests"))
			minetest.after(3, function(playername)
				if (next(quests.active_quests[playername]) ~= nil) then
					player:hud_change(quests.hud[playername].list[1].id, "text", S("Quests:"))
				else
					quests.hide_hud(playername)
				end
			end, playername)
		end
	end
end



-- show the HUDs
--for playername,id in pairs(quests.hud) do
--	if (id ~= nil) then
--		quests.hud[playername] = nil
--		minetest.after(10, function(playername)
--			quests.show_hud(playername)
--			quests.update_hud(playername)
--		end, playername)
--	end
--end

minetest.register_on_joinplayer(function(player)
	local playername = player:get_player_name()
	if (quests.hud[playername] ~= nil) then
		if (not(quests.hud[playername].first)) then
			return
		end
		local list = quests.hud[playername].list
		local autohide = quests.hud[playername].autohide
		local central_message_enabled = quests.hud[playername].central_message_enabled
		quests.hud[playername] = {
			autohide = autohide,
			central_message_enabled = central_message_enabled
		}
		if (list ~= nil) then
			minetest.after(1, function(playername)
				quests.show_hud(playername)
			end, playername)
		end
	else -- new player
		quests.hud[playername] = {
			autohide = true,
			central_message_enabled = true
		}
		quests.active_quests[playername] = {}
	end
end)
