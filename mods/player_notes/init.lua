-- Created by Krock
-- License: WTFPL

player_notes = {}
player_notes.player = {}
player_notes.mod_path = minetest.get_modpath("player_notes")
player_notes.data_file = minetest.get_worldpath().."/player_notes.data"
player_notes.mgr = {}

-- to generate unique 4-digit long numbers as key
player_notes.enable_timestamp = "%x %X" -- %x = date | %X = time -> "%x %X"
player_notes.key_min = 100
player_notes.key_max = 999

dofile(player_notes.mod_path.."/data_mgr.lua")
minetest.register_privilege("player_notes", "Can view and modify player's notes.")

minetest.register_chatcommand("notes", {
	description = "Lists all notes / Lists notes of <name>",
	privs = {player_notes=true},
	func = function(name, param)
		player_notes.mgr[name] = { indx={}, data="", note={}, key="" }
		minetest.show_formspec(name, "player_notes:conf", player_notes.get_formspec(0, name))
	end
})

minetest.register_on_player_receive_fields(function(player,formname,fields)
	if formname ~= "player_notes:conf" then
		return
	end
	local player_name = player:get_player_name()
	if fields.quit then -- exit
		if player_notes.mgr[player_name] then
			player_notes.mgr[player_name] = nil
		end
		return
	end
	if not player_notes.mgr[player_name] then
		return
	end
	if not minetest.check_player_privs(player_name, {player_notes=true}) then
		return
	end
	if fields.close then -- exit to main
		minetest.show_formspec(player_name, "player_notes:conf", player_notes.get_formspec(0, player_name))
		return
	end
	if fields.m_all then -- list-click-event
		local selected_player = ""
		local event = minetest.explode_textlist_event(fields.m_all)
		if event.type == "CHG" then
			selected_player = player_notes.mgr[player_name].indx[event.index]
		end
		player_notes.mgr[player_name].data = selected_player
		minetest.show_formspec(player_name, "player_notes:conf", player_notes.get_formspec(0, player_name))
		return
	end
	if fields.p_all then -- list-click-event
		local selected_note = ""
		local event = minetest.explode_textlist_event(fields.p_all)
		if event.type == "CHG" then
			selected_note = tostring(player_notes.mgr[player_name].note[event.index])
		end
		player_notes.mgr[player_name].key = selected_note
		minetest.show_formspec(player_name, "player_notes:conf", player_notes.get_formspec(2, player_name))
		return
	end
	if fields.m_add and fields.p_name then -- show adding formspec
		if not minetest.auth_table[fields.p_name] then
			minetest.chat_send_player(player_name, "Unknown player: "..fields.p_name)
			return
		end
		player_notes.mgr[player_name].data = fields.p_name
		minetest.show_formspec(player_name, "player_notes:conf", player_notes.get_formspec(1, player_name))
		return
	end
	if fields.m_rm then -- show removing formspec
		if not player_notes.player[player_notes.mgr[player_name].data] then
			minetest.chat_send_player(player_name, "Please select a player name.")
			return
		end
		minetest.show_formspec(player_name, "player_notes:conf", player_notes.get_formspec(2, player_name))
		return
	end
	if fields.m_so then -- show player notes only
		if not player_notes.player[player_notes.mgr[player_name].data] then
			minetest.chat_send_player(player_name, "Please select a player name.")
			return
		end
		minetest.show_formspec(player_name, "player_notes:conf", player_notes.get_formspec(3, player_name))
		return
	end
	
	if fields.p_add and fields.p_name and fields.p_note then -- add note
		local back_err = player_notes.add_note(player_name, fields.p_name, fields.p_note)
		if not back_err then
			minetest.chat_send_player(player_name, "Added note!")
			player_notes.save_data()
		else
			minetest.chat_send_player(player_name, back_err)
		end
		return
	end
	if fields.p_rm and fields.p_key then -- ReMove note
		local back_err = player_notes.rm_note(player_notes.mgr[player_name].data, fields.p_key)
		if not back_err then
			minetest.chat_send_player(player_name, "Removed note!")
			player_notes.save_data()
		else
			minetest.chat_send_player(player_name, back_err)
		end
		minetest.show_formspec(player_name, "player_notes:conf", player_notes.get_formspec(2, player_name))
	end
end)

function player_notes.get_formspec(mode, player_name)
	local formspec = ""
	if mode == 0 then
		--main formspec
		formspec = ("size[5,8]"..
			"label[1,0;Player note manager]"..
			"field[0.3,7.2;5,0.5;p_name;;"..player_notes.mgr[player_name].data.."]"..
			"button_exit[1,7.5;3,1;exit;Close]"..
			"textlist[0,0.5;4,6;m_all;")
		player_notes.mgr[player_name].indx = {}
		local i = 1
		for player, notes in pairs(player_notes.player) do
			local num = 0
			for key, note in pairs(notes) do
				num = num + 1
			end
			formspec = formspec..player.." ("..tostring(num)..")"..","
			player_notes.mgr[player_name].indx[i] = player
			i = i + 1
		end
		player_notes.mgr[player_name].indx[i] = ""
		formspec = (formspec..";;false]"..
			"button[4.2,2;1,1;m_add;+]"..
			"button[4.2,3;1,1;m_so;?]"..
			"button[4.2,4;1,1;m_rm;-]")
	elseif mode == 1 then
		--player add note
		formspec = ("size[7,4]"..
			"label[1,0;Add a player note]"..
			"field[0.5,1.5;4,0.5;p_name;Player name:;"..player_notes.mgr[player_name].data.."]"..
			"field[0.5,3;6,0.5;p_note;Note text:;]"..
			"button[1,3.5;2,1;p_add;Add]"..
			"button[3,3.5;2,1;close;Close]")
	elseif mode == 2 then
		--player remove note
		formspec = ("size[10,6]"..
			"label[1,0;Remove a player note]"..
			"label[0,0.6;Key:]"..
			"field[1,1;3,0.5;p_key;;"..player_notes.mgr[player_name].key.."]"..
			"button[3.6,0.5;2,1;p_rm;Remove]"..
			"button[5.6,0.5;2,1;close;Close]"..
			"textlist[0,1.5;9.8,4.8;p_all;")
		player_notes.mgr[player_name].note = {}
		local i = 1
		if player_notes.player[player_notes.mgr[player_name].data] then
			for key, note in pairs(player_notes.player[player_notes.mgr[player_name].data]) do
				formspec = formspec..key.." - "..minetest.formspec_escape(note)..","
				player_notes.mgr[player_name].note[i] = key
				i = i + 1
			end
		end
		player_notes.mgr[player_name].note[i] = ""
		formspec = formspec..";;false]"
	elseif mode == 3 then
		formspec = ("size[10,5]"..
			"label[1,0;Notes of: "..player_notes.mgr[player_name].data.."]"..
			"button[3.5,4.5;3,1;close;Close]"..
			"textlist[0,0;9.8,4.5;p_see;")
		player_notes.mgr[player_name].note = {}
		if player_notes.player[player_notes.mgr[player_name].data] then
			for key, note in pairs(player_notes.player[player_notes.mgr[player_name].data]) do
				formspec = formspec..minetest.formspec_escape(note)..","
			end
		end
		formspec = formspec..";;false]"
	end
	return formspec
end
