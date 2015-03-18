
-- Bunny by ExeterDad

mobs:register_mob("mobs:bunny", {
	-- animal, monster, npc
	type = "animal",
	-- is it aggressive
	passive = true,
	-- health & armor
	hp_min = 1, hp_max = 4, armor = 200, 
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
	jump = true,
	-- drops meat when deat
	drops = {
		{name = "mobs:meat_raw",
		chance = 1, min = 1, max = 2,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 1,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,
		stand_start = 1,		stand_end = 15,
		walk_start = 16,		walk_end = 24,
	},
	-- follows carrot from farming redo
	follow = "farming:carrot",
	view_range = 5,	
	-- right click to pick up rabbit
	on_rightclick = function(self, clicker)

		local item = clicker:get_wielded_item()
		if item:get_name() == "farming_plus:carrot_item" or item:get_name() == "farming:carrot" then
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.food = (self.food or 0) + 1
			if self.food >= 4 then
				self.food = 0
				self.tamed = true
			end
			return
		end
		if clicker:is_player() and clicker:get_inventory() then
			clicker:get_inventory():add_item("main", "mobs:bunny")
			self.object:remove()
		end
	end, 
})

mobs:register_spawn("mobs:bunny", {"default:dirt_with_grass", "ethereal:green_dirt_top"}, 20, 8, 9000, 1, 31000)
mobs:register_egg("mobs:bunny", "bunny", "mobs_bunny_inv.png", 0)
