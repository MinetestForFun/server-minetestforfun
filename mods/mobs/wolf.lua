
-- Wolf by KrupnoPavel

mobs:register_mob("mobs:wolf", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- agressive, does 4 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	damage = 5,					-- 3 damages if tamed
	-- health & armor
	hp_min = 15, hp_max = 20, armor = 200,
	-- textures and model
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "mobs_wolf.x",
	drawtype = "front",
	textures = {
		{"mobs_wolf.png"},
	},
	--visual_size = {x=1,y=1}, --Quel valeur lui mettre ?
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_wolf",
		attack = "mobs_wolf_attack",
	},
	-- speed and jump
	walk_velocity = 3,
	run_velocity = 5,
	jump = true,
	view_range = 16,
	-- drops mese or diamond when dead
	drops = {
		{name = "mobs:meat_raw",
		chance = 1, min = 2, max = 3,},
		{name = "maptools:silver_coin",
		chance = 4, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 0,
	lava_damage = 5,
	light_damage = 2,
	-- model animation
	animation = {
		stand_start = 0,		stand_end = 14,
		walk_start = 15,		walk_end = 38,
		run_start = 40,			run_end = 63,
		punch_start = 40,		punch_end = 63,
		speed_normal = 15,		speed_run = 15,
	},
	-- right clicking with "raw meat" 4 times will tame the wolf into a friendly dog
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "mobs:meat_raw" then
			clicker:get_inventory():remove_item("main", "mobs:meat_raw")
			self.raw_meat_count = (self.raw_meat_count or 0) + 1
			if self.raw_meat_count > 4 then
				local ent = minetest.add_entity(self.object:getpos(), "mobs:dog")
				self.object:remove()
				local dog_obj = ent:get_luaentity()
				if not dog_obj then return end
				dog_obj.tamed = true
				dog_obj.owner = clicker:get_player_name()
			end
		end
	end
})
mobs:register_spawn("mobs:wolf", {"default:dirt_with_grass"}, 3, -1, 9500, 1, 31000)
mobs:register_egg("mobs:wolf", "Wolf", "mobs_wolf_inv.png", 1)
