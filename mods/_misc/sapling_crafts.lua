-- Crafts for saplings
-- From Skyblock by Cornernote
--

-- sapling from leaves and sticks
minetest.register_craft({
	output = 'default:sapling',
	recipe = {
		{'default:leaves', 'default:leaves', 'default:leaves'},
		{'default:leaves', 'default:leaves', 'default:leaves'},
		{'', 'default:stick', ''},
	}
})

-- junglesapling from jungleleaves and sticks
minetest.register_craft({
	output = 'default:junglesapling',
	recipe = {
		{'default:jungleleaves', 'default:jungleleaves', 'default:jungleleaves'},
		{'default:jungleleaves', 'default:jungleleaves', 'default:jungleleaves'},
		{'', 'default:stick', ''},
	}
})

-- pine_sapling from pine_needles and sticks
minetest.register_craft({
	output = 'default:pine_sapling',
	recipe = {
		{'default:pine_needles', 'default:pine_needles', 'default:pine_needles'},
		{'default:pine_needles', 'default:pine_needles', 'default:pine_needles'},
		{'', 'default:stick', ''},
	}
})

-- Aspen tree
minetest.register_craft({
      output = "default:aspen_sapling",
      recipe = {
	 {"default:aspen_leaves", "default:aspen_leaves", "default:aspen_leaves"},
	 {"default:aspen_leaves", "default:aspen_leaves", "default:aspen_leaves"},
	 {"", "default:stick", ""},
      }
})

-- Cherry trees
minetest.register_craft({
      output = "default:cherry_sapling",
      recipe = {
	 {"default:cherry_blossom_leaves", "default:cherry_blossom_leaves", "default:cherry_blossom_leaves"},
	 {"default:cherry_blossom_leaves", "default:cherry_blossom_leaves", "default:cherry_blossom_leaves"},
	 {"", "default:stick", ""},
      }
})

-- With nether
if minetest.get_modpath("nether") then
   minetest.register_craft({
	 output = "nether:tree_sapling",
	 recipe = {
	    {"nether:leaves", "nether:leaves", "nether:leaves"},
	    {"nether:leaves", "nether:leaves", "nether:leaves"},
	    {"", "default:stick", ""},
	 }
   })
end

-- With moretrees
if minetest.get_modpath("moretrees") then
   for _, tdef in pairs(moretrees.treelist) do
      local treename = tdef[1]
      if treename ~= "jungletree" then
	 local leaves = "moretrees:" .. treename .. "_leaves"

	 minetest.register_craft({
	       output = "moretrees:" .. treename .. "_sapling",
	       recipe = {
		  {leaves, leaves, leaves},
		  {leaves, leaves, leaves},
		  {"", "default:stick", ""},
	       }
	 })
      end
   end
end
