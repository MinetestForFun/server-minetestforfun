
--[[

Copyright (C) 2015 - Auke Kok <sofar@foo-projects.org>

"warps" is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation; either version 2.1
of the license, or (at your option) any later version.

--]]

warps = {}
warps_queue = {}
queue_state = 0
local warps_freeze = 1
-- t = time in usec
-- p = player obj
-- w = warp name

local warp = function(player, dest)
	for i = 1,table.getn(warps) do
		if warps[i].name == dest then
			player:setpos({x = warps[i].x, y = warps[i].y, z = warps[i].z})
			-- MT Core FIXME
			-- get functions don't output proper values for set!
			-- https://github.com/minetest/minetest/issues/2658
			player:set_look_yaw(warps[i].yaw - (math.pi/2))
			player:set_look_pitch(0 - warps[i].pitch)
			minetest.chat_send_player(player:get_player_name(), "Warped to \"" .. dest .. "\"")
			minetest.log("action", player:get_player_name() .. " warped to \"" .. dest .. "\"")
			minetest.sound_play("warps_plop", {
				pos = {x = warps[i].x, y = warps[i].y, z = warps[i].z},
			})
			return
		end
	end
	minetest.chat_send_player(player:get_player_name(), "Unknown warp \"" .. dest .. "\"")
end

do_warp_queue = function()
	if table.getn(warps_queue) == 0 then
		queue_state = 0
		return
	end
	local t = minetest.get_us_time()
	for i = table.getn(warps_queue),1,-1 do
		local e = warps_queue[i]
		if e.p:getpos() then
			if e.p:getpos().x == e.pos.x and e.p:getpos().y == e.pos.y and e.p:getpos().z == e.pos.z then
				if t > e.t then
					warp(e.p, e.w)
					table.remove(warps_queue, i)
				end
			else
				minetest.sound_stop(e.sh)
				minetest.chat_send_player(e.p:get_player_name(), "You have to stand still for " .. warps_freeze .. " seconds!")
				table.remove(warps_queue, i)
			end
		end
	end
	if table.getn(warps_queue) == 0 then
		queue_state = 0
		return
	end
	minetest.after(1, do_warp_queue)
end

local warp_queue_add = function(player, dest)
	table.insert(warps_queue, {
		t = minetest.get_us_time() + ( warps_freeze * 1000000 ),
		pos = player:getpos(),
		p = player,
		w = dest,
		sh = minetest.sound_play("warps_woosh", { pos = player:getpos() })
	})
	minetest.chat_send_player(player:get_player_name(), "Don't move for " .. warps_freeze .. " seconds!")
	if queue_state == 0 then
		queue_state = 1
		minetest.after(1, do_warp_queue)
	end
end

local worldpath = minetest.get_worldpath()

local save = function ()
	local fh,err = io.open(worldpath .. "/warps.txt", "w")
	if err then
		print("No existing warps to read.")
		return
	end
	for i = 1,table.getn(warps) do
		local s = warps[i].name .. " " .. warps[i].x .. " " .. warps[i].y .. " " .. warps[i].z .. " " .. warps[i].yaw .. " " .. warps[i].pitch .. "\n"
		fh:write(s)
	end
	fh:close()
end

local load = function ()
	local fh,err = io.open(worldpath .. "/warps.txt", "r")
	if err then
		minetest.log("action", "[warps] loaded ")
		return
	end
	while true do
		local line = fh:read()
		if line == nil then
			break
		end
		local paramlist = string.split(line, " ")
		local w = {
			name = paramlist[1],
			x = tonumber(paramlist[2]),
			y = tonumber(paramlist[3]),
			z = tonumber(paramlist[4]),
			yaw = tonumber(paramlist[5]),
			pitch = tonumber(paramlist[6])
		}
		table.insert(warps, w)
	end
	fh:close()
	minetest.log("action", "[warps] loaded " .. table.getn(warps) .. " warp location(s)")
end

