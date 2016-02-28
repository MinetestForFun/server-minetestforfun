-- Bags for Minetest

-- Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
-- License: GPLv3

local S = unified_inventory.gettext

unified_inventory.register_page("bags", {
	get_formspec = function(player)
		local player_name = player:get_player_name()
		local formspec = "background[0.06,0.99;7.92,7.52;ui_bags_main_form.png]"
		formspec = formspec.."label[0,0;"..S("Bags").."]"
		formspec = formspec.."button[0,2;2,0.5;bag1;Bag 1]" 
		formspec = formspec.."button[2,2;2,0.5;bag2;Bag 2]"
		formspec = formspec.."button[4,2;2,0.5;bag3;Bag 3]"
		formspec = formspec.."button[6,2;2,0.5;bag4;Bag 4]"
		formspec = formspec.."listcolors[#00000000;#00000000]"
		formspec = formspec.."list[detached:"..minetest.formspec_escape(player_name).."_bags;bag1;0.5,1;1,1;]"
		formspec = formspec.."list[detached:"..minetest.formspec_escape(player_name).."_bags;bag2;2.5,1;1,1;]"
		formspec = formspec.."list[detached:"..minetest.formspec_escape(player_name).."_bags;bag3;4.5,1;1,1;]"
		formspec = formspec.."list[detached:"..minetest.formspec_escape(player_name).."_bags;bag4;6.5,1;1,1;]"
		return {formspec=formspec}
	end,
})

unified_inventory.register_button("bags", {
	type = "image",
	image = "ui_bags_icon.png",
	tooltip = S("Bags"),
	hide_lite=true
})


	unified_inventory.register_page("bag1", {
		get_formspec = function(player)
			local stack = player:get_inventory():get_stack("bag1", 1)
			local image = stack:get_definition().inventory_image
			local formspec = "image[7,0;1,1;"..image.."]"
			formspec = formspec.."label[0,0;Bag 1]"
			formspec = formspec.."listcolors[#00000000;#00000000]"
			formspec = formspec.."list[current_player;bag1contents;0,1;8,3;]"
			formspec = formspec.."listring[current_name;bag1contents]"
			formspec = formspec.."listring[current_player;main]"
			local slots = stack:get_definition().groups.bagslots
			if slots == 8 then
				formspec = formspec.."background[0.06,0.99;7.92,7.52;ui_bags_sm_form.png]"
			elseif slots == 16 then
				formspec = formspec.."background[0.06,0.99;7.92,7.52;ui_bags_med_form.png]"
			elseif slots == 24 then
				formspec = formspec.."background[0.06,0.99;7.92,7.52;ui_bags_lg_form.png]"
			end
			return {formspec=formspec}
		end,
	})
	unified_inventory.register_page("bag2", {
		get_formspec = function(player)
			local stack = player:get_inventory():get_stack("bag2", 1)
			local image = stack:get_definition().inventory_image
			local formspec = "image[7,0;1,1;"..image.."]"
			formspec = formspec.."label[0,0;Bag 2]"
			formspec = formspec.."listcolors[#00000000;#00000000]"
			formspec = formspec.."list[current_player;bag2contents;0,1;8,3;]"
			formspec = formspec.."listring[current_name;bag2contents]"
			formspec = formspec.."listring[current_player;main]"
			local slots = stack:get_definition().groups.bagslots
			if slots == 8 then
				formspec = formspec.."background[0.06,0.99;7.92,7.52;ui_bags_sm_form.png]"
			elseif slots == 16 then
				formspec = formspec.."background[0.06,0.99;7.92,7.52;ui_bags_med_form.png]"
			elseif slots == 24 then
				formspec = formspec.."background[0.06,0.99;7.92,7.52;ui_bags_lg_form.png]"
			end
			return {formspec=formspec}
		end,
	})
	unified_inventory.register_page("bag3", {
		get_formspec = function(player)
			local stack = player:get_inventory():get_stack("bag3", 1)
			local image = stack:get_definition().inventory_image
			local formspec = "image[7,0;1,1;"..image.."]"
			formspec = formspec.."label[0,0;Bag 3]"
			formspec = formspec.."listcolors[#00000000;#00000000]"
			formspec = formspec.."list[current_player;bag3contents;0,1;8,3;]"
			formspec = formspec.."listring[current_name;bag3contents]"
			formspec = formspec.."listring[current_player;main]"
			local slots = stack:get_definition().groups.bagslots
			if slots == 8 then
				formspec = formspec.."background[0.06,0.99;7.92,7.52;ui_bags_sm_form.png]"
			elseif slots == 16 then
				formspec = formspec.."background[0.06,0.99;7.92,7.52;ui_bags_med_form.png]"
			elseif slots == 24 then
				formspec = formspec.."background[0.06,0.99;7.92,7.52;ui_bags_lg_form.png]"
			end
			return {formspec=formspec}
		end,
	})
	unified_inventory.register_page("bag4", {
		get_formspec = function(player)
			local stack = player:get_inventory():get_stack("bag4", 1)
			local image = stack:get_definition().inventory_image
			local formspec = "image[7,0;1,1;"..image.."]"
			formspec = formspec.."label[0,0;Bag 4]"
			formspec = formspec.."listcolors[#00000000;#00000000]"
			formspec = formspec.."list[current_player;bag4contents;0,1;8,3;]"
			formspec = formspec.."listring[current_name;bag4contents]"
			formspec = formspec.."listring[current_player;main]"
			local slots = stack:get_definition().groups.bagslots
			if slots == 8 then
				formspec = formspec.."background[0.06,0.99;7.92,7.52;ui_bags_sm_form.png]"
			elseif slots == 16 then
				formspec = formspec.."background[0.06,0.99;7.92,7.52;ui_bags_med_form.png]"
			elseif slots == 24 then
				formspec = formspec.."background[0.06,0.99;7.92,7.52;ui_bags_lg_form.png]"
			end
			return {formspec=formspec}
		end,
	})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "" then
		return
	end
	for i = 1, 4 do
		if fields["bag"..i] then
			local stack = player:get_inventory():get_stack("bag"..i, 1)
			if not stack:get_definition().groups.bagslots then
				return
			end
			unified_inventory.set_inventory_formspec(player, "bag"..i)
			return
		end
	end
