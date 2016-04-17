--[[

Solar Mana mod [solarmana]
==========================

A mana regeneration controller: only regenerate mana in sunlight.

Copyright (C) 2015 Ben Deutsch <ben@bendeutsch.de>

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
USA

]]


local time_total_regen_check = 0.5
local time_next_regen_check = time_total_regen_check

-- TODO: make this globally accessible
local mana_from_node = {
    ['default:goldblock'] = 5,
    ['runes:rune_heal_minor'] = 1,
    ['runes:rune_heal_medium'] = 3,
    ['runes:rune_heal_major'] = 8,
    ['default:wood'] = 1,
    ['default:junglewood'] = 1,
    ['default:pinewood'] = 1,
    ['group:wood'] = 1,
}

-- just for debugging: see below
local time_total_mana_reset = 10.0
local time_next_mana_reset = time_total_mana_reset

local function tick()
	-- We do not care if this does not run as often as possible,
	-- as all it does is change the regeneration to a fixed number
	minetest.after(time_next_regen_check, tick)
	for _,player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local pos  = player:getpos()
		local pos_y = pos.y
		-- the middle of the block with the player's head
		pos.y = math.floor(pos_y) + 1.5
		local node = minetest.get_node(pos)

		-- Currently uses 'get_node_light' to determine whether
		-- a node is "in sunlight".
		local light_day   = minetest.get_node_light(pos, 0.5)
		local light_night = minetest.get_node_light(pos, 0.0)
		local light_now   = minetest.get_node_light(pos) or 0
		local regen_to = 0

		-- simplest version checks for "full sunlight now"
		if light_now >= 14 then
			regen_to = 3
		end

		-- we can get a bit more lenience by testing whether
		-- * a node is "affected by sunlight" (day > night)
		-- * the node is "bright enough now"
		-- However: you could deny yourself mana regeneration
		--          with torches :-/
		--[[
		if light_day > light_night and light_now > 12 then
			regen_to = 1
		end
		--]]

		-- next, check the block we're standing on.
		pos.y = math.floor(pos_y) - 0.5
		node = minetest.get_node(pos)
		local nodemana = mana_from_node[node.name]
		for key, value in pairs(mana_from_node) do
			if key:split(":")[1] == "group" then
				local groupname = key:split(":")[2]
				if minetest.get_item_group(node.name, groupname) > 0 then
					if nodemana then
						nodemana = math.max(nodemana, value) -- We get the greater one (if the node is part of 2 or more groups)
					else
						nodemana = value
					end
				end
			end
		end
		if nodemana then
			if nodemana > 0 then
				regen_to = math.max(regen_to, nodemana)
			else
				regen_to = regen_to + nodemana -- negative, remember?
			end
			--print("Regen to "..regen_to.." : "..node.name)
		end


		mana.setregen(name, regen_to)
		--print("Regen to "..regen_to.." : "..light_day.."/"..light_now.."/"..light_night)
	end

	--[[ Comment this in for testing if you have no mana sink

	time_next_mana_reset = time_next_mana_reset - dtime
	if time_next_mana_reset < 0.0 then
		time_next_mana_reset = time_total_mana_reset
		mana.set('singleplayer', 100)
		print("Resetting mana")
	end

	--]]
end

tick()
