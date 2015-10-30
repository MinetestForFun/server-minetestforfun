-- Automappercolors by gravgun
-- WTFPL

function amc_dumpnodes()
	local fd, err = io.open(minetest.get_worldpath()..'/amc_nodes.txt', 'wb')
	if not fd then
		return 0, err
	end
	local n = 0
	for name, def in pairs(minetest.registered_nodes) do
		if def.drawtype ~= 'airlike' then
			local tile = def.tiles
			if type(tile) == 'table' then
				tile = tile[1]
				if type(tile) == 'table' then
					tile = tile.name
				end
			end
			if tile ~= nil then
				tile = (tile .. '^'):match('([a-zA-Z0-9\\._-]-)^')
				fd:write(name .. ' ' .. tile .. '\n')
				n = n + 1
			end
		end
	end
	fd:close()
	return n, "done"
end

minetest.register_chatcommand("amcdumpnodes", {
	params = "",
	description = "",
	func = function(plname, param)
		local n, msg = amc_dumpnodes()
		if n == 0 then
			minetest.chat_send_player(plname, 'io.open: ' .. msg)
		else
			minetest.chat_send_player(plname, n .. " nodes dumped.")
		end
	end,
})

minetest.after(1, function(args)
	amc_dumpnodes()
	if minetest.setting_getbool("log_mods") then
		minetest.log("action", "[automappercolors] nodes dumped")
	end
end)


