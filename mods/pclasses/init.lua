-------------------
-- Player Classes
--

-- NOTE: This is a very simple interface for classes, more features will be
--       added depending on the various mechanisms we will need

-- Global namespace
pclasses = {}

-- API
pclasses.api = {}

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
function pclasses.api.register_class(cname, assign_f)
	if not cname then
		minetest.log("error", "[PClasses] Error registering unamed class")
		return
	end

	local c_id = pclasses.api.create_class_id()
	pclasses.classes[c_id] = {name = cname}
	if assign_f then
		pclasses.classes[c_id].match_function = assign_f
	end
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
	return pclasses.datas.players[pname]
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

---------------------------
-- Backup and load system
--

-- Startup
local pfile = io.open(pclasses.conf.datafile, "r")
if pfile then
	local line = pfile:read()
	if line then
		pclasses.datas.players = minetest.deserialize(line)
	end
	pfile.close()
end

-- Frequent backup
local function save_datas()
	local pfile = io.open(pclasses.conf.datafile, "w")
	pfile:write(minetest.serialize(pclasses.datas.players))
	pfile.close()
	minetest.log("action", "[PClasses] Datas saved")
end

local save_timer = 0
minetest.register_globalstep(function(dtime)
	save_timer = save_timer + dtime
	if save_timer >= pclasses.conf.save_interval then
		save_datas()
		save_timer = 0
	end
end)
minetest.register_on_shutdown(save_datas)

-----------------------------
-- Default class assignment
--
if pclasses.conf.default_class then
	local id = pclasses.api.register_class(pclasses.conf.default_class, function() return true end)
	if id then
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

pclasses.api.register_class("warrior", function(player)
	local inv = minetest.get_inventory({type = "detached", name = player:get_player_name() .. "_armor"})
	local shift_class = false
	if not inv or inv:is_empty("armor") then
		return shift_class
	end
	shift_class = true
	for _,piece in pairs({"chestplate", "leggings", "boots", "helmet"}) do
		shift_class = shift_class and inv:contains_item("armor", "3d_armor:" .. piece .. "_warrior")
	end
	return shift_class
end)

pclasses.api.register_class("hunter", function(player)
	local inv = minetest.get_inventory({type = "detached", name = player:get_player_name() .. "_armor"})
	local shift_class = false
	if not inv or inv:is_empty("armor") then
		return shift_class
	end
	shift_class = true
	for _,piece in pairs({"chestplate", "leggings", "boots", "helmet"}) do
		shift_class = shift_class and (inv:contains_item("armor", "3d_armor:" .. piece .. "_reinforced_leather_hunter")
			or inv:contains_item("armor", "3d_armor:" .. piece .. "_hardened_leather_hunter")) -- Why two different armors?!
	end
	return shift_class
end)

function pclasses.api.assign_class(player)
	-- Look for every sign needed to deduct a player's class
	-- Starting from the most important class to the less one

	if pclasses.classes[pclasses.api.id_for_class("hunter")].match_function(player) then
		if pclasses.api.get_player_class(player:get_player_name()) ~= "hunter" then
			pclasses.api.set_player_class(player:get_player_name(), "hunter")
			minetest.chat_send_player(player:get_player_name(), "You are now a hunter")
		end

	elseif pclasses.classes[pclasses.api.id_for_class("warrior")].match_function(player) then
		if pclasses.api.get_player_class(player:get_player_name()) ~= "warrior" then
			pclasses.api.set_player_class(player:get_player_name(), "warrior")
			minetest.chat_send_player(player:get_player_name(), "You are now a warrior")
		end

	elseif pclasses.api.get_player_class(player:get_player_name()) ~= "adventurer" then
		pclasses.api.set_player_class(player:get_player_name(), "adventurer")
		minetest.chat_send_player(player:get_player_name(), "You are now an adventurer")
	end
end

minetest.register_on_respawnplayer(pclasses.api.assign_class)
minetest.register_on_joinplayer(function(player) minetest.after(1, pclasses.api.assign_class, player) end)
minetest.register_on_leaveplayer(pclasses.api.assign_class)

-------------------
-- Reserved items
--
function pclasses.api.reserve_item(cname, itemstring)
	pclasses.datas.reserved_items[itemstring] = pclasses.datas.reserved_items or {}
	table.insert(pclasses.datas.reserved_items[itemstring], 1, cname)
end

pclasses.api.reserve_item("warrior", "moreores:sword_mithril")
pclasses.api.reserve_item("warrior", "default:dungeon_master_s_blood_sword")
pclasses.api.reserve_item("warrior", "3d_armor:chestplate_mithril")
pclasses.api.reserve_item("warrior", "3d_armor:helmet_mithril")
pclasses.api.reserve_item("warrior", "3d_armor:leggins_mithril")
pclasses.api.reserve_item("warrior", "3d_armor:boots_mithril")
pclasses.api.reserve_item("warrior", "shields:shields_mithril")

pclasses.api.reserve_item("hunter", "throwing:bow_horn")



minetest.register_globalstep(function(dtime)
	for id, ref in ipairs(minetest.get_connected_players()) do
		local name = ref:get_player_name()
		local inv = minetest.get_inventory({type="player", name = name})
		for i = 1, inv:get_size("main") do
			local stack = inv:get_stack("main", i)
			if pclasses.datas.reserved_items[stack:get_name()] then
				local drop_stack = true
				for class in pairs(pclasses.datas.reserved_items) do
					if pclasses.api.get_player_class(name) == class then
						drop_stack = false
					end
				end
				if drop_stack then
					inv:set_stack("main", i, "")
					local pos = ref:getpos()
					pos.y = pos.y+2
					pos.x = pos.x + math.random(-10,10)
					pos.z = pos.z + math.random(-10,10)
					minetest.after(1, function()
						local item = minetest.add_item(pos, stack)
						if item then
							item:setvelocity({x = math.random(-10,10), y = math.random(1,7), z = math.random(-10,10)})
						end
					end)
				end
			end
		end
	end
end)
