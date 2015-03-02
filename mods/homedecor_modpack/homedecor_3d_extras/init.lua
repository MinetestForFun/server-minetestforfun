minetest.override_item("default:bookshelf", {
	drawtype = "mesh",
	mesh = "3dbookshelf.obj",
	tiles = { "3dbookshelf.png"	},
	paramtype = "light",
	paramtype2 = "facedir",
})

if minetest.get_modpath("moreblocks") then
	minetest.override_item("moreblocks:empty_bookshelf", {
		drawtype = "nodebox",
		tiles = {
			"3dbookshelf_top.png",
			"3dbookshelf_bottom.png",
			"3dbookshelf_sides.png",
			"3dbookshelf_sides.png",
			"3dbookshelf_fb_empty.png",
			"3dbookshelf_fb_empty.png"
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

