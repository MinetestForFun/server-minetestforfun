local S = homedecor.gettext

local slope_cbox = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5, 0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25, 0.5,     0, 0.5},
		{-0.5,     0,     0, 0.5,  0.25, 0.5},
		{-0.5,  0.25,  0.25, 0.5,   0.5, 0.5}
	}
}

local ocorner_cbox = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5,   0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25,  0.25,     0, 0.5},
		{-0.5,     0,     0,     0,  0.25, 0.5},
		{-0.5,  0.25,  0.25, -0.25,   0.5, 0.5}
	}
}

local icorner_cbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, -- NodeBox5
		{-0.5, -0.5, -0.25, 0.5, 0, 0.5}, -- NodeBox6
		{-0.5, -0.5, -0.5, 0.25, 0, 0.5}, -- NodeBox7
		{-0.5, 0, -0.5, 0, 0.25, 0.5}, -- NodeBox8
		{-0.5, 0, 0, 0.5, 0.25, 0.5}, -- NodeBox9
		{-0.5, 0.25, 0.25, 0.5, 0.5, 0.5}, -- NodeBox10
		{-0.5, 0.25, -0.5, -0.25, 0.5, 0.5}, -- NodeBox11
	}
}

homedecor.register_outer_corner = function(modname, subname, groups, slope_image, description)

	local tiles = slope_image

	if type(slope_image) ~= "table" then
		tiles = { "homedecor_slope_outer_corner_"..slope_image..".png" }
	end

	minetest.register_node(modname..":shingle_outer_corner_" .. subname, {
		description = S(description.. " (outer corner)"),
		drawtype = "mesh",
		mesh = "homedecor_slope_outer_corner.obj",
		tiles = tiles,
		paramtype = "light",
		paramtype2 = "facedir",
		selection_box = ocorner_cbox,
		collision_box = ocorner_cbox,
		groups = groups,
		on_place = minetest.rotate_node,
		sounds = default.node_sound_wood_defaults()
	})
end

homedecor.register_inner_corner = function(modname, subname, groups, slope_image, description)

	local tiles = slope_image

	if type(slope_image) ~= "table" then
		tiles = { "homedecor_slope_outer_corner_"..slope_image..".png" }
	end

	minetest.register_node(modname..":shingle_inner_corner_" .. subname, {
		description = S(description.. " (inner corner)"),
		drawtype = "mesh",
		mesh = "homedecor_slope_inner_corner.obj",
		tiles = tiles,
		paramtype = "light",
		paramtype2 = "facedir",
		collision_box = icorner_cbox,
		groups = groups,
		on_place = minetest.rotate_node,
		sounds = default.node_sound_wood_defaults()
	})
end

homedecor.register_slope = function(modname, subname, recipeitem, groups, slope_image, description)

	local tiles = slope_image

	if type(slope_image) ~= "table" then
		tiles = { "homedecor_slope_outer_corner_"..slope_image..".png" }
	end

	minetest.register_node(modname..":shingle_side_" .. subname, {
		description = S(description),
		drawtype = "mesh",
		mesh = "homedecor_slope.obj",
		tiles = tiles,
		paramtype = "light",
		paramtype2 = "facedir",
		selection_box = slope_cbox,
		collision_box = slope_cbox,
		groups = groups,
		on_place = minetest.rotate_node,
		sounds = default.node_sound_wood_defaults()
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

homedecor.register_roof = function(modname, subname, groups, slope_image , description)
	homedecor.register_outer_corner(modname, subname, groups, slope_image, description)
	homedecor.register_inner_corner(modname, subname, groups, slope_image, description)
end

-- corners

homedecor.register_roof(
	"homedecor",
	"wood",
	{ snappy = 3 },
	{ "homedecor_shingles_wood.png" },
	"Wood Shingles"
)

homedecor.register_roof(
	"homedecor",
	"asphalt",
	{ snappy = 3 },
	{ "homedecor_shingles_asphalt.png" },
	"Asphalt Shingles"
)

homedecor.register_roof(
	"homedecor",
	"terracotta",
	{ snappy = 3 },
	{ "homedecor_shingles_terracotta.png" },
	"Terracotta Shingles"
)

-- register just the slopes

homedecor.register_slope(
	"homedecor",
	"wood",
	"homedecor:shingles_wood",
	{ snappy = 3 },
	{ "homedecor_shingles_wood.png" },
	"Wood Shingles"
)

homedecor.register_slope(
	"homedecor",
	"asphalt",
	"homedecor:shingles_asphalt",
	{ snappy = 3 },
	{ "homedecor_shingles_asphalt.png" },
	"Asphalt Shingles"
)

homedecor.register_slope(
	"homedecor",
	"terracotta",
	"homedecor:shingles_terracotta",
	{ snappy = 3 },
	{ "homedecor_shingles_terracotta.png" },
	"Terracotta Shingles"
)

homedecor.register_slope(
	"homedecor",
	"glass",
	"homedecor:shingles_glass",
	{ snappy = 3 },
	{ "homedecor_shingles_glass.png", "homedecor_shingles_wood.png" },
	"Glass Shingles"
)

