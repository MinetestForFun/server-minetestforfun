local function table_contains(t, v)
	for _,i in pairs(t) do
		if v == i then
			return true
		end
	end
	return false
end

local teleportball_player
local function throw_pearl(item, player)
	local playerpos = player:getpos()
	local obj = minetest.add_entity({x=playerpos.x,y=playerpos.y+1.625,z=playerpos.z}, "nether:pearl_entity")
	local dir = player:get_look_dir()
	obj:setvelocity({x=dir.x*30, y=dir.y*30, z=dir.z*30})
	obj:setacceleration({x=dir.x*-3, y=-dir.y^8*80-10, z=dir.z*-3})
	if not minetest.setting_getbool("creative_mode") then
		item:take_item()
	end
	teleportball_player = player
	return item
end

local ENTITY = {
	timer=0,
	collisionbox = {0,0,0,0,0,0}, --not pointable
	physical = false, -- Collides with things
	textures = {"nether_pearl.png"},
	lastpos={},
	player = "",
}

local allowed_nodes = {"air", "default:water_source"}
local function teleport_player(pos, player)
	local nd2 = minetest.get_node(pos).name
	pos.y = pos.y+1
	local nd3 = minetest.get_node(pos).name
	if table_contains(allowed_nodes, nd2)
	and table_contains(allowed_nodes, nd3) then
		pos.y = pos.y-1.4
		player:moveto(pos)
		pos.y = pos.y-0.6
		return true
	end
	return false
end

ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime

--[[	local delay = self.delay
	if delay < 0.1 then
		self.delay = delay+dtime
		return
	end
	self.delay = 0]]
	local pos = self.object:getpos()
	local lastpos = self.lastpos
	if lastpos.x
	and vector.equals(vector.round(lastpos), vector.round(pos)) then
		return
	end
	local player = self.player
	if not player
	or player == "" then
		self.player = teleportball_player
		player = teleportball_player
	end
	if not player then
		self.object:remove()
		return
	end
	if lastpos.x then --If there is no lastpos for some reason.
		local free, p = minetest.line_of_sight(lastpos, pos)
		if not free then
			local nd1 = minetest.get_node(p).name
			if not table_contains(allowed_nodes, nd1)
			and nd1 ~= "ignore" then
				self.object:remove()
				minetest.after(0, function(p) --minetest.after us used that the sound is played after the teleportation
					minetest.sound_play("nether_pearl", {pos=p, max_hear_distance=10})
				end, p)
				p.y = p.y+1
				if teleport_player(p, player) then
					return
				end
				p.y = p.y-2
				for i = -1,1,2 do
					for _,j in pairs({{i, 0}, {0, i}}) do
						if teleport_player({x=p.x+j[1], y=p.y, z=p.z+j[2]}, player) then
							return
						end
					end
				end
				for i = -1,1,2 do
					for j = -1,1,2 do
						if teleport_player({x=p.x+j, y=p.y, z=p.z+i}, player) then
							return
						end
					end
				end
			end
		end
	end
	if self.timer > 20 then
		self.object:remove()
		return
	end
	self.lastpos = vector.new(pos)
end

minetest.register_entity("nether:pearl_entity", ENTITY)

minetest.override_item("nether:pearl", {on_use = throw_pearl})
