local S = moretrees.intllib

-- © 2016, Rogier <rogier777@gmail.com>

-- Some constants

local coconut_drop_ichance = 8

-- Make the cocos palm fruit trunk a real trunk (it is generated as a fruit)
local trunk = minetest.registered_nodes["moretrees:palm_trunk"]
local ftrunk = {}
local gftrunk = {}
for k,v in pairs(trunk) do
	ftrunk[k] = v
	gftrunk[k] = v
end
ftrunk.tiles = {}
gftrunk.tiles = {}
for k,v in pairs(trunk.tiles) do
	ftrunk.tiles[k] = v
	gftrunk.tiles[k] = v
end
ftrunk.drop = "moretrees:palm_trunk"
gftrunk.drop = "moretrees:palm_trunk"
ftrunk.after_destruct = function(pos, oldnode)
	local coconuts = minetest.find_nodes_in_area({x=pos.x-1, y=pos.y, z=pos.z-1}, {x=pos.x+1, y=pos.y, z=pos.z+1}, {"group:moretrees_coconut"})
	for _,coconutpos in pairs(coconuts) do
		-- minetest.dig_node(coconutpos) does not cause nearby coconuts to be dropped :-( ...
		--minetest.dig_node(coconutpos)
		local items = minetest.get_node_drops(minetest.get_node(coconutpos).name)
		minetest.remove_node(coconutpos)
		for _, itemname in pairs(items) do
			minetest.add_item(coconutpos, itemname)
		end
	end
end
-- Make the different trunk types distinguishable (but barely)
ftrunk.tiles[1] = "moretrees_palm_trunk_top.png^[transformR90"
gftrunk.tiles[1] = "moretrees_palm_trunk_top.png^[transformR180"
gftrunk.description = gftrunk.description.." (gen)"
minetest.register_node("moretrees:palm_fruit_trunk", ftrunk)
minetest.register_node("moretrees:palm_fruit_trunk_gen", gftrunk)

local coconut_regrow_abm_spec = {
	nodenames = { "moretrees:palm_fruit_trunk" },
	interval = moretrees.coconut_flower_interval,
	chance = moretrees.coconut_flower_chance,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local coconuts = minetest.find_nodes_in_area({x=pos.x-1, y=pos.y, z=pos.z-1}, {x=pos.x+1, y=pos.y, z=pos.z+1}, "group:moretrees_coconut")
		-- Expected growth interval increases exponentially with number of coconuts already hanging.
		-- Also: if more coconuts are hanging, the chance of picking an empty spot decreases as well...
		if math.random(2^#coconuts) <= 2 then
			-- Grow in area of 3x3 round trunk
			local dx=math.floor(math.random(3)-2)
			local dz=math.floor(math.random(3)-2)
			local coconutpos = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
			local coconutnode = minetest.get_node(coconutpos)
			if coconutnode.name == "air" then
				minetest.set_node(coconutpos, {name="moretrees:coconut_0"})
			end
		end
	end
}
if moretrees.coconuts_regrow then
	minetest.register_abm(coconut_regrow_abm_spec)
end

-- Spawn initial coconuts

-- Spawn initial coconuts
-- (Instead of coconuts, a generated-palm fruit trunk is generated with the tree. This
--  ABM converts the trunk to a regular fruit trunk, and spawns some coconuts)
minetest.register_abm({
	nodenames = { "moretrees:palm_fruit_trunk_gen" },
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.swap_node(pos, {name="moretrees:palm_fruit_trunk"})
		local poslist = minetest.find_nodes_in_area({x=pos.x-1, y=pos.y, z=pos.z-1}, {x=pos.x+1, y=pos.y, z=pos.z+1}, "air")
		local genlist = {}
		for k,v in pairs(poslist) do
			genlist[k] = {x = math.random(100), pos = v}
		end
		table.sort(genlist, function(a, b) return a.x < b.x; end)
		local gen
		local count = 0
		for _,gen in pairs(genlist) do
			minetest.set_node(gen.pos, {name = "moretrees:coconut_3"})
			count = count + 1
			if count == 4 then
				break
			end
		end
	end,
})

-- Register coconuts, and make them regrow

local coconut_growfn = function(pos, elapsed)
	local node = minetest.get_node(pos)
	local delay = moretrees.coconut_grow_interval
	if not node then
		return
	elseif not moretrees.coconuts_regrow then
		-- Regrowing has been turned off. Make coconust grow instantly
		minetest.swap_node(pos, {name="moretrees:coconut_3"})
		return
	elseif node.name == "moretrees:coconut_3" then
		-- Drop coconuts (i.e. remove them), so that new coconuts can grow.
		-- Coconuts will drop as items with a small chance
		if math.random(coconut_drop_ichance) == 1 then
			if moretrees.coconut_item_drop_ichance > 0 and math.random(moretrees.coconut_item_drop_ichance) == 1 then
				local items = minetest.get_node_drops(minetest.get_node(pos).name)
				for _, itemname in pairs(items) do
					minetest.add_item(pos, itemname)
				end
			end
			minetest.remove_node(pos)
		end
	else
		-- Grow coconuts to the next stage
		local offset = string.len("moretrees:coconut_x")
		local n = string.sub(node.name, offset)
		minetest.swap_node(pos, {name=string.sub(node.name, 1, offset-1)..n+1})
	end
	-- Don't catch up when elapsed time is large. Regular visits are needed for growth...
	local timer = minetest.get_node_timer(pos)
	timer:start(delay + math.random(moretrees.coconut_grow_interval))
end

local coconut_starttimer = function(pos, elapsed)
	local timer = minetest.get_node_timer(pos)
	local base_interval = moretrees.coconut_grow_interval * 2 / 3
	timer:set(base_interval + math.random(base_interval), elapsed or 0)
end

for _,suffix in ipairs({"_0", "_1", "_2", "_3", ""}) do
	local name
	if suffix == "_0" then
		name = S("Coconut Flower")
	else
		name = S("Coconut")
	end
	local drop = ""
	local coco_group = 1
	local tile = "moretrees_coconut"..suffix..".png"
	local timerfn = coconut_growfn
	local constructfn = coconut_starttimer
	if suffix == "_3" then
		drop = "moretrees:coconut"
		tile = "moretrees_coconut.png"
	elseif suffix == "" then
		drop = nil
		coco_group = nil
		timerfn = nil
		constructfn = nil
	end
	local coconutdef = {
		description = name,
		tiles = {tile},
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		groups = { fleshy=3, dig_immediate=3, flammable=2, moretrees_coconut=coco_group },
		inventory_image = tile.."^[transformR180",
		wield_image = tile.."^[transformR180",
		sounds = default.node_sound_defaults(),
		drop = drop,
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.3, -0.3, 0.3, 0.3, 0.3}
		},
		on_timer = timerfn,
		on_construct = constructfn,

	}
	minetest.register_node("moretrees:coconut"..suffix, coconutdef)
