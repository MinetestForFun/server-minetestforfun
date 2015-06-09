local function register_flower(name)
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.006,
			spread = {x=100, y=100, z=100},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		y_min = 1,
		y_max = 30,
		decoration = "flowers:"..name,
	})
end

function flowers.register_mgv6_decorations()
	register_flower("rose")
	register_flower("tulip")
	register_flower("dandelion_yellow")
	register_flower("geranium")
	register_flower("viola")
	register_flower("dandelion_white")
end

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:water_source"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.006,
		spread = {x=100, y=100, z=100},
		seed = 436,
		octaves = 3,
		persist = 0.6
	},
	y_min = -10,
	y_max = 30,
	decoration = "flowers:lily_pad",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:sand"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.006,
		spread = {x=100, y=100, z=100},
		seed = 436,
		octaves = 3,
		persist = 0.6
	},
	y_min = -400,
	y_max = 400,
	decoration = "default:dry_shrub",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:snow"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.006,
		spread = {x=100, y=100, z=100},
		seed = 436,
		octaves = 3,
		persist = 0.6
	},
	y_min = -400,
	y_max = 400,
	decoration = "default:snow",
})


-- Enable in mapgen v6 only

local mg_params = minetest.get_mapgen_params()
if mg_params.mgname == "v6" then
	flowers.register_mgv6_decorations()
end

