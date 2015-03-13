--pyramids = {}

local mummy_walk_limit = 1
local mummy_chillaxin_speed = 1
local mummy_animation_speed = 10
-- Note: This is currently broken due to a bug in Irrlicht, leave at 0
local mummy_animation_blend = 0

-- Default player appearance
local mummy_mesh = "tsm_pyramids_mummy.x"
local mummy_texture = {"tsm_pyramids_mummy.png"}
local mummy_hp = 20
local mummy_drop = "default:papyrus"

local sound_normal = "mummy"
local sound_hit = "mummy_hurt"
local sound_dead = "mummy_death"

local spawner_range = 17
local spawner_max_mobs = 6

local function get_animations()
	return {
		stand_START = 74,
		stand_END = 74,
		sit_START = 81,
		sit_END = 160,
		lay_START = 162,
		lay_END = 166,
		walk_START = 74,
		walk_END = 105,
		mine_START = 74,
		mine_END = 105,
		walk_mine_START = 74,
		walk_mine_END = 105
	}
end

local npc_model = {}
local npc_anim = {}
local npc_sneak = {}
local ANIM_STAND = 1
local ANIM_SIT = 2
local ANIM_LAY = 3
local ANIM_WALK  = 4
local ANIM_WALK_MINE = 5
local ANIM_MINE = 6

function hit(self)
	prop = {
		mesh = mummy_mesh,
		textures = {"tsm_pyramids_mummy.png^tsm_pyramids_hit.png"},
	}
	self.object:set_properties(prop)
	minetest.after(0.4, function()
		prop = {textures = mummy_texture,}
		self.object:set_properties(prop)
	end)
end

function mummy_update_visuals_def(self)
	--local name = get_player_name()
	visual = default_model_def
	npc_anim = 0 -- Animation will be set further below immediately
	--npc_sneak[name] = false
	prop = {
		mesh = mummy_mesh,
		textures = mummy_texture,
		--visual_size = {x=1, y=1, z=1},
	}
	self.object:set_properties(prop)
end

MUMMY_DEF = {
	physical = true,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	visual_size = {x=8,y=8},
	mesh = mummy_mesh,
	textures = mummy_texture,
	makes_footstep_sound = true,
	npc_anim = 0,
	timer = 0,
	turn_timer = 0,
	vec = 0,
	yaw = 0,
	yawwer = 0,
	state = 1,
	jump_timer = 0,
	punch_timer = 0,
	sound_timer = 0,
	attacker = "",
	attacking_timer = 0,
	mob_name = "mummy"
}

spawner_DEF = {
	hp_max = 1,
	physical = true,
	collisionbox = {0,0,0,0,0,0},
	visual = "mesh",
	visual_size = {x=3.3,y=3.3},
	mesh = mummy_mesh,
	textures = mummy_texture,
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

MUMMY_DEF.on_activate = function(self)
	mummy_update_visuals_def(self)
	self.anim = get_animations()
	self.object:set_animation({x=self.anim.stand_START,y=self.anim.stand_END}, mummy_animation_speed, mummy_animation_blend)
	self.npc_anim = ANIM_STAND
	self.object:setacceleration({x=0,y=-20,z=0})--20
	self.state = 1
	self.object:set_hp(mummy_hp)
	self.object:set_armor_groups({fleshy=130})
end

MUMMY_DEF.on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)

	--attack as group
	--[[for  _,object in ipairs(minetest.env:get_objects_inside_radius(self.object:getpos(), 5)) do
		if not object:is_player() then
			if object:get_luaentity().name == "peaceful_npc:npc_def" then
				object:get_luaentity().state = 3
				object:get_luaentity().attacker = puncher:get_player_name()
			end
		end
	end]]

	--if self.state ~= 3 then
		--self.state = 3
		self.attacker = puncher--:get_player_name()
	--end

	if puncher ~= nil then
		local sound = sound_hit
		if self.object:get_hp() == 0 then sound = sound_dead end
		minetest.sound_play(sound, {to_player = puncher:get_player_name(), loop = false, gain = 0.3})
		if time_from_last_punch >= 0.45 then
			hit(self)
			--local dir = puncher:get_look_dir()
		--self.direction = dir
			self.direction = {x=self.object:getvelocity().x, y=self.object:getvelocity().y, z=self.object:getvelocity().z}
			self.punch_timer = 0
			self.object:setvelocity({x=dir.x*mummy_chillaxin_speed,y=5,z=dir.z*mummy_chillaxin_speed})--self.object:setvelocity({x=dir.x*4,y=5,z=dir.z*4})
			if self.state == 1 then
				self.state = 8
			elseif self.state >= 2 then
				self.state = 9
			end
		end
	end

	if self.object:get_hp() == 0 then
	    local obj = minetest.env:add_item(self.object:getpos(), mummy_drop.." "..math.random(0,3))
	end
