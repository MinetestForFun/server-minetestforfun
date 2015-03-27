
-- Kitten by Jordach / BFD

mobs:register_mob("mobs:kitten", {
	-- animal, monster, npc
	type = "animal",
	-- is it aggressive
	passive = true,
	-- health & armor
	hp_min = 4, hp_max = 8, armor = 200,
	-- textures and model
	collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.1, 0.3},
	visual = "mesh",
	visual_size = {x=0.5, y=0.5},
	mesh = "mobs_kitten.b3d",
	available_textures = {
		total = 4,
		texture_1 = {"mobs_kitten_striped.png"},
		texture_2 = {"mobs_kitten_splotchy.png"},
		texture_3 = {"mobs_kitten_ginger.png"},
		texture_4 = {"mobs_kitten_sandy.png"},
	},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_kitten",
	},
	-- speed and jump
	walk_velocity = 0.6,
	jump = false,
	--	drops sometimes coins
	drops = {
		{name = "maptools:copper_coin",
		chance = 10,
		min = 1,
		max = 1,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	-- model animation
	animation = {
		speed_normal = 42,
		stand_start = 97,		stand_end = 192,
		walk_start = 0,			walk_end = 96,
	},
	-- follows rat
	follow = "mobs:rat",
	view_range = 8,
	-- feed with raw fish to tame or right click to pick up
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "fishing:fish_raw" or item:get_name() == "ethereal:fish_raw" then
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.food = (self.food or 0) + 1
			if self.food >= 4 then
				self.food = 0
				self.tamed = true
				minetest.sound_play("mobs_kitten", {object = self.object,gain = 1.0,max_hear_distance = 32,loop = false,})
			end
			return
		end
		if clicker:is_player() and clicker:get_inventory() and clicker:get_inventory():room_for_item("main", "mobs:kitten") then
			clicker:get_inventory():add_item("main", "mobs:kitten")
			self.object:remove()
		end
	end
})

mobs:register_spawn("mobs:kitten", {"default:dirt_with_grass"}, 20, 0, 10000, 1, 31000)
mobs:register_egg("mobs:kitten", "Kitten", "mobs_kitten_inv.png", 0)
