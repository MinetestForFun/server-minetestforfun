-- Code by Mossmanikin
-----------------------------------------------------------------------------------------------
-- TWiGS
-----------------------------------------------------------------------------------------------
minetest.register_craft({ -- *leaves --> twigs
	output = "trunks:twig_1 2",
	recipe = {{"group:leafdecay"}}
})
if minetest.get_modpath("moretrees") ~= nil then
minetest.register_craft({ -- moretrees_leaves --> twigs
	output = "trunks:twig_1 2",
	recipe = {{"group:moretrees_leaves"}}
})
minetest.register_craft({ -- except moretrees:palm_leaves
	output = "moretrees:palm_leaves",
	recipe = {{"moretrees:palm_leaves"}}
})
end
if minetest.get_modpath("bushes") ~= nil then
minetest.register_craft({ -- BushLeaves --> twigs
	output = "trunks:twig_1 2",
	recipe = {{"bushes:BushLeaves1"}}
})
minetest.register_craft({
	output = "trunks:twig_1 2",
	recipe = {{"bushes:BushLeaves2"}}
})
minetest.register_craft({ -- bushbranches --> twigs
	output = "trunks:twig_1 4",
	recipe = {{"bushes:bushbranches1"}}
})
minetest.register_craft({
	output = "trunks:twig_1 4",
	recipe = {{"bushes:bushbranches2"}}
})
minetest.register_craft({
	output = "trunks:twig_1 4",
	recipe = {{"bushes:bushbranches2a"}}
})
minetest.register_craft({
	output = "trunks:twig_1 4",
	recipe = {{"bushes:bushbranches3"}}
})
end
minetest.register_craft({ -- twigs block --> twigs
	output = "trunks:twig_1 8",
	recipe = {{"trunks:twigs"}}
})
minetest.register_craft({ -- twigs_slab --> twigs
	output = "trunks:twig_1 4",
	recipe = {{"trunks:twigs_slab"}}
})
minetest.register_craft({ -- twigs_roof --> twigs
	output = "trunks:twig_1 4",
	recipe = {{"trunks:twigs_roof"}}
})
minetest.register_craft({ -- twigs_roof_corner --> twigs
	output = "trunks:twig_1 3",
	recipe = {{"trunks:twigs_roof_corner"}}
})
minetest.register_craft({ -- twigs_roof_corner_2 --> twigs
	output = "trunks:twig_1 3",
	recipe = {{"trunks:twigs_roof_corner_2"}}
})
-----------------------------------------------------------------------------------------------
-- STiCK
-----------------------------------------------------------------------------------------------
minetest.register_craft({ -- twig --> stick
	output = "default:stick",
	recipe = {{"trunks:twig_1"}}
})

-----------------------------------------------------------------------------------------------
-- TWiGS BLoCK
-----------------------------------------------------------------------------------------------
minetest.register_craft({ -- twigs --> twigs block
	output = "trunks:twigs",
	recipe = {
		{"trunks:twig_1","trunks:twig_1","trunks:twig_1"},
		{"trunks:twig_1",      ""       ,"trunks:twig_1"},
		{"trunks:twig_1","trunks:twig_1","trunks:twig_1"},
	}
})

-----------------------------------------------------------------------------------------------
-- TWiGS SLaBS
-----------------------------------------------------------------------------------------------
minetest.register_craft({ -- twigs blocks --> twigs_slabs
	output = "trunks:twigs_slab 6",
	recipe = {
		{"trunks:twigs","trunks:twigs","trunks:twigs"},
	}
})

-----------------------------------------------------------------------------------------------
-- TWiGS RooFS
-----------------------------------------------------------------------------------------------
minetest.register_craft({ -- twigs blocks --> twigs_roofs
	output = "trunks:twigs_roof 4",
	recipe = {
		{"trunks:twigs",""},
		{"","trunks:twigs"},
	}
})
minetest.register_craft({
	output = "trunks:twigs_roof 4",
	recipe = {
		{"","trunks:twigs"},
		{"trunks:twigs",""},
	}
})

-----------------------------------------------------------------------------------------------
-- TWiGS RooF CoRNeRS
-----------------------------------------------------------------------------------------------
minetest.register_craft({ -- twigs blocks --> twigs_roof_corners
	output = "trunks:twigs_roof_corner 8",
	recipe = {
		{      ""      ,"trunks:twigs",      ""      },
		{"trunks:twigs",      ""      ,"trunks:twigs"},
	}
})

-----------------------------------------------------------------------------------------------
-- TWiGS RooF CoRNeRS 2
-----------------------------------------------------------------------------------------------
minetest.register_craft({ -- twigs blocks --> twigs_roof_corner_2's
	output = "trunks:twigs_roof_corner_2 8",
	recipe = {
		{"trunks:twigs",      ""      ,"trunks:twigs"},
		{      ""      ,"trunks:twigs",      ""      },
	}
})