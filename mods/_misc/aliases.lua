-- Supprime les doublons avec Moreores du subgame carbone
-- Stone
minetest.register_alias("default:stone_with_tin", "default:stone")
minetest.register_alias("default:stone_with_silver", "default:stone")
-- Lump
minetest.register_alias("default:tin_lump", "default:stone")
minetest.register_alias("default:silver_lump", "default:stone")
-- Ingot
minetest.register_alias("default:tin_ingot", "default:stone")
minetest.register_alias("default:silver_ingot", "default:stone")
-- Block
minetest.register_alias("default:tinblock", "default:stone")
minetest.register_alias("default:silverblock", "default:stone")
-- Tools
minetest.register_alias("default:pick_silver", "default:stone")
minetest.register_alias("default:shovel_silver", "default:stone")
minetest.register_alias("default:axe_silver", "default:stone")
minetest.register_alias("default:sword_silver", "default:stone")
minetest.register_alias("default:knife_silver", "default:stone")

-- Remove torch from torches => remise des torches par défaut
minetest.register_alias("torches:floor", "default:torch")
minetest.register_alias("torches:wand", "default:torch")

-- Remove copper_rail from moreores => utilisation des rail_copper du mod carts
minetest.register_alias("moreores:copper_rail", "carts:rail_copper")

-- Old fishing mod to the new fishing mod
minetest.register_alias("fishing:fish_cooked", "fishing:fish")
minetest.register_alias("fishing:worm", "fishing:bait_worm")

-- Old itemframes mod to the new itemframes(v2) mod
minetest.register_alias("itemframes:pedestal", "itemframes:pedestal_cobble")

-- Remove "moreores:copper_rail" for "carts:copper_rail"
minetest.register_alias("moreores:copper_rail", "carts:rail_copper")

-- Remove "multitest:hayblock" because farming redo include it now
minetest.register_alias("multitest:hayblock", "farming:straw")

-- Remove "darkage:stair_straw", "darkage:straw", "darkage:straw_bale" and "darkage:adobe"
minetest.register_alias("darkage:stair_straw", "farming:straw")
minetest.register_alias("darkage:straw", "farming:straw")
minetest.register_alias("darkage:straw_bale", "farming:straw")
minetest.register_alias("darkage:adobe", "farming:straw")
