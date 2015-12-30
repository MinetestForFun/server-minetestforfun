--[[ Nether leaves
minetest.register_node("nether:leaves", {
	description = "Nether Leaves",
	drawtype = "allfaces_optional",
--	visual_scale = 1.189, --scale^2=sqrt(2)
	tiles = {"nether_leaves.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=2},
	sounds = default.node_sound_leaves_defaults(),
})]]

--[[ Nether Lava
minetest.register_node("nether:lava_flowing", {
	description = "Nether Lava (flowing)",
	inventory_image = minetest.inventorycube("default_lava.png"),
	drawtype = "flowingliquid",
	tiles = {"default_lava.png"},
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "flowing",
	liquid_alternative_flowing = "nether:lava_flowing",
	liquid_alternative_source = "default:lava_source",
	liquid_viscosity = LAVA_VISC,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	special_materials = {
		{image="default_lava.png", backface_culling=false},
		{image="default_lava.png", backface_culling=true},
	},
	groups = {lava=3, liquid=2, hot=3},
})

minetest.register_node("nether:lava_source", {
	description = "Nether Lava",
	inventory_image = minetest.inventorycube("default_lava.png"),
	drawtype = "liquid",
	tiles = {"default_lava.png"},
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "nether:lava_flowing",
	liquid_alternative_source = "default:lava_source",
	liquid_viscosity = LAVA_VISC,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	special_materials = {
		-- New-style lava source material (mostly unused)
		{image="default_lava.png", backface_culling=false},
	},
	groups = {lava=3, liquid=2, hot=3},
})]]

-- Throne of Hades
HADES_THRONE = {
	-- Lava Moat
	{pos={x=-1,y=-1,z=-1}, block="default:lava_source"},
	{pos={x=-1,y=-1,z=0}, block="default:lava_source"},
	{pos={x=-1,y=-1,z=1}, block="default:lava_source"},
	{pos={x=-1,y=-1,z=2}, block="default:lava_source"},
	{pos={x=-1,y=-1,z=3}, block="default:lava_source"},
	{pos={x=-1,y=-1,z=4}, block="default:lava_source"},
	{pos={x=-1,y=-1,z=5}, block="default:lava_source"},
	{pos={x=-1,y=-1,z=6}, block="default:lava_source"},
	{pos={x=-1,y=-1,z=7}, block="default:lava_source"},
	{pos={x=0,y=-1,z=7}, block="default:lava_source"},
	{pos={x=1,y=-1,z=7}, block="default:lava_source"},
	{pos={x=2,y=-1,z=7}, block="default:lava_source"},
	{pos={x=3,y=-1,z=7}, block="default:lava_source"},
	{pos={x=4,y=-1,z=7}, block="default:lava_source"},
	{pos={x=5,y=-1,z=7}, block="default:lava_source"},
	{pos={x=6,y=-1,z=7}, block="default:lava_source"},
	{pos={x=6,y=-1,z=6}, block="default:lava_source"},
	{pos={x=6,y=-1,z=5}, block="default:lava_source"},
	{pos={x=6,y=-1,z=4}, block="default:lava_source"},
	{pos={x=6,y=-1,z=3}, block="default:lava_source"},
	{pos={x=6,y=-1,z=2}, block="default:lava_source"},
	{pos={x=6,y=-1,z=1}, block="default:lava_source"},
	{pos={x=6,y=-1,z=0}, block="default:lava_source"},
	{pos={x=6,y=-1,z=-1}, block="default:lava_source"},
	{pos={x=5,y=-1,z=-1}, block="default:lava_source"},
	{pos={x=4,y=-1,z=-1}, block="default:lava_source"},
	{pos={x=3,y=-1,z=-1}, block="default:lava_source"},
	{pos={x=2,y=-1,z=-1}, block="default:lava_source"},
	{pos={x=1,y=-1,z=-1}, block="default:lava_source"},
	{pos={x=0,y=-1,z=-1}, block="default:lava_source"},
	-- Floor 1
	{pos={x=0,y=0,z=0}, block="nether:netherrack"},
	{pos={x=0,y=0,z=1}, block="nether:netherrack"},
	{pos={x=0,y=0,z=2}, block="nether:netherrack"},
	{pos={x=0,y=0,z=3}, block="nether:netherrack"},
	{pos={x=0,y=0,z=4}, block="nether:netherrack"},
	{pos={x=0,y=0,z=5}, block="nether:netherrack"},
	{pos={x=1,y=0,z=5}, block="nether:netherrack"},
	{pos={x=2,y=0,z=5}, block="nether:netherrack"},
	{pos={x=3,y=0,z=5}, block="nether:netherrack"},
	{pos={x=4,y=0,z=5}, block="nether:netherrack"},
	{pos={x=5,y=0,z=5}, block="nether:netherrack"},
	{pos={x=0,y=0,z=6}, block="nether:netherrack"},
	{pos={x=1,y=0,z=6}, block="nether:netherrack"},
	{pos={x=2,y=0,z=6}, block="nether:netherrack"},
	{pos={x=3,y=0,z=6}, block="nether:netherrack"},
	{pos={x=4,y=0,z=6}, block="nether:netherrack"},
	{pos={x=5,y=0,z=6}, block="nether:netherrack"},
	{pos={x=5,y=0,z=4}, block="nether:netherrack"},
	{pos={x=5,y=0,z=3}, block="nether:netherrack"},
	{pos={x=5,y=0,z=2}, block="nether:netherrack"},
	{pos={x=5,y=0,z=1}, block="nether:netherrack"},
	{pos={x=5,y=0,z=0}, block="nether:netherrack"},
	{pos={x=4,y=0,z=0}, block="nether:netherrack"},
	{pos={x=3,y=0,z=0}, block="nether:netherrack"},
	{pos={x=2,y=0,z=0}, block="nether:netherrack"},
	{pos={x=1,y=0,z=0}, block="nether:netherrack"},
	-- Floor 2
	{pos={x=0,y=1,z=0}, block="nether:netherrack"},
	{pos={x=0,y=1,z=1}, block="nether:netherrack"},
	{pos={x=0,y=1,z=2}, block="nether:netherrack"},
	{pos={x=0,y=1,z=3}, block="nether:netherrack"},
	{pos={x=0,y=1,z=4}, block="nether:netherrack"},
	{pos={x=0,y=1,z=5}, block="nether:netherrack"},
	{pos={x=1,y=1,z=5}, block="nether:netherrack"},
	{pos={x=2,y=1,z=5}, block="nether:netherrack"},
	{pos={x=3,y=1,z=5}, block="nether:netherrack"},
	{pos={x=4,y=1,z=5}, block="nether:netherrack"},
	{pos={x=5,y=1,z=5}, block="nether:netherrack"},
	{pos={x=0,y=1,z=6}, block="nether:netherrack"},
	{pos={x=1,y=1,z=6}, block="nether:netherrack"},
	{pos={x=2,y=1,z=6}, block="nether:netherrack"},
	{pos={x=3,y=1,z=6}, block="nether:netherrack"},
	{pos={x=4,y=1,z=6}, block="nether:netherrack"},
	{pos={x=5,y=1,z=6}, block="nether:netherrack"},
	{pos={x=5,y=1,z=4}, block="nether:netherrack"},
	{pos={x=5,y=1,z=3}, block="nether:netherrack"},
	{pos={x=5,y=1,z=2}, block="nether:netherrack"},
	{pos={x=5,y=1,z=1}, block="nether:netherrack"},
	{pos={x=5,y=1,z=0}, block="nether:netherrack"},
	{pos={x=4,y=1,z=0}, block="nether:netherrack"},
	{pos={x=3,y=1,z=1}, block="nether:netherrack"},
	{pos={x=2,y=1,z=1}, block="nether:netherrack"},
	{pos={x=1,y=1,z=0}, block="nether:netherrack"},
	{pos={x=1,y=1,z=1}, block="nether:netherrack"},
	{pos={x=4,y=1,z=1}, block="nether:netherrack"},
	-- Floor 3
	{pos={x=0,y=2,z=0}, block="nether:netherrack"},
	{pos={x=0,y=2,z=1}, block="nether:netherrack"},
	{pos={x=0,y=2,z=2}, block="nether:netherrack"},
	{pos={x=0,y=2,z=3}, block="nether:netherrack"},
	{pos={x=0,y=2,z=4}, block="nether:netherrack"},
	{pos={x=0,y=2,z=5}, block="nether:netherrack"},
	{pos={x=1,y=2,z=5}, block="nether:netherrack"},
	{pos={x=2,y=2,z=5}, block="nether:netherrack"},
	{pos={x=3,y=2,z=5}, block="nether:netherrack"},
	{pos={x=4,y=2,z=5}, block="nether:netherrack"},
	{pos={x=5,y=2,z=5}, block="nether:netherrack"},
	{pos={x=0,y=2,z=6}, block="nether:netherrack"},
	{pos={x=1,y=2,z=6}, block="nether:netherrack"},
	{pos={x=2,y=2,z=6}, block="nether:netherrack"},
	{pos={x=3,y=2,z=6}, block="nether:netherrack"},
	{pos={x=4,y=2,z=6}, block="nether:netherrack"},
	{pos={x=5,y=2,z=6}, block="nether:netherrack"},
	{pos={x=5,y=2,z=4}, block="nether:netherrack"},
	{pos={x=5,y=2,z=3}, block="nether:netherrack"},
	{pos={x=5,y=2,z=2}, block="nether:netherrack"},
	{pos={x=5,y=2,z=1}, block="nether:netherrack"},
	{pos={x=5,y=2,z=0}, block="nether:netherrack"},
	{pos={x=4,y=2,z=0}, block="nether:netherrack"},
	{pos={x=3,y=2,z=2}, block="nether:netherrack"},
	{pos={x=2,y=2,z=2}, block="nether:netherrack"},
	{pos={x=1,y=2,z=0}, block="nether:netherrack"},
	{pos={x=1,y=2,z=1}, block="nether:netherrack"},
	{pos={x=4,y=2,z=1}, block="nether:netherrack"},
	{pos={x=1,y=2,z=2}, block="nether:netherrack"},
	{pos={x=4,y=2,z=2}, block="nether:netherrack"},
	-- Floor 4
	{pos={x=0,y=3,z=0}, block="nether:netherrack"},
	{pos={x=0,y=3,z=1}, block="nether:netherrack"},
	{pos={x=0,y=3,z=2}, block="nether:netherrack"},
	{pos={x=0,y=3,z=3}, block="nether:netherrack"},
	{pos={x=0,y=3,z=4}, block="nether:netherrack"},
	{pos={x=0,y=3,z=5}, block="nether:netherrack"},
	{pos={x=1,y=3,z=5}, block="nether:netherrack"},
	{pos={x=2,y=3,z=5}, block="nether:netherrack"},
	{pos={x=3,y=3,z=5}, block="nether:netherrack"},
	{pos={x=4,y=3,z=5}, block="nether:netherrack"},
	{pos={x=5,y=3,z=5}, block="nether:netherrack"},
	{pos={x=0,y=3,z=6}, block="nether:netherrack"},
	{pos={x=1,y=3,z=6}, block="nether:netherrack"},
	{pos={x=2,y=3,z=6}, block="nether:netherrack"},
	{pos={x=3,y=3,z=6}, block="nether:netherrack"},
	{pos={x=4,y=3,z=6}, block="nether:netherrack"},
	{pos={x=5,y=3,z=6}, block="nether:netherrack"},
	{pos={x=5,y=3,z=4}, block="nether:netherrack"},
	{pos={x=5,y=3,z=3}, block="nether:netherrack"},
	{pos={x=5,y=3,z=2}, block="nether:netherrack"},
	{pos={x=5,y=3,z=1}, block="nether:netherrack"},
	{pos={x=5,y=3,z=0}, block="nether:netherrack"},
	{pos={x=4,y=3,z=0}, block="nether:netherrack"},
	{pos={x=3,y=3,z=3}, block="nether:netherrack"},
	{pos={x=2,y=3,z=3}, block="nether:netherrack"},
	{pos={x=1,y=3,z=0}, block="nether:netherrack"},
	{pos={x=1,y=3,z=1}, block="nether:netherrack"},
	{pos={x=4,y=3,z=1}, block="nether:netherrack"},
	{pos={x=1,y=3,z=2}, block="nether:netherrack"},
	{pos={x=4,y=3,z=2}, block="nether:netherrack"},
	{pos={x=1,y=3,z=3}, block="nether:netherrack"},
	{pos={x=4,y=3,z=3}, block="nether:netherrack"},
	{pos={x=1,y=3,z=4}, block="nether:netherrack"},
	{pos={x=4,y=3,z=4}, block="nether:netherrack"},
	{pos={x=2,y=3,z=4}, block="nether:netherrack"},
	{pos={x=2,y=3,z=5}, block="nether:netherrack"},
	{pos={x=3,y=3,z=4}, block="nether:netherrack"},
	{pos={x=3,y=3,z=5}, block="nether:netherrack"},
	-- Floor 5
	{pos={x=2,y=4,z=4}, block="nether:netherrack"},
	{pos={x=2,y=4,z=5}, block="nether:netherrack"},
	{pos={x=3,y=4,z=4}, block="nether:netherrack"},
	{pos={x=3,y=4,z=5}, block="nether:netherrack"},
	{pos={x=2,y=4,z=6}, block="nether:netherrack"},
	{pos={x=3,y=4,z=6}, block="nether:netherrack"},
	-- Torches on floor 5
	{pos={x=0,y=4,z=4}, block="nether:torch_bottom"},
	{pos={x=1,y=4,z=4}, block="nether:torch_bottom"},
	{pos={x=0,y=4,z=5}, block="nether:torch_bottom"},
	{pos={x=1,y=4,z=5}, block="nether:torch_bottom"},
	{pos={x=4,y=4,z=4}, block="nether:torch_bottom"},
	{pos={x=5,y=4,z=4}, block="nether:torch_bottom"},
	{pos={x=4,y=4,z=5}, block="nether:torch_bottom"},
	{pos={x=5,y=4,z=5}, block="nether:torch_bottom"},
	{pos={x=0,y=4,z=0}, block="nether:torch_bottom"},
	{pos={x=1,y=4,z=0}, block="nether:torch_bottom"},
	{pos={x=0,y=4,z=1}, block="nether:torch_bottom"},
	{pos={x=1,y=4,z=1}, block="nether:torch_bottom"},
	{pos={x=4,y=4,z=0}, block="nether:torch_bottom"},
	{pos={x=5,y=4,z=0}, block="nether:torch_bottom"},
	{pos={x=4,y=4,z=1}, block="nether:torch_bottom"},
	{pos={x=5,y=4,z=1}, block="nether:torch_bottom"},
	{pos={x=0,y=4,z=2}, block="nether:torch_bottom"},
	{pos={x=1,y=4,z=2}, block="nether:torch_bottom"},
	{pos={x=0,y=4,z=3}, block="nether:torch_bottom"},
	{pos={x=1,y=4,z=3}, block="nether:torch_bottom"},
	{pos={x=4,y=4,z=2}, block="nether:torch_bottom"},
	{pos={x=5,y=4,z=2}, block="nether:torch_bottom"},
	{pos={x=4,y=4,z=3}, block="nether:torch_bottom"},
	{pos={x=5,y=4,z=3}, block="nether:torch_bottom"},
	{pos={x=4,y=4,z=6}, block="nether:torch_bottom"},
	{pos={x=5,y=4,z=6}, block="nether:torch_bottom"},
	{pos={x=0,y=4,z=6}, block="nether:torch_bottom"},
	{pos={x=1,y=4,z=6}, block="nether:torch_bottom"},
	-- Nether Portal
	{pos={x=1,y=5,z=6}, portalblock=true},
}


minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y <= 99 then
		return
	end
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}

	local perlin1 = minetest.get_perlin(13,3, 0.5, 50)	--Get map specific perlin
	local perlin2 = minetest.get_perlin(133,3, 0.5, 10)
	for x=minp.x, maxp.x, 1 do
		for z=minp.z, maxp.z, 1 do
			local test = perlin1:get2d({x=x, y=z})+1
			local test2 = perlin2:get2d({x=x, y=z})
