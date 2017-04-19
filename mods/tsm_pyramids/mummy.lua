-- Pyramid mummy

mobs:register_mob("tsm_pyramids:mummy", {
	-- animal, monster, npc, barbarian
	type = "monster",
	-- aggressive, deals 4 damage to player when hit
	passive = false,
	attack_type = "dogfight",
	damage = 4,
	-- health & armor
	hp_min = 15, hp_max = 20, armor = 100,
	-- textures and model
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "tsm_pyramids_mummy.x",
	drawtype = "front",
	textures = {
		{"tsm_pyramids_mummy.png"},
	},
	visual_size = {x=8,y=8},
	blood_texture = "default_sand.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "mummy",
	},
	-- speed and jump, sinks in water
	walk_velocity = 0.4,
	run_velocity = 0.8,
	view_range = 16,
	jump = false,
	floats = 0,
	knock_back = 0.1,		--this is a test
	-- drops papyrus when dead
	drops = {
		{name = "default:papyrus",
		chance = 2, min = 4, max = 6,},
		{name = "maptools:silver_coin",
		chance = 10, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 0,
	lava_damage = 15,
	light_damage = 15,
	-- model animation
	animation = {
		speed_normal = 15,		speed_run = 15,
		stand_start = 74,		stand_end = 74,
		walk_start = 74,		walk_end = 105,
		run_start = 74,			run_end = 105,
		punch_start = 74,		punch_end = 105,
		sit_start = 81,			sit_end = 160,
		lay_start = 162,		lay_end = 166,
		mine_start = 74,		mine_end = 105,
		walk_mine_start = 74,	walk_mine_end = 105,
	},
})

--MFF ABM to replace old maptools:chest
minetest.register_abm({
	nodenames = {"tsm_pyramids:spawner_mummy"},
	interval = 10.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local chests = minetest.find_nodes_in_area(
						{x=pos.x-4, y=pos.y-3, z=pos.z-10},
						{x=pos.x+4, y=pos.y, z=pos.z},
						"maptools:chest"
					)
		for _, cpos in ipairs(chests) do
			local p2 = 0
			local n = minetest.get_node_or_nil(cpos)
			if n and n.param2 then
				p2 = n.param2
			end
			minetest.set_node(cpos, {name="tsm_pyramids:chest", param2=p2})
		end
	end
})
-- spawner (spawn in pyramids, near the spawner)
if not minetest.setting_getbool("only_peaceful_mobs") then
 minetest.register_abm({
	nodenames = {"tsm_pyramids:spawner_mummy"},
	interval = 10.0,
	chance = 20,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local player_near = false
		local mobs = 0
		for  _,obj in ipairs(minetest.get_objects_inside_radius(pos, 17)) do
			if obj then
				if obj:is_player() then
					player_near = true
				else
					if obj:get_luaentity() and obj:get_luaentity().mob_name == "mummy" then mobs = mobs + 1 end
				end
			end
		end
		if player_near then
			if mobs < 6 then
				pos.x = pos.x+1
				local p = minetest.find_node_near(pos, 5, {"air"})
				minetest.add_entity(p,"tsm_pyramids:mummy")
			end
		end
	end
 })
end

function pyramids.spawn_mummy (pos, number)
	for i=0,number do
		minetest.add_entity(pos,"tsm_pyramids:mummy")
	end
end

minetest.register_node("tsm_pyramids:spawner_mummy", {
	description = "Mummy spawner",
	paramtype = "light",
	tiles = {"tsm_pyramids_spawner.png"},
	is_ground_content = true,
	drawtype = "allfaces",--_optional",
	groups = {unbreakable=1},
	drop = "",
	on_construct = function(pos)
		pos.y = pos.y - 0.28
		minetest.add_entity(pos,"tsm_pyramids:mummy_spawner")
	end,
	on_destruct = function(pos)
		for  _,obj in ipairs(minetest.get_objects_inside_radius(pos, 1)) do
			if not obj:is_player() then
				if obj ~= nil and obj:get_luaentity().m_name == "dummy" then
					obj:remove()
				end
			end
		end
	end
})

-- register spawn egg
minetest.register_craftitem("tsm_pyramids:spawn_egg", {
	description = "Mummy spawn-egg",
	inventory_image = "tsm_pyramids_mummy_egg.png",
	liquids_pointable = false,
	stack_max = 99,
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type == "node" then
			minetest.add_entity(pointed_thing.above,"tsm_pyramids:mummy")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			return itemstack
		end
	end,
})

 -- Spawner entity

spawner_DEF = {
	hp_max = 1,
	physical = true,
	collisionbox = {0,0,0,0,0,0},
	visual = "mesh",
	visual_size = {x=3.3,y=3.3},
	mesh = "tsm_pyramids_mummy.x",
	textures = {"tsm_pyramids_mummy.png"},
	makes_footstep_sound = false,
	timer = 0,
	automatic_rotate = math.pi * 2.9,
	m_name = "dummy"
}

spawner_DEF.on_activate = function(self)
	mummy_update_visuals_def(self)
	self.object:setvelocity({x=0, y=0, z=0})
	self.object:setacceleration({x=0, y=0, z=0})
	self.object:set_armor_groups({immortal=1})

end

spawner_DEF.on_step = function(self, dtime)
	self.timer = self.timer + 0.01
	local n = minetest.get_node_or_nil(self.object:getpos())
	if self.timer > 1 then
		if n and n.name and n.name ~= "tsm_pyramids:spawner_mummy" then
			self.object:remove()
		end
	end
end

spawner_DEF.on_punch = function(self, hitter)

end

minetest.register_entity("tsm_pyramids:mummy_spawner", spawner_DEF)

function mummy_update_visuals_def(self)
	--local name = get_player_name()
	-- visual = default_model_def
	self.npc_anim = 0 -- Animation will be set further below immediately
	--npc_sneak[name] = false
	local prop = {
		mesh = self.mesh,
		textures = self.textures,
		--visual_size = {x=1, y=1, z=1},
	}
	self.object:set_properties(prop)
end
