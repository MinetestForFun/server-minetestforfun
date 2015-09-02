--[[

Skyblock for Minetest

Copyright (c) 2015 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-skyblock
License: GPLv3

]]--

-- expose functions to other modules
skyblock = {}


--
-- CONFIG OPTIONS
--

-- Debug mode
skyblock.debug = minetest.setting_getbool('skyblock.debug')

-- How far apart to set players start positions
skyblock.start_gap = tonumber(minetest.setting_get('skyblock.start_gap')) or 32

-- The Y position the spawn nodes will appear
skyblock.start_height = tonumber(minetest.setting_get('skyblock.start_height')) or 4

-- How many players will be in 1 row
-- skyblock.world_width * skyblock.world_width = total players
skyblock.world_width = tonumber(minetest.setting_get('skyblock.world_width')) or 1000

-- How far down (in nodes) before a player dies and is respawned
skyblock.world_bottom = tonumber(minetest.setting_get('skyblock.world_bottom')) or -8

-- Node to use for the world bottom
skyblock.world_bottom_node = minetest.setting_get('skyblock.world_bottom') or 'air' -- 'air' || 'default:water_source' || 'default:lava_source'

-- Should digging the spawn result in a new spawn pos?
skyblock.dig_new_spawn = minetest.setting_getbool('skyblock.dig_new_spawn')

-- Should player lose bags on death?
skyblock.lose_bags_on_death = minetest.setting_getbool('skyblock.lose_bags_on_death')

-- Which schem file to use
skyblock.schem = minetest.setting_get('skyblock.schem') or 'island.schem'

-- Schem offset X
skyblock.schem_offset_x = tonumber(minetest.setting_get('skyblock.schem_offset_x')) or -3

-- Schem offset Y
skyblock.schem_offset_y = tonumber(minetest.setting_get('skyblock.schem_offset_y')) or -4

-- Schem offset Z
skyblock.schem_offset_z = tonumber(minetest.setting_get('skyblock.schem_offset_z')) or -3


-- local variables
local filename = minetest.get_worldpath()..'/skyblock'
local last_start_id = 0
local start_positions = {}
local spawnpos = {}


--
-- PUBLIC FUNCTIONS
--

-- log
function skyblock.log(message)
	if not skyblock.debug then
		return
	end
	minetest.log('action', '[skyblock] '..message)
end

-- dump_pos
function skyblock.dump_pos(pos)
	if pos==nil then return 'nil' end
	return '{x='..pos.x..',y='..pos.x..',z='..pos.z..'}'
end

-- get players spawn position
function skyblock.get_spawn(player_name)
	local spawn = spawnpos[player_name]
	if spawn then
		skyblock.log('get_spawn() for '..player_name..' is '..skyblock.dump_pos(spawn))
		return spawn
	end
	skyblock.log('get_spawn() for '..player_name..' is unknown')
end

-- get player_name at spawn position
function skyblock.get_spawn_player(pos)
	for player_name,spawn in pairs(spawnpos) do
		if spawn.x == pos.x and spawn.y == pos.y and spawn.z == pos.z then
			return player_name
		end
	end
	return nil
end

-- set players spawn position
function skyblock.set_spawn(player_name, pos)
	skyblock.log('set_spawn() for '..player_name..' at '..skyblock.dump_pos(pos))
	spawnpos[player_name] = pos
	-- save the spawn data from the table to the file
	local output = io.open(filename..'.spawn', 'w')
	for i, v in pairs(spawnpos) do
		if v ~= nil then
			output:write(v.x..' '..v.y..' '..v.z..' '..i..'\n')
		end
	end
	io.close(output)
end

-- get next spawn position
function skyblock.get_next_spawn()
	skyblock.log('get_next_spawn()')
	last_start_id = last_start_id+1
	local output = io.open(filename..'.last_start_id', 'w')
	output:write(last_start_id)
	io.close(output)
	local spawn = start_positions[last_start_id]
	if spawn == nil then
		print('MAJOR ERROR - no spawn position at id='..last_start_id)
	end
	return spawn
end

-- handle player spawn setup
function skyblock.spawn_player(player)
	local player_name = player:get_player_name()
	skyblock.log('skyblock.spawn_player() '..player_name)
	
	-- find the player spawn point
	local spawn = skyblock.get_spawn(player_name)
	if spawn == nil then
		spawn = skyblock.get_next_spawn()
		skyblock.set_spawn(player_name,spawn)
	end
	
	-- add the start block and teleport the player
	skyblock.make_spawn_blocks(spawn,player_name)
	player:setpos({x=spawn.x,y=spawn.y+6,z=spawn.z})
	player:set_hp(20)
end

-- load schem
local schempath = minetest.get_modpath(minetest.get_current_modname())..'/schems'
function skyblock.load_schem(origin,filename)
	local file, err = io.open(schempath..'/'..filename, 'rb')
	local value = file:read('*a')
	file:close()
		
	local nodes = minetest.deserialize(value)
	if not nodes then return nil end

	for _,entry in ipairs(nodes) do
		local pos = {
			x=entry.x + origin.x + skyblock.schem_offset_x,
			y=entry.y + origin.y + skyblock.schem_offset_y,
			z=entry.z + origin.z + skyblock.schem_offset_z,
		}
		if minetest.env:get_node(pos).name == 'air' then
			minetest.add_node(pos, {name=entry.name})
		end
	end
