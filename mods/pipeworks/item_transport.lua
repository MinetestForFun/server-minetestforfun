function pipeworks.tube_item(pos, item)
	error("obsolete pipeworks.tube_item() called; change caller to use pipeworks.tube_inject_item() instead")
end

function pipeworks.tube_inject_item(pos, start_pos, velocity, item)
	-- Take item in any format
	local stack = ItemStack(item)
	local obj = luaentity.add_entity(pos, "pipeworks:tubed_item")
	obj:set_item(stack:to_string())
	obj.start_pos = vector.new(start_pos)
	obj:setvelocity(velocity)
	--obj:set_color("red") -- todo: this is test-only code
	return obj
end

-- adding two tube functions
-- can_remove(pos,node,stack,dir) returns the maximum number of items of that stack that can be removed
-- remove_items(pos,node,stack,dir,count) removes count items and returns them
-- both optional w/ sensible defaults and fallback to normal allow_* function
-- XXX: possibly change insert_object to insert_item

local adjlist={{x=0,y=0,z=1},{x=0,y=0,z=-1},{x=0,y=1,z=0},{x=0,y=-1,z=0},{x=1,y=0,z=0},{x=-1,y=0,z=0}}

function pipeworks.notvel(tbl, vel)
	local tbl2={}
	for _,val in ipairs(tbl) do
		if val.x ~= -vel.x or val.y ~= -vel.y or val.z ~= -vel.z then table.insert(tbl2, val) end
	end
	return tbl2
end

