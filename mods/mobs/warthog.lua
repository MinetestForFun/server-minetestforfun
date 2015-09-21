
-- Warthog by KrupnoPavel

mobs:register_mob("mobs:pumba", {
	-- animal, monster, npc, barbarian
	type = "animal",
	-- aggressive, deals 5 damage to player when threatened
	passive = false,
	group_attack = true,
	attack_type = "dogfight",
	damage = 4,
	-- health & armor
	hp_min = 15,
	hp_max = 20,
	armor = 200,
	-- textures and model
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "mobs_pumba.x",
	textures = {
		{"mobs_pumba.png"},
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
	-- follows apple and potato
	follow = {"default:apple", "farming:potato"},
	view_range = 10,
	-- drops raw pork when dead
	drops = {
		{name = "mobs:pork_raw",
		chance = 1, min = 2, max = 3,},
		{name = "maptools:silver_coin",
		chance = 10, min = 1, max = 1,},
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
		mobs:feed_tame(self, clicker, 8, true, true)
		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})
-- spawns on dirt or junglegrass, between 8 and 20 light, 1 in 10000 chance, 1 in area up to 31000 in height
mobs:spawn_specific("mobs:pumba", {"default:dirt", "default:junglegrass"}, {"air"}, 8, 20, 30, 10000, 1, -31000, 31000, true)
-- register spawn egg
mobs:register_egg("mobs:pumba", "Warthog", "mobs_warthog_inv.png", 1)

-- porkchop (raw and cooked)
minetest.register_craftitem("mobs:pork_raw", {
	description = "Raw Porkchop",
	inventory_image = "mobs_pork_raw.png",
	on_use = minetest.item_eat(4),
})

-- cooked porkchop
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
