
--function save settings
function fishing_setting.func.save()
	local input, err = io.open(fishing_setting.file_settings, "w")
	if input then
		input:write(minetest.serialize(fishing_setting.settings))
		input:close()
	else
		minetest.log("error", "open(" .. fishing_setting.file_settings .. ", 'w') failed: " .. err)
	end
end


function fishing_setting.func.set_settings(new_settings, settings)
	if settings["message"] ~= nil then
		new_settings["message"] = settings["message"]
	end

	if settings["worm_is_mob"] ~= nil then
		new_settings["worm_is_mob"] = settings["worm_is_mob"]
	end

	if settings["worm_chance"] ~= nil then
		new_settings["worm_chance"] = settings["worm_chance"]
	end

	if settings["new_worm_source"] ~= nil then
		new_settings["new_worm_source"] = settings["new_worm_source"]
	end
	if settings["wear_out"] ~= nil then
		new_settings["wear_out"] = settings["wear_out"]
	end

	if settings["bobber_view_range"] ~= nil then
		new_settings["bobber_view_range"] = settings["bobber_view_range"]
	end

	if settings["simple_deco_fishing_pole"] ~= nil then
		new_settings["simple_deco_fishing_pole"] = settings["simple_deco_fishing_pole"]
	end

	if settings["fish_chance"] ~= nil then
		new_settings["fish_chance"] = settings["fish_chance"]
	end

	if settings["treasure_chance"] ~= nil then
		new_settings["treasure_chance"] = settings["treasure_chance"]
	end

	if settings["shark_chance"] ~= nil then
		new_settings["shark_chance"] = settings["shark_chance"]
	end

	if settings["treasure_enable"] ~= nil then
		new_settings["treasure_enable"] = settings["treasure_enable"]
	end

	if settings["escape_chance"] ~= nil then
		new_settings["escape_chance"] = settings["escape_chance"]
	end
end


--function load settings from file
function fishing_setting.func.load()
	local file = io.open(fishing_setting.file_settings, "r")
	local settings = {}
	if file then
		settings = minetest.deserialize(file:read("*all"))
		file:close()
		if settings and type(settings) == "table" then
			fishing_setting.func.set_settings(fishing_setting.settings, settings)
		end
	end
end

--function return wear tool value (old or new)
function fishing_setting.func.wear_value(wear)
	local used = 0
	if wear == "random" then
		used = (2000*(math.random(20, 29)))
	elseif wear == "randomtools" then
		used = (65535/(30-(math.random(15, 29))))
	end
	return used
end


-- function return table where mods actived
function fishing_setting.func.ignore_mod(list)
	local listOk = {}
	for i,v in ipairs(list) do
		if minetest.get_modpath(v[1]) ~= nil then
			table.insert(listOk, v)
		end
	end
	return listOk
end

--function random hungry by bait type
function fishing_setting.func.hungry_random()
	for i,a in pairs(fishing_setting.baits) do
		fishing_setting.baits[i]["hungry"] = math.random(15, 80)
	end
	--change hungry after random time, min 0h30, max 6h00
	minetest.after(math.random(1, 12)*1800,function() fishing_setting.func.hungry_random() end)
end


-- Show notification when a player catches treasure
function fishing_setting.func.notify(f_name, treasure)
	local title = fishing_setting.func.S("Lucky %s, he caught the treasure, %s!"):format(f_name, treasure[4])
	for _, player in ipairs(minetest.get_connected_players()) do
		local player_name = player:get_player_name()
		if player_name == f_name then
			minetest.chat_send_player(player_name, fishing_setting.func.S("You caught the treasure, %s!"):format(treasure[4]))
		else
			minetest.chat_send_player(player_name, title)
		end
	end
end


