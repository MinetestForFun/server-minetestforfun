--[[

Skyblock for Minetest

Copyright (c) 2015 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-skyblock
License: GPLv3

]]--


-- quest node
minetest.override_item('skyblock:quest', {
	groups = {crumbly=2,cracky=2},
	on_construct = function(pos)
		local player_name = skyblock.get_spawn_player(pos)
		if player_name then
			skyblock.feats.update(player_name)
		end
	end,
    on_punch = function(pos, node, puncher)
		local player_name = skyblock.get_spawn_player(pos)
		if player_name then
			skyblock.feats.update(player_name)
		end
	end,
	can_dig = function(pos, player)
		return true
	end,
    on_dig = function(pos, node, digger)
		skyblock.show_restart_formspec(digger:get_player_name())
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if fields.restart then
			skyblock.show_restart_formspec(sender:get_player_name())
			return
		end
		for k,v in pairs(fields) do
			if string.match(k, 'skyblock_craft_guide_') then
				minetest.show_formspec(sender:get_player_name(),'skyblock_craft_guide',skyblock.craft_guide.get_formspec(k, fields))
				return
			end
		end
	end,
})

-- trees
local trees = {'default:tree','default:jungletree','default:pinetree'}
for k,node in ipairs(trees) do
	local groups = minetest.registered_nodes[node].groups
	groups.oddly_breakable_by_hand = 0
	minetest.override_item(node, {groups = groups})
end

-- leaves
local leaves = {'default:leaves','default:jungleleaves','default:pine_needles'}
for k,node in ipairs(leaves) do
	minetest.override_item(node, {climbable = true,	walkable = false})
end

-- instant grow sapling if there is room
minetest.override_item('default:sapling', {
	after_place_node = function(pos)
		-- check if we have space to make a tree
		for dy=1,4 do
			pos.y = pos.y+dy
			if minetest.env:get_node(pos).name ~= 'air' and minetest.env:get_node(pos).name ~= 'default:leaves' then
				return
			end
			pos.y = pos.y-dy
		end
		-- add the tree
		default.grow_tree(pos, math.random(1, 4) == 1)
	end,
})
