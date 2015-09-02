--[[

Skyblock for Minetest

Copyright (c) 2015 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-skyblock
License: GPLv3

]]--

-- set mapgen to singlenode
minetest.register_on_mapgen_init(function(mgparams)
	minetest.set_mapgen_params({mgname='singlenode', water_level=-32000})
end)

-- new player
minetest.register_on_newplayer(function(player)
	-- spawn player
	skyblock.spawn_player(player)
end)

-- respawn player
minetest.register_on_respawnplayer(function(player)
	-- unset old spawn position
	if skyblock.dig_new_spawn then
		local player_name = player:get_player_name()
		local spawn = skyblock.get_spawn(player_name)
		skyblock.set_spawn(player_name, nil)
		skyblock.set_spawn(player_name..'_DEAD', spawn)
	end
	-- spawn player
	skyblock.spawn_player(player)
	return true
end)

-- register globalstep after the server starts
minetest.after(0.1, function()
	local spawn_timer = 0
	local spawn_throttle = 1

	-- handle globalstep
	minetest.register_globalstep(function(dtime)
		spawn_timer = spawn_timer + dtime

		-- only check once per throttle time
		if spawn_timer > spawn_throttle then
			for _,player in ipairs(minetest.get_connected_players()) do
				local pos = player:getpos()
				-- hit the bottom
				if pos.y < skyblock.world_bottom then
					local spawn = skyblock.get_spawn(player:get_player_name())
					if minetest.env:get_node(spawn).name == 'skyblock:quest' then
						player:set_hp(0)
					else
						skyblock.spawn_player(player)
					end
				end
			end
		end
		
		-- reset the spawn_timer
		if spawn_timer > spawn_throttle then	
			spawn_timer = 0
		end	
	
	end)

end)

-- register map generation
minetest.register_on_generated(function(minp, maxp, seed)
	-- do not handle mapchunks which are too heigh or too low
	if( minp.y > 0 or maxp.y < 0) then
		return
	end

	local vm, area, data, emin, emax

	-- if no voxelmanip data was passed on, read the data here
	if not(vm) or not(area) or not(data) then
		vm, emin, emax = minetest.get_mapgen_object('voxelmanip')
		if not(vm) then
			return
		end
		area = VoxelArea:new{
			MinEdge={x=emin.x, y=emin.y, z=emin.z},
			MaxEdge={x=emax.x, y=emax.y, z=emax.z},
		}
		data = vm:get_data()
	end

	-- add cloud floor
	local cloud_y = skyblock.world_bottom-2
	if minp.y<=cloud_y and maxp.y>=cloud_y then 
		local id_cloud = minetest.get_content_id('default:cloud')
		for x=minp.x,maxp.x do
			for z=minp.z,maxp.z do
				data[area:index(x,cloud_y,z)] = id_cloud
			end
		end
	end

	-- add world_bottom_node
	if skyblock.world_bottom_node ~= 'air' then
		local id_bottom = minetest.get_content_id(skyblock.world_bottom_node)
		local y_start = math.max(cloud_y+1,minp.y)
		local y_end   = math.min(skyblock.start_height,maxp.y)
		for x=minp.x,maxp.x do
			for z=minp.z,maxp.z do
				for y=y_start, y_end do
					data[area:index(x,y,z)] = id_bottom
				end
			end
		end
	end
	
	-- add starting blocks
	--[[
	local start_pos_list = skyblock.get_start_positions_in_mapchunk(minp, maxp)
	for _,pos in ipairs(start_pos_list) do
		skyblock.make_spawn_blocks_on_generated(pos, data, area)
	end
	]]--

	-- store the voxelmanip data
	vm:set_data(data)
	vm:calc_lighting(emin,emax)
	vm:write_to_map(data)
	vm:update_liquids()
end) 


-- no placing low nodes
minetest.register_on_placenode(function(pos, newnode, placer, oldnode)
	if pos.y <= skyblock.world_bottom then
		minetest.env:remove_node(pos)
		return true -- give back item
	end
end)