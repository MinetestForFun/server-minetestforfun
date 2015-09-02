--[[

Skyblock for Minetest

Copyright (c) 2015 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-skyblock
License: GPLv3

]]--


skyblock.levels = {}

--
-- CONFIG OPTIONS
--

-- true to restart from level1, false to restart from current level
skyblock.levels.restart_on_die = minetest.setting_getbool('skyblock.levels.restart_on_die')


--
-- Functions
--

-- empty inventory
function skyblock.levels.empty_inventory(player)
	local inv = player:get_inventory()
	if not inv:is_empty('rewards') then
		for i=1,inv:get_size('rewards') do
			inv:set_stack('rewards', i, nil)
		end
	end
	if skyblock.levels.lose_bags_on_death then
		local bags_inv = minetest.get_inventory({type='detached', name=player:get_player_name()..'_bags'})
		for bag=1,4 do
			if not bags_inv:is_empty('bag'..bag) then
				for i=1,bags_inv:get_size('bag'..bag) do
					inv:set_stack('bag'..bag, i, nil)
				end
				for i=1,bags_inv:get_size('bag'..bag) do
					bags_inv:set_stack('bag'..bag, i, nil)
					inv:set_stack('bag'..bag..'contents', i, nil)
				end
			end
		end
	end
end


--
-- Formspec
--

-- get_formspec
function skyblock.levels.get_formspec(player_name)
	local level = skyblock.feats.get_level(player_name)
	local level_info = skyblock.levels[level].get_info(player_name)
	return level_info.formspec
end

-- get_inventory_formspec
function skyblock.levels.get_inventory_formspec(level,player_name,inventory)
	local formspec = 'size[15,10;]'
	if inventory then
		if minetest.get_modpath('unified_inventory') then
			formspec = formspec..skyblock.get_unified_inventory_buttons()
		end
		formspec = formspec..'button_exit[13,0;2,0.5;close;Close]'
	else
		formspec = formspec
			..'button[11,0;2,0.5;restart;Restart]'
			..'button_exit[13,0;2,0.5;close;Close]'
	end
		
	formspec = formspec
		..'background[-0.1,-0.1;6.6,10.3;goals.png]'
		..'label[0,0; --== LEVEL '..level..' for '..player_name..' ==--]'

		..'label[7,1.5; Rewards]'
		..'background[6.9,1.4;2.2,2.8;rewards.png]'
		..'list[current_player;rewards;7,2;2,2;]'

		..'label[10,1.5; Craft]'
		..'label[14,2.5;Output]'
		..'background[9.9,1.4;5.2,3.8;craft.png]'
		..'list[current_player;craft;10,2;3,3;]'
		..'list[current_player;craftpreview;14,3;1,1;]'
		
		..'label[7,5.5; Inventory]'
		..'background[6.9,5.4;8.2,4.8;inventory.png]'
		..'list[current_player;main;7,6;8,4;]'
	return formspec
end

-- render an item image button for the formspec
local function image_button_link(stack_string)
	local stack = ItemStack(stack_string);
	local new_node_name = stack_string;
	if stack and stack:get_name() then
		new_node_name = stack:get_name()
	end
	return tostring(stack_string)..';item_button_nochange_'..unified_inventory.mangle_for_formspec(new_node_name)..';'
end

-- get_feat_formspec
function skyblock.levels.get_feat_formspec(info,i,feat,required,text,hint,inventory)
	local y = 2.9+(i*0.6)
	local count = skyblock.feats.get(info.level,info.player_name,feat)
	if count > required then
		count = required
	end
	local formspec = 'label[0.5,'..y..'; '..text..' ('..count..'/'..required..')]'
	if hint then
		if inventory and minetest.get_modpath('unified_inventory') then
			formspec = formspec..'item_image_button[5.8,'..y..';0.6,0.6;'..image_button_link(hint)..']'
		else
			formspec = formspec..'item_image_button[5.8,'..y..';0.6,0.6;'..skyblock.craft_guide.image_button_link(hint)..']'
		end
	end
	if count == required then
		formspec = formspec .. 'image[-0.2,'..(y-0.25)..';1,1;checkbox_checked.png]'
		info.count = info.count + 1
	else
		formspec = formspec .. 'image[-0.2,'..(y-0.25)..';1,1;checkbox_unchecked.png]'
	end
	return formspec
end

