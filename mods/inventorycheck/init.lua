-- Check Inventory

minetest.register_privilege("inv", "Can use /inv")

minetest.register_chatcommand("inv", {
	params = "<name>",
	description = "Shows inventory of <name>",
	func = function(name, param)
		if not minetest.check_player_privs(name, {inv=true}) then
			return false, "You don't have permission to check inventories"
		end
		local player = minetest.get_player_by_name(param)
		if player == nil then
			minetest.chat_send_player(name, param.." is not online right now")
			return false
		end
		local player_inv = player:get_inventory()
		local invlist = param.."'s inventory: "
		for i=1,player_inv:get_size("main") do
			local items = player_inv:get_stack("main", i)
			items = items:to_string()
			if items ~= "" then
				invlist = invlist..items.." | "
			end
		end
		for i=1,player_inv:get_size("craft") do
			local items = player_inv:get_stack("craft", i)
			items = items:to_string()
			if items ~= "" then
				invlist = invlist..items.." | "
			end
		end
		minetest.chat_send_player(name, invlist)
	end,
})
