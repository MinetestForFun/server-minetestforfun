-- Various kinds of shingles

local S = homedecor.gettext

-- Corner shingle nodes, courtesy Bas080

homedecor.register_outer_corner = function(modname, subname, groups, images, description)
	local slopeboxedge = {}
	local detail = homedecor.detail_level
	for i = 0, detail-1 do
		slopeboxedge[i+1]={-0.5, -0.5, (i/detail)-0.5, 0.5-(i/detail), (i/detail)-0.5+(1.25/detail), 0.5}
	end
	minetest.register_node(modname..":shingle_outer_corner_" .. subname, {
		description = S(description.. " (outer corner)"),
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = true,
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5,  -0.5,  -0.5,   0.5, -0.25, 0.5},
				{-0.5, -0.25, -0.25,  0.25,     0, 0.5},
				{-0.5,     0,     0,     0,  0.25, 0.5},
				{-0.5,  0.25,  0.25, -0.25,   0.5, 0.5}
			}
		},
		node_box = {
			type = "fixed",
			fixed = slopeboxedge
		},
		groups = groups,
	})
end

homedecor.register_inner_corner = function(modname, subname, groups, images, description)
	local slopeboxedge = {}
	local detail = homedecor.detail_level
	for i = 0, detail-1 do
		slopeboxedge[i+1]={-0.5, -0.5, -0.5, 0.5-(i/detail), (i/detail)-0.5+(1.25/detail), 0.5}
		slopeboxedge[i+detail+1]={-0.5, -0.5, (i/detail)-0.5, 0.5, (i/detail)-0.5+(1.25/detail), 0.5}
	end
	minetest.register_node(modname..":shingle_inner_corner_" .. subname, {
		description = S(description.. " (inner corner)"),
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
		},
		node_box = {
			type = "fixed",
			fixed = slopeboxedge
		},
		groups = groups,
	})
end

homedecor.register_slope = function(modname, subname, recipeitem, groups, images, description)
	local slopeboxedge = {}
	local detail = homedecor.detail_level
	for i = 0, detail-1 do
		slopeboxedge[i+1]={-0.5, -0.5, (i/detail)-0.5, 0.5, (i/detail)-0.5+(1.25/detail), 0.5}
	end
	minetest.register_node(modname..":shingle_side_" .. subname, {
		description = S(description),
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = true,
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5,  -0.5,  -0.5, 0.5, -0.25, 0.5},
				{-0.5, -0.25, -0.25, 0.5,     0, 0.5},
				{-0.5,     0,     0, 0.5,  0.25, 0.5},
				{-0.5,  0.25,  0.25, 0.5,   0.5, 0.5}
			}
		},
		node_box = {
			type = "fixed",
			fixed = slopeboxedge,
		},
		groups = groups,
	})

	-- convert between flat shingles and slopes

	minetest.register_craft({
		output = modname..":shingle_side_"..subname.." 3",
		recipe = {
			{recipeitem, recipeitem, recipeitem}
		}
	})

	minetest.register_craft({
		output = recipeitem.." 3",
		recipe = {
			{modname..":shingle_side_"..subname, modname..":shingle_side_"..subname, modname..":shingle_side_"..subname},
		}
	})

	-- craft outer corners

	minetest.register_craft({
		output = modname..":shingle_outer_corner_"..subname.." 3",
		recipe = {
			{ "", recipeitem, "" },
			{ recipeitem, "", recipeitem }
		}
	})

	minetest.register_craft({
		output = modname..":shingle_outer_corner_"..subname.." 3",
		recipe = {
			{ "", modname..":shingle_side_"..subname, "" },
			{ modname..":shingle_side_"..subname, "", modname..":shingle_side_"..subname },
		}
	})

	-- craft inner corners

	minetest.register_craft({
		output = modname..":shingle_inner_corner_"..subname.." 3",
		recipe = {
			{recipeitem, recipeitem},
			{"", recipeitem}
		}
	})

	minetest.register_craft({
		output = modname..":shingle_inner_corner_"..subname.." 3",
		recipe = {
			{modname..":shingle_side_"..subname, modname..":shingle_side_"..subname},
			{"", modname..":shingle_side_"..subname}
		}
	})
	-- convert between flat shingles and inner/outer corners

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem.." 1",
		recipe = { modname..":shingle_outer_corner_"..subname }
	})

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem.." 1",
		recipe = { modname..":shingle_inner_corner_"..subname }
	})
end

minetest.register_craft( {
	output = "homedecor:shingle_side_glass",
	recipe = {
		{ "homedecor:skylight", "homedecor:skylight", "homedecor:skylight" }
	}
})

