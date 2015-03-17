local load_time_start = os.clock()
local MAX_SIZE = 3

riesenpilz = {}
dofile(minetest.get_modpath("riesenpilz").."/settings.lua")
dofile(minetest.get_modpath("riesenpilz").."/functions.lua")

local function r_area(manip, width, height, pos)
	local emerged_pos1, emerged_pos2 = manip:read_from_map(
		{x=pos.x-width, y=pos.y, z=pos.z-width},
		{x=pos.x+width, y=pos.y+height, z=pos.z+width}
	)
	return VoxelArea:new({MinEdge=emerged_pos1, MaxEdge=emerged_pos2})
end

riesenpilz.vm_update = true
local function set_vm_data(manip, nodes, pos, t1, name)
	manip:set_data(nodes)
	manip:write_to_map()
	riesenpilz.inform("a "..name.." mushroom grew at ("..pos.x.."|"..pos.y.."|"..pos.z..")", 3, t1)
	if riesenpilz.vm_update then
		local t1 = os.clock()
		manip:update_map()
		riesenpilz.inform("map updated", 3, t1)
	end
end


--Growing Functions

local c

function riesenpilz_hybridpilz(pos)

	local t1 = os.clock()
	local manip = minetest.get_voxel_manip()
	local area = r_area(manip, MAX_SIZE+1, MAX_SIZE+3, pos)
	local nodes = manip:get_data()

	local breite = math.random(MAX_SIZE)
	local br = breite+1
	local height = breite+2

	for i = 0, height do
		nodes[area:index(pos.x, pos.y+i, pos.z)] = c.stem
	end

	for l = -br+1, br do
		for k = -1, 1, 2 do
			nodes[area:index(pos.x+br*k, pos.y+height, pos.z-l*k)] = c.head_red
			nodes[area:index(pos.x+l*k, pos.y+height, pos.z+br*k)] = c.head_red
		end
	end

	for k = -breite, breite do
		for l = -breite, breite do
			nodes[area:index(pos.x+l, pos.y+height+1, pos.z+k)] = c.head_red
			nodes[area:index(pos.x+l, pos.y+height, pos.z+k)] = c.lamellas
		end
	end

	set_vm_data(manip, nodes, pos, t1, "red")
end


function riesenpilz_brauner_minecraftpilz(pos)

	local t1 = os.clock()
	local manip = minetest.get_voxel_manip()
	local area = r_area(manip, MAX_SIZE+1, MAX_SIZE+2, pos)
	local nodes = manip:get_data()

	local random = math.random(MAX_SIZE-1)
	local br	 = random+1
	local breite = br+1
	local height = br+2

	for i in area:iterp(pos, {x=pos.x, y=pos.y+height, z=pos.z}) do
		nodes[i] = c.stem
	end

	for l = -br, br do
		for k = -breite, breite, breite*2 do
			nodes[area:index(pos.x+k, pos.y+height+1, pos.z+l)] = c.head_brown
			nodes[area:index(pos.x+l, pos.y+height+1, pos.z+k)] = c.head_brown
		end
		for k = -br, br do
			nodes[area:index(pos.x+l, pos.y+height+1, pos.z+k)] = c.head_brown
		end
	end

	set_vm_data(manip, nodes, pos, t1, "brown")
end


function riesenpilz_minecraft_fliegenpilz(pos)

	local t1 = os.clock()
	local manip = minetest.get_voxel_manip()
	local area = r_area(manip, 2, 4, pos)
	local nodes = manip:get_data()
	local param2s = manip:get_param2_data() 

	local height = 3

	for i = 0, height do
		nodes[area:index(pos.x, pos.y+i, pos.z)] = c.stem
	end

	for j = -1, 1 do
		for k = -1, 1 do
			nodes[area:index(pos.x+j, pos.y+height+1, pos.z+k)] = c.head_red
		end
		for l = 1, height do
			local y = pos.y+l
			for _,p in pairs({
				{area:index(pos.x+j, y, pos.z+2), 0},
				{area:index(pos.x+j, y, pos.z-2), 2},
				{area:index(pos.x+2, y, pos.z+j), 1},
				{area:index(pos.x-2, y, pos.z+j), 3},
			}) do
				local tmp = p[1]
				nodes[tmp] = c.head_red_side
				param2s[tmp] = p[2]
			end
		end
	end

	manip:set_data(nodes)
	manip:set_param2_data(param2s)
	manip:write_to_map()
	manip:update_map()
	riesenpilz.inform("a fly agaric grew at ("..pos.x.."|"..pos.y.."|"..pos.z..")", 3, t1)
