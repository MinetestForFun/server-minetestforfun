multitest = {}

multitest.colors = {"black", "blue", "brown", "cyan", "dark_green",
"dark_grey", "green", "grey", "magenta", "orange",
"pink", "red", "violet", "white", "yellow"}

multitest.colornames = {"Black", "Blue", "Brown", "Cyan", "Dark Green",
"Dark Grey", "Green", "Grey", "Magenta", "Orange",
"Pink", "Red", "Violet", "White", "Yellow"}

dofile(minetest.get_modpath("multitest").."/crafts.lua")
dofile(minetest.get_modpath("multitest").."/craftitems.lua")
dofile(minetest.get_modpath("multitest").."/nodes.lua")
dofile(minetest.get_modpath("multitest").."/fuel.lua")

--[[minetest.register_tool("multitest:shears", {
    description = "Shears",
    inventory_image = "multitest_shears.png",
    tool_capabilities = {
        max_drop_level=3,
        groupcaps= {
            crumbly={times={[1]=5.00, [2]=3.50, [3]=3.00}, uses=80, maxlevel=1}
        }
    }
})

minetest.register_tool("multitest:wood_shears", {
    description = "Wood Shears",
    inventory_image = "multitest_wood_shears.png",
    tool_capabilities = {
        max_drop_level=3,
        groupcaps= {
            crumbly={times={[1]=3.00, [2]=2.50, [3]=1.00}, uses=40, maxlevel=1}
        }
    }
})

minetest.register_tool("multitest:stone_shears", {
    description = "Stone Shears",
    inventory_image = "multitest_stone_shears.png",
    tool_capabilities = {
        max_drop_level=3,
        groupcaps= {
            crumbly={times={[1]=4.00, [2]=3.00, [3]=1.50}, uses=50, maxlevel=1}
        }
    }
})]]--

minetest.register_tool("multitest:scraper", {
    description = "Scraper",
    inventory_image = "multitest_scraper.png",
    tool_capabilities = {
        max_drop_level=3,
        groupcaps= {
        }
    }
})
