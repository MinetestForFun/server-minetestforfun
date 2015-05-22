
-- Cow by Krupnovpavel

mobs:register_mob("mobs:cow", {
	-- animal, monster, npc, barbarian
	type = "animal",
	-- aggressive, does 5 damage to player when threatened
	passive = false,
	attack_type = "dogfight",
	damage = 5,
	-- health & armor
	hp_min = 25,
	hp_max = 30,
	armor = 200,
	-- textures and model
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	mesh = "mobs_cow.x",
	textures = {
		{"mobs_cow.png"},
		--{"mobs_cow_brown.png"}, -- dé-commenter quand "mobs_cow_brown.png" sera compatible
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=1,y=1},
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_cow",
	},
	-- speed and jump
	walk_velocity = 1,
	run_velocity = 2,
	jump = false,
	-- drops raw meat when dead
	drops = {
		{name = "mobs:meat_raw",
		chance = 1, min = 5, max = 10},
		{name = "mobs:leather",
		chance = 1, min = 0, max = 3},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,		speed_run = 15,
		stand_start = 0,		stand_end = 30,
		walk_start = 35,		walk_end = 65,
		run_start = 105,		run_end = 135,
		punch_start = 70,		punch_end = 100,
	},
	-- follows wheat
	follow = "farming:wheat", view_range = 8,
	-- replace grass/wheat with air (eat) 	-- Modif MFF /DEBUT
	replacements = {
		{
			replace_rate = 50,
			replace_what = {"default:grass_3", "default:grass_4",
							"default:grass_5", "farming:wheat_8"},
			replace_with = "air",
		},
		{
			replace_rate = 2000,
			replace_what = {"air"},
			replace_with = "mobs:dung",
		}
	},										-- Modif MFF /FIN
	-- right-click cow with empty bucket to get milk, then feed 8 wheat to replenish milk
	on_rightclick = function(self, clicker)
		local tool = clicker:get_wielded_item()
		local name = clicker:get_player_name()

		if tool:get_name() == "bucket:bucket_empty" then
			if self.gotten == true
			or self.child == true then
				return
			end
			local inv = clicker:get_inventory()
			inv:remove_item("main", "bucket:bucket_empty")
			-- if room add bucket of milk to inventory, otherwise drop as item
			if inv:room_for_item("main", {name="mobs:bucket_milk"}) then
				clicker:get_inventory():add_item("main", "mobs:bucket_milk")
			else
				local pos = self.object:getpos()
				pos.y = pos.y + 0.5
				minetest.add_item(pos, {name = "mobs:bucket_milk"})
			end
			self.gotten = true -- milked
		end

		if tool:get_name() == "farming:wheat" then
			-- take item
			if not minetest.setting_getbool("creative_mode") then
				tool:take_item(1)
				clicker:set_wielded_item(tool)
			end
			-- make child grow quicker
			if self.child == true then
				self.hornytimer = self.hornytimer + 10
				return
			end
			-- feed and tame
			self.food = (self.food or 0) + 1
			if self.food > 7 then
				self.food = 0
				if self.hornytimer == 0 then
					self.horny = true
				end
				self.gotten = false -- ready to be milked again
				self.tamed = true
				-- make owner
				if not self.owner or self.owner == "" then
					self.owner = name
				end
				minetest.sound_play("mobs_cow", {
					object = self.object,
					gain = 1.0,
					max_hear_distance = 32,
					loop = false,
				})
			end
			return
		end

		if tool:get_name() == "mobs:magic_lasso"
		and clicker:is_player()
		and clicker:get_inventory()
		and self.child == false
		and clicker:get_inventory():room_for_item("main", "mobs:cow") then

			-- pick up if owner
			if self.owner == name then
				clicker:get_inventory():add_item("main", "mobs:cow")
				self.object:remove()
				tool:add_wear(3000) -- 22 uses
				clicker:set_wielded_item(tool)
			-- cannot pick up if not tamed
			elseif not self.owner or self.owner == "" then
				minetest.chat_send_player(name, "Not tamed!")
			-- cannot pick up if not owner
			elseif self.owner ~= name then
				minetest.chat_send_player(name, "Not owner!")
			end

		end
	end,
})
-- spawn on default;green;prairie grass between 0 and 20 light, 1 in 11000 chance, 1 cow in area up to 31000 in height
mobs:register_spawn("mobs:cow", {"default:dirt_with_grass"}, 20, 8, 10000, 1, 31000)
-- register spawn egg
mobs:register_egg("mobs:cow", "Cow", "default_grass.png", 1)

-- leather
minetest.register_craftitem("mobs:leather", {
	description = "Leather",
	inventory_image = "mobs_leather.png",
})

-- bucket of milk
minetest.register_craftitem("mobs:bucket_milk", {
	description = "Bucket of Milk",
	inventory_image = "mobs_bucket_milk.png",
	stack_max = 1,
	on_use = minetest.item_eat(8, 'bucket:bucket_empty'),
})

-- cheese wedge
minetest.register_craftitem("mobs:cheese", {
	description = "Cheese",
	inventory_image = "mobs_cheese.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type = "cooking",
	output = "mobs:cheese",
	recipe = "mobs:bucket_milk",
	cooktime = 5,
	replacements = {{ "mobs:bucket_milk", "bucket:bucket_empty"}}
})

-- cheese block
minetest.register_node("mobs:cheeseblock", {
	description = "Cheese Block",
	tiles = {"mobs_cheeseblock.png"},
	is_ground_content = false,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = "mobs:cheeseblock",
	recipe = {
		{'mobs:cheese', 'mobs:cheese', 'mobs:cheese'},
		{'mobs:cheese', 'mobs:cheese', 'mobs:cheese'},
		{'mobs:cheese', 'mobs:cheese', 'mobs:cheese'},
	}
})

minetest.register_craft({
	output = "mobs:cheese 9",
	recipe = {
		{'mobs:cheeseblock'},
	}
})

-- Dung
-- O_o?

minetest.register_node("mobs:dung", {
	description = "Cow dung",
	tiles = {"mobs_dung.png"},
	inventory_image  = "mobs_dung.png",
	visual_scale = 0.7,
	drawtype = "plantlike",
	wield_image = "mobs_dung.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {snappy=2, dig_immediate=3},
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name="mobs:dung", param2=1})
		end
	end
})

minetest.register_craft({
	type = "fuel",
	recipe = "mobs:dung",
	burntime = "8",
})
