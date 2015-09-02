--[[

Skyblock for Minetest

Copyright (c) 2015 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-skyblock
License: GPLv3

]]--


-- quest
minetest.register_node('skyblock:quest', {
	description = 'Skyblock',
	tiles = {'skyblock_quest.png'},
	is_ground_content = true,
	paramtype = 'light',
	light_propagates = true,
	sunlight_propagates = true,
	light_source = 15,		
	can_dig = function(pos, player)
		return false
	end,
	on_construct = function(pos)
		-- do not remove, needed to init the node
	end,
})

