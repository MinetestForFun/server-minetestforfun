--[[
--==============================
--==========================================================
LazyJ's Fork of Splizard's "Snow Biomes" Mod
by LazyJ
version: Umpteen-hundred and 7/5ths something or another.
2014_04_12

~~~

"Snow Biomes" Mod
By Splizard

Download:
http//forum.minetest.net/viewtopic.php?id=2290
http://github.com/Splizard/minetest-mod-snow/

--==========================================================
--==============================

   Snow Biomes

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
]]--



-- Original Lua Files
--dofile(minetest.get_modpath("snow").."/util.lua")
--dofile(minetest.get_modpath("snow").."/mapgen.lua")
--dofile(minetest.get_modpath("snow").."/sled.lua")
-- "falling_snow.lua" disabled since weather functions minetest.get_heat(pos) and minetest.get_humidity(pos)
-- have been removed from Minetest.
--  Until something else can be figured out, use paramat's "Snowdrift" mod instead.
-- dofile(minetest.get_modpath("snow").."/falling_snow.lua")

-- Original init.lua File Broken into Smaller Files
dofile(minetest.get_modpath("snow").."/src/abms.lua")
dofile(minetest.get_modpath("snow").."/src/aliases.lua")
dofile(minetest.get_modpath("snow").."/src/crafting.lua")
dofile(minetest.get_modpath("snow").."/src/snowball.lua")


-- The formspec menu didn't work when util.lua was the very first "dofile" so I moved
-- it and all the other original "dofiles", in order, to the bottom of the list. ~ LazyJ
-- Minetest would crash if the mapgen was called upon before the rest of other snow lua files so
-- I put it lower on the list and that seems to do the trick. ~ LazyJ
dofile(minetest.get_modpath("snow").."/src/util.lua")
-- To get Xmas tree saplings, the "christmas_content", true or false, in "util.lua" has to be determined first.
-- That means "nodes.lua", where the saplings are controlled, has to come after "util.lua". ~ LazyJ
dofile(minetest.get_modpath("snow").."/src/nodes.lua")
dofile(minetest.get_modpath("snow").."/aliases.lua")
dofile(minetest.get_modpath("snow").."/src/basic_stairs_slabs.lua")
-- dofile(minetest.get_modpath("snow").."/src/mapgen.lua")
dofile(minetest.get_modpath("snow").."/src/sled.lua")
-- dofile(minetest.get_modpath("snow").."/src/falling_snow.lua")



-- Check for "MoreBlocks". If not found, skip this next "dofile".

if minetest.get_modpath("moreblocks") then

	dofile(minetest.get_modpath("snow").."/src/stairsplus.lua")

end

--This function places snow checking at the same time for snow level and increasing as needed.
--This also takes into account sourrounding snow and makes snow even.
function snow.place(pos)
	if pos.y < -19000 then return end -- Don't put anything in the nether!
	local node = minetest.get_node_or_nil(pos)

	--Oops, maybe there is no node?
	if not node
	or not minetest.registered_nodes[node.name] then
		return
	end

	local bnode = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})
	if node.name == "default:snow" then
		local level = minetest.get_node_level(pos)
		if level < 63 then
			if minetest.get_item_group(bnode.name, "leafdecay") == 0
			and not snow.is_uneven(pos) then
				minetest.sound_play("default_snow_footstep", {pos=pos})
				minetest.add_node_level(pos, 7)
			end
		elseif level == 63 then
			local p = minetest.find_node_near(pos, 10, "default:dirt_with_grass")
			if p
			and minetest.get_node_light(p, 0.5) == 15 then
				minetest.sound_play("default_grass_footstep", {pos=pos})
				minetest.place_node({x=pos.x, y=pos.y+1, z=pos.z}, {name="default:snow"})
			else
				minetest.sound_play("default_snow_footstep", {pos=pos})
				minetest.add_node(pos, {name="default:snowblock"})
			end
		end
	elseif node.name ~= "default:ice"
	and bnode.name ~= "air" then
		local data = minetest.registered_nodes[node.name]
		local drawtype = data.drawtype
		if drawtype == "normal"
		or drawtype == "allfaces_optional" then
			pos.y = pos.y+1
			local sound = data.sounds
			if sound then
				sound = sound.footstep
				if sound then
					minetest.sound_play(sound.name, {pos=pos, gain=sound.gain})
				end
			end
			minetest.place_node(pos, {name="default:snow"})
		elseif drawtype == "plantlike" then
			pos.y = pos.y - 1
			if minetest.get_node(pos).name == "default:dirt_with_grass" then
				minetest.sound_play("default_grass_footstep", {pos=pos})
				minetest.add_node(pos, {name="default:dirt_with_snow"})
			end
		end
	end
end

-- Checks if the snow level is even at any given pos.
-- Smooth Snow
local function is_uneven(pos)
	local num = minetest.get_node_level(pos)
	local get_node = minetest.get_node
	local add_node = minetest.add_node
	local found
	local foundx
	local foundy
	local foundz
	for z = -1,1 do
		for x = -1,1 do
			local p = {x=pos.x+x, y=pos.y, z=pos.z+z}
			local node = get_node(p)
			p.y = p.y-1
			local bnode = get_node(p)

			if node
			and minetest.registered_nodes[node.name]
			and minetest.registered_nodes[node.name].drawtype == "plantlike"
			and bnode.name == "default:dirt_with_grass" then
				add_node(p, {name="default:dirt_with_snow"})
				return true
			end

			p.y = p.y+1
			if not (x == 0 and z == 0)
			and node.name == "default:snow"
			and minetest.get_node_level(p) < num then
				found = true
				foundx = x
				foundz = z
			elseif node.name == "air"
			and bnode.name ~= "air"
			and bnode.name ~= "default:snow" then
				p.y = p.y-1
				snow.place(p)
				return true
			end
		end
	end
	if found then
		local p = {x=pos.x+foundx, y=pos.y, z=pos.z+foundz}
		if is_uneven(p) ~= true then
			minetest.add_node_level(p, 7)
		end
		return true
	end
end

function snow.is_uneven(pos)
	if snow.smooth_snow then
		return is_uneven(pos)
	end
end