end

-- make spawn blocks
function skyblock.make_spawn_blocks(pos, player_name)
	skyblock.log('skyblock.make_spawn_blocks('..skyblock.dump_pos(pos)..', '..player_name..') ')
	skyblock.load_schem(pos,skyblock.schem)
	--minetest.env:add_node(pos, {name='skyblock:quest'})
end

-- make spawn blocks on generated
--[[
function skyblock.make_spawn_blocks_on_generated(pos, data, area)
	local id_dirt = minetest.get_content_id('default:dirt')
	for x=-1,1 do
		for z=-1,1 do
			data[area:index(pos.x+x,pos.y,pos.z+z)] = id_dirt
			data[area:index(pos.x+x,pos.y-1,pos.z+z)] = id_dirt
			data[area:index(pos.x+x,pos.y-2,pos.z+z)] = id_dirt
		end
	end
	data[area:index(pos.x,pos.y,pos.z)] = minetest.get_content_id('skyblock:quest')
	--minetest.registered_nodes['skyblock:quest'].on_construct(pos)
end
]]--

-- get start positions in mapchunk
--[[
skyblock.get_start_positions_in_mapchunk = function(minp, maxp)
	local list = {};
	for i,v in ipairs(start_positions) do
		if     v.x>=minp.x and v.x<=maxp.x
		   and v.y>=minp.y and v.y<=maxp.y
		   and v.z>=minp.z and v.z<=maxp.z then
			list[#list+1] = {x=v.x, y=v.y, z=v.z}
		end
	end
	return list
end
]]--


--
-- LOCAL FUNCTIONS
--

-- spiral matrix - used to generate starting positions
-- http://rosettacode.org/wiki/Spiral_matrix#Lua
av, sn = math.abs, function(s) return s~=0 and s/av(s) or 0 end
local function sindex(y, x) -- returns the value at (x, y) in a spiral that starts at 1 and goes outwards
	if y == -x and y >= x then return (2*y+1)^2 end
	local l = math.max(av(y), av(x))
	return (2*l-1)^2+4*l+2*l*sn(x+y)+sn(y^2-x^2)*(l-(av(y)==l and sn(y)*x or sn(x)*y)) -- OH GOD WHAT
end
local function spiralt(side)
	local ret, id, start, stop = {}, 0, math.floor((-side+1)/2), math.floor((side-1)/2)
	for i = 1, side do
		for j = 1, side do
			local id = side^2 - sindex(stop - i + 1,start + j - 1)
			ret[id] = {x=i,z=j}
		end
	end
	return ret
end

-- reverse ipairs
local function ripairs(t)
	local function ripairs_it(t,i)
		i=i-1
		local v=t[i]
		if v==nil then return v end
		return i,v
	end
	return ripairs_it, t, #t+1
end


--
-- INIT FUNCTIONS
--

-- load the spawn data from disk
local function load_spawn()
    local input = io.open(filename..'.spawn', 'r')
    if input then
        while true do
            local x = input:read('*n')
            if x == nil then
                break
            end
            local y = input:read('*n')
            local z = input:read('*n')
            local name = input:read('*l')
            spawnpos[name:sub(2)] = {x = x, y = y, z = z}
        end
        io.close(input)
    else
        spawnpos = {}
    end
end
load_spawn() -- run it now

-- load the start positions from disk
local function load_start_positions()
    local input = io.open(filename..'.start_positions', 'r')

	-- create start_positions file if needed
    if not input then
		skyblock.log('generate start positions')
		local output = io.open(filename..'.start_positions', 'w')
		local pos
		for i,v in ripairs(spiralt(skyblock.world_width)) do -- get positions using spiral
			pos = {x=v.x*skyblock.start_gap, y=skyblock.start_height, z=v.z*skyblock.start_gap}
			output:write(pos.x..' '..pos.y..' '..pos.z..'\n')
		end
		io.close(output)
		input = io.open(filename..'.start_positions', 'r')
	end
	
	-- read start positions
	skyblock.log('read start positions')
	while true do
		local x = input:read('*n')
		if x == nil then
			break
		end
		local y = input:read('*n')
		local z = input:read('*n')
		table.insert(start_positions,{x = x, y = y, z = z})
	end
	io.close(input)
end
load_start_positions() -- run it now

-- load the last start position from disk
local function load_last_start_id()
	local input = io.open(filename..'.last_start_id', 'r')
	
	-- create last_start_id file if needed
    if not input then
		local output = io.open(filename..'.last_start_id', 'w')
		output:write(last_start_id)
		io.close(output)
		input = io.open(filename..'.last_start_id', 'r')
	end
	
	-- read last start id
	last_start_id = input:read('*n')
	if last_start_id == nil then
		last_start_id = 0
	end
	io.close(input)
	
end
load_last_start_id() -- run it now
