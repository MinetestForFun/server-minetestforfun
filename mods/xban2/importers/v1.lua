
function xban.importers.v1()
	local f, e = io.open(minetest.get_worldpath().."/players.iplist")
	if not f then
		return false, "Unable to open `players.iplist': "..e
	end
	for line in f:lines() do
		local list = line:split("|")
		if #list >= 2 then
			local banned = (list[1]:sub(1, 1) == "!")
			local entry
			entry = xban.find_entry(list[1], true)
			entry.banned = banned
			for _, name in ipairs(list) do
				entry.names[name] = true
			end
			if banned then
				entry.reason = "Banned in `players.iplist'"
				entry.time = os.time()
				entry.expires = nil
				entry.source = "xban:importer_v1"
				table.insert(entry.record, {
					source = entry.source,
					reason = entry.reason,
					time = entry.time,
					expires = nil,
				})
			end
		end
	end
	f:close()
	return true
end
