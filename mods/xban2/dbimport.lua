
xban.importers = { }

dofile(xban.MP.."/importers/minetest.lua")
dofile(xban.MP.."/importers/v1.lua")
dofile(xban.MP.."/importers/v2.lua")

minetest.register_chatcommand("xban_dbi", {
	description = "Import old databases",
	params = "<importer>",
	privs = { server=true },
	func = function(name, params)
		if params == "--list" then
			local names = { }
			for name in pairs(xban.importers) do
				table.insert(names, name)
			end
			minetest.chat_send_player(name,
			  ("[xban] Known importers: %s"):format(
			  table.concat(names, ", ")))
			return
		elseif not xban.importers[params] then
			minetest.chat_send_player(name,
			  ("[xban] Unknown importer `%s'"):format(params))
			minetest.chat_send_player(name, "[xban] Try `--list'")
			return
		end
		local f = xban.importers[params]
		local ok, err = f()
		if ok then
			minetest.chat_send_player(name,
			  "[xban] Import successfull")
		else
			minetest.chat_send_player(name,
			  ("[xban] Import failed: %s"):format(err))
		end
	end,
})
