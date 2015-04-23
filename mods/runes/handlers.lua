-- Use handlers for runes

-- First, the functions

projection = function(itemstack, user, pointed_thing)
	if pointed_thing.type == "object" then
		local dir = vector.direction(user:getpos(),pointed_thing.ref:getpos())
		local ykb = 10
		if v.y ~= 0 then ykb = 0 end 
		pointed_thing.ref:setvelocity({x=dir.x*50,y=ykb,z=dir.z*50})
	end
end

damage_around = function(itemstack, user, pointed_thing)
	for name,entity in pairs(minetest.get_objects_inside_radius(user:getpos(),10)) do
		if true and (entity:is_player() and entity:get_player_name() ~= user:get_player_name()) then
			entity:set_hp(1)
		end
	end
end

earthquake = function(itemstack, user, pointed_thing)
	for name,entity in pairs(minetest.get_objects_inside_radius(user:getpos(),10)) do
		local v = entity:getvelocity() or {x=0,y=0,z=0}
		entity:setvelocity({x=v.x, y=v.y+50, z=v.z})
	end
end

add_owner = function(pos, placer, itemstack, pointed_thing)
	if placer and placer:is_player() then
		local meta = minetest.get_meta(pos)
		meta:set_string("owner",placer:get_player_name())
	end
end

is_owner_online = function(pos)
	local meta = minetest.get_meta(pos)
	print(meta:get_string("owner"))
	if meta:get_string("owner") ~= nil then
		return minetest.get_player_by_name(meta:get_string("owner")) ~= nil
	else
		return true
	end
end

go_to_me = function(pos, node, digger)
	if digger then
		digger:setpos(minetest.get_player_by_name(minetest.get_meta(pos):get_string("owner")):getpos())
	end
end

-- Then, connect

runes.functions.connect("project","use",projection)
runes.functions.connect("damager","use",damage_around)
runes.functions.connect("earthquake","use",earthquake)
runes.functions.connect("gotome","place",add_owner)
runes.functions.connect("gotome","dig",go_to_me)
runes.functions.connect("gotome","can_dig",is_owner_online)