-- Menu: fishing configuration
fishing_setting.func.on_show_settings = function(player_name)
	local S = fishing_setting.func.S
	if not fishing_setting.tmp_setting then
		fishing_setting.tmp_setting = {}
		fishing_setting.func.set_settings(fishing_setting.tmp_setting, fishing_setting.settings)
	end
	local formspec = "size[10.8,9]label[4,0;"..S("Fishing configuration").."]"..
		-- Fish chance
		"label[1.6,0.5;"..S("Fish chance").."]"..
		"button[0,1;1,1;cfish;-1]"..
		"button[1,1;1,1;cfish;-10]"..
		"label[2.1,1.2;"..tostring(fishing_setting.tmp_setting["fish_chance"]).."]"..
		"button[2.7,1;1,1;cfish;+10]"..
		"button[3.7,1;1,1;cfish;+1]"..
		-- Shark chance
		"label[1.5,2;"..S("Shark chance").."]"..
		"button[0,2.5;1,1;cshark;-1]"..
		"button[1,2.5;1,1;cshark;-10]"..
		"label[2.1,2.7;"..tostring(fishing_setting.tmp_setting["shark_chance"]).."]"..
		"button[2.7,2.5;1,1;cshark;+10]"..
		"button[3.7,2.5;1,1;cshark;+1]"..
		-- Treasure chance
		"label[1.5,3.5;"..S("Treasure chance").."]"..
		"button[0,4.;1,1;ctreasure;-1]"..
		"button[1,4;1,1;ctreasure;-10]"..
		"label[2.1,4.2;"..tostring(fishing_setting.tmp_setting["treasure_chance"]).."]"..
		"button[2.7,4;1,1;ctreasure;+10]"..
		"button[3.7,4;1,1;ctreasure;+1]"..
		-- Worm chance
		"label[7.5,0.5;"..S("Worm chance").."]"..
		"button[6,1;1,1;cworm;-1]"..
		"button[7,1;1,1;cworm;-10]"..
		"label[8.1,1.2;"..tostring(fishing_setting.tmp_setting["worm_chance"]).."]"..
		"button[8.7,1;1,1;cworm;+10]"..
		"button[9.7,1;1,1;cworm;+1]"..
		-- Escape chance
		"label[7.4,2;"..S("Escape chance").."]"..
		"button[6,2.5;1,1;cescape;-1]"..
		"button[7,2.5;1,1;cescape;-10]"..
		"label[8.1,2.7;"..tostring(fishing_setting.tmp_setting["escape_chance"]).."]"..
		"button[8.7,2.5;1,1;cescape;+10]"..
		"button[9.7,2.5;1,1;cescape;+1]"..
		-- Bobber view range
		"label[7.2,3.5;"..S("Bobber view range").."]"..
		"button[7,4;1,1;bvrange;-1]"..
		"label[8.1,4.2;"..tostring(fishing_setting.tmp_setting["bobber_view_range"]).."]"..
		"button[8.7,4;1,1;bvrange;+1]"..
		-- Messages display
		"label[0,5.7;"..S("Display messages in chat").."]"..
		"button[3.7,5.5;1,1;dmessages;"..tostring(fishing_setting.tmp_setting["message"]).."]"..
		--poledeco
		"label[0,6.5;"..S("Simple pole deco").."]"..
		"button[3.7,6.3;1,1;poledeco;"..tostring(fishing_setting.tmp_setting["simple_deco_fishing_pole"]).."]"..
		-- Wearout
		"label[0,7.3;"..S("Poles wearout").."]"..
		"button[3.7,7.1;1,1;wearout;"..tostring(fishing_setting.tmp_setting["wear_out"]).."]"..
		-- TREASURE_ENABLE
		"label[6,5.7;"..S("Enable treasure").."]"..
		"button[9.7,5.5;1,1;treasureenable;"..tostring(fishing_setting.tmp_setting["treasure_enable"]).."]"..
		-- NEW_WORM_SOURCE
		"label[6,6.5;"..S("New worm source (reboot)").."]"..
		"button[9.7,6.3;1,1;newworm;"..tostring(fishing_setting.tmp_setting["new_worm_source"]).."]"..
		-- WORM_IS_MOB
		"label[6,7.3;"..S("Worm is a mob (reboot)").."]"..
		"button[9.7,7.1;1,1;wormmob;"..tostring(fishing_setting.tmp_setting["worm_is_mob"]).."]"..
		"button_exit[0,8.2;1.5,1;abort;"..S("Abort").."]"..
		"button_exit[9.2,8.2;1.5,1;save;"..S("OK").."]"
	minetest.show_formspec(player_name, "fishing:settings", formspec)
