-- Date palms.
--
-- Date palms grow in hot and dry desert, but they require water. This makes them
-- a bit harder to find. If found in the middle of the desert, their presence
-- indicates a water source below the surface.
--
-- As an additional feature (which can be disabled), dates automatically regrow after
-- harvesting (provided a male tree is sufficiently nearby).
-- If regrowing is enabled, then ripe dates will not hang forever. Most will disappear
-- (e.g. eaten by birds, ...), and a small fraction will drop as items.

-- © 2016, Rogier <rogier777@gmail.com>
-- License: WTFPL

local S = moretrees.intllib

-- Some constants

local dates_drop_ichance = 4
local stems_drop_ichance = 4
local flowers_wither_ichance = 3

-- implementation

local dates_regrow_prob
if moretrees.dates_regrow_unpollinated_percent <= 0 then
	dates_regrow_prob = 0
elseif moretrees.dates_regrow_unpollinated_percent >= 100 then
	dates_regrow_prob = 1
else
	dates_regrow_prob = 1 - math.pow(moretrees.dates_regrow_unpollinated_percent/100, 1/flowers_wither_ichance)
end

-- Make the date palm fruit trunk a real trunk (it is generated as a fruit)
local trunk = minetest.registered_nodes["moretrees:date_palm_trunk"]
local ftrunk = {}
local fftrunk = {}
local mftrunk = {}
for k,v in pairs(trunk) do
	ftrunk[k] = v
end
ftrunk.tiles = {}
for k,v in pairs(trunk.tiles) do
	ftrunk.tiles[k] = v
