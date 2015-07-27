--- Quests HUD.
-- @module hud

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

--- Show quests HUD to player.
-- The HUD can only show up to `show_max` quests
-- @param playername Player whose quests HUD must be shown
-- @param autohide Whether to automatically hide the HUD once it's empty
function quests.show_hud(playername, autohide)
	if quests.hud[playername] == nil then
		quests.hud[playername] = { autohide = autohide }
	end
	if quests.hud[playername].list ~= nil then
		return
	end
	local player = minetest.get_player_by_name(playername)
	if player == nil then
		return false
	end
	quests.hud[playername].header = player:hud_add({
		hud_elem_type = "text",
		alignment = {x=1, y=1},
		position = {x = hud_config.position.x, y = hud_config.position.y},
		offset = {x = hud_config.offset.x, y = hud_config.offset.y - 20},
		number = hud_config.number,
		text = S("Quests:")
	})

	quests.hud[playername].list = {}
	minetest.after(0, quests.update_hud, playername)
end

--- Hide quests HUD to player.
-- @param playername Player whose quests HUD must be hidden
function quests.hide_hud(playername)
	local player = minetest.get_player_by_name(playername)
	if player == nil or quests.hud[playername] == nil or quests.hud[playername].list == nil then
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


local function get_quest_hud_string(title, value, max)
	return title .. "\n               ("..quests.round(value, 2).."/"..max..")"
end

local function get_hud_list(playername)
	local deftable = {}
	local counter = 0
	for questname, plr_quest in quests.sorted_pairs(quests.active_quests[playername]) do
		local quest = quests.registered_quests[questname]
		local hide_from_hud
		if quests.info_quests[playername] and quests.info_quests[playername][questname] then
			hide_from_hud = quests.info_quests[playername][questname].hide_from_hud
		else
			hide_from_hud = false
		end
		if quest and not hide_from_hud then -- Quest might have been deleted
			local function get_table(name, value, max)
				local def = {
					text = {
						hud_elem_type = "text",
						alignment = { x=1, y= 1 },
						position = {x = hud_config.position.x, y = hud_config.position.y},
						offset = {x = hud_config.offset.x, y = hud_config.offset.y + counter * 40},
						number = hud_config.number,
						text = name
					}
				}
				if plr_quest.finished then
					if quests.failed_quests[playername] and quests.failed_quests[playername][questname] then
						def.text.number = quests.colors.failed
					else
						def.text.number = quests.colors.success
					end
				else
					def.text.number = hud_config.number
				end
				if value and max then
					def.bar = {
						hud_elem_type = "image",
						scale = { x = math.floor(20 * value / max), y = 1 },
						alignment = { x = 1, y = 1 },
						position = { x = hud_config.position.x, y = hud_config.position.y },
						offset = { x = hud_config.offset.x + 2, y = hud_config.offset.y + counter * 40 + 24 },
						text = "quests_questbar.png"
					}
					def.background = {
						hud_elem_type = "image",
						scale = { x = 1, y = 1 },
						size = { x = 2, y = 4 },
						alignment = { x = 1, y = 1 },
						position = { x = hud_config.position.x, y = hud_config.position.y },
						offset = { x = hud_config.offset.x, y = hud_config.offset.y + counter * 40 + 22 },
						text = "quests_questbar_background.png"
					}
				end
				return def
			end
			if quest.simple then
				deftable[questname] = get_table(get_quest_hud_string(quest.title, plr_quest.value, quest.max), plr_quest.value, quest.max)
				counter = counter + 1
			else
				deftable[questname] = get_table(quest.title, plr_quest.value, quest.max)
				counter = counter + 0.5
				for taskname, task in pairs(quest.tasks) do
					local plr_task = quests.active_quests[playername][questname][taskname]
					if plr_task.visible and not plr_task.disabled and not plr_task.finished then
						deftable[questname .. "#" .. taskname] = get_table("- " .. get_quest_hud_string(task.title, plr_task.value, task.max), plr_task.value, task.max)
						counter = counter + 1
						if counter >= show_max + 1 then
							break
						end
					end
				end
				counter = counter + 0.1
			end
			if counter >= show_max + 1 then
				break
			end
		end
	end
	return deftable
