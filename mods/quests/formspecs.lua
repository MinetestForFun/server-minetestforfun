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
	quests.formspec_lists[playername] = quests.formspec_lists[playername] or {}
	quests.formspec_lists[playername].id = 1
	quests.formspec_lists[playername].list = {}
	tab = tab or quests.formspec_lists[playername].tab or "1"
	if (tab == "1") then
		questlist = quests.active_quests[playername] or {}
	elseif (tab == "2") then
		questlist = quests.successfull_quests[playername] or {}
	elseif (tab == "3") then
		questlist = quests.failed_quests[playername] or {}
	end
	quests.formspec_lists[playername].tab = tab
		
	local no_quests = true
	for questname,questspecs in pairs(questlist) do
		if (questspecs.finished == nil) then
			local queststring = quests.registered_quests[questname]["title"]
			if (questspecs["count"] and questspecs["count"] > 1) then
				queststring = queststring .. " - " .. questspecs["count"]
			elseif(not questspecs["count"] and quests.registered_quests[questname]["max"] ~= 1) then
				queststring = queststring .. " - (" .. quests.round(questspecs["value"], 2) .. "/" .. quests.registered_quests[questname]["max"] .. ")"
			end
			table.insert(queststringlist, queststring)
			table.insert(quests.formspec_lists[playername].list, questname)
			no_quests = false
		end
	end
	local formspec = ""
	if (not integrated) then
		formspec = formspec .. "size[7,9]"
	end
	formspec = formspec .. "tabheader[0,0;quests_header;" .. S("Open quests") .. "," .. S("Finished quests") .. "," .. S("Failed quests") .. ";" .. tab .. "]"
	if (no_quests) then
		formspec = formspec .. "label[0.25,0.25;" .. S("There are no quests in this category.") .. "]"
	else
		formspec = formspec .. "textlist[0.25,0.25;6.5,6.5;quests_questlist;"..table.concat(queststringlist, ",") .. ";1;false]"
	end
	if (quests.formspec_lists[playername].tab == "1") then
		formspec = formspec .."button[0.25,7;3,.7;quests_abort;" .. S("Abort quest") .. "]"
	end
	formspec = formspec .. "button[3.75,7;3,.7;quests_config;" .. S("Configure") .. "]"..
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
function quests.create_info(playername, questname, integrated)
	local formspec = ""
	if (not integrated) then
		formspec = formspec .. "size[9,6.5]"
	end
	formspec = formspec .. "label[0.5,0.5;" 

	if (questname) then
		formspec = formspec .. quests.registered_quests[questname].title .. "]" ..
				"box[.4,1.5;8.2,4.5;#999999]" ..
				"label[.5,1.5;" ..
				wordwrap(quests.registered_quests[questname].description, 60) .. "]"

		if (quests.formspec_lists[playername].tab == "1") then
			formspec = formspec .. "button[.5,6;3,.7;quests_info_abort;" .. S("Abort quest") .. "]"
		end
	else
		formspec = formspec .. S("No quest specified.") .. "]"
	end
	formspec = formspec .. "button[3.25,6;3,.7;quests_info_return;" .. S("Return") .. "]"
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
	if (player == nil) then
		return
	end
	local playername = player:get_player_name();
	if (playername == "") then
		return
	end

--	questlog
	if (fields["quests_header"]) then
		if (formname == "quests:questlog") then
			minetest.show_formspec(playername, "quests:questlog", quests.create_formspec(playername, fields["quests_header"]))
		else
			if (fields["quests_header"] == "1") then
				unified_inventory.set_inventory_formspec(player, "quests")
			elseif (fields["quests_header"] == "2") then
				unified_inventory.set_inventory_formspec(player, "quests_successfull")
				return
			else
				unified_inventory.set_inventory_formspec(player, "quests_failed")
				return
			end
		end
		return
	end
	if (fields["quests_questlist"]) then
		local event = minetest.explode_textlist_event(fields["quests_questlist"])
		if (event.type == "CHG") then
			quests.formspec_lists[playername].id = event.index
		end
	end
	if (fields["quests_abort"]) then
		if (quests.formspec_lists[playername].id == nil) then
			return
		end
		quests.abort_quest(playername, quests.formspec_lists[playername]["list"][quests.formspec_lists[playername].id]) 
		if (formname == "quests:questlog") then
			minetest.show_formspec(playername, "quests:questlog", quests.create_formspec(playername))
		else
			unified_inventory.set_inventory_formspec(player, "quests")
		end
	end
	if (fields["quests_config"]) then
		if (formname == "quests:questlog") then
			minetest.show_formspec(playername, "quests:config", quests.create_config(playername))
		else
			unified_inventory.set_inventory_formspec(player, "quests_config")
		end
	end
	if (fields["quests_info"]) then
		if (formname == "quests:questlog") then
			minetest.show_formspec(playername, "quests:info", quests.create_info(playername, quests.formspec_lists[playername].list[quests.formspec_lists[playername].id]))
		else
			unified_inventory.set_inventory_formspec(player, "quests_info")
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
	if (fields["quests_info_abort"]) then
		if (quests.formspec_lists[playername].id == nil) then
			return
		end
		quests.abort_quest(playername, quests.formspec_lists[playername]["list"][quests.formspec_lists[playername].id]) 
		if (formname == "quests:info") then
			minetest.show_formspec(playername, "quests:questlog", quests.create_formspec(playername))
		else 
			unified_inventory.set_inventory_formspec(player, "quests")
		end
	end
	if (fields["quests_info_return"]) then
		if (formname == "quests:info") then
			minetest.show_formspec(playername, "quests:questlog", quests.create_formspec(playername))
		else 
			unified_inventory.set_inventory_formspec(player, "quests")
		end
	end
end)
