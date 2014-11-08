-- Remove stone_with_tin from default carbone subgame => virer doublon minerais brutes
minetest.register_alias("default:stone_with_tin", "default:stone")
minetest.register_alias("default:stone_with_silver", "default:stone")

-- Remove lump from default carbone subgame => virer doublon minerais
minetest.register_alias("default:tin_lump", "default:stone")
minetest.register_alias("default:silver_lump", "default:stone")

-- Remove ingot from default carbone subgame => virer doublon lingots
minetest.register_alias("default:tin_ingot", "default:stone")
minetest.register_alias("default:silver_ingot", "default:stone")

-- Remove torch from torches => remise des torches par défaut
minetest.register_alias("torches:floor", "default:torch")
minetest.register_alias("torches:wand", "default:torch")

-- Remove copper_rail from moreores => utilisation des rail_copper du mod carts
minetest.register_alias("moreores:copper_rail", "carts:rail_copper")