end


local function ran_node(a, b, ran)
	if math.random(ran) == 1 then
		return a
	end
	return b
end

function riesenpilz_lavashroom(pos)

	local t1 = os.clock()
	local manip = minetest.get_voxel_manip()
	local area = r_area(manip, 4, MAX_SIZE+7, pos)
	local nodes = manip:get_data()

	local height = 3+math.random(MAX_SIZE-2)
	nodes[area:index(pos.x, pos.y, pos.z)] = c.air

	for i = -1, 1, 2 do
		local o = 2*i

		for n = 0, height do
			nodes[area:index(pos.x+i, pos.y+n, pos.z)] = c.stem_brown
			nodes[area:index(pos.x, pos.y+n, pos.z+i)] = c.stem_brown
		end

		for l = -1, 1 do
			for k = 2, 3 do
				nodes[area:index(pos.x+k*i, pos.y+height+2, pos.z+l)] = c.head_brown_full
				nodes[area:index(pos.x+l, pos.y+height+2, pos.z+k*i)] = c.head_brown_full
			end
			nodes[area:index(pos.x+l, pos.y+height+1, pos.z+o)] = c.head_brown_full
			nodes[area:index(pos.x+o, pos.y+height+1, pos.z+l)] = c.head_brown_full
		end

		for m = -1, 1, 2 do
			for k = 2, 3 do
				for j = 2, 3 do
					nodes[area:index(pos.x+j*i, pos.y+height+2, pos.z+k*m)] = ran_node(c.head_yellow, c.head_orange, 7)
				end
			end
			nodes[area:index(pos.x+i, pos.y+height+1, pos.z+m)] = c.head_brown_full
			nodes[area:index(pos.x+m*2, pos.y+height+1, pos.z+o)] = c.head_brown_full
		end

		for l = -3+1, 3 do
			nodes[area:index(pos.x+3*i, pos.y+height+5, pos.z-l*i)] = ran_node(c.head_yellow, c.head_orange, 5)
			nodes[area:index(pos.x+l*i, pos.y+height+5, pos.z+3*i)] = ran_node(c.head_yellow, c.head_orange, 5)
		end

		for j = 0, 1 do
			for l = -3, 3 do
				nodes[area:index(pos.x+i*4, pos.y+height+3+j, pos.z+l)] = ran_node(c.head_yellow, c.head_orange, 6)
				nodes[area:index(pos.x+l, pos.y+height+3+j, pos.z+i*4)] = ran_node(c.head_yellow, c.head_orange, 6)
			end
		end

	end

	for k = -2, 2 do
		for l = -2, 2 do
			nodes[area:index(pos.x+k, pos.y+height+6, pos.z+l)] = ran_node(c.head_yellow, c.head_orange, 4)
		end
	end

	set_vm_data(manip, nodes, pos, t1, "lavashroom")
end


function riesenpilz_glowshroom(pos)

	local t1 = os.clock()
	local manip = minetest.get_voxel_manip()
	local area = r_area(manip, 2, MAX_SIZE+5, pos)
	local nodes = manip:get_data()

	local height = 2+math.random(MAX_SIZE)
	local br = 2

	for i = 0, height do
		nodes[area:index(pos.x, pos.y+i, pos.z)] = c.stem_blue
	end

	for i = -1, 1, 2 do

		for k = -br, br, 2*br do
			for l = 2, height do
				nodes[area:index(pos.x+i*br, pos.y+l, pos.z+k)] = c.head_blue
			end
			nodes[area:index(pos.x+i*br, pos.y+1, pos.z+k)] = c.head_blue_bright
		end

		for l = -br+1, br do
			nodes[area:index(pos.x+i*br, pos.y+height, pos.z-l*i)] = c.head_blue
			nodes[area:index(pos.x+l*i, pos.y+height, pos.z+br*i)] = c.head_blue
		end

	end

	for l = 0, br do
		for i = -br+l, br-l do
			for k = -br+l, br-l do
				nodes[area:index(pos.x+i, pos.y+height+1+l, pos.z+k)] = c.head_blue
			end
		end
	end

	set_vm_data(manip, nodes, pos, t1, "glowshroom")
end


