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



local function register_kitten(image, name)

	mobs:register_spawn("mobs:kitten_"..name, {"default:dirt_with_grass"}, 15, 0, 10000, 10, 31000)

	mobs:register_mob("mobs:kitten_"..name, {
		type = "animal",
		hp_min = 5,
		hp_max = 10,
		collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.1, 0.3},
		visual = "mesh",
		visual_size = {x=0.5, y=0.5},
		mesh = "mobs_kitten.b3d",
		textures = {image},
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
		lava_damage = 10,
		on_rightclick = nil,
		armor = 100,
		sounds = {
			random = "mobs_kitten",
		},
		animation = {
			stand_start = 97,
			stand_end = 192,
			walk_start = 0,
			walk_end = 96,
			speed_normal = 42,
		}
	})
	
end

register_kitten("mobs_kitten_striped.png", "striped")
register_kitten("mobs_kitten_splotchy.png", "splotchy")
register_kitten("mobs_kitten_ginger.png", "ginger")
register_kitten("mobs_kitten_sandy.png", "sandy")

