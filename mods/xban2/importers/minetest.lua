
function xban.importers.minetest()
	local f, e = io.open(minetest.get_worldpath().."/ipban.txt")
	if not f then
		return false, "Unable to open `ipban.txt': "..e
	end
	for line in f:lines() do
		local ip, name = line:match("([^|]+)%|(.+)")
		if ip and name then
			local entry
			entry = xban.find_entry(ip, true)
			entry.banned = true
			entry.reason = "Banned in `ipban.txt'"
			entry.names[name] = true
			entry.names[ip] = true
			entry.time = os.time()
			entry.expires = nil
			entry.source = "xban:importer_minetest"
			table.insert(entry.record, {
				source = entry.source,
				reason = entry.reason,
				time = entry.time,
				expires = nil,
			})
		end
	end
	f:close()
	return true
end
