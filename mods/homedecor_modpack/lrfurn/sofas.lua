

local sofa_sbox = {
	type = "fixed",
	fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 1.5}
}

local sofa_cbox = {
	type = "fixed",
	fixed = { 
		{-0.5, -0.5, -0.5, 0.5, 0, 1.5 },
		{-0.5, -0.5, 0.5, -0.4, 0.5, 1.5 }
	}
}

for i in ipairs(lrfurn.colors) do
	local colour = lrfurn.colors[i][1]
	local hue = lrfurn.colors[i][2]

	minetest.register_node("lrfurn:sofa_"..colour, {
		description = "Sofa ("..colour..")",
		drawtype = "mesh",
		mesh = "lrfurn_sofa_short.obj",
		tiles = {
			"lrfurn_bg_white.png^[colorize:"..hue.."^lrfurn_sofa_overlay.png",
			"lrfurn_sofa_bottom.png"
		},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=3},
		sounds = default.node_sound_wood_defaults(),
		selection_box = sofa_sbox,
		node_box = sofa_cbox,
		on_rotate = screwdriver.disallow,

		after_place_node = function(pos, placer, itemstack, pointed_thing)
			if minetest.is_protected(pos, placer:get_player_name()) then return true end

			local fdir = minetest.dir_to_facedir(placer:get_look_dir(), false)

			if lrfurn.check_forward(pos, fdir, false, placer) then
				minetest.set_node(pos, {name = "lrfurn:sofa_"..colour, param2 = fdir})
				itemstack:take_item()
			else
				minetest.chat_send_player(placer:get_player_name(), "No room to place the sofa!")
				minetest.set_node(pos, { name = "air" })

			end
			return itemstack
		end,
		on_rightclick = function(pos, node, clicker)
			if not clicker:is_player() then
				return
			end
			pos.y = pos.y-0.5
			clicker:setpos(pos)
		end
	})

	minetest.register_alias("lrfurn:sofa_left_"..colour, "air")
	minetest.register_alias("lrfurn:sofa_right_"..colour, "lrfurn:sofa_"..colour)

	minetest.register_craft({
		output = "lrfurn:sofa_"..colour,
		recipe = {
			{"wool:"..colour, "wool:"..colour, "", },
			{"stairs:slab_wood", "stairs:slab_wood", "", },
			{"group:stick", "group:stick", "", }
		}
	})

	minetest.register_craft({
		output = "lrfurn:sofa_"..colour,
		recipe = {
			{"wool:"..colour, "wool:"..colour, "", },
			{"moreblocks:slab_wood", "moreblocks:slab_wood", "", },
			{"group:stick", "group:stick", "", }
		}
	})

end

if minetest.setting_get("log_mods") then
	minetest.log("action", "sofas loaded")
end
