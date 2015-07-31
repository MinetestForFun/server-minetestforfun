function pclasses.register_class_switch_orb(cname, color)
	color = color or { r = 255, g = 255, b = 255 }
	local txtcolor = string.format("#%02x%02x%02x", color.r, color.g, color.b)
	local overlay = "pclasses_class_switch_orb_overlay.png"
	minetest.register_node(":pclasses:class_switch_orb_" .. cname, {
		description = "Class switch orb (" .. cname .. ")",
		tiles = {overlay .. "^[colorize:" .. txtcolor .. "^" .. overlay},
		drop = "",
		can_dig = function() return false end,
		diggable = false,
		sunlight_propagates = true,
		light_source = 10,
		sounds = default.node_sound_glass_defaults(),
		groups = {not_in_creative_inventory=1},
		on_rightclick = function(pos, node, player, itemstack, pointed_thing)
			-- TODO implement timeout logic
			pclasses.api.set_player_class(player:get_player_name(), cname)
		end
	})
end
