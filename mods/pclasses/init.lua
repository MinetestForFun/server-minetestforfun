-------------------
-- Player Classes
--

-- NOTE: This is a very simple interface for classes, more features will be
--       added depending on the various mechanisms we will need

-- Global namespace
pclasses = {}

-- API
pclasses.api = {}

-- Classes
pclasses.classes = {}

-- Data
pclasses.datas = {}
pclasses.datas.players = {}
pclasses.datas.hud_ids = {} -- HUD maybe?


-- Various utility functions

-- Get an ID number dedicated to the class
function pclasses.api.create_class_id()
	return table.getn(pclasses.classes)+1
end

function pclasses.api.id_for_class(cname)
	if cname then
		for k,v in ipairs(pclasses.classes) do
			if v and v.name and v.name == cname then
				return k
			end
		end
		return 0
	end
	return nil
end

-- Register the class (basic registration)
function pclasses.api.register_class(cname)
	if not cname then
		minetest.log("error", "[PClasses] Error registering unamed class")
		return
	end

	local c_id = pclasses.api.create_class()
	pclasses.classes[c_id] = {name = cname}
	return c_id
end

------------------------
-- Getters and Setters
--

-- Get class specs
--  by id
function pclasses.api.get_class_by_id(id)
	return pclasses.classes[id]
end

-- by name
function pclasses.api.get_class_by_name(cname)
	return pclasses.classes[pclasses.api.id_for_class(cname)]
end


-- Get single player
function pclasses.api.get_player_class(pname)
	return pclasses.datas.player[pname]
end

-- Get all players for a class
function pclasses.api.get_class_players(cname)
	local pnames = {}
	if pclasses.api.get_class_by_name(cname) then
		for p,c in ipairs(pclasses.datas.players) do
			if c == cname then
				table.insert(pnames, table.getn(pnames)+1)
			end
		end
	end
end

-- Set single player
function pclasses.api.set_player_class(pname, cname)
	if pclasses.api.get_class_by_name(cname) then
		pclasses.datas.players[pname] = cname
		return true
	end
	return false
end
