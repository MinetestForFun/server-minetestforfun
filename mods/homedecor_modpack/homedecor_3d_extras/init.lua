minetest.override_item("default:bookshelf", {
	drawtype = "mesh",
	mesh = "3dbookshelf.obj",
	tiles = {
		"default_wood.png",
		"default_wood.png^3dbookshelf_inside_back.png",
		"3dbookshelf_books.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
})

if minetest.get_modpath("vessels")
 and minetest.registered_nodes["vessels:shelf"]
 and minetest.registered_nodes["vessels:glass_bottle"]
 and minetest.registered_nodes["vessels:drinking_glass"] then

	minetest.override_item("vessels:shelf", {
		drawtype = "mesh",
		mesh = "3dvessels_shelf.obj",
		tiles = {
			"default_wood.png",
			"default_wood.png^3dbookshelf_inside_back.png",
			"3dvessels_shelf_glass.png",
		},
		paramtype = "light",
		paramtype2 = "facedir",
		use_texture_alpha = true
	})
	
	local sbox = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, -0.1, 0.15 }
	}

	minetest.override_item("vessels:glass_bottle", {
		drawtype = "mesh",
		mesh = "3dvessels_bottle.obj",
		tiles = {"3dvessels_shelf_glass.png"},
		inventory_image = "3dvessels_glass_bottle_inv.png",
		wield_image = "3dvessels_glass_bottle_inv.png",
		use_texture_alpha = true,
		selection_box = sbox
	})

	minetest.override_item("vessels:steel_bottle", {
		drawtype = "mesh",
		mesh = "3dvessels_bottle_steel.obj",
		tiles = {"bottle_metal_bright.png"},
		inventory_image = "3dvessels_steel_bottle_inv.png",
		wield_image = "3dvessels_steel_bottle_inv.png",
		selection_box = sbox
	})

	minetest.override_item("vessels:drinking_glass", {
		drawtype = "mesh",
		mesh = "3dvessels_drink.obj",
		tiles = {"3dvessels_shelf_glass.png"},
		inventory_image = "3dvessels_drinking_glass_inv.png",
		wield_image = "3dvessels_drinking_glass_inv.png",
		use_texture_alpha = true,
		selection_box = sbox
	})
end

if minetest.get_modpath("moreblocks") then
	minetest.override_item("moreblocks:empty_bookshelf", {
		drawtype = "nodebox",
		tiles = {
			"default_wood.png^[transformR180",
			"default_wood.png",
			"default_wood.png^[transformR90",
			"default_wood.png^[transformR270",
			"default_wood.png^3dbookshelf_inside_back.png",
			"default_wood.png^3dbookshelf_inside_back.png"
		},
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875},
				{-0.5, -0.5, -0.5, -0.4375, 0.5, 0.5},
				{0.4375, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
				{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
				{-0.5, -0.0625, -0.5, 0.5, 0.0625, 0.5},
			}
		}
	})
end

