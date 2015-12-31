--[[
function riesenpilz_circle(nam, pos, radius, rand, seed)
	local ra = seed
	for i = -radius, radius, 1 do
		for j = -radius, radius, 1 do
			if math.floor(	math.sqrt(i^2+j^2)	+0.5) == radius then
				random = PseudoRandom(ra)
				p={x=pos.x+i, y=pos.y, z=pos.z+j}
				if minetest.get_node(p).name == "air"
				and random:next(1,rand) == 1
				and minetest.get_node({x=pos.x+i, y=pos.y-1, z=pos.z+j}).name ~= "air" then
					minetest.add_node(p, {name=nam})
				end
				ra = ra+1
			end
		end
	end
end

						elseif pr:next(1,80) == 1 then
							riesenpilz_circle("riesenpilz:brown", boden, pr:next(2,3), 3, seed)
						elseif pr:next(1,90) == 1 then
							riesenpilz_circle("riesenpilz:red", boden, pr:next(3,4), 3, seed)
						elseif pr:next(1,100) == 1 then
							riesenpilz_circle("riesenpilz:fly_agaric", boden, 3, 3, seed)
						elseif pr:next(1,4000) == 1 then
							riesenpilz_circle("riesenpilz:lavashroom", boden, pr:next(4,5), 3, seed)
						elseif pr:next(1,5000) == 1 then
							riesenpilz_circle("riesenpilz:glowshroom", boden, 2, 3, seed)
]]
function riesenpilz_circle(nam, pos, radius, chance)
	for i = -radius, radius, 1 do
		for j = -radius, radius, 1 do
			if math.floor(	math.sqrt(i^2+j^2)	+0.5) == radius
			and minetest.get_node({x=pos.x+i, y=pos.y, z=pos.z+j}).name == "air"
			and math.random(1,chance) == 1
			and minetest.get_node({x=pos.x+i, y=pos.y-1, z=pos.z+j}).name == "riesenpilz:ground" then
				minetest.add_node({x=pos.x+i, y=pos.y, z=pos.z+j}, {name=nam})
			end
		end
	end
end

local function find_ground(pos, nodes)
	for _, evground in ipairs(nodes) do
		if minetest.get_node(pos).name == evground then
			return true
		end
	end
	return false
end

