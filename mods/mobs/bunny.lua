
-- Bunny by ExeterDad

mobs:register_mob("mobs:bunny", {
	-- animal, monster, npc
	type = "animal",
	-- is it aggressive
	passive = true,
	reach = 1,
	-- health & armor
	hp_min = 3,
	hp_max = 6,
	armor = 200,
	-- textures and model
	collisionbox = {-0.268, -0.5, -0.268,  0.268, 0.167, 0.268},
	visual = "mesh",
	mesh = "mobs_bunny.b3d",
	drawtype = "front",
	textures = {
		{"mobs_bunny_grey.png"},
		{"mobs_bunny_brown.png"},
		{"mobs_bunny_white.png"},
	},
	-- sounds
	sounds = {},
	makes_footstep_sound = false,
	-- speed and jump
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	jump = true,
	-- drops meat when dead
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 2},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	-- model animation
	animation = {
		speed_normal = 15,
		stand_start = 1,
		stand_end = 15,
		walk_start = 16,
		walk_end = 24,
		punch_start = 16,
		punch_end = 24,
	},
	-- follows carrot from farming redo
	follow = {"farming:carrot", "farming_plus:carrot_item"},
	view_range = 8,
	-- eat carrots
	replace_rate = 10,
	replace_what = {"farming:carrot_7", "farming:carrot_8", "farming_plus:carrot"},
	replace_with = "air",
	-- right click to pick up rabbit
	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, true, true) then
			return
		end

		-- Monty Python tribute
		local item = clicker:get_wielded_item()

		if item:get_name() == "mobs:lava_orb" then

			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end

			self.object:set_properties({
				textures = {"mobs_bunny_evil.png"},
			})

			self.type = "monster"
			self.object:set_hp(20)

			return
		end

		mobs:capture_mob(self, clicker, 30, 50, 80, false, nil)
	end,

	attack_type = "dogfight",
	damage = 5,
})
mobs:spawn_specific("mobs:bunny", {"default:dirt_with_grass"}, {"air"}, 8, 20, 30, 15000, 2, -31000, 31000, true, true)
mobs:register_egg("mobs:bunny", "Bunny", "mobs_bunny_inv.png", 1)
