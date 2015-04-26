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

if minetest.get_modpath("vessels") and minetest.registered_nodes["vessels:shelf"] then
	minetest.override_item("vessels:shelf", {
		drawtype = "mesh",
		mesh = "3dvesselshelf.obj",
		tiles = {
			"default_wood.png",
			"default_wood.png^3dbookshelf_inside_back.png",
			"3dvesselshelf_glass.png",
		},
		use_texture_alpha = true,
		paramtype = "light",
		paramtype2 = "facedir",
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