end

local DELETED = {}
-- only for internal use
-- updates the hud
function quests.update_hud(playername)
	if quests.hud[playername] == nil or quests.active_quests[playername] == nil then
		return
	end
	if quests.hud[playername].list == nil then
		if quests.hud[playername].autohide and next(quests.active_quests[playername]) ~= nil then
			quests.show_hud(playername)
		end
		return
	end
	local player = minetest.get_player_by_name(playername)
	if player == nil then
		return
	end

	if quests.hud[playername].autohide then
		if next(quests.active_quests[playername]) == nil then
			player:hud_change(quests.hud[playername].header, "text", S("No more Quests"))
			minetest.after(3, function(playername)
				if next(quests.active_quests[playername]) ~= nil then
					player:hud_change(quests.hud[playername].header, "text", S("Quests:"))
					quests.update_hud(playername)
				else
					quests.hide_hud(playername)
				end
			end, playername)
		end
	end

	-- Check for changes in the hud
	local function table_diff(tab1, tab2)
		local result_tab
		for k, v in pairs(tab2) do
			if not tab1[k] or tab1[k] ~= v then
				if type(tab1[k]) == "table" and type(v) == "table" then
					local diff = table_diff(tab1[k], v)
					if diff ~= nil then
						if not result_tab then
							result_tab = {}
						end
						result_tab[k] = diff
					end
				else
					if not result_tab then
						result_tab = {}
					end
					result_tab[k] = v
				end
			end
		end
		for k, _ in pairs(tab1) do
			if tab2[k] == nil then
				if not result_tab then
					result_tab = {}
				end
				result_tab[k] = DELETED
			end
		end
		return result_tab
	end
	-- Merge `from` into table `into`
	local function table_merge(from, into)
		for k, v in pairs(from) do
			if type(v) == "table" and type(into[k]) == "table" then
				table_merge(v, into[k])
			else
				into[k] = v
			end
		end
	end
	local old_hud = quests.hud[playername].list
	local new_hud = get_hud_list(playername)
	local diff = table_diff(old_hud, new_hud)
	-- Copy the HUD IDs from the old table to the new one, to avoid loosing them
	for questname, hud_elms in pairs(old_hud) do
		for elm_name, elm_def in pairs(hud_elms) do 
			if new_hud[questname] and new_hud[questname][elm_name] then
				new_hud[questname][elm_name].id = elm_def.id
			end
		end
	end
	if diff ~= nil then
		for questname, hud_elms in pairs(diff) do
			if hud_elms == DELETED then
				for elm_name, elm_def in pairs(old_hud[questname]) do
					player:hud_remove(elm_def.id)
				end
			else
				for elm_name, elm_def in pairs(hud_elms) do 
					if not old_hud[questname] or not old_hud[questname][elm_name] or not old_hud[questname][elm_name].id then
						new_hud[questname][elm_name].id = player:hud_add(elm_def)
					else
						for elm_prop_name, elm_prop in pairs(elm_def) do
							if elm_prop_name ~= "id" then
								if type(elm_prop) == "table" then
									-- For table-based properties, MT expects a full table to be specified,
									-- so we must create a merged table. Just merge the changes with the old
									-- HUD table, since it will disappear.
									table_merge(elm_prop, old_hud[questname][elm_name][elm_prop_name])
								else
									old_hud[questname][elm_name][elm_prop_name] = elm_prop
								end
								player:hud_change(new_hud[questname][elm_name].id, elm_prop_name, old_hud[questname][elm_name][elm_prop_name])
							end
						end
					end
				end
			end
		end
	end
	quests.hud[playername].list = new_hud
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
