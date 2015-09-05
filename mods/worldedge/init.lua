--------------
-- TODO: Check for terrain height

-- Defines the edge of a world
local edge = 30000
-- Radius which should be checked for a good teleportation place
local radius = 2
--------------

local count = 0
local waiting_list = {}
--[[ Explanation of waiting_list table
	Index = Player name
	Value = {
		player = Player to teleport
		pos = Destination
		obj = Attacked entity
		notified = When the player must wait longer...
	}
]]

local function tick()
	for k, v in pairs(waiting_list) do
		if v.player and v.player:is_player() then
			local pos = get_surface_pos(v.pos)
			if pos then
				v.obj:setpos(pos)
				minetest.after(0.2, function(p, o)
					p:set_detach()
					o:remove()
				end, v.player, v.obj)
				waiting_list[k] = nil
			elseif not v.notified then
				v.notified = true
				minetest.chat_send_player(k, "Sorry, we have not found a free place yet. Please be patient.")
			end
		else
			v.obj:remove()
			waiting_list[k] = nil
		end
	end

	local newedge = edge - 5
	-- Check if the players are near the edge and teleport them
	local players = minetest.get_connected_players()
	for i, player in ipairs(players) do
		local name = player:get_player_name()
		if not waiting_list[name] then
			local pos = vector.round(player:getpos())

			-- Sanity check for insane coordinates
			if pos.x > 31000 or pos.y > 31000 or pos.z > 31000
				or pos.x < -31000 or pos.y < -31000 or pos.z < -31000 then
				-- Move to spawn asap
				-- The server probably set invalid/insane coordinates. We have not saved the previous ones,
				-- So we need to teleport the player to the spawn to save them from an endless loop of
				-- Teleportation.
				local spawn = minetest.string_to_pos(minetest.setting_get("static_spawnpoint") or "0,0,0")
				minetest.chat_send_player(player:get_player_name(), "An internal error has occured. Your coordinates were corrupted. You are now teleported to the spawn." ..
					" Please report it to any staff member.")
				minetest.log("error", "[WorldEdge] Corrupted position detected for player " .. player:get_player_name())
				player:setpos(spawn)
			else -- Indent skipped, too many lines to change... We'll wait for "continue" to be introduced in Lua5.2

			local newpos = nil
			if pos.x >= edge then
				newpos = {x = -newedge, y = 10, z = pos.z}
			elseif pos.x <= -edge then
				newpos = {x = newedge, y = 10, z = pos.z}
			end

			if pos.z >= edge then
				newpos = {x = pos.x, y = 10, z = -newedge}
				if get_surface_pos(newpos) then
					newpos.y = get_surface_pos(newpos).y+1 -- /MFF (Mg|19/05//15)
				end -- /MFF (Mg|14/07/15)
			elseif pos.z <= -edge then
				newpos = {x = pos.x, y = 10, z = newedge}
				if get_surface_pos(newpos) then
					newpos.y = get_surface_pos(newpos).y+1 -- /MFF (Mg|19/05/15)
				end -- /MFF (Mg|14/07/15)
			end

			-- Teleport the player
			if newpos then
				minetest.chat_send_player(name, "Please wait a few seconds. We will teleport you soon.")
				local obj = minetest.add_entity(newpos, "worldedge:lock")
				player:set_attach(obj, "", {x=0, y=0, z=0}, {x=0, y=0, z=0})
				waiting_list[name] = {
					player = player,
					pos = newpos,
					obj = obj
				}
				obj:setpos(newpos)
			end
			end
		end
	end
	minetest.after(3, tick)
end
tick()

function get_surface_pos(pos)
	local minp = {
		x = pos.x - radius - 1,
		y = -10,
		z = pos.z - radius - 1
	}
	local maxp = {
		x = pos.x + radius - 1,
		y = 50,
		z = pos.z + radius - 1
	}

	local c_air = minetest.get_content_id("air")
	local c_ignore = minetest.get_content_id("ignore")

	local vm = minetest.get_voxel_manip()
	local emin, emax = vm:read_from_map(minp, maxp)
	local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
	local data = vm:get_data()

	local seen_air = false
	local deepest_place = vector.new(pos)
	deepest_place.y = 50

	for x = minp.x, maxp.x do
	for z = minp.z, maxp.z do
		local solid = 0
		for y = deepest_place.y, -10, -1 do
			local node = data[area:index(x, y, z)]
			if y < deepest_place.y and node == c_air then
				deepest_place = vector.new(x, y, z)
				seen_air = true
			end
			if solid > 5 then
				-- Do not find caves!
				break
			end
			if node ~= c_air and node ~= c_ignore then
				solid = solid + 1
			end
		end
	end
	end

	if seen_air then
		return deepest_place
	else
		return false
	end
end

minetest.register_entity("worldedge:lock", {
	initial_properties = {
		is_visible = false
	},
	on_activate = function(staticdata, dtime_s)
		--self.object:set_armor_groups({immortal = 1})
	end
})
