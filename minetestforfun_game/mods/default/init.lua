-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.

default = {} -- Definitions made by this mod are usable by all mods.

-- The API documentation in here was moved into game_api.txt

-- Definitions made by this mod that other mods can use too
default = {}

default.LIGHT_MAX = 14

-- GUI related stuff
default.gui_bg = "bgcolor[#080808BB;true]"
default.gui_bg_img = "background[5,5;1,1;gui_formbg.png;true]"
default.gui_slots = "listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]"

function default.get_hotbar_bg(x,y)
	local out = ""
	for i=0,7,1 do
		out = out .."image["..x+i..","..y..";1,1;gui_hb_bg.png]"
	end
	return out
end

default.gui_survival_form = "size[8,8.5]"..
			default.gui_bg..
			default.gui_bg_img..
			default.gui_slots..
			"list[current_player;main;0,4.25;8,1;]"..
			"list[current_player;main;0,5.5;8,3;8]"..
			"list[current_player;craft;1.75,0.5;3,3;]"..
			"list[current_player;craftpreview;5.75,1.5;1,1;]"..
			"image[4.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
			"listring[current_player;main]"..
			"listring[current_player;craft]"..
			default.get_hotbar_bg(0,4.25)

-- Load files
dofile(minetest.get_modpath("default").."/functions.lua")
dofile(minetest.get_modpath("default").."/commands.lua")
dofile(minetest.get_modpath("default").."/nodes.lua")
dofile(minetest.get_modpath("default").."/furnace.lua")
dofile(minetest.get_modpath("default").."/tools.lua")
dofile(minetest.get_modpath("default").."/craftitems.lua")
dofile(minetest.get_modpath("default").."/crafting.lua")
dofile(minetest.get_modpath("default").."/mapgen.lua")
dofile(minetest.get_modpath("default").."/player.lua")
dofile(minetest.get_modpath("default").."/trees.lua")
dofile(minetest.get_modpath("default").."/aliases.lua")
dofile(minetest.get_modpath("default").."/legacy.lua")

-- Code below by Casimir.

local function count_items()
	local i = 0
	local number = 0
	for name, item in pairs(minetest.registered_items) do
		if (name and name ~= "") then
			number = number + 1
		end
		i = i + 1
	end
	minetest.log("action", "There are " .. number .. " registered nodes, items and tools.")
end

local function player_join_sounds()
	minetest.register_on_joinplayer(function()
		minetest.sound_play("player_join", {gain = 0.75})
	end)
end

local function player_leave_sounds()
	minetest.register_on_leaveplayer(function()
		minetest.sound_play("player_leave", {gain = 1})
	end)
end

minetest.after(1, count_items)
minetest.after(5, player_join_sounds)
minetest.after(5, player_leave_sounds)


minetest.register_on_joinplayer(function(player)
	player:set_physics_override({
    sneak_glitch = false, -- Climable blocks are quite fast in Carbone.
  })
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
    if #minetest.get_connected_players() >= (minetest.setting_get("max_users") - 2)
    and not minetest.check_player_privs(name, {server = true}) then
        return "Sorry, 2 slots are reserved for administrators."
    end
end)


if minetest.setting_getbool("log_mods") then
	 -- Highlight the default mod in the mod loading logs:
	minetest.log("action", "Carbone: * [default] loaded.")
end
