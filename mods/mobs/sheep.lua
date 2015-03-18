
-- Sheep by PilzAdam

mobs:register_mob("mobs:sheep", {
	-- animal, monster, npc, barbarian
	type = "animal",
	-- not aggressive
	passive = true,
	-- health & armor
	hp_min = 10, hp_max = 15, armor = 200,
	-- textures and model
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "mobs_sheep.x",
	drawtype = "front",
	available_textures = {
		total = 1,
		texture_1 = {"mobs_sheep.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=1,y=1},
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_sheep",
	},
	-- speed and jump
	walk_velocity = 1,
	jump = true,
	step = 1,
	-- drops raw meat when dead
	drops = {
		{name = "mobs:meat_raw",
		chance = 1, min = 2, max = 3,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,		speed_run = 15,
		stand_start = 0,		stand_end = 80,
		walk_start = 81,		walk_end = 100,
	},
	-- follows wheat
	follow = "farming:wheat",
	view_range = 8,
	-- replace grass/wheat with air (eat)
	replace_rate = 50,
	replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "farming:wheat_8"},
	replace_with = "air",
	-- right click sheep to shear sheep and get wood, feed 8 wheat for wool to grow back
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" then
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.food = (self.food or 0) + 1
			if self.food >= 8 then
				self.food = 0
				if self.child == false then self.horny = true end
				self.gotten = false -- can be shaved again
				self.tamed = true
				self.object:set_properties({
					textures = {"mobs_sheep.png"},
					mesh = "mobs_sheep.x",
				})
				minetest.sound_play("mobs_sheep", {object = self.object,gain = 1.0,max_hear_distance = 32,loop = false,})
			end
		return
		end
		if clicker:get_inventory() and not self.gotten and self.child == false then
			self.gotten = true -- shaved
			if minetest.registered_items["wool:white"] then
				clicker:get_inventory():add_item("main", ItemStack("wool:white "..math.random(1,3)))
			end
			self.object:set_properties({
				textures = {"mobs_sheep_shaved.png"},
				mesh = "mobs_sheep_shaved.x",
			})
		else print ("shaved already!")
		end
	end,
})
-- spawn on default;green grass between 20 and 8 light, 1 in 9000 chance, 1 sheep in area up to 31000 in height
mobs:register_spawn("mobs:sheep", {"default:dirt_with_grass"}, 20, 8, 9000, 1, 31000)
-- register spawn egg
mobs:register_egg("mobs:sheep", "Sheep", "wool_white.png", 1)
