local function spawn_maze(name, param)
	local t1 = os.clock()
	math.randomseed(os.time())
	local found, _, maze_size_x_st, maze_size_y_st, maze_size_l_st, material_floor, material_wall, material_ceiling = param:find("(%d+)%s+(%d+)%s+(%d+)%s+([^%s]+)%s+([^%s]+)%s+([^%s]+)")
	local min_size = 11
	local maze_size_x = tonumber(maze_size_x_st)
	maze_size_x = maze_size_x or 20
	maze_size_x = math.max(maze_size_x, min_size)
	local maze_size_y = tonumber(maze_size_y_st)
	maze_size_y = maze_size_y or 20
	maze_size_y = math.max(maze_size_y, min_size)
	local maze_size_l = tonumber(maze_size_l_st)
	maze_size_l = maze_size_l or 3
	maze_size_l = math.max(maze_size_l, 1)
	-- check if chosen material exists
	if not minetest.registered_nodes[material_floor] then
		material_floor = "default:cobble"
	end
	material_floor = material_floor or "default:cobble"
	if not minetest.registered_nodes[material_wall] then
		material_wall = "default:cobble"
	end
	material_wall = material_wall or "default:cobble"
	if not minetest.registered_nodes[material_ceiling] then
		material_ceiling = "default:cobble"
	end
	material_ceiling = material_ceiling or "default:cobble"

	minetest.chat_send_player(name, "Try to build " .. maze_size_x .. " * " .. maze_size_y .. " * " .. maze_size_l .. " maze.  F:" .. material_floor .. " W:" .. material_wall .. " C:" .. material_ceiling)

	local maze = {}
	for l = 0, maze_size_l-1 do
		maze[l] = {}
		for x = 0, maze_size_x-1 do
			maze[l][x] = {}
			for y = 0, maze_size_y-1 do
				maze[l][x][y] = true -- everywhere walls
			end
		end
	end

