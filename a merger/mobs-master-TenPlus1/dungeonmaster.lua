
-- Dungeon Master by PilzAdam

-- Node which cannot be destroyed by DungeonMasters' fireballs
local excluded = {"nether:netherrack","default:obsidian_glass","default:obsidian", "default:obsidian_cooled", "default:bedrock", "doors:door_steel_b_1", "doors:door_steel_t_1", "doors:door_steel_b_2", "doors:door_steel_t_2","default:chest_locked"}

mobs:register_mob("mobs:dungeon_master", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, shoots fireballs at player, deal 13 damages
	passive = false,
	damage = 13,
	attack_type = "shoot",
	shoot_interval = 2.5,
	arrow = "mobs:fireball",
	shoot_offset = 0,
	-- health & armor
	hp_min = 50,
	hp_max = 60,
	armor = 60,
	-- textures and model
	collisionbox = {-0.7, -0.01, -0.7, 0.7, 2.6, 0.7},
	visual = "mesh",
	mesh = "mobs_dungeon_master.x",
	textures = {
		{"mobs_dungeon_master.png"},
		{"mobs_dungeon_master_cobblestone.png"},
		{"mobs_dungeon_master_strangewhite.png"},
	},
	visual_size = {x=8, y=8},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_dungeonmaster",
		attack = "mobs_fireball",
	},
	-- speed and jump
	walk_velocity = 1,
	run_velocity = 2,
	jump = false,
	view_range = 16,
	-- drops mese or diamond when dead
	drops = {
		{name = "default:mese_crystal_fragment",
		chance = 1, min = 1, max = 3,},
		{name = "default:diamond",
		chance = 5, min = 1, max = 3,},
		{name = "default:mese_crystal",
		chance = 2, min = 1, max = 3,},
		{name = "default:diamond_block",
		chance = 30, min = 1, max = 1,},
		{name = "maptools:gold_coin",
		chance = 15, min = 1, max = 2,},
		{name = "maptools:silver_coin",
		chance = 1, min = 2, max = 10,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 1,
	light_damage = 0,
	-- model animation
	animation = {
		stand_start = 0,		stand_end = 19,
		walk_start = 20,		walk_end = 35,
		punch_start = 36,		punch_end = 48,
		speed_normal = 15,		speed_run = 15,
	},
})
-- spawn on stone between 20 and -1 light, 1 in 7000 chance, 1 dungeon master in area starting at -100 and below
mobs:register_spawn("mobs:dungeon_master", {"default:stone, nether:netherrack"}, 20, -1, 7000, 1, -100)
-- register spawn egg
mobs:register_egg("mobs:dungeon_master", "Dungeon Master", "fire_basic_flame.png", 1)

-- fireball (weapon)
mobs:register_arrow("mobs:fireball", {
	visual = "sprite",
	visual_size = {x=1, y=1},
	textures = {"mobs_fireball.png"},
	velocity = 6,

	-- direct hit, no fire... just plenty of pain
	hit_player = function(self, player)
		player:punch(self.object, 1.0,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=13},
		}, 0)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=8},
		}, 0)
	end,

	-- node hit, bursts into flame (cannot blast through obsidian or protection redo mod items)
	hit_node = function(self, pos, node)
		mobs:explosion(pos, 1, 1, 0)
	end
})
