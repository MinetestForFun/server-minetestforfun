local time = tonumber(os.clock())+10
local lastpos = vector.zero or {x=0, y=0, z=0}
local last_tab, always_test

if not core.get_gravity then
	local gravity,grav_updating = 10
	function core.get_gravity()
		if not grav_updating then
			gravity = tonumber(core.setting_get("movement_gravity")) or gravity
			grav_updating = true
			core.after(50, function()
				grav_updating = false
			end)
		end
		return gravity
	end
	local set_setting = core.setting_set
	function core.setting_set(name, v, ...)
		if name == "gravity" then
			name = "movement_gravity"
			gravity = tonumber(v) or gravity
		end
		return set_setting(name, v, ...)
	end
	local get_setting = core.setting_get
	function core.setting_get(name, ...)
		if name == "gravity" then
			name = "movement_gravity"
		end
		return get_setting(name, ...)
	end
end

local function get_nodes(pos)
	if not always_test then
		local rnd_pos = vector.round(pos)
		local t = tonumber(os.clock())
		if vector.equals(rnd_pos, lastpos)
		and t-time < 10 then
			return last_tab
		end
		time = t
		lastpos = rnd_pos
		local near_objects = minetest.get_objects_inside_radius(pos, 1)
		if #near_objects >= 2 then
			always_test = true
			minetest.after(10, function() always_test = false end)
		end
	end
	local tab,n = {},1
	for i = -1,1,2 do
		for _,p in pairs({
			{x=pos.x+i, y=pos.y, z=pos.z},
			{x=pos.x, y=pos.y, z=pos.z+i}
		}) do
			tab[n] = {p, minetest.get_node(p)}
			n = n+1
		end
	end
	if not always_test then
		last_tab = tab
	end
	return tab
end

local function get_flowing_dir(pos)
	local data = get_nodes(pos) or {}
	local param2 = minetest.get_node(pos).param2
	if param2 > 7 then
		return
	end
	for _,i in pairs(data) do
		local nd = i[2]
		local name = nd.name
		local par2 = nd.param2
		if name == "default:water_flowing"
		and par2 < param2 then
			return i[1]
		end
	end
	for _,i in pairs(data) do
		local nd = i[2]
		local name = nd.name
		local par2 = nd.param2
		if name == "default:water_flowing"
		and par2 >= 11 then
			return i[1]
		end
	end
	for _,i in pairs(data) do
		local nd = i[2]
		local name = nd.name
		local par2 = nd.param2
		local tmp = minetest.registered_nodes[name]
		if tmp
		and not tmp.walkable
		and name ~= "default:water_flowing" then
			return i[1]
		end
	end
end

local item_entity = minetest.registered_entities["__builtin:item"]
local old_on_step = item_entity.on_step or function()end

item_entity.on_step = function(self, dtime)
	old_on_step(self, dtime)

	local p = self.object:getpos()

	local name = minetest.get_node(p).name
	if name == "default:lava_flowing"
	or name == "default:lava_source" then
		minetest.sound_play("builtin_item_lava", {pos=p})
		minetest.add_particlespawner({
			amount = 3,
			time = 0.1,
			minpos = {x=p.x, y=p.y, z=p.z},
			maxpos = {x=p.x, y=p.y+0.2, z=p.z},
			minacc = {x=-0.5,y=5,z=-0.5},
			maxacc = {x=0.5,y=5,z=0.5},
			minexptime = 0.1,
			minsize = 2,
			maxsize = 4,
			texture = "smoke_puff.png"
		})
		minetest.add_particlespawner ({
			amount = 1, time = 0.4,
			minpos = {x = p.x, y= p.y + 0.25, z= p.z},
			maxpos = {x = p.x, y= p.y + 0.5, z= p.z},
			minexptime = 0.2, maxexptime = 0.4,
			minsize = 4, maxsize = 6,
			collisiondetection = false,
			vertical = false,
			texture = "fire_basic_flame.png",
		})
		self.object:remove()
		return
	end

	local tmp = minetest.registered_nodes[name]
	if tmp
	and tmp.liquidtype == "flowing" then
		local vec = get_flowing_dir(self.object:getpos())
		if vec then
			local v = self.object:getvelocity()
			if vec.x-p.x > 0 then
				self.object:setvelocity({x=0.5,y=v.y,z=0})
			elseif vec.x-p.x < 0 then
				self.object:setvelocity({x=-0.5,y=v.y,z=0})
			elseif vec.z-p.z > 0 then
				self.object:setvelocity({x=0,y=v.y,z=0.5})
			elseif vec.z-p.z < 0 then
				self.object:setvelocity({x=0,y=v.y,z=-0.5})
			end
			self.object:setacceleration({x=0, y=-core.get_gravity(), z=0})
			self.physical_state = true
			self.object:set_properties({
				physical = true
			})
		end
	end
end

minetest.register_entity(":__builtin:item", item_entity)

if minetest.setting_get("log_mods") then
	minetest.log("action", "builtin_item loaded")
end
