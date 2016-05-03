
-- local variables
local l_colors = {
	"#111010:200",	--dark_grey
	"#101020:225",	--dark_blue
	"#404030:225",	--cold_grey
	"#404040:210",	--light_grey
	"#202020:210"	--grey
}
local l_skins = {
	{"(shark_first.png^[colorize:"..l_colors[1]..")^(shark_second.png^[colorize:"..l_colors[5]..")^shark_third.png"},
	{"(shark_first.png^[colorize:"..l_colors[2]..")^(shark_second.png^[colorize:"..l_colors[5]..")^shark_third.png"},
	{"(shark_first.png^[colorize:"..l_colors[3]..")^(shark_second.png^[colorize:"..l_colors[4]..")^shark_third.png"}
}
local l_anims = {
	speed_normal = 24,	speed_run = 24,
	stand_start = 1,	stand_end = 80,
	walk_start = 80,	walk_end = 160,
	run_start = 80,		run_end = 160
}
local l_model			= "mobs_shark.b3d"
local l_egg_texture		= "mobs_shark_shark_inv.png"
local l_spawn_in		= {"default:water_source"}
local l_spawn_near		= {"default:water_flowing","default:water_source","seawrecks:woodship","seawrecks:uboot"}
local l_spawn_chance	= 500000

-- large
mobs:register_mob("mobs:shark_lg", {
	type = "monster",
	attack_type = "dogfight",
	damage = 4,
	reach = 3,
	hp_min = 15,
	hp_max = 20,
	armor = 150,
	collisionbox = {-0.75, -0.5, -0.75, 0.75, 0.5, 0.75},
	visual = "mesh",
	mesh = l_model,
	textures = l_skins,
	makes_footstep_sound = false,
	walk_velocity = 2,
	run_velocity = 4,
	fly = true,
	fly_in = "default:water_source",
	fall_speed = 0,
	rotate = 270,
	view_range = 10,
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
	animation = l_anims,
	do_custom = function(self)
		local p = self.object:getpos()
		local a = self.object:getvelocity()
		if p.y > 0 and a.y > 0 then
			a.y = -1
		else
			local r = math.random(100)
			if r >= 1 and r <=25 then a.y = 0.25
			elseif r > 25 and r <= 50 then a.y = 0
			elseif r > 50 and r <= 75 then a.y = -0.25
			end
		end
		self.object:setvelocity(a)
	end
})
--name, nodes, neighbours, minlight, maxlight, interval, chance, active_object_count, min_height, max_height
mobs:spawn_specific("mobs:shark_lg", l_spawn_in, l_spawn_near, -1, 20, 30, l_spawn_chance, 1, -50, -1)
mobs:register_egg("mobs:shark_lg", "Shark (large)", l_egg_texture, 1)

-- medium
mobs:register_mob("mobs:shark_md", {
	type = "monster",
	attack_type = "dogfight",
	damage = 5,
	reach = 2,
	hp_min = 20,
	hp_max = 25,
	armor = 125,
	collisionbox = {-0.57, -0.38, -0.57, 0.57, 0.38, 0.57},
	visual = "mesh",
	visual_size = {x=0.75, y=0.75},
	mesh = l_model,
	textures = l_skins,
	makes_footstep_sound = false,
	walk_velocity = 2,
	run_velocity = 4,
	fly = true,
	fly_in = "default:water_source",
	fall_speed = -1,
	rotate = 270,
	view_range = 10,
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
	animation = l_anims
})
--name, nodes, neighbours, minlight, maxlight, interval, chance, active_object_count, min_height, max_height
mobs:spawn_specific("mobs:shark_md", l_spawn_in, l_spawn_near, -1, 20, 30, l_spawn_chance, 1, -50, -1)
mobs:register_egg("mobs:shark_md", "Shark (medium)", l_egg_texture, 1)
