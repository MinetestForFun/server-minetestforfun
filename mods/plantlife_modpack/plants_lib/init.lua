-- Plantlife library mod by Vanessa Ezekowitz
--
-- License:  WTFPL
--
-- I got the temperature map idea from "hmmmm", values used for it came from
-- Splizard's snow mod.
--

-- Various settings - most of these probably won't need to be changed

plantslib = {}

plantslib.blocklist_aircheck = {}
plantslib.blocklist_no_aircheck = {}

plantslib.surface_nodes_aircheck = {}
plantslib.surface_nodes_no_aircheck = {}

plantslib.surfaceslist_aircheck = {}
plantslib.surfaceslist_no_aircheck = {}

plantslib.actioncount_aircheck = {}
plantslib.actioncount_no_aircheck = {}

plantslib.actionslist_aircheck = {}
plantslib.actionslist_no_aircheck = {}

plantslib.modpath = minetest.get_modpath("plants_lib")

plantslib.total_no_aircheck_calls = 0

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end
plantslib.intllib = S

local DEBUG = false --... except if you want to spam the console with debugging info :-)

function plantslib:dbg(msg)
	if DEBUG then
		print("[Plantlife] "..msg)
		minetest.log("verbose", "[Plantlife] "..msg)
	end
end

plantslib.plantlife_seed_diff = 329	-- needs to be global so other mods can see it

local perlin_octaves = 3
local perlin_persistence = 0.6
local perlin_scale = 100

local temperature_seeddiff = 112
local temperature_octaves = 3
local temperature_persistence = 0.5
local temperature_scale = 150

local humidity_seeddiff = 9130
local humidity_octaves = 3
local humidity_persistence = 0.5
local humidity_scale = 250

local time_scale = 1
local time_speed = tonumber(minetest.setting_get("time_speed"))

if time_speed and time_speed > 0 then
	time_scale = 72 / time_speed
end

--PerlinNoise(seed, octaves, persistence, scale)

plantslib.perlin_temperature = PerlinNoise(temperature_seeddiff, temperature_octaves, temperature_persistence, temperature_scale)
plantslib.perlin_humidity = PerlinNoise(humidity_seeddiff, humidity_octaves, humidity_persistence, humidity_scale)

-- Local functions

function plantslib:is_node_loaded(node_pos)
	local n = minetest.get_node_or_nil(node_pos)
	if (not n) or (n.name == "ignore") then
		return false
	end
	return true
end

function plantslib:set_defaults(biome)
	biome.seed_diff = biome.seed_diff or 0
	biome.min_elevation = biome.min_elevation or -31000
	biome.max_elevation = biome.max_elevation or 31000
	biome.temp_min = biome.temp_min or 1
	biome.temp_max = biome.temp_max or -1
	biome.humidity_min = biome.humidity_min or 1
	biome.humidity_max = biome.humidity_max or -1
	biome.plantlife_limit = biome.plantlife_limit or 0.1
	biome.near_nodes_vertical = biome.near_nodes_vertical or 1

-- specific to on-generate

	biome.neighbors = biome.neighbors or biome.surface
	biome.near_nodes_size = biome.near_nodes_size or 0
	biome.near_nodes_count = biome.near_nodes_count or 1
	biome.rarity = biome.rarity or 50
	biome.max_count = biome.max_count or 5
	if biome.check_air ~= false then biome.check_air = true end

-- specific to abm spawner
	biome.seed_diff = biome.seed_diff or 0
	biome.light_min = biome.light_min or 0
	biome.light_max = biome.light_max or 15
	biome.depth_max = biome.depth_max or 1
	biome.facedir = biome.facedir or 0
end

local function search_table(t, s)
	for i = 1, #t do
		if t[i] == s then return true end
	end
	return false
end

-- register the list of surfaces to spawn stuff on, filtering out all duplicates.
-- separate the items by air-checking or non-air-checking map eval methods

