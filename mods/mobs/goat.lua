
-- Goat by DonBatman

mobs:register_mob("mobs:goat", {
	-- animal, monster, npc, barbarian
	type = "animal",
	-- aggressive, does 5 damage to player when threatened
	passive = false,
	group_attack = true,
	attack_type = "dogfight",
	reach = 2,
	damage = 3,
	-- health & armor
	hp_min = 10,
	hp_max = 20,
	armor = 200,
	-- textures and model
	collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.75, 0.3},
	visual = "mesh",
	mesh = "mobs_goat.b3d",
	drawtype = "front",
	textures = {
		{"mobs_goat_white.png"},
		{"mobs_goat_brown.png"},
		{"mobs_goat_grey.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=2,y=2},
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_sheep",
	},
	-- speed and jump
	walk_velocity = 1.5,
	run_velocity = 3,
	jump = true,
	-- drops raw meat when dead
	drops = {
		{name = "mobs:meat_raw",
		chance = 1, min = 2, max = 4},
		{name = "maptools:silver_coin",
		chance = 10, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 25,		speed_run = 30,
		stand_start = 0,		stand_end = 60, -- head down/up
		walk_start = 80,		walk_end = 110, -- walk
		run_start = 160,		run_end = 198, -- walk
		punch_start = 120,		punch_end = 150, -- attack
	},
	-- follows wheat
	follow = "farming:wheat",
	view_range = 10,
	-- replace grass/wheat with air (eat)
	replace_rate = 50,
	replace_what = {"group:flora"},
	replace_with = "air",
	on_rightclick = function(self, clicker)
		-- feed or tame
		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		local tool = clicker:get_wielded_item()

		-- milk goat with empty bucket
		if tool:get_name() == "bucket:bucket_empty" then
			if self.child == true then
				return
			end

			if self.gotten == true then
				minetest.chat_send_player(clicker:get_player_name(),
						"Goat already milked!")
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
-- spawn on dirt_with_grass between -1 and 20 light, 1 in 20000 chance, 1 goat in area up to 31000 in height
mobs:spawn_specific("mobs:goat", {"default:dirt_with_grass"}, {"air"}, -1, 20, 30, 20000, 1, -31000, 31000, true)
-- register spawn egg
mobs:register_egg("mobs:goat", "Goat", "mobs_goat_inv.png", 1)
