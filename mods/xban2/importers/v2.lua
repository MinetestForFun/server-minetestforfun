
function xban.importers.v2()
	return pcall(function()
		local f, e = io.open(minetest.get_worldpath().."/players.iplist.v2")
		if not f then
			error("Unable to open `players.iplist.v2': "..e)
		end
		local text = f:read("*a")
		f:close()
		local db = minetest.deserialize(text)
		for _, e in ipairs(db) do
			for name in pairs(e.names) do
				local entry = xban.find_entry(name, true)
				if entry.source ~= "xban:importer_v2" then
					for nm in pairs(e.names) do
						entry.names[nm] = true
					end
					if e.banned then
						entry.banned = true
						entry.reason = e.banned
						entry.source = "xban:importer_v2"
						entry.time = e.time
						entry.expires = e.expires
						table.insert(entry.record, {
							source = entry.source,
							reason = entry.reason,
							time = entry.time,
							expires = entry.expires,
						})
					end
				end
			end
		end
	end)
end
