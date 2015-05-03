local longsofas_list = {
	{ "Red Long Sofa", "red"},
	{ "Orange Long Sofa", "orange"},
	{ "Yellow Long Sofa", "yellow"},
	{ "Green Long Sofa", "green"},
	{ "Blue Long Sofa", "blue"},
	{ "Violet Long Sofa", "violet"},
	{ "Black Long Sofa", "black"},
	{ "Grey Long Sofa", "grey"},
	{ "White Long Sofa", "white"},
}

local longsofa_sbox = {
	type = "fixed",
	fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 2.5}
}

local longsofa_cbox = {
	type = "fixed",
	fixed = { 
		{-0.5, -0.5, -0.5, 0.5, 0, 2.5 },
		{-0.5, -0.5, 0.5, -0.4, 0.5, 2.5 }
	}
}

for i in ipairs(longsofas_list) do
	local longsofadesc = longsofas_list[i][1]
	local colour = longsofas_list[i][2]

	minetest.register_node("lrfurn:longsofa_"..colour, {
		description = longsofadesc,
		drawtype = "mesh",
		mesh = "lrfurn_sofa_long.obj",
		tiles = {
			"lrfurn_sofa_"..colour..".png",
			"lrfurn_sofa_bottom.png"
		},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=3},
		sounds = default.node_sound_wood_defaults(),
		selection_box = longsofa_sbox,
		node_box = longsofa_cbox,
        on_place = function(itemstack, placer, pointed_thing)
			local pos = pointed_thing.above
			local fdir = minetest.dir_to_facedir(placer:get_look_dir(), false)

			if lrfurn.check_forward(pos, fdir, true) then
				minetest.set_node(pos, {name = "lrfurn:longsofa_"..colour, param2 = fdir})
				itemstack:take_item()
			else
				minetest.chat_send_player(placer:get_player_name(), "No room to place the sofa!")
			end
			return itemstack
		end,
		on_rightclick = function(pos, node, clicker)
			if not clicker:is_player() then
				return
			end
			pos.y = pos.y-0.5
			clicker:setpos(pos)
			clicker:set_hp(20)
		end
	})

	minetest.register_alias("lrfurn:longsofa_left_"..colour, "air")
	minetest.register_alias("lrfurn:longsofa_middle_"..colour, "air")
	minetest.register_alias("lrfurn:longsofa_right_"..colour, "lrfurn:longsofa_"..colour)

	minetest.register_craft({
		output = "lrfurn:longsofa_"..colour,
		recipe = {
			{"wool:"..colour, "wool:"..colour, "wool:"..colour, },
			{"stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood", },
			{"group:stick", "group:stick", "group:stick", }
		}
	})

	minetest.register_craft({
		output = "lrfurn:longsofa_"..colour,
		recipe = {
			{"wool:"..colour, "wool:"..colour, "wool:"..colour, },
			{"moreblocks:slab_wood", "moreblocks:slab_wood", "moreblocks:slab_wood", },
			{"group:stick", "group:stick", "group:stick", }
		}
	})

	minetest.register_craft({
		output = "lrfurn:longsofa_"..colour,
		recipe = {
			{"wool:"..colour, "wool:"..colour, "wool:"..colour, },
			{"group:wood_slab", "group:wood_slab", "group:wood_slab", },
			{"group:stick", "group:stick", "group:stick", }
		}
	})

end

if minetest.setting_get("log_mods") then
	minetest.log("action", "long sofas loaded")
end