--			print(test)
			if test2 < 0 then
				h = 200+math.floor(test2*3+0.5)
			else
				h = 203+math.floor(test*3+0.5)
			end
			for y=minp.y, maxp.y, 1 do
				p_addpos = area:index(x, y, z)
				if y <= h then
					data[p_addpos] = c_netherrack
				elseif y <= 201 then
					data[p_addpos] = c_lava
				end
			end
		end
	end

	vm:set_data(data)
	--vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:update_liquids()
	vm:write_to_map()
end)


We don't want the Throne of Hades to get regenerated (especially since it will screw up portals)
	if (minp.x <= HADES_THRONE_STARTPOS_ABS.x)
	and (maxp.x >= HADES_THRONE_STARTPOS_ABS.x)
	and (minp.y <= HADES_THRONE_STARTPOS_ABS.y)
	and (maxp.y >= HADES_THRONE_STARTPOS_ABS.y)
	and (minp.z <= HADES_THRONE_STARTPOS_ABS.z)
	and (maxp.z >= HADES_THRONE_STARTPOS_ABS.z)
	and (nether:fileexists(HADES_THRONE_GENERATED) == false) then
		-- Pass 3: Make way for the Throne of Hades!
		for x=(HADES_THRONE_STARTPOS_ABS.x - 1), (HADES_THRONE_ENDPOS_ABS.x + 1), 1 do
			for z=(HADES_THRONE_STARTPOS_ABS.z - 1), (HADES_THRONE_ENDPOS_ABS.z + 1), 1 do
				-- Notice I did not put a -1 for the beginning. This is because we don't want the throne to float
				for y=HADES_THRONE_STARTPOS_ABS.y, (HADES_THRONE_ENDPOS_ABS.y + 1), 1 do
					addpos = {x=x, y=y, z=z}
					minetest.add_node(addpos, {name="air"})
				end
			end
		end
		-- Pass 4: Throne of Hades
		for i,v in ipairs(HADES_THRONE_ABS) do
			if v.portalblock == true then
				NETHER_PORTALS_FROM_NETHER[table.getn(NETHER_PORTALS_FROM_NETHER)+1] = v.pos
				nether:save_portal_from_nether(v.pos)
				nether:createportal(v.pos)
			else
				minetest.add_node(v.pos, {name=v.block})
			end
		end
		nether:touch(HADES_THRONE_GENERATED)
	end

