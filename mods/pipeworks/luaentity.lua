local max_entity_id = 1000000000000 -- If you need more, there's a problem with your code

luaentity = {}

luaentity.registered_entities = {}

local filename = minetest.get_worldpath().."/luaentities"
local function read_file()
	local f = io.open(filename, "r")
	if f == nil then return {} end
    	local t = f:read("*all")
    	f:close()
	if t == "" or t == nil then return {} end
	return minetest.deserialize(t)
end

local function write_file(tbl)
	local f = io.open(filename, "w")
    	f:write(minetest.serialize(tbl))
    	f:close()
end

local function read_entities()
	local t = read_file()
	for _, entity in pairs(t) do
		setmetatable(entity, luaentity.registered_entities[entity.name])
	end
	return t
end

local function write_entities()
	for _, entity in pairs(luaentity.entities) do
		setmetatable(entity, nil)
		for _, attached in pairs(entity._attached_entities) do
			if attached.entity then
				attached.entity:remove()
				attached.entity = nil
			end
		end
		entity._attached_entities_master = nil
	end
	write_file(luaentity.entities)
end

minetest.register_on_shutdown(write_entities)
luaentity.entities_index = 0

local function get_blockpos(pos)
	return {x = math.floor(pos.x / 16),
	        y = math.floor(pos.y / 16),
	        z = math.floor(pos.z / 16)}
end

local active_blocks = {} -- These only contain active blocks near players (i.e., not forceloaded ones)
local handle_active_blocks_step = 2
local handle_active_blocks_timer = 0
minetest.register_globalstep(function(dtime)
	handle_active_blocks_timer = handle_active_blocks_timer + dtime
	if handle_active_blocks_timer >= handle_active_blocks_step then
		handle_active_blocks_timer = handle_active_blocks_timer - handle_active_blocks_step
		local active_block_range = tonumber(minetest.setting_get("active_block_range")) or 2
		local new_active_blocks = {}
		for _, player in ipairs(minetest.get_connected_players()) do
			local blockpos = get_blockpos(player:getpos())
			local minp = vector.subtract(blockpos, active_block_range)
			local maxp = vector.add(blockpos, active_block_range)

			for x = minp.x, maxp.x do
			for y = minp.y, maxp.y do
			for z = minp.z, maxp.z do
				local pos = {x = x, y = y, z = z}
				new_active_blocks[minetest.hash_node_position(pos)] = pos
			end
			end
			end
		end
		active_blocks = new_active_blocks
		-- todo: callbacks on block load/unload
	end
end)

local function is_active(pos)
	return active_blocks[minetest.hash_node_position(get_blockpos(pos))] ~= nil
end

local entitydef_default = {
	_attach = function(self, attached, attach_to)
		local attached_def = self._attached_entities[attached]
		local attach_to_def = self._attached_entities[attach_to]
		attached_def.entity:set_attach(
			attach_to_def.entity, "",
			vector.subtract(attached_def.offset, attach_to_def.offset), -- todo: Does not work because is object space
			vector.new(0, 0, 0)
		)
	end,
	_set_master = function(self, index)
		self._attached_entities_master = index
		if not index then
			return
		end
		local def = self._attached_entities[index]
		if not def.entity then
			return
		end
		def.entity:setpos(vector.add(self._pos, def.offset))
		def.entity:setvelocity(self._velocity)
		def.entity:setacceleration(self._acceleration)
	end,
	_attach_all = function(self)
		local master = self._attached_entities_master
		if not master then
			return
		end
		for id, entity in pairs(self._attached_entities) do
			if id ~= master and entity.entity then
				self:_attach(id, master)
			end
		end
	end,
	_detach_all = function(self)
		local master = self._attached_entities_master
		for id, entity in pairs(self._attached_entities) do
			if id ~= master and entity.entity then
				entity.entity:set_detach()
			end
		end
	end,
	_add_attached = function(self, index)
		local entity = self._attached_entities[index]
		if entity.entity then
			return
		end
		local entity_pos = vector.add(self._pos, entity.offset)
		if not is_active(entity_pos) then
			return
		end
		local ent = minetest.add_entity(entity_pos, entity.name):get_luaentity()
		ent:from_data(entity.data)
		ent.parent_id = self._id
		ent.attached_id = index
		entity.entity = ent.object
		local master = self._attached_entities_master
		if master then
			self:_attach(index, master)
		else
			self:_set_master(index)
		end
	end,
	_remove_attached = function(self, index)
		local master = self._attached_entities_master
		local entity = self._attached_entities[index]
		local ent = entity.entity
		entity.entity = nil
		if index == master then
			self:_detach_all()
			local newmaster
			for id, attached in pairs(self._attached_entities) do
				if id ~= master and attached.entity then
					newmaster = id
					break
				end
			end
			self:_set_master(newmaster)
			self:_attach_all()
		elseif master and ent then
			ent:set_detach()
		end
		if ent then
			ent:remove()
		end
	end,
	_add_loaded = function(self)
		for id, _ in pairs(self._attached_entities) do
			self:_add_attached(id)
		end
	end,
	getid = function(self)
		return self._id
	end,
	getpos = function(self)
		return vector.new(self._pos)
	end,
	setpos = function(self, pos)
		self._pos = vector.new(pos)
		--for _, entity in pairs(self._attached_entities) do
		--	if entity.entity then
		--		entity.entity:setpos(vector.add(self._pos, entity.offset))
		--	end
		--end
		local master = self._attached_entities_master
		if master then
			local master_def = self._attached_entities[master]
			master_def.entity:setpos(vector.add(self._pos, master_def.offset))
		end
	end,
	getvelocity = function(self)
		return vector.new(self._velocity)	
	end,
	setvelocity = function(self, velocity)
		self._velocity = vector.new(velocity)
		local master = self._attached_entities_master
		if master then
			self._attached_entities[master].entity:setvelocity(self._velocity)
		end
	end,
	getacceleration = function(self)
		return vector.new(self._acceleration)
	end,
	setacceleration = function(self, acceleration)
		self._acceleration = vector.new(acceleration)
		local master = self._attached_entities_master
		if master then
			self._attached_entities[master].entity:setacceleration(self._acceleration)
		end
	end,
	remove = function(self)
		self:_detach_all()
		for _, entity in pairs(self._attached_entities) do
			if entity.entity then
				entity.entity:remove()
			end
		end
		luaentity.entities[self._id] = nil
	end,
	add_attached_entity = function(self, name, data, offset)
		local index = #self._attached_entities + 1
		self._attached_entities[index] = {
			name = name,
			data = data,
			offset = vector.new(offset),
		}
		self:_add_attached(index)
		return index
	end,
	remove_attached_entity = function(self, index)
		self:_remove_attached(index)
		self._attached_entities[index] = nil
	end,
}

