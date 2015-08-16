global_timer=0
minetest.after(15,function(dtime)
   global_timer=20
end)

minetest.register_on_player_receive_fields(function(player, formname, fields, pos)
	if fields.quit then
		if formname:find('3dchest:3dchest') then
			local pos = minetest.deserialize(string.split(formname,'_')[2])
			if not pos then return end
			local objs = minetest.get_objects_inside_radius(pos, 0.1)
			for i,obj in ipairs(objs) do
				if not obj:is_player() then
					local self = obj:get_luaentity()
					if self.name == '3dchest:3dchest' then
						self.object:set_animation({x=25,y=40}, 60, 0)
						minetest.sound_play('chestclosed', {pos = pos, gain = 0.3, max_hear_distance = 5})
						minetest.after(0.1, function(dtime)
							self.object:set_animation({x=1,y=1}, 1, 0)
						end)
					end
				end
			end
		end
	end
end)


-- 3d chest!
local tdc = {
	physical = true,
	visual = "mesh",
	visual_size = {x=4.95, y=4.95, z=4.95},
	mesh = "chest_proto.x",
	textures = {"default_chest3d.png"},
	makes_footstep_sound = true,
	groups = {choppy=2, punch_operable = 1, immortal = 1},

	on_activate = function(self, staticdata, dtime_s)
		if staticdata then
			local tmp = minetest.deserialize(staticdata)
			if tmp and tmp.textures then
				self.textures = tmp.textures
				self.object:set_properties({textures=self.textures})
			end
			if tmp and tmp.visual then
				self.visual = tmp.visual
				self.object:set_properties({visual=self.visual})
			end
			if tmp and tmp.mesh then
				self.mesh = tmp.mesh
				self.object:set_properties({mesh=self.mesh})
			end
		end
		self.object:set_armor_groups({immortal = 1})
	end,

	get_staticdata = function(self)
		local tmp = {
			textures = self.textures,
			visual = self.visual,
			mesh = self.mesh,
		}
		return minetest.serialize(tmp)
	end,
	on_step = function(self, dtime)
		local pos = self.object:getpos()
		local nn = minetest.get_node(pos).name
		if nn~='3dchest:chest' then
			self.object:remove()
			return
	   end
	end,
}


minetest.register_entity('3dchest:3dchest', tdc)						-- normal

