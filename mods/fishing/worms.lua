-----------------------------------------------------------------------------------------------
-- Fishing - crabman77's version
-- Rewrited from original Fishing - Mossmanikin's version - Worm 0.0.2
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
	description = fishing_setting.func.S("Worm"),
	groups = { fishing_bait=1 },
	inventory_image = "fishing_bait_worm.png",
	on_use = minetest.item_eat(1),
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
		minetest.add_entity({x=pt.under.x, y=pt.under.y+0.6, z=pt.under.z}, "fishing:bait_worm_entity")
		itemstack:take_item()
		return itemstack
	end,
	on_drop = function(itemstack, dropper, pos)
		minetest.add_entity({x = pos.x, y = pos.y, z = pos.z}, "fishing:bait_worm_entity")
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
	textures = { "fishing_bait_worm.png", "fishing_bait_worm.png"},
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
		-- despawn when no player in range
		local remove_entity = true
		for _,player in pairs(minetest.get_connected_players()) do
			local p = player:getpos()
			local dist = ((p.x-pos.x)^2 + (p.y-pos.y)^2 + (p.z-pos.z)^2)^0.5
			if dist < 25 then
				remove_entity = false
				break
			end
		end
		if remove_entity then
			self.object:remove()
			return
		end
		local n = minetest.get_node({x=pos.x,y=pos.y-0.3,z=pos.z})
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
				if minetest.get_item_group(minetest.get_node({x=pos.x,y=pos.y-0.1,z=pos.z}).name, "soil") == 0 and self.object:get_hp() > 200 then
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
				local goal_01 = check_group(minetest.get_node({x = pos.x + 1, y = pos.y-0.4, z = pos.z	  }).name, "soil")
				local goal_02 = check_group(minetest.get_node({x = pos.x, 	  y = pos.y-0.4, z = pos.z + 1}).name, "soil")
				local goal_03 = check_group(minetest.get_node({x = pos.x - 1, y = pos.y-0.4, z = pos.z	  }).name, "soil")
				local goal_04 = check_group(minetest.get_node({x = pos.x, 	  y = pos.y-0.4, z = pos.z - 1}).name, "soil")

				local goal_1a = check_group(minetest.get_node({x = pos.x + 1, y = pos.y+0.6, z = pos.z	  }).name, "soil")
				local goal_2a = check_group(minetest.get_node({x = pos.x, 	  y = pos.y+0.6, z = pos.z + 1}).name, "soil")
				local goal_3a = check_group(minetest.get_node({x = pos.x - 1, y = pos.y+0.6, z = pos.z	  }).name, "soil")
				local goal_4a = check_group(minetest.get_node({x = pos.x, 	  y = pos.y+0.6, z = pos.z - 1}).name, "soil")
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

-- Bait Worm Entity
minetest.register_craft({
	output = "fishing:bait_worm_entity 8",
	recipe = {
		{"default:dirt"},
		{"default:dirt"},
	}
})

-----------------------------------------------------------------------------------------------
-- GETTING WORMS
-----------------------------------------------------------------------------------------------
-- get worms from digging in dirt:
if fishing_setting.settings["new_worm_source"] == false then
	minetest.register_node(":default:dirt", {
		description = fishing_setting.func.S("Dirt"),
		tiles = {"default_dirt.png"},
		is_ground_content = true,
		groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults(),
		after_dig_node = function (pos, oldnode, oldmetadata, digger)
				if math.random(1, 100) <= fishing_setting.settings["worm_chance"] then
				local tool_in_use = digger:get_wielded_item():get_name()
				if tool_in_use == "" or tool_in_use == "default:dirt" then
					if fishing_setting.settings["worm_is_mob"] == true then
						minetest.add_entity({x = pos.x, y = pos.y+0.4, z = pos.z}, "fishing:bait_worm_entity")
					else
						local inv = digger:get_inventory()
						if inv:room_for_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""}) then
							inv:add_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""})
						end
					end
				end
			end
		end,
	})

else
	-- get worms from digging with hoes:
	-- turns nodes with group soil=1 into soil
	local function hoe_on_use(itemstack, user, pointed_thing, uses)
		local pt = pointed_thing
		-- check if pointing at a node
		if not pt or pt.type ~= "node" then
			return
		end

		local under = minetest.get_node(pt.under)
		local upos = pointed_thing.under

		if minetest.is_protected(upos, user:get_player_name()) then
			minetest.record_protection_violation(upos, user:get_player_name())
			return
		end

		local p = {x=pt.under.x, y=pt.under.y+1, z=pt.under.z}
		local above = minetest.get_node(p)

		-- return if any of the nodes is not registered
		if not minetest.registered_nodes[under.name]
		or not minetest.registered_nodes[above.name] then
			return
		end

		-- check if the node above the pointed thing is air
		if above.name ~= "air" then
			return
		end

		-- check if pointing at dirt
		if minetest.get_item_group(under.name, "soil") ~= 1 then
			return
		end
		-- turn the node into soil, wear out item and play sound
		minetest.set_node(pt.under, {name="farming:soil"})
		minetest.sound_play("default_dig_crumbly", {pos = pt.under, gain = 0.5,})

		if math.random(1, 100) < fishing_setting.settings["worm_chance"] then
			if fishing_setting.settings["worm_is_mob"] == true then
				minetest.add_entity({x=pt.under.x, y=pt.under.y+0.4, z=pt.under.z}, "fishing:bait_worm_entity")
			else
				local inv = user:get_inventory()
				if inv:room_for_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""}) then
					inv:add_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""})
				end
			end
		end
		if not minetest.setting_getbool("creative_mode") then
			local tool_name = itemstack:get_name()
			itemstack:add_wear(65535/(uses-1))
			if itemstack:get_wear() == 0 and minetest.get_modpath("invtweak") then
				local index = user:get_wield_index()
				minetest.sound_play("invtweak_tool_break", {pos = user:getpos(), gain = 0.9, max_hear_distance = 5})
				minetest.after(0.20, refill, user, tool_name, index)
			end
		end
		return itemstack
	end


	-- didn't change the hoes, just here because hoe_on_use is local
	minetest.register_tool(":farming:hoe_wood", {
		description = fishing_setting.func.S("Wooden Hoe"),
		inventory_image = "farming_tool_woodhoe.png",
		on_use = function(itemstack, user, pointed_thing)
			return hoe_on_use(itemstack, user, pointed_thing, 30)
		end,
	})
	minetest.register_tool(":farming:hoe_stone", {
		description = fishing_setting.func.S("Stone Hoe"),
		inventory_image = "farming_tool_stonehoe.png",
		on_use = function(itemstack, user, pointed_thing)
			return hoe_on_use(itemstack, user, pointed_thing, 90)
		end,
	})
	minetest.register_tool(":farming:hoe_steel", {
		description = fishing_setting.func.S("Steel Hoe"),
		inventory_image = "farming_tool_steelhoe.png",
		on_use = function(itemstack, user, pointed_thing)
			return hoe_on_use(itemstack, user, pointed_thing, 200)
		end,
	})
	minetest.register_tool(":farming:hoe_bronze", {
		description = fishing_setting.func.S("Bronze Hoe"),
		inventory_image = "farming_tool_bronzehoe.png",
		on_use = function(itemstack, user, pointed_thing)
			return hoe_on_use(itemstack, user, pointed_thing, 220)
		end,
	})
end
