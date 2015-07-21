
local all_colours = {
	"grey", "black", "red", "yellow", "green", "cyan", "blue", "magenta",
	"orange", "violet", "brown", "pink", "dark_grey", "dark_green"
}

-- Sheep by PilzAdam

mobs:register_mob("mobs:sheep", {
	-- animal, monster, npc, barbarian
	type = "animal",
	-- not aggressive
	passive = true,
	-- health & armor
	hp_min = 10,
	hp_max = 15,
	armor = 200,
	-- textures and model
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.3, 0.4},
	visual = "mesh",
	mesh = "mobs_sheep.b3d",
	textures = {
		{"mobs_sheep.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=1,y=1},
	-- specific texture and mesh for gotten
	gotten_texture = {"mobs_sheep_shaved.png"},
	gotten_mesh = "mobs_sheep_shaved.b3d",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_sheep",
	},
	-- speed and jump
	walk_velocity = 1,
	run_velocity = 2,
	jump = true,
	-- drops raw meat when dead
	drops = {
		{name = "mobs:meat_raw",
		chance = 1, min = 2, max = 3},
		{name = "wool:white",
		chance = 1, min = 1, max = 1},
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
	replace_offset = -1,
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		local name = clicker:get_player_name()

		if item:get_name() == "farming:wheat" then
			-- take item
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
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
				self.gotten = false -- can be shaved again
				self.tamed = true
				-- make owner
				if self.owner == "" then
					self.owner = name
				end
				self.object:set_properties({
					textures = {"mobs_sheep.png"},
					mesh = "mobs_sheep.b3d",
				})
				minetest.sound_play("mobs_sheep", {
					object = self.object,
					gain = 1.0,
					max_hear_distance = 10,
					loop = false,
				})
			end
			return
		end

		if item:get_name() == "mobs:shears"
		and self.gotten == false
		and self.child == false then
			self.gotten = true -- shaved
			if minetest.registered_items["wool:white"] then
				local pos = self.object:getpos()
				pos.y = pos.y + 0.5
				local obj = minetest.add_item(pos, ItemStack("wool:white "..math.random(2,3)))
				if obj then
					obj:setvelocity({x=math.random(-1,1), y=5, z=math.random(-1,1)})
				end
				item:add_wear(650) -- 100 uses
				clicker:set_wielded_item(item)
			end
			self.object:set_properties({
				textures = {"mobs_sheep_shaved.png"},
				mesh = "mobs_sheep_shaved.b3d",
			})
			return
		end

		for _, col in ipairs(all_colours) do
			if item:get_name() == "dye:"..col
			and self.gotten == false
			and self.child == false
			and self.tamed == true
			and name == self.owner then
				local pos = self.object:getpos()
				self.object:remove()
				local mob = minetest.add_entity(pos, "mobs:sheep_"..col)
				local ent = mob:get_luaentity()
				ent.owner = clicker:get_player_name()
				ent.tamed = true
				-- take item
				if not minetest.setting_getbool("creative_mode") then
					item:take_item()
					clicker:set_wielded_item(item)
				end
				break
			else
				print ("not owner/tamed, cant dye sheep")
			end
		end

		mobs:capture_mob(self, clicker, 0, 5, 60, false, nil)
	end,
})
-- spawn on default;green grass between 20 and 8 light, 1 in 9000 chance, 1 sheep in area up to 31000 in height
mobs:spawn_specific("mobs:sheep", {"default:dirt_with_grass"}, {"air"}, 8, 20, 30, 10000, 1, -31000, 31000, true)
-- register spawn egg
mobs:register_egg("mobs:sheep", "Sheep", "wool_white.png", 1)

-- shears (right click sheep to shear wool)
minetest.register_tool("mobs:shears", {
	description = "Steel Shears (right-click sheep to shear)",
	inventory_image = "mobs_shears.png",
	tool_capabilities = {				-- Modif MFF /DEBUT
		full_punch_interval = 1,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=0},
	}
})							-- Modif MFF /FIN

minetest.register_craft({
	output = 'mobs:shears',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'', 'group:stick', 'default:steel_ingot'},
	}
})

-- Coloured sheep

for _, col in ipairs(all_colours) do

mobs:register_mob("mobs:sheep_"..col, {
	type = "animal",
	passive = true,
	hp_min = 8,
	hp_max = 10,
	armor = 200,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.3, 0.4},
	visual = "mesh",
	mesh = "mobs_sheep.b3d",
	textures = {
		{"mobs_sheep_"..col..".png"},
	},
	gotten_texture = {"mobs_sheep_shaved.png"},
	gotten_mesh = "mobs_sheep_shaved.b3d",
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_sheep",
	},
	walk_velocity = 1,
	jump = true,
	drops = {
		{name = "mobs:meat_raw",
		chance = 1, min = 2, max = 3},
		{name = "wool:"..col,
		chance = 1, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 80,
		walk_start = 81,
		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
	replace_rate = 50,
	replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "farming:wheat_8"},
	replace_with = "air",
	replace_offset = -1,
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		local name = clicker:get_player_name()

		if item:get_name() == "farming:wheat" then
			-- take item
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
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
				self.gotten = false -- can be shaved again
				self.tamed = true
				-- make owner
				if self.owner == "" then
					self.owner = name
				end
				self.object:set_properties({
					textures = {"mobs_sheep_"..col..".png"},
					mesh = "mobs_sheep.b3d",
				})
				minetest.sound_play("mobs_sheep", {
					object = self.object,
					gain = 1.0,
					max_hear_distance = 10,
					loop = false,
				})
			end
			return
		end

		if item:get_name() == "mobs:shears"
		and self.gotten == false
		and self.child == false then
			self.gotten = true -- shaved
			if minetest.registered_items["wool:"..col] then
				local pos = self.object:getpos()
				pos.y = pos.y + 0.5
				local obj = minetest.add_item(pos, ItemStack("wool:"..col.." "..math.random(2,3)))
				if obj then
					obj:setvelocity({x = math.random(-1,1), y = 5, z = math.random(-1,1)})
				end
				item:add_wear(650) -- 100 uses
				clicker:set_wielded_item(item)
			end
			self.object:set_properties({
				textures = {"mobs_sheep_shaved.png"},
				mesh = "mobs_sheep_shaved.b3d",
			})
			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 60, false, nil)

	end,
})

mobs:register_egg("mobs:sheep_"..col, "Sheep ("..col..")", "wool_"..col..".png", 1)

end
