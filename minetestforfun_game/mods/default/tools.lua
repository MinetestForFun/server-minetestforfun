-- mods/default/tools.lua

-- The hand
minetest.register_item(":", {
	type = "none",
	wield_image = "wieldhand.png",
	range = 5,
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times = {[2] = 2.75, [3] = 0.65}, uses = 0, maxlevel = 1},
			snappy = {times = {[3] = 0.25}, uses = 0, maxlevel = 1},
			oddly_breakable_by_hand = {times = {[1] = 3.50, [2] = 2.00, [3] = 0.65}, uses = 0}
		},
		damage_groups = {fleshy = 2},
	}
})

--
-- Picks
--

minetest.register_tool("default:pick_wood", {
	description = "Wooden Pickaxe",
	inventory_image = "default_tool_woodpick.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 0,
		groupcaps = {
			cracky = {times = {[1] = 6.5, [2] = 2.0, [3] = 1.2}, uses = 20, maxlevel = 1},
		},
		damage_groups = {fleshy = 3},
	},
})
minetest.register_tool("default:pick_stone", {
	description = "Stone Pickaxe",
	inventory_image = "default_tool_stonepick.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 0,
		groupcaps = {
			cracky = {times = {[1] = 5.5, [2] = 1.6, [3] = 0.9}, uses = 20, maxlevel = 1},
			crumbly = {times = {[1] = 2.6, [2] = 1.4, [3] = 0.44}, uses = 20, maxlevel = 1},
		},
		damage_groups = {fleshy = 3},
	},
})
minetest.register_tool("default:pick_steel", {
	description = "Steel Pickaxe",
	inventory_image = "default_tool_steelpick.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 1,
		groupcaps = {
			cracky = {times = {[1] = 4.0, [2] = 1.3, [3] = 0.85}, uses = 20, maxlevel = 2},
			crumbly = {times = {[1] = 2.4, [2] = 1.2, [3] = 0.39}, uses = 20, maxlevel = 1},
		},
		damage_groups = {fleshy = 4},
	},
})
minetest.register_tool("default:pick_bronze", {
	description = "Bronze Pickaxe",
	inventory_image = "default_tool_bronzepick.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 1,
		groupcaps = {
			cracky = {times = {[1] = 4.0, [2] = 1.3, [3] = 0.85}, uses = 30, maxlevel = 2},
			crumbly = {times = {[1] = 2.4, [2] = 1.2, [3] = 0.39}, uses = 30, maxlevel = 1},
		},
		damage_groups = {fleshy = 4},
	},
})
minetest.register_tool("default:pick_gold", {
	description = "Golden Pickaxe",
	inventory_image = "default_tool_goldpick.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 3,
		groupcaps = {
			cracky = {times = {[1] = 2.4, [2] = 1.0, [3] = 0.65}, uses = 5, maxlevel = 3},
			crumbly = {times = {[1] = 2.0, [2] = 0.9, [3] = 0.36}, uses = 5, maxlevel = 2},
		},
		damage_groups = {fleshy = 5},
	},
})
minetest.register_tool("default:pick_diamond", {
	description = "Diamond Pickaxe",
	inventory_image = "default_tool_diamondpick.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 3,
		groupcaps = {
			cracky = {times = {[1] = 2.4, [2] = 1.0, [3] = 0.65}, uses = 25, maxlevel = 3},
			crumbly = {times = {[1] = 2.0, [2] = 0.9, [3] = 0.36}, uses = 25, maxlevel = 2},
		},
		damage_groups = {fleshy = 5},
	},
})
minetest.register_tool("default:pick_nyan", {
	description = "Nyan Pickaxe",
	inventory_image = "default_tool_nyanpick.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 3,
		groupcaps = {
			cracky = {times = {[1] = 2.4, [2] = 1.0, [3] = 0.65}, uses = 75, maxlevel = 3},
			crumbly = {times = {[1] = 2.0, [2] = 0.9, [3] = 0.36}, uses = 75, maxlevel = 2},
		},
		damage_groups = {fleshy = 5},
	},
})
minetest.register_tool("default:pick_mese", {
	description = "Mese Pickaxe",
	inventory_image = "default_tool_mesepick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 3,
		groupcaps = {
			cracky = {times = {[1] = 1.8, [2] = 0.75, [3] = 0.45}, uses = 15, maxlevel = 3},
			crumbly = {times = {[1] = 1.65, [2] = 0.6, [3] = 0.32}, uses = 15, maxlevel = 3},
		},
		damage_groups = {fleshy = 5},
	},
})

--
-- Shovels
--

