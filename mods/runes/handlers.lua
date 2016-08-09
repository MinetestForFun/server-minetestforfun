-- Use handlers for runes

-- Every handler must receive as arguments the default callback arguments and
-- as first argument the power level of the rune as a string which can be :
--   `minor`	: Low level
--   `medium`	: Medium level
--   `major`	: High level

-- First, the functions

projection = function(runelevel, itemstack, user, pointed_thing)
	if pointed_thing.type == "object" then
		local dir = vector.direction(user:getpos(),pointed_thing.ref:getpos())
		local v = pointed_thing.ref:getvelocity() or {x=0,y=0,z=0}
		local ykb = 10
		if v.y ~= 0 then ykb = 0 end
		pointed_thing.ref:setvelocity({x=dir.x*50,y=ykb,z=dir.z*50})
	end
end

damage_around = function(runelevel, itemstack, user, pointed_thing)
	for name,entity in pairs(minetest.get_objects_inside_radius(user:getpos(),10)) do
		if true and (entity:is_player() and entity:get_player_name() ~= user:get_player_name()) then
			entity:set_hp(1)
		end
	end
end

earthquake = function(runelevel, itemstack, user, pointed_thing)
	for name,entity in pairs(minetest.get_objects_inside_radius(user:getpos(),10)) do
		local v = entity:getvelocity() or {x=0,y=0,z=0}
		entity:setvelocity({x=v.x, y=v.y+50, z=v.z})
	end
end

add_owner = function(runelevel, pos, placer, itemstack, pointed_thing)
	if placer and placer:is_player() then
		local meta = minetest.get_meta(pos)
		meta:set_string("owner",placer:get_player_name())
	end
end

is_owner_online = function(runelevel, pos)
	local meta = minetest.get_meta(pos)
	if meta:get_string("owner") ~= nil then
		return minetest.get_player_by_name(meta:get_string("owner")) ~= nil
	else
		return false
	end
end

is_owner = function(runelevel, pos, player)
	local meta = minetest.get_meta(pos)
	if meta:get_string("owner") ~= nil and player:get_player_name() then
		return meta:get_string("owner") == player:get_player_name()
	else
		return false
	end
end

go_to_me = function(runelevel, pos, node, digger)
	if digger and is_owner_online(pos) and not (minetest.get_meta(pos):get_string("owner") == digger:get_player_name()) then
		digger:setpos(minetest.get_player_by_name(minetest.get_meta(pos):get_string("owner")):getpos())
		mana.subtract(minetest.get_meta(pos):get_string("owner"), 5)
	else
		mana.add(digger:get_player_name(),50)
	end
end

set_manamax = function(runelevel, itemstack, user, pointed_thing)
	if user and user:is_player() then
		mana.set(user:get_player_name(),mana.getmax(user:get_player_name()))
		if not minetest.get_player_privs(user:get_player_name()).server then
			-- Violent reaction if not admin
			user:set_hp(1)
			user:set_breath(1)
			local userpos = user:getpos()
			local useritem = user:get_wielded_item()
			user:setpos({x=userpos.x+math.random(-50,50),y = userpos.y + math.random(1,20),z = userpos.z + math.random(-50,50)})
		end
	end
end


set_manamax = function(level, itemstack, user, pointed_thing)
	if user and user:is_player() then
		mana.set(user:get_player_name(),mana.getmax(user:get_player_name()))
		if not minetest.get_player_privs(user:get_player_name()).server then
			-- Violent reaction if not admin
			user:set_hp(1)
			user:set_breath(1)
			local userpos = user:getpos()
			local useritem = user:get_wielded_item()
			user:setpos({x=userpos.x+math.random(-50,50),y = userpos.y + math.random(1,20),z = userpos.z + math.random(-50,50)})
		end
	end
end

-- Then, connect

runes.functions.connect("project","use",projection)
runes.functions.connect("damager","use",damage_around)
runes.functions.connect("earthquake","use",earthquake)
runes.functions.connect("gotome","punch",go_to_me)
runes.functions.connect("gotome","can_dig",is_owner)
runes.functions.connect("megamana","use",set_manamax)