function riesenpilz_parasol(pos)
	local t1 = os.clock()

	local height = 6+math.random(MAX_SIZE)
	local br = math.random(MAX_SIZE+1,MAX_SIZE+2)

	local manip = minetest.get_voxel_manip()
	local area = r_area(manip, br, height, pos)
	local nodes = manip:get_data()

	local rh = math.random(2,3)
	local bhead1 = br-1
	local bhead2 = math.random(1,br-2)

	--stem
	for i in area:iterp(pos, {x=pos.x, y=pos.y+height-2, z=pos.z}) do
		nodes[i] = c.stem
	end

	for _,j in pairs({
		{bhead2, 0, c.head_brown_bright},
		{bhead1, -1, c.head_binge}
	}) do
		for i in area:iter(pos.x-j[1], pos.y+height+j[2], pos.z-j[1], pos.x+j[1], pos.y+height+j[2], pos.z+j[1]) do
			nodes[i] = j[3]
		end
	end

	for k = -1, 1, 2 do
		for l = 0, 1 do
			nodes[area:index(pos.x+k, pos.y+rh, pos.z-l*k)] = c.head_white
			nodes[area:index(pos.x+l*k, pos.y+rh, pos.z+k)] = c.head_white
		end
		for l = -br+1, br do
			nodes[area:index(pos.x+br*k, pos.y+height-2, pos.z-l*k)] = c.head_binge
			nodes[area:index(pos.x+l*k, pos.y+height-2, pos.z+br*k)] = c.head_binge
		end
		for l = -bhead1+1, bhead1 do
			nodes[area:index(pos.x+bhead1*k, pos.y+height-2, pos.z-l*k)] = c.head_white
			nodes[area:index(pos.x+l*k, pos.y+height-2, pos.z+bhead1*k)] = c.head_white
		end
	end

	set_vm_data(manip, nodes, pos, t1, "parasol")
end


function riesenpilz_apple(pos)

	local t1 = os.clock()
	local manip = minetest.get_voxel_manip()
	local area = r_area(manip, 5, 14, pos)
	local nodes = manip:get_data()

	local size = 5
	local a = size*2
	local b = size-1

	for l = -b, b do
		for j = 1, a-1 do
			for k = -size, size, a do
				nodes[area:index(pos.x+k, pos.y+j, pos.z+l)] = c.red
				nodes[area:index(pos.x+l, pos.y+j, pos.z+k)] = c.red
			end
		end
		for i = -b, b do
			nodes[area:index(pos.x+i, pos.y, pos.z+l)] = c.red
			nodes[area:index(pos.x+i, pos.y+a, pos.z+l)] = c.red
		end
	end

	for i = a+1, a+b do
		nodes[area:index(pos.x, pos.y+i, pos.z)] = c.tree
	end

	local c = pos.y+1
	for i = -3,1,1 do
		nodes[area:index(pos.x+i, c, pos.z+1)] = c.brown
	end
	for i = 0,1,1 do
		nodes[area:index(pos.x+i+1, c, pos.z-1-i)] = c.brown
		nodes[area:index(pos.x+i+2, c, pos.z-1-i)] = c.brown
	end
	nodes[area:index(pos.x+1, c, pos.z)] = c.brown
	nodes[area:index(pos.x-3, c+1, pos.z+1)] = c.brown

	manip:set_data(nodes)
	manip:write_to_map()
	riesenpilz.inform("an apple grew at ("..pos.x.."|"..pos.y.."|"..pos.z..")", 3, t1)
	manip:update_map()
end



--3D apple [3apple]


minetest.override_item("default:apple", {
	drawtype = "nodebox",
	tiles = {"3apple_apple_top.png","3apple_apple_bottom.png","3apple_apple.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-3/16,	-7/16,	-3/16,	3/16,	1/16,	3/16},
			{-4/16,	-6/16,	-3/16,	4/16,	0,		3/16},
			{-3/16,	-6/16,	-4/16,	3/16,	0,		4/16},
			{-1/32,	1/16,	-1/32,	1/32,	4/16,	1/32},
			{-1/16,	1.6/16,	0,		1/16,	1.8/16,	1/16},
			{-2/16,	1.4/16,	1/16,	1/16,	1.6/16,	2/16},
			{-2/16,	1.2/16,	2/16,	0,		1.4/16,	3/16},
			{-1.5/16,	1/16,	.5/16,	0.5/16,		1.2/16,	2.5/16},
		}
	},
})



