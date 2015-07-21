unified_inventory.register_button("quests", {
	type = "image",
	image = "inventory_plus_quests.png",
	tooltip = "Show the questlog",
--	action = function(player)
--		quests.show_formspec(player:get_player_name())
--	end
})

unified_inventory.register_page("quests", {
	get_formspec = function(player) 
		local playername = player:get_player_name()
		local formspec = quests.create_formspec(playername, "1", true)
		return {formspec = formspec, draw_inventory=false}
	end
})

unified_inventory.register_page("quests_successfull", {
	get_formspec = function(player) 
		local playername = player:get_player_name()
		local formspec = quests.create_formspec(playername, "2", true)
		return {formspec = formspec, draw_inventory=false}
	end
})

unified_inventory.register_page("quests_failed", {
	get_formspec = function(player) 
		local playername = player:get_player_name()
		local formspec = quests.create_formspec(playername, "3", true)
		return {formspec = formspec, draw_inventory=false}
	end
})

unified_inventory.register_page("quests_config", {
	get_formspec = function(player)
		local playername = player:get_player_name()
		local formspec = quests.create_config(playername, true)
		return {formspec = formspec, draw_inventory = false }
	end
})
unified_inventory.register_page("quests_info", {
	get_formspec = function(player)
		local playername = player:get_player_name()
		local formspec = quests.create_info(playername, quests.formspec_lists[playername].list[quests.formspec_lists[playername].id], true)
		return {formspec = formspec, draw_inventory = false }
	end
})
