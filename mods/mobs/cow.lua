
-- Cow by Krupnovpavel

mobs:register_mob("mobs:cow", {
	-- animal, monster, npc, barbarian
	type = "animal",
	-- aggressive, does 5 damage to player when threatened
	passive = false,
	group_attack = true,
	attack_type = "dogfight",
	reach = 2,
	damage = 4,
	-- health & armor
	hp_min = 15,
	hp_max = 20,
	armor = 200,
	-- textures and model
	collisionbox = {-0.8, 0, -0.8, 0.8, 1.6, 0.8}, --Modif MFF (debug)
	visual = "mesh",
	mesh = "mobs_cow.b3d",
	textures = {
		{"mobs_cow_lightbrown.png"},
		{"mobs_cow_brown.png"},
		{"mobs_cow_white.png"},
	},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_cow",
	},
	-- speed and jump
	walk_velocity = 1,
	run_velocity = 2,
	jump = true,
	-- drops raw meat when dead
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 5, max = 10},
		{name = "mobs:leather", chance = 1, min = 0, max = 3},
		{name = "maptools:silver_coin", chance = 10, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 30,
		walk_start = 35,
		walk_end = 65,
		run_start = 105,
		run_end = 135,
		punch_start = 70,
		punch_end = 100,
	},
	follow = "farming:wheat",
	view_range = 7,
	replace_rate = 10,
	replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "farming:wheat_8"},
	replace_with = "mobs:dung",
	fear_height = 2,
	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		local tool = clicker:get_wielded_item()

		-- milk cow with empty bucket
		if tool:get_name() == "bucket:bucket_empty" then

			--if self.gotten == true
			if self.child == true then
				return
			end

			if self.gotten == true then
				minetest.chat_send_player(clicker:get_player_name(),
						"Cow already milked!")
				return
			end

			local inv = clicker:get_inventory()

			inv:remove_item("main", "bucket:bucket_empty")

			if inv:room_for_item("main", {name = "mobs:bucket_milk"}) then
				clicker:get_inventory():add_item("main", "mobs:bucket_milk")
			else
				local pos = self.object:getpos()
				pos.y = pos.y + 0.5
				minetest.add_item(pos, {name = "mobs:bucket_milk"})
			end

			self.gotten = true -- milked

			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 60, false, nil)
	end,
})

-- spawn on default;green;prairie grass between 0 and 20 light, 1 in 11000 chance, 1 cow in area up to 31000 in height
mobs:spawn_specific("mobs:cow", {"default:dirt_with_grass"}, {"air"}, 8, 20, 30, 10000, 2, -31000, 31000, true, true)
-- register spawn egg
mobs:register_egg("mobs:cow", "Cow", "mobs_cow_inv.png", 1)

-- leather
minetest.register_craftitem("mobs:leather", {
	description = "Leather",
	inventory_image = "mobs_leather.png",
})

-- bucket of milk
minetest.register_craftitem("mobs:bucket_milk", {
	description = "Bucket of Milk",
	inventory_image = "mobs_bucket_milk.png",
	stack_max = 1,
	on_use = minetest.item_eat(8, 'bucket:bucket_empty'),
})

-- cheese wedge
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

-- cheese block
minetest.register_node("mobs:cheeseblock", {
	description = "Cheese Block",
	tiles = {"mobs_cheeseblock.png"},
	is_ground_content = false,
	groups = {crumbly = 3},
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

-- Dung (from factory's fertilizer)
minetest.register_node("mobs:dung", {
        tiles = {"default_dirt.png"},
        inventory_image = "mobs_dung.png",
        description = "Cow dung",
        drawtype = "nodebox",
        paramtype = "light",
        is_ground_content = true,
        groups = {snappy = 3, attached_node = 1},
        node_box = {
                type = "fixed",
                fixed = {
                        {-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
                        {-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
                        {0, -0.375, -0.0625, 0.0625, -0.3125, 0.0625},
                        {0, -0.3125, -0.0625, 0.0625, -0.25, 0},
                        {-0.0625, -0.375, -0.0625, 0, -0.3125, 0},
                }
        }
})

minetest.register_craft({
	type = "fuel",
	recipe = "mobs:dung",
	burntime = "8",
})
