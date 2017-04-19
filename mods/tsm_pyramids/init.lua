pyramids = {}
pyramids.max_time = 30*60

dofile(minetest.get_modpath("tsm_pyramids").."/mummy.lua")
dofile(minetest.get_modpath("tsm_pyramids").."/nodes.lua")
dofile(minetest.get_modpath("tsm_pyramids").."/room.lua")

local chest_stuff = {
	{name="default:apple", max = 3},
	{name="farming:bread", max = 3},
	{name="default:steel_ingot", max = 2},
	{name="default:gold_ingot", max = 2},
	{name="default:diamond", max = 1},
	{name="default:pick_steel", max = 1},
	{name="default:pick_diamond", max = 1}

}

function pyramids.fill_chest(pos)
	local n = minetest.get_node_or_nil(pos)
	if n and n.name and n.name == "tsm_pyramids:chest" then
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
		inv:set_list("main",
			{
				[1] = "",
				[32] = ""
			}
		)
		if math.random(1,10) < 7 then return end
		local stacks = {}
		if minetest.get_modpath("treasurer") ~= nil then
			stacks = treasurer.select_random_treasures()
		else
			for i=0,2,1 do
				local stuff = chest_stuff[math.random(1,#chest_stuff)]
				if stuff.name == "farming:bread" and not minetest.get_modpath("farming") then stuff = chest_stuff[1] end
				table.insert(stacks, {name=stuff.name, count = math.random(1,stuff.max)})
			end
		end
		for s=1,#stacks do
			if not inv:contains_item("main", stacks[s]) then
				inv:set_stack("main", math.random(1,32), stacks[s])
			end
		end
	end
end

local function add_spawner(pos)
	minetest.set_node(pos, {name="tsm_pyramids:spawner_mummy"})
	if not minetest.setting_getbool("only_peaceful_mobs") then pyramids.spawn_mummy({x=pos.x,y=pos.y,z=pos.z-2},2) end
end

local function can_replace(pos)
	local n = minetest.get_node_or_nil(pos)
	if n and n.name and minetest.registered_nodes[n.name] and not minetest.registered_nodes[n.name].walkable then
		return true
	elseif not n then
		return true
	else
		return false
	end
end

local function underground(pos)
	local p2 = pos
	local cnt = 0
	local mat = "desert_sand"
	p2.y = p2.y-1
	while can_replace(p2)==true do
		cnt = cnt+1
		if cnt > 25 then break end
		if cnt>math.random(2,4) then mat = "desert_stone" end
		minetest.set_node(p2, {name="default:"..mat})
		p2.y = p2.y-1
	end
end

local function make_entrance(pos)
	local gang = {x=pos.x+10,y=pos.y, z=pos.z}
	for iy=2,3,1 do
		for iz=0,6,1 do
			minetest.remove_node({x=gang.x+1,y=gang.y+iy,z=gang.z+iz})
			if iz >=3 and iy == 3 then
				minetest.set_node({x=gang.x,y=gang.y+iy+1,z=gang.z+iz}, {name="maptools:sandstone_brick"})
				minetest.set_node({x=gang.x+1,y=gang.y+iy+1,z=gang.z+iz}, {name="maptools:sandstone_brick"})
				minetest.set_node({x=gang.x+2,y=gang.y+iy+1,z=gang.z+iz}, {name="maptools:sandstone_brick"})
			end
		end
	end
end

function pyramids.make(pos)
	minetest.log("action", "Created pyramid at ("..pos.x..","..pos.y..","..pos.z..")")
	for iy=0,10,1 do
		for ix=iy,22-iy,1 do
			for iz=iy,22-iy,1 do
				if iy <1 then underground({x=pos.x+ix,y=pos.y,z=pos.z+iz}) end
				minetest.set_node({x=pos.x+ix,y=pos.y+iy,z=pos.z+iz}, {name="maptools:sandstone_brick"})
				for yy=1,10-iy,1 do
					local n = minetest.get_node({x=pos.x+ix,y=pos.y+iy+yy,z=pos.z+iz})
					if n and n.name and n.name == "default:desert_stone" then minetest.set_node({x=pos.x+ix,y=pos.y+iy+yy,z=pos.z+iz},{name="default:desert_sand"}) end
				end
			end
		end
	end

	pyramids.make_room(pos)
	minetest.after(2, pyramids.make_traps, pos)
	add_spawner({x=pos.x+11,y=pos.y+2, z=pos.z+17})
	make_entrance({x=pos.x,y=pos.y, z=pos.z})
end

local perl1 = {SEED1 = 9130, OCTA1 = 3,	PERS1 = 0.5, SCAL1 = 250} -- Values should match minetest mapgen V6 desert noise.

local function hlp_fnct(pos, name)
	local n = minetest.get_node_or_nil(pos)
	if n and n.name and n.name == name then
		return true
	else
		return false
	end
end

local function ground(pos, old)
	local p2 = pos
	while hlp_fnct(p2, "air") do
		p2.y = p2.y -1
	end
	if p2.y < old.y then
		return p2
	else
		return old
	end
end


minetest.register_on_generated(function(minp, maxp, seed)
	minetest.after(3, function(minp, maxp, seed)

		if maxp.y < 0 then return end
		math.randomseed(seed)
		local cnt = 0

		local perlin1 = minetest.get_perlin(perl1.SEED1, perl1.OCTA1, perl1.PERS1, perl1.SCAL1)
		local noise1 = perlin1:get2d({x=minp.x,y=minp.y})--,z=minp.z})

		if noise1 > 0.25 or noise1 < -0.26 and math.random(1,100) % 2 == 0 then -- Coward attempt to divide per 2 the spawn rate
			local mpos = {x=math.random(minp.x,maxp.x), y=math.random(minp.y,maxp.y), z=math.random(minp.z,maxp.z)}

			local p2 = minetest.find_node_near(mpos, 25, {"default:desert_sand"})
			while p2 == nil and cnt < 5 do
				cnt = cnt+1
				mpos = {x=math.random(minp.x,maxp.x), y=math.random(minp.y,maxp.y), z=math.random(minp.z,maxp.z)}
				p2 = minetest.find_node_near(mpos, 25, {"default:desert_sand"})
			end
			if p2 == nil then return end
			if p2.y < 0 then return end

			local off = 0
			local opos1 = {x=p2.x+22,y=p2.y-1,z=p2.z+22}
			local opos2 = {x=p2.x+22,y=p2.y-1,z=p2.z}
			local opos3 = {x=p2.x,y=p2.y-1,z=p2.z+22}
			local opos1_n = minetest.get_node_or_nil(opos1)
			local opos2_n = minetest.get_node_or_nil(opos2)
			local opos3_n = minetest.get_node_or_nil(opos3)
			if opos1_n and opos1_n.name and opos1_n.name == "air" then
				p2 = ground(opos1, p2)
			end
			if opos2_n and opos2_n.name and opos2_n.name == "air" then
				p2 = ground(opos2, p2)
			end
			if opos3_n and opos3_n.name and opos3_n.name == "air" then
				p2 = ground(opos3, p2)
			end
			p2.y = p2.y - 3
			if p2.y < 0 then p2.y = 0 end
			if minetest.find_node_near(p2, 25, {"default:water_source"}) ~= nil
			or minetest.find_node_near(p2, 22, {"default:dirt_with_grass"}) ~= nil
			or minetest.find_node_near(p2, 52, {"maptools:sandstone_brick"}) ~= nil then return end

			if math.random(0,10) > 7 then return end
			pyramids.make(p2)
		end
	end, minp, maxp, seed)
end)