end

local inc = function(value, field, min, max)
	local inc = tonumber(field)
	local v = value
	if inc ~= nil then
		v = value + inc
	end

	if v > max then
		return max
	end
	if v < min then
		return min
	end
	return v
end


local bool = function(field)
	return field ~= "true"
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local player_name = player:get_player_name()
	if not player_name then return end
	if formname == "fishing:settings" then
		if fields["save"]  then
			fishing_setting.func.set_settings(fishing_setting.settings, fishing_setting.tmp_setting)
			fishing_setting.func.save()
			fishing_setting.tmp_setting = nil
			return
		elseif fields["quit"] or fields["abort"] then
			fishing_setting.tmp_setting = nil
			return
		elseif fields["cfish"] then
			fishing_setting.tmp_setting["fish_chance"] = inc(fishing_setting.tmp_setting["fish_chance"], fields["cfish"], 1, 100)
		elseif fields["cshark"] then
			fishing_setting.tmp_setting["shark_chance"] = inc(fishing_setting.tmp_setting["shark_chance"], fields["cshark"], 1, 100)
		elseif fields["ctreasure"] then
			fishing_setting.tmp_setting["treasure_chance"] = inc(fishing_setting.tmp_setting["treasure_chance"], fields["ctreasure"], 1, 100)
		elseif fields["bvrange"] then
			fishing_setting.tmp_setting["bobber_view_range"] = inc(fishing_setting.tmp_setting["bobber_view_range"], fields["bvrange"], 4, 20)
		elseif fields["cworm"] then
			fishing_setting.tmp_setting["worm_chance"] = inc(fishing_setting.tmp_setting["worm_chance"], fields["cworm"], 1, 100)
		elseif fields["cescape"] then
			fishing_setting.tmp_setting["escape_chance"] = inc(fishing_setting.tmp_setting["escape_chance"], fields["cescape"], 1, 50)
		elseif fields["dmessages"] then
			fishing_setting.tmp_setting["message"] = bool(fields["dmessages"])
		elseif fields["poledeco"] then
			fishing_setting.tmp_setting["simple_deco_fishing_pole"] = bool(fields["poledeco"])
		elseif fields["wearout"] then
			fishing_setting.tmp_setting["wear_out"] = bool(fields["wearout"])
		elseif fields["treasureenable"] then
			fishing_setting.tmp_setting["treasure_enable"] = bool(fields["treasureenable"])
		elseif fields["newworm"] then
			fishing_setting.tmp_setting["new_worm_source"] = bool(fields["newworm"])
		elseif fields["wormmob"] then
			fishing_setting.tmp_setting["worm_is_mob"] = bool(fields["wormmob"])
		else
			return
		end

		fishing_setting.func.on_show_settings(player_name)
	elseif formname == "fishing:admin_conf" then
		if fields["classement"] then
			local formspec = fishing_setting.func.get_stat()
			minetest.show_formspec(player_name, "fishing:classement", formspec)
		elseif fields["contest"] then
			fishing_setting.func.on_show_settings_contest(player_name)
		elseif fields["configuration"] then
			fishing_setting.func.on_show_settings(player_name)
		end
	end
end)

--function load settings from file
function fishing_setting.func.load_trophies()
	local file = io.open(fishing_setting.file_trophies, "r")
	fishing_setting.trophies = {}
	if file then
		fishing_setting.trophies = minetest.deserialize(file:read("*all"))
		file:close()
		if not fishing_setting.trophies or type(fishing_setting.trophies) ~= "table" then
			fishing_setting.trophies = {}
		end
	end
end

function fishing_setting.func.save_trophies()
	local input = io.open(fishing_setting.file_trophies, "w")
	if input then
		input:write(minetest.serialize(fishing_setting.trophies))
		input:close()
	else
		minetest.log("action","Open failed (mode:w) of " .. fishing_setting.file_trophies)
	end
end

minetest.register_on_shutdown(function()
	minetest.log("action", "[fishing] Server shuts down. saving trophies table")
	fishing_setting.func.save_trophies()
	fishing_setting.func.save_contest()
end)