end

	local cnt1 = 0
	local cnt2 = 0

MUMMY_DEF.on_step = function(self, dtime)
	self.timer = self.timer + 0.01
	self.turn_timer = self.turn_timer + 0.01
	self.jump_timer = self.jump_timer + 0.01
	self.punch_timer = self.punch_timer + 0.01
	self.attacking_timer = self.attacking_timer + 0.01
	self.sound_timer = self.sound_timer + 0.01

	local current_pos = self.object:getpos()
	local current_node = minetest.env:get_node(current_pos)
	if self.time_passed == nil then
		self.time_passed = 0
	end

	--self.time_passed = self.time_passed + dtime
	if self.object:get_hp() == 0 then-- self.object:remove() end

	--if self.time_passed >= 5 then
		minetest.sound_play(sound_dead, {pos = current_pos, max_hear_distance = 10 , gain = 0.3})
		self.object:remove()
	end--else
	 if current_node.name == "default:water_source" or current_node.name == "default:water_flowing" or current_node.name == "default:lava_source" or current_node.name == "default:lava_flowing" then
		--self.time_passed =  self.time_passed + dtime
		self.sound_timer = self.sound_timer + dtime
		if self.sound_timer >= 0.8 then
			self.sound_timer = 0
			self.object:set_hp(self.object:get_hp()-5)
			hit(self)
			minetest.sound_play(sound_hit, {pos = current_pos, max_hear_distance = 10, gain = 0.3})
		end
	 else
		self.time_passed = 0
	 end
	--end

	--update moving state every 1 or 2 seconds
	if self.state < 3 then
		if self.timer > math.random(1,2) then
			if self.attacker == "" then
				self.state = math.random(1,2)
			else self.state = 1 end
			self.timer = 0
		end
	end

	--play sound
	if self.sound_timer > math.random(5,35) then
		minetest.sound_play(sound_normal, {pos = current_pos, max_hear_distance = 10, gain = 0.2})
		self.sound_timer = 0
	end

	--after punched
	if self.state >= 8 then
		if self.punch_timer > 0.15 then
			--self.direction = {x = math.sin(self.yaw)*-1, y = -20, z = math.cos(self.yaw)}
			if self.state == 9 then
				self.object:setvelocity({x=self.direction.x*mummy_chillaxin_speed,y=-20,z=self.direction.z*mummy_chillaxin_speed})
				self.state = 2
			elseif self.state == 8 then
				self.object:setvelocity({x=0,y=-20,z=0})
				self.state = 1
			end
		end
	end

	--STANDING
	if self.state == 1 then
		self.yawwer = true
		self.attacker = ""
		for  _,object in ipairs(minetest.env:get_objects_inside_radius(self.object:getpos(), 4)) do
			if object:is_player() then
				self.yawwer = false
				NPC = self.object:getpos()
				PLAYER = object:getpos()
				self.vec = {x=PLAYER.x-NPC.x, y=PLAYER.y-NPC.y, z=PLAYER.z-NPC.z}
				self.yaw = math.atan(self.vec.z/self.vec.x)+math.pi^2
				if PLAYER.x > NPC.x then
					self.yaw = self.yaw + math.pi
				end
				self.yaw = self.yaw - 2
				self.object:setyaw(self.yaw)
				self.attacker = object--:get_player_name()
			end
		end

		if self.attacker == "" and self.turn_timer > math.random(1,4) then--and yawwer == true then
			self.yaw = 360 * math.random()
			self.object:setyaw(self.yaw)
			self.turn_timer = 0
			self.direction = {x = math.sin(self.yaw)*-1, y = -20, z = math.cos(self.yaw)}
		end
		self.object:setvelocity({x=0,y=self.object:getvelocity().y,z=0})
		if self.npc_anim ~= ANIM_STAND then
			self.anim = get_animations()
			self.object:set_animation({x=self.anim.stand_START,y=self.anim.stand_END}, mummy_animation_speed, mummy_animation_blend)
			self.npc_anim = ANIM_STAND
		end
		if self.attacker ~= "" then
			self.direction = {x = math.sin(self.yaw)*-1, y = -20, z = math.cos(self.yaw)}
			self.state = 2
		end
	end
	--WALKING
	if self.state == 2 then

		if self.direction ~= nil then
			self.object:setvelocity({x=self.direction.x*mummy_chillaxin_speed,y=self.object:getvelocity().y,z=self.direction.z*mummy_chillaxin_speed})
		end
		if self.turn_timer > math.random(1,4) and not self.attacker then
			self.yaw = 360 * math.random()
			self.object:setyaw(self.yaw)
			self.turn_timer = 0
			self.direction = {x = math.sin(self.yaw)*-1, y = -20, z = math.cos(self.yaw)}
			--self.object:setvelocity({x=self.direction.x,y=self.object:getvelocity().y,z=direction.z})
			--self.object:setacceleration(self.direction)
		end
		if self.npc_anim ~= ANIM_WALK then
			self.anim = get_animations()
			self.object:set_animation({x=self.anim.walk_START,y=self.anim.walk_END}, mummy_animation_speed, mummy_animation_blend)
			self.npc_anim = ANIM_WALK
		end
		--[[jump
		if self.direction ~= nil then
			if self.jump_timer > 0.3 then
				if minetest.env:get_node({x=self.object:getpos().x + self.direction.x,y=self.object:getpos().y-1,z=self.object:getpos().z + self.direction.z}).name ~= "air" then
					self.object:setvelocity({x=self.object:getvelocity().x,y=5,z=self.object:getvelocity().z})
					self.jump_timer = 0
				end
			end
		end]]

		if self.attacker ~= "" and minetest.setting_getbool("enable_damage") then
			local s = self.object:getpos()
			local p = self.attacker:getpos()
			if (s ~= nil and p ~= nil) then
				local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5

				if dist < 2 and self.attacking_timer > 0.6 then
				self.attacker:punch(self.object, 1.0,  {
					full_punch_interval=1.0,
					damage_groups = {fleshy=1}
				})
					self.attacking_timer = 0
				end
			end
		end
	end
