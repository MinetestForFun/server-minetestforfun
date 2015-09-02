-- Miscellaneous legacies from our old mod, HUD by BlockMen
--

minetest.register_on_joinplayer(function(player)
    --player:hud_set_flags({crosshair = true, hotbar = true, healthbar = false, wielditem = true, breathbar = false})

    player:hud_set_hotbar_image("hudbars_hotbar.png")
    player:hud_set_hotbar_selected_image("hudbars_hotbar_selected.png")
end)
