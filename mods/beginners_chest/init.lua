--[[
	Beginners_chest mod
		Put some useful stuff in chests for the new players
		
	Version : 1.1 - 11/8/2014_14h48UTC
	Last modification by Mg on the : 11/8/2014 @ 14h48 UTC
		
	Mod ßý Mg, based on an idea of MinetestForFun/Darcidride
]]--

local chests = {
  [1] = {
    position = {x = 5, y = 40, z = -1},
    interval_max = 3600,
	stuff = {
		[1] = "3d_armor:boots_steel",
		[2] = "default:pick_stone",
		[3] = "default:sword_stone",
		[32] = ""
	}
  },
  [2] = {
    position = {x = 34, y = 20, z = 101},
    interval_max = 600,
    stuff = {
		[1] = "3d_armor:steel_chest",
		[2] = "throwing:bow_stone",
		[3] = "default:sword_stone",
		[4] = "farming:carrot 3",
		[32] = ""
    }
  },
   [3] = {
    position = {x = -36, y = 503, z = -14},
    interval_max = 5*60,
    stuff = {
		[1] = "default:apple 10",
		[32] = ""
    }
  },
  [4] = {
    position = {x = -44, y = 503, z = -27},
    interval_max = 5*60,
    stuff = {
		[1] = "default:apple 10",
		[32] = ""
    }
  },
  [5] = {
    position = {x = 22, y = 504, z = -28},
    interval_max = 30*60,
    stuff = {
		[1] = "3d_armor:diamond_chest",
		[2] = "default:sword_diamond",
		[3] = "default:apple 10",
		[4] = "colormachine:colormachine",
		[32] = ""
    }
  },
  [6] = {
    position = {x = -12, y = 589, z = -16},
    interval_max = 30*60,
    stuff = {
		[1] = "maptools:gold_coin",
		[2] = "default:mese",
		[3] = "3d_armor:boots_mithril",
		[4] = "maptools:superapple 5",
		[32] = ""
    }
  },
  [7] = {
    position = {x = 6, y = 593, z = -26},
    interval_max = 5*60,
    stuff = {
		[1] = "default:apple 10",
		[32] = ""
    }
  },
  [8] = {
    position = {x = 13, y = 581, z = -26},
    interval_max = 30*60,
    stuff = {
		[1] = "default:obsidianbrick",
		[2] = "default:nyancat 5",
		[3] = "maptools:gold_coin 5",
		[4] = "default:axe_nyan",
		[5] = "maptools:superapple 10",
		[32] = ""
    }
  },
  [9] = {
    position = {x = 25, y = 550, z = -8},
    interval_max = 5*60,
    stuff = {
		[1] = "default:apple 10",
		[32] = ""
    }
  },
  [10] = {
    position = {x = 32, y = 550, z = 5},
    interval_max = 5*60,
    stuff = {
		[1] = "default:apple 20",
		[2] = "maptools:superapple 10",
		[32] = ""
    }
  },
  [11] = {
    position = {x = 65, y = 505, z = 64},
    interval_max = 5*60,
    stuff = {
		[1] = "homedecor:trophy",
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
			local node = minetest.get_node(chests[i].position)
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

				local meta = minetest.get_meta(chests[i].position)
				local inv = meta:get_inventory()
				inv:set_list("main", chests[i].stuff)

				minetest.log("action","[b_chest]["..i.."] Chest reloaded at "..chests[i].position.x..", "..chests[i].position.y..", "..chests[i].position.z)
				
			else
				minetest.log("action","[b_chest]["..i.."] Cannot reload chest at "..chests[i].position.x..", "..chests[i].position.y..", "..chests[i].position.z.." : area not loaded.")
			end
		end
		i = i + 1
	end

end)