end

-- convert exisiting cocos palms. This is a bit tricky...
-- Try to make sure that this is indeed a generated tree, and not manually-placed trunks and/or coconuts
if moretrees.coconuts_convert_existing_palms then
	local spec = {
		name = "moretrees:convert_existing_cocos_palms_to_regrow_coconuts",
		nodenames = "moretrees:coconut",
		action = function(pos, node, active_object_count, active_object_count_wider)
			local trunks
			local cvtrunks
			local leaves
			local coconuts
			-- One regular trunk must be adjacent to  the coconut
			trunks = minetest.find_nodes_in_area({x=pos.x-1, y=pos.y, z=pos.z-1}, {x=pos.x+1, y=pos.y, z=pos.z+1}, "moretrees:palm_trunk")
			if #trunks ~= 1 then
				return
			end
			local tpos = trunks[1]
			-- 1 or 2 other trunks must be one level below to the trunk being converted.
			trunks = minetest.find_nodes_in_area({x=tpos.x-1, y=tpos.y-1, z=tpos.z-1}, {x=tpos.x+1, y=tpos.y-1, z=tpos.z+1}, "moretrees:palm_trunk")
			if #trunks < 1 or #trunks > 2 then
				return
			end
			-- 1 or 2 other trunks must be two levels below to the trunk being converted.
			trunks = minetest.find_nodes_in_area({x=tpos.x-1, y=tpos.y-2, z=tpos.z-1}, {x=tpos.x+1, y=tpos.y-2, z=tpos.z+1}, "moretrees:palm_trunk")
			if #trunks < 1 or #trunks > 2 then
				return
			end
			-- 1 or 2 trunks must at the level of the trunk being converted.
			cvtrunks = minetest.find_nodes_in_area({x=tpos.x-1, y=tpos.y, z=tpos.z-1}, {x=tpos.x+1, y=tpos.y, z=tpos.z+1}, "moretrees:palm_trunk")
			if #cvtrunks < 1 or #cvtrunks > 2 then
				return
			end
			-- No trunks may be one level above the trunk being converted.
			trunks = minetest.find_nodes_in_area({x=tpos.x-1, y=tpos.y+1, z=tpos.z-1}, {x=tpos.x+1, y=tpos.y+1, z=tpos.z+1}, "moretrees:palm_trunk")
			if #trunks ~= 0 then
				return
			end
			-- Leaves must be one level above the trunk being converted.
			leaves = minetest.find_nodes_in_area({x=tpos.x-1, y=tpos.y+1, z=tpos.z-1}, {x=tpos.x+1, y=tpos.y+1, z=tpos.z+1}, "moretrees:palm_leaves")
			if #leaves == 0 then
				return
			end
			-- Leaves must be two levels above the trunk being converted.
			leaves = minetest.find_nodes_in_area({x=tpos.x-1, y=tpos.y+2, z=tpos.z-1}, {x=tpos.x+1, y=tpos.y+2, z=tpos.z+1}, "moretrees:palm_leaves")
			if #leaves == 0 then
				return
			end
			-- No cocos fruit trunk may already be adjacent to the coconut
			trunks = minetest.find_nodes_in_area({x=pos.x-1, y=pos.y, z=pos.z-1}, {x=pos.x+1, y=pos.y, z=pos.z+1}, "moretrees:palm_fruit_trunk")
			if #trunks ~= 0 then
				return
			end
			-- No cocos fruit trunk may be adjacent to or below the trunk being converted.
			trunks = minetest.find_nodes_in_area({x=tpos.x-1, y=tpos.y-2, z=tpos.z-1}, {x=tpos.x+1, y=tpos.y, z=tpos.z+1}, "moretrees:palm_fruit_trunk")
			if #trunks ~= 0 then
				return
			end
			-- Convert trunk and all coconuts nearby. Maybe convert 2 trunks, just in case...
			for _, tpos in pairs(cvtrunks) do
				minetest.swap_node(tpos, {name = "moretrees:palm_fruit_trunk"})
				coconuts = minetest.find_nodes_in_area({x=tpos.x-1, y=tpos.y, z=tpos.z-1}, {x=tpos.x+1, y=tpos.y, z=tpos.z+1}, "moretrees:coconut")
				for _, coconutpos in pairs(coconuts) do
					minetest.set_node(coconutpos, {name = "moretrees:coconut_3"})
				end
			end
		end,
	}
	if minetest.register_lbm then
		minetest.register_lbm(spec)
	else
		spec.interval = 3691
		spec.chance = 10
		minetest.register_abm(spec)
	end
end

-- If regrowing was previously disabled, but is enabled now, make sure timers are started for existing coconuts
if moretrees.coconuts_regrow then
	local spec = {
		name = "moretrees:restart_coconut_regrow_timer",
		nodenames = "group:moretrees_coconut",
		action = function(pos, node, active_object_count, active_object_count_wider)
			local timer = minetest.get_node_timer(pos)
			if not timer:is_started() then
				coconut_starttimer(pos)
			else
				local timeout = timer:get_timeout()
				local elapsed = timer:get_elapsed()
				if timeout - elapsed > moretrees.coconut_grow_interval * 4/3 then
					coconut_starttimer(pos, math.random(moretrees.coconut_grow_interval * 4/3))
				end
			end
		end,
	}
	if minetest.register_lbm then
		minetest.register_lbm(spec)
	else
		spec.interval = 3659
		spec.chance = 10
		minetest.register_abm(spec)
	end
end

