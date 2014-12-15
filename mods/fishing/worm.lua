-----------------------------------------------------------------------------------------------
-- Fishing - Mossmanikin's version - Worm 0.0.2
-----------------------------------------------------------------------------------------------
-- License (code & textures): 	WTFPL
-- Contains code from: 		fishing (original), mobs
-- Looked at code from:		my_mobs
-- Dependencies: 			default
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-- WORM ITEM
-----------------------------------------------------------------------------------------------
minetest.register_craftitem("fishing:bait_worm", {
	description = "Worm",
    groups = { fishing_bait=1 },
    inventory_image = "fishing_worm.png",
	on_use = minetest.item_eat(1),
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
		minetest.env:add_entity({x=pt.under.x, y=pt.under.y+0.6, z=pt.under.z}, "fishing:bait_worm_entity")
		itemstack:take_item()
		return itemstack
	end,
	on_drop = function(itemstack, dropper, pos)
		minetest.env:add_entity({x = pos.x, y = pos.y, z = pos.z}, "fishing:bait_worm_entity")
		itemstack:take_item()
		return itemstack
	end,
})

-----------------------------------------------------------------------------------------------
-- WORM MOB
-----------------------------------------------------------------------------------------------
minetest.register_entity("fishing:bait_worm_entity", {
	hp_max = 300,
	damage_over_time = 1,
	collisionbox = {-3/16, -3/16, -3/16, 3/16, 3/16, 3/16},
	visual = "sprite",
	visual_size = {x=1/2, y=1/2},
	textures = { "fishing_worm.png", "fishing_worm.png"},
	view_range = 32,
	-- Don't punch this poor creature...
	on_punch = function(self, puncher)
		self.object:remove()
	end,
	-- ...softly take it into your hand.
	on_rightclick = function(self, clicker)
		if clicker:is_player() and clicker:get_inventory() then
			clicker:get_inventory():add_item("main", "fishing:bait_worm")
			self.object:remove()
		end
	end,
	-- AI :D
	on_step = function(self, dtime)
		local pos = self.object:getpos()
		local n = minetest.env:get_node({x=pos.x,y=pos.y-0.3,z=pos.z})
		-- despawn when no player in range
		for _,player in pairs(minetest.get_connected_players()) do
			local s = self.object:getpos()
			local p = player:getpos()
			local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
			if dist > self.view_range then
				self.object:remove()
			end
		end	
		-- move in world
		local look_whats_up = function(self)
			self.object:set_hp(self.object:get_hp()-self.damage_over_time) -- creature is getting older
			if n.name == "air" then -- fall when in air
				self.object:moveto({x=pos.x,y=pos.y-0.5,z=pos.z})
				self.object:set_hp(self.object:get_hp()-75)
				
			--if n.name == "snappy" then -- fall when leaves or similar
			elseif minetest.get_item_group(n.name, "snappy") ~= 0 then
				self.object:moveto({x=pos.x+(0.001*(math.random(-32, 32))),y=pos.y-(0.001*(math.random(0, 64))),z=pos.z+(0.001*(math.random(-32, 32)))})
				
				
			elseif string.find(n.name, "default:water") then -- sink when in water
				self.object:moveto({x=pos.x,y=pos.y-0.25,z=pos.z})
				self.object:set_hp(self.object:get_hp()-37)
			
			elseif minetest.get_item_group(n.name, "soil") ~= 0 then
				if minetest.get_item_group(minetest.env:get_node({x=pos.x,y=pos.y-0.1,z=pos.z}).name, "soil") == 0 and self.object:get_hp() > 200 then
					self.object:set_hp(199)
				elseif self.object:get_hp() > 200 then -- leave dirt to see whats going on
					self.object:moveto({x=pos.x+(0.001*(math.random(-2, 2))),y=pos.y+0.003,z=pos.z+(0.001*(math.random(-2, 2)))})
				elseif self.object:get_hp() < 199 then -- no rain here, let's get outa here
					self.object:moveto({x=pos.x+(0.001*(math.random(-2, 2))),y=pos.y-0.001,z=pos.z+(0.001*(math.random(-2, 2)))})
				elseif self.object:get_hp() == 0 then
					self.object:remove()
				end
			else -- check if there's dirt anywhere (not finished)
				local check_group = minetest.get_item_group
				local goal_01 = check_group(minetest.env:get_node({x = pos.x + 1, y = pos.y-0.4, z = pos.z	  }).name, "soil")
				local goal_02 = check_group(minetest.env:get_node({x = pos.x, 	  y = pos.y-0.4, z = pos.z + 1}).name, "soil")
				local goal_03 = check_group(minetest.env:get_node({x = pos.x - 1, y = pos.y-0.4, z = pos.z	  }).name, "soil")
				local goal_04 = check_group(minetest.env:get_node({x = pos.x, 	  y = pos.y-0.4, z = pos.z - 1}).name, "soil")
				
				local goal_1a = check_group(minetest.env:get_node({x = pos.x + 1, y = pos.y+0.6, z = pos.z	  }).name, "soil")
				local goal_2a = check_group(minetest.env:get_node({x = pos.x, 	  y = pos.y+0.6, z = pos.z + 1}).name, "soil")
				local goal_3a = check_group(minetest.env:get_node({x = pos.x - 1, y = pos.y+0.6, z = pos.z	  }).name, "soil")
				local goal_4a = check_group(minetest.env:get_node({x = pos.x, 	  y = pos.y+0.6, z = pos.z - 1}).name, "soil")
				-- if there's dirt nearby, go there
				if     goal_01 ~= 0 or goal_1a ~= 0 then
					self.object:moveto({x=pos.x+0.002,y=pos.y,z=pos.z+(0.001*(math.random(-2, 2)))})	
				elseif goal_02 ~= 0 or goal_2a ~= 0 then
					self.object:moveto({x=pos.x+(0.001*(math.random(-2, 2))),y=pos.y,z=pos.z+0.002})	
				elseif goal_03 ~= 0 or goal_3a ~= 0 then
					self.object:moveto({x=pos.x-0.002,y=pos.y,z=pos.z+(0.001*(math.random(-2, 2)))})	
				elseif goal_04 ~= 0 or goal_4a ~= 0 then
					self.object:moveto({x=pos.x+(0.001*(math.random(-2, 2))),y=pos.y,z=pos.z-0.002})	
				else -- I'm lost, no dirt
					self.object:moveto({x=pos.x+(0.001*(math.random(-8, 8))),y=pos.y,z=pos.z+(0.001*(math.random(-8, 8)))})	
				end
			end	
		end
		look_whats_up(self)
	end,
})