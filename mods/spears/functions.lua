function spears_shot (itemstack, player)
	local spear = itemstack:get_name() .. '_entity'
	local playerpos = player:getpos()
	local obj = minetest.add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, spear)
	local dir = player:get_look_dir()
	local sp = 14
	local dr = .3
	local gravity = 9.8
	obj:setvelocity({x=dir.x*sp, y=dir.y*sp, z=dir.z*sp})
	obj:setacceleration({x=-dir.x*dr, y=-gravity, z=-dir.z*dr})
	obj:setyaw(player:get_look_yaw()+math.pi)
	obj:get_luaentity().wear = itemstack:get_wear()
	obj:get_luaentity().player = player:get_player_name()
	obj:get_luaentity().lastpos = {x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}
	minetest.sound_play("spears_sound", {pos=playerpos})
	return true
end


function spears_set_entity(kind, eq, toughness)
	local SPEAR_ENTITY={
		physical = false,
		visual = "wielditem",
		visual_size = {x=0.15, y=0.1},
		textures = {"spears:spear_" .. kind},
		lastpos={},
		collisionbox = {0,0,0,0,0,0},
		player = "",
		wear = 0,

		on_punch = function(self, puncher)
			if puncher then
				if puncher:is_player() then
					local stack = {name='spears:spear_' .. kind, wear=self.wear+65535/toughness}
					local inv = puncher:get_inventory()
					if inv:room_for_item("main", stack) then
						inv:add_item("main", stack)
						self.object:remove()
					end
				end
			end
		end,
	}


	SPEAR_ENTITY.on_step = function(self, dtime)
		local pos = self.object:getpos()
		local node = minetest.get_node(pos)
		if not self.wear then
			self.object:remove()
			return
		end
		local newpos = self.object:getpos()
		if self.lastpos.x ~= nil then
			for _, pos in pairs(spears_get_trajectoire(self, newpos)) do
				local node = minetest.get_node(pos)

				if node.name ~= "air"
				and not string.find(node.name, 'water_')
				and not (string.find(node.name, 'grass') and not string.find(node.name, 'dirt'))
				and not (string.find(node.name, 'farming:') and not string.find(node.name, 'soil'))
				and not string.find(node.name, 'flowers:')
				and not string.find(node.name, 'fire:') then
					if self.wear+65535/toughness < 65535 then
						local spear_item = minetest.add_item(self.lastpos, {name='spears:spear_' .. kind, wear=self.wear+65535/toughness})
						if spear_item then
							spear_item:get_luaentity().item_drop_min_tstamp = minetest.get_us_time() + 3000000
						end
					end
					self.object:remove()
					return
				end

				local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
				for k, obj in pairs(objs) do
					local objpos = obj:getpos()
					if spears_is_player(self.player, obj) or spears_is_entity(obj) then
						if spears_touch(pos, objpos) then
							local puncher = self.object
							if self.player and minetest.get_player_by_name(self.player) then
								puncher = minetest.get_player_by_name(self.player)
							end
							--local speed = vector.length(self.object:getvelocity()) --MFF crabman(28/09/2015) damage valeur equal eq
							local damage = eq --((speed + eq +5)^1.2)/10 --MFF crabman(28/09/2015) damage valeur equal eq
							obj:punch(puncher, 1.0, {
								full_punch_interval=1.0,
								damage_groups={fleshy=damage},
							}, nil)
							if self.wear+65535/toughness < 65535 then
								local spear_item = minetest.add_item(self.lastpos, {name='spears:spear_' .. kind, wear=self.wear+65535/toughness})
								if spear_item then
									spear_item:get_luaentity().item_drop_min_tstamp = minetest.get_us_time() + 3000000
								end
							end
							self.object:remove()
							return
						end
					end
				end

				self.lastpos={x=pos.x, y=pos.y, z=pos.z}
			end
		end

		self.lastpos={x=newpos.x, y=newpos.y, z=newpos.z}
	end
	return SPEAR_ENTITY
end


function spears_is_player(name, obj)
	return (obj:is_player() and obj:get_player_name() ~= name)
end

function spears_is_entity(obj)
	return (obj:get_luaentity() ~= nil
			and not string.find(obj:get_luaentity().name, "spears:")
			and obj:get_luaentity().name ~= "__builtin:item"
			and obj:get_luaentity().name ~= "gauges:hp_bar"
			and obj:get_luaentity().name ~= "signs:text")
end



function spears_get_trajectoire(self, newpos)
	if self.lastpos.x == nil then
		return {newpos}
	end
	local coord = {}
	local nx = (newpos["x"] - self.lastpos["x"])/3
	local ny = (newpos["y"] - self.lastpos["y"])/3
	local nz = (newpos["z"] - self.lastpos["z"])/3

	if nx and ny and nz then
		table.insert(coord, {x=self.lastpos["x"]+nx, y=self.lastpos["y"]+ny ,z=self.lastpos["z"]+nz })
		table.insert(coord, {x=newpos["x"]-nx, y=newpos["y"]-ny ,z=newpos["z"]-nz })
	end
	table.insert(coord, newpos)
	return coord
end

function spears_touch(pos, objpos)
	local rx = pos.x - objpos.x
	local ry = pos.y - (objpos.y+1)
	local rz = pos.z - objpos.z
	if (ry < 1 and ry > -1) and (rx < 0.4 and rx > -0.4) and (rz < 0.4 and rz > -0.4) then
		return true
	end
	return false
end