end)

minetest.register_on_joinplayer(function(player)
	local player_inv = player:get_inventory()
	local bags_inv = minetest.create_detached_inventory(player:get_player_name().."_bags",{
		on_put = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, stack)
			player:get_inventory():set_size(listname.."contents",
					stack:get_definition().groups.bagslots)
		end,
		on_take = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, nil)
		end,
		allow_put = function(inv, listname, index, stack, player)
			if stack:get_definition().groups.bagslots then
				return 1
			else
				return 0
			end
		end,
		allow_take = function(inv, listname, index, stack, player)
			if player:get_inventory():is_empty(listname.."contents") then
				return stack:get_count()
			else
				return 0
			end
		end,
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return 0
		end,
	})
	for i=1,4 do
		local bag = "bag"..i
		player_inv:set_size(bag, 1)
		bags_inv:set_size(bag, 1)
		bags_inv:set_stack(bag, 1, player_inv:get_stack(bag, 1))
	end
end)

-- register bag tools
minetest.register_tool("unified_inventory:bag_small", {
	description = S("Small Bag"),
	inventory_image = "bags_small.png",
	groups = {bagslots=8},
})

minetest.register_tool("unified_inventory:bag_medium", {
	description = S("Medium Bag"),
	inventory_image = "bags_medium.png",
	groups = {bagslots=16},
})

minetest.register_tool("unified_inventory:bag_large", {
	description = S("Large Bag"),
	inventory_image = "bags_large.png",
	groups = {bagslots=24},
})

-- register bag crafts
minetest.register_craft({
	output = "unified_inventory:bag_small",
	recipe = {
		{"",           "farming:cotton", ""},
		{"group:wool", "group:wool",     "group:wool"},
		{"group:wool", "group:wool",     "group:wool"},
	},
})

minetest.register_craft({
	output = "unified_inventory:bag_medium",
	recipe = {
		{"",               "",                            ""},
		{"farming:cotton", "unified_inventory:bag_small", "farming:cotton"},
		{"farming:cotton", "unified_inventory:bag_small", "farming:cotton"},
	},
})

minetest.register_craft({
	output = "unified_inventory:bag_large",
	recipe = {
		{"",               "",                             ""},
		{"farming:cotton", "unified_inventory:bag_medium", "farming:cotton"},
		{"farming:cotton", "unified_inventory:bag_medium", "farming:cotton"},
    },
})