function fishing_setting.func.timetostr(time)
	local countdown = time
	local answer = ""
	if countdown >= 3600 then
		local hours = math.floor(countdown / 3600)
		countdown = countdown % 3600
		answer = hours .. "h"
	end
	if countdown >= 60 then
		local minutes = math.floor(countdown / 60)
		countdown = countdown % 60
		answer = answer .. minutes .. "m"
	else
		answer = answer .. "0m"
	end
	local seconds = countdown
	answer = answer .. math.floor(seconds) .. "s"
	return answer
end

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	if fishing_setting.contest["contest"] == true then
		minetest.chat_send_player(player_name, fishing_setting.func.S("A fishing contest is in progress. (remaining time %s)"):format(fishing_setting.func.timetostr(fishing_setting.contest["duration"])))
	end
end)


function fishing_setting.func.add_to_trophies(player, fish, desc)
	local player_name = player:get_player_name()
	if not player_name then return end
	if fish == "fish_raw" or fish == "shark_raw" or fish == "pike_raw" or fish == "clownfish_raw" or fish == "bluewhite_raw" then
		if fishing_setting.trophies[fish] == nil then
			fishing_setting.trophies[fish] = {}
		end
		fishing_setting.trophies[fish][player_name] = (fishing_setting.trophies[fish][player_name] or 0) + 1
		if fishing_setting.trophies[fish][player_name]%100 == 0 then
			minetest.chat_send_player(player_name, fishing_setting.func.S("You win a new trophy, you have caught %s " .. fish.."."):format(fishing_setting.trophies[fish][player_name]))
			local inv = player:get_inventory()
			local name = "fishing:trophy_"..fish
			if inv:room_for_item("main", {name=name, count=1, wear=0, metadata=""}) then
				inv:add_item("main", {name=name, count=1, wear=0, metadata=""})
			else
				minetest.spawn_item(player:getpos(), {name=name, count=1, wear=0, metadata=""})
			end
		end

		if fishing_setting.contest["contest"] ~= nil and fishing_setting.contest["contest"] == true then
			if fishing_setting.contest[fish] == nil then
				fishing_setting.contest[fish] = {}
			end
			fishing_setting.contest[fish][player_name] = (fishing_setting.contest[fish][player_name] or 0) + 1
			minetest.chat_send_all(fishing_setting.func.S("Yeah, %s caught "..desc):format(player_name))
		end
	end
end


-- Menu: fishing configuration/contest
fishing_setting.func.on_show_admin_menu = function(player_name)
	local S = fishing_setting.func.S
	local formspec = "size[5,5]label[1.6,0;"..S("Fishing Menu").."]"..
					"button[0.5,0.5;4,1;classement;"..S("Contest rankings").."]"..
					"button[0.5,1.5;4,1;contest;"..S("Contests").."]"..
					"button[0.5,2.5;4,1;configuration;"..S("Configuration").."]"..
					"button_exit[1,4.5;3,1;close;"..S("Close").."]"
	minetest.show_formspec(player_name, "fishing:admin_conf", formspec)
end


if (minetest.get_modpath("unified_inventory")) then
	unified_inventory.register_button("menu_fishing", {
		type = "image",
		image = "fishing_fish_raw.png",
		tooltip = "fishing menu configuration",
		action = function(player)
			local player_name = player:get_player_name()
			if not player_name then return end
			if minetest.check_player_privs(player_name, {server=true}) then
				fishing_setting.func.on_show_admin_menu(player_name)
			else
				local formspec = fishing_setting.func.get_stat()
				minetest.show_formspec(player_name, "fishing:classement", formspec)
			end
		end,
	})
end


--function save settings
function fishing_setting.func.save_contest()
	local input = io.open(fishing_setting.file_contest, "w")
	if input then
		input:write(minetest.serialize(fishing_setting.contest))
		input:close()
	else
		minetest.log("action","Open failed (mode:w) of " .. fishing_setting.file_contest)
	end
end

