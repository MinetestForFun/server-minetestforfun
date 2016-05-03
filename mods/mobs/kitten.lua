
-- Kitten by Jordach / BFD

mobs:register_mob("mobs:kitten", {
	-- animal, monster, npc
	type = "animal",
	-- is it aggressive
	passive = true,
	-- health & armor
	hp_min = 5,
	hp_max = 10,
	armor = 200,
	-- textures and model
	collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.1, 0.3},
	visual = "mesh",
	visual_size = {x = 0.5, y = 0.5},
	mesh = "mobs_kitten.b3d",
	textures = {
		{"mobs_kitten_striped.png"},
		{"mobs_kitten_splotchy.png"},
		{"mobs_kitten_ginger.png"},
		{"mobs_kitten_sandy.png"},
	},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_kitten",
	},
	-- speed and jump
	walk_velocity = 0.6,
	run_velocity = 2,
	runaway = true,
	jump = false,
	--	drops string
	drops = {
		{name = "farming:string", chance = 2, min = 1, max = 1},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	fear_height = 3,
	-- model animation
	animation = {
		speed_normal = 42,
		stand_start = 97,
		stand_end = 192,
		walk_start = 0,
		walk_end = 96,
	},
	-- follows Rat and Raw Fish
	follow = {"mobs:rat", "ethereal:fish_raw"},
	view_range = 10,
	-- feed with raw fish to tame or right click to pick up
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 4, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 50, 50, 90, false, nil)
	end
})
mobs:spawn_specific("mobs:kitten", {"default:dirt_with_grass"}, {"air"}, 0, 20, 30, 15000, 1, -31000, 31000, true, true)
mobs:register_egg("mobs:kitten", "Kitten", "mobs_kitten_inv.png", 0)