function luaentity.register_entity(name, prototype)
	-- name = check_modname_prefix(name)
	prototype.name = name
	setmetatable(prototype, {__index = entitydef_default})
	prototype.__index = prototype -- Make it possible to use it as metatable
	luaentity.registered_entities[name] = prototype
end

-- function luaentity.get_entity_definition(entity)
--	 return luaentity.registered_entities[entity.name]
-- end

function luaentity.add_entity(pos, name)
	local index = luaentity.entities_index
	while luaentity.entities[index] do
		index = index + 1
		if index >= max_entity_id then
			index = 0
		end
	end
	luaentity.entities_index = index

	local entity = {
		name = name,
		_id = index,
		_pos = vector.new(pos),
		_velocity = {x = 0, y = 0, z = 0},
		_acceleration = {x = 0, y = 0, z = 0},
		_attached_entities = {},
	}
	
	local prototype = luaentity.registered_entities[name]
	setmetatable(entity, prototype) -- Default to prototype for other methods
	luaentity.entities[index] = entity

	if entity.on_activate then
		entity:on_activate()
	end
	return entity
end

-- todo: check if remove in get_staticdata works
function luaentity.get_staticdata(self)
	local parent = luaentity.entities[self.parent_id]
	if parent and parent._remove_attached then
		parent:_remove_attached(self.attached_id)
	end
	return "toremove"
end

function luaentity.on_activate(self, staticdata)
	if staticdata == "toremove" then
		self.object:remove()
	end
end

function luaentity.get_objects_inside_radius(pos, radius)
	local objects = {}
	local index = 1
	for id, entity in pairs(luaentity.entities) do
		if vector.distance(pos, entity:getpos()) <= radius then
			objects[index] = entity
			index = index + 1
		end
	end
end

minetest.register_globalstep(function(dtime)
	if not luaentity.entities then
		luaentity.entities = read_entities()
	end
	for id, entity in pairs(luaentity.entities) do
		local master = entity._attached_entities_master
		if master then
			local master_def = entity._attached_entities[master]
			local master_entity = master_def.entity
			entity._pos = vector.subtract(master_entity:getpos(), master_def.offset)
			entity._velocity = master_entity:getvelocity()
			entity._acceleration = master_entity:getacceleration()
		else
			entity._pos = vector.add(vector.add(
				entity._pos,
				vector.multiply(entity._velocity, dtime)),
				vector.multiply(entity._acceleration, 0.5 * dtime * dtime))
			entity._velocity = vector.add(
				entity._velocity,
				vector.multiply(entity._acceleration, dtime))
		end
		entity:_add_loaded()
		if entity.on_step then
			entity:on_step(dtime)
		end
	end
end)
