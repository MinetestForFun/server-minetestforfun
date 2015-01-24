local armchairs_list = {
	{ "Red Armchair", "red"},
	{ "Orange Armchair", "orange"},
	{ "Yellow Armchair", "yellow"},
	{ "Green Armchair", "green"},
	{ "Blue Armchair", "blue"},
	{ "Violet Armchair", "violet"},
	{ "Black Armchair", "black"},
	{ "Grey Armchair", "grey"},
	{ "White Armchair", "white"},
}

for i in ipairs(armchairs_list) do
	local armchairdesc = armchairs_list[i][1]
	local colour = armchairs_list[i][2]

	minetest.register_node("lrfurn:armchair_"..colour, {
		description = armchairdesc,
		drawtype = "nodebox",
		tiles = {"lrfurn_armchair_top_"..colour..".png", "lrfurn_coffeetable_back.png",  "lrfurn_sofa_left_side_"..colour..".png",  "lrfurn_sofa_right_side_"..colour..".png",  "lrfurn_sofa_back_"..colour..".png",  "lrfurn_armchair_front_"..colour..".png"},
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
						{-0.4375, -0.5, 0.375, -0.375, -0.375, 0.4375},
						{0.375, -0.5, 0.375, 0.4375, -0.375, 0.4375},

						--base/cushion
						{-0.5, -0.375, -0.5, 0.5, 0, 0.5},

						--back
						{-0.5, 0, 0.3125, 0.5, 0.5, 0.5},

						--arms
						{-0.5, 0, -0.5, -0.3125, 0.25, 0.3125},
						{0.3125, 0, -0.5, 0.5, 0.25, 0.3125},
					}
		},
		selection_box = { type = "regular" },

		on_rightclick = function(pos, node, clicker)
			if not clicker:is_player() then
				return
			end
			pos.y = pos.y-0.5
			clicker:setpos(pos)
			clicker:set_hp(20)
		end
	})

	minetest.register_craft({
		output = "lrfurn:armchair_"..colour,
		recipe = {
			{"wool:"..colour, "", "", },
			{"stairs:slab_wood", "", "", },
			{"group:stick", "", "", }
		}
	})

	minetest.register_craft({
		output = "lrfurn:armchair_"..colour,
		recipe = {
			{"wool:"..colour, "", "", },
			{"moreblocks:slab_wood", "", "", },
			{"group:stick", "", "", }
		}
	})

	minetest.register_craft({
		output = "lrfurn:armchair_"..colour,
		recipe = {
			{"wool:"..colour, "", "", },
			{"group:wood_slab", "", "", },
			{"group:stick", "", "", }
		}
	})

end

if minetest.setting_get("log_mods") then
	minetest.log("action", "armchairs loaded")
end
