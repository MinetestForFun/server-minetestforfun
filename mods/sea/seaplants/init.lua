-- NODES

minetest.register_node("seaplants:kelpgreen", {
	description = "Green Kelp",
	drawtype = "plantlike",
	tiles = {"seaplants_kelpgreen.png"},
	inventory_image = "seaplants_kelpgreen.png",
	wield_image = "seaplants_kelpgreen.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seaplants=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(1)
})

minetest.register_node("seaplants:kelpgreenmiddle", {
	description = "Green Kelp middle",
	drawtype = "plantlike",
	tiles = {"seaplants_kelpgreenmiddle.png"},
	inventory_image = "seaplants_kelpgreenmiddle.png",
	wield_image = "seaplants_kelpgreenmiddle.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seaplants=1, sea=1},
	drop = "seaplants:kelpgreen",
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("seaplants:kelpbrown", {
	description = "Brown Kelp ",
	drawtype = "plantlike",
	tiles = {"seaplants_kelpbrown.png"},
	inventory_image = "seaplants_kelpbrown.png",
	wield_image = "seaplants_kelpbrown.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seaplants=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(1)
})

minetest.register_node("seaplants:kelpbrownmiddle", {
	description = "Brown Kelp middle",
	drawtype = "plantlike",
	tiles = {"seaplants_kelpbrownmiddle.png"},
	inventory_image = "seaplants_kelpbrownmiddle.png",
	wield_image = "seaplants_kelpbrownmiddle.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seaplants=1, sea=1},
	drop = "seaplants:kelpbrown",
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("seaplants:seagrassgreen", {
	description = "Green Seagrass",
	drawtype = "plantlike",
	tiles = {"seaplants_seagrassgreen.png"},
	inventory_image = "seaplants_seagrassgreen.png",
	wield_image = "seaplants_seagrassgreen.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seaplants=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(1)
})

minetest.register_node("seaplants:seagrassred", {
	description = "Red Seagrass",
	drawtype = "plantlike",
	tiles = {"seaplants_seagrassred.png"},
	inventory_image = "seaplants_seagrassred.png",
	wield_image = "seaplants_seagrassred.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seaplants=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(1)
})

minetest.register_node("seaplants:seaplantssandkelpgreen", {
	description = "Sea plants sand kelp green",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("seaplants:seaplantsdirtkelpgreen", {
	description = "Sea plants dirt kelp green",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seaplants:seaplantssandkelpbrown", {
	description = "Sea plants sand kelp brown",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("seaplants:seaplantsdirtkelpbrown", {
	description = "Sea plants dirt kelp brown",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seaplants:seaplantssandseagrassgreen", {
	description = "Sea plants sand seagrass green",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("seaplants:seaplantsdirtseagrassgreen", {
	description = "Sea plants dirt seagrass green",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seaplants:seaplantssandseagrassred", {
	description = "Sea plants sand seagrass red",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("seaplants:seaplantsdirtseagrassred", {
	description = "Sea plants dirt seagrass red",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults(),
})


-- CRAFT ITEMS


minetest.register_craftitem("seaplants:seasaladmix", {
	description = "Sea salad mix",
	inventory_image = "seaplants_seasaladmix.png",
	on_use = minetest.item_eat(6)
})


-- CRAFTING

minetest.register_craft({
	type = "shapeless",
	output = "seaplants:seasaladmix",
	recipe = {"seaplants:kelpgreen", "seaplants:kelpbrown", "seaplants:seagrassgreen", "seaplants:seagrassred"}
})


-- SEAPLANTS SAND AND DIRT GENERATION


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seaplants:seaplantssandkelpgreen",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -14,
	height_min     = -31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seaplants:seaplantsdirtkelpgreen",
	wherein        = "default:dirt",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -14,
	height_min     = -31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seaplants:seaplantssandkelpbrown",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -14,
	height_min     = -31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seaplants:seaplantsdirtkelpbrown",
	wherein        = "default:dirt",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -14,
	height_min     = -31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seaplants:seaplantssandseagrassgreen",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -14,
	height_min     = -31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seaplants:seaplantsdirtseagrassgreen",
	wherein        = "default:dirt",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -14,
	height_min     = -31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seaplants:seaplantssandseagrassred",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -14,
	height_min     = -31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seaplants:seaplantsdirtseagrassred",
	wherein        = "default:dirt",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -14,
	height_min     = -31000,
})

local function generate_ore(name, wherein, minp, maxp, seed, chunks_per_volume, chunk_size, ore_per_chunk, height_min, height_max)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	if chunk_size >= y_max - y_min + 1 then
		return
	end
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / ore_per_chunk)
	for i=1,num_chunks do
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= height_min and y0 <= height_max then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			local p0 = {x=x0, y=y0, z=z0}
			for x1=0,chunk_size-1 do
			for y1=0,chunk_size-1 do
			for z1=0,chunk_size-1 do
				if pr:next(1,inverse_chance) == 1 then
					local x2 = x0+x1
					local y2 = y0+y1
					local z2 = z0+z1
					local p2 = {x=x2, y=y2, z=z2}
					if minetest.get_node(p2).name == wherein then
						minetest.set_node(p2, {name=name})
					end
				end
			end
			end
			end
		end
	end
end


-- ABM'S


minetest.register_abm({
nodenames = {"seaplants:seaplantsdirtkelpgreen"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seaplants:kelpgreen"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seaplants:seaplantssandkelpgreen"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seaplants:kelpgreen"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seaplants:kelpgreen"},
interval = 6,
chance = 3,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	local yyp = {x = pos.x, y = pos.y + 2, z = pos.z}
	local yyyp = {x = pos.x, y = pos.y + 3, z = pos.z}
	if minetest.get_node(pos).name == "seaplants:kelpgreen" and
		(minetest.get_node(yp).name == "default:water_source" or
		minetest.get_node(yp).name == "noairblocks:water_sourcex") then
			if (minetest.get_node(yyp).name == "default:water_source" or
			minetest.get_node(yyp).name == "noairblocks:water_sourcex") then
				if (minetest.get_node(yyyp).name == "default:water_source" or
				minetest.get_node(yyyp).name == "noairblocks:water_sourcex") then
					minetest.add_node(pos, {name = "seaplants:kelpgreenmiddle"}) 
					pos.y = pos.y + 1
					minetest.add_node(pos, {name = "seaplants:kelpgreen"}) 
				else
				return
			end
		end
	end
end
})

minetest.register_abm({
nodenames = {"seaplants:seaplantsdirtkelpbrown"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seaplants:kelpbrown"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seaplants:seaplantssandkelpbrown"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seaplants:kelpbrown"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seaplants:kelpbrown"},
interval = 6,
chance = 3,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	local yyp = {x = pos.x, y = pos.y + 2, z = pos.z}
	local yyyp = {x = pos.x, y = pos.y + 3, z = pos.z}
	if minetest.get_node(pos).name == "seaplants:kelpbrown" and
		(minetest.get_node(yp).name == "default:water_source" or
		minetest.get_node(yp).name == "noairblocks:water_sourcex") then
			if (minetest.get_node(yyp).name == "default:water_source" or
			minetest.get_node(yyp).name == "noairblocks:water_sourcex") then
				if (minetest.get_node(yyyp).name == "default:water_source" or
				minetest.get_node(yyyp).name == "noairblocks:water_sourcex") then
					minetest.add_node(pos, {name = "seaplants:kelpbrownmiddle"}) 
					pos.y = pos.y + 1
					minetest.add_node(pos, {name = "seaplants:kelpbrown"}) 
				else
				return
			end
		end
	end
end
})

minetest.register_abm({
nodenames = {"seaplants:seaplantsdirtseagrassgreen"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seaplants:seagrassgreen"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seaplants:seaplantssandseagrassgreen"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seaplants:seagrassgreen"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seaplants:seaplantsdirtseagrassred"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seaplants:seagrassred"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seaplants:seaplantssandseagrassred"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seaplants:seagrassred"}) else
		return
	end
end
})


-- ALIASES


minetest.register_alias("seaplants:stemsgreen","default:sand")
minetest.register_alias("seaplants:stemsbrown","default:dirt")
minetest.register_alias("seaplants:leafyblue","default:sand")
minetest.register_alias("seaplants:leafygreen","default:dirt")

minetest.register_alias("seaplants:chewstickgreen","seaplants:kelpgreen")
minetest.register_alias("seaplants:chewstickbrown","seaplants:kelpbrown")
minetest.register_alias("seaplants:leavysnackgreen","seaplants:seagrassgreen")
minetest.register_alias("seaplants:leavysnackblue","seaplants:seagrassred")
minetest.register_alias("seaplants:seasalad","seaplants:seasaladmix")