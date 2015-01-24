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

for i in ipairs(longsofas_list) do
	local longsofadesc = longsofas_list[i][1]
	local colour = longsofas_list[i][2]

	minetest.register_node("lrfurn:longsofa_right_"..colour, {
		description = longsofadesc,
		drawtype = "nodebox",
		tiles = {"lrfurn_sofa_right_top_"..colour..".png", "lrfurn_coffeetable_back.png",  "lrfurn_sofa_right_front_"..colour..".png",  "lrfurn_sofa_back_"..colour..".png",  "lrfurn_sofa_left_side_"..colour..".png",  "lrfurn_sofa_right_side_"..colour..".png"},
		paramtype = "light",
		paramtype2 = "facedir",
		stack_max = 1,
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
						--legs
						{-0.4375, -0.5, -0.4375, -0.375, -0.375, -0.375},
						{0.375, -0.5, -0.4375, 0.4375, -0.375, -0.375},

						--base/cushion
						{-0.5, -0.375, -0.5, 0.5, 0, 0.5},

						--back
						{-0.5, 0, -0.5, -0.3125, 0.5, 0.5},

						--arm
						{-0.3125, 0, -0.5, 0.5, 0.25, -0.3125},
					}
		},
		selection_box = {
			type = "fixed",
			fixed = {
						{-0.5, -0.5, -0.5, 0.5, 0.5, 2.5},
					}
		},

		on_construct = function(pos)
			local node = minetest.get_node(pos)
			local param2 = node.param2
			node.name = "lrfurn:longsofa_middle_"..colour
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			if( minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).name == "air" ) then
				minetest.set_node(pos, node)
				node.name = "lrfurn:longsofa_left_"..colour
				if param2 == 0 then
					pos.z = pos.z+1
				elseif param2 == 1 then
					pos.x = pos.x+1
				elseif param2 == 2 then
					pos.z = pos.z-1
				elseif param2 == 3 then
					pos.x = pos.x-1
				end
				if( minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).name == "air" ) then
					minetest.set_node(pos, node)
				end
			end
		end,

		on_destruct = function(pos)
			local node = minetest.get_node(pos)
			local param2 = node.param2
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			if( minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).name == "lrfurn:longsofa_middle_"..colour ) then
				if( minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).param2 == param2 ) then
					minetest.remove_node(pos)
					if param2 == 0 then
						pos.z = pos.z+1
					elseif param2 == 1 then
						pos.x = pos.x+1
					elseif param2 == 2 then
						pos.z = pos.z-1
					elseif param2 == 3 then
						pos.x = pos.x-1
					end
					if( minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).name == "lrfurn:longsofa_left_"..colour ) then
						if( minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).param2 == param2 ) then
							minetest.remove_node(pos)
						end
					end
				end
			end
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

	minetest.register_node("lrfurn:longsofa_middle_"..colour, {
		drawtype = "nodebox",
		tiles = {"lrfurn_longsofa_middle_top_"..colour..".png", "lrfurn_coffeetable_back.png",  "lrfurn_longsofa_middle_front_"..colour..".png",  "lrfurn_sofa_back_"..colour..".png",  "lrfurn_sofa_left_side_"..colour..".png",  "lrfurn_sofa_right_side_"..colour..".png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
						--legs
						{-0.4375, -0.5, -0.03125, -0.375, -0.375, 0.03125},
						{0.375, -0.5, -0.03125, 0.4375, -0.375, 0.03125},

						--base/cushion
						{-0.5, -0.375, -0.5, 0.5, 0, 0.5},

						--back
						{-0.5, 0, -0.5, -0.3125, 0.5, 0.5},
					}
		},
		selection_box = {
			type = "fixed",
			fixed = {
						{0, 0, 0, 0, 0, 0},
					}
		},
	})

	minetest.register_node("lrfurn:longsofa_left_"..colour, {
		drawtype = "nodebox",
		tiles = {"lrfurn_sofa_left_top_"..colour..".png", "lrfurn_coffeetable_back.png",  "lrfurn_sofa_left_front_"..colour..".png",  "lrfurn_sofa_back_"..colour..".png",  "lrfurn_sofa_left_side_"..colour..".png",  "lrfurn_sofa_right_side_"..colour..".png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
						--legs
						{-0.4375, -0.5, 0.375, -0.375, -0.375, 0.4375},
						{0.375, -0.5, 0.375, 0.4375, -0.375, 0.4375},

						--base/cushion
						{-0.5, -0.375, -0.5, 0.5, 0, 0.5},

						--back
						{-0.5, 0, -0.5, -0.3125, 0.5, 0.5},

						--arm
						{-0.3125, 0, 0.3125, 0.5, 0.25, 0.5},
					}
		},
		selection_box = {
			type = "fixed",
			fixed = {
						{0, 0, 0, 0, 0, 0},
					}
		},
	})

	minetest.register_alias("lrfurn:longsofa_"..colour, "lrfurn:longsofa_right_"..colour)

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
