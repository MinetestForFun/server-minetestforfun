
--
-- Falling stuff custom for protected area
--
minetest.register_entity(":__builtin:falling_node", {
	initial_properties = {
		physical = true,
		collide_with_objects = false,
		collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
		visual = "wielditem",
		textures = {},
		visual_size = {x=0.667, y=0.667},
		owner = "falling",
	},

	node = {},

	set_node = function(self, node)
		self.node = node
		local stack = ItemStack(node.name)
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
		local prop = {
			is_visible = true,
			textures = {node.name},
		}
		self.object:set_properties(prop)
	end,

	set_owner = function(self, owner)
		if owner ~= nil then
			self.owner = "falling"
		else
			self.owner = owner
		end
	end,

	get_staticdata = function(self)
		return self.node.name
	end,

	on_activate = function(self, staticdata)
		self.object:set_armor_groups({immortal=1})
		self:set_node({name=staticdata})
	end,

	on_step = function(self, dtime)
		-- Set gravity
		self.object:setacceleration({x=0, y=-10, z=0})
		-- Turn to actual sand when collides to ground or just move
		local pos = self.object:getpos()
		local bcp = {x=pos.x, y=pos.y-0.7, z=pos.z} -- Position of bottom center point
		local bcn = minetest.get_node(bcp)
		local bcd = minetest.registered_nodes[bcn.name]
		-- Note: walkable is in the node definition, not in item groups
		if not bcd or
				(bcd.walkable or
				(minetest.get_item_group(self.node.name, "float") ~= 0 and
				bcd.liquidtype ~= "none")) then
			if bcd and bcd.leveled and
					bcn.name == self.node.name then
				local addlevel = self.node.level
				if addlevel == nil or addlevel <= 0 then
					addlevel = bcd.leveled
				end
				if minetest.add_node_level(bcp, addlevel) == 0 then
					self.object:remove()
					return
				end
			elseif bcd and bcd.buildable_to and
					(minetest.get_item_group(self.node.name, "float") == 0 or
					bcd.liquidtype == "none") then
				minetest.remove_node(bcp)
				return
			end
			local np = {x=bcp.x, y=bcp.y+1, z=bcp.z}
			-- Check what's here
			local n2 = minetest.get_node(np)
			-- If it's not air or liquid, remove node and replace it with
			-- it's drops
			if n2.name ~= "air" and (not minetest.registered_nodes[n2.name] or
					minetest.registered_nodes[n2.name].liquidtype == "none") then
				minetest.remove_node(np)
				if minetest.registered_nodes[n2.name].buildable_to == false then
					-- Add dropped items
					local drops = minetest.get_node_drops(n2.name, "")
					local _, dropped_item
					for _, dropped_item in ipairs(drops) do
						minetest.add_item(np, dropped_item)
					end
				end
				-- Run script hook
				local _, callback
				for _, callback in ipairs(minetest.registered_on_dignodes) do
					callback(np, n2, nil)
				end
			end
			-- Create node and remove entity
			if self.owner == nil or self.owner == "falling" and not minetest.is_protected(pos,"") then
				minetest.add_node(np, self.node)
			else
				if not minetest.is_protected(pos,self.owner) then
					minetest.log("action", self.owner
					.. " falling node " .. self.node.name
					.. " at"
					.. minetest.pos_to_string(pos))
					minetest.add_node(np, self.node)
				else
					minetest.log("action", self.owner
					.. " try to falling node " .. self.node.name
					.. " at protected position "
					.. minetest.pos_to_string(pos))
					minetest.add_item(np, self.node)
				end
			end
			self.object:remove()
			nodeupdate(np)
			return
		end
		local vel = self.object:getvelocity()
		if vector.equals(vel, {x=0,y=0,z=0}) then
			local npos = self.object:getpos()
			self.object:setpos(vector.round(npos))
		end
	end
})

minetest.override_item("default:lava_source", {
	on_place = function(itemstack, placer, pointed_thing)
		if not pointed_thing.type == "node" then
				return itemstack
		end
		local pn = placer:get_player_name()
		if minetest.is_protected(pointed_thing.above, pn) then
			return itemstack
		end
		minetest.add_node(pointed_thing.above, {name=itemstack:get_name()})
		local meta = minetest.get_meta(pointed_thing.above)
		meta:set_string("owner", pn)
		nodeupdate(pointed_thing.above)
		if not minetest.setting_getbool("creative_mode") then
						itemstack:take_item()
		end
		return itemstack
	end,
})

minetest.override_item("default:lava_flowing", {
	on_place = function(itemstack, placer, pointed_thing)
		if not pointed_thing.type == "node" then
				return itemstack
		end
		local pn = placer:get_player_name()
		if minetest.is_protected(pointed_thing.above, pn) then
			return itemstack
		end
		minetest.add_node(pointed_thing.above, {name=itemstack:get_name()})
		local meta = minetest.get_meta(pointed_thing.above)
		meta:set_string("owner", pn)
		nodeupdate(pointed_thing.above)
		if not minetest.setting_getbool("creative_mode") then
						itemstack:take_item()
		end
		return itemstack
	end,
})

if PROTECT_LAVA_REALTIME == 1 then
	minetest.register_abm({
		nodenames = {"default:lava_source","default:lava_flowing"},
		neighbors = {"air"},
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
				local meta = minetest.get_meta(pos)
				if meta:get_string("owner") ~= nil and minetest.is_protected(pos, meta:get_string("owner")) then
					minetest.add_node(pos,{name="air"})
				end
		end
	})
end

if PROTECT_WATER_REALTIME == 1 then
	minetest.register_abm({
		nodenames = {"default:water_source","default:water_flowing"},
		neighbors = {"air"},
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
				local meta = minetest.get_meta(pos)
				if meta:get_string("owner") ~= nil and minetest.is_protected(pos, meta:get_string("owner")) then
					minetest.add_node(pos,{name="air"})
				end
		end
	})
end


-- More slow >.<

--local c_air = minetest.get_content_id("air")
--minetest.register_abm({
--	nodenames = {"default:lava_source","default:lava_flowing"},
--	neighbors = {"air"},
--	interval = 2,
--	chance = 1,
--	action = function(pos, node, active_object_count, active_object_count_wider)
--			local vm = minetest.get_voxel_manip()
--			local minp, maxp = vm:read_from_map({x = pos.x, y = pos.y , z = pos.z },
--				{x = pos.x , y = pos.y , z = pos.z })
--			local area = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
--			local data = vm:get_data()
--						local p_pos = area:index(pos.x, pos.y , pos.z)
--						print ("pos:  , name :"..minetest.get_name_from_content_id(data[p_pos]))
--						local meta = minetest.get_meta(area:position(p_pos))
--						if minetest.get_name_from_content_id(data[p_pos])== "default:lava_source"  and meta:get_string("owner") ~= nil and minetest.is_protected(area:position(p_pos), meta:get_string("owner")) then
--							data[p_pos] = c_air
--						end
--			vm:set_data(data)
--			vm:write_to_map()
--			vm:update_map()
--	end
--})


