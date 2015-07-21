minetest.register_on_joinplayer(function(player) 
	inventory_plus.register_button(player, "quests")
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if (fields.quests) then
		quests.show_formspec(player:get_player_name())
	end
end)