--Mushroom Nodes


local mushrooms_list = {
	["brown"] = {
		description = "brown mushroom",
		box = {
			{-0.15, -0.2, -0.15, 0.15, -0.1, 0.15},
			{-0.2, -0.3, -0.2, 0.2, -0.2, 0.2},
			{-0.05, -0.5, -0.05, 0.05, -0.3, 0.05}
		},
		growing = {
			r = {min=3, max=4},
			grounds = {soil=1, crumbly=3},
			neighbours = {"default:tree"},
			light = {min=1, max=7},
			interval = 100,
			chance = 18,
		},
	},
	["red"] = {
		description = "red mushroom",
		box = {
			{-1/16, -8/16, -1/16, 1/16, -6/16, 1/16},
			{-3/16, -6/16, -3/16, 3/16, -5/16, 3/16},
			{-4/16, -5/16, -4/16, 4/16, -4/16, 4/16},
			{-3/16, -4/16, -3/16, 3/16, -3/16, 3/16},
			{-2/16, -3/16, -2/16, 2/16, -2/16, 2/16}
		},
		growing = {
			r = {min=4, max=5},
			grounds = {soil=2},
			neighbours = {"default:water_flowing"},
			light = {min=4, max=13},
			interval = 50,
			chance = 30,
		},
	},
	["fly_agaric"] = {
		description = "fly agaric",
		box = {
			{-0.05, -0.5, -0.05, 0.05, 1/20, 0.05},
			{-3/20, -6/20, -3/20, 3/20, 0, 3/20},
			{-4/20, -2/20, -4/20, 4/20, -4/20, 4/20}
		},
		growing = {
			r = 4,
			grounds = {soil=1, crumbly=3},
			neighbours = {"default:pinetree"},
			light = {min=2, max=10},
			interval = 101,
			chance = 30,
		},
	},
	["lavashroom"] = {
		description = "Lavashroom",
		box = {
			{-1/16, -8/16, -1/16, 1/16, -6/16, 1/16},
			{-2/16, -6/16, -2/16, 2/16,     0, 2/16},
			{-3/16, -5/16, -3/16, 3/16, -1/16, 3/16},
			{-4/16, -4/16, -4/16, 4/16, -2/16, 4/16}
		},
		growing = {
			r = {min=5, max=6},
			grounds = {cracky=3},
			neighbours = {"default:lava_source"},
			light = {min=10, max=14},
			interval = 1010,
			chance = 60,
		},
	},
	["glowshroom"] = {
		description = "Glowshroom",
		box = {
			{-1/16, -8/16, -1/16, 1/16, -1/16, 1/16},
			{-2/16, -3/16, -2/16, 2/16, -2/16, 2/16},
			{-3/16, -5/16, -3/16, 3/16, -3/16, 3/16},
			{-3/16, -7/16, -3/16, -2/16, -5/16, -2/16},
			{3/16, -7/16, -3/16, 2/16, -5/16, -2/16},
			{-3/16, -7/16, 3/16, -2/16, -5/16, 2/16},
			{3/16, -7/16, 3/16, 2/16, -5/16, 2/16}
		},
		growing = {
			r = 3,
			grounds = {soil=1, crumbly=3},
			neighbours = {"default:stone"},
			light = 0,
			interval = 710,
			chance = 320,
		},
	},
	["nether_shroom"] = {
		description = "Nether mushroom",
		box = {
			{-1/16, -8/16, -1/16, 1/16, -2/16, 1/16},
			{-2/16, -6/16, -2/16, 2/16, -5/16, 2/16},
			{-3/16, -2/16, -3/16, 3/16,     0, 3/16},
			{-4/16, -1/16, -4/16, 4/16,  1/16,-2/16},
			{-4/16, -1/16,  2/16, 4/16,  1/16, 4/16},
			{-4/16, -1/16, -2/16,-2/16,  1/16, 2/16},
			{ 2/16, -1/16, -2/16, 4/16,  1/16, 2/16}
		},
		burntime = 6,
	},
	["parasol"] = {
		description = "white parasol mushroom",
		box = {
			{-1/16, -8/16, -1/16, 1/16,  0, 1/16},
			{-2/16, -6/16, -2/16, 2/16, -5/16, 2/16},
			{-5/16, -4/16, -5/16, 5/16, -3/16, 5/16},
			{-4/16, -3/16, -4/16, 4/16, -2/16, 4/16},
			{-3/16, -2/16, -3/16, 3/16, -1/16, 3/16}
		},
		growing = {
			r = {min=3, max=5},
			grounds = {soil=1, crumbly=3},
			neighbours = {"default:pinetree"},
			light = {min=1, max=11},
			interval = 51,
			chance = 36,
		},
	},
	["red45"] = {
		description = "45 red mushroom",
		box = {
			{-1/16, -0.5, -1/16, 1/16, 1/8, 1/16},
			{-3/16, 1/8, -3/16, 3/16, 1/4, 3/16},
			{-5/16, -1/4, -5/16, -1/16, 1/8, -1/16},
			{1/16, -1/4, -5/16, 5/16, 1/8, -1/16},
			{-5/16, -1/4, 1/16, -1/16, 1/8, 5/16},
			{1/16, -1/4, 1/16, 5/16, 1/8, 5/16}
		},
		growing = {
			r = {min=3, max=4},
			grounds = {soil=2},
			neighbours = {"default:water_source"},
			light = {min=2, max=7},
			interval = 1000,
			chance = 180,
		},
	},
	["brown45"] = {
		description = "45 brown mushroom",
		box = {
			{-1/16, -0.5, -1/16, 1/16, 1/16, 1/16},
			{-3/8, 1/8, -7/16, 3/8, 1/4, 7/16},
			{-7/16, 1/8, -3/8, 7/16, 1/4, 3/8},
			{-3/8, 1/4, -3/8, 3/8, 5/16, 3/8},
			{-3/8, 1/16, -3/8, 3/8, 1/8, 3/8}
		},
		growing = {
			r = {min=2, max=3},
			grounds = {tree=1},
			neighbours = {"default:water_flowing"},
			light = {min=7, max=11},
			interval = 100,
			chance = 20,
		},
	},
}