local GROUND	=	{"default:dirt_with_grass","default:dirt","default:sand","default:desert_sand"}
USUAL_STUFF =	{"default:leaves","default:apple","default:tree","default:cactus","default:papyrus"}
minetest.register_on_generated(function(minp, maxp, seed)
	if maxp.y >= -10 then
		local x0,z0,x1,z1 = minp.x,minp.z,maxp.x,maxp.z	-- Assume X and Z lengths are equal
		local env = minetest.env	--Should make things a bit faster.
		local perlin1 = env:get_perlin(11,3, 0.5, 200)	--Get map specific perlin

		--[[if not (perlin1:get2d({x=x0, y=z0}) > 0.53) and not (perlin1:get2d({x=x1, y=z1}) > 0.53)
		and not (perlin1:get2d({x=x0, y=z1}) > 0.53) and not (perlin1:get2d({x=x1, y=z0}) > 0.53)
		and not (perlin1:get2d({x=(x1-x0)/2, y=(z1-z0)/2}) > 0.53) then]]
		if not ( perlin1:get2d( {x=x0, y=z0} ) > 0.53 ) 					--top left
		and not ( perlin1:get2d( { x = x0 + ( (x1-x0)/2), y=z0 } ) > 0.53 )--top middle
		and not (perlin1:get2d({x=x1, y=z1}) > 0.53) 						--bottom right
		and not (perlin1:get2d({x=x1, y=z0+((z1-z0)/2)}) > 0.53) 			--right middle
		and not (perlin1:get2d({x=x0, y=z1}) > 0.53)  						--bottom left
		and not (perlin1:get2d({x=x1, y=z0}) > 0.53)						--top right
		and not (perlin1:get2d({x=x0+((x1-x0)/2), y=z1}) > 0.53) 			--left middle
		and not (perlin1:get2d({x=(x1-x0)/2, y=(z1-z0)/2}) > 0.53) 			--middle
		and not (perlin1:get2d({x=x0, y=z1+((z1-z0)/2)}) > 0.53) then		--bottom middle
			print("abortsumpf")
			return
		end
		local divs = (maxp.x-minp.x);
		local pr = PseudoRandom(seed+68)

		--remove usual stuff
		local trees = env:find_nodes_in_area(minp, maxp, USUAL_STUFF)
		for i,v in pairs(trees) do
			env:remove_node(v)
		end

		--Information:
		local geninfo = "-#- giant mushrooms generate: x=["..minp.x.."; "..maxp.x.."] z=["..minp.z.."; "..maxp.z.."]"
		print(geninfo)
		minetest.chat_send_all(geninfo)

		local smooth = riesenpilz.smooth

		for j=0,divs do
			for i=0,divs do
				local x,z = x0+i,z0+j

				--Check if we are in a "riesenpilz biome"
				local in_biome = false
				local test = perlin1:get2d({x=x, y=z})
				--smooth mapgen
				if smooth and (test > 0.73 or (test > 0.43 and pr:next(0,29) > (0.73 - test) * 100 )) then
					in_biome = true
				elseif (not smooth) and test > 0.53 then
					in_biome = true
				end

				if in_biome then

					local ground_y = nil --Definition des Bodens:
					for y=maxp.y,0,-1 do
						if find_ground({x=x,y=y,z=z}, GROUND) then
							ground_y = y
							break
						end
					end
					if ground_y then
						env:add_node({x=x,y=ground_y,z=z}, {name="riesenpilz:ground"})
						for i = -1,-5,-1 do
							local pos = {x=x,y=ground_y+i,z=z}
							if env:get_node(pos).name == "default:desert_sand" then
								env:add_node(pos, {name="default:dirt"})
							else
								break
							end
						end
						local boden = {x=x,y=ground_y+1,z=z}
						if pr:next(1,15) == 1 then
							env:add_node(boden, {name="default:dry_shrub"})
						elseif pr:next(1,80) == 1 then
							riesenpilz_circle("riesenpilz:brown", boden, pr:next(3,4), 3)
						elseif pr:next(1,90) == 1 then
							riesenpilz_circle("riesenpilz:red", boden, pr:next(4,5), 3)
						elseif pr:next(1,100) == 1 then
							riesenpilz_circle("riesenpilz:fly_agaric", boden, 4, 3)
						elseif pr:next(1,4000) == 1 then
							riesenpilz_circle("riesenpilz:lavashroom", boden, pr:next(5,6), 3)
						elseif pr:next(1,5000) == 1 then
							riesenpilz_circle("riesenpilz:glowshroom", boden, 3, 3)
						--[[elseif pr:next(1,80) == 1 then
							env:add_node(boden, {name="riesenpilz:brown"})
						elseif pr:next(1,90) == 1 then
							env:add_node(boden, {name="riesenpilz:red"})
						elseif pr:next(1,100) == 1 then
							env:add_node(boden, {name="riesenpilz:fly_agaric"})
						elseif pr:next(1,4000) == 1 then
							env:add_node(boden, {name="riesenpilz:lavashroom"})
						elseif pr:next(1,5000) == 1 then
							env:add_node(boden, {name="riesenpilz:glowshroom"})]]
						elseif pr:next(1,380) == 1 then
							riesenpilz_hybridpilz(boden)
						elseif pr:next(1,340) == 10 then
							riesenpilz_brauner_minecraftpilz(boden)
						elseif pr:next(1,390) == 20 then
							riesenpilz_minecraft_fliegenpilz(boden)
						elseif pr:next(1,6000) == 2 and pr:next(1,200) == 15 then
							riesenpilz_lavashroom(boden)
						end
					end
				end
			end
		end
	end
	if maxp.y < -10 then
		local x0,z0,x1,z1 = minp.x,minp.z,maxp.x,maxp.z	-- Assume X and Z lengths are equal
		local env = minetest.env	--Should make things a bit faster.
		local perlin1 = env:get_perlin(11,3, 0.5, 200)	--Get map specific perlin

		--[[if not (perlin1:get2d({x=x0, y=z0}) > 0.53) and not (perlin1:get2d({x=x1, y=z1}) > 0.53)
		and not (perlin1:get2d({x=x0, y=z1}) > 0.53) and not (perlin1:get2d({x=x1, y=z0}) > 0.53)
		and not (perlin1:get2d({x=(x1-x0)/2, y=(z1-z0)/2}) > 0.53) then]]
		if not ( perlin1:get2d( {x=x0, y=z0} ) > 0.53 ) 					--top left
		and not ( perlin1:get2d( { x = x0 + ( (x1-x0)/2), y=z0 } ) > 0.53 )--top middle
		and not (perlin1:get2d({x=x1, y=z1}) > 0.53) 						--bottom right
		and not (perlin1:get2d({x=x1, y=z0+((z1-z0)/2)}) > 0.53) 			--right middle
		and not (perlin1:get2d({x=x0, y=z1}) > 0.53)  						--bottom left
		and not (perlin1:get2d({x=x1, y=z0}) > 0.53)						--top right
		and not (perlin1:get2d({x=x0+((x1-x0)/2), y=z1}) > 0.53) 			--left middle
		and not (perlin1:get2d({x=(x1-x0)/2, y=(z1-z0)/2}) > 0.53) 			--middle
		and not (perlin1:get2d({x=x0, y=z1+((z1-z0)/2)}) > 0.53) then		--bottom middle
			print("abortsumpf")
			return
		end
		local divs = (maxp.x-minp.x);
		local pr = PseudoRandom(seed+68)

		for j=0,divs do
			for i=0,divs do
				local x,z = x0+i,z0+j

				for y=minp.y,maxp.y,1 do
					local pos = {x=x, y=y, z=z}

					if env:get_node(pos).name == "air"
					and env:get_node({x=x, y=y-1, z=z}).name == "default:stone"
					and pr:next(1,40) == 33
					and env:find_node_near(pos, 4, "group:igniter")
					and not env:find_node_near(pos, 3, "group:igniter") then
						env:add_node(pos, {name="riesenpilz:lavashroom"})
					end
				end
			end
		end
	end
end)
