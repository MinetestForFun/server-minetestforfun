
function spawn_falling_node(p, node, owners)
	local obj = minetest.add_entity(p, "__builtin:falling_node")
	obj:get_luaentity():set_node(node)
	obj:get_luaentity():set_owner(owners)
end

function drop_attached_node(p)
	local nn = minetest.get_node(p).name
	minetest.remove_node(p)
	for _,item in ipairs(minetest.get_node_drops(nn, "")) do
		local pos = {
			x = p.x + math.random()/2 - 0.25,
			y = p.y + math.random()/2 - 0.25,
			z = p.z + math.random()/2 - 0.25,
		}
		minetest.add_item(pos, item)
	end
end

function check_attached_node(p, n)
	local def = minetest.registered_nodes[n.name]
	local d = {x=0, y=0, z=0}
	if def.paramtype2 == "wallmounted" then
		if n.param2 == 0 then
			d.y = 1
		elseif n.param2 == 1 then
			d.y = -1
		elseif n.param2 == 2 then
			d.x = 1
		elseif n.param2 == 3 then
			d.x = -1
		elseif n.param2 == 4 then
			d.z = 1
		elseif n.param2 == 5 then
			d.z = -1
		end
	else
		d.y = -1
	end
	local p2 = {x=p.x+d.x, y=p.y+d.y, z=p.z+d.z}
	local nn = minetest.get_node(p2).name
	local def2 = minetest.registered_nodes[nn]
	if def2 and not def2.walkable then
		return false
	end
	return true
end

--
-- Some common functions
--

function nodeupdate_single(p, delay)
	local n = minetest.get_node(p)
	if minetest.get_item_group(n.name, "falling_node") ~= 0 then
		local p_bottom = {x=p.x, y=p.y-1, z=p.z}
		local n_bottom = minetest.get_node(p_bottom)
		-- Note: walkable is in the node definition, not in item groups
		if minetest.registered_nodes[n_bottom.name] and
				(minetest.get_item_group(n.name, "float") == 0 or
					minetest.registered_nodes[n_bottom.name].liquidtype == "none") and
				(n.name ~= n_bottom.name or (minetest.registered_nodes[n_bottom.name].leveled and
					minetest.get_node_level(p_bottom) < minetest.get_node_max_level(p_bottom))) and
				(not minetest.registered_nodes[n_bottom.name].walkable or
					minetest.registered_nodes[n_bottom.name].buildable_to) then
			if delay then
				minetest.after(0.1, nodeupdate_single, {x=p.x, y=p.y, z=p.z}, false)
			else
				n.level = minetest.get_node_level(p)
				local meta = minetest.get_meta(p)
				--print('get owner '.. meta:get_string("owner"))
				spawn_falling_node(p, n, meta:get_string("owner"))
				minetest.remove_node(p)
				nodeupdate(p)
			end
		end
	end

	if minetest.get_item_group(n.name, "attached_node") ~= 0 then
		if not check_attached_node(p, n) then
			drop_attached_node(p)
			nodeupdate(p)
		end
	end
end

function nodeupdate(p, delay)
	-- Round p to prevent falling entities to get stuck
	p.x = math.floor(p.x+0.5)
	p.y = math.floor(p.y+0.5)
	p.z = math.floor(p.z+0.5)

	for x = -1,1 do
	for y = -1,1 do
	for z = -1,1 do
		nodeupdate_single({x=p.x+x, y=p.y+y, z=p.z+z}, delay or not (x==0 and y==0 and z==0))
	end
	end
	end
end

--
-- Global callbacks
--

function on_placenode(p, node)
	nodeupdate(p)
end
minetest.register_on_placenode(on_placenode)

function on_dignode(p, node)
	nodeupdate(p)
end
minetest.register_on_dignode(on_dignode)

--
-- Protected Area
--

function is_protected_area(p, zone, name)
	for x= -zone, zone do
		for y= -zone, zone do
			for z= -zone, zone do
				local pos = {x=p.x+x,y=p.y+y,z=p.z+z}
				if minetest.is_protected(pos,name) then
					return true
				end
			end
		end
	end
	return false
end

--
-- rewrite of bucket
--

function add_protected_bukket_liquid(nameofbukket,liquidsourcename)
	minetest.override_item(nameofbukket, {
	on_place = function(itemstack, user, pointed_thing)
			-- Must be pointing to node
			if pointed_thing.type ~= "node" then
				return
			end
			-- Check if pointing to a buildable node
			local n = minetest.get_node(pointed_thing.under)

			if is_protected_area(pointed_thing.under, 4 ,user:get_player_name()) then
				minetest.chat_send_player(user:get_player_name(),"You can't place here - Too short of a protected area. (less than or equal to 4 blocks)")
				if minetest.is_protected(pointed_thing.under,user:get_player_name()) then
					minetest.log("action", user:get_player_name().. " try use "..nameofbukket.." at protected pos ".. minetest.pos_to_string(pointed_thing.under))
				end
				return itemstack
			end

			if minetest.registered_nodes[n.name].buildable_to then
				-- buildable; replace the node
				minetest.log("action", user:get_player_name().. " use "..nameofbukket.." at  ".. minetest.pos_to_string(pointed_thing.under))
				minetest.add_node(pointed_thing.under, {name=liquidsourcename})
			else
				-- not buildable to; place the liquid above
				-- check if the node above can be replaced
				n = minetest.get_node(pointed_thing.above)
				if minetest.registered_nodes[n.name].buildable_to then
					minetest.log("action", user:get_player_name().. " use "..nameofbukket.."  at  ".. minetest.pos_to_string(pointed_thing.above))
					minetest.add_node(pointed_thing.above, {name=liquidsourcename})
				else
					-- do not remove the bucket with the liquid
					return
				end
			end
			return {name="bucket:bucket_empty"}
		end
	})
end
