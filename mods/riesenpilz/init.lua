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

local function set_vm_data(manip, nodes, pos, t1, name)
	manip:set_data(nodes)
	manip:write_to_map()
	riesenpilz.inform("a "..name.." mushroom grew at ("..pos.x.."|"..pos.y.."|"..pos.z..")", 3, t1)
	local t1 = os.clock()
	manip:update_map()
	riesenpilz.inform("map updated", 3, t1)
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

	for i = 0, height, 1 do
		nodes[area:index(pos.x, pos.y+i, pos.z)] = c.stem
	end

	for l = -br+1, br, 1 do
		for k = -1, 1, 2 do
			nodes[area:index(pos.x+br*k, pos.y+height, pos.z-l*k)] = c.head_red
			nodes[area:index(pos.x+l*k, pos.y+height, pos.z+br*k)] = c.head_red
		end
	end

	for k = -breite, breite, 1 do
		for l = -breite, breite, 1 do
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

	for l = -br, br, 1 do
		for k = -breite, breite, breite*2 do
			nodes[area:index(pos.x+k, pos.y+height+1, pos.z+l)] = c.head_brown
			nodes[area:index(pos.x+l, pos.y+height+1, pos.z+k)] = c.head_brown
		end
		for k = -br, br, 1 do
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

	for i = 0, height, 1 do
		nodes[area:index(pos.x, pos.y+i, pos.z)] = c.stem
	end

	for j = -1, 1, 1 do
		for k = -1, 1, 1 do
			nodes[area:index(pos.x+j, pos.y+height+1, pos.z+k)] = c.head_red
		end
		for l = 1, height, 1 do
			local y = pos.y+l
			for _,p in ipairs({
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

		for n = 0, height, 1 do
			nodes[area:index(pos.x+i, pos.y+n, pos.z)] = c.stem_brown
			nodes[area:index(pos.x, pos.y+n, pos.z+i)] = c.stem_brown
		end

		for l = -1, 1, 1 do
			for k = 2, 3, 1 do
				nodes[area:index(pos.x+k*i, pos.y+height+2, pos.z+l)] = c.head_brown_full
				nodes[area:index(pos.x+l, pos.y+height+2, pos.z+k*i)] = c.head_brown_full
			end
			nodes[area:index(pos.x+l, pos.y+height+1, pos.z+o)] = c.head_brown_full
			nodes[area:index(pos.x+o, pos.y+height+1, pos.z+l)] = c.head_brown_full
		end

		for m = -1, 1, 2 do
			for k = 2, 3, 1 do
				for j = 2, 3, 1 do
					nodes[area:index(pos.x+j*i, pos.y+height+2, pos.z+k*m)] = ran_node(c.head_yellow, c.head_orange, 7)
				end
			end
			nodes[area:index(pos.x+i, pos.y+height+1, pos.z+m)] = c.head_brown_full
			nodes[area:index(pos.x+m*2, pos.y+height+1, pos.z+o)] = c.head_brown_full
		end

		for l = -3+1, 3, 1 do
			nodes[area:index(pos.x+3*i, pos.y+height+5, pos.z-l*i)] = ran_node(c.head_yellow, c.head_orange, 5)
			nodes[area:index(pos.x+l*i, pos.y+height+5, pos.z+3*i)] = ran_node(c.head_yellow, c.head_orange, 5)
		end

		for j = 0, 1, 1 do
			for l = -3, 3, 1 do
				nodes[area:index(pos.x+i*4, pos.y+height+3+j, pos.z+l)] = ran_node(c.head_yellow, c.head_orange, 6)
				nodes[area:index(pos.x+l, pos.y+height+3+j, pos.z+i*4)] = ran_node(c.head_yellow, c.head_orange, 6)
			end
		end

	end

	for k = -2, 2, 1 do
		for l = -2, 2, 1 do
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

	for i = 0, height, 1 do
		nodes[area:index(pos.x, pos.y+i, pos.z)] = c.stem_blue
	end

	for i = -1, 1, 2 do

		for k = -br, br, 2*br do
			for l = 2, height, 1 do
				nodes[area:index(pos.x+i*br, pos.y+l, pos.z+k)] = c.head_blue
			end
			nodes[area:index(pos.x+i*br, pos.y+1, pos.z+k)] = c.head_blue_bright
		end

		for l = -br+1, br, 1 do
			nodes[area:index(pos.x+i*br, pos.y+height, pos.z-l*i)] = c.head_blue
			nodes[area:index(pos.x+l*i, pos.y+height, pos.z+br*i)] = c.head_blue
		end

	end

	for l = 0, br, 1 do
		for i = -br+l, br-l, 1 do
			for k = -br+l, br-l, 1 do
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

	for _,j in ipairs({
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

	for l = -b, b, 1 do
		for j = 1, a-1, 1 do
			for k = -size, size, a do
				nodes[area:index(pos.x+k, pos.y+j, pos.z+l)] = c.red
				nodes[area:index(pos.x+l, pos.y+j, pos.z+k)] = c.red
			end
		end
		for i = -b, b, 1 do
			nodes[area:index(pos.x+i, pos.y, pos.z+l)] = c.red
			nodes[area:index(pos.x+i, pos.y+a, pos.z+l)] = c.red
		end
	end

	for i = a+1, a+b, 1 do
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


local tmp = minetest.registered_nodes["default:apple"]
minetest.register_node(":default:apple", {
	description = tmp.description,
	drawtype = "nodebox",
	visual_scale = tmp.visual_scale,
	tiles = {"3apple_apple_top.png","3apple_apple_bottom.png","3apple_apple.png"},
	inventory_image = tmp.inventory_image,
	sunlight_propagates = tmp.sunlight_propagates,
	walkable = tmp.walkable,
	paramtype = tmp.paramtype,
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
	groups = tmp.groups,
	on_use = tmp.on_use,
	sounds = tmp.sounds,
	after_place_node = tmp.after_place_node,
})



--Mushroom Nodes


local function pilz(name, desc, b, burntime)
	burntime = burntime or 1
	local box = {
		type = "fixed",
		fixed = b
	}
	minetest.register_node("riesenpilz:"..name, {
		description = desc,
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
end

local BOX = {
	RED = {
		{-1/16, -8/16, -1/16, 1/16, -6/16, 1/16},
		{-3/16, -6/16, -3/16, 3/16, -5/16, 3/16},
		{-4/16, -5/16, -4/16, 4/16, -4/16, 4/16},
		{-3/16, -4/16, -3/16, 3/16, -3/16, 3/16},
		{-2/16, -3/16, -2/16, 2/16, -2/16, 2/16}
	},
	BROWN = {
		{-0.15, -0.2, -0.15, 0.15, -0.1, 0.15},
		{-0.2, -0.3, -0.2, 0.2, -0.2, 0.2},
		{-0.05, -0.5, -0.05, 0.05, -0.3, 0.05}
	},
	FLY_AGARIC = {
		{-0.05, -0.5, -0.05, 0.05, 1/20, 0.05},
		{-3/20, -6/20, -3/20, 3/20, 0, 3/20},
		{-4/20, -2/20, -4/20, 4/20, -4/20, 4/20}
	},
	LAVASHROOM = {
		{-1/16, -8/16, -1/16, 1/16, -6/16, 1/16},
		{-2/16, -6/16, -2/16, 2/16,     0, 2/16},
		{-3/16, -5/16, -3/16, 3/16, -1/16, 3/16},
		{-4/16, -4/16, -4/16, 4/16, -2/16, 4/16}
	},
	GLOWSHROOM = {
		{-1/16, -8/16, -1/16, 1/16, -1/16, 1/16},
		{-2/16, -3/16, -2/16, 2/16, -2/16, 2/16},
		{-3/16, -5/16, -3/16, 3/16, -3/16, 3/16},
		{-3/16, -7/16, -3/16, -2/16, -5/16, -2/16},
		{3/16, -7/16, -3/16, 2/16, -5/16, -2/16},
		{-3/16, -7/16, 3/16, -2/16, -5/16, 2/16},
		{3/16, -7/16, 3/16, 2/16, -5/16, 2/16}
	},
	NETHER_SHROOM = {
		{-1/16, -8/16, -1/16, 1/16, -2/16, 1/16},
		{-2/16, -6/16, -2/16, 2/16, -5/16, 2/16},
		{-3/16, -2/16, -3/16, 3/16,     0, 3/16},
		{-4/16, -1/16, -4/16, 4/16,  1/16,-2/16},
		{-4/16, -1/16,  2/16, 4/16,  1/16, 4/16},
		{-4/16, -1/16, -2/16,-2/16,  1/16, 2/16},
		{ 2/16, -1/16, -2/16, 4/16,  1/16, 2/16}
	},
	PARASOL = {
		{-1/16, -8/16, -1/16, 1/16,  0, 1/16},
		{-2/16, -6/16, -2/16, 2/16, -5/16, 2/16},
		{-5/16, -4/16, -5/16, 5/16, -3/16, 5/16},
		{-4/16, -3/16, -4/16, 4/16, -2/16, 4/16},
		{-3/16, -2/16, -3/16, 3/16, -1/16, 3/16}
	},
	RED45 = {
		{-1/16, -0.5, -1/16, 1/16, 1/8, 1/16},
		{-3/16, 1/8, -3/16, 3/16, 1/4, 3/16},
		{-5/16, -1/4, -5/16, -1/16, 1/8, -1/16},
		{1/16, -1/4, -5/16, 5/16, 1/8, -1/16},
		{-5/16, -1/4, 1/16, -1/16, 1/8, 5/16},
		{1/16, -1/4, 1/16, 5/16, 1/8, 5/16}
	},
	BROWN45 = {
		{-1/16, -0.5, -1/16, 1/16, 1/16, 1/16},
		{-3/8, 1/8, -7/16, 3/8, 1/4, 7/16},
		{-7/16, 1/8, -3/8, 7/16, 1/4, 3/8},
		{-3/8, 1/4, -3/8, 3/8, 5/16, 3/8},
		{-3/8, 1/16, -3/8, 3/8, 1/8, 3/8}
	},
}


local mushrooms_list = {
	{"brown", "Brown Mushroom", BOX.BROWN},
	{"red", "Red Mushroom", BOX.RED},
	{"fly_agaric", "Fly Agaric", BOX.FLY_AGARIC},
	{"lavashroom", "Lavashroom", BOX.LAVASHROOM},
	{"glowshroom", "Glowshroom", BOX.GLOWSHROOM},
	{"nether_shroom", "Nether Mushroom", BOX.NETHER_SHROOM, 6},
	{"parasol", "Parasol Mushroom", BOX.PARASOL},
	{"red45", "45 Brown Mushroom", BOX.RED45},
	{"brown45", "45 Red Mushroom", BOX.BROWN45},
}

for _,i in ipairs(mushrooms_list) do
	pilz(i[1], i[2], i[3], i[4])
end



--Mushroom Blocks


local function pilznode(name, desc, textures, sapling)
minetest.register_node("riesenpilz:"..name, {
	description = desc,
	tiles = textures,
	groups = {oddly_breakable_by_hand=3},
	drop = {max_items = 1,
		items = {{items = {"riesenpilz:"..sapling},rarity = 20,},
				{items = {"riesenpilz:"..name},rarity = 1,}}},
})
end


local r = "riesenpilz_"
local h = "head_"
local s = "stem_"
local rh = r..h
local rs = r..s

local GS = "Giant Mushroom "
local GSH = GS.."Head "
local GSS = GS.."Stem "

local pilznode_list = {
	{"stem", GSS.."Beige", {rs.."top.png", rs.."top.png", "riesenpilz_stem.png"}, "stem"},
	{s.."brown", GSS.."Brown", {rs.."top.png", rs.."top.png", rs.."brown.png"}, s.."brown"},
	{s.."blue", GSS.."Blue", {rs.."top.png",rs.."top.png",rs.."blue.png"}, s.."blue"},
	{"lamellas", "Giant Mushroom Lamella", {"riesenpilz_lamellas.png"}, "lamellas"},
	{h.."red", GSH.."Red", {"riesenpilz_head.png", "riesenpilz_lamellas.png", "riesenpilz_head.png"}, "red"},
	{h.."orange", GSH.."Orange", {rh.."orange.png"}, "lavashroom"},
	{h.."yellow", GSH.."Yellow", {rh.."yellow.png"}, "lavashroom"},
	{h.."brown", GSH.."Brown", {r.."brown_top.png", r.."lamellas.png", r.."brown_top.png"}, "brown"},
	{h.."brown_full", GSH.."Full Brown", {r.."brown_top.png"},"brown"},
	{h.."blue_bright", GSH.."Blue Bright", {rh.."blue_bright.png"},"glowshroom"},
	{h.."blue", GSH.."Blue", {rh.."blue.png"},"glowshroom"},
	{h.."white", GSH.."White", {rh.."white.png"},"parasol"},
	{h.."binge", GSH.."Binge", {rh.."binge.png", rh.."white.png", rh.."binge.png"},"parasol"},
	{h.."brown_bright", GSH.."Brown Bright", {rh.."brown_bright.png", rh.."white.png", rh.."brown_bright.png"},"parasol"},
}

for _,i in ipairs(pilznode_list) do
	pilznode(i[1], i[2], i[3], i[4])
end


minetest.register_node("riesenpilz:head_red_side", {
	description = "Giant Mushroom Head Side",
	tiles = {"riesenpilz_head.png",	"riesenpilz_lamellas.png",	"riesenpilz_head.png",
					"riesenpilz_head.png",	"riesenpilz_head.png",	"riesenpilz_lamellas.png"},
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=3},
	drop = {max_items = 1,
		items = {{items = {"riesenpilz:fly_agaric"},rarity = 20,},
				{items = {"riesenpilz:head_red"},rarity = 1,}}},
})

minetest.register_node("riesenpilz:ground", {
	description = "Grass?",
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
	description = "Growingtool",
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
