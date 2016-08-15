local alias = minetest.register_alias
-- Remove duplicated items from the carbone subgame because of Moreores mod
-- Stone
alias("default:stone_with_tin", "default:stone")
alias("default:stone_with_silver", "default:stone")
-- Lump
alias("default:tin_lump", "default:stone")
alias("default:silver_lump", "default:stone")
-- Ingot
alias("default:tin_ingot", "default:stone")
alias("default:silver_ingot", "default:stone")
-- Block
alias("default:tinblock", "default:stone")
alias("default:silverblock", "default:stone")
-- Tools
alias("default:pick_silver", "default:stone")
alias("default:shovel_silver", "default:stone")
alias("default:axe_silver", "default:stone")
alias("default:sword_silver", "default:stone")
alias("default:knife_silver", "default:stone")

-- Remove torch from torches => remise des torches par défaut
alias("torches:floor", "default:torch")
alias("torches:wand", "default:torch")

-- Remove copper_rail from moreores => utilisation des rail_copper du mod carts
alias("moreores:copper_rail", "carts:rail_copper")

-- Old fishing mod to the new fishing mod
alias("fishing:fish_cooked", "fishing:fish")
alias("fishing:worm", "fishing:bait_worm")

-- Old itemframes mod to the new itemframes(v2) mod
alias("itemframes:pedestal", "itemframes:pedestal_cobble")

-- Remove "moreores:copper_rail" for "carts:copper_rail"
alias("moreores:copper_rail", "carts:rail_copper")

-- Remove "multitest:hayblock" because farming redo include it now
alias("multitest:hayblock", "farming:straw")

-- Remove "darkage:stair_straw", "darkage:straw", "darkage:straw_bale" and "darkage:adobe"
alias("darkage:stair_straw", "farming:straw")
alias("darkage:straw", "farming:straw")
alias("darkage:straw_bale", "farming:straw")
alias("darkage:adobe", "farming:straw")

-- Remove "wiki:wiki"
alias("wiki:wiki", "default:bookshelf")

-- Remove "building_blocks:knife"
alias("building_blocks:knife", "default:sword_steel")

-- Remove "xmas_tree" from snow mod
alias("snow:xmas_tree", "default:dirt")

-- remove "fake_fire:flint_and_steel" from homedecor_modpack mod
alias("fake_fire:flint_and_steel", "fire:flint_and_steel")

-- remove ongen pine saplings from moretrees
alias("moretrees:pine_sapling_ongen", "default:pine_sapling")

-- Remove bedrock mod
alias("bedrock:bedrock", "default:cobble")