--function load councours data from file
function fishing_setting.func.load_contest()
	local file = io.open(fishing_setting.file_contest, "r")
	local settings = {}
	fishing_setting.contest = {["contest"] = false, ["duration"] = 3600, ["bobber_nb"] = 4}
	if file then
		 settings = minetest.deserialize(file:read("*all"))
		file:close()
		if settings ~= nil and type(settings) == "table" then
			if settings["contest"] ~= nil then
				fishing_setting.contest["contest"] = settings["contest"]
			end
			if settings["duration"] ~= nil then
				fishing_setting.contest["duration"] = settings["duration"]
			end
			if settings["bobber_nb"] ~= nil then
				fishing_setting.contest["bobber_nb"] = settings["bobber_nb"]
			end
			if settings["fish_raw"] ~= nil then
				fishing_setting.contest["fish_raw"] = settings["fish_raw"]
			end
			if settings["clownfish_raw"] ~= nil then
				fishing_setting.contest["clownfish_raw"] = settings["clownfish_raw"]
			end
			if settings["bluewhite_raw"] ~= nil then
				fishing_setting.contest["bluewhite_raw"] = settings["bluewhite_raw"]
			end
			if settings["shark_raw"] ~= nil then
				fishing_setting.contest["shark_raw"] = settings["shark_raw"]
			end
			if settings["pike_raw"] ~= nil then
				fishing_setting.contest["pike_raw"] = settings["pike_raw"]
			end
		end
	end
end

function fishing_setting.func.end_contest()
	fishing_setting.contest["contest"] = false
	minetest.chat_send_all(fishing_setting.func.S("End of fishing contest."))
	minetest.sound_play("fishing_contest_end",{gain=0.8})
	fishing_setting.func.show_result()
end

--Menu fishing configuration
fishing_setting.func.on_show_settings_contest = function(player_name)
	local S = fishing_setting.func.S
	if not fishing_setting.tmp_setting then
		fishing_setting.tmp_setting = { ["contest"] = (fishing_setting.contest["contest"] or false),
										["duration"] = (math.floor(fishing_setting.contest["duration"]) or 3600),
										["bobber_nb"] = (fishing_setting.contest["bobber_nb"] or 2),
										["reset"] = false
										}
	end
	local formspec = "size[6.1,7]label[1.9,0;"..S("Fishing contest").."]"..
				--Time contest
				"label[2.2,0.5;"..S("Duration(in sec)").."]"..
				"button[0.8,1;1,1;duration;-60]"..
				"button[1.8,1;1,1;duration;-600]"..
				"label[2.7,1.2;"..tostring(fishing_setting.tmp_setting["duration"]).."]"..
				"button[3.5,1;1,1;duration;+600]"..
				"button[4.5,1;1,1;duration;+60]"..
				--bobber nb
				"label[2,2;"..S("Bobber number limit").."]"..
				"button[1.8,2.5;1,1;bobbernb;-1]"..
				"label[2.9,2.7;"..tostring(fishing_setting.tmp_setting["bobber_nb"]).."]"..
				"button[3.5,2.5;1,1;bobbernb;+1]"..
				--contest enable
				"label[0.8,3.8;"..S("Enable contests").."]"..
				"button[4.5,3.6;1,1;contest;"..tostring(fishing_setting.tmp_setting["contest"]).."]"..
				--reset
				"label[0.8,5.2;"..S("Reset rankings").."]"..
				"button[4.5,5;1,1;reset;"..tostring(fishing_setting.tmp_setting["reset"]).."]"..
				"button_exit[0.8,6.2;1.5,1;abort;"..S("Abort").."]"..
				"button_exit[4,6.2;1.5,1;save;"..S("OK").."]"
	minetest.show_formspec(player_name, "fishing:contest", formspec)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "fishing:contest" then
		local name = player:get_player_name()
		if not name then return end
		if fields["save"] then
			if fishing_setting.tmp_setting["reset"] == true then
				fishing_setting.contest["fish_raw"] = {}
				fishing_setting.contest["clownfish_raw"] = {}
				fishing_setting.contest["bluewhite_raw"] = {}
				fishing_setting.contest["shark_raw"] = {}
				fishing_setting.contest["pike_raw"] = {}
			end

			local progress = (fishing_setting.contest["contest"] or false)
			fishing_setting.contest["duration"] = fishing_setting.tmp_setting["duration"]
			fishing_setting.contest["contest"] = fishing_setting.tmp_setting["contest"]
			fishing_setting.contest["bobber_nb"] = fishing_setting.tmp_setting["bobber_nb"]
			if progress == false and fishing_setting.tmp_setting["contest"] == true then
				fishing_setting.contest["contest"] = true
				fishing_setting.contest["warning_said"] = false
				local time = fishing_setting.func.timetostr(fishing_setting.contest["duration"])
				minetest.chat_send_all(fishing_setting.func.S("Attention, Fishing contest start (duration %s)!!!"):format(time))
				minetest.sound_play("fishing_contest_start",{gain=0.8})
			elseif progress == true and fishing_setting.tmp_setting["contest"] == false then
				fishing_setting.func.end_contest()
			end
			fishing_setting.func.save_contest()
			fishing_setting.tmp_setting = nil
			return
		elseif fields["quit"] or fields["abort"] then
			fishing_setting.tmp_setting = nil
			return
		elseif fields["duration"] then
			fishing_setting.tmp_setting["duration"] = inc(fishing_setting.tmp_setting["duration"], fields["duration"], 120, 14400)
		elseif fields["contest"] then
			fishing_setting.tmp_setting["contest"] = bool(fields["contest"])
		elseif fields["bobbernb"] then
			fishing_setting.tmp_setting["bobber_nb"] = inc(fishing_setting.tmp_setting["bobber_nb"], fields["bobbernb"], 1, 8)
		elseif fields["reset"] then
			fishing_setting.tmp_setting["reset"] = bool(fields["reset"])
		else
			return
		end
		fishing_setting.func.on_show_settings_contest(name)
	end