minetest.register_tool("default:shovel_wood", {
	description = "Wooden Shovel",
	inventory_image = "default_tool_woodshovel.png",
	wield_image = "default_tool_woodshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times = {[1] = 2.6, [2] = 1.4, [3] = 0.44}, uses = 20, maxlevel = 1},
		},
		damage_groups = {fleshy = 2},
	},
})
minetest.register_tool("default:shovel_stone", {
	description = "Stone Shovel",
	inventory_image = "default_tool_stoneshovel.png",
	wield_image = "default_tool_stoneshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times = {[1] = 2.4, [2] = 1.2, [3] = 0.39}, uses = 20, maxlevel = 1},
		},
		damage_groups = {fleshy = 3},
	},
})
minetest.register_tool("default:shovel_steel", {
	description = "Steel Shovel",
	inventory_image = "default_tool_steelshovel.png",
	wield_image = "default_tool_steelshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 1,
		groupcaps = {
			crumbly = {times = {[1] = 2.0, [2] = 0.9, [3] = 0.36}, uses = 30, maxlevel = 2},
		},
		damage_groups = {fleshy = 3},
	},
})
minetest.register_tool("default:shovel_bronze", {
	description = "Bronze Shovel",
	inventory_image = "default_tool_bronzeshovel.png",
	wield_image = "default_tool_bronzeshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 1,
		groupcaps = {
			crumbly = {times = {[1] = 2.0, [2] = 0.9, [3] = 0.36}, uses = 40, maxlevel = 2},
		},
		damage_groups = {fleshy = 3},
	},
})
minetest.register_tool("default:shovel_gold", {
	description = "Golden Shovel",
	inventory_image = "default_tool_goldshovel.png",
	wield_image = "default_tool_goldshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 1,
		groupcaps = {
			crumbly = {times = {[1] = 1.65, [2] = 0.6, [3] = 0.32}, uses = 5, maxlevel = 3},
		},
		damage_groups = {fleshy = 4},
	},
})
minetest.register_tool("default:shovel_diamond", {
	description = "Diamond Shovel",
	inventory_image = "default_tool_diamondshovel.png",
	wield_image = "default_tool_diamondshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 1,
		groupcaps = {
			crumbly = {times = {[1] = 1.65, [2] = 0.6, [3] = 0.32}, uses = 25, maxlevel = 3},
		},
		damage_groups = {fleshy = 4},
	},
})
minetest.register_tool("default:shovel_nyan", {
	description = "Nyan Shovel",
	inventory_image = "default_tool_nyanshovel.png",
	wield_image = "default_tool_nyanshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 1,
		groupcaps = {
			crumbly = {times = {[1] = 1.65, [2] = 0.6, [3] = 0.32}, uses = 75, maxlevel = 3},
		},
		damage_groups = {fleshy = 4},
	},
})
minetest.register_tool("default:shovel_mese", {
	description = "Mese Shovel",
	inventory_image = "default_tool_meseshovel.png",
	wield_image = "default_tool_meseshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 3,
		groupcaps = {
			crumbly = {times = {[1] = 1.25, [2] = 0.45, [3] = 0.26}, uses = 15, maxlevel = 3},
		},
		damage_groups = {fleshy = 4},
	},
})

--
-- Axes
--

