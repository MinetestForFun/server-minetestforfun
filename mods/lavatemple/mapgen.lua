lavatemple.mapgen_data = {}
lavatemple.file = minetest.get_worldpath()..'/lavatemple.mt'

-- try to load the data from file
local f = io.open(lavatemple.file, "r")
if f then
	local contents = f:read()
	io.close(f)
	if contents ~= nil then
		lavatemple.mapgen_data = minetest.deserialize(contents)
	end
end

-- generate position of the temple (if not done already)
if type (lavatemple.mapgen_data) ~= "table" or
   lavatemple.mapgen_data.pos == nil or
   lavatemple.mapgen_data.pos.x == nil or
   lavatemple.mapgen_data.pos.y == nil or
   lavatemple.mapgen_data.pos.z == nil then

	-- generate the temple position
	math.randomseed(os.time())
	lavatemple.mapgen_data.pos = {
		x=math.random(-2000,2000),
		y=math.random(-500,-50),
		z=math.random(-2000,2000)
	}

	-- save data
	local f = io.open(lavatemple.file, "w")
	f:write(minetest.serialize(lavatemple.mapgen_data))
	io.close(f)
end

minetest.register_on_generated(function(minp,maxp,seed)
	local ltp = lavatemple.mapgen_data.pos
	if ltp.x > minp.x and ltp.x < maxp.x and
	   ltp.y > minp.y and ltp.y < maxp.y and
	   ltp.z > minp.z and ltp.z < maxp.z then
		local f = io.open(minetest.get_modpath("lavatemple").."/schems/lavatemple.we", "r")
		if not f then return end
		local contents = f:read()
		io.close(f)
		if not contents then return end
		-- Clear the area since worldedit doesn't save "air" nodes
		pos1, pos2, count = worldedit.allocate(ltp, contents)
		for x=pos1.x,pos2.x do
		for y=pos1.y,pos2.y do
		for z=pos1.z,pos2.z do
			minetest.remove_node({x=x,y=y,z=z})
		end end end
		-- Deserialize the temple
		--worldedit.deserialize(ltp, contents, minetest|.env)
		worldedit.deserialize(ltp, contents, minetest)
	end
end)

