--[[
	Beginners_chest mod
		Put some useful stuff in a chest for the new players
		
	Mod ßý Mg, based on an idea of MinetestForFun/Darcidride
]]--

chest_position = {x = 5, y = 40, z = -1}
local interval_timer = 0
local interval_max = 10


minetest.register_globalstep(function(dtime)
	interval_timer = interval_timer+dtime
	if interval_timer < interval_max then return end -- We have to wait 2 hours
	
	local chest = minetest.get_node(chest_position)
	if chest.name ~= "default:chest" then
		if chest.name == "ignore" then
			print("[b_chest] Unable to reload chest : area not loaded")
			return
		elseif chest.name ~= "air" then
			print("[b_chest] Unable to place chest : position still used")
			return
		elseif chest.name == "air" then
				minetest.add_node(chest_position,{name = "default:chest"})
				print("[b_chest] Chest placed")
		end
	end
			
	local meta = minetest.get_meta(chest_position)
	local inv = meta:get_inventory()
	inv:set_list("main",{[1] = "3d_armor:boots_steel", [2] = "default:pick_stone", [3] = "default:pick_steel", [32] = ""})
	interval_timer = 0
end)
