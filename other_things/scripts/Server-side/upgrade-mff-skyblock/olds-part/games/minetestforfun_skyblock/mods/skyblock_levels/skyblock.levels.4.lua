--[[

Skyblock for Minetest

Copyright (c) 2015 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-skyblock
License: GPLv3

]]--

local level = 4

--
-- PUBLIC FUNCTIONS
--

skyblock.levels[level] = {}

-- feats
skyblock.levels[level].feats = {}

-- init level
skyblock.levels[level].init = function(player_name)
	local privs = core.get_player_privs(player_name)
	privs['fly'] = true
	privs['fast'] = true
	core.set_player_privs(player_name, privs)
	minetest.chat_send_player(player_name, 'You can now use FLY and FAST !')
end

-- get level information
skyblock.levels[level].get_info = function(player_name)
	local info = { 
		level=level, 
		total=1, 
		count=0, 
		player_name=player_name, 
		infotext='', 
		formspec = '', 
		formspec_quest = '',
	}
	
	local text = 'label[0,0.5; THE END]'
		..'label[0,1.0; I hope you enjoyed your journey, and you]'
		..'label[0,1.5; are welcome to stay and keep building]'
		..'label[0,2.0; your new sky world.]'
		
	info.formspec = skyblock.levels.get_inventory_formspec(level,info.player_name,true)..text
	info.formspec_quest = skyblock.levels.get_inventory_formspec(level,info.player_name)..text
	info.infotext = 'THE END! for '.. player_name ..' ... or is it ...'
	return info
end

-- no feat tracking
skyblock.levels[level].reward_feat = function(player_name, feat) end
skyblock.levels[level].on_placenode = function(pos, newnode, placer, oldnode) end
skyblock.levels[level].on_dignode = function(pos, oldnode, digger) end
skyblock.levels[level].on_item_eat = function(player_name, itemstack) end
skyblock.levels[level].on_craft = function(player_name, itemstack) end
skyblock.levels[level].bucket_on_use = function(player_name, pointed_thing) end
skyblock.levels[level].bucket_water_on_use = function(player_name, pointed_thing) end
skyblock.levels[level].bucket_lava_on_use = function(player_name, pointed_thing) end