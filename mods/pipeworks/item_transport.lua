local function delay(x)
	return (function() return x end)
end

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

local function set_filter_infotext(data, meta)
	local infotext = data.wise_desc.." Filter-Injector"
	if meta:get_int("slotseq_mode") == 2 then
		infotext = infotext .. " (slot #"..meta:get_int("slotseq_index").." next)"
	end
	meta:set_string("infotext", infotext)
end

local function set_filter_formspec(data, meta)
	local itemname = data.wise_desc.." Filter-Injector"
	local formspec = "size[8,8.5]"..
			"item_image[0,0;1,1;pipeworks:"..data.name.."]"..
			"label[1,0;"..minetest.formspec_escape(itemname).."]"..
			"label[0,1;Prefer item types:]"..
			"list[current_name;main;0,1.5;8,2;]"..
			fs_helpers.cycling_button(meta, "button[0,3.5;4,1", "slotseq_mode",
				{"Sequence slots by Priority",
				 "Sequence slots Randomly",
				 "Sequence slots by Rotation"})..
			"list[current_player;main;0,4.5;8,4;]"
	meta:set_string("formspec", formspec)
end

-- todo SOON: this function has *way too many* parameters
local function grabAndFire(data,slotseq_mode,filtmeta,frominv,frominvname,frompos,fromnode,filtername,fromtube,fromdef,dir,fakePlayer,all)
	local sposes = {}
	for spos,stack in ipairs(frominv:get_list(frominvname)) do
		local matches
		if filtername == "" then
			matches = stack:get_name() ~= ""
		else
			matches = stack:get_name() == filtername
		end
		if matches then table.insert(sposes, spos) end
	end
	if #sposes == 0 then return false end
	if slotseq_mode == 1 then
		for i = #sposes, 2, -1 do
			local j = math.random(i)
			local t = sposes[j]
			sposes[j] = sposes[i]
			sposes[i] = t
		end
	elseif slotseq_mode == 2 then
		local headpos = filtmeta:get_int("slotseq_index")
		table.sort(sposes, function (a, b)
			if a >= headpos then
				if b < headpos then return true end
			else
				if b >= headpos then return false end
			end
			return a < b
		end)
	end
	for _, spos in ipairs(sposes) do
			local stack = frominv:get_stack(frominvname, spos)
			local doRemove = stack:get_count()
			if fromtube.can_remove then
				doRemove = fromtube.can_remove(frompos, fromnode, stack, dir)
			elseif fromdef.allow_metadata_inventory_take then
				doRemove = fromdef.allow_metadata_inventory_take(frompos, frominvname,spos, stack, fakePlayer)
			end
			-- stupid lack of continue statements grumble
			if doRemove > 0 then
				if slotseq_mode == 2 then
					local nextpos = spos + 1
					if nextpos > frominv:get_size(frominvname) then
						nextpos = 1
					end
					filtmeta:set_int("slotseq_index", nextpos)
					set_filter_infotext(data, filtmeta)
				end
				local item
				local count
				if all then
					count = math.min(stack:get_count(), doRemove)
				else
					count = 1
				end
				if fromtube.remove_items then
					-- it could be the entire stack...
					item = fromtube.remove_items(frompos, fromnode, stack, dir, count)
				else
					item = stack:take_item(count)
					frominv:set_stack(frominvname, spos, stack)
					if fromdef.on_metadata_inventory_take then
						fromdef.on_metadata_inventory_take(frompos, frominvname, spos, item, fakePlayer)
					end
				end
				local pos = vector.add(frompos, vector.multiply(dir, 1.4))
				local start_pos = vector.add(frompos, dir)
				local item1 = pipeworks.tube_inject_item(pos, start_pos, dir, item)
				return true-- only fire one item, please
			end
	end
	return false
end

local function punch_filter(data, filtpos, filtnode)
	local filtmeta = minetest.get_meta(filtpos)
	local filtinv = filtmeta:get_inventory()
	local owner = filtmeta:get_string("owner")
	local fakePlayer = {
		get_player_name = delay(owner),
	} -- TODO: use a mechanism as the wielder one
	local dir = minetest.facedir_to_right_dir(filtnode.param2)
	local frompos = vector.subtract(filtpos, dir)
	local fromnode = minetest.get_node(frompos)
	if not fromnode then return end
	local fromdef = minetest.registered_nodes[fromnode.name]
	if not fromdef then return end
	local fromtube = fromdef.tube
	if not (fromtube and fromtube.input_inventory) then return end
	local filters = {}
	for _, filterstack in ipairs(filtinv:get_list("main")) do
		local filtername = filterstack:get_name()
		if filtername ~= "" then table.insert(filters, filtername) end
	end
	if #filters == 0 then table.insert(filters, "") end
	local slotseq_mode = filtmeta:get_int("slotseq_mode")
	local frommeta = minetest.get_meta(frompos)
	local frominv = frommeta:get_inventory()
	if fromtube.before_filter then fromtube.before_filter(frompos) end
	for _, frominvname in ipairs(type(fromtube.input_inventory) == "table" and fromtube.input_inventory or {fromtube.input_inventory}) do
		local done = false
		for _, filtername in ipairs(filters) do
			if grabAndFire(data, slotseq_mode, filtmeta, frominv, frominvname, frompos, fromnode, filtername, fromtube, fromdef, dir, fakePlayer, data.stackwise) then
				done = true
				break
			end
		end
		if done then break end
	end
	if fromtube.after_filter then fromtube.after_filter(frompos) end
end

for _, data in ipairs({
	{
		name = "filter",
		wise_desc = "Itemwise",
		stackwise = false,
	},
	{
		name = "mese_filter",
		wise_desc = "Stackwise",
		stackwise = true,
	},
}) do
	minetest.register_node("pipeworks:"..data.name, {
		description = data.wise_desc.." Filter-Injector",
		tiles = {
			"pipeworks_"..data.name.."_top.png",
			"pipeworks_"..data.name.."_top.png",
			"pipeworks_"..data.name.."_output.png",
			"pipeworks_"..data.name.."_input.png",
			"pipeworks_"..data.name.."_side.png",
			"pipeworks_"..data.name.."_top.png",
		},
		paramtype2 = "facedir",
		groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, mesecon = 2},
		legacy_facedir_simple = true,
		sounds = default.node_sound_wood_defaults(),
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			set_filter_formspec(data, meta)
			set_filter_infotext(data, meta)
			local inv = meta:get_inventory()
			inv:set_size("main", 8*2)
		end,
		after_place_node = function (pos, placer)
			minetest.get_meta(pos):set_string("owner", placer:get_player_name())
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			fs_helpers.on_receive_fields(pos, fields)
			local meta = minetest.get_meta(pos)
			meta:set_int("slotseq_index", 1)
			set_filter_formspec(data, meta)
			set_filter_infotext(data, meta)
		end,
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:is_empty("main")
		end,
		mesecons = {
			effector = {
				action_on = function(pos, node)
					punch_filter(data, pos, node)
				end,
			},
		},
		tube = {connect_sides = {right = 1}},
		on_punch = function (pos, node, puncher)
			punch_filter(data, pos, node)
		end,
	})
end

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
					minetest.item_drop(stack, "", drop_pos)
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
