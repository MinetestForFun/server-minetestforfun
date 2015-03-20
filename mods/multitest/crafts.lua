--[[minetest.register_craft({
    output = "multitest:shears",
    recipe = {
        {"default:steel_ingot", "", "default:steel_ingot"},
        {"", "default:wood", ""},
        {"multitest:handle_grip", "", "multitest:handle_grip"}
    }
})

minetest.register_craft({
    output = "multitest:wood_shears",
    recipe = {
        {"default:tree", "", "default:tree"},
        {"", "default:wood", ""},
        {"multitest:handle_grip", "", "multitest:handle_grip"}
    }
})

minetest.register_craft({
    output = "multitest:stone_shears",
    recipe = {
        {"default:cobble", "", "default:cobble"},
        {"", "default:wood", ""},
        {"multitest:handle_grip", "", "multitest:handle_grip"}
    }
})]]--

minetest.register_craft({
        output = "multitest:rubber_raw 4",
        recipe = {
        {"default:clay_lump", "default:papyrus", "default:clay_lump"},
        {"default:papyrus", "bucket:bucket_water", "default:papyrus"},
        {"default:clay_lump", "default:papyrus", "default:clay_lump"},
    },
    replacements = {{ "bucket:bucket_water", "bucket:bucket_empty" }}
})

minetest.register_craft({
	type = "cooking",
	recipe = "multitest:rubber_raw",
	output = "multitest:rubber",
})

minetest.register_craft({
    output = "multitest:handle_grip 2",
    recipe = {
        {"", "", ""},
        {"multitest:rubber", "multitest:rubber", "multitest:rubber"},
        {"", "", ""}
    }
})

minetest.register_craft({
    type = "cooking",
    recipe = "multitest:blackcobble",
    output = "multitest:blackstone",
})

minetest.register_craft({
    output = "multitest:rubberblock",
    recipe = {
        {"multitest:rubber", "multitest:rubber", ""},
        {"multitest:rubber", "multitest:rubber", ""},
        {"", "", ""}
    }
})

minetest.register_craft({
    output = "multitest:scraper",
    recipe = {
        {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
        {"", "default:steel_ingot", ""},
        {"", "multitest:handle_grip", ""}
    }
})

minetest.register_craft({
        output = "multitest:blackstone_paved",
        recipe = {
        {"multitest:scraper", "multitest:blackstone", ""},
        {"", "", ""},
        {"", "", ""},
    },
    replacements = {{ "multitest:scraper", "multitest:scraper" }}
})

minetest.register_craft({
        output = "multitest:rubber 4",
        recipe = {
        {"multitest:rubberblock", "", ""},
        {"", "", ""},
        {"", "", ""},
    },
})

minetest.register_craft({
        output = "multitest:blackstone",
        recipe = {
        {"default:stone", "default:stone", "default:stone"},
        {"default:stone", "dye:black", "default:stone"},
        {"default:stone", "default:stone", "default:stone"},
    },
})

minetest.register_craft({
        output = "multitest:blackstone_brick",
        recipe = {
        {"multitest:blackstone", "multitest:blackstone", ""},
        {"multitest:blackstone", "multitest:blackstone", ""},
        {"", "", ""},
    },
})

--[[ maintenant dans farming redo
minetest.register_craft({
        output = "multitest:hayblock 4",
        recipe = {
        {"farming:wheat", "farming:wheat", "farming:wheat"},
        {"farming:wheat", "farming:wheat", "farming:wheat"},
        {"farming:wheat", "farming:wheat", "farming:wheat"},
    },
})
--]]

minetest.register_craft({
        output = "multitest:checkered_floor",
        recipe = {
        {"default:stone", "multitest:blackstone", ""},
        {"multitest:blackstone", "default:stone", ""},
        {"", "", ""},
    },
})

minetest.register_craft({
        output = "multitest:checkered_floor",
        recipe = {
        {"multitest:blackstone", "default:stone", ""},
        {"default:stone", "multitest:blackstone", ""},
        {"", "", ""},
    },
})

minetest.register_craft({
        output = "multitest:checkered_floor",
        recipe = {
        {"multitest:blackstone", "default:stone", ""},
        {"default:stone", "multitest:blackstone", ""},
        {"", "", ""},
    },
})

for i, v in ipairs(multitest.colors) do
    minetest.register_craft({
        output = "multitest:carpet_"..v.." 4",
        recipe = {
            {"wool:"..v, "wool:"..v, ""},
            {"", "", ""},
            {"", "", ""},
        },
    })
end

minetest.register_craft({
        output = "multitest:lamp",
        recipe = {
        {"", "default:tree", ""},
        {"default:tree", "default:torch", "default:tree"},
        {"", "default:tree", ""},
    },
})

minetest.register_craft({
        output = "multitest:door_mat",
        recipe = {
        {"wool:black", "wool:black", "wool:black"},
        {"wool:black", "wool:brown", "wool:black"},
        {"wool:black", "wool:black", "wool:black"},
    },
})

minetest.register_craft({
        output = "multitest:andesite 4",
        recipe = {
        {"default:stone", "default:stone", "default:stone"},
        {"default:cobble", "default:cobble", "default:cobble"},
        {"default:stone", "default:stone", "default:stone"},
    },
})

minetest.register_craft({
        output = "multitest:andesite_smooth",
        recipe = {
        {"multitest:andesite", "multitest:scraper", ""},
        {"", "", ""},
        {"", "", ""},
    },
    replacements = {{ "multitest:scraper", "multitest:scraper" }}
})

minetest.register_craft({
        output = "multitest:granite 4",
        recipe = {
        {"multitest:andesite", "default:bronze_ingot", ""},
        {"", "", ""},
        {"", "", ""},
    },
})

minetest.register_craft({
        output = "multitest:granite_smooth",
        recipe = {
        {"multitest:granite", "multitest:scraper", ""},
        {"", "", ""},
        {"", "", ""},
    },
    replacements = {{ "multitest:scraper", "multitest:scraper" }}
})

minetest.register_craft({
        output = "multitest:diorite 4",
        recipe = {
        {"multitest:andesite", "default:clay_lump", ""},
        {"", "", ""},
        {"", "", ""},
    },
})

minetest.register_craft({
        output = "multitest:diorite_smooth",
        recipe = {
        {"multitest:diorite", "multitest:scraper", ""},
        {"", "", ""},
        {"", "", ""},
    },
    replacements = {{ "multitest:scraper", "multitest:scraper" }}
})

minetest.register_craft({
        output = "multitest:diorite",
        recipe = {
        {"multitest:diorite_smooth", "", ""},
        {"", "", ""},
        {"", "", ""},
    },
})

minetest.register_craft({
        output = "multitest:granite",
        recipe = {
        {"multitest:granite_smooth", "", ""},
        {"", "", ""},
        {"", "", ""},
    },
})

minetest.register_craft({
        output = "multitest:andesite",
        recipe = {
        {"multitest:andesite_smooth", "", ""},
        {"", "", ""},
        {"", "", ""},
    },
})

minetest.register_craft({
        output = "multitest:sandstone_carved",
        recipe = {
        {"default:sandstone", "multitest:scraper", ""},
        {"", "", ""},
        {"", "", ""},
    },
    replacements = {{ "multitest:scraper", "multitest:scraper" }}
})

minetest.register_craft({
        output = "multitest:sponge_block 4",
        recipe = {
        {"", "dye:yellow", ""},
        {"", "wool:white", ""},
        {"", "farming:wheat", ""},
    },
})
