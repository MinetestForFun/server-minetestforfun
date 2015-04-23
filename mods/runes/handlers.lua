-- Use handlers for runes

-- First, the functions

projection = function(itemstack, user, pointed_thing)
	if pointed_thing.type == "object" then
		local dir = vector.direction(user:getpos(),pointed_thing.ref:getpos())
<<<<<<< HEAD
		local v = pointed_thing.ref:getvelocity() or {x=0,y=0,z=0}
=======
>>>>>>> Added base of runes mod
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
<<<<<<< HEAD
=======
	print(meta:get_string("owner"))
>>>>>>> Added base of runes mod
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

<<<<<<< HEAD
set_manamax = function(itemstack, user, pointed_thing)
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

=======
>>>>>>> Added base of runes mod
-- Then, connect

runes.functions.connect("project","use",projection)
runes.functions.connect("damager","use",damage_around)
runes.functions.connect("earthquake","use",earthquake)
runes.functions.connect("gotome","place",add_owner)
runes.functions.connect("gotome","dig",go_to_me)
runes.functions.connect("gotome","can_dig",is_owner_online)
<<<<<<< HEAD
runes.functions.connect("megamana","use",set_manamax)

-- And globalsteps

-- Is in
minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		local playerpos = player:getpos()
		local underpos  = {x=playerpos.x,y=playerpos.y,z=playerpos.z}
		local undernode = minetest.get_node(underpos)
		local meta		= minetest.get_meta(underpos)
		local inv		= meta:get_inventory()

		if undernode.name == "runes:rune_popper" then --and player:get_player_name() ~= meta:get_string("owner") then
			if minetest.get_player_by_name(meta:get_string("owner")) and mana.get(meta:get_string("owner")) > 10 then
				local thieff = math.random(1,32)
				local stolen = player:get_inventory():get_stack("main", thieff)
				player:get_inventory():set_stack("main", thieff, nil)
				if stolen:get_count() > 0 then
					local obj = minetest.add_item({x = underpos.x, y = underpos.y + 2.5, z = underpos.z}, stolen)
					if obj then
						obj:setvelocity({x = math.random(-5,5), y = math.random(3,5), z = math.random(-5,5)})
					end
					mana.set(meta:get_string("owner"), mana.get(meta:get_string("owner"))-10)
				end
			end
		end
	end
end)
=======
>>>>>>> Added base of runes mod