-- create maze map
	local start_x = 0
	local start_y = math.floor(maze_size_y/2)
	local start_l = 0
	local pos_x = start_x
	local pos_y = start_y
	local pos_l = start_l
	maze[pos_l][pos_x][pos_y] = false -- the entrance
	local moves = {}
	local updowns = {}
	local possible_ways = {}
	local direction = ""
	local pos = {x = 0, y = 0, l = 0}
	local forward = true
	local return_count = 0
	local treasure_x = 0
	local treasure_y = 0
	local treasure_l = 0
	local dead_end = {}
	table.insert(moves, {x = pos_x, y = pos_y, l = pos_l})
	-- print(#moves .. " " .. moves[1].x .. " " .. moves[1].y)
	repeat
		possible_ways = {}
		-- is D possible?
		if
			pos_x > 1 and pos_x < maze_size_x - 1 and pos_y > 1 and pos_y < maze_size_y - 1 and
			pos_l < maze_size_l - 1 and
			maze[pos_l + 1][pos_x - 1][pos_y - 1] and
			maze[pos_l + 1][pos_x - 1][pos_y] and
			maze[pos_l + 1][pos_x - 1][pos_y + 1] and
			maze[pos_l + 1][pos_x][pos_y - 1] and
			maze[pos_l + 1][pos_x][pos_y] and
			maze[pos_l + 1][pos_x][pos_y + 2] and
			maze[pos_l + 1][pos_x + 1][pos_y - 1] and
			maze[pos_l + 1][pos_x + 1][pos_y] and
			maze[pos_l + 1][pos_x + 1][pos_y + 1]
		then
			table.insert(possible_ways, "D")
		end
		-- is U possible?
		if
			pos_x > 1 and pos_x < maze_size_x - 1 and pos_y > 1 and pos_y < maze_size_y - 1 and
			pos_l > 0 and
			maze[pos_l - 1][pos_x - 1][pos_y - 1] and
			maze[pos_l - 1][pos_x - 1][pos_y] and
			maze[pos_l - 1][pos_x - 1][pos_y + 1] and
			maze[pos_l - 1][pos_x][pos_y - 1] and
			maze[pos_l - 1][pos_x][pos_y] and
			maze[pos_l - 1][pos_x][pos_y + 2] and
			maze[pos_l - 1][pos_x + 1][pos_y - 1] and
			maze[pos_l - 1][pos_x + 1][pos_y] and
			maze[pos_l - 1][pos_x + 1][pos_y + 1]
		then
			table.insert(possible_ways, "U")
		end
		-- is N possible?
		if
			pos_y - 2 >= 0 and pos_x - 1 >= 0 and pos_x + 1 < maze_size_x and
			maze[pos_l][pos_x][pos_y - 1] and -- N is wall
			maze[pos_l][pos_x][pos_y - 2] and -- N from N is wall
			maze[pos_l][pos_x - 1][pos_y - 2] and -- NW from N is wall
			maze[pos_l][pos_x + 1][pos_y - 2] and -- NE from N is wall
			maze[pos_l][pos_x - 1][pos_y - 1] and -- W from N is wall
			maze[pos_l][pos_x + 1][pos_y - 1] -- E from N is wall
		then
			table.insert(possible_ways, "N")
			table.insert(possible_ways, "N") -- twice as possible as U and D
		end
		-- is E possible?
		if
			pos_x + 2 < maze_size_x and pos_y - 1 >= 0 and pos_y + 1 < maze_size_y and
			maze[pos_l][pos_x + 1][pos_y] and -- E is wall
			maze[pos_l][pos_x + 2][pos_y] and -- E from E is wall
			maze[pos_l][pos_x + 2][pos_y - 1] and -- NE from E is wall
			maze[pos_l][pos_x + 2][pos_y + 1] and -- SE from E is wall
			maze[pos_l][pos_x + 1][pos_y - 1] and -- N from E is wall
			maze[pos_l][pos_x + 1][pos_y + 1] -- S from E is wall
		then
			table.insert(possible_ways, "E")
			table.insert(possible_ways, "E") -- twice as possible as U and D
		end
		-- is S possible?
		if
			pos_y + 2 < maze_size_y and pos_x - 1 >= 0 and pos_x + 1 < maze_size_x and
			maze[pos_l][pos_x][pos_y + 1] and -- S is wall
			maze[pos_l][pos_x][pos_y + 2] and -- S from S is wall
			maze[pos_l][pos_x - 1][pos_y + 2] and -- SW from S is wall
			maze[pos_l][pos_x + 1][pos_y + 2] and -- SE from S is wall
			maze[pos_l][pos_x - 1][pos_y + 1] and -- W from S is wall
			maze[pos_l][pos_x + 1][pos_y + 1] -- E from S is wall
		then
			table.insert(possible_ways, "S")
			table.insert(possible_ways, "S") -- twice as possible as U and D
		end
		-- is W possible?
		if
			pos_x - 2 >= 0 and pos_y - 1 >= 0 and pos_y + 1 < maze_size_y and
			maze[pos_l][pos_x - 1][pos_y] and -- W is wall
			maze[pos_l][pos_x - 2][pos_y] and -- W from W is wall
			maze[pos_l][pos_x - 2][pos_y - 1] and -- NW from W is wall
			maze[pos_l][pos_x - 2][pos_y + 1] and -- SW from W is wall
			maze[pos_l][pos_x - 1][pos_y - 1] and -- N from W is wall
			maze[pos_l][pos_x - 1][pos_y + 1] -- S from W is wall
		then
			table.insert(possible_ways, "W")
			table.insert(possible_ways, "W") -- twice as possible as U and D
		end
		if #possible_ways > 0 then
			forward = true
			direction = possible_ways[math.random(# possible_ways)]
			if direction == "N" then
				pos_y = pos_y - 1
			elseif direction == "E" then
				pos_x = pos_x + 1
			elseif direction == "S" then
				pos_y = pos_y + 1
			elseif direction == "W" then
				pos_x = pos_x - 1
			elseif direction == "D" then
				table.insert(updowns, {x = pos_x, y = pos_y, l = pos_l}) -- mark way down
				pos_l = pos_l + 1
			elseif direction == "U" then
				pos_l = pos_l - 1
				table.insert(updowns, {x = pos_x, y = pos_y, l = pos_l}) -- mark way up = down from level above
			end
			table.insert(moves, {x = pos_x, y = pos_y, l = pos_l})
			maze[pos_l][pos_x][pos_y] = false
			-- print(# possible_ways .. " " .. direction)
		else -- there is no possible way forward
			if forward then -- the last step was forward, now back, so we're in a dead end
				-- mark dead end for possible braid
				if not maze[pos_l][pos_x - 1][pos_y] then -- dead end to E, only way is W
					table.insert(dead_end, {x = pos_x, y = pos_y, l = pos_l, dx = 1, dy = 0})
				elseif not maze[pos_l][pos_x + 1][pos_y] then -- dead end to W, only way is E
					table.insert(dead_end, {x = pos_x, y = pos_y, l = pos_l, dx = -1, dy = 0})
				elseif not maze[pos_l][pos_x][pos_y - 1] then -- dead end to S, only way is N
					table.insert(dead_end, {x = pos_x, y = pos_y, l = pos_l, dx = 0, dy = 1})
				elseif not maze[pos_l][pos_x][pos_y + 1] then -- dead end to N, only way is S
					table.insert(dead_end, {x = pos_x, y = pos_y, l = pos_l, dx = 0, dy = -1})
				end
				-- third time returning is location of treasure, if there are three ways back else it's somewhere before
				if return_count <= 3 then
					-- print("place treasure")
					treasure_x = pos_x
					treasure_y = pos_y
					treasure_l = pos_l
				end
				return_count = return_count + 1
				forward = false
			end
			pos = table.remove(moves)
			pos_x = pos.x
			pos_y = pos.y
			pos_l = pos.l
			-- print("get back to " .. pos_x .. " / " .. pos_y .. " / " .. pos_l .. " to find another way from there")
		end
	until pos_x == start_x
	and pos_y == start_y
-- create partial braid maze, about 20%
	for _, braid_pos in pairs(dead_end) do
		if braid_pos.x ~= treasure_x
		or braid_pos.y ~= treasure_y
		or braid_pos.l ~= treasure_l then -- treasure remains in dead end
			-- print(braid_pos.x.."/"..braid_pos.y.."/"..braid_pos.l.." "..braid_pos.dx.."/"..braid_pos.dy)
			local x = braid_pos.x + braid_pos.dx * 2
			local y = braid_pos.y + braid_pos.dy * 2
			if math.random(5) == 1
			and x > 0
			and x < maze_size_x - 1
			and y > 0
			and y < maze_size_y - 1
			and not maze[braid_pos.l][x][y] then
				-- remove wall if behind is corridor with 20% chance
				maze[braid_pos.l][braid_pos.x + braid_pos.dx][braid_pos.y + braid_pos.dy] = false
				print("removed "..braid_pos.l.."/"..braid_pos.x + braid_pos.dx.."/"..braid_pos.y + braid_pos.dy)
			end
		end
	end
-- create exit on opposite end of maze and make sure it is reachable
	local exit_x = maze_size_x - 1 -- exit always on opposite side of maze
	local exit_y = math.random(maze_size_y - 3) + 1
	local exit_l = math.random(maze_size_l) - 1
	local exit_reachable = false
	repeat
		maze[exit_l][exit_x][exit_y] = false
		exit_reachable = not maze[exit_l][exit_x - 1][exit_y] or not maze[exit_l][exit_x][exit_y - 1] or not maze[exit_l][exit_x][exit_y + 1]
		exit_x = exit_x - 1
	until exit_reachable

	local player = minetest.get_player_by_name(name)
-- get transform factors to place the maze in "look_dir" of player
	local player_dir = player:get_look_dir()
	local cosine = 1
	local sine = 0
	if math.abs(player_dir.x) > math.abs(player_dir.z) then
		if player_dir.x <= 0 then
			cosine = -1
		end
	else
		cosine = 0
		if player_dir.z < 0 then
			sine = -1
		else
			sine = 1
		end
	end
	-- print (cosine .. " " .. sine)

	local playerpos = vector.round(player:getpos())
-- build maze in minetest-world
	local min, max
	local tab = {}
	for l = maze_size_l-1, 0, -1 do
		for y = 0, maze_size_y-1 do
			local line
			if l == 0
			and y == start_y then
				line = "<-"
			else
				line = "  "
			end
			for x = 0, maze_size_x - 1 do
				local ladder_direction = 2
				-- rotate the maze in players view-direction and move it to his position
				local change_level_down = false
				local change_level_up = false
				for i, v in ipairs(updowns) do
					if v.x == x
					and v.y == y then
						if v.l == l then
							change_level_down = true
							-- find direction for the ladders
							ladder_direction = 2
							if maze[l][x - 1][y] and maze[l + 1][x - 1][y] then ladder_direction = 3 end
							if maze[l][x + 1][y] and maze[l + 1][x + 1][y] then ladder_direction = 2 end
							if maze[l][x][y - 1] and maze[l + 1][x][y - 1] then ladder_direction = 5 end
							if maze[l][x][y + 1] and maze[l + 1][x][y + 1] then ladder_direction = 4 end
						elseif v.l == l - 1 then
							change_level_up = true
							-- find direction for the ladders
							if maze[l][x][y + 1] then
								ladder_direction = 4
							elseif maze[l][x][y - 1] then
								ladder_direction = 5
							elseif maze[l][x + 1][y] then
								ladder_direction = 2
							elseif maze[l][x - 1][y] then
								ladder_direction = 3
							else
								ladder_direction = 2
							end
						end
					end
				end
				-- rotate direction for the ladders
				if sine == 1 then
					if ladder_direction == 2 then ladder_direction = 4
					elseif ladder_direction == 3 then ladder_direction = 5
					elseif ladder_direction == 4 then ladder_direction = 3
					elseif ladder_direction == 5 then ladder_direction = 2 end
				elseif sine == -1 then
					if ladder_direction == 2 then ladder_direction = 5
					elseif ladder_direction == 3 then ladder_direction = 4
					elseif ladder_direction == 4 then ladder_direction = 2
					elseif ladder_direction == 5 then ladder_direction = 3 end
				elseif cosine == -1 then
					if ladder_direction == 2 then ladder_direction = 3
					elseif ladder_direction == 3 then ladder_direction = 2
					elseif ladder_direction == 4 then ladder_direction = 5
					elseif ladder_direction == 5 then ladder_direction = 4 end
				end

				local pos = vector.add(playerpos, {
					x = cosine * (x + 2) - sine * (y - start_y),
					z = sine * (x + 2) + cosine * (y - start_y),
					y = - 1 - 3 * l
				})
				if not min then
					min = vector.new(pos)
					max = vector.new(pos)
				end
				min.x = math.min(min.x, pos.x)
				min.y = math.min(min.y, pos.y)
				min.z = math.min(min.z, pos.z)
				max.x = math.max(max.x, pos.x)
				max.z = math.max(max.z, pos.z)
				if not change_level_down then
					table.insert(tab, {{pos.x, pos.y, pos.z}, 1})
				end
				pos.y = pos.y + 1
				local letter = "  "
				if maze[l][x][y] then
					--line = "X" .. line
					letter = "██"
					table.insert(tab, {{pos.x, pos.y, pos.z}, 2})
					pos.y = pos.y + 1
					table.insert(tab, {{pos.x, pos.y, pos.z}, 2})
				else
					-- if change_level_down then minetest.add_node(pos, {name = "default:ladder", param2 = ladder_direction}) end
					if change_level_up then
						table.insert(tab, {{pos.x, pos.y, pos.z}, 4, ladder_direction})
						letter = "╞╡"
					else
						table.insert(tab, {{pos.x, pos.y, pos.z}, 0})
					end
					pos.y = pos.y + 1
					if change_level_up then
						table.insert(tab, {{pos.x, pos.y, pos.z}, 4, ladder_direction})
					elseif change_level_down then
						table.insert(tab, {{pos.x, pos.y, pos.z}, 5, ladder_direction})
						letter = "☀▤"
					elseif math.random(20) == 1 then
						table.insert(tab, {{pos.x, pos.y, pos.z}, 5})
						letter = "☀ "
					else
						table.insert(tab, {{pos.x, pos.y, pos.z}, 0})
					end
				end
				line = letter .. line
				pos.y = pos.y + 1
				if change_level_up then
					table.insert(tab, {{pos.x, pos.y, pos.z}, 4, ladder_direction})
				else
					table.insert(tab, {{pos.x, pos.y, pos.z}, 3})
				end
				max.y = math.max(max.y, pos.y)
			end
			if l == exit_l
			and y == exit_y then
				line = "<-" .. line
			else
				line = "  " .. line
			end
			print(line)
		end
	end


	local c = {
		[0] = minetest.get_content_id("air"),
		minetest.get_content_id(material_floor),
		minetest.get_content_id(material_wall),
		minetest.get_content_id(material_ceiling),
		minetest.get_content_id("default:ladder"),
		minetest.get_content_id("default:torch"),
	}

	local manip = minetest.get_voxel_manip()
	local emerged_pos1, emerged_pos2 = manip:read_from_map(min, max)
	local area = VoxelArea:new({MinEdge=emerged_pos1, MaxEdge=emerged_pos2})
	local nodes = manip:get_data()
	local param2s = manip:get_param2_data()

	for _,p in pairs(tab) do
		local p, typ, par = unpack(p)
		p = area:index(unpack(p))
		nodes[p] = c[typ]
		if par then
			param2s[p] = par
		end
	end

	manip:set_data(nodes)
	manip:set_param2_data(param2s)
	manip:write_to_map()
	manip:update_map()


	-- if exit is underground, dig a hole to surface
	local ladder_direction = 2
	if cosine == -1 then ladder_direction = 3 end
	if sine == -1 then ladder_direction = 5 end
	if sine == 1 then ladder_direction = 4 end
	local pos = vector.add(playerpos, {
		x = cosine * (maze_size_x + 2) - sine * (exit_y - start_y),
		z = sine * (maze_size_x + 2) + cosine * (exit_y - start_y),
		y = - 3 * exit_l
	})
	local is_air  = minetest.get_node_or_nil(pos)
	while is_air
	and is_air.name ~= "air" do
		minetest.add_node(pos, {name = "default:ladder", param2 = ladder_direction})
		pos.y = pos.y + 1
		is_air  = minetest.get_node_or_nil(pos)
	end

-- place a chest as treasure
	local items = 0
	local item_list = {}
	for name in pairs(minetest.registered_items) do
		if string.find(name, "default:") then
			items = items + 1
			item_list[items] = name
		end
	end
	pos = vector.add(playerpos, {
		x = cosine * (treasure_x + 2) - sine * (treasure_y - start_y),
		z = sine * (treasure_x + 2) + cosine * (treasure_y - start_y),
		y = - 3 * treasure_l
	})
	minetest.add_node(pos, {name = "default:chest"})
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	for _,name in pairs(item_list) do
		if math.random(items / 5) == 1 then
			inv:add_item('main', name)
		end
	end

-- place a closer-stone to seal the entrance and exit
	minetest.add_node(vector.add(playerpos, {
		x = cosine * (start_x + 2),
		z = sine * (start_x + 2),
		y = - 3 * start_l - 1
	}), {name = "maze:closer"})
	minetest.add_node(vector.add(playerpos, {
		x = cosine * (maze_size_x + 1) - sine * (exit_y - start_y),
		z = sine * (maze_size_x + 1) + cosine * (exit_y - start_y),
		y = - 3 * exit_l - 1
	}), {name = "maze:closer"})
	print(string.format("[maze] done after ca. %.2fs", os.clock() - t1))
end

minetest.register_chatcommand("maze", {
	params = "<size_x> <size_y> <#floors> <material_floor> <material_wall> <material_ceiling>",
	privs = {server = true},
	description = "Create a maze near your position",
	func = spawn_maze
})

local maze_closer = {} -- list of all closer stones
local closer_available = false

-- closer stone definition
minetest.register_node("maze:closer", {
	description = "Closestone",
	tiles = {"default_cobble.png"},
	drop = "",
	material = { diggability = "not"},
	on_construct = function(pos)
		maze_closer[#maze_closer+1] = pos
		closer_available = true
	end,
})

-- detect player walk over closer stone (abm isn't fast enough)
local function playerwalk()
	for _,player in pairs(minetest.get_connected_players()) do
		local player_pos = player:getpos()
		for _,pos in pairs(maze_closer) do
			local dist = math.sqrt( (pos.x - player_pos.x)^2 + (pos.y - (player_pos.y - 0.5))^2 + (pos.z - player_pos.z)^2 )
			if dist<3 then -- 2.2 would be enough, just make sure
				local meta = minetest.get_meta(pos)
				if dist<0.5 then
					meta:set_string("trap", "triggered")
				elseif dist > 1 then -- 0.71 would be enough, at least one node away
					if meta:get_string("trap") == "triggered" then
						meta:set_string("trap", "")
						for i = 0,2 do
							minetest.add_node({x = pos.x, y = pos.y+i, z = pos.z},{name="default:cobble"})
						end
						minetest.sound_play("default_chest_locked", {pos = pos})
					end
				end
			end
		end
	end
end

local function do_step()
	local tstep
	if closer_available then
		tstep = 0
		playerwalk()
	else
		tstep = 2
	end
	minetest.after(tstep, do_step)
end
minetest.after(5, do_step)

-- create list of all closer stones (walk over detection now in globalstep, because abm isn't called often enough
minetest.register_abm({
	nodenames = {"maze:closer"},
	interval = 5,
	chance = 1,
	action = function(pos)
		for _,closer_pos in pairs(maze_closer) do
			if vector.equals(pos, closer_pos) then
				return
			end
		end
		maze_closer[#maze_closer+1] = pos
		closer_available = true
	end,
})
