-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	-- If you don't use insertions (@1, @2, etc) you can use this:
	S = function(s) return s end
end

-- construct the questlog
function quests.create_formspec(playername, tab, integrated)
	local queststringlist = {}
	local questlist = {}
	quests.formspec_lists[playername] = quests.formspec_lists[playername] or {
		id = 1
	}
	quests.formspec_lists[playername].list = {}
	tab = tab or quests.formspec_lists[playername].tab or "1"
	if tab == "1" then
		questlist = quests.active_quests[playername] or {}
	elseif tab == "2" then
		questlist = quests.successfull_quests[playername] or {}
	elseif tab == "3" then
		questlist = quests.failed_quests[playername] or {}
	end
	quests.formspec_lists[playername].tab = tab

	local quest_count = 0
	for questname,questspecs in quests.sorted_pairs(questlist) do
		if not questspecs.finished then
			local quest = quests.registered_quests[questname]
			if quest then -- Quest might have been deleted
				local queststring = quest.title
				if questspecs.count then
					if questspecs.count > 1 then
						queststring = queststring .. " - " .. questspecs.count
					end
					local restart_remaining = quests.quest_restarting_in(playername, questname)
					if restart_remaining ~= nil then
						queststring = queststring .. " (" .. S("restarts in %ds"):format(restart_remaining) .. ")"
					end
				elseif not questspecs.count and quest.max ~= 1 then
					if quest.simple then
						queststring = queststring .. " (" .. quests.round(questspecs.value, 2) .. "/" .. quest.max .. ")"
					else
						local active_tasks, active_completed = quests.get_active_tasks_stats(playername, questname)
						if active_tasks and active_completed then
							queststring = queststring .. " (" .. S("%d/%d tasks done"):format(active_completed, active_tasks) .. ")"
						else
							-- Kind of an error
							queststring = queststring .. " (...)"
						end
					end
				end
				table.insert(queststringlist, queststring)
				table.insert(quests.formspec_lists[playername].list, questname)
				quest_count = quest_count + 1
			end
		end
	end
	if quest_count ~= 0 and quests.formspec_lists[playername].id > quest_count then
		quests.formspec_lists[playername].id = quest_count
	end
	local formspec = ""
	if not integrated then
		formspec = formspec .. "size[7,9]"
	end
	formspec = formspec .. "tabheader[0,0;quests_header;" .. S("Open quests") .. "," .. S("Finished quests") .. "," .. S("Failed quests") .. ";" .. tab .. "]"
	if quest_count == 0 then
		formspec = formspec .. "label[0.25,0.25;" .. S("There are no quests in this category.") .. "]"
	else
		formspec = formspec .. "textlist[0.25,0.25;6.5,6;quests_questlist;"..table.concat(queststringlist, ",") .. ";" .. tostring(quests.formspec_lists[playername].id) .. ";false]"
	end
	if quests.formspec_lists[playername].tab == "1" then
		local hud_display = "true"
		if quests.formspec_lists[playername].id then
			local questname = quests.formspec_lists[playername].list[quests.formspec_lists[playername].id]
			if not quests.get_quest_hud_visibility(playername, questname) then
				hud_display = "false"
			end
		end
		formspec = formspec .."button[0.25,7.1;3,.7;quests_abort;" .. S("Abort quest") .. "]" ..
				"checkbox[.25,6.2;quests_show_quest_in_hud;" .. S("Show in HUD") .. ";" .. hud_display .. "]"
	end
	formspec = formspec .. "button[3.75,7.1;3,.7;quests_config;" .. S("Configure") .. "]"..
			"button[.25,8;3,.7;quests_info;" .. S("Info") .. "]"..
			"button_exit[3.75,8;3,.7;quests_exit;" .. S("Exit") .. "]"
	return formspec
end

-- construct the configuration
function quests.create_config(playername, integrated)
	local formspec = ""
	if (not integrated) then
		formspec = formspec .. "size[7,3]"
	end
	formspec = formspec .. "checkbox[.25,.25;quests_config_enable;" .. S("Enable HUD") .. ";"
	if(quests.hud[playername] ~= nil and quests.hud[playername].list ~= nil) then
		formspec = formspec .. "true"
	else
		formspec = formspec ..  "false"
	end
	formspec = formspec .. "]checkbox[.25,.75;quests_config_autohide;" .. S("Autohide HUD") .. ";"
	if(quests.hud[playername] ~= nil and quests.hud[playername].autohide) then
		formspec = formspec .. "true"
	else
		formspec = formspec ..  "false"
	end 
	formspec = formspec .. "]checkbox[.25,1.25;quests_config_central_message;" .. S("Central messages") .. ";"
	if(quests.hud[playername] ~= nil and quests.hud[playername].central_message_enabled) then
		formspec = formspec .. "true"
	else
		formspec = formspec ..  "false"
	end
	formspec = formspec .. "]" ..
			"button[.25,2.25;3,.7;quests_config_return;" .. S("Return") .. "]"
	return formspec
