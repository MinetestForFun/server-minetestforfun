

-- useless or useful ??? No activated
minetest.register_node("fishing:material_info", {
	description = fishing_setting.func.S("Show information about hunger fish"),
	name   = "Fishing Info Center",
	tiles  = {"default_wood.png", "default_wood.png", "default_wood.png",
				"default_wood.png", "default_wood.png", "default_wood.png"},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),

	
	on_rightclick = function(pos, _, clicker)
		local formspec = "size[6,8]label[1.7,0;Fishing Info Center]"
		local y = 1
		for i, a in pairs(fishing_setting.baits) do
		formspec = formspec .."item_image_button[1,"..tostring(y)..";1,1;"..tostring(i)..";"..tostring(i)..";]"..
			--formspec = formspec .."image[1,"..tostring(y)..";1,1;"..tostring(a["texture"]).."]"..
			"label[2.2,"..tostring(y+0.2)..";Chance to fish :"..tostring(a["hungry"]).."%]"
			y = y+1
		end
		minetest.show_formspec(clicker:get_player_name(),"fishing:material_info", formspec)
	end

})


minetest.register_craft({
	output = 'fishing:material_info',
	type   = 'shapeless',
	recipe = { 'default:steel_ingot', 'default:steel_ingot' },
})