--[[ Create a nether tree
function nether:grow_nethertree(pos)
	--TRUNK
	pos.y=pos.y+1
	local trunkpos={x=pos.x, z=pos.z}
	for y=pos.y, pos.y+4+math.random(2) do
		trunkpos.y=y
		minetest.add_node(trunkpos, {name="nether:tree"})
	end
	--LEAVES
	local leafpos={}
	for x=(trunkpos.x-NETHER_TREESIZE), (trunkpos.x+NETHER_TREESIZE), 1 do
		for y=(trunkpos.y-NETHER_TREESIZE), (trunkpos.y+NETHER_TREESIZE), 1 do
			for z=(trunkpos.z-NETHER_TREESIZE), (trunkpos.z+NETHER_TREESIZE), 1 do
				if (x-trunkpos.x)*(x-trunkpos.x)
				+(y-trunkpos.y)*(y-trunkpos.y)
				+(z-trunkpos.z)*(z-trunkpos.z)
				<= NETHER_TREESIZE*NETHER_TREESIZE + NETHER_TREESIZE then
					leafpos={x=x, y=y, z=z}
					if minetest.get_node(leafpos).name=="air" then
						if math.random(NETHER_APPLE_FREQ) == 1 then
							if math.random(NETHER_HEAL_APPLE_FREQ) == 1 then
								minetest.add_node(leafpos, {name="default:apple"})
							else
								minetest.add_node(leafpos, {name="nether:apple"})
							end
						else
							minetest.add_node(leafpos, {name="nether:leaves"})
						end				
					end				
				end
			end
		end
	end
end]]
