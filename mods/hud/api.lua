-- global values
hud.registered_items = {}
hud.damage_events = {}
hud.breath_events = {}

-- keep id handling internal
local hud_id = {}	-- hud item ids
local sb_bg = {}	-- statbar background ids

-- localize often used table
local items = hud.registered_items

local function throw_error(msg)
	minetest.chat_send_all(msg)
end


--
-- API
--

function hud.register(name, def)
	if not name or not def then
		throw_error("not enough parameters given")
		return false
	end

	--TODO: allow other elements
	if def.hud_elem_type ~= "statbar" then
		throw_error("The given HUD element is no statbar")
		return false
	end
	if items[name] ~= nil then
		throw_error("A statbar with that name already exists")
		return false
	end

	-- actually register
	-- add background first since draworder is based on id :\
	if def.hud_elem_type == "statbar" and def.background ~= nil then
		sb_bg[name] = table.copy(def)
		sb_bg[name].text = def.background
		if not def.autohide_bg and def.max then
			sb_bg[name].number = def.max
		end
	end
	-- add item itself
	items[name] = def

	-- register events
	if def.events then
		for _,v in pairs(def.events) do
			if v and v.type and v.func then
				if v.type == "damage" then
					table.insert(hud.damage_events, v)
				end

				if v.type == "breath" then
					table.insert(hud.breath_events, v)
				end
			end
		end
	end
	
	-- no error so far, return sucess
	return true
end

function hud.change_item(player, name, def)
	if not player or not name or not def then
		throw_error("Not enough parameters given to change HUD item")
		return false
	end
	local i_name = player:get_player_name().."_"..name
	local elem = hud_id[i_name]
	if not elem then
		throw_error("Given HUD element " .. dump(name) .. " does not exist".." hהההה")
		return false
	end

	-- Only update if values supported and value actually changed
	-- update supported values (currently number and text only)
	if def.number and elem.number then
		if def.number ~= elem.number then
			if elem.max and def.number > elem.max and not def.max then
				def.number = elem.max
			end
			if def.max then
				elem.max = def.max
			end
			player:hud_change(elem.id, "number", def.number)
			elem.number = def.number
			-- hide background when set
			local bg = hud_id[i_name.."_bg"]
			if elem.autohide_bg then
				if def.number < 1 then
					player:hud_change(bg.id, "number", 0)
				else
					local num = bg.number
					if bg.max then
						num = bg.max
					end
					player:hud_change(bg.id, "number", num)
				end
			else
				if bg and bg.max and bg.max < 1 and def.max and def.max > bg.max then
					player:hud_change(bg.id, "number", def.max)
					bg.max = def.max
				end	
			end
		end
	end
	if def.text and elem.text then
		if def.text ~= elem.text then
			player:hud_change(elem.id, "text", def.text)
			elem.text = def.text
		end
	end

	if def.offset and elem.offset then
		if def.item_name and def.offset == "item" then
			local i_name2 = player:get_player_name().."_"..def.item_name
			local elem2 = hud_id[i_name2]
			if elem2 then
				local p2 = elem2.offset
				local p1 = elem.offset
				player:hud_change(elem2.id, "offset", p1)
				player:hud_change(elem.id, "offset", p2)
				elem2.offset = p1
				elem.offset = p2
				if elem.background then
					local elem3 = hud_id[i_name.."_bg"]
					if elem3 and elem3.offset then
						player:hud_change(elem3.id, "offset", p2)
						elem3.offset = p2
						local elem4 = hud_id[i_name2.."_bg"]
						if elem4 and elem4.offset then
							player:hud_change(elem4.id, "offset", p1)
							elem4.offset = p1
						end
					end
				end
			end
		else
			player:hud_change(elem.id, "offset", def.offset)
			elem.offset = def.offset
		end
	end

	return true
end

function hud.remove_item(player, name)
	if not player or not name then
		throw_error("Not enough parameters given")
		return false
	end
	local i_name = player:get_player_name().."_"..name
	if hud_id[i_name] == nil then
		throw_error("Given HUD element " .. dump(name) .. " does not exist")
		return false
	end
	player:hud_remove(hud_id[i_name].id)
	hud_id[i_name] = nil

	return true
end


--
-- Add registered HUD items to joining players
--

-- Following code is placed here to keep HUD ids internal
local function add_hud_item(player, name, def)
	if not player or not name or not def then
		throw_error("not enough parameters given")
		return false
	end
	local i_name = player:get_player_name().."_"..name
	hud_id[i_name] = def
	hud_id[i_name].id = player:hud_add(def)
end

minetest.register_on_joinplayer(function(player)

	-- first: hide the default statbars
	player:hud_set_flags({healthbar = false, breathbar = false})

	-- now add the backgrounds (e.g. for statbars)
	for _,item in pairs(sb_bg) do
		add_hud_item(player, _.."_bg", item)
	end
	-- and finally the actual HUD items
	for _,item in pairs(items) do
		add_hud_item(player, _, item)
	end

	-- fancy hotbar (only when no crafting mod present)
	if minetest.get_modpath("crafting") == nil then
	    minetest.after(0.5, function()
		player:hud_set_hotbar_image("hud_hotbar.png")
		player:hud_set_hotbar_selected_image("hud_hotbar_selected.png")
	    end)
	end
end)
