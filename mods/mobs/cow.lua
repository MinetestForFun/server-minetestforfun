
-- Cow by Krupnovpavel

mobs:register_mob("mobs:cow", {
	-- animal, monster, npc, barbarian
	type = "animal",
	-- aggressive, does 6 damage to player when threatened
	passive = false,
	attack_type = "dogfight",
	damage = 6,
	-- health & armor
	hp_min = 20, hp_max = 30, armor = 200,
	-- textures and model
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "mobs_cow.x",
	drawtype = "front",
	available_textures = {
		total = 1, -- à mettre à 2 quand "mobs_cow_brown.png" sera compatible
		texture_1 = {"mobs_cow.png"},
		--texture_2 = {"mobs_cow_brown.png"}, -- dé-commenter quand "mobs_cow_brown.png" sera compatible
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=1,y=1},
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_cow",
	},
	-- speed and jump
	walk_velocity = 1,
	run_velocity = 2,
	jump = true,
	step = 0.5,
	-- drops raw meat when dead
	drops = {
		{name = "mobs:meat_raw",
		chance = 1, min = 5, max = 10},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,		speed_run = 15,
		stand_start = 0,		stand_end = 30,
		walk_start = 35,		walk_end = 65,
		run_start = 105,		run_end = 135,
		punch_start = 70,		punch_end = 100,
	},
	-- follows wheat
	follow = "farming:wheat", view_range = 8,
	-- replace grass/wheat with air (eat)
	replace_rate = 50,
	replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "farming:wheat_8"},
	replace_with = "air",
	-- right-click cow with empty bucket to get milk, then feed 8 wheat to replenish milk
	on_rightclick = function(self, clicker)
		local tool = clicker:get_wielded_item()
		if tool:get_name() == "bucket:bucket_empty" and self.child == false then
			if self.gotten then return end
			clicker:get_inventory():remove_item("main", "bucket:bucket_empty")
			clicker:get_inventory():add_item("main", "mobs:bucket_milk")
			self.gotten = true -- milked
		end
		if tool:get_name() == "farming:wheat" then -- and self.gotten then
			if not minetest.setting_getbool("creative_mode") then
				tool:take_item(1)
				clicker:set_wielded_item(tool)
			end
			self.food = (self.food or 0) + 1
			if self.food >= 8 then
				self.food = 0
				if self.child == false then self.horny = true end
				self.gotten = false -- ready to be milked again
				self.tamed = true
				minetest.sound_play("mobs_cow", {object = self.object,gain = 1.0,max_hear_distance = 32,loop = false,})
			end
			return tool
		end
		
	end,
})
-- spawn on default;green;prairie grass between 0 and 20 light, 1 in 11000 chance, 1 cow in area up to 31000 in height
mobs:register_spawn("mobs:cow", {"default:dirt_with_grass"}, 20, 0, 10000, 1, 31000)
-- register spawn egg
mobs:register_egg("mobs:cow", "Cow", "default_grass.png", 1)

-- Bucket of Milk
minetest.register_craftitem("mobs:bucket_milk", {
	description = "Bucket of Milk",
	inventory_image = "mobs_bucket_milk.png",
	stack_max = 1,
	on_use = minetest.item_eat(8, 'bucket:bucket_empty'),
})

-- Cheese Wedge
minetest.register_craftitem("mobs:cheese", {
	description = "Cheese",
	inventory_image = "mobs_cheese.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type = "cooking",
	output = "mobs:cheese",
	recipe = "mobs:bucket_milk",
	cooktime = 5,
	replacements = {{ "mobs:bucket_milk", "bucket:bucket_empty"}}
})

-- Cheese Block
minetest.register_node("mobs:cheeseblock", {
	description = "Cheese Block",
	tiles = {"mobs_cheeseblock.png"},
	is_ground_content = false,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = "mobs:cheeseblock",
	recipe = {
		{'mobs:cheese', 'mobs:cheese', 'mobs:cheese'},
		{'mobs:cheese', 'mobs:cheese', 'mobs:cheese'},
		{'mobs:cheese', 'mobs:cheese', 'mobs:cheese'},
	}
})

minetest.register_craft({
	output = "mobs:cheese 9",
	recipe = {
		{'mobs:cheeseblock'},
	}
})
