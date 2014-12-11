minetest.register_on_newplayer(function(player)
	print("Un nouveau joueur vient de nous rejoindre !")
	if minetest.setting_getbool("give_initial_stuff") then
		print("Equipement de depart transmis")
		player:get_inventory():add_item("main", "default:axe_wood")
		player:get_inventory():add_item("main", "default:torch 10")
		player:get_inventory():add_item("main", "default:sapling 2")
		player:get_inventory():add_item("main", "default:apple 5")
	end
end)
