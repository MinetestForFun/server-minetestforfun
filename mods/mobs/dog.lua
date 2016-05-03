
-- Dog

mobs:register_mob("mobs:dog", {
	-- animal, monster, npc, barbarian
	type = "npc",
	-- agressive, does 4 damage to player when hit
	passive = false,
	attacks_monsters = true,
	attack_type = "dogfight",
	damage = 2, -- 1 damage less than wolf
	-- health & armor
	hp_min = 15, hp_max = 20, armor = 200,
	-- textures and model
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "mobs_wolf.x",
	drawtype = "front",
	textures = {
		{"mobs_dog.png"},
	},
	--visual_size = {x=1,y=1}, --Quel valeur lui mettre ?
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_wolf",
		war_cry = "mobs_wolf_attack",
	},
	-- speed and jump
	walk_velocity = 2,
	run_velocity = 4,
	jump = true,
	stepheight = 1.2,
	step = 1.2,
	view_range = 16,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 2, max = 3,},
	},
	-- damaged by
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	-- Special for pet
	owner = "",
	order = "follow",

	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		local name = clicker:get_player_name()
		if not name then return end
		if item:get_name() == "mobs:meat_raw" then
			local hp = self.object:get_hp()
			-- return if full health
			if hp >= self.hp_max then
				minetest.chat_send_player(name, "Dog at full health.")
				return
			end
			hp = hp + 4	-- add restorative value
			-- new health shouldn't exceed self.hp_max
			if hp > self.hp_max then hp = self.hp_max end
			self.object:set_hp(hp)
			-- Take item
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end
		else
			if self.owner == "" then
				self.owner = clicker:get_player_name()
			else
				if self.order == "follow" then
					self.order = "stand"
				else
					self.order = "follow"
				end
			end
		end
	end,
	-- model animation
	animation = {
		stand_start = 0, stand_end = 14,
		walk_start = 15, walk_end = 38,
		run_start = 40, run_end = 63,
		punch_start = 40, punch_end = 63,
		speed_normal = 15, speed_run = 15,
	},
})
mobs:register_egg("mobs:dog", "Dog", "mobs_dog_inv.png", 1)
