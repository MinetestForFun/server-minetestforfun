-- This file provides the actual flow and pathfinding logic that makes water
-- move through the pipes.
--
-- Contributed by mauvebic, 2013-01-03, rewritten a bit by Vanessa Ezekowitz
--

local finitewater = minetest.setting_getbool("liquid_finite")

pipeworks.check_for_liquids = function(pos)
	local coords = {
		{x=pos.x,y=pos.y-1,z=pos.z},
		{x=pos.x,y=pos.y+1,z=pos.z},
		{x=pos.x-1,y=pos.y,z=pos.z},
		{x=pos.x+1,y=pos.y,z=pos.z},
		{x=pos.x,y=pos.y,z=pos.z-1},
		{x=pos.x,y=pos.y,z=pos.z+1},	}
	for i =1,6 do
		local name = minetest.get_node(coords[i]).name
		if name and string.find(name,"water") then
			if finitewater then minetest.remove_node(coords[i]) end
			return true
		end
	end
	return false
end

pipeworks.check_for_inflows = function(pos,node)
	local coords = {
		{x=pos.x,y=pos.y-1,z=pos.z},
		{x=pos.x,y=pos.y+1,z=pos.z},
		{x=pos.x-1,y=pos.y,z=pos.z},
		{x=pos.x+1,y=pos.y,z=pos.z},
		{x=pos.x,y=pos.y,z=pos.z-1},
		{x=pos.x,y=pos.y,z=pos.z+1},	}
	local newnode = false
	local source = false
	for i =1,6 do
		if newnode then break end
		local name = minetest.get_node(coords[i]).name
		if name and (name == "pipeworks:pump_on" and pipeworks.check_for_liquids(coords[i])) or string.find(name,"_loaded") then
			if string.find(name,"_loaded") then
				source = minetest.get_meta(coords[i]):get_string("source")
				if source == minetest.pos_to_string(pos) then break end
			end
			newnode = string.gsub(node.name,"empty","loaded")
			source = {x=coords[i].x,y=coords[i].y,z=coords[i].z}
		end
	end
	if newnode then 
		minetest.add_node(pos,{name=newnode, param2 = node.param2}) 
		minetest.get_meta(pos):set_string("source",minetest.pos_to_string(source))
	end
end

pipeworks.check_sources = function(pos,node)
	local sourcepos = minetest.string_to_pos(minetest.get_meta(pos):get_string("source"))
	if not sourcepos then return end
	local source = minetest.get_node(sourcepos).name
	local newnode = false
	if source and not ((source == "pipeworks:pump_on" and pipeworks.check_for_liquids(sourcepos)) or string.find(source,"_loaded") or source == "ignore" ) then
		newnode = string.gsub(node.name,"loaded","empty")
	end

	if newnode then 
		minetest.add_node(pos,{name=newnode, param2 = node.param2}) 
		minetest.get_meta(pos):set_string("source","")
	end
end

pipeworks.spigot_check = function(pos, node)
	local belowname = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name
	if belowname and (belowname == "air" or belowname == "default:water_flowing" or belowname == "default:water_source") then 
		local spigotname = minetest.get_node(pos).name
		local fdir=node.param2
		local check = {
			{x=pos.x,y=pos.y,z=pos.z+1},
			{x=pos.x+1,y=pos.y,z=pos.z},
			{x=pos.x,y=pos.y,z=pos.z-1},
			{x=pos.x-1,y=pos.y,z=pos.z}
		}
		local near_node = minetest.get_node(check[fdir+1])
		if near_node and string.find(near_node.name, "_loaded") then
			if spigotname and spigotname == "pipeworks:spigot" then
				minetest.add_node(pos,{name = "pipeworks:spigot_pouring", param2 = fdir})
				if finitewater or belowname ~= "default:water_source" then
					minetest.add_node({x=pos.x,y=pos.y-1,z=pos.z},{name = "default:water_source"})
				end
			end
		else
			if spigotname == "pipeworks:spigot_pouring" then
				minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name = "pipeworks:spigot", param2 = fdir})
				if belowname == "default:water_source" and not finitewater then
					minetest.remove_node({x=pos.x,y=pos.y-1,z=pos.z})
				end
			end
		end
	end
end

pipeworks.fountainhead_check = function(pos, node)
	local abovename = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z}).name
	if abovename and (abovename == "air" or abovename == "default:water_flowing" or abovename == "default:water_source") then 
		local fountainhead_name = minetest.get_node(pos).name
		local near_node = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
		if near_node and string.find(near_node.name, "_loaded") then
			if fountainhead_name and fountainhead_name == "pipeworks:fountainhead" then
				minetest.add_node(pos,{name = "pipeworks:fountainhead_pouring"})
				if finitewater or abovename ~= "default:water_source" then
					minetest.add_node({x=pos.x,y=pos.y+1,z=pos.z},{name = "default:water_source"})
				end
			end
		else
			if fountainhead_name == "pipeworks:fountainhead_pouring" then
				minetest.add_node({x=pos.x,y=pos.y,z=pos.z},{name = "pipeworks:fountainhead"})
				if abovename == "default:water_source" and not finitewater then
					minetest.remove_node({x=pos.x,y=pos.y+1,z=pos.z})
				end
			end
		end
	end
end
