-- NODES


minetest.register_node("seacoral:coralcyan", {
	description = "Cyan Coral",
	drawtype = "plantlike",
	tiles = {"seacoral_coralcyan.png"},
	inventory_image = "seacoral_coralcyan.png",
	wield_image = "seacoral_coralcyan.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.3, -0.3, 0.3, 0.3, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seacoral=1, sea=1,basecolor_cyan=1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seacoral:coralmagenta", {
	description = "Magenta Coral",
	drawtype = "plantlike",
	tiles = {"seacoral_coralmagenta.png"},
	inventory_image = "seacoral_coralmagenta.png",
	wield_image = "seacoral_coralmagenta.png",
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
	groups = {snappy=3, seacoral=1, sea=1,basecolor_magenta=1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seacoral:coralaqua", {
	description = "Aqua Coral",
	drawtype = "plantlike",
	tiles = {"seacoral_coralaqua.png"},
	inventory_image = "seacoral_coralaqua.png",
	wield_image = "seacoral_coralaqua.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.3, -0.3, 0.3, 0.3, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seacoral=1, sea=1,excolor_aqua=1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seacoral:corallime", {
	description = "Lime Coral",
	drawtype = "plantlike",
	tiles = {"seacoral_corallime.png"},
	inventory_image = "seacoral_corallime.png",
	wield_image = "seacoral_corallime.png",
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
	groups = {snappy=3, seacoral=1, sea=1,excolor_lime=1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seacoral:coralskyblue", {
	description = "Skyblue Coral",
	drawtype = "plantlike",
	tiles = {"seacoral_coralskyblue.png"},
	inventory_image = "seacoral_coralskyblue.png",
	wield_image = "seacoral_coralskyblue.png",
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
	groups = {snappy=3, seacoral=1, sea=1,excolor_skyblue=1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seacoral:coralredviolet", {
	description = "Redviolet Coral",
	drawtype = "plantlike",
	tiles = {"seacoral_coralredviolet.png"},
	inventory_image = "seacoral_coralredviolet.png",
	wield_image = "seacoral_coralredviolet.png",
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
	groups = {snappy=3, seacoral=1, sea=1,excolor_redviolet=1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seacoral:seacoralsandcyan", {
	description = "Sea coral sand cyan",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("seacoral:seacoraldirtcyan", {
	description = "Sea coral dirt cyan",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seacoral:seacoralsandmagenta", {
	description = "Sea coral sand magenta",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("seacoral:seacoraldirtmagenta", {
	description = "Sea coral dirt magenta",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seacoral:seacoralsandaqua", {
	description = "Sea coral sand aqua",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("seacoral:seacoraldirtaqua", {
	description = "Sea coral dirt aqua",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seacoral:seacoralsandlime", {
	description = "Sea coral sand lime",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("seacoral:seacoraldirtlime", {
	description = "Sea coral dirt lime",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seacoral:seacoralsandskyblue", {
	description = "Sea coral sand skyblue",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("seacoral:seacoraldirtskyblue", {
	description = "Sea coral dirt skyblue",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("seacoral:seacoralsandredviolet", {
	description = "Sea coral sand redviolet",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	drop = 'default:sand',
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("seacoral:seacoraldirtredviolet", {
	description = "Sea coral dirt redviolet",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults(),
})


-- CRAFTING


if( minetest.get_modpath( "colormachine") == nil ) then
	register_seacoral_craft = function(output,recipe)
    	minetest.register_craft({
        type = 'shapeless',
        output = output,
        recipe = recipe,
	})
	end

register_seacoral_craft('dye:cyan 4', {'seacoral:coralcyan'})
register_seacoral_craft('dye:magenta 4', {'seacoral:coralmagenta'})
register_seacoral_craft('dye:lime 4', {'seacoral:corallime'})
register_seacoral_craft('dye:aqua 4', {'seacoral:coralaqua'})
register_seacoral_craft('dye:skyblue 4', {'seacoral:coralskyblue'})
register_seacoral_craft('dye:redviolet 4', {'seacoral:coralredviolet'})
end

-- SEACORAL SAND AND DIRT GENERATION


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoralsandcyan",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -4,
	height_min     = -8,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoraldirtcyan",
	wherein        = "default:dirt",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -4,
	height_min     = -8,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoralsandmagenta",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -4,
	height_min     = -8,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoraldirtmagenta",
	wherein        = "default:dirt",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -4,
	height_min     = -8,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoralsandaqua",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -4,
	height_min     = -8,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoraldirtaqua",
	wherein        = "default:dirt",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -4,
	height_min     = -8,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoralsandlime",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -4,
	height_min     = -8,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoraldirtlime",
	wherein        = "default:dirt",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -4,
	height_min     = -8,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoralsandskyblue",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -4,
	height_min     = -8,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoraldirtskyblue",
	wherein        = "default:dirt",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -4,
	height_min     = -8,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoralsandredviolet",
	wherein        = "default:sand",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -4,
	height_min     = -8,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "seacoral:seacoraldirtredviolet",
	wherein        = "default:dirt",
	clust_scarcity = 10*10*10,
	clust_num_ores = 24,
	clust_size     = 4,
	height_max     = -4,
	height_min     = -8,
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
nodenames = {"seacoral:seacoraldirtcyan"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seacoral:coralcyan"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seacoral:seacoralsandcyan"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seacoral:coralcyan"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seacoral:seacoraldirtmagenta"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seacoral:coralmagenta"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seacoral:seacoralsandmagenta"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seacoral:coralmagenta"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seacoral:seacoraldirtaqua"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seacoral:coralaqua"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seacoral:seacoralsandaqua"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seacoral:coralaqua"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seacoral:seacoraldirtlime"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seacoral:corallime"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seacoral:seacoralsandlime"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seacoral:corallime"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seacoral:seacoraldirtskyblue"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seacoral:coralskyblue"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seacoral:seacoralsandskyblue"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seacoral:coralskyblue"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seacoral:seacoraldirtredviolet"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seacoral:coralredviolet"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"seacoral:seacoralsandredviolet"},
interval = 12,
chance = 12,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	if (minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") then
		pos.y = pos.y + 1
		minetest.add_node(pos, {name = "seacoral:coralredviolet"}) else
		return
	end
end
})

minetest.register_abm({
nodenames = {"group:seacoral"},
interval = 3,
chance = 1,
action = function(pos, node, active_object_count, active_object_count_wider)
	local yp = {x = pos.x, y = pos.y + 1, z = pos.z}
	local yyp = {x = pos.x, y = pos.y + 2, z = pos.z}
	if ((minetest.get_node(yp).name == "default:water_source" or
	minetest.get_node(yp).name == "noairblocks:water_sourcex") and
	(minetest.get_node(yyp).name == "default:water_source" or
	minetest.get_node(yyp).name == "noairblocks:water_sourcex")) then
		local objs = minetest.env:get_objects_inside_radius(pos, 2)
		for k, obj in pairs(objs) do
			obj:set_hp(obj:get_hp()+ 1)
		end
	else
	return
	end
end
})


-- OPTIONAL DEPENDENCY


if( minetest.get_modpath( "colormachine") ~= nil ) then
	colormachine.basic_dye_sources  = { "flowers:rose", "flowers:tulip", "flowers:dandelion_yellow", "seacoral:corallime", "default:cactus", "seacoral:coralaqua", "seacoral:coralcyan", "seacoral:coralskyblue", "flowers:geranium", "flowers:viola", "seacoral:coralmagenta", "seacoral:coralredviolet", "default:stone", "", "", "", "default:coal_lump" };
	else
	return
end


-- ALIASES


minetest.register_alias("seadye:cyan","dye:cyan")
minetest.register_alias("seadye:magenta","dye:magenta")
minetest.register_alias("seadye:lime","dye:lime")
minetest.register_alias("seadye:aqua","dye:aqua")
minetest.register_alias("seadye:skyblue","dye:skyblue")
minetest.register_alias("seadye:redviolet","dye:redviolet")