minetest.register_craft( {
	output = "homedecor:roof_tile_terracotta 8",
	recipe = {
		{ "homedecor:shingle_outer_corner_terracotta", "homedecor:shingle_outer_corner_terracotta" }
	}
})

minetest.register_craft( {
	output = "homedecor:roof_tile_terracotta 8",
	recipe = {
		{ "homedecor:shingle_inner_corner_terracotta", "homedecor:shingle_inner_corner_terracotta" }
	}
})

minetest.register_craft( {
	output = "homedecor:roof_tile_terracotta 8",
	recipe = {
		{ "homedecor:shingle_side_terracotta", "homedecor:shingle_side_terracotta" }
	}
})

minetest.register_craft({
    type = "fuel",
    recipe = "homedecor:shingle_inner_corner_wood",
    burntime = 30,
})

minetest.register_craft({
    type = "fuel",
    recipe = "homedecor:shingle_outer_corner_wood",
    burntime = 30,
})

minetest.register_craft({
    type = "fuel",
    recipe = "homedecor:shingle_side_wood",
	burntime = 30,
})

homedecor.register_roof = function(modname, subname, groups, images , description)
	homedecor.register_outer_corner(modname, subname, groups, images, description)
	homedecor.register_inner_corner(modname, subname, groups, images, description)
end

-- corners

homedecor.register_roof("homedecor", "wood",
	{ snappy = 3 },
	{
		"homedecor_shingles_wood_c_t.png",
		"homedecor_shingles_wood_c_x.png",
		"homedecor_shingles_wood_c_x.png",
		"homedecor_shingles_wood_c_x.png",
		"homedecor_shingles_wood_c_z.png",
		"homedecor_shingles_wood_c_z.png",
	},
	"Wood Shingles"
)

homedecor.register_roof("homedecor", "asphalt",
	{ snappy = 3 },
	{
		"homedecor_shingles_asphalt_c_t.png",
		"homedecor_shingles_asphalt_c_x.png",
		"homedecor_shingles_asphalt_c_x.png",
		"homedecor_shingles_asphalt_c_x.png",
		"homedecor_shingles_asphalt_c_z.png",
		"homedecor_shingles_asphalt_c_z.png",
	},
	"Asphalt Shingles"
)

homedecor.register_roof("homedecor", "terracotta",
	{ snappy = 3 },
	{
		"homedecor_shingles_terracotta_c_t.png",
		"homedecor_shingles_terracotta_c_x.png",
		"homedecor_shingles_terracotta_c_x.png",
		"homedecor_shingles_terracotta_c_x.png",
		"homedecor_shingles_terracotta_c_z.png",
		"homedecor_shingles_terracotta_c_z.png",
	},
	"Terracotta Shingles"
)

-- register just the slopes

homedecor.register_slope("homedecor", "wood",
	"homedecor:shingles_wood",
	{ snappy = 3 },
	{
		"homedecor_shingles_wood_s_t.png",
		"homedecor_shingles_wood_s_z.png",
		"homedecor_shingles_wood_s_z.png",
		"homedecor_shingles_wood_s_z.png",
		"homedecor_shingles_wood_s_z.png",
		"homedecor_shingles_wood_s_z.png",
	},
	"Wood Shingles"
)

homedecor.register_slope("homedecor", "asphalt",
	"homedecor:shingles_asphalt",
	{ snappy = 3 },
	{
		"homedecor_shingles_asphalt_s_t.png",
		"homedecor_shingles_asphalt_s_z.png",
		"homedecor_shingles_asphalt_s_z.png",
		"homedecor_shingles_asphalt_s_z.png",
		"homedecor_shingles_asphalt_s_z.png",
		"homedecor_shingles_asphalt_s_z.png",
	},
	"Asphalt Shingles"
)

homedecor.register_slope("homedecor", "terracotta",
	"homedecor:shingles_terracotta",
	{ snappy = 3 },
	{
		"homedecor_shingles_terracotta_s_t.png",
		"homedecor_shingles_terracotta_s_z.png",
		"homedecor_shingles_terracotta_s_z.png",
		"homedecor_shingles_terracotta_s_z.png",
		"homedecor_shingles_terracotta_s_z.png",
		"homedecor_shingles_terracotta_s_z.png",
	},
	"Terracotta Shingles"
)

homedecor.register_slope("homedecor", "glass",
	"homedecor:shingles_glass",
	{ snappy = 3 },
	{
		"homedecor_shingles_glass_top.png",
		"homedecor_shingles_glass.png"
	},
	"Glass Shingles"
)

