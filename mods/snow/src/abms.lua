--Backwards Compatability.
minetest.register_abm({
	nodenames = {"snow:snow1","snow:snow2","snow:snow3","gsnow4","snow:snow5","snow:snow6","snow:snow7","snow:snow8"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		minetest.add_node(pos,{name="default:snow"})
		minetest.set_node_level(pos, 7*(tonumber(node.name:sub(-1))))
	end,
})



-- Added to change dirt_with_snow to dirt if covered with blocks that don't let light through (sunlight_propagates) or have a light paramtype and liquidtype combination. ~ LazyJ, 2014_03_08

minetest.register_abm({
	nodenames = {"default:dirt_with_snow"},
	interval = 2,
	chance = 20,
	action = function(pos, node)
		local name = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name
		local nodedef = minetest.registered_nodes[name]
		if name ~= "ignore"
		and nodedef
		and not (
			(nodedef.sunlight_propagates or nodedef.paramtype == "light")
			and nodedef.liquidtype == "none"
		) then
			minetest.set_node(pos, {name = "default:dirt"})
		end
	end
})



--Melting
--Any node part of the group melting will melt when near warm nodes such as lava, fire, torches, etc.
--The amount of water that replaces the node is defined by the number on the group:
--1: one water_source
--2: four water_flowings
--3: one water_flowing

minetest.register_abm({
	nodenames = {"group:melts"},
	neighbors = {"group:igniter","default:torch","default:furnace_active","group:hot"},
	interval = 2,
	chance = 2,
	action = function(pos, node)
		local intensity = minetest.get_item_group(node.name,"melts")
		if intensity == 1 then
			minetest.add_node(pos,{name="default:water_source"})
		elseif intensity == 2 then
	 		minetest.add_node(pos,{name="default:water_flowing", param2=7})
		--[[	LazyJ, you need to add param2, which defines the amount of the flowing water ~ HybridDog 2015_03_06
			This was causing "melts=2" nodes to just disappear so I changed it to replace the
			node with a water_source for a couple seconds and then replace the water_source with
			air. This way it made a watery mess that quickly evaporated. ~ LazyJ 2014_04_24
			local check_place = function(pos,node)
				if minetest.get_node(pos).name == "air" then
					minetest.place_node(pos,node)
				end
			end
			minetest.add_node(pos,{name="default:water_flowing"})
			check_place({x=pos.x+1,y=pos.y,z=pos.z},{name="default:water_flowing"})
			check_place({x=pos.x-1,y=pos.y,z=pos.z},{name="default:water_flowing"})
			check_place({x=pos.x,y=pos.y+1,z=pos.z},{name="default:water_flowing"})
			check_place({x=pos.x,y=pos.y-1,z=pos.z},{name="default:water_flowing"})
		elseif intensity == 3 then
		--]
			minetest.add_node(pos,{name="default:water_source"})
				minetest.after(2, function()  -- 2 seconds gives just enough time for
											-- the water to flow and spread before the
											-- water_source is changed to air. ~ LazyJ
					if minetest.get_node(pos).name == "default:water_source" then
	 					minetest.add_node(pos,{name="air"})
	 				end
	 			end)
		--]]
	 	end
		nodeupdate(pos)
	end,
})




--Freezing
--Water freezes when in contact with snow.
minetest.register_abm({
	nodenames = {"default:water_source"},
	 -- Added "group:icemaker" and snowbrick. ~ LazyJ
	neighbors = {"default:snow", "default:snowblock", "snow:snow_brick", "group:icemaker"},
	interval = 20,
	chance = 4,
	action = function(pos)
		minetest.add_node(pos,{name="default:ice"})
	end,
})

--Freeze Ice according to it's param2 value.
minetest.register_abm({
	nodenames = {"default:ice"},
	neighbors = {"default:water_source"},
	interval = 20,
	chance = 4,
	action = function(pos, node)
		if node.param2 > 0 then
			for l = 0,1 do
				for i = -1,1,2 do
					for _,p in pairs({
						{x=pos.x+i, z=pos.z-l*i},
						{x=pos.x+l*i, z=pos.z+i}
					}) do
						if math.random(2) == 2 then
							p.y = pos.y
							if minetest.get_node(p).name == "default:water_source" then
								minetest.add_node(p,{name="default:ice", param2 = math.random(0,node.param2-1)})
							end
						end
					end
				end
			end
			if math.random(8) == 8 then
				minetest.add_node(pos, {name="default:water_source"})
			else
				minetest.add_node(pos, {name="default:ice", param2 = 0})
			end
		end
	end,
})



--Spread moss to cobble.
minetest.register_abm({
	nodenames = {"default:cobble"},
	neighbors = {"snow:moss"},
	interval = 20,
	chance = 6,
	action = function(pos, node)
		node.name = "default:mossycobble"
		minetest.add_node(pos, node)
	end,
})




--Grow Pine Saplings
minetest.register_abm({
	nodenames = {"snow:sapling_pine"},
	interval = 10,
	chance = 50,
	action = function(pos, node)

-- Check if there is enough vertical-space for the sapling to grow without
-- hitting anything else.  ~ LazyJ, 2014_04_10

		-- 'If' there is air in each of the 8 nodes dirctly above the sapling,... ~LazyJ
		for i = 1,8 do
			if minetest.get_node({x=pos.x, y=pos.y+i, z=pos.z}).name ~= "air" then
				return
			end
		end
		-- 'then' let the sapling grow into a tree. ~ LazyJ

		snow.make_pine(pos,false)
		-- This finds the sapling under the grown tree. ~ LazyJ
		if minetest.get_node(pos).name == "snow:sapling_pine" then
			   -- This switches the sapling to a tree trunk. ~ LazyJ
			   minetest.set_node(pos, {name="default:pinetree"})
			   -- This is more for testing but it may be useful info to some admins when
			   -- grepping the server logs too. ~ LazyJ
			   minetest.log("action", "A pine sapling grows into a tree at "..minetest.pos_to_string(pos))
		end
	end
})




--Grow Christmas Tree Saplings
minetest.register_abm({
	nodenames = {"snow:xmas_tree"},
	interval = 10,
	chance = 50,
	action = function(pos, node, active_object_count, active_object_count_wider)

		-- 'If' there is air in each of the 8 nodes dirctly above the sapling,... ~LazyJ
		for i = 1,8 do
			if minetest.get_node({x=pos.x, y=pos.y+i, z=pos.z}).name ~= "air" then
				return
			end
		end
		-- 'then' let the sapling grow into a tree. ~ LazyJ

		snow.make_pine(pos,false,true)
		minetest.log("action", "A pine sapling grows into a Christmas tree at "..minetest.pos_to_string(pos)) -- ~ LazyJ
		--else  -- 'Else', if there isn't air in each of the 8 nodes above the sapling,
				-- then don't anything; including not allowing the sapling to grow.
				-- ~ LazyJ, 2014_04_10
		--end
	end
})
