
-- Bee

mobs:register_mob("mobs:bee", {
	type = "animal",
	hp_min = 1,
	hp_max = 2,
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "mobs_bee.x",
	--textures = {"mobs_bee.png"},
	available_textures = {
		total = 1,
		texture_1 = {"mobs_bee.png"},
	},
	makes_footstep_sound = false,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "mobs:med_cooked",
		chance = 1,
		min = 1,
		max = 2,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 1,
	light_damage = 0,
	
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 30,
		walk_start = 35,
		walk_end = 65,
	},
	sounds = {
		random = "mobs_bee",
	},
	on_rightclick = function(self, clicker)
		if clicker:is_player() and clicker:get_inventory() then
			clicker:get_inventory():add_item("main", "mobs:bee")
			self.object:remove()
		end
	end,
jump = true,
step = 1,
passive = true,
})
mobs:register_spawn("mobs:bee", {"default:dirt_with_grass"}, 20, 4, 7500, 1, 31000)

minetest.register_craftitem("mobs:bee", {
	description = "bee",
	inventory_image = "mobs_bee_inv.png",
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.env:add_entity(pointed_thing.above, "mobs:bee")
			itemstack:take_item()
		end
		return itemstack
	end,
})

-- Honey

minetest.register_craftitem("mobs:honey", {
	description = "Honey",
	inventory_image = "mobs_honey_inv.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craft({
	type = "cooking",
	output = "mobs:med_cooked",
	recipe = "mobs:bee",
	cooktime = 5,
})

-- Beehive

minetest.register_node("mobs:beehive", {
	description = "Beehive",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles ={"mobs_beehive.png"},
	inventory_image = "mobs_beehive.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	groups = {fleshy=3,dig_immediate=3},
	on_use = minetest.item_eat(4),
	sounds = default.node_sound_defaults(),
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name="mobs:beehive", param2=1})
			minetest.env:add_entity(pos, "mobs:bee")
		end
	end,
	
})

minetest.register_craft({
	output = "mobs:beehive",
	recipe = {
		{"mobs:bee","mobs:bee","mobs:bee"},
	}
})

-- Honey Block
minetest.register_node("mobs:honey_block", {
	description = "Honey Block",
	tiles = {"mobs_honey_block.png"},
	groups = {snappy=3,flammable=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_craft({
	output = "mobs:honey_block",
	recipe = {
		{"mobs:honey", "mobs:honey", "mobs:honey"},
		{"mobs:honey", "mobs:honey", "mobs:honey"},
		{"mobs:honey", "mobs:honey", "mobs:honey"},
	}
})

minetest.register_craft({
	output = "mobs:honey 9",
	recipe = {
		{"mobs:honey_block"},
	}
})
