
local FORMNAME = "xban2:main"

local states = { }

local table_insert, table_concat =
      table.insert, table.concat

local ESC = minetest.formspec_escape

local function make_fs(name)
	local state = states[name]
	if not state then return end
	local list, index, filter = state.list, state.index, state.filter
	if index > #list then
		index = #list
	end
	local fs = {
		"size[10,8]",
		"label[0.5,0.6;Filter]",
		"field[1.5,0.5;6,2;filter;;"..ESC(filter).."]",
		"button[7.5,0.5;2,1;search;Search]",
	}
	table_insert(fs,
			("textlist[0.5,2;3,5.5;player;%s;%d;0]"):
			format(table_concat(list, ","), index))
	local record_name = list[index]
	if record_name then
		local record, err = xban.get_record(record_name)
		if record then
			local reclist = { }
			for _, r in ipairs(record) do
				table_insert(reclist, ESC(r))
			end
			table_insert(fs,
					("textlist[4,2;5,5.5;entry;%s;0;0]"):
					format(table_concat(reclist, ",")))
		else
			table_insert(fs,
					"textlist[4,2;5,5.5;entry;"..ESC(err)..";0]")
		end
	end
	return table_concat(fs)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= FORMNAME then return end
	local name = player:get_player_name()
	local state = states[name]
	if fields.player then
		local t = minetest.explode_textlist_event(fields.player)
		if (t.type == "CHG") or (t.type == "DCL") then
			state.index = t.index
			minetest.show_formspec(name, FORMNAME, make_fs(name))
		end
		return
	end
	if fields.search then
		local filter = fields.filter or ""
		state.filter = filter
		local list = { }
		state.list = list
		for k in pairs(minetest.auth_table) do
			if k:find(filter, 1, true) then
				table_insert(list, k)
			end
		end
		table.sort(list)
		minetest.show_formspec(name, FORMNAME, make_fs(name))
	end
end)

minetest.register_chatcommand("xban_gui", {
	description = "Show XBan GUI",
	params = "",
	func = function(name, params)
		local state = states[name]
		if not state then
			state = { index=1, filter="" }
			states[name] = state
			local list = { }
			state.list = list
			for k in pairs(minetest.auth_table) do
				table_insert(list, k)
			end
			table.sort(list)
		end
		minetest.show_formspec(name, FORMNAME, make_fs(name))
	end,
})
