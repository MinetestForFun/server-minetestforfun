-----------------------------------------------------------------------------------------------
-- Fishing - crabman77's version - Bobber
-- Rewrited from original Fishing - Mossmanikin's version - Bobber 0.1.7
-- License (code & textures): 	WTFPL
-- Contains code from: 		fishing (original), mobs, throwing, volcano
-- Supports:				3d_armor, animal_clownfish, animal_fish_blue_white, animal_rat, flowers_plus, mobs, seaplants
-----------------------------------------------------------------------------------------------

-- bobber
minetest.register_node("fishing:bobber_box", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
--			{ left, bottom, front,  right, top ,  back}
			{-8/16, -8/16,     0,  8/16,  8/16,     0}, -- feathers
			{-2/16, -8/16, -2/16,  2/16, -4/16,  2/16}, -- bobber
		},
	},
	tiles = {
		"fishing_bobber_top.png",
		"fishing_bobber_bottom.png",
		"fishing_bobber.png",
		"fishing_bobber.png",
		"fishing_bobber.png",
		"fishing_bobber.png^[transformFX"
	}, --
	groups = {not_in_creative_inventory=1},
})


local FISHING_BOBBER_ENTITY={
	hp_max = 605,
	water_damage = 1,
	physical = true,
	timer = 0,
	env_damage_timer = 0,
	visual = "wielditem",
	visual_size = {x=1/3, y=1/3, z=1/3},
	textures = {"fishing:bobber_box"},
	--             {left ,bottom, front, right,  top ,  back}
	collisionbox = {-2/16, -4/16, -2/16,  2/16, 1/16,  2/16},
	randomtime = 50,
	baitball = 0,
	prize = "",
	bait = "",

--  DESTROY BOBBER WHEN PUNCHING IT
	on_punch = function (self, puncher, time_from_last_punch, tool_capabilities, dir)
		if not puncher:is_player() then return end
		local player = puncher:get_player_name()
		if playername ~= self.owner then return end
		if fishing_setting.settings["message"] == true then minetest.chat_send_player(playername, fishing_setting.func.S("You didn't catch anything."), false) end
		if not fishing_setting.is_creative_mode then
			local inv = puncher:get_inventory()
			if inv:room_for_item("main", {name=self.bait, count=1, wear=0, metadata=""}) then
				inv:add_item("main", {name=self.bait, count=1, wear=0, metadata=""})
				if fishing_setting.settings["message"] == true then minetest.chat_send_player(playername, fishing_setting.func.S("The bait is still there."), false) end
			end
		end
		-- make sound and remove bobber
		minetest.sound_play("fishing_bobber1", { pos = self.object:getpos(), gain = 0.5, })
		self.object:remove()
	end,


-- WHEN RIGHTCLICKING THE BOBBER THE FOLLOWING HAPPENS (CLICK AT THE RIGHT TIME WHILE HOLDING A FISHING POLE)
	on_rightclick = function (self, clicker)
		local item = clicker:get_wielded_item()
		local playername = clicker:get_player_name()
		local inv = clicker:get_inventory()
		local pos = self.object:getpos()
		local item_name = item:get_name()
		if string.find(item_name, "fishing:pole_") ~= nil then
			if playername ~= self.owner then return end
			if self.prize ~= "" then
				if math.random(1, 100) <= fishing_setting.settings["escape_chance"] then
					if fishing_setting.settings["message"] == true then minetest.chat_send_player(playername, fishing_setting.func.S("Your fish escaped."), false) end -- fish escaped
				else
					local name = self.prize[1]..":"..self.prize[2]
					local desc = self.prize[4]
					if fishing_setting.settings["message"] == true then minetest.chat_send_player(playername, fishing_setting.func.S("You caught "..desc), false) end
					fishing_setting.func.add_to_trophies(clicker, self.prize[2], desc)
					local wear_value = fishing_setting.func.wear_value(self.prize[3])
					if inv:room_for_item("main", {name=name, count=1, wear=wear_value, metadata=""}) then
						inv:add_item("main", {name=name, count=1, wear=wear_value, metadata=""})
					else
						minetest.spawn_item(clicker:getpos(), {name=name, count=1, wear=wear_value, metadata=""})
					end
				end
			end
			-- weither player has fishing pole or not
			minetest.sound_play("fishing_bobber1", { pos = self.object:getpos(), gain = 0.5, })
			self.object:remove()

		elseif item_name == "fishing:baitball" then
			if not fishing_setting.is_creative_mode then
				inv:remove_item("main", "fishing:baitball")
			end
			self.baitball = 20
			--addparticle
			minetest.add_particlespawner(30, 0.5,   -- for how long (?)             -- Particles on splash
				{x=pos.x,y=pos.y-0.0625,z=pos.z}, {x=pos.x,y=pos.y,z=pos.z}, -- position min, pos max
				{x=-2,y=-0.0625,z=-2}, {x=2,y=3,z=2}, -- velocity min, vel max
				{x=0,y=-9.8,z=0}, {x=0,y=-9.8,z=0},
				0.3, 1.2,
				0.25, 0.5,  -- min size, max size
				false, "fishing_particle_baitball.png")
			-- add sound
			minetest.sound_play("fishing_baitball", {pos = self.object:getpos(), gain = 0.2, })
		end
	end,


-- AS SOON AS THE BOBBER IS PLACED IT WILL ACT LIKE
	on_step = function(self, dtime)
		local pos = self.object:getpos()
		--remove if no owner, no player, owner no in bobber_view_range
		if self.owner == nil then self.object:remove(); return end
		--remove if not node water
		local node = minetest.get_node_or_nil({x=pos.x, y=pos.y-0.5, z=pos.z})
		if not node or string.find(node.name, "water_source") == nil then
			if fishing_setting.settings["message"] == true then minetest.chat_send_player(self.owner, "Haha, Fishing is prohibited outside water!") end
			self.object:remove()
			return
		end
		local player = minetest.get_player_by_name(self.owner)
		if not player then self.object:remove(); return end
		local p = player:getpos()
		local dist = ((p.x-pos.x)^2 + (p.y-pos.y)^2 + (p.z-pos.z)^2)^0.5
		if dist > fishing_setting.settings["bobber_view_range"] then
			minetest.sound_play("fishing_bobber1", {pos = self.object:getpos(),gain = 0.5,})
			self.object:remove()
			return
		end

		--rotate bobber
		if math.random(1, 4) == 1 then
			self.object:setyaw(self.object:getyaw()+((math.random(0,360)-180)/2880*math.pi))
		end

		self.timer = self.timer + 1
		if self.timer < self.randomtime then
			-- if fish or others items, move bobber to simulate fish on the line
			if self.prize ~= "" and math.random(1,3) == 1 then
				if self.old_pos2 == true then
					pos.y = pos.y-0.0325
					self.object:moveto(pos, false)
					self.old_pos2 = false
				else
					pos.y = pos.y+0.0325
					self.object:moveto(pos, false)
					self.old_pos2 = true
				end
			end
			return
		end

		--change item on line
		self.timer = 0
		self.prize = ""
		self.object:moveto(self.old_pos, false)
		--Once the fish are not hungry :), baitball increase hungry + 20%
		if math.random(1, 100) > fishing_setting.baits[self.bait]["hungry"] + self.baitball then
			--Fish not hungry !(
			self.randomtime = math.random(20,60)*10
			return
		end

		self.randomtime = math.random(1,5)*10
		if math.random(1, 100) <= fishing_setting.settings["fish_chance"] then
			self.prize = fishing_setting.prizes["fish"][math.random(1,#fishing_setting.prizes["fish"])]
		else
			if math.random(1, 100) <= 10 then
				self.prize = fishing_setting.func.get_loot()
			end
		end

		if self.prize ~= "" then
			pos.y = self.old_pos.y-0.1
			self.object:moveto(pos, false)
			minetest.sound_play("fishing_bobber1", {pos=pos,gain = 0.5,})
		end
	end,
}

minetest.register_entity("fishing:bobber_fish_entity", FISHING_BOBBER_ENTITY)