local abm_allowed = true
local disallowed_ps = {}
for name,i in pairs(mushrooms_list) do
	local burntime = i.burntime or 1
	local box = {
		type = "fixed",
		fixed = i.box
	}
	local nd = "riesenpilz:"..name
	minetest.register_node(nd, {
		description = i.description,
		tiles = {"riesenpilz_"..name.."_top.png", "riesenpilz_"..name.."_bottom.png", "riesenpilz_"..name.."_side.png"},
		inventory_image = "riesenpilz_"..name.."_side.png",
		walkable = false,
		buildable_to = true,
		drawtype = "nodebox",
		paramtype = "light",
		groups = {snappy=3,flammable=2,attached_node=1},
		sounds =  default.node_sound_leaves_defaults(),
		node_box = box,
		selection_box = box,
		furnace_burntime = burntime
	})

	local g = i.growing

	if g then
		local grounds = g.grounds
		local nds = {}
		for n in pairs(grounds) do
			table.insert(nds, "group:"..n)
		end

		local nbs = table.copy(g.neighbours)
		table.insert(nbs, "air")

		local rmin, rmax, lmin, lmax

		local r = g.r
		if type(r) == "table" then
			rmin = r.min
			rmax = r.max
		else
			rmin = r or 3
			rmax = rmin
		end

		local l = g.light
		if type(l) == "table" then
			lmin = l.min
			lmax = l.max
		else
			lmin = l or 3
			lmax = lmin
		end

		minetest.register_abm({
			nodenames = nds,
			neighbors = g.neighbours,
			interval = g.interval,
			chance = g.chance,
			action = function(pos, node)
				if not abm_allowed then
					return
				end

			-- don't try to spawn them on the same positions again
				for _,p in pairs(disallowed_ps) do
					if vector.equals(p, pos) then
						return
					end
				end

			-- don't spawn mushroom circles next to other ones
				if minetest.find_node_near(pos, rmax, nd) then
					return
				end

			-- spawn them around the right nodes
				local data = minetest.registered_nodes[node.name]
				if not data
				or not data.groups then
					return
				end
				local groups = data.groups
				for n,i in pairs(grounds) do
					if groups[n] ~= i then
						return
					end
				end

			-- find their neighbours
				for _,n in pairs(nbs) do
					if not minetest.find_node_near(pos, rmin, n) then
						return
					end
				end

			-- should disallow lag
				abm_allowed = false
				minetest.after(2, function() abm_allowed = true end)
				table.insert(disallowed_ps, pos)

			-- witch circles
				local ps = {}
				for _,p in pairs(vector.circle(math.random(rmin, rmax))) do
					local p = vector.add(pos, p)

				-- currently 3 is used here, approved by its use in the mapgen
					if math.random(3) == 1 then

					-- don't only use the current y for them
						for y = 1,-1,-1 do
							local pos = {x=p.x, y=p.y+y, z=p.z}
							if minetest.get_node(pos).name ~= "air" then
								break
							end
							local f = minetest.get_node({x=p.x, y=p.y+y-1, z=p.z}).name
							if f ~= "air" then

							-- they grown on walkable, cubic nodes
								local data = minetest.registered_nodes[f]
								if data
								and data.walkable
								and (not data.drawtype
									or data.drawtype == "normal"
								) then

								-- they also need specific light strengths
									local light = minetest.get_node_light(pos, 0.5)
									if light >= lmin
									and light <= lmax then
										table.insert(ps, pos)
									end
								end
								break
							end
						end
					end
				end
				if not ps[1] then
					return
				end

			-- place them
				for _,p in pairs(ps) do
					minetest.set_node(p, {name=nd})
				end
				minetest.log("info", "[riesenpilz] "..nd.." mushrooms grew at "..minetest.pos_to_string(pos))
			end
		})
	end
