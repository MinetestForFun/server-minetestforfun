--[[

Skyblock for Minetest

Copyright (c) 2015 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-skyblock
License: GPLv3

]]--

--[[

level 1 feats and rewards:

* dig_dirt x10				default:stick
* place_dirt x10			default:leaves 6
* place_sapling x1			default:tree
* dig_tree x16				default:cobble 8
* place_furnace x1			default:axe_steel
* place_cobble x50			default:stair_cobble 4
* place_chest x1			default:papyrus 5
* place_sign x1				default:pick_steel
* place_door x1				default:sand 2
* place_glass x2			protector:protect

]]--

local level = 1

--
-- PUBLIC FUNCTIONS
--

skyblock.levels[level] = {}

-- feats
skyblock.levels[level].feats = {
	{
		name = 'dig 10 Dirt',
		hint = nil,
		feat = 'dig_dirt', 
		count = 10, 
		reward = 'default:stick',
		dignode = {'default:dirt', 'default:dirt_with_grass', 'default:dirt_with_grass_footsteps'},
	},
	{
		name = 'place 10 Dirt',
		hint = 'default:dirt',
		feat = 'place_dirt', 
		count = 10, 
		reward = 'default:leaves 6',
		placenode = {'default:dirt'},
	},
	{
		name = 'craft a Sapling and grow a Tree',
		hint = 'default:sapling',
		feat = 'place_sapling', 
		count = 1, 
		reward = 'default:tree',
		placenode = {'default:sapling'},
	},
	{
		name = 'craft an Axe and dig 16 Tree',
		hint = 'default:axe_wood',
		feat = 'dig_tree', 
		count = 16, 
		reward = 'default:cobble 8',
		dignode = {'default:tree'},
	},
	{
		name = 'craft and place a Furnace',
		hint = 'default:furnace',
		feat = 'place_furnace', 
		count = 1, 
		reward = 'default:axe_steel',
		placenode = {'default:furnace'},
	},
	{
		name = 'craft and place 50 Cobblestone',
		hint = 'default:cobble',
		feat = 'place_cobble', 
		count = 50,
		reward = 'stairs:stair_cobble 4',
		placenode = {'default:cobble'},
	},
	{
		name = 'craft and place a Chest',
		hint = 'default:chest',
		feat = 'place_chest',
		count = 1, 
		reward = 'default:papyrus 5',
		placenode = {'default:chest'},
	},
	{
		name = 'craft and place a Sign',
		hint = 'default:sign_wall',
		feat = 'place_sign',
		count = 1,
		reward = 'default:pick_steel',
		placenode = {'default:sign_wall'},
	},
	{
		name = 'craft and place a Door',
		hint = 'doors:door_wood',
		feat = 'place_door',
		count = 1,
		reward = 'default:sand 2',
		placenode = {'doors:door_wood'},
	},
	{
		name = 'craft and place 2 Glass',
		hint = 'default:glass',
		feat = 'place_glass',
		count = 2,
		reward = 'protector:protect',
		placenode = {'default:glass'},
	},
}

-- init level
skyblock.levels[level].init = function(player_name)
	-- revoke perms
	local privs = core.get_player_privs(player_name)
	if privs['fly'] or privs['fast'] then
		privs['fly'] = nil
		privs['fast'] = nil
		core.set_player_privs(player_name, privs)
		minetest.chat_send_player(player_name, 'You have lost FLY and FAST')
	end
end

-- get level information
skyblock.levels[level].get_info = function(player_name)
	local info = { 
		level=level, 
		total=10, 
		count=0, 
		player_name=player_name, 
		infotext='', 
		formspec = '', 
		formspec_quest = '',
	}

	local text = 'label[0,2.7; --== Quests ==--]'
		..'label[0,0.5;Welcome '..player_name..', of the Sky People]'
		..'label[0,1.0;We can no longer live on the surface.]'
		..'label[0,1.5;Can you help us rebuild in the sky?]'
		..'label[0,2.0;Complete the quests to receive great rewards!]'
	
	info.formspec = skyblock.levels.get_inventory_formspec(level,info.player_name,true)..text
	info.formspec_quest = skyblock.levels.get_inventory_formspec(level,info.player_name)..text
	
	for k,v in ipairs(skyblock.levels[level].feats) do
		info.formspec = info.formspec..skyblock.levels.get_feat_formspec(info,k,v.feat,v.count,v.name,v.hint,true)
		info.formspec_quest = info.formspec_quest..skyblock.levels.get_feat_formspec(info,k,v.feat,v.count,v.name,v.hint)
	end
	if info.count>0 then
		info.count = info.count/2 -- only count once
	end

	info.infotext = 'LEVEL '..info.level..' for '..info.player_name..': '..info.count..' of '..info.total
	
	return info
end

-- reward_feat
skyblock.levels[level].reward_feat = function(player_name,feat)
	return skyblock.levels.reward_feat(level, player_name, feat)
end

-- track digging feats
skyblock.levels[level].on_dignode = function(pos, oldnode, digger)
	skyblock.levels.on_dignode(level, pos, oldnode, digger)
end

-- track placing feats
skyblock.levels[level].on_placenode = function(pos, newnode, placer, oldnode)
	skyblock.levels.on_placenode(level, pos, newnode, placer, oldnode)
end

-- track eating feats
skyblock.levels[level].on_item_eat = function(player_name, itemstack)
	skyblock.levels.on_item_eat(level, player_name, itemstack)
end

-- track crafting feats
skyblock.levels[level].on_craft = function(player_name, itemstack)
	skyblock.levels.on_craft(level, player_name, itemstack)
end

-- track bucket feats
skyblock.levels[level].bucket_on_use = function(player_name, pointed_thing)
	skyblock.levels.bucket_on_use(level, player_name, pointed_thing)
end

-- track bucket water feats
skyblock.levels[level].bucket_water_on_use = function(player_name, pointed_thing) 
	skyblock.levels.bucket_water_on_use(level, player_name, pointed_thing)
end

-- track bucket lava feats
skyblock.levels[level].bucket_lava_on_use = function(player_name, pointed_thing)
	skyblock.levels.bucket_lava_on_use(level, player_name, pointed_thing)
end