--[[
If you want to run PlantLife and mods that depend on it, i.e. MoreTrees, Disable the mapgen by
commenting-out the lines starting with "local mgname = " through "end" (I left a note were to start
and stop) Disabling "Snow's" mapgen allows MoreTrees and PlantLife to do their thing until the
issue is figured out. However, the pine and xmas tree code is still needed for when those
saplings grow into trees. --]]
--The *starting* comment looks like this:  --[[
--The *closing* comment looks like this:  --]]

-- ~ LazyJ, 2014_05_13


-- Part 1: To disable the mapgen, add the *starting* comment under this line.


snow.mapgen = snow.mapgen or {}
local mg = snow.mapgen

-- perlin noise "hills" are not peaks but looking like sinus curve
local function upper_rarity(rarity)
	return math.sign(rarity)*math.sin(math.abs(rarity)*math.pi/2)
end

local rarity = snow.mapgen_rarity
local size = snow.mapgen_size
local smooth = snow.smooth_biomes

local nosmooth_rarity, perlin_scale
local function calc_values()
	nosmooth_rarity = 1-rarity/50
	perlin_scale = size*100/rarity
	mg.perlin_scale = perlin_scale
	local smooth_rarity_max, smooth_rarity_min, smooth_rarity_dif
	if smooth then
		local smooth_trans_size = 4 --snow.smooth_trans_size
		mg.smooth_rarity_max = upper_rarity(nosmooth_rarity+smooth_trans_size*2/perlin_scale)
		mg.smooth_rarity_min = upper_rarity(nosmooth_rarity-smooth_trans_size/perlin_scale)
		mg.smooth_rarity_dif = mg.smooth_rarity_max-mg.smooth_rarity_min
	end
	nosmooth_rarity = upper_rarity(nosmooth_rarity)
	mg.nosmooth_rarity = nosmooth_rarity
end
calc_values()

snow.register_on_configuring(function(name, v)
	if name == "mapgen_rarity" then
		rarity = v
	elseif name == "mapgen_size" then
		size = v
	elseif name == "smooth_biomes" then
		smooth = v
	else
		return
	end
	-- TODO: if e.g. size and rarity get changed at once, don't calculate the values more times
	calc_values()
end)


--Identify the mapgen.
local mgname = minetest.get_mapgen_setting"mg_name"
if not mgname then
	minetest.log("error", "[MOD] Snow Biomes: WARNING! mapgen could not be identifyed!")
end
local path = minetest.get_modpath"snow"
if mgname == "v7" then
	--Load mapgen_v7 compatibility.
	dofile(path.."/src/mapgen_v7.lua")
else
	--Load mapgen_v6 compatibility.
	dofile(path.."/src/mapgen_v6.lua")
end

-- To complete the commenting-out add the *closing* comment under this line.


local pine_tree = {
	axiom="TABff",
	rules_a="[&T+f+ff+ff+ff+f]GA",
	rules_b="[&T+f+Gf+Gf+Gf]GB",
	trunk="default:pinetree",
	leaves="snow:needles",
	angle=90,
	iterations=1,
	random_level=0,
	trunk_type="single",
	thin_branches=true,
}



local xmas_tree = {
	axiom="TABff",
	rules_a="[&T+f+ff+ff+ff+f]GA",
	rules_b="[&T+f+Gf+Gf+Gf]GB",
	trunk="default:pinetree",
	leaves="snow:needles_decorated",
	angle=90,
	iterations=1,
	random_level=0,
	trunk_type="single",
	thin_branches=true,
}



--Makes pine tree
function snow.make_pine(pos,snow,xmas)
	local minetest = minetest
	local try_node = function(pos, node)
		local n = minetest.get_node(pos).name
		if n == "air"
		or n == "ignore" then
			minetest.add_node(pos, node)
		end
	end
	if xmas then
		minetest.remove_node(pos)
		minetest.spawn_tree(pos, xmas_tree)
	else
		minetest.spawn_tree(pos, pine_tree)
	end
	if snow then
		local x,z = pos.x,pos.z
		try_node({x=x+1,y=pos.y+3,z=z+1},{name="default:snow"})
		try_node({x=x-1,y=pos.y+3,z=z-1},{name="default:snow"})
		try_node({x=x-1,y=pos.y+3,z=z+1},{name="default:snow"})
		try_node({x=x+1,y=pos.y+3,z=z-1},{name="default:snow"})

		try_node({x=x+1,y=pos.y+5,z=z},{name="default:snow"})
		try_node({x=x-1,y=pos.y+5,z=z},{name="default:snow"})
		try_node({x=x,y=pos.y+5,z=z+1},{name="default:snow"})
		try_node({x=x,y=pos.y+5,z=z-1},{name="default:snow"})
	end
	if xmas then
		try_node({x=pos.x,y=pos.y+7,z=pos.z},{name="snow:star_lit"}) -- Added lit star. ~ LazyJ
	elseif snow
	and minetest.get_perlin(112,3, 0.5, perlin_scale):get2d({x=pos.x,y=pos.z}) > nosmooth_rarity then
		try_node({x=pos.x,y=pos.y+7,z=pos.z},{name="default:snow"})
	end
end



--Makes pine tree
function snow.voxelmanip_pine(pos,a,data)
	local c_snow = minetest.get_content_id("default:snow")
	local c_pine_needles = minetest.get_content_id("snow:needles")
	local c_pinetree = minetest.get_content_id("default:pinetree")
	local c_air = minetest.get_content_id("air")

	local perlin1 = minetest.get_perlin(112,3, 0.5, perlin_scale)
	for z = -1,1 do
		local z = pos.z + z
		for x = -1,1 do
			local x = pos.x + x

			--Make tree.
			for i = 1,2 do
				data[a:index(x,pos.y+i,z)] = c_pine_needles
				if x ~= 0
				and z ~= 0
				and perlin1:get2d({x=x,y=z}) > nosmooth_rarity then
					local abovenode = a:index(x,pos.y+i+1,z)
					data[abovenode] = c_snow
				end
			end
		end
	end
	for i=3, 4 do
		local x = pos.x
		local y = pos.y+i
		local z = pos.z
		data[a:index(x+1,y,z)] = c_pine_needles
		data[a:index(x-1,y,z)] = c_pine_needles
		data[a:index(x,y,z+1)] = c_pine_needles
		data[a:index(x,y,z-1)] = c_pine_needles
		if perlin1:get2d({x=x+1,y=z}) > nosmooth_rarity then
			data[a:index(x+1,y+1,z)] = c_snow
		end
		if perlin1:get2d({x=x+1,y=z}) > nosmooth_rarity then
			data[a:index(x-1,y+1,z)] = c_snow
		end
		if perlin1:get2d({x=x,y=z+1}) > nosmooth_rarity then
			data[a:index(x,y+1,z+1)] = c_snow
		end
		if perlin1:get2d({x=x,y=z-1}) > nosmooth_rarity then
			data[a:index(x,y+1,z-1)] = c_snow
		end
	end
	for i=0, 4 do
		data[a:index(pos.x,pos.y+i,pos.z)] = c_pinetree
	end
	data[a:index(pos.x,pos.y+5,pos.z)] = c_pine_needles
	data[a:index(pos.x,pos.y+6,pos.z)] = c_pine_needles
	if perlin1:get2d({x=pos.x,y=pos.z}) > nosmooth_rarity then
		data[a:index(pos.x,pos.y+7,pos.z)] = c_snow
	end
end