end
ftrunk.drop = "moretrees:date_palm_trunk"
ftrunk.after_destruct = function(pos, oldnode)
	local dates = minetest.find_nodes_in_area({x=pos.x-2, y=pos.y, z=pos.z-2}, {x=pos.x+2, y=pos.y, z=pos.z+2}, {"group:moretrees_dates"})
	for _,datespos in pairs(dates) do
		-- minetest.dig_node(datespos) does not cause nearby dates to be dropped :-( ...
		local items = minetest.get_node_drops(minetest.get_node(datespos).name)
		minetest.remove_node(datespos)
		for _, itemname in pairs(items) do
			minetest.add_item(datespos, itemname)
		end
	end
end
for k,v in pairs(ftrunk) do
	mftrunk[k] = v
	fftrunk[k] = v
end
fftrunk.tiles = {}
mftrunk.tiles = {}
for k,v in pairs(trunk.tiles) do
	fftrunk.tiles[k] = v
	mftrunk.tiles[k] = v
end
-- Make the different types of trunk distinguishable (but not too easily)
ftrunk.tiles[1] = "moretrees_date_palm_trunk_top.png^[transformR180"
ftrunk.description = ftrunk.description.." (gen)"
fftrunk.tiles[1] = "moretrees_date_palm_trunk_top.png^[transformR90"
mftrunk.tiles[1] = "moretrees_date_palm_trunk_top.png^[transformR-90"
minetest.register_node("moretrees:date_palm_fruit_trunk", ftrunk)
minetest.register_node("moretrees:date_palm_ffruit_trunk", fftrunk)
minetest.register_node("moretrees:date_palm_mfruit_trunk", mftrunk)

-- ABM to grow new date blossoms
local date_regrow_abm_spec = {
	nodenames = { "moretrees:date_palm_ffruit_trunk", "moretrees:date_palm_mfruit_trunk" },
	interval = moretrees.dates_flower_interval,
	chance = moretrees.dates_flower_chance,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local dates = minetest.find_nodes_in_area({x=pos.x-2, y=pos.y, z=pos.z-2}, {x=pos.x+2, y=pos.y, z=pos.z+2}, "group:moretrees_dates")

		-- New blossom interval increases exponentially with number of dates already hanging
		-- In addition: if more dates are hanging, the chance of picking an empty spot decreases as well...
		if math.random(2^#dates) <= 2 then
			-- Grow in area of 5x5 round trunk; higher probability in 3x3 area close to trunk
			local dx=math.floor((math.random(50)-18)/16)
			local dz=math.floor((math.random(50)-18)/16)
			local datepos = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
			local datenode = minetest.get_node(datepos)
			if datenode.name == "air" then
				if node.name == "moretrees:date_palm_ffruit_trunk" then
					minetest.set_node(datepos, {name="moretrees:dates_f0"})
				else
					minetest.set_node(datepos, {name="moretrees:dates_m0"})
				end
			end
		end
	end
}
if moretrees.dates_regrow_pollinated or moretrees.dates_regrow_unpollinated_percent > 0 then
	minetest.register_abm(date_regrow_abm_spec)
end

-- Choose male or female palm, and spawn initial dates
-- (Instead of dates, a dates fruit trunk is generated with the tree. This
--  ABM converts the trunk to a female or male fruit trunk, and spawns some
--  hanging dates)
minetest.register_abm({
	nodenames = { "moretrees:date_palm_fruit_trunk" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local type
		if math.random(100) <= moretrees.dates_female_percent then
			type = "f"
			minetest.swap_node(pos, {name="moretrees:date_palm_ffruit_trunk"})
		else
			type = "m"
			minetest.swap_node(pos, {name="moretrees:date_palm_mfruit_trunk"})
		end
		local dates1 = minetest.find_nodes_in_area({x=pos.x-1, y=pos.y, z=pos.z-1}, {x=pos.x+1, y=pos.y, z=pos.z+1}, "air")
		local genpos
		for _,genpos in pairs(dates1) do
			if math.random(100) <= 20 then
				if type == "m" then
					minetest.set_node(genpos, {name = "moretrees:dates_n"})
				else
					minetest.set_node(genpos, {name = "moretrees:dates_f4"})
				end
			end
		end
		local dates2 = minetest.find_nodes_in_area({x=pos.x-2, y=pos.y, z=pos.z-2}, {x=pos.x+2, y=pos.y, z=pos.z+2}, "air")
		for _,genpos in pairs(dates2) do
			if math.random(100) <= 5 then
				if type == "m" then
					minetest.set_node(genpos, {name = "moretrees:dates_n"})
				else
					minetest.set_node(genpos, {name = "moretrees:dates_f4"})
				end
			end
		end
	end,
})

-- Dates growing functions.

-- This is a bit complex, as the purpose is to find male flowers at horizontal distances of over
-- 100 nodes. As searching such a large area is time consuming, this is optimized in four ways:
-- - The search result (the locations of male trees) is cached, so that it can be used again
-- - Only 1/9th of the desired area is searched at a time. A new search is only performed if no male
--   flowers are found in the previously searched parts.
-- - Search results are shared with other female palms nearby.
-- - If previous searches for male palms have consumed too much CPU time, the search is skipped
--   (This means no male palms will be found, and the pollination of the flowers affected will be
--   delayed. If this happens repeatedly, eventually, the female flowers will wither...)
-- A caching method was selected that is suited for the case where most date trees are long-lived,
-- and where the number of trees nearby is limited:
-- - Locations of male palms are stored as metadata for every female palm. This means that a player
--   visiting a remote area with some date palms will not cause extensive searches for male palms as
--   long overdue blossoming ABMs are triggered for every date palm.
-- - Even when male palms *are* cut down, a cache refill will only be performed if the cached results do not
--   contain a male palm with blossoms.
-- The method will probably perform suboptimally:
-- - If female palms are frequently chopped down and replanted.
--   Freshly grown palms will need to search for male palms again
--   (this is mitigated by the long blossoming interval, which increases the chance that search
--    results have already been shared)
-- - If an area contains a large number of male and female palms.
--   In this area, every female palm will have an almost identical list of male palm locations
--   as metadata.
-- - If all male palms within range of a number of female palms have been chopped down (with possibly
--   new ones planted). Although an attempt was made to share search results in this case as well,
--   a number of similar searches will unavoidably be performed by the different female palms.
-- - If no male palms are in range of a female palm. In that case, there will be frequent searches
--   for newly-grown male palms.

-- Search statistics - used to limit the search load.
local sect_search_stats = {}		-- Search statistics - server-wide
local function reset_sect_search_stats()
	sect_search_stats.count = 0		-- # of searches
	sect_search_stats.skip = 0		-- # of times skipped
	sect_search_stats.sum = 0		-- total time spent
	sect_search_stats.min = 999999999	-- min time spent
	sect_search_stats.max = 0		-- max time spent
end
reset_sect_search_stats()
sect_search_stats.last_us = 0			-- last time a search was done (microseconds, max: 2^32)
sect_search_stats.last_s = 0			-- last time a search was done (system time in seconds)

-- Find male trunks in one section (=1/9 th) of the searchable area.
-- sect is -4 to 4, where 0 is the center section
local function find_fruit_trunks_near(ftpos, sect)
	local r = moretrees.dates_pollination_distance + 2 * math.sqrt(2)
	local sect_hr = math.floor(r / 3 + 0.9999)
	local sect_vr = math.floor(r / 2 + 0.9999)
	local t0us = core.get_us_time()
	local t0s = os.time()

	-- Compute elapsed time since last search.
	-- Unfortunately, the time value wraps after about 71 minutes (2^32 microseconds),
	-- so it must be corrected to obtain the actual elapsed time.
	if t0us < sect_search_stats.last_us then
		-- Correct a simple wraparound.
		-- This is not sufficient, as the time value may have wrapped more than once...
		sect_search_stats.last_us = sect_search_stats.last_us - 2^32
	end
	if t0s - sect_search_stats.last_s > 2^32/1000000 then
		-- One additional correction is enough for our purposes.
		-- For exact results, more corrections may be needed though...
		-- (and even not applying this correction at all would still only yield
		--  a minimal risk of a non-serious miscalculation...)
		sect_search_stats.last_us = sect_search_stats.last_us - 2^32
	end

	-- Skip the search if it is consuming too much CPU time
	if sect_search_stats.count > 0 and moretrees.dates_blossom_search_iload > 0
			and sect_search_stats.sum / sect_search_stats.count > moretrees.dates_blossom_search_time_treshold
			and t0us - sect_search_stats.last_us < moretrees.dates_blossom_search_iload * (sect_search_stats.sum / sect_search_stats.count) then
		sect_search_stats.skip = sect_search_stats.skip + 1
		return nil
	end

	local basevec = { x = ftpos.x + 2 * sect.x * sect_hr,
			  y = ftpos.y,
			  z = ftpos.z + 2 * sect.z * sect_hr}
	-- find_nodes_in_area is limited to 82^3, make sure to not overrun it
	local sizevec = { x = sect_hr, y = sect_vr, z = sect_hr }
	if sect_hr * sect_hr * sect_vr > 41^3 then
		sizevec = vector.apply(sizevec, function(a) return math.min(a, 41) end)
	end

	local all_palms = minetest.find_nodes_in_area(
				vector.subtract(basevec, sizevec),
				vector.add(basevec, sizevec),
				{"moretrees:date_palm_mfruit_trunk", "moretrees:date_palm_ffruit_trunk"})

	-- Collect different palms in separate lists.
	local female_palms = {}
	local male_palms = {}
	local all_male_palms = {}
	for _, pos in pairs(all_palms) do
		if pos.x ~= ftpos.x or pos.y ~= ftpos.y or pos.z ~= ftpos.z then
			local node = minetest.get_node(pos)
			if node and node.name == "moretrees:date_palm_ffruit_trunk" then
				table.insert(female_palms,pos)
			elseif node then
				table.insert(all_male_palms,pos)
				-- In sector 0, all palms are of interest.
				-- In other sectors, forget about palms that are too far away.
				if sect == 0 then
					table.insert(male_palms,pos)
				else
					local ssq = 0
					for _, c in pairs({"x", "z"}) do
						local dc = pos[c] - ftpos[c]
						ssq = ssq + dc * dc
					end
					if math.sqrt(ssq) <= r then
						table.insert(male_palms,pos)
					end
				end
			end
		end
	end

	-- Update search statistics
	local t1us = core.get_us_time()
	if t1us < t0us then
		-- Wraparound. Assume the search lasted less than 2^32 microseconds (~71 min)
		-- (so no need to apply another correction)
		t0us = t0us - 2^32
	end
	sect_search_stats.last_us = t0us
	sect_search_stats.last_s = t0s
	sect_search_stats.count = sect_search_stats.count + 1
	sect_search_stats.sum = sect_search_stats.sum + t1us-t0us
	if t1us - t0us < sect_search_stats.min then
		sect_search_stats.min = t1us - t0us
	end
	if t1us - t0us > sect_search_stats.max then
		sect_search_stats.max = t1us - t0us
	end

	return male_palms, female_palms, all_male_palms
end

local function dates_print_search_stats(log)
	local stats
	if sect_search_stats.count > 0 then
		stats = string.format("Male date tree searching stats: searches: %d/%d:  average: %d µs  (%d..%d)",
			sect_search_stats.count, sect_search_stats.count + sect_search_stats.skip,
			sect_search_stats.sum/sect_search_stats.count, sect_search_stats.min, sect_search_stats.max)
	else
		stats = string.format("Male date tree searching stats: searches: 0/0:  average: (no searches yet)")
	end
	if log then
		minetest.log("action", "[moretrees] " .. stats)
	end
	return true, stats
end

minetest.register_chatcommand("dates_stats", {
	description = "Print male date palm search statistics",
	params = "|chat|log|reset",
	privs = { server = true },
	func = function(name, param)
		param = string.lower(string.trim(param))
		if param == "" or param == "chat" then
			return dates_print_search_stats(false)
		elseif param == "log" then
			return dates_print_search_stats(true)
		elseif param == "reset" then
			reset_sect_search_stats()
			return true
		else
			return false, "Invalid subcommand; expected: '' or 'chat' or 'log' or 'reset'"
		end
	end,
})

-- Find the female trunk near the female flowers to be pollinated
local function find_female_trunk(fbpos)
	local trunks = minetest.find_nodes_in_area({x=fbpos.x-2, y=fbpos.y, z=fbpos.z-2},
						{x=fbpos.x+2, y=fbpos.y, z=fbpos.z+2},
						"moretrees:date_palm_ffruit_trunk")
	local ftpos
	local d = 99
	for x, pos in pairs(trunks) do
		local ssq = 0
		for _, c in pairs({"x", "z"}) do
			local dc = pos[c] - fbpos[c]
			ssq = ssq + dc * dc
		end
		if math.sqrt(ssq) < d then
			ftpos = pos
			d = math.sqrt(ssq)
		end
	end
	return ftpos
end

-- Find male blossom near a male trunk,
-- the male blossom must be in range of a specific female blossom as well
local function find_male_blossom_near_trunk(fbpos, mtpos)
	local r = moretrees.dates_pollination_distance
	local blossoms = minetest.find_nodes_in_area({x=mtpos.x-2, y=mtpos.y, z=mtpos.z-2},
						{x=mtpos.x+2, y=mtpos.y, z=mtpos.z+2},
						"moretrees:dates_m0")
	for x, mbpos in pairs(blossoms) do
		local ssq = 0
		for _, c in pairs({"x", "z"}) do
			local dc = mbpos[c] - fbpos[c]
			ssq = ssq + dc * dc
		end
		if math.sqrt(ssq) <= r then
			return mbpos
		end
	end

end

-- Find a male blossom in range of a specific female blossom,
-- using a nested list of male blossom positions
local function find_male_blossom_in_mpalms(ftpos, fbpos, mpalms)
	-- Process the elements of mpalms.sect (index -4 .. 4) in random order
	-- First, compute the order in which the sectors will be searched
	local sect_index = {}
	local sect_rnd = {}
	for i = -4,4 do
		local n = math.random(1023)
		sect_index[n] =  i
		table.insert(sect_rnd, n)
	end
	table.sort(sect_rnd)

	-- Search the sectors
	local sect_old = 0
	local sect_time = minetest.get_gametime()
	for _, n in pairs(sect_rnd) do
		-- Record the oldest sector, so that it can be searched if no male
		-- blossoms were found
		if not mpalms.sect_time[sect_index[n]] then
			sect_old = sect_index[n]
			sect_time = 0
		elseif mpalms.sect_time[sect_index[n]] < sect_time then
			sect_old = sect_index[n]
			sect_time = mpalms.sect_time[sect_index[n]]
		end
		if mpalms.sect[sect_index[n]] and #mpalms.sect[sect_index[n]] then
			for px, mtpos in pairs(mpalms.sect[sect_index[n]]) do
				local node = minetest.get_node(mtpos)
				if node and node.name == "moretrees:date_palm_mfruit_trunk" then
					local mbpos = find_male_blossom_near_trunk(fbpos, mtpos)
					if mbpos then
						return mbpos
					end
				elseif node and node.name ~= "ignore" then
					-- no more male trunk here.
					mpalms.sect[sect_index[n]][px] = nil
				end
			end
		end
	end
	return nil, sect_old
end

-- Find a male blossom in range of a specific female blossom,
-- using the cache associated with the given female trunk
-- If necessary, recompute part of the cache
local last_search_result = {}
local function find_male_blossom_with_ftrunk(fbpos,ftpos)
	local meta = minetest.get_meta(ftpos)
	local mpalms
	local cache_changed = true

	-- Load cache. If distance has changed, start with empty cache instead.
	local mpalms_dist = meta:get_int("male_palms_dist")
	if mpalms_dist and mpalms_dist == moretrees.dates_pollination_distance then
		mpalms = meta:get_string("male_palms")
		if mpalms and mpalms ~= "" then
			mpalms = minetest.deserialize(mpalms)
			cache_changed = false
		end
	end
	if not mpalms or not mpalms.sect then
		mpalms = {}
		mpalms.sect = {}
		mpalms.sect_time = {}
		meta:set_int("male_palms_dist", moretrees.dates_pollination_distance)
		cache_changed = true
	end
	local fpalms_list
	local all_mpalms_list
	local sector0_searched = false

	-- Always make sure that sector 0 is cached
	if not mpalms.sect[0] then
		mpalms.sect[0], fpalms_list, all_mpalms_list = find_fruit_trunks_near(ftpos, {x = 0, z = 0})
		mpalms.sect_time[0] = minetest.get_gametime()
		sector0_searched = true
		cache_changed = true
		last_search_result.female = fpalms_list
		last_search_result.male = all_mpalms_list
	end

	-- Find male palms
	local mbpos, sect_old = find_male_blossom_in_mpalms(ftpos, fbpos, mpalms)

	-- If not found, (re)generate the cache for an additional sector. But don't search it yet (for performance reasons)
	-- (Use the globally cached results if possible)
	if not mbpos and not sector0_searched then
		if not mpalms.sect_time[0] or mpalms.sect_time[0] == 0 or math.random(3) == 1 then
			-- Higher probability of re-searching the center sector
			sect_old = 0
		end
		-- Use globally cached result if possible
		mpalms.sect[sect_old] = nil
		if sect_old == 0 and mpalms.sect_time[0] and mpalms.sect_time[0] > 0
				and last_search_result.male and #last_search_result.male then
			for _, pos in pairs(last_search_result.female) do
				if pos.x == ftpos.x and pos.y == ftpos.y and pos.z == ftpos.z then
					mpalms.sect[sect_old] = last_search_result.male
					-- Next time, don't use the cached result
					mpalms.sect_time[sect_old] = nil
					cache_changed = true
				end
			end
		end
		-- Else do a new search
		if not mpalms.sect[sect_old] then
			mpalms.sect[sect_old], fpalms_list, all_mpalms_list = find_fruit_trunks_near(ftpos, {x = (sect_old + 4) % 3 - 1, z = (sect_old + 4) / 3 - 1})
			cache_changed = true
			if sect_old == 0 then
				-- Save the results if it is sector 0
				-- (chance of reusing results from another sector are smaller)
				last_search_result.female = fpalms_list
				last_search_result.male = all_mpalms_list
			end
			if mpalms.sect[sect_old] then
				mpalms.sect_time[sect_old] = minetest.get_gametime()
			else
				mpalms.sect_time[sect_old] = nil
			end
		end
	end

	-- Share search results with other female trunks in the same area
	-- Note that the list of female trunks doesn't (shouldn't :-) contain the current female trunk.
	if fpalms_list and #fpalms_list and #all_mpalms_list then
		local all_mpalms = {}
		all_mpalms.sect = {}
		all_mpalms.sect_time = {}
		all_mpalms.sect[0] = all_mpalms_list
		-- Don't set sect_time[0], so that the cached sector will be re-searched soon (if necessary)
		local all_mpalms_serialized = minetest.serialize(all_mpalms)
		for _, pos in pairs(fpalms_list) do
			local fmeta = minetest.get_meta(pos)
			local fdist = fmeta:get_int("male_palms_dist")
			if not fdist or fdist ~= moretrees.dates_pollination_distance then
				fmeta:set_string("male_palms", all_mpalms_serialized)
				fmeta:set_int("male_palms_dist", moretrees.dates_pollination_distance)
			end
		end
	end

	-- Save cache.
	if cache_changed then
		meta:set_string("male_palms", minetest.serialize(mpalms))
	end

	return mbpos
end

-- Find a male blossom in range of a specific female blossom
local function find_male_blossom(fbpos)
	local ftpos = find_female_trunk(fbpos)
	if ftpos then
		return find_male_blossom_with_ftrunk(fbpos, ftpos)
	end
	return nil
end

-- Growing function for dates
local dates_growfn = function(pos, elapsed)
	local node = minetest.get_node(pos)
	local delay = moretrees.dates_grow_interval
	local r = moretrees.dates_pollination_distance
	local action
	if not node then
		return
	elseif not moretrees.dates_regrow_pollinated and dates_regrow_prob == 0 then
		-- Regrowing of dates is disabled.
		if string.find(node.name, "moretrees:dates_f") then
			minetest.swap_node(pos, {name="moretrees:dates_f4"})
		elseif string.find(node.name, "moretrees:dates_m") then
			minetest.swap_node(pos, {name="moretrees:dates_n"})
		else
			minetest.remove_node(pos)
		end
		return
	elseif node.name == "moretrees:dates_f0" and math.random(100) <= 100 * dates_regrow_prob then
		-- Dates grow unpollinated
		minetest.swap_node(pos, {name="moretrees:dates_f1"})
		action = "nopollinate"
	elseif node.name == "moretrees:dates_f0" and moretrees.dates_regrow_pollinated and find_male_blossom(pos) then
		-- Pollinate flowers
		minetest.swap_node(pos, {name="moretrees:dates_f1"})
		action = "pollinate"
	elseif string.match(node.name, "0$") then
		-- Make female unpollinated and male flowers last a bit longer
		if math.random(flowers_wither_ichance) == 1 then
			if node.name == "moretrees:dates_f0" then
				minetest.swap_node(pos, {name="moretrees:dates_fn"})
			else
				minetest.swap_node(pos, {name="moretrees:dates_n"})
			end
			action = "wither"
		else
			action = "nowither"
		end
	elseif node.name == "moretrees:dates_f4" then
		-- Remove dates, and optionally drop them as items
		if math.random(dates_drop_ichance) == 1 then
			if moretrees.dates_item_drop_ichance > 0 and math.random(moretrees.dates_item_drop_ichance) == 1 then
				local items = minetest.get_node_drops(minetest.get_node(pos).name)
				for _, itemname in pairs(items) do
					minetest.add_item(pos, itemname)
				end
			end
			minetest.swap_node(pos, {name="moretrees:dates_n"})
			action = "drop"
		else
			action = "nodrop"
		end
	elseif string.match(node.name, "n$") then
		-- Remove stems.
		if math.random(stems_drop_ichance) == 1 then
			minetest.remove_node(pos)
			return "stemdrop"
		end
		action = "nostemdrop"
	else
		-- Grow dates
		local offset = 18
		local n = string.sub(node.name, offset)
		minetest.swap_node(pos, {name=string.sub(node.name, 1, offset-1)..n+1})
		action = "grow"
	end
	-- Don't catch up when elapsed time is large. Regular visits are needed for growth...
	local timer = minetest.get_node_timer(pos)
	timer:start(delay + math.random(moretrees.dates_grow_interval))
	return action
end

-- Alternate growth function for dates.
-- It calls the primary growth function, but also measures CPU time consumed.
-- Use this function to analyze date growing performance.
local stat = {}
stat.count = 0
local dates_growfn_profiling = function(pos, elapsed)
	local t0 = core.get_us_time()
	local action = dates_growfn(pos, elapsed)
	local t1 = core.get_us_time()
	if t1 < t0 then
		t1 = t1 + 2^32
	end
	stat.count = stat.count + 1
	if not stat[action] then
		stat[action] = {}
		stat[action].count = 0
		stat[action].sum = 0
		stat[action].min = 9999999999
		stat[action].max = 0
	end
	stat[action].count = stat[action].count + 1
	stat[action].sum = stat[action].sum + t1-t0
	if t1-t0 < stat[action].min then
		stat[action].min = t1-t0
	end
	if t1-t0 > stat[action].max then
		stat[action].max = t1-t0
	end

	if stat.count % 10 == 0 then
		io.write(".")
		io.flush()
	end
	if stat.count % 100 == 0 then
		print(string.format("Date grow statistics %5d:", stat.count))
		local sum = 0
		local count = 0
		if sect_search_stats.count > 0 and stat.pollinate and stat.pollinate.count > 0 then
			print(string.format("\t%-12s: %6d (%4.1f%%): %6dus (%d..%d)",
				"search", sect_search_stats.count,
				100*sect_search_stats.count/stat.pollinate.count,
				sect_search_stats.sum/sect_search_stats.count,
				sect_search_stats.min, sect_search_stats.max))
		else
			print(string.format("\t%-12s: %6d (%4.1f%%): %6dus (%d..%d)",
				"search", sect_search_stats.count,
				0, 0, 0, 0))
		end
		for action,data in pairs(stat) do
			if action ~= "count" then
				count = count + data.count
				sum = sum + data.sum
				print(string.format("\t%-12s: %6d (%4.1f%%): %6dus (%d..%d)",
					action, data.count,
					100*data.count/stat.count, data.sum/data.count,
					data.min, data.max))
			end
		end
		print(string.format("\t%-12s: %6d ( 100%%): %6dus",
			"TOTAL", count, sum/count))
	end
end

-- Register dates

local dates_starttimer = function(pos, elapsed)
	local timer = minetest.get_node_timer(pos)
	local base_interval = moretrees.dates_grow_interval * 2 / 3
	timer:set(base_interval + math.random(base_interval), elapsed or 0)
end

local dates_drop = {
	items = {
		{items = { "moretrees:date" }},
		{items = { "moretrees:date" }},
		{items = { "moretrees:date" }},
		{items = { "moretrees:date" }},
		{items = { "moretrees:date" }, rarity = 2 },
		{items = { "moretrees:date" }, rarity = 2 },
		{items = { "moretrees:date" }, rarity = 2 },
		{items = { "moretrees:date" }, rarity = 2 },
		{items = { "moretrees:date" }, rarity = 5 },
		{items = { "moretrees:date" }, rarity = 5 },
		{items = { "moretrees:date" }, rarity = 5 },
		{items = { "moretrees:date" }, rarity = 5 },
		{items = { "moretrees:date" }, rarity = 20 },
		{items = { "moretrees:date" }, rarity = 20 },
		{items = { "moretrees:date" }, rarity = 20 },
		{items = { "moretrees:date" }, rarity = 20 },
	}
}

for _,suffix in ipairs({"f0", "f1", "f2", "f3", "f4", "m0", "fn", "n"}) do
	local name
	if suffix == "f0" or suffix == "m0" then
		name = S("Date Flowers")
	elseif suffix == "n" or suffix == "fn" then
		name = S("Date Stem")
	else
		name = S("Dates")
	end
	local dropfn = suffix == "f4" and dates_drop or ""
	local datedef = {
		description = name,
		tiles = {"moretrees_dates_"..suffix..".png"},
		visual_scale = 2,
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		groups = { fleshy=3, dig_immediate=3, flammable=2, moretrees_dates=1 },
		inventory_image = "moretrees_dates_"..suffix..".png^[transformR0",
		wield_image = "moretrees_dates_"..suffix..".png^[transformR90",
		sounds = default.node_sound_defaults(),
		drop = dropfn,
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.3, -0.3, 0.3, 3.5, 0.3}
		},
		on_timer = dates_growfn,
		on_construct = (moretrees.dates_regrow_pollinated or moretrees.dates_regrow_unpollinated_percent > 0)
				and dates_starttimer,

	}
	minetest.register_node("moretrees:dates_"..suffix, datedef)
end

-- If regrowing was previously disabled, but is enabled now, make sure timers are started for existing dates
if moretrees.dates_regrow_pollinated or moretrees.dates_regrow_unpollinated_percent > 0 then
	local spec = {
		name = "moretrees:restart_dates_regrow_timer",
		nodenames = "group:moretrees_dates",
		action = function(pos, node, active_object_count, active_object_count_wider)
			local timer = minetest.get_node_timer(pos)
			if not timer:is_started() then
				dates_starttimer(pos)
			else
				local timeout = timer:get_timeout()
				local elapsed = timer:get_elapsed()
				if timeout - elapsed > moretrees.dates_grow_interval * 4/3 then
					dates_starttimer(pos, math.random(moretrees.dates_grow_interval * 4/3))
				end
			end
		end,
	}
	if minetest.register_lbm then
		minetest.register_lbm(spec)
	else
		spec.interval = 3557
		spec.chance = 10
		minetest.register_abm(spec)
	end
end

