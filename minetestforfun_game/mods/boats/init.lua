--
-- Helper functions
--

boats = {}

function boats.is_water(pos)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, "water") ~= 0
end

function boats.get_sign(i)
	if i == 0 then
		return 0
	else
		return i / math.abs(i)
	end
end

function boats.get_velocity(v, yaw, y)
	local x = -math.sin(yaw) * v
	local z =  math.cos(yaw) * v
	return {x = x, y = y, z = z}
end

function boats.get_v(v)
	return math.sqrt(v.x ^ 2 + v.z ^ 2)
end

function boats.on_rightclick(self, clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	local name = clicker:get_player_name()
	if self.driver and clicker == self.driver then
		self.driver = nil
		clicker:set_detach()
		default.player_attached[name] = false
		default.player_set_animation(clicker, "stand" , 30)
		local pos = clicker:getpos()
		pos = {x = pos.x, y = pos.y + 0.2, z = pos.z}
		minetest.after(0.1, function()
			clicker:setpos(pos)
		end)
	elseif not self.driver then
		local attach = clicker:get_attach()
		if attach and attach:get_luaentity() then
			local luaentity = attach:get_luaentity()
			if luaentity.driver then
				luaentity.driver = nil
			end
		end
		clicker:set_detach()
	end
	self.driver = clicker
	clicker:set_attach(self.object, "", {x = 0, y = 11, z = -3}, {x = 0, y = 0, z = 0})
	default.player_attached[name] = true
	minetest.after(0.2, function()
		default.player_set_animation(clicker, "sit" , 30)
	end)
	self.object:setyaw(clicker:get_look_yaw() - math.pi / 2)
end


function boats.on_activate(self, staticdata, dtime_s)
	self.object:set_armor_groups({immortal = 1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
	self.last_v = self.v
end


function boats.get_staticdata(self)
	return tostring(self.v)
end


function boats.on_punch(self, puncher)
	if not puncher or not puncher:is_player() or self.removed then
		return
	end
	if self.driver and puncher == self.driver then
		self.driver = nil
		puncher:set_detach()
		default.player_attached[puncher:get_player_name()] = false
	end
	if not self.driver then
		self.removed = true
		-- delay remove to ensure player is detached
		minetest.after(0.1, function()
			self.object:remove()
		end)
		if not minetest.setting_getbool("creative_mode") then
			local inv = puncher:get_inventory()
			if inv:room_for_item("main", "boats:" .. self.parameters.name) then
				inv:add_item("main", "boats:" .. self.parameters.name)
			else
				minetest.add_item(self.object:getpos(), "boats:" .. self.parameters.name)
			end
		end
	end
end

function boats.on_step(self, dtime)
	self.v = boats.get_v(self.object:getvelocity()) * boats.get_sign(self.v)
	if self.driver then
		local ctrl = self.driver:get_player_control()
		local yaw = self.object:getyaw()
		if ctrl.up then
			self.v = self.v + self.parameters.controls.up or 0.1
		elseif ctrl.down then
			self.v = self.v - self.parameters.controls.down or 0.08
		end
		if ctrl.left then
			if self.v < 0 then
				self.object:setyaw(yaw - (1 + dtime) * (0.03 * (self.parameters.controls.rotate or 1)))
			else
				self.object:setyaw(yaw + (1 + dtime) * (0.03 * (self.parameters.controls.rotate or 1)))
			end
		elseif ctrl.right then
			if self.v < 0 then
				self.object:setyaw(yaw + (1 + dtime) * (0.03 * (self.parameters.controls.rotate or 1)))
			else
				self.object:setyaw(yaw - (1 + dtime) * (0.03 * (self.parameters.controls.rotate or 1)))
			end
		end
	end
	local velo = self.object:getvelocity()
	if self.v == 0 and velo.x == 0 and velo.y == 0 and velo.z == 0 then
		self.object:setpos(self.object:getpos())
		return
	end
	local s = boats.get_sign(self.v)
	self.v = self.v - 0.02 * s
	if s ~= boats.get_sign(self.v) then
		self.object:setvelocity({x = 0, y = 0, z = 0})
		self.v = 0
		return
	end
	if math.abs(self.v) > 4.5 then
		self.v = 4.5 * boats.get_sign(self.v)
	end

	local p = self.object:getpos()
	p.y = p.y - 0.5
	local new_velo = {x = 0, y = 0, z = 0}
	local new_acce = {x = 0, y = 0, z = 0}
	if not boats.is_water(p) then
		local nodedef = minetest.registered_nodes[minetest.get_node(p).name]
		if (not nodedef) or nodedef.walkable then
			self.v = 0
			new_acce = {x = 0, y = 1, z = 0}
		else
			new_acce = {x = 0, y = -9.8, z = 0} -- freefall in air -9.81
		end
		new_velo = boats.get_velocity(self.v, self.object:getyaw(),
		self.object:getvelocity().y)
		self.object:setpos(self.object:getpos())
	else
		p.y = p.y + 1
		if boats.is_water(p) then
			local y = self.object:getvelocity().y
			if y >= 4.5 then
				y = 4.5
			elseif y < 0 then
				new_acce = {x = 0, y = 20, z = 0}
			else
				new_acce = {x = 0, y = 5, z = 0}
			end
			new_velo = boats.get_velocity(self.v, self.object:getyaw(), y)
			self.object:setpos(self.object:getpos())
		else
			new_acce = {x = 0, y = 0, z = 0}
			if math.abs(self.object:getvelocity().y) < 1 then
				local pos = self.object:getpos()
				pos.y = math.floor(pos.y) + 0.5
				self.object:setpos(pos)
				new_velo = boats.get_velocity(self.v, self.object:getyaw(), 0)
			else
				new_velo = boats.get_velocity(self.v, self.object:getyaw(),
				self.object:getvelocity().y)
				self.object:setpos(self.object:getpos())
			end
		end
	end
	self.object:setvelocity(new_velo)
	self.object:setacceleration(new_acce)
end

boats.register_boat = function(parameters)
	minetest.register_entity("boats:" .. parameters.name, {
		physical = true,
		collisionbox = {-0.5, -0.35, -0.5, 0.5, 0.3, 0.5},
		visual = "mesh",
		mesh = "boat.obj",
		textures = {parameters.texture or "default_wood.png"},

		parameters = parameters,
		driver = nil,
		v = 0,
		last_v = 0,
		removed = false,

		on_rightclick = boats.on_rightclick,
		on_activate = boats.on_activate,
		get_staticdata = boats.get_staticdata,
		on_punch = boats.on_punch,
		on_step = boats.on_step
	})

	minetest.register_craftitem("boats:" .. parameters.name, {
		description = parameters.description or "Boat",
		inventory_image = "boats_" .. parameters.name .. "_inventory.png",
		wield_image = "boats_" .. parameters.name .. "_wield.png",
		wield_scale = {x = 2, y = 2, z = 1},
		liquids_pointable = true,

		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return
			end
			if not boats.is_water(pointed_thing.under) then
				return
			end
			pointed_thing.under.y = pointed_thing.under.y + 0.5
			minetest.add_entity(pointed_thing.under, "boats:"..parameters.name)
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
			return itemstack
		end,
	})
end


boats.register_boat({
	name = "boat",
	texture = "default_wood.png",
	controls = {
		up = 0.1,
		down = 0.08,
		rotate = 0.75
	},
	description = "Boat"
})

boats.register_boat({
	name = "race",
	texture = "default_gravel.png",
	controls = {
		up = 0.2,
		down = 0.18,
		rotate = 1
	},
	description = "Race boat"
})

boats.register_boat({
	name = "expert_race",
	texture = "default_desert_stone.png",
	controls = {
		up = 0.25,
		down = 0.25,
		rotate = 4
	},
	description = "Expert race boat"
})


boats.register_boat({
	name = "water",
	texture = "default_water.png",
	controls = {
		up = 0.3,
		down = 0.24,
		rotate = 4
	},
	description = "Water boat"
})

boats.register_boat({
	name = "moon",
	texture = "boats_moon.png",
	controls = {
		up = 0.5,
		down = 0.1,
		rotate = 8
	},
	description = "Moon boat"
})

-- Craft registrations

minetest.register_craft({
	output = "boats:moon",
	recipe = {
		{"default:obsidian", "", "default:obsidian"},
		{"default:dirt", "default:leaves", "default:dirt"},
	},
})

minetest.register_craft({
	output = "boats:expert_race",
	recipe = {
		{"default:desert_stone", "", "default:desert_stone"},
		{"default:desert_stone", "default:mese", "default:desert_stone"},
	},
})

minetest.register_craft({
	output = "boats:race",
	recipe = {
		{"default:gravel", "", "default:gravel"},
		{"default:gravel", "default:steelblock", "default:gravel"},
	},
})

minetest.register_craft({
	output = "boats:water",
	recipe = {
		{"default:glass", "", "default:glass"},
		{"default:glass", "bucket:bucket_water", "default:glass"},
	},
})


minetest.register_craft({
	output = "boats:boat",
	recipe = {
		{"",           "",           ""          },
		{"group:wood", "",           "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	},
})
