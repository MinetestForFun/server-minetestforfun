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
rofl.conf.Rpertick = 20000 -- Max reading operations per tick
rofl.conf.Wpertick = 50000 -- Max writing operations per tick
rofl.conf.Apertick = 10000 -- Max application operations per tick
rofl.conf.Lpertick = 75000 -- Max loading operations per tick

rofl.buffers = {}
rofl.buffers.RCache = {} -- Reading
rofl.buffers.WCache = {} -- Writing
rofl.buffers.LCache = {} -- Loading -- not in use
rofl.buffers.ACache = {} -- Application


-------------------------------------------------
-- ROFL Capture (not copter)
-- Queue nodes to be written in a buffer file
-------------------------------------------------
function rofl.capture(f, pos1, pos2)
	local posU = {x = math.max(pos1.x, pos2.x), y = math.max(pos1.y, pos2.y), z = math.max(pos1.z, pos2.z)}
	local posD = {x = math.min(pos1.x, pos2.x), y = math.min(pos1.y, pos2.y), z = math.min(pos1.z, pos2.z)}

	local n = 0
	for x = posD.x, posU.x do
		for y = posD.y, posU.y do
			for z = posD.z, posU.z do
				local node = minetest.get_node({x = x, y = y, z = z})
				if node.name == "ignore" then
				--	return false, "Area unloaded : ~" .. minetest.pos_to_string({x = x, y = y, z = z})
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
	params = "<name> <pos1> <pos2>",
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

		local k, u  = rofl.capture(f, p1, p2)
		if k then
			io.close(io.open(bufferfiles .. f .. ".buf", "w")) -- Remove any previous file that would have the same name
			return true, "Successfully captured area from " ..
				core.pos_to_string(p1, 1) .. " to " .. core.pos_to_string(p2, 1) ..
				" in file " .. f .. " : " .. k .. " nodes"
		else
			return false, "Failed to capture the area : " .. u
		end
	end,
})

----------------------
-- Node application
----------------------

function rofl.apply(pos, buf)
	local f = io.open(bufferfiles .. buf .. ".buf")
	if not f then
		return false, "No such buffer : " .. buf
	end

	local l = 0
	for line in f:lines() do
		local t, node = unpack(line:split("|"))
		t = t:split(";")

		if table.getn(t) == 3 then
			local pos2 = {x = t[1] + math.floor(pos.x), y = t[2] + math.floor(pos.y), z = t[3] + math.floor(pos.z)}
			node = minetest.deserialize(node)

			table.insert(rofl.buffers.ACache, {pos2, node})
			l = l + 1
		end
	end
	f:close()
	return l
end

minetest.register_chatcommand("roflPaste", {
	params = "<name> [<pos>]",
	description = "Apply nodes present in buffer",
	privs = {server=true},
	func = function(name, param)
		local bufname, pos = unpack(param:split(" "))

		if not bufname or bufname == "" then
			return false, "Invalid buffer name"
		elseif not pos or pos == "" then
			local p = minetest.get_player_by_name(name)
			if not p then
				return false, "Unable to get your position"
			else
				pos = minetest.pos_to_string(p:getpos())
			end
		end
		if not minetest.string_to_pos(pos) then
			return false, "Invalid pos"
		end

		local k, u = rofl.apply(minetest.string_to_pos(pos), bufname)
		if not k then
			return false, "Unable to apply nodes : " .. u
		else
			minetest.log("action", "{ROFL} " .. k .. " nodes queued")
			return true, k .. " nodes are queued"
		end
	end
})

-----------------
-- Empty Caches
-----------------
minetest.register_chatcommand("roflFlush", {
	params = "<W|A>",
	description = "Empty Writing or Application buffers",
	privs = {server=true},
	func = function(name, param)
		if param == "" then
			return false, "Enter a letter, either W(riting) or A(pplication)"
		elseif param == "W" then
			rofl.buffers.WCache = {}
			return true, "WCache flushed"
		elseif param == "A" then
			rofl.buffers.ACache = {}
			return true, "ACache flushed"
		else
			return false, "Unknown cache name : " .. param
		end
	end
})

-------------------------
-- Delete buffer files
-------------------------
minetest.register_chatcommand("roflReset", {
	params = "<name>",
	description = "Empty a buffer file (or create the file if it doesn't exist)",
	privs = {server=true},
	func = function(name, param)
		param = param:split(" ")[1]
		if param == "" then
			return false, "Enter a buffer name please"
		else
			io.close(io.open(bufferfiles .. param .. ".buf", "w"))
			return true, "Done"
		end
	end
})

-------------------------------
-- Regularly work on queues
-------------------------------
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

	--[[if table.getn(rofl.buffers.LCache) > 0 then
		minetest.log("action", "{ROFL} LCache has " .. table.getn(rofl.buffers.LCache) .. " elements")
		minetest.log("action", "{ROFL} Doing up to " .. rofl.conf.Lpertick .. " loading operations")

		for x = 1, rofl.conf.Lpertick do
			if not rofl.buffers.LCache[1] then break end
			table.remove(rofl.buffers.LCache, 1)
		end

		if table.getn(rofl.buffers.LCache) == 0 then
			minetest.log("action", "{ROFL} Loading operations finished")
		end
	end]]

	-- Applying
	if table.getn(rofl.buffers.ACache) > 0 then
		minetest.log("action", "{ROFL} ACache has " .. table.getn(rofl.buffers.ACache) .. " elements")
		minetest.log("action", "{ROFL} Doing up to " .. rofl.conf.Apertick .. " application operations")

		for x = 1, rofl.conf.Apertick do
			if not rofl.buffers.ACache[1] then break end

			minetest.set_node(rofl.buffers.ACache[1][1], rofl.buffers.ACache[1][2])
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

--------------------------------
-- Clean our mess on shutdown
--------------------------------
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
