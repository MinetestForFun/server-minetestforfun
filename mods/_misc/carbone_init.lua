-- Code below by Casimir.

minetest.after(1, function()
	local i = 0
	local number = 0
	for name, item in pairs(minetest.registered_items) do
		if (name and name ~= "") then
			number = number + 1
		end
		i = i + 1
	end
	minetest.log("action", "There are " .. number .. " registered nodes, items and tools.")
end)

minetest.register_on_joinplayer(function(player)
	minetest.sound_play("player_join", {gain = 0.75})
	player:set_physics_override({
		sneak_glitch = false, -- Climable blocks are quite fast in Carbone.
	})
end)

minetest.register_on_leaveplayer(function(player)
	minetest.sound_play("player_leave", {gain = 1})
end)

minetest.register_on_respawnplayer(function(player)
	player:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
	local pos = player:getpos()
	-- minetest.sound_play("player_join", {pos = pos, gain = 0.5})
end)

minetest.register_on_item_eat(function(hp_change, replace_with_item, itemstack, user, pointed_thing)
	if user:get_hp() >= 20 then return end
	local pos = user:getpos()
	minetest.sound_play("health_gain", {pos = pos, gain = 0.4})
end)

minetest.log("action", "") -- Empty line.
minetest.log("action", "") -- Empty line.

if minetest.setting_getbool("creative_mode") then
	minetest.log("action", "Creative mode is enabled.")
	else
	minetest.log("action", "Creative mode is disabled.")
end

if minetest.setting_getbool("enable_damage") then
	minetest.log("action", "Damage is enabled.")
	else
	minetest.log("action", "Damage is disabled.")
end

if minetest.setting_getbool("enable_pvp") then
	minetest.log("action", "PvP is enabled.")
	else
	minetest.log("action", "PvP is disabled.")
end

if not minetest.is_singleplayer() and minetest.setting_getbool("server_announce") then
	minetest.log("action", "") -- Empty line.
	minetest.log("action", "Server name: " .. minetest.setting_get("server_name") or "(none)")
	minetest.log("action", "Server description: " .. minetest.setting_get("server_description") or "(none)")
	minetest.log("action", "Server URL: " .. minetest.setting_get("server_address") or "(none)")
	minetest.log("action", "MOTD: " .. minetest.setting_get("motd") or "(none)")
	minetest.log("action", "Maximum users: " .. minetest.setting_get("max_users") or 15)
end

minetest.log("action", "") -- Empty line.
minetest.log("action", "") -- Empty line.

-- Reserved slot handling:

minetest.register_on_prejoinplayer(function(name, ip)
	local admin_slots = minetest.setting_get('admin_slots') or 2
	if #minetest.get_connected_players() >= (minetest.setting_get('max_users') - admin_slots)
	   and not minetest.check_player_privs(name, {server = true}) then
		return "Sorry, " .. admin_slots .. " slots are reserved for administrators."
	end
end)


if minetest.setting_getbool("log_mods") then
	 -- Highlight the default mod in the mod loading logs:
	minetest.log("action", "Carbone: * [default] loaded.")
end 
