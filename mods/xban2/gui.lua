
local FORMNAME = "xban2:main"
local MAXLISTSIZE = 100

local strfind, format = string.find, string.format

local ESC = minetest.formspec_escape

local function make_list(filter)
	filter = filter or ""
	local list, n, dropped = { }, 0, false
	for k in pairs(minetest.auth_table) do
		if strfind(k, filter, 1, true) then
			if n >= MAXLISTSIZE then
				dropped = true
				break
			end
			n=n+1 list[n] = k
		end
	end
	table.sort(list)
	return list, dropped
end

local states = { }

local function get_state(name)
	local state = states[name]
	if not state then
		state = { index=1, filter="" }
		states[name] = state
		state.list, state.dropped = make_list()
	end
	return state
end

local function get_record_simple(name)
	local e = xban.find_entry(name)
	if not e then
		return nil, ("No entry for `%s'"):format(name)
	elseif (not e.record) or (#e.record == 0) then
		return nil, ("`%s' has no ban records"):format(name)
	end
	local record = { }
	for _, rec in ipairs(e.record) do
		local msg = (os.date("%Y-%m-%d %H:%M:%S", rec.time).." | "
				..(rec.reason or "No reason given."))
		table.insert(record, msg)
	end
	return record, e.record
end

local function make_fs(name)
	local state = get_state(name)
	local list, filter = state.list, state.filter
	local pli, ei = state.player_index or 1, state.entry_index or 0
	if pli > #list then
		pli = #list
	end
	local fs = {
		"size[16,12]",
		"label[0,-.1;Filter]",
		"field[1.5,0;12.8,1;filter;;"..ESC(filter).."]",
		"button[14,-.3;2,1;search;Search]",
	}
	local fsn = #fs
	fsn=fsn+1 fs[fsn] = format("textlist[0,.8;4,9.3;player;%s;%d;0]",
			table.concat(list, ","), pli)
	local record_name = list[pli]
	if record_name then
		local record, e = get_record_simple(record_name)
		if record then
			for i, r in ipairs(record) do
				record[i] = ESC(r)
			end
			fsn=fsn+1 fs[fsn] = format(
					"textlist[4.2,.8;11.7,9.3;entry;%s;%d;0]",
					table.concat(record, ","), ei)
			local rec = e[ei]
			if rec then
				fsn=fsn+1 fs[fsn] = format("label[0,10.3;%s]",
						ESC("Source: "..(rec.source or "<none>")
							.."\nTime: "..os.date("%c", rec.time)
							.."\n"..(rec.expires and
								os.date("%c", rec.expires) or "")),
						pli)
			end
		else
			fsn=fsn+1 fs[fsn] = "textlist[4.2,.8;11.7,9.3;err;"..ESC(e)..";0]"
			fsn=fsn+1 fs[fsn] = "label[0,10.3;"..ESC(e).."]"
		end
	else
		local e = "No entry matches the query."
		fsn=fsn+1 fs[fsn] = "textlist[4.2,.8;11.7,9.3;err;"..ESC(e)..";0]"
		fsn=fsn+1 fs[fsn] = "label[0,10.3;"..ESC(e).."]"
	end
	return table.concat(fs)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= FORMNAME then return end
	local name = player:get_player_name()
	local state = get_state(name)
	if fields.player then
		local t = minetest.explode_textlist_event(fields.player)
		if (t.type == "CHG") or (t.type == "DCL") then
			state.player_index = t.index
			minetest.show_formspec(name, FORMNAME, make_fs(name))
		end
		return
	end
	if fields.entry then
		local t = minetest.explode_textlist_event(fields.entry)
		if (t.type == "CHG") or (t.type == "DCL") then
			state.entry_index = t.index
			minetest.show_formspec(name, FORMNAME, make_fs(name))
		end
		return
	end
	if fields.search then
		local filter = fields.filter or ""
		state.filter = filter
		state.list = make_list(filter)
		minetest.show_formspec(name, FORMNAME, make_fs(name))
	end
end)

minetest.register_chatcommand("xban_gui", {
	description = "Show XBan GUI",
	params = "",
	func = function(name, params)
		minetest.show_formspec(name, FORMNAME, make_fs(name))
	end,
})