end

minetest.register_entity("tsm_pyramids:mummy", MUMMY_DEF)
minetest.register_entity("tsm_pyramids:mummy_spawner", spawner_DEF)


--spawn-egg/spawner

minetest.register_craftitem("tsm_pyramids:spawn_egg", {
	description = "Mummy spawn-egg",
	inventory_image = "tsm_pyramids_mummy_egg.png",
	liquids_pointable = false,
	stack_max = 99,
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type == "node" then
			minetest.env:add_entity(pointed_thing.above,"tsm_pyramids:mummy")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			return itemstack
		end
	end,

})

function pyramids.spawn_mummy (pos, number)
	for i=0,number do
		minetest.env:add_entity(pos,"tsm_pyramids:mummy")
	end
end

minetest.register_node("tsm_pyramids:spawner_mummy", {
	description = "Mummy spawner",
	paramtype = "light",
	tiles = {"tsm_pyramids_spawner.png"},
	is_ground_content = true,
	drawtype = "allfaces",--_optional",
	groups = {cracky=1,level=1},
	drop = "",
	on_construct = function(pos)
		pos.y = pos.y - 0.28
		minetest.env:add_entity(pos,"tsm_pyramids:mummy_spawner")
	end,
	on_destruct = function(pos)
		for  _,obj in ipairs(minetest.env:get_objects_inside_radius(pos, 1)) do
			if not obj:is_player() then 
				if obj ~= nil and obj:get_luaentity().m_name == "dummy" then
					obj:remove()	
				end
			end
		end
	end
})
if not minetest.setting_getbool("only_peaceful_mobs") then
 minetest.register_abm({
	nodenames = {"tsm_pyramids:spawner_mummy"},
	interval = 2.0,
	chance = 20,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local player_near = false
		local mobs = 0
		for  _,obj in ipairs(minetest.env:get_objects_inside_radius(pos, spawner_range)) do
			if obj:is_player() then
				player_near = true 
			else
				if obj:get_luaentity().mob_name == "mummy" then mobs = mobs + 1 end
			end
		end
		if player_near then
			if mobs < spawner_max_mobs then
				pos.x = pos.x+1
				local p = minetest.find_node_near(pos, 5, {"air"})	
				minetest.env:add_entity(p,"tsm_pyramids:mummy")
			end
		end
	end
 })
end
	
