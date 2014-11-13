--[[
	Beginners_chest mod
		Put some useful stuff in chests for the new players
		
	Version : 1.1 - 11/8/2014_14h48UTC
	Last modification by Mg on the : 11/8/2014 @ 14h48 UTC
		
	Mod ßý Mg, based on an idea of MinetestForFun/Darcidride
]]--

chests = {
  [1] = {
    position = {x = 5, y = 40, z = -1},
    interval_timer = 0,
    interval_max = 7200,
	stuff = {
		[1] = "3d_armor:boots_steel",
		[2] = "default:pick_stone",
		[3] = "default:sword_stone",
		[32] = ""
	}
  },
  [2] = {
    position = {x = 34, y = 20, z = 101},
    interval_max = 7200,
    stuff = {
	[1] = "3d_armor:steel_chest",
	[2] = "throwing:bow_stone",
	[3] = "default:sword_stone",
	[4] = "farming:carrot 3",
	[32] = ""
    }
  }
}

minetest.register_globalstep(function(dtime)
	local i = 1
	while i < table.getn(chests)+1 do
		
		if not chests[i].stuff then
			chests[i].stuff = {
				[1] = "default:wood",
				[32] = ""
			}
		end
		if not chests[i].interval_timer then
			chests[i].interval_timer = 0
		end
		if not chests[i].interval_max then 
			chests[i].interval_max = 7200 -- Using default value : 2h
		end
		
		chests[i].interval_timer = chests[i].interval_timer + dtime
		
		if chests[i].position.x and chests[i].position.y and chests[i].position.z and chests[i].interval_timer >= chests[i].interval_max then
			chests[i].interval_timer = 0
			node = minetest.get_node(chests[i].position)
			if node.name ~= "ignore" then
				if node.name ~= "default:chest" then
					if node.name == "air" then
						minetest.add_node(chests[i].position,{name = "default:chest"})
						minetest.log("action","[b_chest]["..i.."] Chest placed at "..chests[i].position.x..", "..chests[i].position.y..", "..chests[i].position.z)
					else
						minetest.log("action","[b_chest]["..i.."] Unable to place chest at "..chests[i].position.x..", "..chests[i].position.y..", "..chests[i].position.z.." : place already in use.")
						break
					end
				end

				meta = minetest.get_meta(chests[i].position)
				inv = meta:get_inventory()
				inv:set_list("main", chests[i].stuff)

				minetest.log("action","[b_chest]["..i.."] Chest reloaded at "..chests[i].position.x..", "..chests[i].position.y..", "..chests[i].position.z)
				
			else
				minetest.log("action","[b_chest]["..i.."] Cannot reload chest at "..chests[i].position.x..", "..chests[i].position.y..", "..chests[i].position.z.." : area not loaded.")
			end
		end
		i = i + 1
	end

end)
