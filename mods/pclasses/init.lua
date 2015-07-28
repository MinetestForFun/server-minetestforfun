-------------------
-- Player Classes
--

-- NOTE: This is a very simple interface for classes, more features will be
--       added depending on the various mechanisms we will need

-- Global namespace
pclasses = {}

-- API
pclasses.api = {}
pclasses.api.util = {}

-- Configuration
pclasses.conf = {}
pclasses.conf.default_class = "adventurer"
pclasses.conf.save_interval = 3 * 60
pclasses.conf.datafile = minetest.get_worldpath() .. "/pclasses"

-- Classes
pclasses.classes = {}

-- Data
pclasses.datas = {}
pclasses.datas.players = {}
pclasses.datas.reserved_items = {}
pclasses.datas.hud_ids = {} -- HUD maybe?

dofile(minetest.get_modpath("pclasses") .. "/api.lua")



------------------
-- Default class
--

if pclasses.conf.default_class then
	dofile(minetest.get_modpath("pclasses") .. "/" .. pclasses.conf.default_class .. ".lua")
	if pclasses.api.get_class_by_name(pclasses.conf.default_class) then
		minetest.register_on_joinplayer(function(player)
			if not pclasses.api.get_player_class(player:get_player_name()) then
				pclasses.api.set_player_class(player:get_player_name(),
					pclasses.conf.default_class)
			end
		end)
	end
end



------------
-- Classes
--

dofile(minetest.get_modpath("pclasses") .. "/warrior.lua")
dofile(minetest.get_modpath("pclasses") .. "/hunter.lua")
dofile(minetest.get_modpath("pclasses") .. "/admin.lua")

