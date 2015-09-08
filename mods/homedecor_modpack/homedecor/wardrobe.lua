local S = homedecor.gettext

local wd_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 }
}

homedecor.register("wardrobe", {
	mesh = "homedecor_bedroom_wardrobe.obj",
	tiles = {
		homedecor.plain_wood,
		"homedecor_wardrobe_drawers.png",
		"homedecor_wardrobe_doors.png"
	},
	inventory_image = "homedecor_wardrobe_inv.png",
	description = "Wardrobe",
	groups = {snappy=3},
	selection_box = wd_cbox,
	collision_box = wd_cbox,
	sounds = default.node_sound_wood_defaults(),
	expand = { top="placeholder" },
	on_rotate = screwdriver.rotate_simple,
	infotext = "Wardrobe",
	inventory = {
		size = 10
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local skins = {"male1", "male2", "male3", "male4", "male5"}
		-- textures made by the Minetest community (mostly Calinou and Jordach)
		local clothes_strings = ""
		for i = 1,5 do
			clothes_strings = clothes_strings..
			  "image_button_exit["..(i-1)..".5,0;1.1,2;homedecor_clothes_"..skins[i].."_preview.png;"..skins[i]..";]"..
			  "image_button_exit["..(i-1)..".5,2;1.1,2;homedecor_clothes_fe"..skins[i].."_preview.png;fe"..skins[i]..";]"
		end
		meta:set_string("formspec", "size[5.5,8.5]"..default.gui_bg..default.gui_bg_img..default.gui_slots..
			"vertlabel[0,0.5;CLOTHES]"..
			clothes_strings..
			"vertlabel[0,5.2;STORAGE]"..
			"list[current_name;main;0.5,4.5;5,2;]"..
			"list[current_player;main;0.5,6.8;5,2;]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		local skins = {"male1", "male2", "male3", "male4", "male5"}
		local playerName = sender:get_player_name()
		local armor_mod = minetest.get_modpath("3d_armor")

		for i = 1,5 do
			if fields[skins[i]] then
				if armor_mod then -- if 3D_armor's installed, let it set the skin
					armor.textures[playerName].skin = "homedecor_clothes_"..skins[i]..".png"
					armor:update_player_visuals(sender)
					break
				end
				default.player_set_textures(sender, { "homedecor_clothes_"..skins[i]..".png" })
				break
			elseif fields["fe"..skins[i]] then
				if armor_mod then
					armor.textures[playerName].skin = "homedecor_clothes_fe"..skins[i]..".png"
					armor:update_player_visuals(sender)
					break
				end
				default.player_set_textures(sender, { skin = "homedecor_clothes_fe"..skins[i]..".png" })
				break
			end
		end
	end
})

minetest.register_alias("homedecor:wardrobe_bottom", "homedecor:wardrobe")
minetest.register_alias("homedecor:wardrobe_top", "air")
