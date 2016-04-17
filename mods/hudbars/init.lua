hb = {}

hb.hudtables = {}

-- number of registered HUD bars
hb.hudbars_count = 0

hb.settings = {}
hb.settings.custom = {} --MFF (crabman|19/06/15) add custom pos
-- default settings
hb.settings.max_bar_length = 160

-- statbar positions
hb.settings.pos_left = { x=0.5, y=1 }
hb.settings.pos_right= { x = 0.5, y = 1 }
hb.settings.start_offset_left = { x = -175, y = -100 }
hb.settings.start_offset_right = { x = 15, y = -100 }

hb.settings.vmargin = 24
hb.settings.tick = 0.1

-- Table which contains all players with active default HUD bars (only for internal use)
--hb.players = {}

function hb.value_to_barlength(value, max)
	if max == 0 then
		return 0
	else
		return math.ceil((value/max) * hb.settings.max_bar_length)
	end
end

function hb.get_hudtable(identifier)
	return hb.hudtables[identifier]
end

function hb.register_hudbar(identifier, text_color, label, textures, default_start_value, default_start_max, default_start_hidden, format_string)
	local hudtable = {}
	local pos, offset

	--MFF (crabman|19/06/15)|DEBUT add custom pos
	if hb.settings.custom.custom and hb.settings.custom[identifier] ~= nil then
		if hb.settings.custom[identifier].x == 0 then
			pos = hb.settings.pos_left
			offset = {
				x = hb.settings.start_offset_left.x,
				y = hb.settings.start_offset_left.y - hb.settings.vmargin * math.floor(hb.settings.custom[identifier].y)
			}
		else
			pos = hb.settings.pos_right
			offset = {
				x = hb.settings.start_offset_right.x,
				y = hb.settings.start_offset_right.y - hb.settings.vmargin * math.floor(hb.settings.custom[identifier].y)
			}
		end
	--MFF (crabman|19/06/15) /FIN
	elseif hb.hudbars_count % 2 == 0 then
		pos = hb.settings.pos_left
		offset = {
			x = hb.settings.start_offset_left.x,
			y = hb.settings.start_offset_left.y - hb.settings.vmargin * math.floor(hb.hudbars_count/2)
		}
	else
		pos = hb.settings.pos_right
		offset = {
			x = hb.settings.start_offset_right.x,
			y = hb.settings.start_offset_right.y - hb.settings.vmargin * math.floor((hb.hudbars_count-1)/2)
		}
	end
	if format_string == nil then
		format_string = "%s: %d/%d"
	end

	hudtable.add_all = function(player, hudtable, start_value, start_max, start_hidden)
		if start_value == nil then start_value = hudtable.default_start_value end
		if start_max == nil then start_max = hudtable.default_start_max end
		if start_hidden == nil then start_hidden = hudtable.default_start_hidden end
		local ids = {}
		local state = {}
		local name = player:get_player_name()
		local bgscale, iconscale, text, barnumber
		if start_max == 0 or start_hidden then
			bgscale = { x=0, y=0 }
		else
			bgscale = { x=1, y=1 }
		end
		if start_hidden then
			iconscale = { x=0, y=0 }
			barnumber = 0
			text = ""
		else
			iconscale = { x=1, y=1 }
			barnumber = hb.value_to_barlength(start_value, start_max)
			text = string.format(format_string, label, start_value, start_max)
		end
		ids.bg = player:hud_add({
			hud_elem_type = "image",
			position = pos,
			scale = bgscale,
			text = "hudbars_bar_background.png",
			alignment = {x=1,y=1},
			offset = { x = offset.x - 1, y = offset.y - 1 },
		})
		if textures.icon ~= nil then
			ids.icon = player:hud_add({
				hud_elem_type = "image",
				position = pos,
				scale = iconscale,
				text = textures.icon,
				alignment = {x=-1,y=1},
				offset = { x = offset.x - 3, y = offset.y },
			})
		end
		ids.bar = player:hud_add({
			hud_elem_type = "statbar",
			position = pos,
			text = textures.bar,
			number = barnumber,
			alignment = {x=-1,y=-1},
			offset = offset,
			size = {x = 2.5, y = 16},
		})
		ids.text = player:hud_add({
			hud_elem_type = "text",
			position = pos,
			text = text,
			alignment = {x=1,y=1},
			number = text_color,
			direction = 0,
			offset = { x = offset.x + 2,  y = offset.y },
		})
		-- Do not forget to update hb.get_hudbar_state if you add new fields to the state table
		state.hidden = start_hidden
		state.value = start_value
		state.max = start_max
		state.text = text
		state.barlength = hb.value_to_barlength(start_value, start_max)

		local main_error_text =
			"[hudbars] Bad initial values of HUD bar identifier “"..tostring(identifier).."” for player "..name..". "

		if start_max < start_value then
			minetest.log("error", main_error_text.."start_max ("..start_max..") is smaller than start_value ("..start_value..")!")
		end
		if start_max < 0 then
			minetest.log("error", main_error_text.."start_max ("..start_max..") is smaller than 0!")
		end
		if start_value < 0 then
			minetest.log("error", main_error_text.."start_value ("..start_value..") is smaller than 0!")
		end

		hb.hudtables[identifier].hudids[name] = ids
		hb.hudtables[identifier].hudstate[name] = state
	end

	hudtable.identifier = identifier
	hudtable.format_string = format_string
	hudtable.label = label
	hudtable.hudids = {}
	hudtable.hudstate = {}
	hudtable.default_start_hidden = default_start_hidden
	hudtable.default_start_value = default_start_value
	hudtable.default_start_max = default_start_max

	hb.hudbars_count= hb.hudbars_count + 1

	hb.hudtables[identifier] = hudtable
