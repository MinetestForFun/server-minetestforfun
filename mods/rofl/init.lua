--------------------------------------
-- <put meaning here>
-- ROFLMAO
-- Licence : CC0
-- Last modified : 27/11/15
-- By : Mg
--
--

local bufferfiles = minetest.get_worldpath() .. "/roflmao/"
minetest.mkdir(bufferfiles)

rofl = {}
rofl.version = "ROFLMAO"

rofl.files = {}

rofl.conf = {}
rofl.conf.Tick = 20 -- Tick interval
rofl.conf.Rpertick = 2000 -- Max reading operations per tick
rofl.conf.Wpertick = 5000 -- Max writing operations per tick
rofl.conf.Apertick = 1000 -- Max application operations per tick
rofl.conf.Lpertick = 7500 -- Max loading operations per tick

rofl.buffers = {}
rofl.buffers.RCache = {} -- Reading
rofl.buffers.WCache = {} -- Writing
rofl.buffers.LCache = {} -- Loading -- not in use
rofl.buffers.ACache = {} -- Application



function rofl.capture(f, pos1, pos2)
	local posU = {x = math.max(pos1.x, pos2.x), y = math.max(pos1.y, pos2.y), z = math.max(pos1.z, pos2.z)}
	local posD = {x = math.min(pos1.x, pos2.x), y = math.min(pos1.y, pos2.y), z = math.min(pos1.z, pos2.z)}

	local n = 0
	for x = posD.x, posU.x do
		for y = posD.y, posU.y do
			for z = posD.z, posU.z do
				local node = minetest.get_node_or_nil({x = x, y = y, z = z})
				if not node or node.name == "ignore" then
					return false
				else
					table.insert(rofl.buffers.WCache, {f, x-posD.x .. ";" .. y-posD.y .. ";" .. z-posD.z .. "|" .. minetest.serialize(node) .. "\n"})
					n = n + 1
				end
			end
		end
	end
	return n
end

minetest.register_chatcommand("roflCapture", {
	params = "<pos1> <pos2> <name>",
	description = "Capture nodes contained in area pos1 to pos2",
	privs = {server=true},
	func = function(name, param)
		local f, p1, p2 = unpack(param:split(" "))

		if not f then
			return false, "Invalid buffer name"
		elseif not minetest.string_to_pos(p1) then
			return false, "Invalid pos1"
		elseif not minetest.string_to_pos(p2) then
			return false, "Invalid pos2"
		end
		p1 = minetest.string_to_pos(p1)
		p2 = minetest.string_to_pos(p2)

		local k = rofl.capture(f, p1, p2)
		if k then
			return true, "Successfully captured area from " ..
				core.pos_to_string(p1, 1) .. " to " .. core.pos_to_string(p2, 1) ..
				" in file " .. f .. " : " .. k .. " nodes"
		else
			return false, "Failed to capture the area"
		end
	end,
})

minetest.register_on_shutdown(function()
	if table.getn(rofl.buffers.WCache) > 0 then
		minetest.log("warning", "{ROFL} WCache is not empty! Canceling all pending writing operations")
		rofl.buffers.WCache = {}
	end

	if table.getn(rofl.buffers.ACache) > 0 then
		minetest.log("warning", "{ROFL} ACache is not empty! Canceling all pending application operations")
		rofl.buffers.ACache = {}
	end

	for fname, f in pairs(rofl.files) do
		f:close()
		minetest.log("action", "{ROFL} Closing filebuf " .. fname)
	end
end)

function tick()
	local t = os.time()

	-- Writing
	if table.getn(rofl.buffers.WCache) > 0 then
		minetest.log("action", "{ROFL} WCache has " .. table.getn(rofl.buffers.WCache) .. " elements")
		minetest.log("action", "{ROFL} Doing up to " .. rofl.conf.Wpertick .. " writing operations")

		for x = 1, rofl.conf.Wpertick do
			if not rofl.buffers.WCache[1] then break end

			if not rofl.files[rofl.buffers.WCache[1][1]] then
				rofl.files[rofl.buffers.WCache[1][1]] = io.open(bufferfiles .. rofl.buffers.WCache[1][1] .. ".buf", "w")
			end

			rofl.files[rofl.buffers.WCache[1][1]]:write(rofl.buffers.WCache[1][2])
			table.remove(rofl.buffers.WCache, 1)
		end

		if table.getn(rofl.buffers.WCache) == 0 then
			minetest.log("action", "{ROFL} Operations finished")
			for fname, f in pairs(rofl.files) do
				f:close()
				minetest.log("action", "{ROFL} Closing filebuf " .. fname)
			end
			rofl.files = {}
		end
	end

	-- Applying
	if table.getn(rofl.buffers.ACache) > 0 then
		minetest.log("action", "{ROFL} ACache has " .. table.getn(rofl.buffers.WCache) .. " elements")
		minetest.log("action", "{ROFL} Doing up to " .. rofl.conf.Wpertick .. " writing operations")

		for x = 1, rofl.conf.Apertick do
			if not rofl.buffers.ACache[1] then break end
			buffer:write(rofl.buffers.ACache[1])
			table.remove(rofl.buffers.ACache, 1)
		end

		if table.getn(rofl.buffers.ACache) == 0 then
			minetest.log("action", "{ROFL} Operations finished")
		end
	end

	local t2 = os.time()
	if os.difftime(t2, t) > 0 then
		minetest.log("action", "{ROFL} Tick took " .. os.difftime(t2, t) .. "s")
	end
	minetest.after(rofl.conf.Tick, tick)
end

minetest.after(1, tick)
