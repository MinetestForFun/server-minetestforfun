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
pclasses.data = {}
pclasses.data.players = {}
pclasses.data.reserved_items = {}
pclasses.data.hud_ids = {} -- HUD maybe?

dofile(minetest.get_modpath("pclasses") .. "/api.lua")
dofile(minetest.get_modpath("pclasses") .. "/nodes.lua")

function pclasses.data.load()
	local file = io.open(minetest.get_worldpath().."/quests", "r")
	if file then
		local loaded = minetest.deserialize(file:read("*all"))
		file:close()
		pclasses.data.players = loaded.players or pclasses.data.players
		minetest.log("action", "[PClasses] Loaded data")
	end
end

function pclasses.data.save()
	local file, err = io.open(pclasses.conf.datafile, "w")
	if file then
		file:write(minetest.serialize({
			players = pclasses.data.players,
		}))
		file:close()
		minetest.log("action", "[PClasses] Saved data")
	else
		minetest.log("error", "[PClasses] Data save failed: open failed: " .. err)
	end
end

local function data_save_loop()
	minetest.after(save_interval, data_save_loop)
	pclasses.data.save()
end

pclasses.data.load()

------------------
-- Default class
--

if pclasses.conf.default_class then
	dofile(minetest.get_modpath("pclasses") .. "/" .. pclasses.conf.default_class .. ".lua")
	if pclasses.api.get_class_by_name(pclasses.conf.default_class) then
		minetest.register_on_joinplayer(function(player)
			local pname = player:get_player_name()
			if pclasses.api.get_player_class(pname) == nil then
				pclasses.api.set_player_class(pname, pclasses.conf.default_class)
			end
		end)
	end
end