minetest.register_privilege("warp_admin", {
	description = "Allows modification of warp points",
	give_to_singleplayer = true,
	default = false
})

minetest.register_privilege("warp_user", {
	description = "Allows use of warp points",
	give_to_singleplayer = true,
	default = true
})

minetest.register_chatcommand("setwarp", {
	params = "name",
	description = "Set a warp location to the players location",
	privs = { warp_admin = true },
	func = function(name, param)
		local h = "created"
		for i = 1,table.getn(warps) do
			if warps[i].name == param then
				table.remove(warps, i)
				h = "changed"
				break
			end
		end
		local player = minetest.get_player_by_name(name)
		local pos = player:getpos()
		if not pos then
			return false, "Internal error while getting your position. Please try again later"
		end
		table.insert(warps, { name = param, x = pos.x, y = pos.y, z = pos.z, yaw = player:get_look_yaw(), pitch = player:get_look_pitch() })
		save()
		minetest.log("action", name .. " " .. h .. " warp \"" .. param .. "\": " .. pos.x .. ", " .. pos.y .. ", " .. pos.z)
		return true, h .. " warp \"" .. param .. "\""
	end,
})

minetest.register_chatcommand("delwarp", {
	params = "name",
	description = "Set a warp location to the players location",
	privs = { warp_admin = true },
	func = function(name, param)
		for i = 1,table.getn(warps) do
			if warps[i].name == param then
				table.remove(warps, i)
				minetest.log("action", name .. " removed warp \"" .. param .. "\"")
				return true, "Removed warp \"" .. param .. "\""
			end
		end
		return false, "Unknown warp location \"" .. param .. "\""
	end,
})

minetest.register_chatcommand("listwarps", {
	params = "name",
	description = "List known warp locations",
	privs = { warp_user = true },
	func = function(name, param)
		local s = "List of known warp locations:\n"
		for i = 1,table.getn(warps) do
			s = s .. "- " .. warps[i].name .. "\n"
		end
		return true, s
	end
})

minetest.register_chatcommand("warp", {
	params = "name",
	description = "Warp to a warp location",
	privs = { warp_user = true },
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		warp_queue_add(player, param)
	end
})

minetest.register_node("warps:warpstone", {
	visual = "mesh",
	mesh = "warps_warpstone.obj",
	description = "A Warp Stone",
	tiles = { "warps_warpstone.png" },
	drawtype = "mesh",
	sunlight_propagates = true,
	walkable = false,
	paramtype = "light",
	groups = { choppy=3 },
	light_source = 8,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25,  0.25, 0.5, 0.25}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
			"field[destination;Warp Destination;]")
		meta:set_string("infotext", "Uninitialized Warp Stone")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if not minetest.check_player_privs(sender:get_player_name(), {warp_admin = true}) then
			minetest.chat_send_player(sender:get_player_name(), "You do not have permission to modify warp stones")
			return false
		end
		if not fields.destination then
			return
		end
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
			"field[destination;Warp Destination;" .. fields.destination .. "]")
		meta:set_string("infotext", "Warp stone to " .. fields.destination)
		meta:set_string("warps_destination", fields.destination)
		minetest.log("action", sender:get_player_name() .. " changed warp stone to \"" .. fields.destination .. "\"")
	end,
	on_punch = function(pos, node, puncher, pointed_thingo)
		if puncher:get_player_control().sneak and minetest.check_player_privs(puncher:get_player_name(), {warp_admin = true}) then
			minetest.remove_node(pos)
			minetest.chat_send_player(puncher:get_player_name(), "Warp stone removed!")
			return
		end
		local meta = minetest.get_meta(pos)
		local destination = meta:get_string("warps_destination")
		if destination == "" then
			minetest.chat_send_player(puncher:get_player_name(), "Unknown warp location for this warp stone, cannot warp!")
			return false
		end
		warp_queue_add(puncher, destination)
	end,
})

-- load existing warps
load()

