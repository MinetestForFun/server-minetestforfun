--[[

Crafting Sections (in order, top to bottom):
	1. Fuel
	2. Cooking
	3. Crafting and Recycling

The crafting recipe for the sled is in the sled.lua file.

~ LazyJ

--]]

-- 1. Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "snow:needles",
	burntime = 1,
})



minetest.register_craft({
	type = "fuel",
	recipe = "snow:sapling_pine",
	burntime = 10,
})



minetest.register_craft({
	type = "fuel",
	recipe = "snow:needles_decorated",
	burntime = 1,
})



minetest.register_craft({
	type = "fuel",
	recipe = "snow:xmas_tree",
	burntime = 10,
})



-- 2. Cooking

--[[
"Cooks_into_ice" is a custom group I assigned to full-sized, snow-stuff nodes
(snow bricks, snow cobble, snow blocks, etc.) so I wouldn't have to write an individual cooking
recipe for each one.

~ LazyJ
--]]

minetest.register_craft({
	type = "cooking",
	cooktime = 12,
	output = "default:ice",
	recipe = "group:cooks_into_ice",
})






-- 3. Crafting and Recycling

-- Let's make moss craftable so players can more easily create mossycobble and
-- gives another useful purpose to pine needles. ~ LazyJ

minetest.register_craft({
    output = 'snow:moss',
    recipe = {
        {'snow:needles', 'snow:needles'},
        {'snow:needles', 'snow:needles'},
    },
})


--[[
Most snow biomes are too small to provide enough snow as a building material and
still have enough landscape snow to create the wintry surroundings of a
snow village or castle. So I added this snowblock crafting recipe as a way for
players to increase their snow supply in small increments. I considered making
the output 9 but that would make it all too quick and easy (especially for griefers) to create lots
of snowblocks (and then use them to water-grief by melting the snow blocks).

~ LazyJ

--]]

minetest.register_craft({
	type = "shapeless",
	output = 'default:snowblock 2',
	recipe = {
		'snow:snow_cobble',
		'snow:snow_cobble'
		}
})



--[[minetest.register_craft({
	type = "shapeless",
	output = 'default:snowblock 3',
	recipe = {
		'default:snowblock',
		'default:snowblock'
		}
})]]



minetest.register_craft({
    output = 'snow:snow_brick',
    recipe = {
        {'default:snowblock', 'default:snowblock'},
        {'default:snowblock', 'default:snowblock'}
    }
})

--Craft icy snow.
minetest.register_craft({
	type = "shapeless",
	output = 'snow:snow_cobble 6',
	recipe = {
		'default:snow',
		'default:snow',
		'default:snow',
		'default:snow',
		'default:snow',
		'default:snow',
		'default:ice',
		'default:ice',
		'default:ice'
		}
})


minetest.register_craft({
	type = "shapeless",
	output = 'snow:snow_cobble 4',
	recipe = {
		'default:snow',
		'default:snow',
		'default:snow',
		'default:snow',
		'default:ice',
		'default:ice'
		}
})

minetest.register_craft({
	type = "shapeless",
	output = 'snow:snow_cobble 2',
	recipe = {
		'default:snow',
		'default:snow',
		'default:ice'
		}
})

minetest.register_craft({
	type = "shapeless",
	output = 'snow:snow_cobble',
	recipe = {
		'default:snow',
		'default:ice'
		}
})


-- Why not recycle snow_bricks back into snowblocks? ~ LazyJ
minetest.register_craft({
    output = 'default:snowblock 4',
    recipe = {
        {'snow:snow_brick'}
    }
})



-- Recycle basic, half-block, slabs back into full blocks

-- A little "list" magic here. Instead of writing four crafts I only have to write two. ~ LazyJ
local recycle_default_slabs = {
	"ice",
	"snowblock",
}

for _, name in pairs(recycle_default_slabs) do
	local subname_default = name

	-- This craft is for default snowblocks and default ice.
	-- 1 crafting recipe handles 2, default blocks. ~ LazyJ
	minetest.register_craft({
		type = "shapeless",
		output = "default:"..subname_default,
		recipe = {
			"snow:slab_"..subname_default,
			"snow:slab_"..subname_default,
		}
	})
end



-- Similar list magic here too. I couldn't successfully combine these in the first list
-- because we are dealing with slabs/blocks from two different mods, the "Snow" mod and
-- minetest_game's "Default" mod. ~ LazyJ

local recycle_snowmod_slabs = {
	"snow_brick",
	"snow_cobble",
}

for _, name in pairs(recycle_snowmod_slabs) do
	local subname_snowmod = name

	-- This craft is for the Snow mod's full-sized blocks.
	-- 1 crafting recipe handles 2, or more, Snow mod blocks. ~ LazyJ
	minetest.register_craft({
		type = "shapeless",
		output = "snow:"..subname_snowmod,
		recipe = {
			"snow:slab_"..subname_snowmod,
			"snow:slab_"..subname_snowmod,
		}
	})
end
