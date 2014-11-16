
minetest.register_privilege("notice", "Able to show notices to players.")

minetest.register_chatcommand("notice", {
	params = "<player> <text>",
	privs = { notice=true, },
	description = "Show a notice to a player.",
	func = function(name, params)
		local target, text = params:match("(%S+)%s+(.+)")
		if not (target and text) then
			minetest.chat_send_player(name, "Usage: /notice <player> <text>")
			return
		end
		local player = minetest.get_player_by_name(target)
		if not player then
			minetest.chat_send_player(name, ("There's no player named '%s'."):format(target))
			return
		end
		local fs = { }
		local y = 0
		for _, line in ipairs(text:split("|")) do
			table.insert(fs, ("label[1,%f;%s]"):format(y+1, minetest.formspec_escape(line)))
			y = y + 0.5
		end
		table.insert(fs, 1, ("size[8,%d]"):format(y+3))
		table.insert(fs, ("button_exit[3,%f;2,0.5;ok;OK]"):format(y+2))
		fs = table.concat(fs)
		minetest.chat_send_player(name, "Notice sent.")
		minetest.after(0.5, function()
			minetest.show_formspec(target, "notice:notice", fs)
		end)
	end,
})
