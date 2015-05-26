-- This file supplies the various kinds of pneumatic tubes

local tubenodes = {}
pipeworks.tubenodes = tubenodes

minetest.register_alias("pipeworks:tube", "pipeworks:tube_000000")

-- now, a function to define the tubes

local REGISTER_COMPATIBILITY = true

local vti = {4, 3, 2, 1, 6, 5}

local default_noctrs = { "pipeworks_tube_noctr.png" }
local default_plain = { "pipeworks_tube_plain.png" }
local default_ends = { "pipeworks_tube_end.png" }

local texture_mt = {
	__index = function(table, key)
		local size, idx = #table, tonumber(key)
		if size > 0 then -- avoid endless loops with empty tables
			while idx > size do idx = idx - size end
			return table[idx]
		end
	end
}

local register_one_tube = function(name, tname, dropname, desc, plain, noctrs, ends, short, inv, special, connects, style)
	noctrs = noctrs or default_noctrs
	setmetatable(noctrs, texture_mt)
	plain = plain or default_plain
	setmetatable(plain, texture_mt)
	ends = ends or default_ends
	setmetatable(ends, texture_mt)
	short = short or "pipeworks_tube_short.png"
	inv = inv or "pipeworks_tube_inv.png"

	local outboxes = {}
	local outsel = {}
	local outimgs = {}
	
	for i = 1, 6 do
		outimgs[vti[i]] = plain[i]
	end
	
	for _, v in ipairs(connects) do
		table.extend(outboxes, pipeworks.tube_boxes[v])
		table.insert(outsel, pipeworks.tube_selectboxes[v])
		outimgs[vti[v]] = noctrs[v]
	end

	if #connects == 1 then
		local v = connects[1]
		v = v-1 + 2*(v%2) -- Opposite side
		outimgs[vti[v]] = ends[v]
	end

	local tgroups = {snappy = 3, tube = 1, tubedevice = 1, not_in_creative_inventory = 1}
	local tubedesc = string.format("%s %s... You hacker, you.", desc, dump(connects))
	local iimg = plain[1]
	local wscale = {x = 1, y = 1, z = 1}

	if #connects == 0 then
		tgroups = {snappy = 3, tube = 1, tubedevice = 1}
		tubedesc = desc
		iimg=inv
		outimgs = {
			short, short,
			ends[3],ends[4],
			short, short
		}
		outboxes = { -24/64, -9/64, -9/64, 24/64, 9/64, 9/64 }
		outsel = { -24/64, -10/64, -10/64, 24/64, 10/64, 10/64 }
		wscale = {x = 1, y = 1, z = 0.01}
	end
	
	local rname = string.format("%s_%s", name, tname)
	table.insert(tubenodes, rname)
	
	local nodedef = {
		description = tubedesc,
		drawtype = "nodebox",
		tiles = outimgs,
		sunlight_propagates = true,
		inventory_image = iimg,
		wield_image = iimg,
		wield_scale = wscale,
		paramtype = "light",
		selection_box = {
			type = "fixed",
			fixed = outsel
		},
		node_box = {
			type = "fixed",
			fixed = outboxes
		},
		groups = tgroups,
		sounds = default.node_sound_wood_defaults(),
		walkable = true,
		stack_max = 99,
		basename = name,
		style = style,
		drop = string.format("%s_%s", name, dropname),
		tubelike = 1,
		tube = {
			connect_sides = {front = 1, back = 1, left = 1, right = 1, top = 1, bottom = 1},
			priority = 50
		},
		after_place_node = pipeworks.after_place,
		after_dig_node = pipeworks.after_dig
	}
	if style == "6d" then
		nodedef.paramtype2 = "facedir"
	end
	
	if special == nil then special = {} end

	for key, value in pairs(special) do
		--if key == "after_dig_node" or key == "after_place_node" then
		--	nodedef[key.."_"] = value
		if key == "groups" then
			for group, val in pairs(value) do
				nodedef.groups[group] = val
			end
		elseif key == "tube" then
			for key, val in pairs(value) do
				nodedef.tube[key] = val
			end
		else
			nodedef[key] = table.recursive_replace(value, "#id", tname)
		end
	end

	minetest.register_node(rname, nodedef)
end

local register_all_tubes = function(name, desc, plain, noctrs, ends, short, inv, special, old_registration)
	if old_registration then
		for xm = 0, 1 do
		for xp = 0, 1 do
		for ym = 0, 1 do
		for yp = 0, 1 do
		for zm = 0, 1 do
		for zp = 0, 1 do
			local connects = {}
			if xm == 1 then
				connects[#connects+1] = 1
			end
			if xp == 1 then
				connects[#connects+1] = 2
			end
			if ym == 1 then
				connects[#connects+1] = 3
			end
			if yp == 1 then
				connects[#connects+1] = 4
			end
			if zm == 1 then
				connects[#connects+1] = 5
			end
			if zp == 1 then
				connects[#connects+1] = 6
			end
			local tname = xm..xp..ym..yp..zm..zp
			register_one_tube(name, tname, "000000", desc, plain, noctrs, ends, short, inv, special, connects, "old")
		end
		end
		end
		end
		end
		end
	else
		-- 6d tubes: uses only 10 nodes instead of 64, but the textures must be rotated
		local cconnects = {{}, {1}, {1, 2}, {1, 3}, {1, 3, 5}, {1, 2, 3}, {1, 2, 3, 5}, {1, 2, 3, 4}, {1, 2, 3, 4, 5}, {1, 2, 3, 4, 5, 6}}
		for index, connects in ipairs(cconnects) do
			register_one_tube(name, tostring(index), "1", desc, plain, noctrs, ends, short, inv, special, connects, "6d")
		end
		if REGISTER_COMPATIBILITY then
			local cname = name.."_compatibility"
			minetest.register_node(cname, {
				drawtype = "airlike",
				style = "6d",
				basename = name,
				inventory_image = inv,
				wield_image = inv,
				paramtype = "light",
				sunlight_propagates = true,
				description = "Pneumatic tube segment (legacy)",
				after_place_node = pipeworks.after_place,
				groups = {not_in_creative_inventory = 1, tube_to_update = 1, tube = 1},
				tube = {connect_sides = {front = 1, back = 1, left = 1, right = 1, top = 1, bottom = 1}},
				drop = name.."_1",
			})
			table.insert(tubenodes, cname)
			for xm = 0, 1 do
			for xp = 0, 1 do
			for ym = 0, 1 do
			for yp = 0, 1 do
			for zm = 0, 1 do
			for zp = 0, 1 do
				local tname = xm..xp..ym..yp..zm..zp
				minetest.register_alias(name.."_"..tname, cname)
			end
			end
			end
			end
			end
			end
		end
	end
end

pipeworks.register_tube = function(name, def, ...)
	if type(def) == "table" then
		register_all_tubes(name, def.description,
				def.plain, def.noctr, def.ends, def.short,
				def.inventory_image, def.node_def, def.no_facedir)
	else
		-- we assert to be the old function with the second parameter being the description
		-- function(name, desc, plain, noctrs, ends, short, inv, special, old_registration)
		assert(type(def) == "string", "invalid arguments to pipeworks.register_tube")
		register_all_tubes(name, def, ...)
	end
end


if REGISTER_COMPATIBILITY then
	minetest.register_abm({
		nodenames = {"group:tube_to_update"},
		interval = 1,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local minp = vector.subtract(pos, 1)
			local maxp = vector.add(pos, 1)
			if table.getn(minetest.find_nodes_in_area(minp, maxp, "ignore")) == 0 then
				pipeworks.scan_for_tube_objects(pos)
			end
		end
	})
end
