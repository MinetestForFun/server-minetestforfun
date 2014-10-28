
-- walking on ice makes player walk faster, also cactus hurts player when touched
-- by TenPlus1

local time = 0
minetest.register_globalstep(function(dtime)

	time = time + dtime

	-- every 1 second
	if time > 1 then
	
		-- check players
		for _,player in ipairs(minetest.get_connected_players()) do
			
			-- is it me?
			if player:is_player() then

				-- where am I?
				local pos = player:getpos()
				
				-- what am I standing on?
				pos.y = pos.y - 0.1 -- just under player to detect snow also
				local nod = minetest.get_node(pos).name
				
				-- standing on ice? if so walk faster
				if nod == "default:ice" then
					player:set_physics_override(1.3, 1, 1)
				-- standing on snow? if so walk slower
				elseif nod == "default:snow" or nod == "default:snowblock" then
					player:set_physics_override(0.7, 1, 1)
				else
					player:set_physics_override(1, 1, 1) -- (default speed, jump, gravity)
				end
				
				-- am I near a cactus?
				pos.y = pos.y + 0.1
				local near = minetest.find_node_near(pos, 1, "default:cactus")
				if near then
					pos = near
					
					-- am I touching the cactus? if so it hurts
					for _,object in ipairs(minetest.env:get_objects_inside_radius(pos, 1.0)) do
						if object:get_hp() > 0 then
							object:set_hp(object:get_hp()-1)
						end
					end

				end
				
				-- reset time and break entity check
				time = 0
				break
			end
		end
		
		-- incase none of the above happened, reset time for next check
		time = 0
	end
end)
