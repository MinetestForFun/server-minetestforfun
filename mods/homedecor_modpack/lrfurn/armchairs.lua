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

local armchair_cbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, 0, 0.5 },
		{-0.5, -0.5, 0.4, 0.5, 0.5, 0.5 }
	}
}

for i in ipairs(armchairs_list) do
	local armchairdesc = armchairs_list[i][1]
	local colour = armchairs_list[i][2]

	minetest.register_node("lrfurn:armchair_"..colour, {
		description = armchairdesc,
		drawtype = "mesh",
		mesh = "lrfurn_armchair.obj",
		tiles = {
			"lrfurn_sofa_"..colour..".png",
			"lrfurn_sofa_bottom.png"
		},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=3},
		sounds = default.node_sound_wood_defaults(),
		node_box = armchair_cbox,
		on_rightclick = function(pos, node, clicker)
			if not clicker:is_player() then
				return
			end
			pos.y = pos.y-0.5
			clicker:setpos(pos)
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

end

if minetest.setting_get("log_mods") then
	minetest.log("action", "armchairs loaded")
end