end

-- disallow abms when the server is lagging
minetest.register_globalstep(function(dtime)
	if dtime > 0.5
	and abm_allowed then
		abm_allowed = false
		minetest.after(2, function() abm_allowed = true end)
		--minetest.chat_send_all(dtime)
	end
end)



--Mushroom Blocks


local pilznode_list = {
	{
		typ = "stem",
		description = "white",
		textures = {"stem_top.png", "stem_top.png", "stem_white.png"},
	},
	{
		typ = "stem",
		name = "brown",
		textures = {"stem_top.png", "stem_top.png", "stem_brown.png"},
	},
	{
		typ = "stem",
		name = "blue",
		textures = {"stem_top.png","stem_top.png","stem_blue.png"},
	},
	{
		name = "lamellas",
		description = "giant mushroom lamella",
		textures = "lamellas.png",
		sapling = "lamellas"
	},
	{
		typ = "head",
		name = "red",
		textures = {"head.png", "lamellas.png", "head.png"},
		sapling = "red"
	},
	{
		typ = "head",
		name = "orange",
		textures = "head_orange.png",
		sapling = "lavashroom"
	},
	{
		typ = "head",
		name = "yellow",
		textures = "head_yellow.png",
		sapling = "lavashroom"
	},
	{
		typ = "head",
		name = "brown",
		textures = {"brown_top.png", "lamellas.png", "brown_top.png"},
		sapling = "brown"
	},
	{
		typ = "head",
		name = "brown_full",
		description = "full brown",
		textures = "brown_top.png",
		sapling = "brown"
	},
	{
		typ = "head",
		name = "blue_bright",
		description = "blue bright",
		textures = "head_blue_bright.png",
		sapling = "glowshroom"
	},
	{
		typ = "head",
		name = "blue",
		textures = "head_blue.png",
		sapling = "glowshroom"
	},
	{
		typ = "head",
		name = "white",
		textures = "head_white.png",
		sapling = "parasol"
	},
	{
		typ = "head",
		name = "binge",
		textures = {"head_binge.png", "head_white.png", "head_binge.png"},
		sapling = "parasol"
	},
	{
		typ = "head",
		name = "brown_bright",
		description = "brown bright",
		textures = {"head_brown_bright.png", "head_white.png", "head_brown_bright.png"},
		sapling = "parasol"
	},
}

local head_sounds = default.node_sound_wood_defaults({
	footstep = {name="riesenpilz_head", gain=0.1},
	place = {name="default_place_node", gain=0.5},
	dig = {name="riesenpilz_head", gain=0.2},
	dug = {name="riesenpilz_stem", gain=0.1}
})

