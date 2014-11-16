minetest.register_privilege("physics", {
    description = "Allows player to set their gravity, jump height and movement speed"})

-- Infotool code by PilzAdam:
minetest.register_craftitem("default:infotool", {
    description = "Infotool",
    inventory_image = "default_infotool.png",
    wield_image = "default_infotool.png^[transformR90",
    groups = {not_in_creative_inventory = 1},
    on_use = function(_, user, pt)
	if pt.type ~= "node" then return end
	local nn = minetest.get_node(pt.under).name
	if type(minetest.registered_items[nn].tiles[1]) ~= "string" then return end
	local def = minetest.registered_nodes[nn]
	if not def then return end
	
	local textures = def.tiles
	local description = def.description
	if not textures then
	    textures = {"(no texture)"}
	end
	if not description then
	    description = {"(no description)"}
		end
	for i = 1,6 do
	    if not textures[i] then
		textures[i] = textures[i-1]
	    end
	end
	local dir = vector.subtract(pt.above, pt.under)
	local index
	-- This doesn't work for facedir or other drawtypes yet.
	if dir.y == 1 then
	    index = 1
	elseif dir.y == -1 then
	    index = 2
	else
	    if dir.x == 1 then
		index = 3
	    elseif dir.x == -1 then
		index = 4
	    else
		if dir.z == 1 then
		    index = 5
		else
		    index = 6
		end
	    end
	end
	minetest.chat_send_player(user:get_player_name(), description .. ": " .. nn .. " (" .. textures[index] .. ")")
    end,
})

minetest.register_chatcommand("info", {
	description = "Gives an Infotool, click to receive information on the pointed node",
	func = function(name)
		local receiverref = minetest.get_player_by_name(name)
		receiverref:get_inventory():add_item("main", "default:infotool")
		minetest.chat_send_player(name, "\"default:infotool\" added to inventory.")
	end,
})

minetest.register_chatcommand("clearinventory", {
	params = "<inventory>",
	description = "Clears an entire inventory, \"main\" if unspecified, \"craft\" is another possible choice",
	func = function(name, param)
	    local player = minetest.get_player_by_name(name)
	    local player_inv = player:get_inventory()
		if not player then
			minetest.log("error", "Unable to clear inventory, no player.")
			return false, "Unable to clear inventory, no player."
		end
		if param == "" then
		    player_inv:set_list("main", {})
			return true, "Inventory \"main\" cleared."
		    else
			player_inv:set_list(param, {})
			return true, "Inventory \"" .. param .. "\" cleared."
		end
	end,
})

-- The following commands /whoami, /suicide, /speed, /gravity and /jump by Wuzzy:
minetest.register_chatcommand("whoami", {
	params = "",
	description = "Tells your name",
	privs = {},
	func = function(name)
		minetest.chat_send_player(name, "Your name is: " .. name)
	end,
})

minetest.register_chatcommand("ip", {
	params = "",
	description = "Shows your IP address",
	privs = {},
	func = function(name)
		minetest.chat_send_player(name, "Your IP address is: "..minetest.get_player_ip(name))
	end
})

minetest.register_chatcommand("suicide", {
	params = "",
	description = "Kills yourself",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then return end
		player:set_hp(0)
		if minetest.setting_getbool("enable_damage") == false then
			minetest.chat_send_player(name, "[X] Damage is disabled on this server.")
		else
			minetest.chat_send_player(name, "[X] You suicided.")
		end
	end,
})

minetest.register_chatcommand("speed", {
    params = "[speed]",
    description = "Sets your movement speed (defaults to 1).",
    privs = {physics = true},
    func = function(name, speed)
	local player = minetest.get_player_by_name(name)
	if not player then return end
	if speed == "" then speed = 1 end
	if type(tonumber(speed)) ~= "number"
	or tonumber(speed) < 0
	or tonumber(speed) > 10 then
	    minetest.chat_send_player(name, "[~] Speed must be between 0.0 and 10.0.")
	    return
	end

	player:set_physics_override(tonumber(speed), nil, nil)
	minetest.chat_send_player(name, "[~] Speed set to " .. tonumber(speed) * 100 .. " %.")
    end,
})

minetest.register_chatcommand("gravity", {
	params = "[gravity]",
	description = "Sets your gravity (defaults to 1).",
	privs = {physics = true},
	func = function(name, gravity)
		local player = minetest.get_player_by_name(name)
		if not player then return end
		if gravity == "" then gravity = 1 end
		if type(tonumber(gravity)) ~= "number"
		or tonumber(gravity) < -10
		or tonumber(gravity) > 10 then
		    minetest.chat_send_player(name, "[~] Gravity must be between -10.0 and 10.0.")
		    return
		end

		player:set_physics_override(nil, nil, tonumber(gravity))
		minetest.chat_send_player(name, "[~] Gravity set to " .. tonumber(gravity) * 100 .. " %.")
	end,
})

minetest.register_chatcommand("jump", {
	params = "[height]",
	description = "Sets your jump height (defaults to 1)",
	privs = {physics = true},
	func = function(name, jump)
		local player = minetest.get_player_by_name(name)
		if not player then return end
		if jump == "" then jump = 1 end
		if type(tonumber(jump)) ~= "number"
		or tonumber(jump) < 0
		or tonumber(jump) > 10 then
		    minetest.chat_send_player(name, "[~] Jump height must be between 0.0 and 10.0.")
		    return
		end

		player:set_physics_override(nil, tonumber(jump), nil)
		minetest.chat_send_player(name, "[~] Jump height set to " .. tonumber(jump) * 100 .. " %.")
	end,
})

minetest.register_chatcommand("hotbar", {
	params = "[size]",
	description = "Sets the size of your hotbar",
	func = function(name, slots)
		if slots == "" then slots = 16 end
		if type(tonumber(slots)) ~= "number" or tonumber(slots) < 1 or tonumber(slots) > 23 then
			minetest.chat_send_player(name, "[_] Hotbar size must be between 1 and 23.")
			return
		end
		local player = minetest.get_player_by_name(name)
		player:hud_set_hotbar_itemcount(tonumber(slots))
		minetest.chat_send_player(name, "[_] Hotbar size set to " .. tonumber(slots) .. ".")
	end,
})
