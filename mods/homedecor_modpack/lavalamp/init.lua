local lavalamps_list = {
	{ "Red Lava Lamp", "red"},
	{ "Orange Lava Lamp", "orange"},	
	{ "Yellow Lava Lamp", "yellow"},
	{ "Green Lava Lamp", "green"},
	{ "Blue Lava Lamp", "blue"},
	{ "Violet Lava Lamp", "violet"},
}

for i in ipairs(lavalamps_list) do
	local lavalampdesc = lavalamps_list[i][1]
	local colour = lavalamps_list[i][2]

	minetest.register_node("lavalamp:"..colour, {
	    description = lavalampdesc,
		drawtype = "mesh",
		mesh = "lavalamp.obj",
	    tiles = {
	        "lavalamp_metal.png",
	        {
	            name="lavalamp_lamp_anim_"..colour..".png",
	            animation={
	                type="vertical_frames",
	                aspect_w=40,
	                aspect_h=40,
	                length=6.0,
	            },
	        },
	    },
		inventory_image = "lavalamp_lamp_"..colour.."_inv.png",
	    paramtype = "light",
	    paramtype2 = "facedir",
	    sunlight_propagates = true,
	    walkable = false,
	    light_source = 14,
	    selection_box = {
	        type = "fixed",
	        fixed = { -0.25, -0.5, -0.25, 0.25,0.5, 0.25 },
	    },
		groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
		sounds = default.node_sound_glass_defaults(),
		on_rightclick = function(pos, node, clicker)
	        node.name = "lavalamp:"..colour.."_off"
	        minetest.set_node(pos, node)
	    end,
	})

	minetest.register_node("lavalamp:"..colour.."_off", {
	    description = lavalampdesc.." off",
	    drawtype = "mesh",
		mesh = "lavalamp.obj",
	    tiles = {
	        "lavalamp_metal.png",
	        "lavalamp_lamp_off.png",
	    },	    
	    paramtype = "light",
	    paramtype2 = "facedir",
	    sunlight_propagates = true,
	    walkable = false,
	    selection_box = {
	        type = "fixed",
	        fixed = { -0.25, -0.5, -0.25, 0.25,0.5, 0.25 },
	    },
		groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, not_in_creative_inventory=1},
		sounds = default.node_sound_glass_defaults(),
		drop = "lavalamp:"..colour,
		on_rightclick = function(pos, node, clicker)
	        node.name = "lavalamp:"..colour
	        minetest.set_node(pos, node)
	    end,
	})

	minetest.register_craft({
		output = "lavalamp:"..colour,
		recipe = {
			{"", "wool:"..colour, "", },
			{"", "bucket:bucket_water", "", },
			{"", "wool:black", "", }
		}
	})
	
end