end)


function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end
    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end
    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end


function fishing_setting.func.set_winners(list)
	local win = {}
	local i = 1
	-- this uses an custom sorting function ordering by score descending
	for k,v in spairs(list, function(t,a,b) return t[b] < t[a] end) do
		table.insert(win, {[k]=v})
		if #win >= 6 then
			break
		end
	end
	return win
end


function fishing_setting.func.get_stat()
	local winners= {}
	for k,v in pairs(fishing_setting.contest) do
		if string.find(k, "_raw") ~= nil then
			if fishing_setting.contest[k] ~= nil then
				winners[k] = fishing_setting.func.set_winners(fishing_setting.contest[k])
			else
				winners[k] = {}
			end
		end
	end
	local S = fishing_setting.func.S
	local formspec = {"size[12,8]label[3.7,0;"..S("Fishing contest rankings").."]"}
	local X = 0
	local Y
	for fish, fishers in pairs(winners) do
		Y = 1.1
		table.insert(formspec, "label["..(X+0.4)..",0.5;"..string.gsub(fish, "_raw", ""):upper().."]") --fish name
		for _,s in ipairs(fishers) do
			for pl,nb in pairs(s) do
				table.insert(formspec, "label["..(X) ..","..Y..";"..tostring(nb).."]") -- nb fish caught
				table.insert(formspec, "label["..(X+0.5) ..","..Y..";"..tostring(pl).."]") -- playername
			end
			Y = Y + 0.4
		end
		X = X + 2.3
	end
	table.insert(formspec, "button_exit[5.5,7.5;1.2,1;close;"..S("Close").."]")
	return table.concat(formspec)
end


minetest.register_chatcommand("fishing_menu", {
	params = "",
	description = "Show fishing menu (admin only)",
	privs = {server=true},
	func = function(player_name, param)
		if not player_name then return end
		fishing_setting.func.on_show_admin_menu(player_name)
	end
})

minetest.register_chatcommand("fishing_classement", {
	params = "display classement",
	description = "",
	privs = {interact=true},
	func = function(player_name, param)
		if not player_name then return end
		local formspec = fishing_setting.func.get_stat()
		minetest.show_formspec(player_name, "fishing:classement", formspec)
	end
})

function fishing_setting.func.show_result()
	minetest.after(3, function()
		local formspec = fishing_setting.func.get_stat()
		for _,player in pairs(minetest.get_connected_players()) do
			local player_name = player:get_player_name()
			if player_name ~= nil then
				minetest.show_formspec(player_name, "fishing:classement", formspec)
			end
		end
	end)
end