-- get_unified_inventory_buttons
function skyblock.get_unified_inventory_buttons()
	local formspec = ''
	local button_row = 0
	local button_col = 0
	local main_button_x = 7
	local main_button_y = 0
	for i, def in pairs(unified_inventory.buttons) do
		if unified_inventory.lite_mode and i > 4 then
			button_row = 1
			button_col = 1
		end
		local tooltip = def.tooltip or ''
		if def.type == 'image' then
			formspec = formspec..'image_button['
					..( main_button_x + 0.65 * (i - 1) - button_col * 0.65 * 4)
					..','..(main_button_y + button_row * 0.7)..';0.8,0.8;'
					..minetest.formspec_escape(def.image)..';'
					..minetest.formspec_escape(def.name)..';]'
					..'tooltip['..minetest.formspec_escape(def.name)
					..';'..tooltip..']'
		end
	end
	return formspec
end

-- get_restart_formspec
function skyblock.show_restart_formspec(player_name)
	local formspec = 'size[6,2.5;]'
		..'label[0,0.0;-= Are you sure you want to restart? =-]'
		..'label[0,0.5;You will lose all your Items and will have to redo]'
		..'label[0,1.0;all of your Quests starting from Level 1.]'
		..'button[0,2;3,0.5;restart;Confirm Restart]'
		..'button_exit[3,2;3,0.5;close;Cancel]'
	minetest.show_formspec(player_name, 'skyblock_restart', formspec)
end

--
-- Feat Checks
--

-- reward_feat
function skyblock.levels.reward_feat(level,player_name,feat)
	local count = skyblock.feats.get(level,player_name,feat)
	for _,v in ipairs(skyblock.levels[level].feats) do
		if v.feat == feat and v.count == count then
			skyblock.feats.give_reward(level,player_name,v.reward)
			return true
		end
	end
end

-- track digging feats
function skyblock.levels.on_dignode(level,pos,oldnode,digger)
	local player_name = digger:get_player_name()
	for _,v in ipairs(skyblock.levels[level].feats) do
		if v.dignode then
			for _,vv in ipairs(v.dignode) do
				if oldnode.name == vv then
					skyblock.feats.add(level,player_name,v.feat)
					return
				end
			end
		end
	end
end

-- track placing feats
function skyblock.levels.on_placenode(level,pos,newnode,placer,oldnode)
	local player_name = placer:get_player_name()
	for _,v in ipairs(skyblock.levels[level].feats) do
		if v.placenode then
			for _,vv in ipairs(v.placenode) do
				if newnode.name == vv then
					skyblock.feats.add(level,player_name,v.feat)
					return
				end
			end
		end
	end
end

-- track eating feats
function skyblock.levels.on_item_eat(level,player_name,itemstack)
	local item_name = itemstack:get_name()
	for _,v in ipairs(skyblock.levels[level].feats) do
		if v.item_eat then
			for _,vv in ipairs(v.item_eat) do
				if item_name==vv then
					skyblock.feats.add(level,player_name,v.feat)
					return
				end
			end
		end
	end
end

-- track crafting feats
function skyblock.levels.on_craft(level,player_name,itemstack)
	local item_name = itemstack:get_name()
	for _,v in ipairs(skyblock.levels[level].feats) do
		if v.craft then
			for _,vv in ipairs(v.craft) do
				if item_name==vv then
					skyblock.feats.add(level,player_name,v.feat)
					return
				end
			end
		end
	end
end

-- track bucket feats
function skyblock.levels.bucket_on_use(level,player_name,pointed_thing)
	local node = minetest.env:get_node(pointed_thing.under)
	for _,v in ipairs(skyblock.levels[level].feats) do
		if v.bucket then
			for _,vv in ipairs(v.bucket) do
				if node.name == vv then
					skyblock.feats.add(level,player_name,v.feat)
					return
				end
			end
		end
	end
end

-- track bucket water feats
function skyblock.levels.bucket_water_on_use(level,player_name,pointed_thing) 
	local node = minetest.env:get_node(pointed_thing.under)
	for _,v in ipairs(skyblock.levels[level].feats) do
		if v.bucket_water then
			for _,vv in ipairs(v.bucket_water) do
				if node.name == vv then
					skyblock.feats.add(level,player_name,v.feat)
					return
				end
			end
		end
	end
end

-- track bucket lava feats
function skyblock.levels.bucket_lava_on_use(level,player_name,pointed_thing)
	local node = minetest.env:get_node(pointed_thing.under)
	for _,v in ipairs(skyblock.levels[level].feats) do
		if v.bucket_lava then
			for _,vv in ipairs(v.bucket_lava) do
				if node.name == vv then
					skyblock.feats.add(level,player_name,v.feat)
					return
				end
			end
		end
	end
end