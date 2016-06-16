-- Bags for Minetest

-- Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
-- License: GPLv3

local S = unified_inventory.gettext

unified_inventory.register_page("bags", {
	get_formspec = function(player)
		local player_name = player:get_player_name()
		local formspec = "background[0.06,0.99;7.92,7.52;ui_bags_main_form.png]"
		formspec = formspec.."label[0,0;"..S("Bags").."]"
		formspec = formspec.."button[0,2;2,0.5;bag1;Bag 1]" .. "button[0,3;2,0.5;unequip_bag1;Unequip]"
		formspec = formspec.."button[2,2;2,0.5;bag2;Bag 2]" .. "button[2,3;2,0.5;unequip_bag2;Unequip]"
		formspec = formspec.."button[4,2;2,0.5;bag3;Bag 3]" .. "button[4,3;2,0.5;unequip_bag3;Unequip]"
		formspec = formspec.."button[6,2;2,0.5;bag4;Bag 4]" .. "button[6,3;2,0.5;unequip_bag4;Unequip]"
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
	hide_lite=true,
	show_with = false, --Modif MFF (Crabman 30/06/2015)
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
		elseif fields["unequip_bag" .. i] then
			local stack = unified_inventory.extract_bag(player, i)
			if not stack then
				return
			elseif stack == "overflow" then
				minetest.chat_send_player(player:get_player_name(), "You bag is too heavy to be unequipped... Remove some items and retry")
				return
			elseif not player:get_inventory():room_for_item("main", stack) then
				local pos = player:getpos()
				pos.y = pos.y + 2
				minetest.add_item(pos, stack)
				return
			end
			player:get_inventory():add_item("main", stack)
		end
	end
end)

minetest.register_on_joinplayer(function(player)
	local player_inv = player:get_inventory()
	local bags_inv = minetest.create_detached_inventory(player:get_player_name().."_bags",{
		on_put = function(inv, listname, index, stack, player)
			local pinv = player:get_inventory()
			pinv:set_stack(listname, index, stack)
			pinv:set_size(listname.."contents",
					stack:get_definition().groups.bagslots)

			-- Retrieve the serialized inventory if any
			if stack:get_metadata() ~= "" then
				for i, item in pairs(minetest.deserialize(stack:get_metadata())) do
					pinv:set_stack(listname .. "contents", i, ItemStack(item))
				end
			end
		end,
		allow_take = function()
			return 0
		end,
		allow_put = function(inv, listname, index, stack, player)
			if stack:get_definition().groups.bagslots then
				return 1
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

local colours = {"orange", "blue", "green", "violet"}

for _, colour in pairs(colours) do
	minetest.register_tool("unified_inventory:bag_small_" .. colour, {
		description = S("Small Bag"),
		inventory_image = "bags_small_" .. colour .. ".png",
		groups = {bagslots=8},
	})

	minetest.register_tool("unified_inventory:bag_medium_" .. colour, {
		description = S("Medium Bag"),
		inventory_image = "bags_medium_" .. colour .. ".png",
		groups = {bagslots=16},
	})

	minetest.register_tool("unified_inventory:bag_large_" .. colour, {
		description = S("Large Bag"),
		inventory_image = "bags_large_" .. colour .. ".png",
		groups = {bagslots=24},
	})
	
	-- register bag crafts
	minetest.register_craft({
		output = "unified_inventory:bag_small_" .. colour,
		recipe = {
			{"dye:"..colour,           "unified_inventory:bag_small"},
		},
	})
	
	minetest.register_craft({
		output = "unified_inventory:bag_medium_" .. colour,
		recipe = {
			{"",              "",                            ""},
			{"farming:cotton", "unified_inventory:bag_small_" .. colour, "farming:cotton"},
			{"farming:cotton", "unified_inventory:bag_small_" .. colour, "farming:cotton"},
		},
	})

	minetest.register_craft({
		output = "unified_inventory:bag_large_" .. colour,
		recipe = {
			{"",              "",                             ""},
			{"farming:cotton", "unified_inventory:bag_medium_" .. colour, "farming:cotton"},
			{"farming:cotton", "unified_inventory:bag_medium_" .. colour, "farming:cotton"},
	    },
	})
end

--minetest.register_alias("unified_inventory:bag_small", "unified_inventory:bad_small_red")
--minetest.register_alias("unified_inventory:bag_medium", "unified_inventory:bad_medium_red")
--minetest.register_alias("unified_inventory:bag_large", "unified_inventory:bad_large_red")

-- register bag crafts
minetest.register_craft({
	output = "unified_inventory:bag_small",
	recipe = {
		{"",           "farming:cotton", ""},
		{"group:wool", "group:wool",    "group:wool"},
		{"group:wool", "group:wool",    "group:wool"},
	},
})

minetest.register_craft({
	output = "unified_inventory:bag_medium",
	recipe = {
		{"",              "",                            ""},
		{"farming:cotton", "unified_inventory:bag_small", "farming:cotton"},
		{"farming:cotton", "unified_inventory:bag_small", "farming:cotton"},
	},
})

minetest.register_craft({
	output = "unified_inventory:bag_large",
	recipe = {
		{"",              "",                             ""},
		{"farming:cotton", "unified_inventory:bag_medium", "farming:cotton"},
		{"farming:cotton", "unified_inventory:bag_medium", "farming:cotton"},
    },
})

function unified_inventory.extract_bag(player, id)
	if not player then
		minetest.log("error", "[u_inv] Invalid player for bag extraction : nil")
		return
	end
	if tonumber(id) == nil or id > 4 or id < 0 then
		minetest.log("error", "Invalid id: " .. (id or 'nil'))
		return
	end

	local stack = player:get_inventory():get_stack("bag"..id, 1)
	if not stack:get_definition().groups.bagslots then
		return
	end
	local pinv = player:get_inventory()
	local inv = pinv:get_list("bag" .. id .. "contents")
	local list = {}
	for i, item in pairs(inv) do
		list[i] = item:to_table()
	end
	if minetest.serialize(list):len() >= 4096 then
		minetest.log("warning", "[U_Inv] Preventing metadata overflow with bag metadata")
		return "overflow"
	end

	pinv:remove_item("bag" .. id, stack)
	minetest.get_inventory({type = "detached", name = minetest.formspec_escape(player:get_player_name()) .. "_bags"}):set_stack("bag" .. id, 1, nil)
	pinv:set_list("bag" .. id .. "contents", {})

	stack:set_metadata(minetest.serialize(list))
	return stack
end
