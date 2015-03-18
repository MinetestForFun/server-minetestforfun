
-- Warthog by KrupnoPavel

mobs:register_mob("mobs:pumba", {
	-- animal, monster, npc, barbarian
	type = "animal",
	-- aggressive, deals 2 damage to player when threatened
	passive = false,
	attack_type = "dogfight",
	damage = 4,
	-- health & armor
	hp_min = 15, hp_max = 20, armor = 200,
	-- textures and model
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "mobs_pumba.x",
	drawtype = "front",
	available_textures = {
		total = 1,
		texture_1 = {"mobs_pumba.png"},
	},
	visual_size = {x=1,y=1},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_pig",
		attack = "mobs_pig_angry",
	},
	-- speed and jump
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	step = 1,
	-- follows apple
	follow = "default:apple",
	view_range = 8,
	-- drops raw pork when dead
	drops = {
		{name = "mobs:pork_raw",
		chance = 1, min = 2, max = 3,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,
		stand_start = 25,		stand_end = 55,
		walk_start = 70,		walk_end = 100,
		punch_start = 70,		punch_end = 100,
	},
	-- can be tamed by feeding 8 wheat (will not attack when tamed)
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "default:apple" then
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.food = (self.food or 0) + 1
			if self.food >= 8 then
				if self.child == false then self.horny = true end
				self.food = 0
				self.tamed = true
				minetest.sound_play("mobs_pig", {object = self.object,gain = 1.0,max_hear_distance = 32,loop = false,})
			end
			return
		end
	end,
})
-- spawns on normal or shroom dirt, between 8 and 20 light, 1 in 10000 chance, 1 in area up to 31000 in height
mobs:register_spawn("mobs:pumba", {"default:dirt_with_grass", "default:dirt"}, 20, 8, 10000, 1, 31000)
-- register spawn egg
mobs:register_egg("mobs:pumba", "Warthog", "wool_pink.png", 1)

-- Porkchops (raw and cooked)
minetest.register_craftitem("mobs:pork_raw", {
	description = "Raw Porkchop",
	inventory_image = "mobs_pork_raw.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craftitem("mobs:pork_cooked", {
	description = "Cooked Porkchop",
	inventory_image = "mobs_pork_cooked.png",
	on_use = minetest.item_eat(8),
})

minetest.register_craft({
	type = "cooking",
	output = "mobs:pork_cooked",
	recipe = "mobs:pork_raw",
	cooktime = 5,
})
