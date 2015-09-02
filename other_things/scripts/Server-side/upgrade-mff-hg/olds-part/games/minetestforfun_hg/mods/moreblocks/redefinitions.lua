--[[
More Blocks: redefinitions of default stuff

Copyright (c) 2011-2015 Calinou and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- Redefinitions of some default nodes
-- ===================================

-- Let there be light. This makes some nodes let light pass through:
minetest.override_item("default:ladder", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:sapling", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:dry_shrub", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:papyrus", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:fence_wood", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:junglegrass", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:junglesapling", {
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.override_item("default:grass_1", {
	inventory_image = "default_grass_3.png", -- Use a bigger inventory image.
	wield_image = "default_grass_3.png",
	paramtype = "light",
	sunlight_propagates = true,
})

for i = 2, 5 do
	minetest.override_item("default:grass_" ..i, {
		paramtype = "light",
		sunlight_propagates = true,
	})
end
