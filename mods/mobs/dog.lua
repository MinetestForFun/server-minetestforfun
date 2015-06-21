
-- Dog

mobs:register_mob("mobs:dog", {
	type = "npc",
	passive = true,
	hp_max = 5,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "mobs_wolf.x",
	textures = {
		{"mobs_dog.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		war_cry = "mobs_wolf_attack",
	},
	view_range = 15,
	stepheight = 1.1,
	owner = "",
	order = "follow",
	walk_velocity = 4,
	run_velocity = 4,
	damage = 2,
	armor = 200,
	attacks_monsters = true,
	attack_type = "dogfight",
	drops = {
		{name = "mobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
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
	animation = {
		speed_normal = 20,
		speed_run = 30,
		stand_start = 10,
		stand_end = 20,
		walk_start = 75,
		walk_end = 100,
		run_start = 100,
		run_end = 130,
		punch_start = 135,
		punch_end = 155,
	},
	jump = true,
	step = 1,
	blood_texture = "mobs_blood.png",
})
mobs:register_egg("mobs:dog", "Dog", "wool_brown.png", 1)