function plantslib:register_generate_plant(biomedef, nodes_or_function_or_model)

	-- if calling code passes an undefined node for a surface or 
	-- as a node to be spawned, don't register an action for it.

	if type(nodes_or_function_or_model) == "string"
	  and string.find(nodes_or_function_or_model, ":")
	  and not minetest.registered_nodes[nodes_or_function_or_model] then
		plantslib:dbg("Warning: Ignored registration for undefined spawn node: "..dump(nodes_or_function_or_model))
		return
	end

	if type(nodes_or_function_or_model) == "string"
	  and not string.find(nodes_or_function_or_model, ":") then
		plantslib:dbg("Warning: Registered function call using deprecated string method: "..dump(nodes_or_function_or_model))
	end

	if biomedef.check_air == false then 
		plantslib:dbg("Register no-air-check mapgen hook: "..dump(nodes_or_function_or_model))
		plantslib.actionslist_no_aircheck[#plantslib.actionslist_no_aircheck + 1] = { biomedef, nodes_or_function_or_model }
		local s = biomedef.surface
		if type(s) == "string" then
			if s and (string.find(s, "^group:") or minetest.registered_nodes[s]) then
				if not search_table(plantslib.surfaceslist_no_aircheck, s) then
					plantslib.surfaceslist_no_aircheck[#plantslib.surfaceslist_no_aircheck + 1] = s
				end
			else
				plantslib:dbg("Warning: Ignored no-air-check registration for undefined surface node: "..dump(s))
			end
		else
			for i = 1, #biomedef.surface do
				local s = biomedef.surface[i]
				if s and (string.find(s, "^group:") or minetest.registered_nodes[s]) then
					if not search_table(plantslib.surfaceslist_no_aircheck, s) then
						plantslib.surfaceslist_no_aircheck[#plantslib.surfaceslist_no_aircheck + 1] = s
					end
				else
					plantslib:dbg("Warning: Ignored no-air-check registration for undefined surface node: "..dump(s))
				end
			end
		end
	else
		plantslib:dbg("Register with-air-checking mapgen hook: "..dump(nodes_or_function_or_model))
		plantslib.actionslist_aircheck[#plantslib.actionslist_aircheck + 1] = { biomedef, nodes_or_function_or_model }
		local s = biomedef.surface
		if type(s) == "string" then
			if s and (string.find(s, "^group:") or minetest.registered_nodes[s]) then
				if not search_table(plantslib.surfaceslist_aircheck, s) then
					plantslib.surfaceslist_aircheck[#plantslib.surfaceslist_aircheck + 1] = s
				end
			else
				plantslib:dbg("Warning: Ignored with-air-checking registration for undefined surface node: "..dump(s))
			end
		else
			for i = 1, #biomedef.surface do
				local s = biomedef.surface[i]
				if s and (string.find(s, "^group:") or minetest.registered_nodes[s]) then
					if not search_table(plantslib.surfaceslist_aircheck, s) then
						plantslib.surfaceslist_aircheck[#plantslib.surfaceslist_aircheck + 1] = s
					end
				else
					plantslib:dbg("Warning: Ignored with-air-checking registration for undefined surface node: "..dump(s))
				end
			end
		end
	end
end

function plantslib:populate_surfaces(biome, nodes_or_function_or_model, snodes, checkair)

	plantslib:set_defaults(biome)

	-- filter stage 1 - find nodes from the supplied surfaces that are within the current biome.

	local in_biome_nodes = {}
	local perlin_fertile_area = minetest.get_perlin(biome.seed_diff, perlin_octaves, perlin_persistence, perlin_scale)

	for i = 1, #snodes do
		local pos = snodes[i]
		local p_top = { x = pos.x, y = pos.y + 1, z = pos.z }
		local noise1 = perlin_fertile_area:get2d({x=pos.x, y=pos.z})
		local noise2 = plantslib.perlin_temperature:get2d({x=pos.x, y=pos.z})
		local noise3 = plantslib.perlin_humidity:get2d({x=pos.x+150, y=pos.z+50})
		local biome_surfaces_string = dump(biome.surface)
		local surface_ok = false

		if not biome.depth then
			local dest_node = minetest.get_node(pos)
			if string.find(biome_surfaces_string, dest_node.name) then
				surface_ok = true
			else
				if string.find(biome_surfaces_string, "group:") then
					for j = 1, #biome.surface do
						if string.find(biome.surface[j], "^group:") 
						  and minetest.get_item_group(dest_node.name, biome.surface[j]) then
							surface_ok = true
							break
						end
					end
				end
			end
		elseif not string.find(biome_surfaces_string, minetest.get_node({ x = pos.x, y = pos.y-biome.depth-1, z = pos.z }).name) then
			surface_ok = true
		end

		if surface_ok
		  and (not checkair or minetest.get_node(p_top).name == "air")
		  and pos.y >= biome.min_elevation
		  and pos.y <= biome.max_elevation
		  and noise1 > biome.plantlife_limit
		  and noise2 <= biome.temp_min
		  and noise2 >= biome.temp_max
		  and noise3 <= biome.humidity_min
		  and noise3 >= biome.humidity_max
		  and (not biome.ncount or #(minetest.find_nodes_in_area({x=pos.x-1, y=pos.y, z=pos.z-1}, {x=pos.x+1, y=pos.y, z=pos.z+1}, biome.neighbors)) > biome.ncount)
		  and (not biome.near_nodes or #(minetest.find_nodes_in_area({x=pos.x-biome.near_nodes_size, y=pos.y-biome.near_nodes_vertical, z=pos.z-biome.near_nodes_size}, {x=pos.x+biome.near_nodes_size, y=pos.y+biome.near_nodes_vertical, z=pos.z+biome.near_nodes_size}, biome.near_nodes)) >= biome.near_nodes_count)
		  and math.random(1,100) > biome.rarity
		  and (not biome.below_nodes or string.find(dump(biome.below_nodes), minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name) )
		  then
			in_biome_nodes[#in_biome_nodes + 1] = pos
		end
	end

	-- filter stage 2 - find places within that biome area to place the plants.

	local num_in_biome_nodes = #in_biome_nodes

	if num_in_biome_nodes > 0 then
		for i = 1, math.min(biome.max_count, num_in_biome_nodes) do
			local tries = 0
			local spawned = false
			while tries < 2 and not spawned do
				local pos = in_biome_nodes[math.random(1, num_in_biome_nodes)]
				if biome.spawn_replace_node then
					pos.y = pos.y-1
				end
				local p_top = { x = pos.x, y = pos.y + 1, z = pos.z }

				if not (biome.avoid_nodes and biome.avoid_radius and minetest.find_node_near(p_top, biome.avoid_radius + math.random(-1.5,2), biome.avoid_nodes)) then
					if biome.delete_above then
						minetest.remove_node(p_top)
						minetest.remove_node({x=p_top.x, y=p_top.y+1, z=p_top.z})
					end

					if biome.delete_above_surround then
						minetest.remove_node({x=p_top.x-1, y=p_top.y, z=p_top.z})
						minetest.remove_node({x=p_top.x+1, y=p_top.y, z=p_top.z})
						minetest.remove_node({x=p_top.x,   y=p_top.y, z=p_top.z-1})
						minetest.remove_node({x=p_top.x,   y=p_top.y, z=p_top.z+1})

						minetest.remove_node({x=p_top.x-1, y=p_top.y+1, z=p_top.z})
						minetest.remove_node({x=p_top.x+1, y=p_top.y+1, z=p_top.z})
						minetest.remove_node({x=p_top.x,   y=p_top.y+1, z=p_top.z-1})
						minetest.remove_node({x=p_top.x,   y=p_top.y+1, z=p_top.z+1})
					end

					if biome.spawn_replace_node then
						minetest.remove_node(pos)
					end

					local objtype = type(nodes_or_function_or_model)

					if objtype == "table" then
						if nodes_or_function_or_model.axiom then
							plantslib:generate_tree(pos, nodes_or_function_or_model)
							spawned = true
						else
							local fdir = nil
							if biome.random_facedir then
								fdir = math.random(biome.random_facedir[1], biome.random_facedir[2])
							end
							minetest.set_node(p_top, { name = nodes_or_function_or_model[math.random(#nodes_or_function_or_model)], param2 = fdir })
							spawned = true
						end
					elseif objtype == "string" and
					  minetest.registered_nodes[nodes_or_function_or_model] then
						local fdir = nil
						if biome.random_facedir then
							fdir = math.random(biome.random_facedir[1], biome.random_facedir[2])
						end
						minetest.set_node(p_top, { name = nodes_or_function_or_model, param2 = fdir })
						spawned = true
					elseif objtype == "function" then
						nodes_or_function_or_model(pos)
						spawned = true
					elseif objtype == "string" and pcall(loadstring(("return %s(...)"):
						format(nodes_or_function_or_model)),pos) then
						spawned = true
					else
						plantslib:dbg("Warning: Ignored invalid definition for object "..dump(nodes_or_function_or_model).." that was pointed at {"..dump(pos).."}")
					end
				else
					tries = tries + 1
				end
			end
		end
	end
end

-- Primary mapgen spawner, for mods that can work with air checking enabled on
-- a surface during the initial map read stage.

function plantslib:generate_block_with_air_checking(dtime)

	if #plantslib.blocklist_aircheck > 0 then

		local minp =		plantslib.blocklist_aircheck[1][1]
		local maxp =		plantslib.blocklist_aircheck[1][2]

		-- use the block hash as a unique key into the surface nodes
		-- tables, so that we can write the tables thread-safely.

		local blockhash =	minetest.hash_node_position(minp)

		if not plantslib.surface_nodes_aircheck.blockhash then

			local search_area = minetest.find_nodes_in_area(minp, maxp, plantslib.surfaceslist_aircheck)

			-- search the generated block for air-bounded surfaces

			plantslib.surface_nodes_aircheck.blockhash = {}

			for i = 1, #search_area do
			local pos = search_area[i]
				local p_top = { x=pos.x, y=pos.y+1, z=pos.z }
				if minetest.get_node(p_top).name == "air" then
					plantslib.surface_nodes_aircheck.blockhash[#plantslib.surface_nodes_aircheck.blockhash + 1] = pos
				end
			end
			plantslib.actioncount_aircheck.blockhash = 1

		else
			if plantslib.actioncount_aircheck.blockhash <= #plantslib.actionslist_aircheck then
				-- [1] is biome, [2] is node/function/model
				plantslib:populate_surfaces(
					plantslib.actionslist_aircheck[plantslib.actioncount_aircheck.blockhash][1],
					plantslib.actionslist_aircheck[plantslib.actioncount_aircheck.blockhash][2],
					plantslib.surface_nodes_aircheck.blockhash, true)
				plantslib.actioncount_aircheck.blockhash = plantslib.actioncount_aircheck.blockhash + 1
			else
				if plantslib.surface_nodes_aircheck.blockhash then
					table.remove(plantslib.blocklist_aircheck, 1)
					plantslib.surface_nodes_aircheck.blockhash = nil
				end
			end
		end
	end
end

-- Secondary mapgen spawner, for mods that require disabling of
-- checking for air during the initial map read stage.

function plantslib:generate_block_no_aircheck(dtime)

	if #plantslib.blocklist_no_aircheck > 0 then

		local minp =		plantslib.blocklist_no_aircheck[1][1]
		local maxp =		plantslib.blocklist_no_aircheck[1][2]

		local blockhash =	minetest.hash_node_position(minp)

		if not plantslib.surface_nodes_no_aircheck.blockhash then

			-- directly read the block to be searched into the chunk cache

			plantslib.surface_nodes_no_aircheck.blockhash =
				minetest.find_nodes_in_area(minp, maxp, plantslib.surfaceslist_no_aircheck)
			plantslib.actioncount_no_aircheck.blockhash = 1

		else
			if plantslib.actioncount_no_aircheck.blockhash <= #plantslib.actionslist_no_aircheck then
				plantslib:populate_surfaces(
					plantslib.actionslist_no_aircheck[plantslib.actioncount_no_aircheck.blockhash][1],
					plantslib.actionslist_no_aircheck[plantslib.actioncount_no_aircheck.blockhash][2],
					plantslib.surface_nodes_no_aircheck.blockhash, false)
				plantslib.actioncount_no_aircheck.blockhash = plantslib.actioncount_no_aircheck.blockhash + 1
			else
				if plantslib.surface_nodes_no_aircheck.blockhash then
					table.remove(plantslib.blocklist_no_aircheck, 1)
					plantslib.surface_nodes_no_aircheck.blockhash = nil
				end
			end
		end
	end
end

-- "Record" the chunks being generated by the core mapgen

minetest.register_on_generated(function(minp, maxp, blockseed)
	plantslib.blocklist_aircheck[#plantslib.blocklist_aircheck + 1] = { minp, maxp }
end)

minetest.register_on_generated(function(minp, maxp, blockseed)
	plantslib.blocklist_no_aircheck[#plantslib.blocklist_no_aircheck + 1] = { minp, maxp }
end)

-- "Play" them back, populating them with new stuff in the process

minetest.register_globalstep(function(dtime)
	plantslib:generate_block_with_air_checking(dtime)
end)

minetest.register_globalstep(function(dtime)
	plantslib:generate_block_no_aircheck(dtime)
end)

-- The spawning ABM

function plantslib:spawn_on_surfaces(sd,sp,sr,sc,ss,sa)

	local biome = {}

	if type(sd) ~= "table" then
		biome.spawn_delay = sd	-- old api expects ABM interval param here.
		biome.spawn_plants = {sp}
		biome.avoid_radius = sr
		biome.spawn_chance = sc
		biome.spawn_surfaces = {ss}
		biome.avoid_nodes = sa
	else
		biome = sd
	end

	if biome.spawn_delay*time_scale >= 1 then
		biome.interval = biome.spawn_delay*time_scale
	else
		biome.interval = 1
	end

	plantslib:set_defaults(biome)
	biome.spawn_plants_count = #(biome.spawn_plants)

	minetest.register_abm({
		nodenames = biome.spawn_surfaces,
		interval = biome.interval,
		chance = biome.spawn_chance,
		neighbors = biome.neighbors,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local p_top = { x = pos.x, y = pos.y + 1, z = pos.z }	
			local n_top = minetest.get_node(p_top)
			local perlin_fertile_area = minetest.get_perlin(biome.seed_diff, perlin_octaves, perlin_persistence, perlin_scale)
			local noise1 = perlin_fertile_area:get2d({x=p_top.x, y=p_top.z})
			local noise2 = plantslib.perlin_temperature:get2d({x=p_top.x, y=p_top.z})
			local noise3 = plantslib.perlin_humidity:get2d({x=p_top.x+150, y=p_top.z+50})
			if noise1 > biome.plantlife_limit 
			  and noise2 <= biome.temp_min
			  and noise2 >= biome.temp_max
			  and noise3 <= biome.humidity_min
			  and noise3 >= biome.humidity_max
			  and plantslib:is_node_loaded(p_top) then
				local n_light = minetest.get_node_light(p_top, nil)
				if not (biome.avoid_nodes and biome.avoid_radius and minetest.find_node_near(p_top, biome.avoid_radius + math.random(-1.5,2), biome.avoid_nodes))
				  and n_light >= biome.light_min
				  and n_light <= biome.light_max
				  and (not(biome.neighbors and biome.ncount) or #(minetest.find_nodes_in_area({x=pos.x-1, y=pos.y, z=pos.z-1}, {x=pos.x+1, y=pos.y, z=pos.z+1}, biome.neighbors)) > biome.ncount )
				  and (not(biome.near_nodes and biome.near_nodes_count and biome.near_nodes_size) or #(minetest.find_nodes_in_area({x=pos.x-biome.near_nodes_size, y=pos.y-biome.near_nodes_vertical, z=pos.z-biome.near_nodes_size}, {x=pos.x+biome.near_nodes_size, y=pos.y+biome.near_nodes_vertical, z=pos.z+biome.near_nodes_size}, biome.near_nodes)) >= biome.near_nodes_count)
				  and (not(biome.air_count and biome.air_size) or #(minetest.find_nodes_in_area({x=p_top.x-biome.air_size, y=p_top.y, z=p_top.z-biome.air_size}, {x=p_top.x+biome.air_size, y=p_top.y, z=p_top.z+biome.air_size}, "air")) >= biome.air_count)
				  and pos.y >= biome.min_elevation
				  and pos.y <= biome.max_elevation
				  then
					local walldir = plantslib:find_adjacent_wall(p_top, biome.verticals_list)
					if biome.alt_wallnode and walldir then
						if n_top.name == "air" then
							minetest.set_node(p_top, { name = biome.alt_wallnode, param2 = walldir })
						end
					else
						local currentsurface = minetest.get_node(pos).name
						if currentsurface ~= "default:water_source"
						  or (currentsurface == "default:water_source" and #(minetest.find_nodes_in_area({x=pos.x, y=pos.y-biome.depth_max-1, z=pos.z}, {x=pos.x, y=pos.y, z=pos.z}, {"default:dirt", "default:dirt_with_grass", "default:sand"})) > 0 )
						  then
							local rnd = math.random(1, biome.spawn_plants_count)
							local plant_to_spawn = biome.spawn_plants[rnd]
							local fdir = biome.facedir
							if biome.random_facedir then
								fdir = math.random(biome.random_facedir[1],biome.random_facedir[2])
							end
							if type(biome.spawn_plants) == "string" then
								assert(loadstring(biome.spawn_plants.."(...)"))(pos)
							elseif not biome.spawn_on_side and not biome.spawn_on_bottom and not biome.spawn_replace_node then
								if n_top.name == "air" then
									minetest.set_node(p_top, { name = plant_to_spawn, param2 = fdir })
								end
							elseif biome.spawn_replace_node then
								minetest.set_node(pos, { name = plant_to_spawn, param2 = fdir })

							elseif biome.spawn_on_side then
								local onside = plantslib:find_open_side(pos)
								if onside then 
									minetest.set_node(onside.newpos, { name = plant_to_spawn, param2 = onside.facedir })
								end
							elseif biome.spawn_on_bottom then
								if minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "air" then
									minetest.set_node({x=pos.x, y=pos.y-1, z=pos.z}, { name = plant_to_spawn, param2 = fdir} )
								end
							end
						end
					end
				end
			end
		end
	})
end

-- The growing ABM

function plantslib:grow_plants(opts)

	local options = opts

	options.height_limit = options.height_limit or 5
	options.ground_nodes = options.ground_nodes or { "default:dirt_with_grass" }
	options.grow_nodes = options.grow_nodes or { "default:dirt_with_grass" }
	options.seed_diff = options.seed_diff or 0

	if options.grow_delay*time_scale >= 1 then
		options.interval = options.grow_delay*time_scale
	else
		options.interval = 1
	end

	minetest.register_abm({
		nodenames = { options.grow_plant },
		interval = options.interval,
		chance = options.grow_chance,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local p_top = {x=pos.x, y=pos.y+1, z=pos.z}
			local p_bot = {x=pos.x, y=pos.y-1, z=pos.z}
			local n_top = minetest.get_node(p_top)
			local n_bot = minetest.get_node(p_bot)
			local root_node = minetest.get_node({x=pos.x, y=pos.y-options.height_limit, z=pos.z})
			local walldir = nil
			if options.need_wall and options.verticals_list then
				walldir = plantslib:find_adjacent_wall(p_top, options.verticals_list)
			end
			if n_top.name == "air" and (not options.need_wall or (options.need_wall and walldir))
			  then
				-- corner case for changing short junglegrass
				-- to dry shrub in desert
				if n_bot.name == options.dry_early_node and options.grow_plant == "junglegrass:short" then
					minetest.set_node(pos, { name = "default:dry_shrub" })

				elseif options.grow_vertically and walldir then
					if plantslib:search_downward(pos, options.height_limit, options.ground_nodes) then
						minetest.set_node(p_top, { name = options.grow_plant, param2 = walldir})
					end

				elseif not options.grow_result and not options.grow_function then
					minetest.remove_node(pos)

				else
					plantslib:replace_object(pos, options.grow_result, options.grow_function, options.facedir, options.seed_diff)
				end
			end
		end
	})
end

-- Function to decide how to replace a plant - either grow it, replace it with
-- a tree, run a function, or die with an error.

function plantslib:replace_object(pos, replacement, grow_function, walldir, seeddiff)
	local growtype = type(grow_function)
	if growtype == "table" then
		minetest.remove_node(pos)
		plantslib:grow_tree(pos, grow_function)
		return
	elseif growtype == "function" then
		local perlin_fertile_area = minetest.get_perlin(seeddiff, perlin_octaves, perlin_persistence, perlin_scale)
		local noise1 = perlin_fertile_area:get2d({x=pos.x, y=pos.z})
		local noise2 = plantslib.perlin_temperature:get2d({x=pos.x, y=pos.z})
		grow_function(pos,noise1,noise2,walldir)
		return
	elseif growtype == "string" then
		local perlin_fertile_area = minetest.get_perlin(seeddiff, perlin_octaves, perlin_persistence, perlin_scale)
		local noise1 = perlin_fertile_area:get2d({x=pos.x, y=pos.z})
		local noise2 = plantslib.perlin_temperature:get2d({x=pos.x, y=pos.z})
		assert(loadstring(grow_function.."(...)"))(pos,noise1,noise2,walldir)
		return
	elseif growtype == "nil" then
		minetest.set_node(pos, { name = replacement, param2 = walldir})
		return
	elseif growtype ~= "nil" and growtype ~= "string" and growtype ~= "table" then
		error("Invalid grow function "..dump(grow_function).." used on object at ("..dump(pos)..")")
	end
end

-- function to decide if a node has a wall that's in verticals_list{}
-- returns wall direction of valid node, or nil if invalid.

function plantslib:find_adjacent_wall(pos, verticals)
	local verts = dump(verticals)
	if string.find(verts, minetest.get_node({ x=pos.x-1, y=pos.y, z=pos.z   }).name) then return 3 end
	if string.find(verts, minetest.get_node({ x=pos.x+1, y=pos.y, z=pos.z   }).name) then return 2 end
	if string.find(verts, minetest.get_node({ x=pos.x  , y=pos.y, z=pos.z-1 }).name) then return 5 end
	if string.find(verts, minetest.get_node({ x=pos.x  , y=pos.y, z=pos.z+1 }).name) then return 4 end
	return nil
end

-- Function to search downward from the given position, looking for the first
-- node that matches the ground table.  Returns the new position, or nil if
-- height limit is exceeded before finding it.

function plantslib:search_downward(pos, heightlimit, ground)
	for i = 0, heightlimit do
		if string.find(dump(ground), minetest.get_node({x=pos.x, y=pos.y-i, z = pos.z}).name) then
			return {x=pos.x, y=pos.y-i, z = pos.z}
		end
	end
	return false
end

function plantslib:find_open_side(pos)
	if minetest.get_node({ x=pos.x-1, y=pos.y, z=pos.z }).name == "air" then
		return {newpos = { x=pos.x-1, y=pos.y, z=pos.z }, facedir = 2}
	end
	if minetest.get_node({ x=pos.x+1, y=pos.y, z=pos.z }).name == "air" then
		return {newpos = { x=pos.x+1, y=pos.y, z=pos.z }, facedir = 3}
	end
	if minetest.get_node({ x=pos.x, y=pos.y, z=pos.z-1 }).name == "air" then
		return {newpos = { x=pos.x, y=pos.y, z=pos.z-1 }, facedir = 4}
	end
	if minetest.get_node({ x=pos.x, y=pos.y, z=pos.z+1 }).name == "air" then
		return {newpos = { x=pos.x, y=pos.y, z=pos.z+1 }, facedir = 5}
	end
	return nil
end

-- spawn_tree() on generate is routed through here so that other mods can hook
-- into it.

function plantslib:generate_tree(pos, nodes_or_function_or_model)
	minetest.spawn_tree(pos, nodes_or_function_or_model)
end

-- and this one's for the call used in the growing code

function plantslib:grow_tree(pos, nodes_or_function_or_model)
	minetest.spawn_tree(pos, nodes_or_function_or_model)
end

-- Check for infinite stacks

if minetest.get_modpath("unified_inventory") or not minetest.setting_getbool("creative_mode") then
	plantslib.expect_infinite_stacks = false
else
	plantslib.expect_infinite_stacks = true
end

-- read a field from a node's definition

function plantslib:get_nodedef_field(nodename, fieldname)
	if not minetest.registered_nodes[nodename] then
		return nil
	end
	return minetest.registered_nodes[nodename][fieldname]
end

print("[Plants Lib] Loaded")

minetest.after(0, function()
	print("[Plants Lib] Registered a total of "..(#plantslib.surfaceslist_aircheck)+(#plantslib.surfaceslist_no_aircheck).." surface types to be evaluated, spread")
	print("[Plants Lib] across "..#plantslib.actionslist_aircheck.." actions with air-checking and "..#plantslib.actionslist_no_aircheck.." actions without.")
end)