end

local function wordwrap(text, linelength)
	local lines = text:split("\n")
	local ret = ""
	for i = 1,#lines do
		local line = lines[i]
		while (#line > linelength) do
			local split = false
			local j = linelength
			while (not split) do
				if (string.sub(line, j, j) == " ") then
					split = true
					ret = ret .. string.sub(line, 1, j) .. "\n"
					line = string.sub(line, j + 1)
				end
				if (j <= 1) then
					break
				end
				j = j - 1
			end
			if (not split) then
				ret = ret .. string.sub(line, 1, linelength) .. "\n"
				line = string.sub(line, linelength);
			end
		end
		ret = ret .. line .. "\n"
	end
	return ret
end

-- construct the info formspec
function quests.create_info(playername, questname, taskid, integrated)
	local formspec = ""
	if not integrated then
		formspec = formspec .. "size[7.5,9]"
	end

	if questname then
		local restart_remaining = quests.quest_restarting_in(playername, questname)
		local quest = quests.registered_quests[questname]
		formspec = formspec .. "image[0,0;0.8,0.8;" .. quest.icon .. "]"
		if restart_remaining ~= nil then
			formspec = formspec .. "label[0.8,0;" .. quest.title .. "]" ..
					"label[0.8,0.3;" .. S("%ds seconds remaining"):format(restart_remaining) .. "]"
		else
			formspec = formspec .. "label[0.8,0.1;" .. quest.title .. "]"
		end

		if quest.simple then
			formspec = formspec .. "textarea[.4,1;7.2,7;_;;" .. minetest.formspec_escape(quest.description) .. "]"
		else
			quests.formspec_lists[playername].taskid = nil
			local taskidlist = {}
			local taskstringlist = {}
			for taskname, task in pairs(quest.tasks) do
				local plr_task = nil
				if quests.active_quests[playername] and quests.active_quests[playername][questname] then
					 plr_task = quests.active_quests[playername][questname][taskname]
				end
				if not plr_task or (plr_task and plr_task.visible) then
					-- not plr_task => quest is finished, display all tasks
					table.insert(taskidlist, taskname)
					local color = ""
					local suffix = ""
					if plr_task then
						if plr_task.finished then
							color = "#00BB00"
						end
						if plr_task.disabled then
							color = "#AAAAAA"
						end
						suffix = " - " .. quests.round(plr_task.value, 2) .. "/" .. task.max
					end
					table.insert(taskstringlist, color .. task.title .. suffix)
				end
			end
			local task = false
			if taskid ~= nil then
				task = quest.tasks[taskidlist[taskid]]
			end
			task = task or {title=S("No task selected"), description=""}
			formspec = formspec .. "textarea[.4,1;7.2,2;_;;" .. minetest.formspec_escape(quest.description) .. "]" ..
					"textlist[0.1,2.9;7,2;quest_info_tasklist;" .. table.concat(taskstringlist, ",") .. "]" ..
					"label[0.8,5.2;" .. task.title .. "]" ..
					"textarea[.4,6;7.2,2;__;;" .. minetest.formspec_escape(task.description) .. "]"
			if task.icon then
				formspec = formspec .. "image[0,5.1;0.8,0.8;" .. task.icon .. "]"
			end
		end

		if quests.formspec_lists[playername].tab == "1" then
			formspec = formspec .. "button[3.6,8;3,.7;quests_info_abort;" .. S("Abort quest") .. "]"
		end
	else
		formspec = formspec .. "label[0.8,0.1;" .. S("No quest specified.") .. "]"
	end
	formspec = formspec .. "button[.4,8;3,.7;quests_info_return;" .. S("Return") .. "]"
	return formspec
end

-- show the player playername his/her questlog
function quests.show_formspec(playername) 
	minetest.show_formspec(playername, "quests:questlog", quests.create_formspec(playername))
end

-- chatcommand to see a full list of quests:
minetest.register_chatcommand("quests", {
	params = "",
	description = S("Show all open quests"),
	func = function(name, param)
		minetest.show_formspec(name, "quests:questlog", quests.create_formspec(name))
		return true
	end
})

-- Handle the return fields of the questlog
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if player == nil then
		return
	end
	local playername = player:get_player_name()
	if playername == "" then
		return
	end

--	questlog
	if fields.quests_header then
		if formname == "quests:questlog" then
			minetest.show_formspec(playername, "quests:questlog", quests.create_formspec(playername, fields.quests_header))
		else
			if fields.quests_header == "1" then
				unified_inventory.set_inventory_formspec(player, "quests")
			elseif fields.quests_header == "2" then
				unified_inventory.set_inventory_formspec(player, "quests_successfull")
				return
			else
				unified_inventory.set_inventory_formspec(player, "quests_failed")
				return
			end
		end
		return
	end
	if fields.quests_questlist then
		local event = minetest.explode_textlist_event(fields.quests_questlist)
		if event.type == "CHG" then
			quests.formspec_lists[playername].id = event.index
			if formname == "quests:questlog" then
				minetest.show_formspec(playername, "quests:questlog", quests.create_formspec(playername))
			else 
				unified_inventory.set_inventory_formspec(player, "quests")
			end
		end
	end
	if fields.quests_abort then
		if quests.formspec_lists[playername].id == nil then
			return
		end
		quests.abort_quest(playername, quests.formspec_lists[playername].list[quests.formspec_lists[playername].id]) 
		if formname == "quests:questlog" then
			minetest.show_formspec(playername, "quests:questlog", quests.create_formspec(playername))
		else
			unified_inventory.set_inventory_formspec(player, "quests")
		end
	end
	if fields.quests_config then
		if formname == "quests:questlog" then
			minetest.show_formspec(playername, "quests:config", quests.create_config(playername))
		else
			unified_inventory.set_inventory_formspec(player, "quests_config")
		end
	end
	if fields.quests_info then
		if formname == "quests:questlog" then
			minetest.show_formspec(playername, "quests:info", quests.create_info(playername, quests.formspec_lists[playername].list[quests.formspec_lists[playername].id], nil, false))
		else
			unified_inventory.set_inventory_formspec(player, "quests_info")
		end
	end
	if fields.quests_show_quest_in_hud ~= nil then
		local questname = quests.formspec_lists[playername].list[quests.formspec_lists[playername].id]
		if questname then
			quests.set_quest_hud_visibility(playername, questname, fields.quests_show_quest_in_hud == "true")
			if formname == "quests:questlog" then
				minetest.show_formspec(playername, "quests:questlog", quests.create_formspec(playername))
			else 
				unified_inventory.set_inventory_formspec(player, "quests")
			end
		end
	end

-- config
	if (fields["quests_config_enable"]) then
		quests.hud[playername].autohide = false
		if (fields["quests_config_enable"] == "true") then	
			quests.show_hud(playername)
		else
			quests.hide_hud(playername)
		end
		if (formname == "quests:config") then
			minetest.show_formspec(playername, "quests:config", quests.create_config(playername))
		else
			unified_inventory.set_inventory_formspec(player, "quests_config")
		end
	end
	if (fields["quests_config_autohide"]) then
		if (fields["quests_config_autohide"] == "true") then
			quests.hud[playername].autohide = true
			quests.update_hud(playername)
		else
			quests.hud[playername].autohide = false
		end
		if (formname == "quests:config") then
			minetest.show_formspec(playername, "quests:config", quests.create_config(playername))
		else
			unified_inventory.set_inventory_formspec(player, "quests_config")
		end
	end
	if (fields["quests_config_central_message"]) then
		if (fields["quests_config_central_message"] == "true") then
			quests.hud[playername].central_message_enabled = true
		else
			quests.hud[playername].central_message_enabled = false
		end
		if (formname == "quests:config") then
			minetest.show_formspec(playername, "quests:config", quests.create_config(playername))
		else
			unified_inventory.set_inventory_formspec(player, "quests_config")
		end
	end

	if (fields["quests_config_return"]) then
		if (formname == "quests:config") then
			minetest.show_formspec(playername, "quests:questlog", quests.create_formspec(playername))
		else 
			unified_inventory.set_inventory_formspec(player, "quests")
		end
	end

-- info
	if fields.quest_info_tasklist then
		local event = minetest.explode_textlist_event(fields.quest_info_tasklist)
		if event.type == "CHG" then
			if formname == "quests:info" then
				minetest.show_formspec(playername, "quests:info", quests.create_info(playername, quests.formspec_lists[playername].list[quests.formspec_lists[playername].id], event.index, false))
			else
				quests.formspec_lists[playername].taskid = event.index
				unified_inventory.set_inventory_formspec(player, "quests_info")
			end
		end
	end
	if fields.quests_info_abort then
		if quests.formspec_lists[playername].id == nil then
			return
		end
		quests.abort_quest(playername, quests.formspec_lists[playername].list[quests.formspec_lists[playername].id]) 
		if formname == "quests:info" then
			minetest.show_formspec(playername, "quests:questlog", quests.create_formspec(playername))
		else 
			unified_inventory.set_inventory_formspec(player, "quests")
		end
	end
	if fields.quests_info_return then
		if formname == "quests:info" then
			minetest.show_formspec(playername, "quests:questlog", quests.create_formspec(playername))
		else 
			unified_inventory.set_inventory_formspec(player, "quests")
		end
	end
end)