end

function hb.init_hudbar(player, identifier, start_value, start_max, start_hidden)
	local hudtable = hb.get_hudtable(identifier)
	hb.hudtables[identifier].add_all(player, hudtable, start_value, start_max, start_hidden)
end

function hb.change_hudbar(player, identifier, new_value, new_max_value)
	if new_value == nil and new_max_value == nil then
		return
	end

	local name = player:get_player_name()
	local hudtable = hb.get_hudtable(identifier)
	local value_changed, max_changed = false, false

	if new_max_value ~= nil then
		if new_max_value ~= hudtable.hudstate[name].max then
			hudtable.hudstate[name].max = new_max_value
			max_changed = true
		end
	else
		new_max_value = (hudtable.hudstate[name] or {max = 0}).max
	end

	if new_value ~= nil and hudtable.hudstate[name] then
		if new_value ~= hudtable.hudstate[name].value then
			if new_value > new_max_value then
				new_value = new_max_value
			end
			hudtable.hudstate[name].value = new_value
			value_changed = true
		end
	elseif hudtable.hudstate[name] then
		new_value = hudtable.hudstate[name].value
	end

	local main_error_text =
		"[hudbars] Bad call to hb.change_hudbar, identifier: “"..tostring(identifier).."”, player name: “"..name.."”. "
	if new_max_value < new_value then
		minetest.log("error", main_error_text.."new_max_value ("..new_max_value..") is smaller than new_value ("..new_value..")!")
	end
	if new_max_value < 0 then
		minetest.log("error", main_error_text.."new_max_value ("..new_max_value..") is smaller than 0!")
	end
	if new_value < 0 then
		minetest.log("error", main_error_text.."new_value ("..new_value..") is smaller than 0!")
	end

	if hudtable.hudstate[name] and hudtable.hudstate[name].hidden == false then
		if max_changed then
			if hudtable.hudstate[name].max == 0 then
				player:hud_change(hudtable.hudids[name].bg, "scale", {x=0,y=0})
			else
				player:hud_change(hudtable.hudids[name].bg, "scale", {x=1,y=1})
			end
		end

		if value_changed or max_changed then
			local new_barlength = hb.value_to_barlength(new_value, new_max_value)
			if new_barlength ~= hudtable.hudstate[name].barlength then
				player:hud_change(hudtable.hudids[name].bar, "number", hb.value_to_barlength(new_value, new_max_value))
				hudtable.hudstate[name].barlength = new_barlength
			end

			local new_text = string.format(hudtable.format_string, hudtable.label, new_value, new_max_value)
			if new_text ~= hudtable.hudstate[name].text then
				player:hud_change(hudtable.hudids[name].text, "text", new_text)
				hudtable.hudstate[name].text = new_text
			end
		end
	end
end

