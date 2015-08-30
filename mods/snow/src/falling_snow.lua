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

-- copied from meru mod
local SEEDDIFF3 = 9130 -- 9130 -- Values should match minetest mapgen desert perlin.
local OCTAVES3 = 3 -- 3
local PERSISTENCE3 = 0.5 -- 0.5
local SCALE3 = 250 -- 250

--Get snow at position.
local function get_snow(pos)
	--Legacy support.
	if weather_legacy == "snow" then
		local perlin1 = minetest.get_perlin(112,3, 0.5, 150)
		if perlin1:get2d({x=pos.x, y=pos.z}) <= 0.53 then
			return false
		end

		-- disable falling snow in desert
		local desert_perlin = minetest.get_perlin(SEEDDIFF3, OCTAVES3, PERSISTENCE3, SCALE3)
		local noise3 = desert_perlin:get2d({x=pos.x+150,y=pos.z+50}) -- Offsets must match minetest mapgen desert perlin.
		if noise3 > 0.35 then -- Smooth transition 0.35 to 0.45.
			return false
		end
		return true
	end
	return false
end

local addvectors = vector and vector.add

--Returns a random position between minp and maxp.
local function randpos(minp, maxp)
	local x,z
	if minp.x > maxp.x then
		x = math.random(maxp.x,minp.x)
	else
		x = math.random(minp.x,maxp.x)
	end
	if minp.z > maxp.z then
		z = math.random(maxp.z,minp.z)
	else
		z = math.random(minp.z,maxp.z)
	end
	return {x=x,y=minp.y,z=z}
end

local default_snow_particle = {
	amount = 3,
	time = 0.5,
	exptime = 5,
	size = 50,
	collisiondetection = false,
	vertical = false,
}

local function get_snow_particledef(data)
	for n,i in pairs(default_snow_particle) do
		data[n] = data[n] or i
	end
	for _,i in pairs({"vel", "acc", "exptime", "size"}) do
		data["min"..i] = data[i]
		data["max"..i] = data[i]
	end
	data.texture = "weather_snow.png^[transform"..math.random(0,7)
	return data
end

local function snow_fall(pos, player, animate)
	local ground_y = nil
	for y=pos.y+10,pos.y+20,1 do
		local n = minetest.get_node({x=pos.x,y=y,z=pos.z}).name
		if n ~= "air" and n ~= "ignore" then
			return
		end
	end
	for y=pos.y+10,pos.y-15,-1 do
		local n = minetest.get_node({x=pos.x,y=y,z=pos.z}).name
		if n ~= "air" and n ~= "ignore" then
			ground_y = y
			break
		end
	end
	if not ground_y then
		return
	end

	pos = {x=pos.x, y=ground_y, z=pos.z}

  	if get_snow(pos) then
  		if animate then
			local spos = {x=pos.x, y=ground_y+10, z=pos.z}
			minetest.add_particlespawner(get_snow_particledef({
				minpos = addvectors(spos, {x=-9, y=3, z=-9}),
				maxpos = addvectors(spos, {x= 9, y=5, z= 9}),
				vel = {x=0, y=-1, z=-1},
				acc = {x=0, y=0, z=0},
				playername = player:get_player_name()
			}))
		end
		snow.place(pos, true)
		--minetest.place_node({x=pos.x, y=pos.y+2, z=pos.z}, {name="default:snow"}) -- LazyJ
	end
end

-- Snow
local function calc_snowfall()
	for _, player in pairs(minetest.get_connected_players()) do
		local ppos = player:getpos()

		-- Make sure player is not in a cave/house...
		if get_snow(ppos)
		and minetest.get_node_light(ppos, 0.5) == 15 then
			local animate
			if not snow.lighter_snowfall then
				local vel = {x=0, y=-1, z=-1}
				local acc = {x=0, y=0, z=0}
				minetest.add_particlespawner(get_snow_particledef({
					amount = 5,
					minpos = addvectors(ppos, {x=-9, y=3, z=-9}),
					maxpos = addvectors(ppos, {x= 9, y=5, z= 9}),
					vel = vel,
					acc = acc,
					size = 25,
					playername = player:get_player_name()
				}))

				minetest.add_particlespawner(get_snow_particledef({
					amount = 4,
					minpos = addvectors(ppos, {x=-5, y=3.2, z=-5}),
					maxpos = addvectors(ppos, {x= 5, y=1.6, z= 5}),
					vel = vel,
					acc = acc,
					exptime = 4,
					size = 25,
					playername = player:get_player_name()
				}))

				animate = false
			else
				animate = true
			end

			if math.random(1,5) == 4 then
				snow_fall(
					randpos(
						addvectors(ppos, {x=-20, y=0, z=-20}),
						addvectors(ppos, {x= 20, y=0, z= 20})
					),
					player,
					animate
				)
			end
		end
	end
end

minetest.register_globalstep(function(dtime)
	if snow.enable_snowfall then
		calc_snowfall()
	end
end)