for _,i in pairs(pilznode_list) do
	-- fill missing stuff
	local textures = i.textures
	i.description = i.description or i.name
	if type(textures) == "string" then
		textures = {textures}
	end
	for i = 1,#textures do
		textures[i] = "riesenpilz_"..textures[i]
	end
	local nodename = "riesenpilz:"
	local desctiption,sounds = "giant mushroom "
	if i.typ == "stem" then
		desctiption = desctiption.."stem "..i.description
		nodename = nodename.."stem"..((i.name and "_"..i.name) or "")
		sounds = default.node_sound_wood_defaults({
			footstep = {name="riesenpilz_stem", gain=0.2},
			place = {name="default_place_node", gain=0.5},
			dig = {name="riesenpilz_stem", gain=0.4},
			dug = {name="default_wood_footstep", gain=0.3}
		})
	elseif i.typ == "head" then
		desctiption = desctiption.."head "..i.description
		nodename = nodename.."head_"..i.name
		sounds = head_sounds
	else
		nodename = nodename..i.name
		desctiption = desctiption..i.description
	end
	local drop = i.sapling and {max_items = 1, items = {
		{items = {"riesenpilz:"..i.sapling}, rarity = 20},
		{items = {nodename}, rarity = 1}
	}}
	minetest.register_node(nodename, {
		description = desctiption,
		tiles = textures,
		groups = {oddly_breakable_by_hand=3},
		drop = drop,
		sounds = sounds,
	})
end

minetest.register_node("riesenpilz:head_red_side", {
	description = "giant mushroom head red side",
	tiles = {"riesenpilz_head.png",	"riesenpilz_lamellas.png",	"riesenpilz_head.png",
					"riesenpilz_head.png",	"riesenpilz_head.png",	"riesenpilz_lamellas.png"},
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=3},
	drop = {max_items = 1,
		items = {{items = {"riesenpilz:fly_agaric"},rarity = 20,},
		{items = {"riesenpilz:head_red"},rarity = 1,}}},
	sounds = head_sounds
})



minetest.register_node("riesenpilz:ground", {
	description = "dirt with rotten grass",
	tiles = {"riesenpilz_ground_top.png","default_dirt.png","default_dirt.png^riesenpilz_ground_side.png"},
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
	drop = 'default:dirt'
})


c = {
	air = minetest.get_content_id("air"),

	stem = minetest.get_content_id("riesenpilz:stem"),
	head_red = minetest.get_content_id("riesenpilz:head_red"),
	lamellas = minetest.get_content_id("riesenpilz:lamellas"),

	head_brown = minetest.get_content_id("riesenpilz:head_brown"),

	head_red_side = minetest.get_content_id("riesenpilz:head_red_side"),

	stem_brown = minetest.get_content_id("riesenpilz:stem_brown"),
	head_brown_full = minetest.get_content_id("riesenpilz:head_brown_full"),
	head_orange = minetest.get_content_id("riesenpilz:head_orange"),
	head_yellow = minetest.get_content_id("riesenpilz:head_yellow"),

	stem_blue = minetest.get_content_id("riesenpilz:stem_blue"),
	head_blue = minetest.get_content_id("riesenpilz:head_blue"),
	head_blue_bright = minetest.get_content_id("riesenpilz:head_blue_bright"),

	head_white = minetest.get_content_id("riesenpilz:head_white"),
	head_binge = minetest.get_content_id("riesenpilz:head_binge"),
	head_brown_bright = minetest.get_content_id("riesenpilz:head_brown_bright"),

	red = minetest.get_content_id("default:copperblock"),
	brown = minetest.get_content_id("default:desert_stone"),
	tree = minetest.get_content_id("default:tree"),
}



--Growing


minetest.register_tool("riesenpilz:growingtool", {
	description = "growingtool",
	inventory_image = "riesenpilz_growingtool.png",
})

minetest.register_on_punchnode(function(pos, node, puncher)
	if puncher:get_wielded_item():get_name() == "riesenpilz:growingtool" then
		local name = node.name
		if name == "riesenpilz:red" then
			riesenpilz_hybridpilz(pos)
		elseif name == "riesenpilz:fly_agaric" then
			riesenpilz_minecraft_fliegenpilz(pos)
		elseif name == "riesenpilz:brown" then
			riesenpilz_brauner_minecraftpilz(pos)
		elseif name == "riesenpilz:lavashroom" then
			riesenpilz_lavashroom(pos)
		elseif name == "riesenpilz:glowshroom" then
			riesenpilz_glowshroom(pos)
		elseif name == "riesenpilz:parasol" then
			riesenpilz_parasol(pos)
		elseif name == "default:apple" then
			riesenpilz_apple(pos)
		end
	end
end)



if riesenpilz.enable_mapgen then
	dofile(minetest.get_modpath("riesenpilz") .. "/mapgen.lua")
end

riesenpilz.inform("loaded", 1, load_time_start)
