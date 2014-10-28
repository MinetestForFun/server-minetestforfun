-- NODES


minetest.register_node("whiteshell:whiteshell", {
	description = "White shell",
	drawtype = "normal",
--	tiles = {"default_desert_sand.png^clams_crushedwhite.png"},
	tiles = {"default_desert_sand.png"},
	is_ground_content = true,
	groups = {sand=1, crumbly=3, falling_node=1, sand=1, not_in_creative_inventory=1},
	drop = {
		max_items = 2,
		items = {
			{
				items = {'clams:crushedwhite'},
			},
			{
				items = {'default:desert_sand'},
			}
		}
	},
	sounds = default.node_sound_sand_defaults(),
})

-- WHITESHELL GENERATION


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "whiteshell:whiteshell",
	wherein        = "default:desert_sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 18,
	clust_size     = 6,
	height_max     = 31000,
	height_min     = -31000,
})


local function generate_ore(name, wherein, minp, maxp, seed, chunks_per_volume, chunk_size, ore_per_chunk, height_min, height_max)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	if chunk_size >= y_max - y_min + 1 then
		return
	end
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / ore_per_chunk)
	for i=1,num_chunks do
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= height_min and y0 <= height_max then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			local p0 = {x=x0, y=y0, z=z0}
			for x1=0,chunk_size-1 do
			for y1=0,chunk_size-1 do
			for z1=0,chunk_size-1 do
				if pr:next(1,inverse_chance) == 1 then
					local x2 = x0+x1
					local y2 = y0+y1
					local z2 = z0+z1
					local p2 = {x=x2, y=y2, z=z2}
					if minetest.get_node(p2).name == wherein then
						minetest.set_node(p2, {name=name})
					end
				end
			end
			end
			end
		end
	end
end


-- ALIASES


minetest.register_alias("clams:whiteshell","whiteshell:whiteshell")