minetest.register_node("3dchest:chest", {
	description = "Chest",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype2 = "facedir",
	wield_image = minetest.inventorycube("default_chest_top.png", "default_chest_front.png", "default_chest_side.png"),
	inventory_image = minetest.inventorycube("default_chest_top.png", "default_chest_front.png", "default_chest_side.png"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
			fixed = {-0.01, -0.01, -0.01, 0.01, 0.01, 0.01},
	},
	selection_box = {
			type = "fixed",
			fixed = {
				{-0.501, -0.501, -0.501, 0.501, 0.501, 0.501},
			}
	},
	paramtype = "light",
	walkable = false,
	groups = {choppy=2, dig_immediate = 2},
	legacy_facedir_simple = true,

	on_construct = function(pos)
			local param2 = minetest.get_node(pos).param2
			local meta = minetest.get_meta(pos)
				meta:set_string("formspect",
				"size[8,8.2]"..
				"bgcolor[#bbbbbb;false]"..
				"listcolors[#777777;#cccccc;#333333;#555555;#dddddd]"..
				"list[nodemeta:"..pos.x..","..pos.y..","..pos.z..";main;0,0;8,4;]"..
				"list[current_player;main;0,4.2;8,3;8]"..
				"list[current_player;main;0,7.4;8,1;]")
				meta:set_string("infotext", "Chest")
			local inv = meta:get_inventory()
			inv:set_size("main", 4*8)
	end,
	can_dig = function(pos)
		return minetest.get_meta(pos):get_inventory():is_empty("main")
	end,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
			local m = minetest.get_meta(pos)
			local ent = minetest.add_entity(pos,'3dchest:3dchest')
			if ent then
				local ent2 = ent:get_luaentity()
				ent:set_animation({x=1,y=1}, 20, 0)
				local dir = placer:get_look_dir()
				local absx, absy, absz = math.abs(dir.x), math.abs(dir.y), math.abs(dir.z)
				local maxd = math.max(math.max(absx,absy),absz)
				if maxd == absx then
					if dir.x>0 then
							ent:setyaw(math.pi/2)
							m:set_int('dir',1)
					else
							ent:setyaw(3*math.pi/2)
							m:set_int('dir',3)
					end
				elseif maxd == absy then
					if dir.x>dir.z then
							ent:setyaw(math.pi)
							m:set_int('dir',2)
					else
							ent:setyaw(3*math.pi/2)
							m:set_int('dir',3)
					end
				elseif maxd == absz then
					if dir.z>0 then
							ent:setyaw(math.pi)
							m:set_int('dir',2)
					else
							ent:setyaw(0)
							m:set_int('dir',0)
					end
				end
				m:set_int('3d',1)
			end
		local timer = minetest.get_node_timer(pos)
		timer:start(1)
	end,
	on_timer = function(pos,el)
		if global_timer<15 then return true end
		local meta = minetest.get_meta(pos)
		local cover = false
		local node = minetest.get_node(pos)
		local objs = minetest.get_objects_inside_radius(pos, 0.1)
			for i,obj in ipairs(objs) do
				if not obj:is_player() then
					local self = obj:get_luaentity()
					if self.name == '3dchest:3dchest' and node.name == '3dchest:chest' then
						cover = true
						break
					else
						self.object:remove()
					end
				 end
			 end
		if not cover then
			if node.name == '3dchest:chest' then
				local ent = minetest.env:add_entity(pos,'3dchest:3dchest')
				if ent then
					ent:set_animation({x=1,y=1}, 20, 0)
					local dir = meta:get_int('dir')
					ent:setyaw(dir*(math.pi/2))
				end
			end
		end
		return true
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local meta = minetest.get_meta(pos)
		local meta2 = meta
		meta:from_table(oldmetadata)
		local inv = meta:get_inventory()
		for i=1,inv:get_size("main") do
			local stack = inv:get_stack("main", i)
			if not stack:is_empty() then
				local p = {x=pos.x+math.random(0, 10)/10-0.5, y=pos.y, z=pos.z+math.random(0, 10)/10-0.5}
				minetest.add_item(p, stack)
			end
		end
		meta:from_table(meta2:to_table())
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
	end,

	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local selves = minetest.get_objects_inside_radius(pos, 0.1)
		local self
		for _,obj in pairs(selves) do
			if obj:get_luaentity() and obj:get_luaentity().name == '3dchest:3dchest' then
				self = obj:get_luaentity()
				break
			end
		end
		local meta = minetest.get_meta(pos)
		local name = '3dchest:3dchest'
		local pll = clicker:get_player_name()
		local formspec = meta:get_string('formspect')
		local dir = (meta:get_int("dir")+2)%4
		local directions = {
			[0] = {x = pos.x, y = pos.y, z = pos.z + 1},
			[1] = {x = pos.x - 1, y = pos.y, z = pos.z},
			[2] = {x = pos.x, y = pos.y, z = pos.z - 1},
			[3] = {x = pos.x + 1, y = pos.y, z = pos.z}
		}
		local backnode = minetest.get_node(directions[dir])
		local upnode = minetest.get_node({x = directions[dir].x, y = directions[dir].y + 1, z = directions[dir].z})
		if (not backnode or (backnode and backnode.name ~= "air"))
			or (not upnode or (upnode and upnode.name ~= "air")) then
			minetest.chat_send_player(clicker:get_player_name(), "Cannot open chest's lid, move it.")
			return
		end

		if not self then
			minetest.show_formspec(pll, name..'_'..minetest.serialize(pos), formspec)
			return
		else
			self.object:set_animation({x=10,y=25}, 60, 0)
			minetest.after(0.1,function(dtime)
				self.object:set_animation({x=25,y=25}, 20, 0)
			end)
			minetest.sound_play('chestopen', {pos = pos, gain = 0.3, max_hear_distance = 5})
			minetest.show_formspec(pll, name..'_'..minetest.serialize(pos), formspec)
		end
	end,
})