minetest.register_tool("default:axe_wood", {
	description = "Wooden Axe",
	inventory_image = "default_tool_woodaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 0,
		groupcaps = {
			choppy = {times = {[2] = 2.0, [3] = 1.3}, uses = 20, maxlevel = 1},
			snappy = {times = {[3] = 0.2}, uses = 0, maxlevel = 1},
		},
		damage_groups = {fleshy = 3},
	},
})
minetest.register_tool("default:axe_stone", {
	description = "Stone Axe",
	inventory_image = "default_tool_stoneaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 0,
		groupcaps = {
			choppy = {times = {[1] = 3.0, [2] = 1.6, [3] = 1.1}, uses = 20, maxlevel = 1},
			snappy = {times = {[3] = 0.175}, uses = 0, maxlevel = 1},
		},
		damage_groups = {fleshy = 4},
	},
})
minetest.register_tool("default:axe_steel", {
	description = "Steel Axe",
	inventory_image = "default_tool_steelaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 1,
		groupcaps = {
			choppy = {times = {[1] = 2.5, [2] = 1.3, [3] = 0.9}, uses = 20, maxlevel = 2},
			snappy = {times = {[3] = 0.15}, uses = 0, maxlevel = 1},
		},
		damage_groups = {fleshy = 5},
	},
})
minetest.register_tool("default:axe_bronze", {
	description = "Bronze Axe",
	inventory_image = "default_tool_bronzeaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 1,
		groupcaps = {
			choppy = {times = {[1] = 2.5, [2] = 1.3, [3] = 0.9}, uses = 30, maxlevel = 2},
			snappy = {times = {[3] = 0.15}, uses = 0, maxlevel = 1},
		},
		damage_groups = {fleshy = 5},
	},
})
minetest.register_tool("default:axe_gold", {
	description = "Golden Axe",
	inventory_image = "default_tool_goldaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 1,
		groupcaps = {
			choppy = {times = {[1] = 2.2, [2] = 1.0, [3] = 0.55}, uses = 5, maxlevel = 3},
			snappy = {times = {[3] = 0.125}, uses = 0, maxlevel = 1},
		},
		damage_groups = {fleshy = 6},
	},
})
minetest.register_tool("default:axe_diamond", {
	description = "Diamond Axe",
	inventory_image = "default_tool_diamondaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 1,
		groupcaps = {
			choppy = {times = {[1] = 2.2, [2] = 1.0, [3] = 0.55}, uses = 25, maxlevel = 3},
			snappy = {times = {[3] = 0.125}, uses = 0, maxlevel = 1},
		},
		damage_groups = {fleshy = 6},
	},
})
minetest.register_tool("default:axe_nyan", {
	description = "Nyan Axe",
	inventory_image = "default_tool_nyanaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level = 1,
		groupcaps = {
			choppy = {times = {[1] = 2.2, [2] = 1.0, [3] = 0.55}, uses = 75, maxlevel = 3},
			snappy = {times = {[3] = 0.125}, uses = 0, maxlevel = 1},
		},
		damage_groups = {fleshy = 6},
	},
})
minetest.register_tool("default:axe_mese", {
	description = "Mese Axe",
	inventory_image = "default_tool_meseaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 1,
		groupcaps = {
			choppy = {times = {[1] = 1.5, [2] = 0.75, [3] = 0.4}, uses = 15, maxlevel = 3},
			snappy = {times = {[3] = 0.1}, uses = 0, maxlevel = 1},
		},
		damage_groups = {fleshy = 6},
	},
})

--
-- Swords
--

minetest.register_tool("default:sword_wood", {
	description = "Wooden Sword",
	inventory_image = "default_tool_woodsword.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
			snappy = {times = {[2] = 1.4, [3] = 0.2}, uses = 20, maxlevel = 1},
		},
		damage_groups = {fleshy = 3},
	}
})
minetest.register_tool("default:sword_stone", {
	description = "Stone Sword",
	inventory_image = "default_tool_stonesword.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
			snappy = {times = {[2] = 1.2, [3] = 0.175}, uses = 20, maxlevel = 1},
		},
		damage_groups = {fleshy = 4},
	}
})
minetest.register_tool("default:sword_steel", {
	description = "Steel Sword",
	inventory_image = "default_tool_steelsword.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 1,
		groupcaps = {
			snappy = {times = {[1] = 2.2, [2] = 1.2, [3] = 0.15}, uses = 30, maxlevel = 2},
		},
		damage_groups = {fleshy = 5},
	}
})
minetest.register_tool("default:sword_bronze", {
	description = "Bronze Sword",
	inventory_image = "default_tool_bronzesword.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 1,
		groupcaps = {
			snappy = {times = {[1] = 2.2, [2] = 1.2, [3] = 0.15}, uses = 40, maxlevel = 2},
		},
		damage_groups = {fleshy = 5},
	}
})
minetest.register_tool("default:sword_gold", {
	description = "Golden Sword",
	inventory_image = "default_tool_goldsword.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 1,
		groupcaps = {
			snappy = {times = {[1] = 1.9, [2] = 0.85, [3] = 0.125}, uses = 5, maxlevel = 3},
		},
		damage_groups = {fleshy = 6},
	}
})
minetest.register_tool("default:sword_diamond", {
	description = "Diamond Sword",
	inventory_image = "default_tool_diamondsword.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 1,
		groupcaps = {
			snappy = {times = {[1] = 1.9, [2] = 0.85, [3] = 0.125}, uses = 25, maxlevel = 3},
		},
		damage_groups = {fleshy = 6},
	}
})
minetest.register_tool("default:sword_nyan", {
	description = "Nyan Sword",
	inventory_image = "default_tool_nyansword.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 1,
		groupcaps = {
			snappy = {times = {[1] = 1.9, [2] = 0.85, [3] = 0.125}, uses = 75, maxlevel = 3},
		},
		damage_groups = {fleshy = 6},
	}
})
minetest.register_tool("default:sword_mese", {
	description = "Mese Sword",
	inventory_image = "default_tool_mesesword.png",
	tool_capabilities = {
		full_punch_interval = 0.675,
		max_drop_level = 1,
		groupcaps = {
			snappy = {times = {[1] = 1.5, [2] = 0.7, [3] = 0.1}, uses = 15, maxlevel = 3},
		},
		damage_groups = {fleshy = 6},
	}
})
