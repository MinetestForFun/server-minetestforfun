--[[
--=================
--======================================
LazyJ's Fork of Splizard's "Snow" Mod
by LazyJ
version: Umpteen and 7/5ths something or another.
2014_04_12
--======================================
--=================


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
THE LIST OF CHANGES I'VE MADE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


* Falling snow would destroy nodes it deposited snow on. I figured out that if
I switched the 'snow.place' with 'minetest.place_node' and increased the
y position by 2, then the nodes were nolonger destroyed and the snow
would start to pile up.



~~~~~~
TODO
~~~~~~

* Add code to prevent snowfall from depositing snow on or
near torches and lava.

* Add code to prevent snowfall from depositing snow on
'walkable = false' defined nodes.

--]]



--=============================================================
-- CODE STUFF
--=============================================================


if snow.enable_snowfall then

	local weather_legacy
	
	local read_weather_legacy = function ()
		local file = io.open(minetest.get_worldpath().."/weather_v6", "r")
		if not file then return end
		local readweather = file:read()
		file:close()
		return readweather
	end
	
	--Weather for legacy versions of minetest.
	local save_weather_legacy = function ()
		local file = io.open(minetest.get_worldpath().."/weather_v6", "w+")
		file:write(weather_legacy)
		file:close()
	end
	
		weather_legacy = read_weather_legacy() or ""

		minetest.register_globalstep(function(dtime)
			if weather_legacy == "snow" then
				if math.random(1, 10000) == 1 then
					weather_legacy = "none"
					save_weather_legacy()
				end
			else
				if math.random(1, 50000) == 2 then
					weather_legacy = "snow"
					save_weather_legacy()
				end
			end
		end)
	
	--Get snow at position.
	local get_snow = function(pos)
		--Legacy support.
		if weather_legacy == "snow" then
			local perlin1 = minetest.env:get_perlin(112,3, 0.5, 150)
			if perlin1:get2d( {x=pos.x, y=pos.z} ) > 0.53 then
				return true
			else
				return false
			end
		else
			return false
		end
	end
	
	local addvectors = vector and vector.add
	
	--Returns a random position between minp and maxp.
	local randpos = function (minp, maxp)
		local x,y,z
		if minp.x > maxp.x then
			x = math.random(maxp.x,minp.x) else x = math.random(minp.x,maxp.x) end
			y = minp.y
		if minp.z > maxp.z then
			z = math.random(maxp.z,minp.z) else z = math.random(minp.z,maxp.z) end
		return {x=x,y=y,z=z}
	end

	local snow_fall=function (pos, player, animate)
			local ground_y = nil
			for y=pos.y+10,pos.y+20,1 do
				local n = minetest.env:get_node({x=pos.x,y=y,z=pos.z}).name
				if n ~= "air" and n ~= "ignore" then
					return
				end
			end
			for y=pos.y+10,pos.y-15,-1 do
				local n = minetest.env:get_node({x=pos.x,y=y,z=pos.z}).name
				if n ~= "air" and n ~= "ignore" then
					ground_y = y
					break
				end
			end
			if not ground_y then return end
			pos = {x=pos.x, y=ground_y, z=pos.z}
			local spos = {x=pos.x, y=ground_y+10, z=pos.z}
	
		  
		  	if get_snow(pos) then
		  		if animate then
			  		local minp = addvectors(spos, {x=-9, y=3, z=-9})
					local maxp = addvectors(spos, {x= 9, y=5, z= 9})
			  		local vel = {x=0, y=   -1, z=-1}
					local acc = {x=0, y=   0, z=0}
		 		 	minetest.add_particlespawner(3, 0.5,
							minp, maxp,
							vel, vel,
							acc, acc,
							5, 5,
							50, 50,
					false, "weather_snow.png", player:get_player_name())
				end
				snow.place(pos, true)
				--minetest.place_node({x=pos.x, y=pos.y+2, z=pos.z}, {name="default:snow"}) -- LazyJ
			end
	end

	-- Snow
	minetest.register_globalstep(function(dtime)
		for _, player in ipairs(minetest.get_connected_players()) do
			local ppos = player:getpos()
			
			local sminp = addvectors(ppos, {x=-20, y=0, z=-20})
			local smaxp = addvectors(ppos, {x= 20, y=0, z= 20})
		
			-- Make sure player is not in a cave/house...
			if get_snow(ppos) and minetest.env:get_node_light(ppos, 0.5) == 15 then

				local minp = addvectors(ppos, {x=-9, y=3, z=-9})
				local maxp = addvectors(ppos, {x= 9, y=5, z= 9})

				local minp_deep = addvectors(ppos, {x=-5, y=3.2, z=-5})
				local maxp_deep = addvectors(ppos, {x= 5, y=1.6, z= 5})

				local vel = {x=0, y=   -1, z=-1}
				local acc = {x=0, y=   0, z=0}
				
				if not snow.lighter_snowfall then
					minetest.add_particlespawner(5, 0.5,
						minp, maxp,
						vel, vel,
						acc, acc,
						5, 5,
						25, 25,
						false, "weather_snow.png", player:get_player_name())

					minetest.add_particlespawner(4, 0.5,
						minp_deep, maxp_deep,
						vel, vel,
						acc, acc,
						4, 4,
						25, 25,
						false, "weather_snow.png", player:get_player_name())
						
					if math.random(1,5) == 4 then	
						snow_fall(randpos(sminp, smaxp), player)
					end
				else
					if math.random(1,5) == 4 then	
						snow_fall(randpos(sminp, smaxp), player, true)
					end
				end
					
				
			else
			
				if math.random(1,5) == 4 then	
					snow_fall(randpos(sminp, smaxp), player, true)
				end
			end
		end
	end)
	
end
