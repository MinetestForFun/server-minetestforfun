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
pclasses.conf.superuser_class = "admin"
pclasses.conf.save_interval = 3 * 60
pclasses.conf.datafile = minetest.get_worldpath() .. "/pclasses"
pclasses.conf.gravefile = minetest.get_worldpath() .. "/graveyards"

-- Classes
pclasses.classes = {}

-- Data
pclasses.data = {}
pclasses.data.players = {}
pclasses.data.reserved_items = {}
pclasses.data.hud_ids = {} -- HUD maybe?

dofile(minetest.get_modpath("pclasses") .. "/api.lua")
dofile(minetest.get_modpath("pclasses") .. "/inventory.lua")
dofile(minetest.get_modpath("pclasses") .. "/nodes.lua")

function pclasses.data.load()
	local file = io.open(pclasses.conf.datafile, "r")
	if file then
		local loaded = minetest.deserialize(file:read("*all"))
		file:close()
		if loaded then
			pclasses.data.players = loaded.players or pclasses.data.players
			minetest.log("action", "[PClasses] Loaded data")
		end
	end
end

function pclasses.data.save()
	local file, err = io.open(pclasses.conf.datafile, "w")
	if file then
		file:write(minetest.serialize({
			players = pclasses.data.players,
		}))
		file:close()
		--minetest.log("action", "[PClasses] Saved data")
	else
		minetest.log("error", "[PClasses] Data save failed: open failed: " .. err)
	end
end

local function data_save_loop()
	pclasses.data.save()
	minetest.after(pclasses.conf.save_interval, data_save_loop)
end

pclasses.data.load()

------------------
-- Default class
--

if pclasses.conf.default_class then
	dofile(minetest.get_modpath("pclasses") .. "/" .. pclasses.conf.default_class .. ".lua")
end

minetest.register_on_joinplayer(function(player)
	local pname = player:get_player_name()
	pclasses.api.create_graveyard_inventory(player) --create inventory before
	
	local cname = pclasses.api.get_player_class(pname)
	if cname ~= nil and pclasses.api.get_class_by_name(cname) then
		pclasses.api.set_player_class(pname, cname)
	elseif pclasses.api.get_class_by_name(pclasses.conf.default_class) then
		pclasses.api.set_player_class(pname, pclasses.conf.default_class)
	end
end)

minetest.register_on_shutdown(function()
	pclasses.data.save()
end)

data_save_loop()
