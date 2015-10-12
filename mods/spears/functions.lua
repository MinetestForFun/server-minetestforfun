
function spears_shot (itemstack, player)
	local spear = itemstack:get_name() .. '_entity'
	local playerpos = player:getpos()
	local obj = minetest.add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, spear)
	local dir = player:get_look_dir()
	obj:setvelocity({x=dir.x*14, y=dir.y*14, z=dir.z*14})
	obj:setacceleration({x=-dir.x*.5, y=-9.8, z=-dir.z*.5})
	obj:setyaw(player:get_look_yaw()+math.pi)
	obj:get_luaentity().wear = itemstack:get_wear()
	obj:get_luaentity().player = player:get_player_name()
	obj:get_luaentity().lastpos = {x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}
	minetest.sound_play("spears_sound", {pos=playerpos})
	return true
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

