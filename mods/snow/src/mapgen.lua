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


--Identify the mapgen.
minetest.register_on_mapgen_init(function(MapgenParams)
	local mgname = MapgenParams.mgname
	if not mgname then
		io.write("[MOD] Snow Biomes: WARNING! mapgen could not be identifyed!\n")
	end
	if mgname == "v7" then
		--Load mapgen_v7 compatibility.
		dofile(minetest.get_modpath("snow").."/src/mapgen_v7.lua")
	else
		--Load mapgen_v6 compatibility.
		dofile(minetest.get_modpath("snow").."/src/mapgen_v6.lua")
	end
end)

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
	local perlin1 = minetest.get_perlin(112,3, 0.5, 150)
	local try_node = function(pos, node)
		local n = minetest.get_node(pos).name
		if n == "air"
		or n == "ignore" then
			minetest.add_node(pos, node)
		end
	end
	--Clear ground.
	for z = -1,1 do
		for x = -1,1 do
			local p = {x=pos.x+x,y=pos.y,z=pos.z+z}
			local nd = minetest.get_node(p).name
			if nd == "default:snow"
			or nd == "default:snowblock" then
				minetest.remove_node(p)
			end
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
	and perlin1:get2d({x=pos.x,y=pos.z}) > 0.53 then
		try_node({x=pos.x,y=pos.y+7,z=pos.z},{name="default:snow"})
	end
end



--Makes pine tree
function snow.voxelmanip_pine(pos,a,data)
	local c_snow = minetest.get_content_id("default:snow")
	local c_pine_needles = minetest.get_content_id("snow:needles")
	local c_pinetree = minetest.get_content_id("default:pinetree")
	local c_air = minetest.get_content_id("air")

	local perlin1 = minetest.get_perlin(112,3, 0.5, 150)
	for z = -1,1 do
		local z = pos.z + z
		for x = -1,1 do
			local x = pos.x + x

			--Clear ground.
			local node = a:index(x,pos.y,z)
			if data[node] == c_snow then
				data[node] = c_air
			end

			--Make tree.
			for i = 1,2 do
				local node = a:index(x,pos.y+i,z)
				data[node] = c_pine_needles
				if snow
				and x ~= 0
				and z ~= 0
				and perlin1:get2d({x=x,y=z}) > 0.53 then
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
		if snow then
			if perlin1:get2d({x=x+1,y=z}) > 0.53 then
				data[a:index(x+1,y+1,z)] = c_snow
			end
			if perlin1:get2d({x=x+1,y=z}) > 0.53 then
				data[a:index(x-1,y+1,z)] = c_snow
			end
			if perlin1:get2d({x=x,y=z+1}) > 0.53 then
				data[a:index(x,y+1,z+1)] = c_snow
			end
			if perlin1:get2d({x=x,y=z-1}) > 0.53 then
				data[a:index(x,y+1,z-1)] = c_snow
			end
		end
	end
	for i=0, 4 do
		data[a:index(pos.x,pos.y+i,pos.z)] = c_pinetree
	end
	data[a:index(pos.x,pos.y+5,pos.z)] = c_pine_needles
	data[a:index(pos.x,pos.y+6,pos.z)] = c_pine_needles
	if snow
	and perlin1:get2d({x=pos.x,y=pos.z}) > 0.53 then
		data[a:index(pos.x,pos.y+7,pos.z)] = c_snow
	end
end