function hb.hide_hudbar(player, identifier)
	local name = player:get_player_name()
	local hudtable = hb.get_hudtable(identifier)
	if(hudtable.hudstate[name].hidden == false) then
		if hudtable.hudids[name].icon ~= nil then
			player:hud_change(hudtable.hudids[name].icon, "scale", {x=0,y=0})
		end
		player:hud_change(hudtable.hudids[name].bg, "scale", {x=0,y=0})
		player:hud_change(hudtable.hudids[name].bar, "number", 0)
		player:hud_change(hudtable.hudids[name].text, "text", "")
		hudtable.hudstate[name].hidden = true
	end
end

function hb.unhide_hudbar(player, identifier)
	local name = player:get_player_name()
	local hudtable = hb.get_hudtable(identifier)
	if(hudtable.hudstate[name] and hudtable.hudstate[name].hidden) then
		local name = player:get_player_name()
		local value = hudtable.hudstate[name].value
		local max = hudtable.hudstate[name].max
		if hudtable.hudids[name].icon ~= nil then
			player:hud_change(hudtable.hudids[name].icon, "scale", {x=1,y=1})
		end
		if hudtable.hudstate[name].max ~= 0 then
			player:hud_change(hudtable.hudids[name].bg, "scale", {x=1,y=1})
		end
		player:hud_change(hudtable.hudids[name].bar, "number", hb.value_to_barlength(value, max))
		player:hud_change(hudtable.hudids[name].text, "text", tostring(string.format(hudtable.format_string, hudtable.label, value, max)))
		hudtable.hudstate[name].hidden = false
	end
end

function hb.get_hudbar_state(player, identifier)
	local ref = hb.get_hudtable(identifier).hudstate[player:get_player_name()]
	-- Do not forget to update this chunk of code in case the state changes
	local copy = {
		hidden = ref.hidden,
		value = ref.value,
		max = ref.max,
		text = ref.text,
		barlength = ref.barlength,
	}
	return copy
end

--load custom settings
local set = io.open(minetest.get_modpath("hudbars").."/hudbars.conf", "r")
if set then
	dofile(minetest.get_modpath("hudbars").."/hudbars.conf")
	set:close()
end

--register built-in HUD bars
if minetest.setting_getbool("enable_damage") then
	hb.register_hudbar("health", 0xFFFFFF, "Health", { bar = "hudbars_bar_health.png", icon = "hudbars_icon_health.png" }, 20, 20, false)
	hb.register_hudbar("breath", 0xFFFFFF, "Breath", { bar = "hudbars_bar_breath.png", icon = "hudbars_icon_breath.png" }, 10, 10, true)
end

local function hide_builtin(player)
	local flags = player:hud_get_flags()
	flags.healthbar = false
	flags.breathbar = false
	player:hud_set_flags(flags)
end


local function custom_hud(player)
	if minetest.setting_getbool("enable_damage") then
		hb.init_hudbar(player, "health", player:get_hp())
		local breath = player:get_breath()
		local hide_breath
		if breath == 11 then hide_breath = true else hide_breath = false end
		hb.init_hudbar(player, "breath", math.min(breath, 10), nil, hide_breath)
	end
end


-- update built-in HUD bars
local function update_hud(player)
	if minetest.setting_getbool("enable_damage") then
		--air
		local breath = player:get_breath()

		if breath == 11 then
			hb.hide_hudbar(player, "breath")
		elseif breath then
			hb.unhide_hudbar(player, "breath")
			hb.change_hudbar(player, "breath", math.min(breath, 10))
		end

		--health
		hb.change_hudbar(player, "health", player:get_hp())
	end
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if not name or name == "" then return end
	hide_builtin(player)
	custom_hud(player)
--	hb.players[name] = player
end)

--[[
minetest.register_on_leaveplayer(function(player)
	hb.players[player:get_player_name()] = nil
end)
--]]

local main_timer = 0
local timer = 0
minetest.register_globalstep(function(dtime)
	main_timer = main_timer + dtime
	timer = timer + dtime
	if main_timer > hb.settings.tick or timer > 4 then
		if main_timer > hb.settings.tick then main_timer = 0 end
		--for playername, player in pairs(hb.players) do --MFF (6/03/2016) removed cause server register(bug/lag?) table hb.players[""]
		for _,player in ipairs(minetest.get_connected_players()) do
			-- only proceed if damage is enabled
			if minetest.setting_getbool("enable_damage") then
			-- update all hud elements
				update_hud(player)
			end
		end
	end
	if timer > 4 then timer = 0 end
end)

-- Our legacy
dofile(minetest.get_modpath("hudbars").."/hud_legacy.lua")
