
-- Bee by KrupnoPavel

mobs:register_mob("mobs:bee", {
	-- animal, monster, npc, barbarian
	type = "animal",
	-- it is aggressive
	passive = true,
	-- health & armor
	hp_min = 1,
	hp_max = 2,
	armor = 200,
	-- textures and model
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "mobs_bee.x",
	textures = {
		{"mobs_bee.png"},
	},
	-- sounds
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_bee",
	},
	walk_velocity = 1,
	jump = true,
	-- drops honey when killed
	drops = {
		{name = "mobs:honey", chance = 1, min = 1, max = 2},
	},
	-- damage
	water_damage = 1,
	lava_damage = 1,
	light_damage = 0,
	fall_damage = 0,
	fall_speed = -3,
	-- model animation
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 30,
		walk_start = 35,
		walk_end = 65,
	},
	-- right click to pick up bee
	on_rightclick = function(self, clicker)
		mobs:capture_mob(self, clicker, 25, 80, 0, true, nil)
	end,
})
-- spawn on group:flowers between 4 and 20 light, 1 in 8000 chance, 1 bee in area up to 31000 in height
mobs:spawn_specific("mobs:bee", {"group:flower"}, {"air"}, 4, 20, 30, 8000, 2, -31000, 31000, true, true)
-- register spawn egg
mobs:register_egg("mobs:bee", "Bee", "mobs_bee_inv.png", 1)

-- honey
minetest.register_craftitem("mobs:honey", {
	description = "Honey",
	inventory_image = "mobs_honey_inv.png",
	on_use = minetest.item_eat(6),
})

-- beehive (when placed spawns bee)
minetest.register_node("mobs:beehive", {
	description = "Beehive",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"mobs_beehive.png"},
	inventory_image = "mobs_beehive.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	groups = {fleshy=3,dig_immediate=3},
	on_use = minetest.item_eat(4),
	sounds = default.node_sound_defaults(),

	on_construct = function(pos)

		local meta = minetest.get_meta(pos)

		meta:set_string("formspec", "size[8,6]"
			..default.gui_bg..default.gui_bg_img..default.gui_slots
			.. "image[3,0.8;0.8,0.8;mobs_bee_inv.png]"
			.. "list[current_name;beehive;4,0.5;1,1;]"
			.. "list[current_player;main;0,2.35;8,4;]"
			.. "listring[]")

		meta:get_inventory():set_size("beehive", 1)
	end,

	after_place_node = function(pos, placer, itemstack)

		if placer:is_player() then

			minetest.set_node(pos, {name = "mobs:beehive", param2 = 1})

			if math.random(1, 5) == 1 then
				minetest.add_entity(pos, "mobs:bee")
			end
		end
	end,

	on_punch = function(pos, node, puncher)

		-- yep, bee's don't like having their home punched by players
		puncher:set_hp(puncher:get_hp() - 4)
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)

		if listname == "beehive" then
			return 0
		end

		return stack:get_count()
	end,

	can_dig = function(pos,player)

		local meta = minetest.get_meta(pos)

		-- only dig beehive if no honey inside
		return meta:get_inventory():is_empty("beehive")
	end,

})

minetest.register_craft({
	output = "mobs:beehive",
	recipe = {
		{"mobs:bee","mobs:bee","mobs:bee"},
	}
})

-- honey block
minetest.register_node("mobs:honey_block", {
	description = "Honey Block",
	tiles = {"mobs_honey_block.png"},
	groups = {snappy = 3, flammable = 2},
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

-- beehive workings
minetest.register_abm({
	nodenames = {"mobs:beehive"},
	interval = 6,
	chance = 5,
	catch_up = false,
	action = function(pos, node)

		-- bee's only make honey during the day
		local tod = (minetest.get_timeofday() or 0) * 24000

		if tod < 4500 or tod > 19500 then
			return
		end

		-- find flowers in area around hive
		local flowers = minetest.find_nodes_in_area_under_air(
			{x = pos.x - 10, y = pos.y - 5, z = pos.z - 10},
			{x = pos.x + 10, y = pos.y + 5, z = pos.z + 10},
			"group:flower")

		-- no flowers no honey, nuff said!
		if #flowers > 3 then

			local meta = minetest.get_meta(pos)

			-- error check just incase it's an old beehive
			if meta then
				meta:get_inventory():add_item("beehive", "mobs:honey")
			end
		end
	end
})
