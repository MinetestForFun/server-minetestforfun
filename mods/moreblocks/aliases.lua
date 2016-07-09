--[[
More Blocks: alias definitions

Copyright (c) 2011-2015 Calinou and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- More Blocks aliases:
minetest.register_alias("sweeper", "moreblocks:sweeper")
minetest.register_alias("circular_saw", "moreblocks:circular_saw")
minetest.register_alias("jungle_stick", "moreblocks:jungle_stick")

-- Wrong drops

-- //MFF(Mg|10/11/15)

-- Microblocks
for _,i in pairs({"", "_1", "_2", "_4", "_12", "_14", "_15"}) do
	minetest.register_alias("moreblocks:micro_clay_brick" .. i, "moreblocks:micro_brick" .. i)
end

-- Panels
for _,i in pairs({"", "_1", "_2", "_4", "_12", "_14", "_15"}) do
	minetest.register_alias("moreblocks:panel_clay_brick" .. i, "moreblocks:panel_brick" .. i)
end

-- Slabs
for _,i in pairs({"", "_1", "_2", "_quarter", "_three_quarter", "_14", "_15"}) do
	minetest.register_alias("moreblocks:slab_clay_brick" .. i, "moreblocks:slab_brick" .. i)
end

-- Stairs
for _,i in pairs({"", "_outer", "_inner", "_alt", "_alt_1", "_alt_2", "_alt_4", "_half"}) do
	minetest.register_alias("moreblocks:stair_clay_brick" .. i, "moreblocks:stair_brick" .. i)
end

-- Slopes
for _,i in pairs({"", "_half", "_half_raised", "_outer", "_outer_cut", "_outer_cut_half", "_outer_half", "_outer_half_raised", "_inner", "_inner_half", "_inner_half_raised"}) do
	minetest.register_alias("moreblocks:slope_clay_brick" .. i, "moreblocks:slope_brick" .. i)
end



-- Old block/item replacement:
minetest.register_alias("moreblocks:oerkkiblock", "default:mossycobble")
minetest.register_alias("moreblocks:screwdriver", "screwdriver:screwdriver")

-- Node and item renaming:
minetest.register_alias("moreblocks:stone_bricks", "default:stonebrick")
minetest.register_alias("moreblocks:stonebrick", "default:stonebrick")
minetest.register_alias("moreblocks:junglewood", "default:junglewood")
minetest.register_alias("moreblocks:jungle_wood", "default:junglewood")

for _, t in pairs(circular_saw.names) do
	minetest.register_alias("moreblocks:" .. t[1] .. "_jungle_wood" .. t[2],
			"moreblocks:" .. t[1] .. "_junglewood" .. t[2])
end
minetest.register_alias("moreblocks:horizontaltree", "moreblocks:horizontal_tree")
minetest.register_alias("moreblocks:horizontaljungletree", "moreblocks:horizontal_jungle_tree")
minetest.register_alias("moreblocks:stonesquare", "moreblocks:stone_tile")
minetest.register_alias("moreblocks:circlestonebrick", "moreblocks:circle_stone_bricks")
minetest.register_alias("moreblocks:ironstonebrick", "moreblocks:iron_stone_bricks")
minetest.register_alias("moreblocks:fence_junglewood", "moreblocks:fence_jungle_wood")
minetest.register_alias("moreblocks:coalstone", "moreblocks:coal_stone")
minetest.register_alias("moreblocks:ironstone", "moreblocks:iron_stone")
minetest.register_alias("moreblocks:woodtile", "moreblocks:wood_tile")
minetest.register_alias("moreblocks:woodtile_full", "moreblocks:wood_tile_full")
minetest.register_alias("moreblocks:woodtile_centered", "moreblocks:wood_tile_centered")
minetest.register_alias("moreblocks:woodtile_up", "moreblocks:wood_tile_up")
minetest.register_alias("moreblocks:woodtile_down", "moreblocks:wood_tile_down")
minetest.register_alias("moreblocks:woodtile_left", "moreblocks:wood_tile_left")
minetest.register_alias("moreblocks:woodtile_right", "moreblocks:wood_tile_right")
minetest.register_alias("moreblocks:coalglass", "moreblocks:coal_glass")
minetest.register_alias("moreblocks:ironglass", "moreblocks:iron_glass")
minetest.register_alias("moreblocks:glowglass", "moreblocks:glow_glass")
minetest.register_alias("moreblocks:superglowglass", "moreblocks:super_glow_glass")
minetest.register_alias("moreblocks:trapglass", "moreblocks:trap_glass")
minetest.register_alias("moreblocks:trapstone", "moreblocks:trap_stone")
minetest.register_alias("moreblocks:cactuschecker", "moreblocks:cactus_checker")
minetest.register_alias("moreblocks:coalchecker", "moreblocks:coal_checker")
minetest.register_alias("moreblocks:ironchecker", "moreblocks:iron_checker")
minetest.register_alias("moreblocks:cactusbrick", "moreblocks:cactus_brick")
minetest.register_alias("moreblocks:cleanglass", "moreblocks:clean_glass")
minetest.register_alias("moreblocks:emptybookshelf", "moreblocks:empty_bookshelf")
minetest.register_alias("moreblocks:junglestick", "moreblocks:jungle_stick")
minetest.register_alias("moreblocks:splitstonesquare","moreblocks:split_stone_tile")
minetest.register_alias("moreblocks:allfacestree","moreblocks:all_faces_tree")

-- ABM for horizontal trees (fix facedir):
local horizontal_tree_convert_facedir = {7, 12, 9, 18}

minetest.register_abm({
	nodenames = {"moreblocks:horizontal_tree"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		node.param2 = node.param2 < 3 and node.param2 or 0
		minetest.set_node(pos, {
			name = "default:tree",
			param2 = horizontal_tree_convert_facedir[node.param2 + 1]
		})
	end,
})

minetest.register_alias("moreblocks:jungle_stick", "default:stick")
minetest.register_alias("moreblocks:fence_jungle_wood", "default:fence_junglewood")
