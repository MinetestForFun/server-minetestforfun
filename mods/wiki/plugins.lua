
--[[
plugindef = {
	regex = "^/foo/bar/.*",
	description = "My Awesome Plugin",
	load_page = func(entry, player),
	^ Must return text, allow_save
	save_page = func(entry, player),
	^ Must return bool
}
]]

local plugin_defs = { }

function wikilib.register_plugin(def)
	plugin_defs[#plugin_defs + 1] = def
end

local function do_handle(what, entry, player, text)
	for _,pi in ipairs(plugin_defs) do
		if entry:match(pi.regex) then
			return pi[what](entry, player, text)
		end
	end
end

function wikilib.plugin_handle_load(entry, player)
	return do_handle("load_page", entry, player)
end

function wikilib.plugin_handle_save(entry, player, text)
	return do_handle("save_page", entry, player, text)
end