local function go_next(pos, velocity, stack)
	local next_positions = {}
	local max_priority = 0
	local cnode = minetest.get_node(pos)
	local cmeta = minetest.get_meta(pos)
	local can_go
	local speed = math.abs(velocity.x + velocity.y + velocity.z)
	if speed == 0 then
		speed = 1
	end
	local vel = {x = velocity.x/speed, y = velocity.y/speed, z = velocity.z/speed,speed=speed}
	if speed >= 4.1 then
		speed = 4
	elseif speed >= 1.1 then
		speed = speed - 0.1
	else
		speed = 1
	end
	vel.speed = speed
	if minetest.registered_nodes[cnode.name] and minetest.registered_nodes[cnode.name].tube and minetest.registered_nodes[cnode.name].tube.can_go then
		can_go = minetest.registered_nodes[cnode.name].tube.can_go(pos, cnode, vel, stack)
	else
		can_go = pipeworks.notvel(adjlist, vel)
	end
	for _, vect in ipairs(can_go) do
		local npos = vector.add(pos, vect)
		minetest.load_position(npos)
		local node = minetest.get_node(npos)
		local reg_node = minetest.registered_nodes[node.name]
		if reg_node then
			local tube_def = reg_node.tube
			local tubedevice = minetest.get_item_group(node.name, "tubedevice")
			local tube_priority = (tube_def and tube_def.priority) or 100
			if tubedevice > 0 and tube_priority >= max_priority then
				if not tube_def or not tube_def.can_insert or
						tube_def.can_insert(npos, node, stack, vect) then
					if tube_priority > max_priority then
						max_priority = tube_priority
						next_positions = {}
					end
					next_positions[#next_positions + 1] = {pos = npos, vect = vect}
				end
			end
		end
	end

	if not next_positions[1] then
		return false, nil
	end

	local n = (cmeta:get_int("tubedir") % (#next_positions)) + 1
	if pipeworks.enable_cyclic_mode then
		cmeta:set_int("tubedir", n)
	end
	local new_velocity = vector.multiply(next_positions[n].vect, vel.speed)
	return true, new_velocity
end

minetest.register_entity("pipeworks:tubed_item", {
	initial_properties = {
		hp_max = 1,
		physical = false,
		collisionbox = {0.1, 0.1, 0.1, 0.1, 0.1, 0.1},
		visual = "wielditem",
		visual_size = {x = 0.15, y = 0.15},
		textures = {""},
		spritediv = {x = 1, y = 1},
		initial_sprite_basepos = {x = 0, y = 0},
		is_visible = false,
	},

	physical_state = false,

	from_data = function(self, itemstring)
		local stack = ItemStack(itemstring)
		local itemtable = stack:to_table()
		local itemname = nil
		if itemtable then
			itemname = stack:to_table().name
		end
		local item_texture = nil
		local item_type = ""
		if minetest.registered_items[itemname] then
			item_texture = minetest.registered_items[itemname].inventory_image
			item_type = minetest.registered_items[itemname].type
		end
		self.object:set_properties({
			is_visible = true,
			textures = {stack:get_name()}
		})
		local def = stack:get_definition()
		self.object:setyaw((def and def.type == "node") and 0 or math.pi * 0.25)
	end,

	get_staticdata = luaentity.get_staticdata,
	on_activate = function(self, staticdata) -- Legacy code, should be replaced later by luaentity.on_activate
		if staticdata == "" or staticdata == nil then
			return
		end
		if staticdata == "toremove" then
			self.object:remove()
			return
		end
		local item = minetest.deserialize(staticdata)
		pipeworks.tube_inject_item(self.object:getpos(), item.start_pos, item.velocity, item.itemstring)
		self.object:remove()
	end,
})

minetest.register_entity("pipeworks:color_entity", {
	initial_properties = {
		hp_max = 1,
		physical = false,
		collisionbox = {0.1, 0.1, 0.1, 0.1, 0.1, 0.1},
		visual = "cube",
		visual_size = {x = 3.5, y = 3.5, z = 3.5}, -- todo: find correct size
		textures = {""},
		is_visible = false,
	},

	physical_state = false,

	from_data = function(self, color)
		local t = "pipeworks_color_"..color..".png"
		local prop = {
			is_visible = true,
			visual = "cube",
			textures = {t, t, t, t, t, t} -- todo: textures
		}
		self.object:set_properties(prop)
	end,

	get_staticdata = luaentity.get_staticdata,
	on_activate = luaentity.on_activate,
})

luaentity.register_entity("pipeworks:tubed_item", {
	itemstring = '',
	item_entity = nil,
	color_entity = nil,
	color = nil,
	start_pos = nil,

	set_item = function(self, item)
		local itemstring = ItemStack(item):to_string() -- Accept any input format
		if self.itemstring == itemstring then
			return
		end
		if self.item_entity then
			self:remove_attached_entity(self.item_entity)
		end
		self.itemstring = itemstring
		self.item_entity = self:add_attached_entity("pipeworks:tubed_item", itemstring)
	end,

	set_color = function(self, color)
		if self.color == color then
			return
		end
		self.color = color
		if self.color_entity then
			self:remove_attached_entity(self.color_entity)
		end
		if color then
			self.color_entity = self:add_attached_entity("pipeworks:color_entity", color)
		else
			self.color_entity = nil
		end
	end,

	on_step = function(self, dtime)
		if self.start_pos == nil then
			local pos = self:getpos()
			self.start_pos = vector.round(pos)
			self:setpos(pos)
		end

		local pos = self:getpos()
		local stack = ItemStack(self.itemstring)
		local drop_pos

		local velocity = self:getvelocity()

		local moved = false
		local speed = math.abs(velocity.x + velocity.y + velocity.z)
		if speed == 0 then
			speed = 1
			moved = true
		end
		local vel = {x = velocity.x / speed, y = velocity.y / speed, z = velocity.z / speed, speed = speed}

		if vector.distance(pos, self.start_pos) >= 1 then
			self.start_pos = vector.add(self.start_pos, vel)
			moved = true
		end

		minetest.load_position(self.start_pos)
		local node = minetest.get_node(self.start_pos)
		if moved and minetest.get_item_group(node.name, "tubedevice_receiver") == 1 then
			local leftover
			if minetest.registered_nodes[node.name].tube and minetest.registered_nodes[node.name].tube.insert_object then
				leftover = minetest.registered_nodes[node.name].tube.insert_object(self.start_pos, node, stack, vel)
			else
				leftover = stack
			end
			if leftover:is_empty() then
				self:remove()
				return
			end
			velocity = vector.multiply(velocity, -1)
			self:setvelocity(velocity)
			self:set_item(leftover:to_string())
			return
		end

		if moved then
			local found_next, new_velocity = go_next(self.start_pos, velocity, stack) -- todo: color
			if not found_next then
				drop_pos = minetest.find_node_near(vector.add(self.start_pos, velocity), 1, "air")
				if drop_pos then
					-- Using add_item instead of item_drop since this makes pipeworks backward
					-- compatible with Minetest 0.4.13.
					-- Using item_drop here makes Minetest 0.4.13 crash.
					minetest.add_item(drop_pos, stack)
					self:remove()
					return
				end
			end

			if new_velocity and not vector.equals(velocity, new_velocity) then
				self:setpos(self.start_pos)
				self:setvelocity(new_velocity)
			end
		end
	end
})

if minetest.get_modpath("mesecons_mvps") then
	mesecon.register_mvps_unmov("pipeworks:tubed_item")
	mesecon.register_mvps_unmov("pipeworks:color_entity")
	mesecon.register_on_mvps_move(function(moved_nodes)
		local moved = {}
		for _, n in ipairs(moved_nodes) do
			moved[minetest.hash_node_position(n.oldpos)] = vector.subtract(n.pos, n.oldpos)
		end
		for id, entity in pairs(luaentity.entities) do
			if entity.name == "pipeworks:tubed_item" then
				local pos = entity:getpos()
				local rpos = vector.round(pos)
				local dir = moved[minetest.hash_node_position(rpos)]
				if dir then
					entity:setpos(vector.add(pos, dir))
					entity.start_pos = vector.add(entity.start_pos, dir)
				end
			end
		end
	end)
end
