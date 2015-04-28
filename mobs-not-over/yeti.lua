
-- Yeti by TenPlus1

mobs:register_mob("pmobs:yeti", {
	type = "monster",
	hp_min = 10,
	hp_max = 35,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "character.b3d",
	textures = {
		{"mobs_yeti.png"},
	},
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_stonemonster",
	},
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 2,
	drops = {
		{name = "default:ice",
		chance = 1,
		min = 1,
		max = 3,},
	},
	armor = 100,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 1,
	on_rightclick = nil,
	attack_type = "shoot",
	shoot_interval = .7,
	arrow = "pmobs:snowball",
	shoot_offset = 2,
	animation = {
		speed_normal = 30,		speed_run = 30,
		stand_start = 0,		stand_end = 79,
		walk_start = 168,		walk_end = 187,
		run_start = 168,		run_end = 187,
		punch_start = 200,		punch_end = 219,
	},
	jump = true,
	floats = 0,
})
mobs:register_spawn("pmobs:yeti", {"default:dirt_with_snow", "default:snowblock", "default:ice"}, 10, -1, 7000, 1, 31000)

mobs:register_egg("pmobs:yeti", "Yeti", "default_snow.png", 1)

mobs:register_arrow("pmobs:snowball", {
	visual = "sprite",
	visual_size = {x=.5, y=.5},
	textures = {"default_snowball.png"},
	velocity = 6,

	hit_player = function(self, player)
		player:punch(self.object, 1.0,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=1},
		}, 0)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=1},
		}, 0)
	end,

	hit_node = function(self, pos, node)
	end
})

-- snowball throwing item

local snowball_GRAVITY=9
local snowball_VELOCITY=19

-- shoot snowball
local mobs_shoot_snowball=function (item, player, pointed_thing)
	local playerpos=player:getpos()
	local obj=minetest.add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, "pmobs:snowball")
	local dir=player:get_look_dir()
	obj:get_luaentity().velocity = snowball_VELOCITY -- needed for api internal timing
	obj:setvelocity({x=dir.x*snowball_VELOCITY, y=dir.y*snowball_VELOCITY, z=dir.z*snowball_VELOCITY})
	obj:setacceleration({x=dir.x*-3, y=-snowball_GRAVITY, z=dir.z*-3})
	item:take_item()
	return item
end

-- override default snow to shoot snowballs
minetest.override_item("default:snow", {

	--Disable placement prediction for snow.
 	node_placement_prediction = "",
	on_construct = function(pos)
		if minetest.get_item_group(minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name, "soil") > 0 then
			minetest.set_node({x=pos.x, y=pos.y-1, z=pos.z}, {name="default:dirt_with_snow"})
		end
	end,

	on_use = mobs_shoot_snowball
})
