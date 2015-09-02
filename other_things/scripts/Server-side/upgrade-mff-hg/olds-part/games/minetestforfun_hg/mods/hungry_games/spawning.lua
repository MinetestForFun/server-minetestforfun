spawning = {}
local registered_spawns = {}
local filepath = minetest.get_worldpath()..'/spawning'

--Load spawns
local input = io.open(filepath..".spawns", "r")
if input then
    while true do
        local nodename = input:read("*l")
        if not nodename then break end
        local parms = {}
        --Catch config.
		i, flags = nodename:match("^(%S*) (.*)")
		repeat
			v, p = flags:match("^(%S*) (.*)")
			if p then
				flags = p
			end
			if v then
				table.insert(parms,v)
			else
				v = flags:match("^(%S*)")
				table.insert(parms,v)
				break
			end
		until false
		registered_spawns[i] = {
			pos={x=tonumber(parms[1]),y=tonumber(parms[2]),z=tonumber(parms[3])}
		}
	end
	io.close(input)
end

function spawning.save_spawns()
	local output = io.open(filepath..".spawns", "w")
	for i,v in pairs(registered_spawns) do
		output:write(i.." "..v.pos.x.." "..v.pos.y.." "..v.pos.z.."\n")
	end
	io.close(output)
end

--Set spawn pos
function spawning.set_spawn(place, pos)
	local spawn = registered_spawns[place]
	if not spawn then spawning.register_spawn(place, {}) end

	registered_spawns[place].pos = pos

	--Save spawns.
	spawning.save_spawns()
end

--Remove spawn pos
function spawning.unset_spawn(place)
	registered_spawns[place] = nil
	spawning.save_spawns()
end

function spawning.is_spawn(place)
	local spawn = registered_spawns[place]
	if not spawn then return false else return true end
end

function spawning.spawn(player, place)
	if type(player) == "table" then place = player[2] player = player[1] end
	local spawn = registered_spawns[place]
	local pos = spawn.pos
	if spawn then
		player:setpos(pos)
	end
	for i,v in pairs(minetest.env:find_nodes_in_area({x=pos.x-20,y=pos.y-20,z=pos.z-20}, {x=pos.x+20,y=pos.y+20,z=pos.z+20}, "default:lava_source")) do
		minetest.env:remove_node(v)
	end
end

function spawning.register_spawn(name, spawndef)
	local pos
	--Save spawnpoint position if it is already assigned.
	if registered_spawns[name] then pos = registered_spawns[name].pos end

	-- Apply defaults and add to registered_* table.
	setmetatable(spawndef, {__index = spawning.spawndef_default})
	registered_spawns[name] = spawndef

	--Restore position if it was already assigned.
	if pos then registered_spawns[name].pos = pos end

	--Save spawns.
	spawning.save_spawns()
end

spawning.spawndef_default = {
	pos = {x=0, y=0, z=0},
	mode = "static",
}
