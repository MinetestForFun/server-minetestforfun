local kitten_nodes = {
"wool:black",
"wool:blue",
"wool:brown",
"wool:cyan",
"wool:dark_green",
"wool:dark_grey",
"wool:green",
"wool:grey",
"wool:magenta",
"wool:orange",
"wool:pink",
"wool:red",
"wool:violet",
"wool:white",
"wool:yellow",
"carpet:black",
"carpet:blue",
"carpet:brown",
"carpet:cyan",
"carpet:dark_green",
"carpet:dark_grey",
"carpet:green",
"carpet:grey",
"carpet:magenta",
"carpet:orange",
"carpet:pink",
"carpet:red",
"carpet:violet",
"carpet:white",
"carpet:yellow",
"deco:furnace_active",
"beds:bed_bottom",
"beds:bed_top",
"beds:bed_top_red",
"beds:bed_top_orange",
"beds:bed_top_yellow",
"beds:bed_top_green",
"beds:bed_top_blue",
"beds:bed_top_violet",
"beds:bed_top_black",
"beds:bed_top_grey",
"beds:bed_top_white",
"beds:bed_bottom_red",
"beds:bed_bottom_orange",
"beds:bed_bottom_yellow",
"beds:bed_bottom_green",
"beds:bed_bottom_blue",
"beds:bed_bottom_violet",
"beds:bed_bottom_black",
"beds:bed_bottom_grey",
"beds:bed_bottom_white",
}



mobs:register_spawn("mobs:kitten", {"default:dirt_with_grass"}, 15, 0, 2750, 10, 31000)

mobs:register_mob("mobs:kitten", {
	type = "animal",
	hp_min = 5,
	hp_max = 10,
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
	makes_footstep_sound = false,
	view_range = 16,
	walk_velocity = 0.6,
	drops = {
		{name = "maptools:copper_coin",
		chance = 10,
		min = 1,
		max = 1,},
	},
	water_damage = 1,
	lava_damage = 5,
	on_rightclick = nil,
	armor = 200,
	sounds = {
		random = "mobs_kitten",
	},
	animation = {
		stand_start = 97,
		stand_end = 192,
		walk_start = 0,
		walk_end = 96,
		speed_normal = 42,
	},

	follow = "fishing:fish_raw",
	view_range = 8,
--	jump = true,
--	step = 0.5,
	passive = true,
	blood_texture = "mobs_blood.png",

	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "fishing:fish_raw" then
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
	end
})
